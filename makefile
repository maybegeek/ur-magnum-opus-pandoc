TEX          := $(patsubst %.md,%.md.latex.tex,$(wildcard *.ur.md))
TEXSTUD      := $(patsubst %.md,%.md.latex.stud.tex,$(wildcard *.ur.md))
TEXPLAIN     := $(patsubst %.md,%.md.latex.plain.tex,$(wildcard *.ur.md))
TEXSTUDPLAIN := $(patsubst %.md,%.md.latex.stud.plain.tex,$(wildcard *.ur.md))
TEXD         := $(patsubst %.md,%.md.latex.draft.tex,$(wildcard *.ur.md))
TEXSTUDD     := $(patsubst %.md,%.md.latex.stud.draft.tex,$(wildcard *.ur.md))
PDFSLINUX    := $(wildcard *atex.pdf) $(wildcard *atex.stud.pdf) $(wildcard *atex.draft.pdf) $(wildcard *atex.stud.draft.pdf)

define TEX_TMPL
 --standalone --latex-engine=xelatex \
	--no-tex-ligatures --number-sections \
	--biblio Quellen/Quellen.bib -Vlot -Vlof \
	--template=Template/ur-magnum-opus-pandoc.tex \
	Template/metadata.yaml --biblatex 
endef

define TEX_RM
*.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc
endef

export TEX_TMPL
export TEX_RM

all : $(TEX) $(TEXSTUD) $(TEXPLAIN) $(TEXSTUDPLAIN) $(TEXD) $(TEXSTUDD)

# TEX (MD->LaTeX->BibLaTeX+Biber->PDF)
%.ur.md.latex.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	$< -o $@
	@echo '* TEX (biblatex)'
	xelatex $@ && biber $(wildcard *.ur.md).latex && xelatex $@ && xelatex $@ echo
	@-rm $$TEX_RM


# TEXSTUD (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
%.ur.md.latex.stud.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $@
	@echo '* TEX (biblatex, stud)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.stud && xelatex $@ && xelatex $@ echo
	@-rm $$TEX_RM


# TEXPLAIN (MD->LaTeX->BibLaTeX+Biber->PDF)
# ohne Kolumnentitel
%.ur.md.latex.plain.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	$< -o $@
	@echo '* TEX (biblatex)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.plain && xelatex $@ && xelatex $@ echo
	@-rm $$TEX_RM


# TEXSTUDPLAIN (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
# ohne Kolumnentitel
%.ur.md.latex.stud.plain.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $@
	@echo '* TEX (biblatex, stud)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.stud.plain && xelatex $@ && xelatex $@ echo
	@-rm $$TEX_RM


# TEXD (MD->LaTeX->BibLaTeX+Biber->PDF)
# draft
%.ur.md.latex.draft.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	$< -o $@
	@echo '* TEX (biblatex)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.draft && xelatex $@ && xelatex $@ echo
	@-rm $$TEX_RM


# TEXSTUDD (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
# draft
%.ur.md.latex.stud.draft.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $@
	@echo '* TEX (biblatex, stud)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.stud.draft && xelatex $@ && xelatex $@ echo
	@-rm $$TEX_RM


clean-all : ;
	@-rm $(TEX) $(TEXSTUD) $(TEXSTUDPLAIN) $(TEXPLAIN) $(TEXD) $(TEXSTUDD) $(PDFSLINUX) $$TEX_RM
	@echo 'Alle unnötigen Output-Dateien gelöscht.'

rebuild-all : clean-all all
