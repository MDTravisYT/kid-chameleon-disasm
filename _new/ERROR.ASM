InitTXT	macro	src,x,y
	moveq	#0,	d0
	moveq	#0,	d2
	lea	src,	a0
	move.w	#((x*2)+(y*$80)),d1
	jsr	PrintMsg
	endm

errBus:
	InitTXT	ASCIITXT1,2,2
	bra.w	Err_cont
errAddress:
	InitTXT	ASCIITXT2,2,2
	bra.w	Err_cont
errIllegal:
	InitTXT	ASCIITXT3,2,2
	bra.w	Err_cont
errZeroDiv:
	InitTXT	ASCIITXT4,2,2
	bra.w	Err_cont
errChkInst:
	InitTXT	ASCIITXT5,2,2
	bra.w	Err_cont
errPriViol:
	InitTXT	ASCIITXT6,2,2
	bra.w	Err_cont
errTrace:
	InitTXT	ASCIITXT7,2,2
	bra.w	Err_cont
errLine1010:
	InitTXT	ASCIITXT8,2,2
	bra.w	Err_cont
errLine1111:
	InitTXT	ASCIITXT9,2,2
	bra.w	Err_cont
errTrapV:
	InitTXT	ASCIITXT10,2,2
	bra.w	Err_cont
trap:
	InitTXT	ASCIITXT10,2,2
Err_cont:
	bsr.w	LoadASCIIArt
Err_loop:	
	move.l	#CRAMWRITE+((6*2)<<16),VDPCTRL
	move.w	#$EEE,VDPDATA
	bra.s	Err_loop
	
LoadASCIIArt:
	lea	ArtUnc_Text,a0
	move.l	#(ArtUnc_TextSZ)/4-1,d0
	move.l	#VRAMWRITE+$10000003,VDPCTRL
.loadASCII
	move.l	(a0)+,VDPDATA
	dbf	d0,.loadASCII
	rts
	
ASCIITXT1:	dc.b	'BUS ERROR',0
ASCIITXT2:	dc.b	'ADDRESS ERROR',0
ASCIITXT3:	dc.b	'ILLEGAL INSTRUCTION',0
ASCIITXT4:	dc.b	'ZERO DIVISON',0
ASCIITXT5:	dc.b	'CHK INSTRUCTION',0
ASCIITXT6:	dc.b	'PRIVILEGE VIOLATION',0
ASCIITXT7:	dc.b	'TRACE',0
ASCIITXT8:	dc.b	'LINE 1010',0
ASCIITXT9:	dc.b	'LINE 1111',0
ASCIITXT10:	dc.b	'TRAP!',0