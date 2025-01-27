set FAILED_ARK_BUILD=0
git pull https://github.com/hmxmilohax/Guitar-Hero-II-Deluxe-360 main
@echo off
copy "%~dp0\_theme\init_ui_theme.dta" "%~dp0\_ark\ui\" >nul
copy "%~dp0\_theme\init_track_theme.dta" "%~dp0\_ark\ui\" >nul
echo:
echo:Temporarily moving Xbox files out of the ark path to reduce final ARK size
@%SystemRoot%\System32\robocopy.exe "%~dp0\_ark" "%~dp0_temp\_ark" *.milo_xbox /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0\_ark" "%~dp0_temp\_ark" *.png_xbox /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0\_ark" "%~dp0_temp\_ark" *.bmp_xbox /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0\_ark" "%~dp0_temp\_ark" *.mogg /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0\_ark" "%~dp0_temp\_ark" *_xbox.dta /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0\_ark" "%~dp0_temp\_ark" *.fx_xbox /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
echo:
echo:Building PS2 ARK
"%~dp0dependencies/arkhelper" dir2ark "%~dp0\_ark" "%~dp0\_build\PS2\GEN" -n "MAIN" -s 4073741823 >nul
if %errorlevel% neq 0 (set FAILED_ARK_BUILD=1)
@echo off
del "%~dp0\_ark\ui\init_ui_theme.dta"
del "%~dp0\_ark\ui\init_track_theme.dta"
echo:
echo:Moving back Xbox files
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0\_ark" *.milo_xbox /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0\_ark" *.png_xbox /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0\_ark" *.bmp_xbox /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0\_ark" *.mogg /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0\_ark" *_xbox.dta /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0\_ark" *.fx_xbox /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
rd _temp
echo:
if %FAILED_ARK_BUILD% neq 1 (echo:Successfully built Guitar Hero II Deluxe ARK. You may find the files needed to build an ISO in /_build/PS2/)
if %FAILED_ARK_BUILD% neq 0 (echo:Error building ARK. Check your modifications or run _git_reset.bat to rebase your repo.)
echo:
pause