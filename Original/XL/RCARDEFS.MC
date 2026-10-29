; Retail bank-9 vehicle definitions, US $09:8134-$09:8B3A.
; Nine records: lookup tables, 37-byte headers, wheel count/parameter,
; 14-byte wheel descriptors, five-byte auxiliary entries and 25 words.
; Shape words remain retail identities; the two internal lookup pointers
; in each parameter block are relocated to these assembled tables.
; Shift thresholds terminate at zero; a reverse torque row precedes each
; forward-gear curve table. Other parameter/auxiliary meanings remain unnamed.
; These records require the retail constructor/layout before live use.
; Parameter words 3/4/5: acceleration, boost and deceleration forces;
; 6/7: brake and coasting drag; 8/9: initial and hard steering steps;
; 10/11/12: normal limit, hard-limit addition and recentering step;
; 15/16: speed-dependent gravity scale and jump force; 19: impact gain;
; 20/21: shift/curve pointers; 22: boost consumption per update.
; 0/1/2: wheel displacement scale, even torque selector and spring limit;
; 13/14: zero-acceleration and front grip gains; 17/18: control grip gains;
; 23/24: skid threshold and post-drive boost torque.
; The wheel stages use a copied 25-word context.

	incpublics	rcardefs.ext

rcardef_shape	macro
	dw	\1,\2
	db	\3
	endm

rcardef_wheel	macro	[word12,x,y,z,word44,word50,word46]
	dw	\1,\2,\3,\4,\5,\6,\7
	endm

rcardef_aux	macro
	db	\1,\2,\3,\4,\5
	endm

rcardefs_begin

; Native definition $81B9; 4 wheels, 4 auxiliary entries.
rcar81b9_shiftpoints
	dw	$0096,$012c,$0190,$01f4,$0226,$0258,$0000
rcar81b9_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar81b9_gearcurves
	geardata	9,40,40,40,40,40,40,40,40,25,25,25,25,25,25,25,25
	geardata	9,70,70,70,70,70,70,70,70,25,25,25,25,25,25,25,25
	geardata	6,40,40,40,40,40,40,40,40,20,20,20,20,20,20,20,20
	geardata	6,30,30,30,30,30,30,30,30,15,15,15,15,15,15,15,15
	geardata	3,20,20,20,20,20,20,20,20,10,10,10,10,10,10,10,10
	geardata	3,10,10,10,10,10,10,10,10,0,0,0,0,0,0,0,0
rcar81b9
rcar81b9_identity	equ	$81b9
	rcardef_shape	$a200,$a7e8,$00
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ffaa,$000a,$0012,$0000,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$003c,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$0400,$0000
	db	4
	dw	$0014
rcar81b9_wheels
	rcardef_wheel	$002d,-110,90,-110,$0400,$02ee,$0009
	rcardef_wheel	$002d,110,90,-110,$0400,$02ee,$0009
	rcardef_wheel	$002d,-110,90,130,$0400,$014a,$0002
	rcardef_wheel	$002d,110,90,130,$0400,$014a,$0002
rcar81b9_aux
	db	4
	rcardef_aux	$75,$00,$e2,$ec,$2d
	rcardef_aux	$75,$00,$1e,$ec,$2d
	rcardef_aux	$51,$00,$00,$1e,$19
	rcardef_aux	$87,$00,$00,$a6,$00
rcar81b9_parms
	dw	$00e6,$0000,$00b4,$0190,$028a
	dw	$012c,$2ee0,$55f0,$0080,$0080
	dw	$0888,$09f4,$0e38,$36b0,$6d60
	dw	$0bb8,$fce0,$0f54,$d720,$4e20
	dw	rcar81b9_shiftpoints&WM,rcar81b9_gearcurves&WM
	dw	$0002,$001e,$012c
rcar81b9_end

; Native definition $82E5; 4 wheels, 4 auxiliary entries.
rcar82e5_shiftpoints
	dw	$0096,$012c,$01f4,$0226,$0258,$0000,$0000
rcar82e5_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar82e5_gearcurves
	geardata	9,90,90,90,90,90,90,90,90,60,60,60,60,60,60,60,60
	geardata	9,70,70,70,70,70,70,70,70,45,45,45,45,45,45,45,45
	geardata	12,60,60,60,60,60,60,60,60,30,30,30,30,30,30,30,30
	geardata	3,40,40,40,40,40,40,40,40,20,20,20,20,20,20,20,20
	geardata	3,20,20,20,20,20,20,20,20,3,3,3,3,3,3,3,3
	geardata	1,5,5,5,5,5,5,5,5,0,0,0,0,0,0,0,0
rcar82e5
rcar82e5_identity	equ	$82e5
	rcardef_shape	$a2fc,$a900,$02
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ff5a,$0024,$0012,$4010,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$00c8,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$1000,$0000
	db	4
	dw	$0014
