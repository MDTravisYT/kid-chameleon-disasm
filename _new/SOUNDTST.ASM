
VRAMWRITE	EQU	$40000000		; VRAM write
CRAMWRITE	EQU	$C0000000		; CRAM write
VDPDATA		EQU	$C00000		; VDP data port
VDPCTRL		EQU	$C00004		; VDP control port
ASCII_TILEDELTA	= $0660

btnU	=	0		;	up
btnD	=	1		;	down
btnL	=	2		;	left
btnR	=	3		;	right
btnB	=	4		;	B
btnC	=	5		;	C
btnA	=	6		;	A (isnt it funny how this comes after the rest hmmmmmm)
btnS	=	7		;	Start

SndTstID = $FF0000

SoundTest:
	jsr 	_gemsstopall
	move.l	#CRAMWRITE+((6*2)<<16),VDPCTRL
	move.w	#$EEE,VDPDATA

	lea	ArtUnc_Text,a0
	move.l	#(ArtUnc_TextSZ)/4-1,d0
	move.l	#VRAMWRITE+$10000003,VDPCTRL
.loadASCII
	move.l	(a0)+,VDPDATA
	dbf	d0,.loadASCII
	
	moveq	#0,d0
	lea	.string,a0			; string pointer
	move.w	#$0000+((10*2)+(12*$80)),d1	; screen position
	bsr.w	PrintMsg
; ---------------------------------------------------------------------------
.printID:
	lea	SndTstID,	a0
	move.w	(a0),	d0
	move.w	#$0000+((18*2)+(16*$80)),d1	; screen position
	moveq	#0,	d2
	bsr.w	PrintWordValue
.loop
	jsr	WaitForVint
	jsr	readjoypads_sonic
	btst	#btnS,Ctrl_1_Pressed.w
	bne.w	.exit
	btst	#btnL,Ctrl_1_Pressed.w
	bne.w	.left
	btst	#btnR,Ctrl_1_Pressed.w
	bne.w	.right
	btst	#btnU,Ctrl_1_Pressed.w
	bne.w	.up10
	btst	#btnD,Ctrl_1_Pressed.w
	bne.w	.dn10
	btst	#btnC,Ctrl_1_Pressed.w
	bne.w	.play
	
	bra.s	.loop
	
.left:
	sub.w	#1,	SndTstID
	bra.w	.printID
.right:
	add.w	#1,	SndTstID
	bra.w	.printID
.play:
	jsr 	_gemsstopall
	move.b	SndTstID+1,	d0
	jsr	PlaySound
	bra.w	.loop
.exit:
	;move.b  #GMNO_SELECT,gamemode.w
	rts
.up10:
	sub.w	#16,	SndTstID
	bra.w	.printID
.dn10:
	add.w	#16,	SndTstID
	bra.w	.printID

; ---------------------------------------------------------------------------
.string:
	dc.b "Cool, Sweet, & Catchy!",0
	even
; ---------------------------------------------------------------------------
; By Katsushimi, originally created for Sonic Stardom
; Print a standard null-terminated ASCII string to a VDP nametable/address
; ---------------------------------------------------------------------------
; a0 - String addr
; d1 - VRAM location (non-cmd)
; d2 - Palette, info
; ---------------------------------------------------------------------------   

PrintMsg:
	moveq	#0,d3			; Make VDPCMD from value in d1
	move.w	d1,d3
	lsl.l	#2,d3
	lsr.w	#2,d3
	ori.w	#$4000,d3
	swap	d3
	move.l	d3,VDPCTRL		; Set write location

	move.w  d2,d5			; Get d2 palette index
	andi.w	#%11,d5
	lsl.w	#8,d5
	lsl.w	#5,d5

	move.w  #ASCII_TILEDELTA,d4

