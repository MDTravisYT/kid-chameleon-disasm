@ECHO OFF

"build/vasmm68k_psi-x.exe" -altlocal -altnum -spaces -m68000 -maxerrors=0 -no-opt -Fbin -start=0 -o "chameleon.bin" -L "chameleon.lst" -Lall "kid.asm" 2> _errors.log

if %ERRORLEVEL% equ 0 goto noerror
title Aw fiddlesticks, what now!?
color 0c
cls
echo Something bad happened. Specifically:
type _errors.log
echo.
echo This has been saved to _errors.log
pause
exit

:noerror
IF EXIST _errors.log del _errors.log
fc /b kid.bin chameleon.bin > diff.txt