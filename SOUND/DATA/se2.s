;=======================================================;
;			*$$SE2.S  (S.E. Data)						;
;						ORG. MDSE112.S					;
;				'Sound-Source'							;
;				 for Mega Drive (68K)					;
;						Ver  1.1 / 1990.9.1				;
;									  By  H.Kubota		;
;=======================================================;

;		list off
;		include mdEQ11.LIB
;		include mdMCR11.LIB
;		include mdTB11.LIB
;		list on

;		PUBLIC	SB0,SB1,SB2,SB3,SB4,SB5,SB6,SB7
;		PUBLIC	SB8,SB9,SBA,SBB,SBC,SBD,SBE,SBF

		even

;=======================================;
;				   SB0					;
;=======================================;
SB0:
		TDW		TIMBB0,SB0				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,4					; Flag,Channel
		TDW		TABB00,SB0				; FM 1ch Table Pointer
		DC.B	00H,002H				; Bias,Volm
;------------< Table Data >-------------;
TABB00	EQU		*
		DC.B	FEV,0,NL,1,FVR,3,1,05DH,15
		DC.B	BN3,12,VROFF
TB0L	EQU		*
		DC.B	CMTAB,CMVADD,2,CN5,2
		DC.B	CMREPT,0,019H
		JDW		TB0L
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB0	EQU		*
		DC.B	$20
		DC.B	$36, $35, $30, $31, 	$DF, $DF, $9F, $9F, 	$07, $06, $09, $06
		DC.B	$07, $06, $06, $08, 	$2F, $1F, $1F, $FF, 	$16, $30, $13, $80
		even

;=======================================;
;				   SB1					;
;=======================================;
SB1:
		TDW		TIMBB1,SB1				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0A0H				; Flag,Channel
		TDW		TABB10,SB1				; FM 1ch Table Pointer
		DC.B	-12,000H				; Bias,Volm
;------------< Table Data >-------------;
TABB10	EQU		*
		DC.B	EV,0,FVR,2,1,-8,65H
		DC.B	BF2,16
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB1	EQU		*

		even

;=======================================;
;				   SB2					;
;=======================================;
SB2:
		TDW		TIMBB2,SB2				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABB20,SB2				; FM 1ch Table Pointer
		DC.B	06H,010H				; Bias,Volm
;------------< Table Data >-------------;
TABB20	EQU		*
		DC.B	FEV,0,FVR,2,1,-64,-1
		DC.B	CS3,16
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB2	EQU		*
		DC.B	$06
		DC.B	$00, $09, $09, $09, 	$1F, $0D, $0D, $0D, 	$00, $00, $00, $00
		DC.B	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$20, $80, $80, $80
		
	;	dc.b	$06,$00,$09,$09,$09,$1F,$0B,$0B,$0B,$00,$00,$00,$00,$0D,$0D,$0D,$0D,$0F,$0F,$0F,$0F,$20,$80,$80,$80
		even

;=======================================;
;				   SB3					;
;=======================================;
SB3:
		TDW		TIMBB3,SB3				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H					; Flag,Channel
		TDW		TABB30,SB3				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm
;------------< Table Data >-------------;
TABB30	EQU		*
		DC.B	CMNOIS,NOIS7,EV,1
		DC.B	AN5,8,AN5,AN5
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB3	EQU		*

		even

;=======================================;
;				   SB4					;
;=======================================;
SB4:
		TDW		TIMBB4,SB4				; Voice Top Address
		DC.B	1,3						; Base,Use Channel Total

		DC.B	80H,4					; Flag,Channel
		TDW		TABB40,SB4				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

		DC.B	80H,5					; Flag,Channel
		TDW		TABB40,SB4				; FM 1ch Table Pointer
		DC.B	10H,000H				; Bias,Volm

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABB41,SB4				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm
;------------< Table Data >-------------;
TABB40	EQU		*
		DC.B	FEV,0,FVR,4,1,16,8
		DC.B	CN0,4,CN0,10
