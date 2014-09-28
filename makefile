TEXB := $(patsubst %.md,%.md.latex.biblatex.tex,$(wildcard *.ur.md))
TEXSTUD := $(patsubst %.md,%.md.latex.biblatex.stud.tex,$(wildcard *.ur.md))
PDF := $(wildcard *.ur.md.latex.biblatex.pdf)
PDFSTUD := $(wildcard *.ur.md.latex.biblatex.stud.pdf)

all : $(TEXB) $(TEXSTUD)

# TEX biblatex
%.ur.md.latex.biblatex.tex : %.ur.md
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
	xelatex $@ && biber $(wildcard *.ur.md).latex.biblatex && xelatex $@ && xelatex $@ echo
	@-rm *.latex.biblatex.aux *.latex.biblatex.bbl *.latex.biblatex.bcf *.latex.biblatex.blg *.latex.biblatex.lof *.latex.biblatex.log *.latex.biblatex.lot *.latex.biblatex.out *.latex.biblatex.run.xml *.latex.biblatex.toc



# TEX biblatex stud
%.ur.md.latex.biblatex.stud.tex : %.ur.md
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
	xelatex $@ && biber $(wildcard *.ur.md).latex.biblatex.stud && xelatex $@ && xelatex $@ echo
	@-rm *.latex.biblatex.stud.aux *.latex.biblatex.stud.bbl *.latex.biblatex.stud.bcf *.latex.biblatex.stud.blg *.latex.biblatex.stud.lof *.latex.biblatex.stud.log *.latex.biblatex.stud.lot *.latex.biblatex.stud.out *.latex.biblatex.stud.run.xml *.latex.biblatex.stud.toc



clean-all : ;
	@-rm $(TEXB) $(TEXSTUD) $(PDF) $(PDFSTUD) *.latex.biblatex.aux *.latex.biblatex.bbl *.latex.biblatex.bcf *.latex.biblatex.blg *.latex.biblatex.lof *.latex.biblatex.log *.latex.biblatex.lot *.latex.biblatex.out *.latex.biblatex.run.xml *.latex.biblatex.toc *.latex.biblatex.stud.aux *.latex.biblatex.stud.bbl *.latex.biblatex.stud.bcf *.latex.biblatex.stud.blg *.latex.biblatex.stud.lof *.latex.biblatex.stud.log *.latex.biblatex.stud.lot *.latex.biblatex.stud.out *.latex.biblatex.stud.run.xml *.latex.biblatex.stud.toc
	@echo 'Alle unnötigen Output-Dateien gelöscht.'

rebuild-all : clean-all all
