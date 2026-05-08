
VRAMWRITE	EQU	$40000000		; VRAM write
CRAMWRITE	EQU	$C0000000		; CRAM write
VDPDATA		EQU	$C00000		; VDP data port
VDPCTRL		EQU	$C00004		; VDP control port
ASCII_TILEDELTA	= $0660

SndTstID = $FFF808

SoundTest:
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
	bra.s	.printID
	rts

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

ArtUnc_Text:    binclude  "_new/ASCII.BIN"
ArtUnc_TextE:
ArtUnc_TextSZ   EQU     ArtUnc_TextE-ArtUnc_Text