# # # # # # # # # # # # #
# ur-magnus-opus-pandoc
# makefile for Linux
# # # # # # # # # # # # #
TEX          := $(patsubst %.md,%.md.latex.tex,$(wildcard *.ur.md))
TEXSTUD      := $(patsubst %.md,%.md.latex.stud.tex,$(wildcard *.ur.md))
TEXPLAIN     := $(patsubst %.md,%.md.latex.plain.tex,$(wildcard *.ur.md))
TEXSTUDPLAIN := $(patsubst %.md,%.md.latex.stud.plain.tex,$(wildcard *.ur.md))
TEXD         := $(patsubst %.md,%.md.latex.draft.tex,$(wildcard *.ur.md))
TEXSTUDD     := $(patsubst %.md,%.md.latex.stud.draft.tex,$(wildcard *.ur.md))
CSL          := https://raw.githack.com/maybegeek/ur-magnum-opus-csl/master/ur-magnum-opus-zotero.csl
#CSL          := Template/CSL/ur-magnum-opus-zotero.csl
ODT          := $(patsubst %.md,%.md.odt,$(wildcard *.ur.md))
HTM          := $(patsubst %.md,%.md.htm,$(wildcard *.ur.md))
HTMUR        := $(patsubst %.md,%.md.uni.htm,$(wildcard *.ur.md))
PDFSLINUX    := $(wildcard *atex.pdf) $(wildcard *atex.stud.pdf) $(wildcard *atex.draft.pdf) $(wildcard *atex.stud.draft.pdf)
URGRID       := Template/HTML/gridic.css
URHTMCSS     := Template/HTML/html.css
URHTMINCB    := Template/HTML/gridic-before.txt
URHTMINCBB   := Template/HTML/svg-top-banner.txt
URHTMINCA    := Template/HTML/gridic-after.txt
URWEBFONT    := Template/HTML/webfont-eb-garamond-link.txt
OUT          := Output
TEX_O        := --output-directory=$(OUT)

define TEX_TMPL
 --standalone --latex-engine=xelatex \
	--no-tex-ligatures --number-sections \
	--biblio Quellen/Quellen.bib -Vlot -Vlof \
	--template=Template/ur-magnum-opus-pandoc.tex \
	Template/metadata.yaml --biblatex 
endef
define TEX_RM
$(OUT)/*.aux $(OUT)/*.bbl $(OUT)/*.bcf $(OUT)/*.blg $(OUT)/*.lof $(OUT)/*.log $(OUT)/*.lot $(OUT)/*.out $(OUT)/*.run.xml $(OUT)/*.toc
endef
export TEX_TMPL
export TEX_RM

all : $(TEX) $(TEXSTUD) $(TEXPLAIN) $(TEXSTUDPLAIN) $(TEXD) $(TEXSTUDD) $(ODT) $(HTM) $(HTMUR)

odt: $(ODT)
html : $(HTM) $(HTMUR)


# TEX (MD->LaTeX->BibLaTeX+Biber->PDF)
%.ur.md.latex.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	$< -o $(OUT)/$@
	@echo '* TEX (biblatex)'
	xelatex $(TEX_O) $@ && biber $(OUT)/$(wildcard *.ur.md).latex && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXSTUD (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
%.ur.md.latex.stud.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $(OUT)/$@
	@echo '* TEX (biblatex, stud)'
	xelatex $(TEX_O) $@ && biber $(OUT)/$(wildcard *.ur.md).latex.stud && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXPLAIN (MD->LaTeX->BibLaTeX+Biber->PDF)
# ohne Kolumnentitel
%.ur.md.latex.plain.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	$< -o $(OUT)/$@
	@echo '* TEX (biblatex)'
	xelatex $(TEX_O) $@ && biber $(OUT)/$(wildcard *.ur.md).latex.plain && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXSTUDPLAIN (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
# ohne Kolumnentitel
%.ur.md.latex.stud.plain.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $(OUT)/$@
	@echo '* TEX (biblatex, stud)'
	xelatex $(TEX_O) $@ && biber $(OUT)/$(wildcard *.ur.md).latex.stud.plain && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXD (MD->LaTeX->BibLaTeX+Biber->PDF)
# draft
%.ur.md.latex.draft.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	$< -o $(OUT)/$@
	@echo '* TEX (biblatex)'
	xelatex $(TEX_O) $@ && biber $(OUT)/$(wildcard *.ur.md).latex.draft && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# TEXSTUDD (MD->LaTeX->BibLaTeX+Biber->PDF)
# Studentenversion mit mehr Durchschuss
# draft
%.ur.md.latex.stud.draft.tex : %.ur.md
	@pandoc $$TEX_TMPL \
	--include-in-header=Template/latex-include-kolumnentitel.tex \
	--include-in-header=Template/latex-include-watermark.tex \
	-V linestretch='1.7' -V classoption='DIV=11' \
	$< -o $(OUT)/$@
	@echo '* TEX (biblatex, stud)'
	xelatex $(TEX_O) $@ && biber $(OUT)/$(wildcard *.ur.md).latex.stud.draft && xelatex $(TEX_O) $@ && xelatex $(TEX_O) $@
	@-rm $$TEX_RM


# ODT
%.ur.md.odt : %.ur.md
	@pandoc --smart --standalone --biblio Quellen/Quellen.bib --csl $(CSL) \
	$< -o $(OUT)/$@
	@echo '* neue ODT erstellt'


# HTML (for offline use)
%.ur.md.htm : %.ur.md
	@pandoc --smart --standalone --toc --number-sections -t html5 \
	--biblio Quellen/Quellen.bib --csl $(CSL) -c $(URGRID) -c $(URHTMCSS) \
	-H $(URWEBFONT) -B $(URHTMINCB) -A $(URHTMINCA) \
	-V lang='de' --self-contained \
	$< -o $(OUT)/$@
	@echo '* neue HTML-Datei erstellt'


# HTML UNI (for offline use)
%.ur.md.uni.htm : %.ur.md
	@pandoc \
	--smart --standalone --toc --number-sections -t html5 \
	--biblio Quellen/Quellen.bib --csl $(CSL) -c $(URGRID) -c $(URHTMCSS) \
	-H $(URWEBFONT) -B $(URHTMINCBB) -B $(URHTMINCB) -A $(URHTMINCA) \
	-V lang='de' --self-contained \
	--template=Template/HTML/ur-html5-template.htm \
	$< -o $(OUT)/$@
	@echo '* neue HTML-Datei (uni) erstellt'


rm-all : ;
	@-rm $(TEX) $(TEXSTUD) $(TEXSTUDPLAIN) $(TEXPLAIN) $(TEXD) $(TEXSTUDD) $(PDFSLINUX) $(ODT) $$TEX_RM
	@echo 'Alle unnötigen Output-Dateien gelöscht.'

rm-odt : ;
	@-rm $(OUT)/$(ODT)
	@echo '* alte ODT-Datei gelöscht'

rm-html : ;
	@-rm $(OUT)/$(HTM) $(OUT)/$(HTMUR)
	@echo '* alte HTML-Dateien gelöscht'

rebuild-all : rm-all all
rebuild-odt : rm-odt odt
rebuild-html : rm-html html
