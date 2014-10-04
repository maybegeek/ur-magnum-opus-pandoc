TEX          := $(patsubst %.md,%.md.latex.tex,$(wildcard *.ur.md))
TEXSTUD      := $(patsubst %.md,%.md.latex.stud.tex,$(wildcard *.ur.md))
TEXPLAIN     := $(patsubst %.md,%.md.latex.plain.tex,$(wildcard *.ur.md))
TEXSTUDPLAIN := $(patsubst %.md,%.md.latex.stud.plain.tex,$(wildcard *.ur.md))
TEXD         := $(patsubst %.md,%.md.latex.draft.tex,$(wildcard *.ur.md))
TEXSTUDD     := $(patsubst %.md,%.md.latex.stud.draft.tex,$(wildcard *.ur.md))
#CSL          := https://raw.githack.com/maybegeek/ur-magnum-opus-csl/master/ur-magnum-opus-zotero.csl
CSL          := Template/CSL/ur-magnum-opus-zotero.csl
ODT          := $(patsubst %.md,%.md.odt,$(wildcard *.ur.md))
HTM          := $(patsubst %.md,%.md.htm,$(wildcard *.ur.md))
PDFSLINUX    := $(wildcard *atex.pdf) $(wildcard *atex.stud.pdf) $(wildcard *atex.draft.pdf) $(wildcard *atex.stud.draft.pdf)
URGRID       := Template/HTML/gridic.css
URHTMCSS     := Template/HTML/html.css
URHTMINCB    := Template/HTML/gridic-before.txt
URHTMINCA    := Template/HTML/gridic-after.txt
URWEBFONT    := Template/HTML/webfont-eb-garamond-link.txt
O_DIR        := Output
TEX_O        := --output-directory=$(O_DIR)

define TEX_TMPL
 --standalone --latex-engine=xelatex \
	--no-tex-ligatures --number-sections \
	--biblio Quellen/Quellen.bib -Vlot -Vlof \
	--template=Template/ur-magnum-opus-pandoc.tex \
	Template/metadata.yaml --biblatex 
endef
define TEX_RM
Output/*.aux Output/*.bbl Output/*.bcf Output/*.blg Output/*.lof Output/*.log Output/*.lot Output/*.out Output/*.run.xml Output/*.toc
endef
export TEX_TMPL
export TEX_RM

all : $(TEX) $(TEXSTUD) $(TEXPLAIN) $(TEXSTUDPLAIN) $(TEXD) $(TEXSTUDD) $(ODT) $(HTM)

odt: $(ODT)
html : $(HTM)


# TEX (MD->LaTeX->BibLaTeX+Biber->PDF)
%.ur.md.latex.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	$< -o $(O_DIR)/$@
	@echo '* TEX (biblatex)'
	xelatex $(TEX_O) $@ && biber $(O_DIR)/$(wildcard *.ur.md).latex && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXSTUD (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
%.ur.md.latex.stud.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $(O_DIR)/$@
	@echo '* TEX (biblatex, stud)'
	xelatex $(TEX_O) $@ && biber $(O_DIR)/$(wildcard *.ur.md).latex.stud && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXPLAIN (MD->LaTeX->BibLaTeX+Biber->PDF)
# ohne Kolumnentitel
%.ur.md.latex.plain.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	$< -o $(O_DIR)/$@
	@echo '* TEX (biblatex)'
	xelatex $(TEX_O) $@ && biber $(O_DIR)/$(wildcard *.ur.md).latex.plain && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXSTUDPLAIN (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
# ohne Kolumnentitel
%.ur.md.latex.stud.plain.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $(O_DIR)/$@
	@echo '* TEX (biblatex, stud)'
	xelatex $(TEX_O) $@ && biber $(O_DIR)/$(wildcard *.ur.md).latex.stud.plain && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXD (MD->LaTeX->BibLaTeX+Biber->PDF)
# draft
%.ur.md.latex.draft.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	$< -o $(O_DIR)/$@
	@echo '* TEX (biblatex)'
	xelatex $(TEX_O) $@ && biber $(O_DIR)/$(wildcard *.ur.md).latex.draft && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXSTUDD (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
# draft
%.ur.md.latex.stud.draft.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $(O_DIR)/$@
	@echo '* TEX (biblatex, stud)'
	xelatex $(TEX_O) $@ && biber $(O_DIR)/$(wildcard *.ur.md).latex.stud.draft && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# ODT
%.ur.md.odt : %.ur.md
	@pandoc --smart --standalone --biblio Quellen/Quellen.bib --csl $(CSL) \
	$< -o $(O_DIR)/$@
	@echo '* neue ODT erstellt'


# HTML (for offline use)
%.ur.md.htm : %.ur.md
	@pandoc --smart --standalone --toc --number-sections -t html5 \
	--biblio Quellen/Quellen.bib --csl $(CSL) -c $(URGRID) -c $(URHTMCSS) \
	-H $(URWEBFONT) -B $(URHTMINCB) -A $(URHTMINCA) \
	-V lang='de' --self-contained \
	$< -o $(O_DIR)/$@
	@echo '* neue HTML (offline) erstellt'


rm-all : ;
	@-rm $(TEX) $(TEXSTUD) $(TEXSTUDPLAIN) $(TEXPLAIN) $(TEXD) $(TEXSTUDD) $(PDFSLINUX) $(ODT) $$TEX_RM
	@echo 'Alle unnötigen Output-Dateien gelöscht.'

rm-odt : ;
	@-rm $(O_DIR)/$(ODT)
	@echo '* alte ODT gelöscht'

rm-html : ;
	@-rm $(O_DIR)/$(HTM)
	@echo '* alte HTML (offline) gelöscht'

rebuild-all : rm-all all
rebuild-odt : rm-odt odt
rebuild-html : rm-html html