rcar82e5_wheels
	rcardef_wheel	$0036,0,140,-170,$04b0,$044c,$0080
	rcardef_wheel	$0036,0,160,190,$04b0,$0258,$000a
	rcardef_wheel	$0000,120,140,-150,$04b0,$044c,$0009
	rcardef_wheel	$0000,-120,140,-150,$04b0,$044c,$0009
rcar82e5_aux
	db	4
	rcardef_aux	$75,$00,$e2,$c9,$0a
	rcardef_aux	$75,$00,$1e,$c9,$0a
	rcardef_aux	$63,$00,$00,$50,$19
	rcardef_aux	$87,$00,$00,$a6,$00
rcar82e5_parms
	dw	$00e6,$0000,$0078,$00aa,$0118
	dw	$00c8,$2328,$7d00,$016c,$016c
	dw	$0888,$0f6e,$4000,$18f0,$61a8
	dw	$0064,$fc18,$4ca4,$0cc6,$4844
	dw	rcar82e5_shiftpoints&WM,rcar82e5_gearcurves&WM
	dw	$0001,$0064,$0258
rcar82e5_end

; Native definition $8411; 4 wheels, 4 auxiliary entries.
rcar8411_shiftpoints
	dw	$0064,$00c8,$012c,$0190,$0258,$0000,$0000
rcar8411_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar8411_gearcurves
	geardata	6,100,100,100,100,100,100,100,100,60,60,60,60,60,60,60,60
	geardata	6,40,40,40,40,40,40,40,40,20,20,20,20,20,20,20,20
	geardata	6,25,25,25,25,25,25,25,25,10,10,10,10,10,10,10,10
	geardata	6,20,20,20,20,20,20,20,20,5,5,5,5,5,5,5,5
	geardata	12,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0
	geardata	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
rcar8411
rcar8411_identity	equ	$8411
	rcardef_shape	$a28c,$a820,$03
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ff56,$0010,$0012,$0010,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$00f0,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$1000,$0000
	db	4
	dw	$0014
rcar8411_wheels
	rcardef_wheel	$0036,110,180,-150,$0100,$0320,$0109
	rcardef_wheel	$0036,-110,180,-150,$0100,$0320,$0109
	rcardef_wheel	$0036,-110,180,130,$0100,$0190,$010a
	rcardef_wheel	$0036,110,180,130,$0100,$0190,$010a
rcar8411_aux
	db	4
	rcardef_aux	$75,$00,$dd,$d0,$4b
	rcardef_aux	$75,$00,$23,$d0,$4b
	rcardef_aux	$6c,$00,$00,$53,$19
	rcardef_aux	$87,$00,$00,$a6,$00
rcar8411_parms
	dw	$00b4,$0000,$0078,$0140,$0320
	dw	$005a,$1f40,$7530,$00b6,$0222
	dw	$05b0,$0e38,$4000,$18f0,$2710
	dw	$0001,$fd44,$198c,$d34b,$4268
	dw	rcar8411_shiftpoints&WM,rcar8411_gearcurves&WM
	dw	$0001,$001e,$0258
rcar8411_end

; Native definition $853D; 4 wheels, 4 auxiliary entries.
rcar853d_shiftpoints
	dw	$0096,$012c,$0190,$01f4,$0258,$0000,$0000
rcar853d_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar853d_gearcurves
	geardata	9,80,80,80,80,80,80,80,80,20,20,20,20,20,20,20,20
	geardata	9,30,30,30,30,30,30,30,30,15,15,15,15,15,15,15,15
	geardata	6,20,20,20,20,20,20,20,20,10,10,10,10,10,10,10,10
	geardata	6,20,20,20,20,20,20,20,20,5,5,5,5,5,5,5,5
	geardata	6,5,5,5,5,5,5,5,5,0,0,0,0,0,0,0,0
	geardata	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
rcar853d
rcar853d_identity	equ	$853d
	rcardef_shape	$a2a8,$a804,$01
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ffc0,$0010,$0012,$0000,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$003c,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$0400,$0000
	db	4
	dw	$0014
rcar853d_wheels
	rcardef_wheel	$0024,-100,80,-130,$0400,$02bc,$0001
	rcardef_wheel	$0024,100,80,130,$0400,$015e,$000a
	rcardef_wheel	$0024,100,80,-130,$0400,$02bc,$0001
	rcardef_wheel	$0024,-100,80,130,$0400,$015e,$000a
rcar853d_aux
	db	4
	rcardef_aux	$75,$00,$e2,$ec,$2d
	rcardef_aux	$75,$00,$1e,$ec,$2d
	rcardef_aux	$5a,$00,$00,$22,$19
	rcardef_aux	$87,$00,$00,$a6,$00
