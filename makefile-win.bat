@echo off
SET FNAME=latex.win
for /r . %%i in (*.ur.md) do pandoc^
 --standalone^
 --latex-engine=xelatex^
 --no-tex-ligatures^
 -Vlot^
 -Vlof^
 --number-sections^
 --biblio Quellen/Quellen.bib^
 --template=Template/MW-Template.tex^
 Template/yaml.yaml^
 --include-in-header=Template/latex-include-kolumnentitel.tex^
 --biblatex^
 -o %%~dpni.md.%FNAME%.tex %%~fi^
 && xelatex %%~nxi.%FNAME%.tex^
 && biber %%~nxi.%FNAME%^
 && xelatex %%~nxi.%FNAME%.tex^
 && xelatex %%~nxi.%FNAME%.tex 
del *.%FNAME%.aux
del *.%FNAME%.bbl
del *.%FNAME%.bcf
del *.%FNAME%.blg
del *.%FNAME%.lof
del *.%FNAME%.log
del *.%FNAME%.lot
del *.%FNAME%.run.xml
del *.%FNAME%.toc
del *.%FNAME%.out
