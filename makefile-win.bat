@echo off
SET DERNAME=latex.biblatex.win
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
 -o %%~dpni.md.%DERNAME%.tex %%~fi^
 && xelatex %%~nxi.%DERNAME%.tex^
 && biber %%~nxi.%DERNAME%^
 && xelatex %%~nxi.%DERNAME%.tex^
 && xelatex %%~nxi.%DERNAME%.tex 
del *.%DERNAME%.aux
del *.%DERNAME%.bbl
del *.%DERNAME%.bcf
del *.%DERNAME%.blg
del *.%DERNAME%.lof
del *.%DERNAME%.log
del *.%DERNAME%.lot
del *.%DERNAME%.run.xml
del *.%DERNAME%.toc
del *.%DERNAME%.out