TBB41	EQU		*
		DC.B	CN0,15H,CMVADD,8,CMREPT,0,10
		JDW		TBB41
		DC.B	CMEND
TABB41	EQU		*
		DC.B	FVR,4,1,12,2,CMNOIS,NOIS7
TBB42	EQU		*
		DC.B	BN3,10,CMTAB,PVADD,1,CMREPT,0,12
		JDW		TBB42
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB4	EQU		*
		DC.B	$F9
		DC.B	$21, $30, $10, $32, 	$1F, $1F, $1F, $1F, 	$05, $18, $07, $0D
		DC.B	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0E, $07, $04, $80
		even

;=======================================;
;				   SB5					;
;=======================================;
SB5:
		TDW		TIMBB5,SB5				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABB50,SB5				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm
;------------< Table Data >-------------;
TABB50	EQU		*
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB5	EQU		*
		even

;=======================================;
;				   SB6					;
;=======================================;
SB6:
		TDW		TIMBB6,SB6				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABB60,SB6				; FM 1ch Table Pointer
		DC.B	0AH,005H				; Bias,Volm
;------------< Table Data >-------------;
TABB60	EQU		*
		DC.B	FEV,0,FVR,2,1,12H,4
TBB6L0	EQU		*
		DC.B	CN0,4,CMREPT,0,1CH
		JDW		TBB6L0
TBB6L1	EQU		*
		DC.B	CN0,4,CMVADD,3,CMREPT,0,12
		JDW		TBB6L1
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB6	EQU		*
		dc.b	$FA
		dc.b	$21, $30, $10, $32, 	$1F, $1F, $1F, $1F, 	$05, $16, $07, $0D
		dc.b	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0E, $07, $04, $80
		even

;=======================================;
;				   SB7					;
;=======================================;
SB7:
		TDW		TIMBB7,SB7				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABB70,SB7				; FM 1ch Table Pointer
		DC.B	00H,002H				; Bias,Volm
;------------< Table Data >-------------;
TABB70	EQU		*
		DC.B	FEV,0,FVR,1,1,16,-1
		DC.B	AF2,028H
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB7	EQU		*
		DC.B	$54
		DC.B	$00, $32, $31, $14,	$1F, $9F, $1F, $1F
		DC.B	$0E, $08, $0B, $0E,	$0D, $0D, $00, $0F
		DC.B	$3F, $2F, $2F, $3F,	$00, $80, $06, $80
		even

;=======================================;
;				   SB8					;
;=======================================;
SB8:
		TDW		TIMBB8,SB8				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABB80,SB8				; FM 1ch Table Pointer
		DC.B	00H,004H				; Bias,Volm
;------------< Table Data >-------------;
TABB80	EQU		*
		DC.B	FEV,0,GN0,12
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB8	EQU		*
		dc.b	$FA
		dc.b	$21, $30, $10, $32, 	$2F, $1F, $2F, $2F, 	$05, $10, $14, $18
		dc.b	$11, $11, $0B, $0B, 	$5F, $5F, $1F, $0F, 	$0F, $02, $07, $80
		even

;=======================================;
;				   SB9					;
;=======================================;
SB9:
		TDW		TIMBB9,SB9				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABB90,SB9				; FM 1ch Table Pointer
		DC.B	-12,000H				; Bias,Volm
;------------< Table Data >-------------;
TABB90	EQU		*
		DC.B	FEV,0,FVR,2,1,-12,1
TBB90	EQU		*
		DC.B	EF0,8,CMVADD,12,CMREPT,0,6
		JDW		TBB90
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBB9	EQU		*
		dc.b	$02
		dc.b	$00, $00, $02, $30, 	$1D, $1A, $1A, $1A, 	$00, $10, $14, $18
		dc.b	$11, $11, $0B, $0B, 	$5F, $5F, $1F, $0F, 	$0F, $02, $07, $80
		even