rcar853d_parms
	dw	$00e6,$0000,$003c,$0190,$0320
	dw	$00c8,$2328,$4e20,$016c,$00f6
	dw	$05b0,$0b60,$4000,$2ee0,$2710
	dw	$0190,$fda8,$1fef,$ecd7,$4844
	dw	rcar853d_shiftpoints&WM,rcar853d_gearcurves&WM
	dw	$0001,$0000,$0000
rcar853d_end

; Native definition $8669; 5 wheels, 1 auxiliary entries.
rcar8669_shiftpoints
	dw	$0064,$00c8,$012c,$01f4,$0226,$0258,$0000
rcar8669_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar8669_gearcurves
	geardata	6,60,60,60,60,60,60,60,60,30,30,30,30,30,30,30,30
	geardata	6,40,40,40,40,40,40,40,40,20,20,20,20,20,20,20,20
	geardata	6,30,30,30,30,30,30,30,30,10,10,10,10,10,10,10,10
	geardata	12,15,15,15,15,15,15,15,15,0,0,0,0,0,0,0,0
	geardata	3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	geardata	3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
rcar8669
rcar8669_identity	equ	$8669
	rcardef_shape	$a778,$a778,$00
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ff7e,$0000,$0012,$0400,$8407
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$0190,$0190
	dw	$002c,$0070,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$6400,$0000
	db	5
	dw	$8016
rcar8669_wheels
	rcardef_wheel	$0000,200,150,600,$0200,$03e8,$0002
	rcardef_wheel	$0000,-200,150,600,$0200,$03e8,$0002
	rcardef_wheel	$0048,200,150,-600,$0200,$07d0,$0009
	rcardef_wheel	$0048,-200,150,-600,$0200,$07d0,$0009
	rcardef_wheel	$0000,0,0,1600,$0400,$0000,$0001
rcar8669_aux
	db	1
	rcardef_aux	$09,$00,$00,$00,$78
rcar8669_parms
	dw	$0064,$0006,$0000,$012c,$02bc
	dw	$00c8,$7530,$7d00,$01ec,$00b6
	dw	$0ccc,$0fa4,$038e,$4000,$2710
	dw	$2000,$0000,$1fef,$0000,$0000
	dw	rcar8669_shiftpoints&WM,rcar8669_gearcurves&WM
	dw	$0002,$0064,$0000
rcar8669_end

; Native definition $876E; 4 wheels, 0 auxiliary entries.
rcar876e_shiftpoints
	dw	$00c8,$0190,$0258,$02bc,$0000
rcar876e_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar876e_gearcurves
	geardata	12,70,70,70,70,70,70,70,70,50,50,50,50,50,50,50,50
	geardata	12,80,80,80,80,80,80,80,80,50,50,50,50,50,50,50,50
	geardata	12,70,70,70,70,70,70,70,70,50,50,50,50,50,50,50,50
	geardata	6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
rcar876e
rcar876e_identity	equ	$876e
	rcardef_shape	$a7e8,$a7e8,$00
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ffa6,$0000,$0012,$0000,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$0190,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$0400,$0000
	db	4
	dw	$0014
rcar876e_wheels
	rcardef_wheel	$002d,-110,100,130,$0400,$0320,$0002
	rcardef_wheel	$002d,110,100,130,$0400,$0320,$0002
	rcardef_wheel	$002d,-110,100,-110,$0400,$03e8,$0009
	rcardef_wheel	$002d,110,100,-110,$0400,$03e8,$0009
rcar876e_aux
	db	0
rcar876e_parms
	dw	$00e6,$0000,$003c,$01f4,$02ee
	dw	$0190,$2ee0,$7530,$016c,$0318
	dw	$0b60,$0d4c,$4000,$3e80,$4e20
	dw	$1f40,$fed4,$1fef,$0000,$4e20
	dw	rcar876e_shiftpoints&WM,rcar876e_gearcurves&WM
	dw	$0000,$01f4,$0000
rcar876e_end

; Native definition $8886; 3 wheels, 0 auxiliary entries.
rcar8886_shiftpoints
	dw	$0096,$012c,$0190,$0258,$0000,$0000,$0000
rcar8886_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar8886_gearcurves
	geardata	9,90,90,90,90,90,90,90,90,60,60,60,60,60,60,60,60
	geardata	9,70,70,70,70,70,70,70,70,45,45,45,45,45,45,45,45
	geardata	6,60,60,60,60,60,60,60,60,30,30,30,30,30,30,30,30
	geardata	12,40,40,40,40,40,40,40,40,0,0,0,0,0,0,0,0
	geardata	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	geardata	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
rcar8886
rcar8886_identity	equ	$8886
	rcardef_shape	$a820,$a820,$02
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ff38,$0000,$0012,$4010,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$0190,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$1000,$0000
	db	3
	dw	$0014
