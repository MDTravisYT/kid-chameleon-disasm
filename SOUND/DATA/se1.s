;=======================================================;
;			*$$SE1.S  (S.E. Data)						;
;						ORG. MDSE111.S					;
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

;		PUBLIC	SA0,SA1,SA2,SA3,SA4,SA5,SA6,SA7
;		PUBLIC	SA8,SA9,SAA,SAB,SAC,SAD,SAE,SAF

		even

;=======================================;
;				   SA0					;
;=======================================;
SA0:

		TDW		TIMBA0,SA0				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,080H				; Flag,Channel
		TDW		TABA00,SA0				; FM 1ch Table Pointer
		DC.B	-12,000H				; Bias,Volm

;------------< Table Data >-------------;
TABA00	EQU		*
		DC.B	EV,0
		DC.B	FN2,5, FVR,2,1,-8,065h
		DC.B	BF2,015H
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA0	EQU		*

		even

;=======================================;
;				   SA1					;
;=======================================;
SA1:
		TDW		TIMBA1,SA1				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,4				; Flag,Channel
		TDW		TABA10,SA1				; FM 1ch Table Pointer
		DC.B	0CH,05H				; Bias,Volm

;------------< Table Data >-------------;
TABA10	EQU		*
		DC.B	FEV,0
		DC.B	NL,1,FVR,3,1,9,-1,CS6,025H,VROFF
TA100	EQU		*
		DC.B	TIE,CMVADD,1,GN6,2
		DC.B	CMREPT,0,02AH
		JDW		TA100

		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA1	EQU		*
		dc.b	$3C
		dc.b	$00, $44, $02, $02, 	$1F, $1F, $1F, $15, 	$00, $1F, $00, $00
		dc.b	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$0D, $00, $28, $00
		even

;=======================================;
;				   SA2					;
;=======================================;
SA2:
		TDW		TIMBA2,SA2				; Voice Top Address
		DC.B	1,2						; Base,Use Channel Total

		DC.B	80H,080H					; Flag,Channel
		TDW		TABA20,SA2				; FM 1ch Table Pointer
		DC.B	-12,00H				; Bias,Volm
		
		DC.B	80H,0A0H					; Flag,Channel
		TDW		TABA21,SA2				; FM 1ch Table Pointer
		DC.B	-12,00H				; Bias,Volm

;------------< Table Data >-------------;
TABA20	EQU		*
		DC.B	EV,0
		DC.B	BF3,1,NL,BF3,1,NL,3
TA200	EQU	*
		DC.B	BF3,1,NL,1
		DC.B	CMREPT,0,11
		JDW		TA200
		DC.B	CMEND
		
TABA21	EQU		*
		DC.B	EV,0
		DC.B	NL,1,AF3,NL,AF3,NL,3
TA201	EQU	*
		DC.B	AF3,1,NL,1
		DC.B	CMREPT,0,11
		JDW		TA201
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA2	EQU		*
		even

;=======================================;
;				   SA3					;
;=======================================;
SA3:
		TDW		TIMBA3,SA3				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA30,SA3				; FM 1ch Table Pointer
		DC.B	-12,0					; Bias,Volm

;------------< Table Data >-------------;
TABA30	EQU		*
		DC.B	FEV,0
		DC.B	BN3,7,CMTAB,GS3
TABA31	EQU		*
		DC.B	1,CMVADD,1
		DC.B	CMREPT,0,02FH
		JDW		TABA31
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA3	EQU		*
		dc.b	$30
		dc.b	$30, $30, $30, $30, 	$9E, $D8, $DC, $DC, 	$0E, $0A, $04, $05
		dc.b	$08, $08, $08, $08, 	$BF, $BF, $BF, $BF, 	$14, $3C, $14, $80

		even

;=======================================;
;				   SA4					;
;=======================================;
SA4:
		TDW		TIMBA4,SA4				; Voice Top Address
		DC.B	1,2						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA40,SA4				; FM 1ch Table Pointer
		DC.B	0,0						; Bias,Volm

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABA41,SA4				; FM 1ch Table Pointer
		DC.B	0,0						; Bias,Volm

;------------< Table Data >-------------;
TABA40	EQU		*
		DC.B	FVR,3,1,114,11,FEV,0
		DC.B	AN4,22
		DC.B	CMEND
TABA41	EQU		*
		DC.B	EV,1,CMNOIS,NOIS7
		DC.B	BN3,27
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA4	EQU		*
		dc.b	$3C
		dc.b	$0F, $01, $03, $01, 	$1F, $1F, $1F, $1F, 	$19, $12, $19, $0E
		dc.b	$05, $12, $00, $0F, 	$0F, $7F, $FF, $FF, 	$00, $80, $00, $80

		even

;=======================================;
;				   SA5					;
;=======================================;
SA5:
		TDW		TIMBA5,SA5				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,4				; Flag,Channel
		TDW		TABA50,SA5				; FM 1ch Table Pointer
		DC.B	0,5				; Bias,Volm

;------------< Table Data >-------------;
TABA50	EQU		*
		DC.B	LRPAN,RSET