.Loop:
;	rept 4	; unroll 4
	moveq	#0,d3
	move.b	(a0)+,d3
	beq.s	.Done
	add.w	d4,d3
	or.w	d5,d3
	move.w	d3,VDPDATA
	moveq	#0,d3
	move.b	(a0)+,d3
	beq.s	.Done
	add.w	d4,d3
	or.w	d5,d3
	move.w	d3,VDPDATA
	moveq	#0,d3
	move.b	(a0)+,d3
	beq.s	.Done
	add.w	d4,d3
	or.w	d5,d3
	move.w	d3,VDPDATA
	moveq	#0,d3
	move.b	(a0)+,d3
	beq.s	.Done
	add.w	d4,d3
	or.w	d5,d3
	move.w	d3,VDPDATA
;	endr

	bra.s	.Loop
.Done:
	rts
	
; ---------------------------------------------------------------------------
; By Katsushimi, originally created for Sonic Stardom
; Print a word value to a VDP nametable/address
; ---------------------------------------------------------------------------   
; d0 - Value to print
; d1 - VRAM location (non-cmd) 
;
; d0 and d1 are not trashed in this routine.
; ---------------------------------------------------------------------------    

PrintWordValue:
	moveq	#0,d3		; Make VDPCMD from value in d1
	move.w	d1,d3
	lsl.l	#2,d3
	lsr.w	#2,d3
	ori.w	#$4000,d3
	swap	d3
	move.l	d3,VDPCTRL	; Set write location

	move.w	d0,d1		; d0 = d1

	; Write each indivdual digit/nybble as a tile index

	rol.w	#4,d1
	bsr.s	.WriteNybble
	rol.w	#4,d1
	bsr.s	.WriteNybble
	rol.w	#4,d1
	bsr.s	.WriteNybble
	rol.w	#4,d1

.WriteNybble:
	move.w	d1,d4
	andi.w	#$F,d4
	move.w	#0,d3
	add.b	.ConvTbl(pc,d4.w),d3
	addi.w	#ASCII_TILEDELTA+32,d3
	move.w	d3,VDPDATA
	rts

.ConvTbl:
	dc.b	$10, $11, $12, $13, $14, $15, $16, $17
	dc.b	$18, $19, $21, $22, $23, $24, $25, $26

; ---------------------------------------------------------------------------
; This game's joypad code super-sucks. Here's the Sonic version instead.
; --------------------------------------------------------------------------- 
; Word
HVERSION_	EQU	$A10000		; Hardware version
IODATA1_	EQU	$A10002		; Pad 1 Data
IODATA2_	EQU	$A10004         ; Pad 2 Data
IODATA3_	EQU	$A10006         ; EXT Data
IOCTRL1_	EQU	$A10008         ; Pad 1 Ctrl
IOCTRL2_	EQU	$A1000A         ; Pad 2 Ctrl
IOCTRL3_	EQU	$A1000C         ; EXT Ctrl
; Byte
HVERSION        EQU     HVERSION_+1
IODATA1         EQU     IODATA1_+1
IODATA2         EQU     IODATA2_+1
IODATA3         EQU     IODATA3_+1
IOCTRL1         EQU     IOCTRL1_+1
IOCTRL2         EQU     IOCTRL2_+1
IOCTRL3         EQU     IOCTRL3_+1  
readjoypads_sonic:
	lea	(Ctrl_1_Held).w,	a0
	lea	(IODATA1).l,	a1
	bsr.s	.readpad
	addq.w	#2,	a1
	bsr.s	.readpad
	rts
		
.readpad:
	move.b  #0,(a1)
	nop
	nop
	move.b  (a1),d0
	lsl.b   #2,d0
	andi.b  #$c0,d0
	move.b  #$40,(a1) ; '@'
	nop
	nop
	move.b  (a1),d1
	andi.b  #$3f,d1 ; '?'
	or.b    d1,d0
	not.b   d0
	move.b  (a0),d1
	eor.b   d0,d1
	move.b  d0,(a0)+
	and.b   d0,d1
	move.b  d1,(a0)+
	rts

ArtUnc_Text:    binclude  "_new/ASCII.BIN"
ArtUnc_TextE:
ArtUnc_TextSZ   EQU     ArtUnc_TextE-ArtUnc_Text