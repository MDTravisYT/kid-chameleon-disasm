cd SOUND
cd PCM
mkdir OUT
"../../build/vasmz80_psi-x" -altlocal -altnum -spaces -maxerrors=0 -Fbin -start=0 -o "OUT/mddr11.bin" -L "OUT/mddr11.lst" -Lall "mddr11.src" 2> _errors.log
cd ../..
"build/vasmm68k_psi-x" -altlocal -altnum -spaces -m68000 -maxerrors=0 -no-opt -Fbin -start=0 -o "chameleon.bin" -L "chameleon.lst" -Lall "kid.asm" 2> _errors.log