;=======================================;
;				   SBA					;
;=======================================;
SBA:
		TDW		TIMBBA,SBA				; Voice Top Address
		DC.B	1,4						; Base,Use Channel Total

		DC.B	80H,3					; Flag,Channel
		TDW		TABBA0,SBA				; FM 1ch Table Pointer
		DC.B	10H,000H				; Bias,Volm
		DC.B	80H,4					; Flag,Channel
		TDW		TABBA1,SBA				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm
		DC.B	80H,5					; Flag,Channel
		TDW		TABBA2,SBA				; FM 1ch Table Pointer
		DC.B	10H,000H				; Bias,Volm
		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABBA3,SBA				; FM 1ch Table Pointer
		DC.B	0CH,000H				; Bias,Volm
;------------< Table Data >-------------;
TABBA0	EQU		*
		DC.B	LRPAN,RSET,NL,2,CMJUMP,TABBA1
TABBA2	EQU		*
		DC.B	LRPAN,LSET,NL,1
TABBA1	EQU		*
		DC.B	FEV,0,FVR,2,1,0F0H,4
TBA1L0	EQU		*
		DC.B	CN0,12,CMVADD,12,CMREPT,0,4
		JDW		TBA1L0
		DC.B	CMEND
TABBA3	EQU		*
		DC.B	FVR,1,1,0F0H,1,CMNOIS,NOIS7
TBA1L1	EQU		*
		DC.B	GN2,0EH,TIE,PVADD,3,CMREPT,0,5
		JDW		TBA1L1
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBBA	EQU		*
		DC.B	$20
		DC.B	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$00, $11, $14, $18
		DC.B	$12, $12, $0B, $0B, 	$0F, $FF, $1F, $0F, 	$03, $04, $01, $80
		even

;=======================================;
;				   SBB					;
;=======================================;
SBB:
		TDW		TIMBBB,SBB				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABBB0,SBB				; FM 1ch Table Pointer
		DC.B	0FAH,000H				; Bias,Volm
;------------< Table Data >-------------;
TABBB0	EQU		*
		DC.B	FVR,2,1,0F0H,1,CMNOIS,NOIS7
		DC.B	BN3
TBBBL	EQU		*
		DC.B	2,CS5,2,PVADD,3,CMREPT,0,5
		JDW		TBBBL
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBBB	EQU		*

		even

;=======================================;
;				   SBC					;
;=======================================;
SBC:
		TDW		TIMBBC,SBC				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABBC0,SBC				; FM 1ch Table Pointer
		DC.B	00H,001H				; Bias,Volm
;------------< Table Data >-------------;
TABBC0	EQU		*
		DC.B	CMNOIS,NOIS7
		DC.B	FVR,1,1,3,8
TBC0	EQU		*
		DC.B	0A7H,1,CMBIAS,1,CMREPT,0,1AH
		JDW		TBC0
TBC1	EQU		*
		DC.B	20,PVADD,2
		DC.B	CMREPT,0,4
		JDW		TBC1
		DC.B	EXCOM,2
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBBC	EQU		*

		even

;=======================================;
;				   SBD					;
;=======================================;
SBD:
		TDW		TIMBBD,SBD				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABBD0,SBD				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm
;------------< Table Data >-------------;
TABBD0	EQU		*
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBBD	EQU		*

		even

;=======================================;
;				   SBE					;
;=======================================;
SBE:
		TDW		TIMBBE,SBE				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABBE0,SBE				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm
;------------< Table Data >-------------;
TABBE0	EQU		*
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBBE	EQU		*

		even

;=======================================;
;				   SBF					;
;=======================================;
SBF:
		TDW		TIMBBF,SBF				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABBF0,SBF				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm
;------------< Table Data >-------------;
TABBF0	EQU		*
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBBF	EQU		*

; vim: set ft=asm68k sw=4 ts=4 noet:
