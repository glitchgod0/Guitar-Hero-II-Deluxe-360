del /f "%~dp0_ark\track\surfaces\highways.dta"
cd "%~dp0highways"
forfiles /s /m *.* /C "cmd /e:on /v:on /c set \"Phile=@file\" & if @ISDIR==FALSE ren @file !Phile: =_!"
forfiles /s /m *.* /C "cmd /e:on /v:on /c set \"Phile=@file\" & if @ISDIR==FALSE  ren @file !Phile:-=_!"
for /f "Tokens=*" %%f in ('dir /l/b/a-d/s') do (move /y "%%f" "%%f")
for %%i in (*.bmp) do @echo "%%~ni">> highways.dta
for %%i in (*.png) do @echo "%%~ni">> highways.dta
for %%i in (*.jpg) do @echo "%%~ni">> highways.dta
move "%~dp0highways\highways.dta" "%~dp0_ark\track\surfaces\highways.dta"
FOR /F "tokens=*" %%G IN ('dir /b *.png') DO "%~dp0dependencies/magick/magick.exe" convert "%~dp0highways/%%G" -resize 512x1024! -filter Box -define dither:diffusion-amount=50%% -dither FloydSteinberg -colors 256 -depth 8 "%~dp0highways\%%~nG.png"
FOR /F "tokens=*" %%G IN ('dir /b *.jpg') DO "%~dp0dependencies/magick/magick.exe" convert "%~dp0highways/%%G" -resize 512x1024! -filter Box -define dither:diffusion-amount=50%% -dither FloydSteinberg -colors 256 -depth 8 "%~dp0highways\%%~nG.png"
FOR /F "tokens=*" %%G IN ('dir /b *.bmp') DO "%~dp0dependencies/magick/magick.exe" convert "%~dp0highways/%%G" -resize 512x1024! -filter Box -define dither:diffusion-amount=50%% -dither FloydSteinberg -colors 256 -depth 8 "%~dp0highways\%%~nG.png"
FOR /F "tokens=*" %%G IN ('dir /b *.png') DO "%~dp0dependencies/magick/magick.exe" convert "%~dp0highways/%%G" -resize 256x512! -filter Box -define dither:diffusion-amount=50%% -dither FloydSteinberg -colors 256 -depth 8 "%~dp0highways\ps2\%%~nG.png"
FOR /F "tokens=*" %%G IN ('dir /b *.png') DO "%~dp0dependencies/superfreq.exe" png2tex "%~dp0highways/%%G" "%~dp0_ark\track\surfaces\gen\%%~nG_keep.bmp_xbox" --platform x360 --miloVersion 25
cd "%~dp0highways/ps2"
FOR /F "tokens=*" %%G IN ('dir /b *.png') DO "%~dp0dependencies/superfreq.exe" png2tex "%~dp0highways/ps2/%%G" "%~dp0_ark\track\surfaces\gen\%%~nG_keep.bmp_ps2" --platform ps2 --preset gh2
pause