; Some macros for data structures.
; ---------------------------------------------------------------------------

levnamhdr	macro	name, unknown, act
		dc.l	name
		dc.l	unknown
		dc.w	act
		endm

; ---------------------------------------------------------------------------
; the header file contains the following entries (12 bytes):
;		dc.b	xsize, ysize, fgstyle, bgstyle
;		dc.w	playerx, playery, flagx, flagy
maphdr		macro	fnamehdr, fgtile, block, bgtile, enemy
		incbin fnamehdr
		dc.l	fgtile, block, bgtile, enemy
		endm
; ---------------------------------------------------------------------------

anim_frame	macro	mode, duration, spriteframe
		dc.b	mode
		dc.b	duration
		dc.w	spriteframe
		endm

; ---------------------------------------------------------------------------

enemyloaddata	macro	paladdr, artaddr, codeaddr
		dc.w	paladdr
		dc.w	artaddr
		dc.l	codeaddr
		endm

; ---------------------------------------------------------------------------
; if the art crosses a $20000 boundary, align it to make DMA safe
align_dmasafe	macro   artsize
		;    if ((*) ! ((*)+artsize))&$FE0000 <> 0
		;	align $8000
		;    endif
		endm

; ---------------------------------------------------------------------------
sprite_frame_unc	macro	xcenter, ycenter, width, height, art, label
		align_dmasafe	((((width+7)>>3)*((height+7)>>3))*$20 + 6)
\label:
		dc.b	xcenter, ycenter
		dc.w	width, height
		incbin art
		endm

; ---------------------------------------------------------------------------

sprite_frame_vram	macro	spriteindex, xcenter, ycenter, width, height
		dc.w	spriteindex
		dc.b	xcenter, ycenter
		dc.w	width, height
		endm

; ---------------------------------------------------------------------------
sprite_attr	macro	xpos, ypos, xsize, ysize, pattern, lnk
		dc.w	ypos
		dc.w	(xsize<<10) | (ysize<<8) | lnk
		dc.w	pattern
		dc.w	xpos
		endm
; ---------------------------------------------------------------------------
ptfm_move	macro	duration, xvel, yvel
		dc.w	duration
		dc.l	xvel, yvel
		endm

; ---------------------------------------------------------------------------
ptfm		macro	xpos, ypos, bufL, bufR, bufT, bufB, t, s, h, v, pp
		dc.w	xpos, ypos
		dc.b	bufL, bufR, bufT, bufB
		dc.b	(t<<4)|s, (h<<4)|v
		dc.w	pp
		endm

; simplifying macros and functions, taken from Sonic 2 disassembly
; ---------------------------------------------------------------------------
; VDP addresses
VDP_data_port =			$C00000 ; (8=r/w, 16=r/w)
VDP_control_port =		$C00004 ; (8=r/w, 16=r/w)
PSG_input =			$C00011
; 68k address for the DMA macro
DMA_data_thunk = 		$FFFFF800


; makes a VDP address difference
vdpCommDelta func addr {((addr&$3FFF)<<16)|((addr&$C000)>>14)}

; makes a VDP command
vdpComm func addr,type,rwd {(((type&rwd)&3)<<30)|((addr&$3FFF)<<16)|(((type&rwd)&$FC)<<2)|((addr&$C000)>>14)}

; values for the type argument
VRAM = %100001
CRAM = %101011
VSRAM = %100101

; values for the rwd argument
READ = %001100
WRITE = %000111
DMA = %100111

; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
; a6 is the address of VDP_data_port
dma68kToVDP macro source,dest,length,type
	move.l	#($9400|((((length)>>1)&$FF00)>>8))|(($9300|(((length)>>1)&$FF))<<16),4(a6)
	move.l	#($9600|((((source)>>1)&$FF00)>>8))|(($9500|(((source)>>1)&$FF))<<16),4(a6)
	move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),4(a6)
	move.l	#vdpComm(dest,type,DMA),(DMA_data_thunk).w
	move.w	(DMA_data_thunk).w,4(a6)
	move.w	(DMA_data_thunk+2).w,4(a6)
    endm
	
; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 4 bytes per iteration
bytesToLcnt func n {n>>2-1}

; ---------------------------------------------------------------------------
; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_End =			$A02000 ; end of non-reserved Z80 RAM
Z80_Bus_Request =		$A11100
Z80_Reset =			$A11200

Security_Addr =			$A14000

; ---------------------------------------------------------------------------
; I/O Area 
HW_Version =				$A10001
HW_Port_1_Data =			$A10003
HW_Port_2_Data =			$A10005
HW_Expansion_Data =			$A10007
HW_Port_1_Control =			$A10009
HW_Port_2_Control =			$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =			$A1000F
HW_Port_1_RxData =			$A10011
HW_Port_1_SCtrl =			$A10013
HW_Port_2_TxData =			$A10015
HW_Port_2_RxData =			$A10017
HW_Port_2_SCtrl =			$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F