@echo off

for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%

@echo on

git add _vimrc
git add _gvimrc
git add _vsvimrc
git add vim_sync.bat
git add file_associations.bat
git add context_menu.bat
git commit -m "%mydate%:%mytime%"
git pull
git push

pause