TBA5	EQU		*
		DC.B	FEV,0
		DC.B	EN5,4,GN5,5,CN6,01BH
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA5	EQU		*
		dc.b	$04
		dc.b	$37, $72, $77, $49, 	$1F, $1F, $1F, $1F, 	$07, $0A, $07, $0D
		dc.b	$00, $0B, $00, $0B, 	$1F, $0F, $1F, $0F, 	$23, $80, $23, $80

		even

;=======================================;
;				   SA6					;
;=======================================;
SA6:
		TDW		TIMBA6,SA6				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5				; Flag,Channel
		TDW		TABA60,SA6				; FM 1ch Table Pointer
		DC.B	0,5				; Bias,Volm

;------------< Table Data >-------------;
TABA60	EQU		*
		DC.B	LRPAN,LSET
		DC.B	CMJUMP
		JDW		TBA5

;------------< Voice Data >-------------;
TIMBA6	EQU		*
		dc.b	$04
		dc.b	$37, $72, $77, $49, 	$1F, $1F, $1F, $1F, 	$07, $0A, $07, $0D
		dc.b	$00, $0B, $00, $0B, 	$1F, $0F, $1F, $0F, 	$23, $80, $23, $80
		
		even

;=======================================;
;				   SA7					;
;=======================================;
SA7:
		TDW		TIMBA7,SA7				; Voice Top Address
		DC.B	1,2						; Base,Use Channel Total

		DC.B	80H,4				; Flag,Channel
		TDW		TABA70,SA7				; FM 1ch Table Pointer
		DC.B	00H,5				; Bias,Volm
		
		DC.B	80H,5				; Flag,Channel
		TDW		TABA71,SA7				; FM 1ch Table Pointer
		DC.B	00H,8				; Bias,Volm

;------------< Table Data >-------------;
TABA70	EQU		*
		DC.B	FEV,0,AN5,2,5,5,5,5,5,5,03AH
		DC.B	CMEND
TABA71	EQU		*
		DC.B	FEV,0,NL,2,GN5,2,5,015H,2,5,032H
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA7	EQU		*
		dc.b	$04
		dc.b	$37, $72, $77, $49, 	$1F, $1F, $1F, $1F, 	$07, $0A, $07, $0D
		dc.b	$00, $0B, $00, $0B, 	$1F, $0F, $1F, $0F, 	$23, $80, $23, $80

		even

;=======================================;
;				   SA8					;
;=======================================;
SA8:
		TDW		TIMBA8,SA8				; Voice Top Address
		DC.B	2,3						; Base,Use Channel Total

		DC.B	80H,4					; Flag,Channel
		TDW		TABA81,SA8				; FM 1ch Table Pointer
		DC.B	25,0					; Bias,Volm

		DC.B	80H,5					; Flag,Channel
		TDW		TABA81,SA8				; FM 1ch Table Pointer
		DC.B	25,4					; Bias,Volm

		DC.B	80H,0A0H				; Flag,Channel
		TDW		TABA80,SA8				; FM 1ch Table Pointer
		DC.B	-0BH,0					; Bias,Volm

;------------< Table Data >-------------;
TABA81	EQU		*
		DC.B	FEV,0,CMGATE,0,CMJUMP
		JDW		TAA82
TABA80	EQU		*
		DC.B	EV,4,CMGATE,0
TAA82	EQU		*
		DC.B	FS4,2,CN5,2,DS5,CS5,DS5
TAA81	EQU		*
		DC.B	FS5,3,CMVADD,1,CMREPT,0,4
		JDW		TAA81
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA8	EQU		*
;-----------< Voice Data 0 >------------;
		DC.B	$01
		DC.B	$B4,$06,$03,$01 
		DC.B	$20,$01,$66,$00
		DC.B	$00,$00,$32,$F4
		DC.B	$11,$00,$9D,$F4
		DC.B	$07,$00,$EB,$E8
		DC.B	$0F,$01,$1E,$E8

		even

;=======================================;
;				   SA9					;
;=======================================;
SA9:
		TDW		TIMBA9,SA9				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABA90,SA9				; FM 1ch Table Pointer
		DC.B	00CH,0					; Bias,Volm

;------------< Table Data >-------------;
TABA90	EQU		*
		DC.B	FEV,0
		DC.B	NL,1
		DC.B	AS2,5,CMTAB,BN2,026H
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBA9	EQU		*
		DC.B	$30
		DC.B	$30, $30, $30, $30, 	$9E, $A8, $AC, $DC, 	$0E, $0A, $04, $05
		DC.B	$08, $08, $08, $08, 	$BF, $BF, $BF, $BF, 	$04, $2C, $14, $80

		even

;=======================================;
;				   SAA					;
;=======================================;
SAA:
		TDW		TIMBAA,SAA				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABAA0,SAA				; FM 1ch Table Pointer
		DC.B	00H,001H				; Bias,Volm

;------------< Table Data >-------------;
TABAA0	EQU		*
		DC.B	AS4,2,NL,8
		DC.B	CMREPT,0,4
		JDW		TABAA0
		DC.B	NL,16
		DC.B	CMREPT,1,9
		JDW		TABAA0
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBAA	EQU		*

		even

