@echo off
SET ODIR=Output
SET XOPT=--output-directory=%ODIR%
SET FNAME=latex.win
REM SET CSL=https://raw.githack.com/maybegeek/ur-magnum-opus-csl/master/ur-magnum-opus-zotero.csl
SET CSL=Template/CSL/ur-magnum-opus-zotero.csl
SET URGRID=Template/HTML/gridic.css
SET URHTMCSS=Template/HTML/html.css
SET URHTMINCB=Template/HTML/gridic-before.txt
SET URHTMINCA=Template/HTML/gridic-after.txt
SET URWEBFONT=Template/HTML/webfont-eb-garamond-link.txt

REM *.latex.win.pdf
REM TEX
for /r . %%i in (*.ur.md) do pandoc^
 --standalone --latex-engine=xelatex^
 --no-tex-ligatures -Vlot -Vlof^
 --number-sections --biblio Quellen/Quellen.bib^
 --template=Template/ur-magnum-opus-pandoc.tex^
 Template/metadata.yaml --biblatex^
 --include-in-header=Template/latex-include-kolumnentitel.tex^
 -o %ODIR%/%%~nxi.%FNAME%.tex %%~fi^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.tex^
 && biber %ODIR%/%%~nxi.%FNAME%^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.tex^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.tex

REM *.latex.win.stud.pdf
REM TEXSTUD
REM Studentenversion mit mehr Durchschuss
for /r . %%i in (*.ur.md) do pandoc^
 --standalone --latex-engine=xelatex^
 --no-tex-ligatures -Vlot -Vlof^
 --number-sections --biblio Quellen/Quellen.bib^
 --template=Template/ur-magnum-opus-pandoc.tex^
 Template/metadata.yaml --biblatex^
 --include-in-header=Template/latex-include-kolumnentitel.tex^
 -V linestretch=1.7^
 -V classoption=DIV=11^
 -o %ODIR%/%%~nxi.%FNAME%.stud.tex %%~fi^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.tex^
 && biber %ODIR%/%%~nxi.%FNAME%.stud^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.tex^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.tex

REM *.latex.win.plain.pdf
REM TEXPLAIN
REM ohne Kolumnentitel
for /r . %%i in (*.ur.md) do pandoc^
 --standalone --latex-engine=xelatex^
 --no-tex-ligatures -Vlot -Vlof^
 --number-sections --biblio Quellen/Quellen.bib^
 --template=Template/ur-magnum-opus-pandoc.tex^
 Template/metadata.yaml --biblatex^
 -o %ODIR%/%%~nxi.%FNAME%.plain.tex %%~fi^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.plain.tex^
 && biber %ODIR%/%%~nxi.%FNAME%.plain^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.plain.tex^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.plain.tex

REM *.latex.win.stud.plain.pdf
REM TEXSTUDPLAIN
REM Studentenversion mit mehr Durchschuss
REM ohne Kolumnentitel
for /r . %%i in (*.ur.md) do pandoc^
 --standalone --latex-engine=xelatex^
 --no-tex-ligatures -Vlot -Vlof^
 --number-sections --biblio Quellen/Quellen.bib^
 --template=Template/ur-magnum-opus-pandoc.tex^
 Template/metadata.yaml --biblatex^
 -V linestretch=1.7^
 -V classoption=DIV=11^
 -o %ODIR%/%%~nxi.%FNAME%.stud.plain.tex %%~fi^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.plain.tex^
 && biber %ODIR%/%%~nxi.%FNAME%.stud.plain^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.plain.tex^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.plain.tex

REM *.latex.win.draft.pdf
REM TEXD
REM draft
for /r . %%i in (*.ur.md) do pandoc^
 --standalone --latex-engine=xelatex^
 --no-tex-ligatures -Vlot -Vlof^
 --number-sections --biblio Quellen/Quellen.bib^
 --template=Template/ur-magnum-opus-pandoc.tex^
 Template/metadata.yaml --biblatex^
 --include-in-header=Template/latex-include-kolumnentitel.tex^
 --include-in-header=Template/latex-include-watermark.tex^
 -o %ODIR%/%%~nxi.%FNAME%.draft.tex %%~fi^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.draft.tex^
 && biber %ODIR%/%%~nxi.%FNAME%.draft^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.draft.tex^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.draft.tex

REM *.latex.win.stud.draft.pdf
REM TEXSTUDD
REM Studentenversion mit mehr Durchschuss
REM draft
for /r . %%i in (*.ur.md) do pandoc^
 --standalone --latex-engine=xelatex^
 --no-tex-ligatures -Vlot -Vlof^
 --number-sections --biblio Quellen/Quellen.bib^
 --template=Template/ur-magnum-opus-pandoc.tex^
 Template/metadata.yaml --biblatex^
 --include-in-header=Template/latex-include-kolumnentitel.tex^
 --include-in-header=Template/latex-include-watermark.tex^
 -Vlinestretch=1.7^
 -Vclassoption=DIV=11^
 -o %ODIR%/%%~nxi.%FNAME%.stud.draft.tex %%~fi^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.draft.tex^
 && biber %ODIR%/%%~nxi.%FNAME%.stud.draft^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.draft.tex^
 && xelatex %XOPT% %ODIR%/%%~nxi.%FNAME%.stud.draft.tex
 
del %ODIR%\*.%FNAME%*.aux
del %ODIR%\*.%FNAME%*.bbl
del %ODIR%\*.%FNAME%*.bcf
del %ODIR%\*.%FNAME%*.blg
del %ODIR%\*.%FNAME%*.lof
del %ODIR%\*.%FNAME%*.log
del %ODIR%\*.%FNAME%*.lot
del %ODIR%\*.%FNAME%*.run.xml
del %ODIR%\*.%FNAME%*.toc
del %ODIR%\*.%FNAME%*.out


REM ODT
for /r . %%i in (*.ur.md) do pandoc^
 --smart^
 --standalone^
 --biblio Quellen/Quellen.bib^
 --csl %CSL%^
 -o %ODIR%/%%~nxi.win.odt %%~fi

REM HTML
for /r . %%i in (*.ur.md) do pandoc^
 --smart^
 --standalone^
 --toc^
 --number-sections^
 -t html5^
 --biblio Quellen/Quellen.bib^
 --csl %CSL%^
 -c %URGRID%^
 -c %URHTMCSS%^
 -H %URWEBFONT%^
 -B %URHTMINCB%^
 -A %URHTMINCA%^
 -Vlang=de^
 --self-contained^
 -o %ODIR%/%%~nxi.win.htm %%~fi