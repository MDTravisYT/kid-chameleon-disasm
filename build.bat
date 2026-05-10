@ECHO OFF

"build/vasmm68k_psi-x.exe" -altlocal -altnum -spaces -m68000 -maxerrors=0 -no-opt -Fbin -start=0 -o "chameleon.bin" -L "chameleon.lst" -Lall "kid.asm" 2> _errors.log
type _errors.log