;=======================================;
;				   SAB					;
;=======================================;

SAB:
		TDW		TIMAB2,SAB				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,4					; Flag,Channel
		TDW		TABAB0,SAB				; FM 1ch Table Pointer
		DC.B	00H,06H					; Bias,Volm

;------------< Table Data >-------------;

TABAB0	EQU		*
		DC.B	FVR,1,5,156,11,FEV,0
		DC.B	081h,10
TAB0	EQU		*
		DC.B	TIE,CMVADD,4,081h,4
		DC.B	CMREPT,0,8
		JDW		TAB0
		DC.B	CMEND
		
;------------< Voice Data >-------------;

TIMAB2	EQU		*
		CNF		1,4
		MD		3,7,9,5,0,6,1,4
		RSAR	0,31,0,21,0,31,0,20
		D1R		5,20,3,2
		D2R		15,15,15,15
		RRL		15,1,15,2,15,4,15,1
		TL		016H,012H,013H,0

		even

;=======================================;
;				   SAC					;
;=======================================;
SAC:
		TDW		TIMBAC,SAC				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,0A0H				; Flag,Channel
		TDW		TABAC0,SAC				; FM 1ch Table Pointer
		DC.B	000H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABAC0	EQU		*
		DC.B	FVR,1,1,-26,53,CS1,6
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBAC	EQU		*

		even

;=======================================;
;				   SAD					;
;=======================================;
SAD:
		TDW		TIMBAD,SAD				; Voice Top Address
		DC.B	1,4						; Base,Use Channel Total

		DC.B	80H,3					; Flag,Channel
		TDW		TABAD0,SAD				; FM 1ch Table Pointer
		DC.B	10H,000H				; Bias,Volm

		DC.B	80H,4					; Flag,Channel
		TDW		TABAD1,SAD				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

		DC.B	80H,5					; Flag,Channel
		TDW		TABAD2,SAD				; FM 1ch Table Pointer
		DC.B	10H,000H				; Bias,Volm

		DC.B	80H,0C0H				; Flag,Channel
		TDW		TABAD3,SAD				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABAD0	EQU		*
		DC.B	LRPAN,RSET,NL,2,CMJUMP
		JDW		TABAD2
		
TABAD1	EQU		*
		DC.B	LRPAN,LSET,NL,1
TABAD2	EQU		*
		DC.B	FEV,0,FVR,3,1,020H,4
TBAD1	EQU		*
		DC.B	CN0,018H,CMVADD,10,CMREPT,0,6
		JDW		TBAD1
		DC.B	CMEND
TABAD3	EQU		*
		DC.B	FVR,1,1,15,5,CMNOIS,NOIS7
TBAD2	EQU		*
		DC.B	BN3,018H,CMTAB,PVADD,3,CMREPT,0,5
		JDW		TBAD2
		DC.B	CMEND

;------------< Voice Data >-------------;
TIMBAD	EQU		*
		DC.B	$F9
		DC.B	$21, $30, $10, $32, 	$1F, $1F, $1F, $1F, 	$05, $18, $09, $02
		DC.B	$0B, $1F, $10, $05, 	$1F, $2F, $4F, $2F, 	$0E, $07, $04, $80
		even

;=======================================;
;				   SAE					;
;=======================================;
SAE:
		TDW		TIMBAE,SAE				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	80H,5					; Flag,Channel
		TDW		TABAE0,SAE				; FM 1ch Table Pointer
		DC.B	0EH,000H				; Bias,Volm

;------------< Table Data >-------------;
TABAE0	EQU		*
		DC.B	FEV,0,FVR,1,1,033H,018H
		DC.B	AF4,01AH,CMEND

;------------< Voice Data >-------------;
TIMBAE	EQU		*
		DC.B	$3B
		DC.B	$0A, $31, $05, $02, 	$5F, $5F, $5F, $5F, 	$04, $14, $16, $0C
		DC.B	$00, $04, $00, $00, 	$1F, $6F, $D8, $FF, 	$03, $25, $00, $80

		even

;=======================================;
;				   SAF					;
;=======================================;
SAF:
		TDW		TIMBAF,SAF				; Voice Top Address
		DC.B	1,1						; Base,Use Channel Total

		DC.B	080H,5					; Flag,Channel
		TDW		TABAF0,SAF				; FM 1ch Table Pointer
		DC.B	00H,000H				; Bias,Volm

;------------< Table Data >-------------;
TABAF0	EQU		*
		DC.B	FEV,0,AN0,022H,CMEND

;------------< Voice Data >-------------;
TIMBAF	EQU		*
		DC.B	$FA
		DC.B	$21, $30, $10, $32, 	$1F, $1F, $1F, $1F, 	$05, $18, $05, $10
		DC.B	$0B, $1F, $10, $10, 	$1F, $2F, $4F, $2F, 	$0D, $07, $04, $80

; vim: set ft=asm68k sw=4 ts=4 noet:
