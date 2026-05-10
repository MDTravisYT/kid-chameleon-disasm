@ECHO OFF
REM // build the ROM
call build %1

REM  // compare built ROM against original ROM
echo -------------------------------------------------------------
IF EXIST chameleon.bin ( fc /b kid.bin chameleon.bin > diff.txt
) ELSE echo chameleon.bin does not exist, probably due to an assembly error

pause