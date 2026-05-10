@ECHO OFF

IF NOT EXIST level/platform/49.asm goto :spliterr

echo Building PCM data...
echo ========================================================================================================================
cd SOUND
cd PCM
if not exist OUT mkdir OUT
"../../build/vasmz80_psi-x.exe" -altlocal -altnum -spaces -maxerrors=0 -Fbin -start=0 -o "OUT/mddr11.bin" -L "OUT/mddr11.lst" -Lall "mddr11.src" 2> _errors.log
if %ERRORLEVEL% equ 1 goto error

echo.
echo Building game...
echo ========================================================================================================================
cd ../..
"build/vasmm68k_psi-x.exe" -altlocal -altnum -spaces -m68000 -maxerrors=0 -no-opt -Fbin -start=0 -o "chameleon.bin" -L "chameleon.lst" -Lall "kid.asm" 2> _errors.log

if %ERRORLEVEL% equ 0 goto noerror
:error
title Aw fiddlesticks, what now!?
color 0c
cls
echo Something bad happened. Specifically:
type _errors.log
echo.
echo This has been saved to _errors.log
pause
exit

:spliterr
title Unsplit ROM!
color 0c
cls
echo Something bad happened. Specifically:
echo.
echo The ROM has not yet been split. 
echo Insert an unmodified Kid Chameleon (USA) ROM in the root folder, rename it to "kid.bin", then run split.py
echo.
pause
exit


:noerror
IF EXIST _errors.log del _errors.log
fc /b kid.bin chameleon.bin > diff.txt