TEX          := $(patsubst %.md,%.md.latex.tex,$(wildcard *.ur.md))
TEXSTUD      := $(patsubst %.md,%.md.latex.stud.tex,$(wildcard *.ur.md))
TEXD         := $(patsubst %.md,%.md.latex.draft.tex,$(wildcard *.ur.md))
TEXSTUDD     := $(patsubst %.md,%.md.latex.stud.draft.tex,$(wildcard *.ur.md))
PDFSLINUX    := $(wildcard *atex.pdf) $(wildcard *atex.stud.pdf) $(wildcard *atex.draft.pdf) $(wildcard *atex.stud.draft.pdf)

all : $(TEX) $(TEXSTUD) $(TEXD) $(TEXSTUDD)

##
## TEX
## MD->LaTeX->BibLaTeX+Biber->PDF
##
%.ur.md.latex.tex : %.ur.md
	@pandoc \
	--standalone \
	--latex-engine=xelatex \
	--no-tex-ligatures \
	-Vlot \
	-Vlof \
	--number-sections \
	--biblio Quellen/Quellen.bib \
	--template=Template/MW-Template.tex \
	Template/yaml.yaml \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--biblatex \
	$< -o $@
	@echo '* TEX (biblatex)'
	xelatex $@ && biber $(wildcard *.ur.md).latex && xelatex $@ && xelatex $@ echo
	@-rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc

##
## TEXSTUD
## MD->LaTeX->BibLaTeX+Biber->PDF
## Studentenversion mit mehr Durchschuss
##
%.ur.md.latex.stud.tex : %.ur.md
	@pandoc \
	--standalone \
	--latex-engine=xelatex \
	--no-tex-ligatures \
	-Vlot \
	-Vlof \
	--number-sections \
	--biblio Quellen/Quellen.bib \
	--template=Template/MW-Template.tex \
	Template/yaml.yaml \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--biblatex \
	-V linestretch='1.7' \
	-V classoption='DIV=11' \
	$< -o $@
	@echo '* TEX (biblatex, stud)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.stud && xelatex $@ && xelatex $@ echo
	@-rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc

##
## TEXD
## MD->LaTeX->BibLaTeX+Biber->PDF
## draft
##
%.ur.md.latex.draft.tex : %.ur.md
	@pandoc \
	--standalone \
	--latex-engine=xelatex \
	--no-tex-ligatures \
	-Vlot \
	-Vlof \
	--number-sections \
	--biblio Quellen/Quellen.bib \
	--template=Template/MW-Template.tex \
	Template/yaml.yaml \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	--biblatex \
	$< -o $@
	@echo '* TEX (biblatex)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.draft && xelatex $@ && xelatex $@ echo
	@-rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc

##
## TEXSTUDD
## MD->LaTeX->BibLaTeX+Biber->PDF
## Studentenversion mit mehr Durchschuss
## draft
##
%.ur.md.latex.stud.draft.tex : %.ur.md
	@pandoc \
	--standalone \
	--latex-engine=xelatex \
	--no-tex-ligatures \
	-Vlot \
	-Vlof \
	--number-sections \
	--biblio Quellen/Quellen.bib \
	--template=Template/MW-Template.tex \
	Template/yaml.yaml \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	--biblatex \
	-V linestretch='1.7' \
	-V classoption='DIV=11' \
	$< -o $@
	@echo '* TEX (biblatex, stud)'
	xelatex $@ && biber $(wildcard *.ur.md).latex.stud.draft && xelatex $@ && xelatex $@ echo
	@-rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc


clean-all : ;
	@-rm $(TEX) $(TEXSTUD) $(TEXD) $(TEXSTUDD) $(PDFSLINUX) *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc
	@echo 'Alle unnötigen Output-Dateien gelöscht.'

rebuild-all : clean-all all
