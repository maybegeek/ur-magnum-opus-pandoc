TEXB := $(patsubst %.md,%.md.latex.biblatex.tex,$(wildcard *.ur.md))
PDF := $(wildcard *.ur.md.latex.biblatex.pdf)

all : $(TEXB)

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
	-rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc

clean-all : ;
	@-rm $(TEXB) $(PDF) *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.toc
	@echo 'Alle unnötigen Output-Dateien gelöscht.'

rebuild-all : clean-all all