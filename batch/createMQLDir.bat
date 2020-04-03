@echo off

setlocal

set /p path=Insert path where mql folders are created.(C:\devEnv\Project\mql) : 

if "%path%" == "" set path=.

cd %path%

md "01. attribute"
md "02. type"
md "03. role"
md "04. policy"
md "05. relationship"
md "06. command"
md "07. menu"
md "08. channel"
md "09. portal"
md "10. table"
md "11. form"
md "12. page"
md "13. searchindex"
md "14. trigger"
md "15. bus"

echo mql folders are created.
pause