rcar8886_wheels
	rcardef_wheel	$0036,0,160,190,$04b0,$01f4,$000a
	rcardef_wheel	$002d,120,140,-150,$04b0,$03e8,$0009
	rcardef_wheel	$002d,-120,140,-150,$04b0,$03e8,$0009
rcar8886_aux
	db	0
rcar8886_parms
	dw	$00e6,$0000,$0078,$0258,$0320
	dw	$00c8,$0bb8,$7d00,$022c,$040e
	dw	$0a34,$0a74,$4000,$18f0,$6000
	dw	$00c0,$fda8,$1fef,$0000,$4844
	dw	rcar8886_shiftpoints&WM,rcar8886_gearcurves&WM
	dw	$0000,$01f4,$0000
rcar8886_end

; Native definition $8990; 4 wheels, 0 auxiliary entries.
rcar8990_shiftpoints
	dw	$00c8,$012c,$0190,$01c2,$0258,$0000,$0000
rcar8990_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar8990_gearcurves
	geardata	12,60,60,60,60,60,60,60,60,40,40,40,40,40,40,40,40
	geardata	6,60,60,60,60,60,60,60,60,30,30,30,30,30,30,30,30
	geardata	6,30,30,30,30,30,30,30,30,8,8,8,8,8,8,8,8
	geardata	3,6,6,6,6,6,6,6,6,0,0,0,0,0,0,0,0
	geardata	9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	geardata	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
rcar8990
rcar8990_identity	equ	$8990
	rcardef_shape	$a820,$a820,$03
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ff4c,$0020,$0012,$0010,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$0190,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$1000,$0000
	db	4
	dw	$0014
rcar8990_wheels
	rcardef_wheel	$0036,110,180,-150,$0320,$03e8,$0109
	rcardef_wheel	$0036,-110,180,-150,$0320,$03e8,$0109
	rcardef_wheel	$0036,-110,180,130,$0320,$0190,$010a
	rcardef_wheel	$0036,110,180,130,$0320,$0190,$010a
rcar8990_aux
	db	0
rcar8990_parms
	dw	$00b4,$0000,$0078,$00b4,$00e6
	dw	$00c8,$2328,$6d60,$038e,$040e
	dw	$0e38,$0c16,$4000,$4a38,$7530
	dw	$07d0,$fed4,$1fef,$0000,$4268
	dw	rcar8990_shiftpoints&WM,rcar8990_gearcurves&WM
	dw	$0000,$09c4,$0000
rcar8990_end

; Native definition $8AA8; 4 wheels, 0 auxiliary entries.
rcar8aa8_shiftpoints
	dw	$0096,$012c,$0190,$01f4,$0258,$0000,$0000
rcar8aa8_reversecurve
	geardata	25,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5,0
rcar8aa8_gearcurves
	geardata	9,60,60,60,60,60,60,60,60,30,30,30,30,30,30,30,30
	geardata	9,60,60,60,60,60,60,60,60,25,25,25,25,25,25,25,25
	geardata	6,25,25,25,25,25,25,25,25,10,10,10,10,10,10,10,10
	geardata	6,10,10,10,10,10,10,10,10,5,5,5,5,5,5,5,5
	geardata	6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	geardata	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
rcar8aa8
rcar8aa8_identity	equ	$8aa8
	rcardef_shape	$a804,$a804,$01
; Header +05/+07/+09, flags +0B/+0D and frame +0F.
	dw	$0000,$ffbc,$0000,$0012,$0000,$0505
; Bounds +11/+13/+15; five constructor-skipped words +17..+1F.
	dw	$0190,$0190,$0190
	dw	$002c,$004e,$008a,$002c,$000a
; Object words +21/+23; wheel count and shared wheel word.
	dw	$0400,$0000
	db	4
	dw	$0014
rcar8aa8_wheels
	rcardef_wheel	$0024,-110,80,-110,$0400,$02ee,$0001
	rcardef_wheel	$0024,110,80,-110,$0400,$02ee,$0001
	rcardef_wheel	$0024,110,80,130,$0400,$0258,$000a
	rcardef_wheel	$0024,-110,80,130,$0400,$0258,$000a
rcar8aa8_aux
	db	0
rcar8aa8_parms
	dw	$00e6,$0000,$003c,$014a,$015e
	dw	$00c8,$1f40,$7530,$0222,$040e
	dw	$0aaa,$0d0c,$4000,$2ee0,$61a8
	dw	$0bb8,$fed4,$1fef,$0000,$4844
	dw	rcar8aa8_shiftpoints&WM,rcar8aa8_gearcurves&WM
	dw	$0000,$01f4,$0000
rcar8aa8_end
rcardefs_end

