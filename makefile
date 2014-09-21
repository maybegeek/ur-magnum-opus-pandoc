TEXB := $(patsubst %.md,%.md.latex.biblatex.tex,$(wildcard *.md))

all : $(TEXB)

# TEX biblatex
%.md.latex.biblatex.tex : %.md
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
	xelatex $@ && biber $(wildcard *.md).latex.biblatex && xelatex $@ && xelatex $@

clean-all : ;
	@-rm $(TEXB) 
	@echo 'Alle Output-Dateien gelöscht.'

rebuild-all : clean-all all