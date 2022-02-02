@REM FROM: https://superuser.com/a/1260076/1192368
SETLOCAL EnableDelayedExpansion
cd /D %~dp0
cd packages
set _filelist=
for /f "delims=|" %%f in ('dir /b %CD%') do (
  set "_filelist=!_filelist! %%f"
)
set _filelist=%_filelist:,,=%
pip install %_filelist%
exit
