; Retail raw-car lifetime, player/grid setup and camera controllers.
; A8/I16, D=0, DB=$7E and binary arithmetic unless an entry states otherwise.
; Use initialized raw heaps, compiled definitions and a valid packed route.
; These camera entries use the raw-car ABI and general actor activity byte;
; surviving early camera entries remain available to early-layout callers.
; Shape/header words remain retail asset identities for caller binding.
; The early active dispatcher is unchanged. Fatal entries do not return.
	incpublics	mrlife.ext
mrlife_begin
	longa
	longi
retail_fatalcar_l
	ai16
rlf_008016
	lda #$7fff
rlf_008019
	sta.w race_errorcolor
rlf_00801c
	ldx #$00aa
rlf_00801f
	bra rlf_00805c
	longa
	longi
retail_fatal1_l
	ai16
rlf_008023
	lda #$7c1f
rlf_008026
	sta.w race_errorcolor
rlf_008029
	ldx #$00ba
rlf_00802c
	bra rlf_00805c
	longa
	longi
retail_fatal2_l
	ai16
rlf_008030
	lda #$03ff
rlf_008033
	sta.w race_errorcolor
rlf_008036
	ldx #$00ba
rlf_008039
	bra rlf_00805c
	longa
	longi
retail_fatal3_l
	ai16
rlf_00803d
	lda #$7fe0
rlf_008040
	sta.w race_errorcolor
rlf_008043
	ldx #$00c9
rlf_008046
	bra rlf_00805c
	longa
	longi
retail_fatal4_l
	ai16
rlf_00804a
	lda #$03e0
rlf_00804d
	sta.w race_errorcolor
rlf_008050
	ldx #$00e2
rlf_008053
	bra rlf_00805c
	shorta
	longi
retail_fatal5_l
	i16
rlf_008057
	ldx #$00d9
rlf_00805a
	bra rlf_00805c
rlf_00805c
	stx.w race_errortarget
rlf_00805f
	a8
rlf_008061
	stz.w $4200
rlf_008064
	stz.w $420c
rlf_008067
	sei
rlf_008068
	stz.w $212c
rlf_00806b
	stz.w $212d
rlf_00806e
	lda #$00
rlf_008070
	pha
rlf_008071
	plb
rlf_008072
	a8
rlf_008074
	i16
rlf_008076
	lda #$80
rlf_008078
	sta.w $2100
rlf_00807b
	stz.w $2121
rlf_00807e
	lda.w race_errorcolor
rlf_008081
	sta.w $2122
rlf_008084
	lda.w race_errorcolor+1
rlf_008087
	sta.w $2122
rlf_00808a
	lda #$40
rlf_00808c
	sta.w $2107
rlf_00808f
	lda #$00
rlf_008091
	sta.w $210b
rlf_008094
	stz.w $2123
rlf_008097
	stz.w $2124
rlf_00809a
	stz.w $2125
rlf_00809d
	stz.w $212a
rlf_0080a0
	stz.w $212b
rlf_0080a3
	stz.w $212e
rlf_0080a6
	stz.w $212f
rlf_0080a9
	stz.w $2126
rlf_0080ac
	stz.w $2127
rlf_0080af
	lda #$01
rlf_0080b1
	sta.w $2105
rlf_0080b4
	lda #$01
rlf_0080b6
	sta.w $212c
rlf_0080b9
	stz.w $212d
rlf_0080bc
	stz.w $2131
rlf_0080bf
	stz.w $2132
rlf_0080c2
	stz.w $4310
rlf_0080c5
	lda #$00
rlf_0080c7
	sta.w $4311
rlf_0080ca
	lda #retail_fatalhdma>>16
rlf_0080cc
	sta.w $4314
rlf_0080cf
	ldx #retail_fatalhdma&WM
rlf_0080d2
	stx.w $4312
rlf_0080d5
	stz.w $4317
rlf_0080d8
	stz.w $210e
rlf_0080db
	stz.w $210e
rlf_0080de
	lda #$f9
rlf_0080e0
	sta.w $210d
rlf_0080e3
	lda #$ff
rlf_0080e5
	sta.w $210d
rlf_0080e8
	lda #$0f
rlf_0080ea
	sta.w $2100
rlf_0080ed
	lda #$02
rlf_0080ef
	sta.w $420c
rlf_0080f2
	i16
rlf_0080f4
	ldy #$4e20
rlf_0080f7
	dey
rlf_0080f8
	bne rlf_0080f7
rlf_0080fa
	a16
rlf_0080fc
	lda.w race_errortarget
rlf_0080ff
	cmp.w race_errorpos
rlf_008102
	beq retail_fatalhalt
rlf_008104
	sec
rlf_008105
	sbc.w race_errorpos
rlf_008108
	lsr a
rlf_008109
	lsr a
rlf_00810a
	lsr a
rlf_00810b
	bne rlf_008110
rlf_00810d
	lda #$0001
rlf_008110
	clc
rlf_008111
	adc.w race_errorpos
rlf_008114
	sta.w race_errorpos
rlf_008117
	a8
rlf_008119
	lda.w race_errorpos
rlf_00811c
	sta.w $210e
rlf_00811f
	lda.w race_errorpos+1
rlf_008122
	sta.w $210e
rlf_008125
	lda #$03
rlf_008127
	sta.w $2140
rlf_00812a
	bra rlf_0080f4
retail_fatalhalt
	bra retail_fatalhalt
	longa
	longi
retail_easeactor32_l
	cmp tpx
rlf_03cec5
	bne rlf_03cecb
rlf_03cec7
	jml rsc_easereturn+4
rlf_03cecb
	sec
rlf_03cecc
	sbc tpx
rlf_03cece
	cmp #$0000
rlf_03ced1
	bmi rlf_03cedd
rlf_03ced3
	cmp #$0020
rlf_03ced6
	bpl rlf_03cee5
rlf_03ced8
	lda #$0020
rlf_03cedb
	bra rlf_03cee5
rlf_03cedd
	cmp #$ffe0
rlf_03cee0
	bmi rlf_03cee5
rlf_03cee2
	lda #$ffe0
rlf_03cee5
	cmp #$8000
rlf_03cee8
	ror a
rlf_03cee9
	bpl rlf_03ceee
rlf_03ceeb
	adc #$0000
rlf_03ceee
	cmp #$8000
rlf_03cef1
	ror a
rlf_03cef2
	bpl rlf_03cef7
rlf_03cef4
	adc #$0000
rlf_03cef7
	cmp #$8000
rlf_03cefa
	ror a
rlf_03cefb
	bpl rlf_03cf00
rlf_03cefd
	adc #$0000
rlf_03cf00
	cmp #$8000
rlf_03cf03
	ror a
rlf_03cf04
	bpl rlf_03cf09
rlf_03cf06
	adc #$0000
rlf_03cf09
	cmp #$8000
rlf_03cf0c
	ror a
rlf_03cf0d
	bpl rlf_03cf12
rlf_03cf0f
	adc #$0000
rlf_03cf12
	clc
rlf_03cf13
	adc tpx
rlf_03cf15
	sta tpx
rlf_03cf17
	jml rsc_easereturn
	longa
	longi
retail_easeactor64_l
	cmp tpx
rlf_03cf1c
	bne rlf_03cf22
rlf_03cf1e
	jml rsc_easereturn+4
rlf_03cf22
	sec
rlf_03cf23
	sbc tpx
rlf_03cf25
	cmp #$0000
rlf_03cf28
	bmi rlf_03cf34
rlf_03cf2a
	cmp #$0040
rlf_03cf2d
	bpl rlf_03cf3c
rlf_03cf2f
	lda #$0040
rlf_03cf32
	bra rlf_03cf3c
rlf_03cf34
	cmp #$ffc0
rlf_03cf37
	bmi rlf_03cf3c
rlf_03cf39
	lda #$ffc0
rlf_03cf3c
	cmp #$8000
rlf_03cf3f
	ror a
rlf_03cf40
	bpl rlf_03cf45
rlf_03cf42
	adc #$0000
rlf_03cf45
	cmp #$8000
rlf_03cf48
	ror a
rlf_03cf49
	bpl rlf_03cf4e
rlf_03cf4b
	adc #$0000
rlf_03cf4e
	cmp #$8000
rlf_03cf51
	ror a
rlf_03cf52
	bpl rlf_03cf57
rlf_03cf54
	adc #$0000
rlf_03cf57
	cmp #$8000
rlf_03cf5a
	ror a
rlf_03cf5b
	bpl rlf_03cf60
rlf_03cf5d
	adc #$0000
rlf_03cf60
	cmp #$8000
rlf_03cf63
	ror a
rlf_03cf64
	bpl rlf_03cf69
rlf_03cf66
	adc #$0000
rlf_03cf69
	cmp #$8000
rlf_03cf6c
	ror a
rlf_03cf6d
	bpl rlf_03cf72
rlf_03cf6f
	adc #$0000
rlf_03cf72
	clc
rlf_03cf73
	adc tpx
rlf_03cf75
	sta tpx
rlf_03cf77
	jml rsc_easereturn
	shorta
	longi
retail_bindcarcamera_l
	a16
rlf_088527
	tya
rlf_088528
	sta.w al_viewpt,x
rlf_08852b
	lda.w al_viewpt,y
rlf_08852e
	sta.w race_visualoffset
rlf_088531
	lda.w al_stratptr,y
rlf_088534
	sta.w race_callback
rlf_088537
	txa
rlf_088538
	sta.w al_ptr,y
rlf_08853b
	ldy.w race_visualoffset
rlf_08853e
	txa
rlf_08853f
	sta.w $0002,y
rlf_088542
	phx
rlf_088543
	lda.l m_retailarg4
rlf_088547
	tax
rlf_088548
	lda.w race_callback
rlf_08854b
	cmp #retail_introcamera_l&WM
rlf_08854e
	beq rlf_08857f
rlf_088550
	lda.w race_scenephase
rlf_088553
	and #$00ff
rlf_088556
	cmp #$0001
rlf_088559
	beq rlf_088577
rlf_08855b
	cmp #$0002
rlf_08855e
	beq rlf_088567
rlf_088560
	cmp #$0003
rlf_088563
	beq rlf_08856f
rlf_088565
	bra rlf_088585
rlf_088567
	txa
rlf_088568
	clc
rlf_088569
	adc #$0008
rlf_08856c
	tax
rlf_08856d
	bra rlf_088585
rlf_08856f
	txa
rlf_088570
	clc
rlf_088571
	adc #$0006
rlf_088574
	tax
rlf_088575
	bra rlf_088585
rlf_088577
	txa
rlf_088578
	clc
rlf_088579
	adc #$0004
rlf_08857c
	tax
rlf_08857d
	bra rlf_088585
	longa
	longi
rlf_08857f
	txa
rlf_088580
	clc
rlf_088581
	adc #$0002
rlf_088584
	tax
rlf_088585
; Constructor offset selects five words inside the vehicle definition;
; their values remain offsets into the shared camera preset table.
	lda.l rcardefs_begin-$a4,x
rlf_088589
	sta.w $0032,y
rlf_08858c
	plx
rlf_08858d
	lda #$0000
rlf_088590
	sta.w $0035,y
rlf_088593
	sta.w $0037,y
rlf_088596
	sta.w $0039,y
rlf_088599
	sta.w $0026,y
rlf_08859c
	sta.w $0028,y
rlf_08859f
	sta.w $002a,y
rlf_0885a2
	sta.w $002c,y
rlf_0885a5
	sta.w $002e,y
rlf_0885a8
	sta.w $0030,y
rlf_0885ab
	lda #$0005
rlf_0885ae
	sta.w $0000,y
rlf_0885b1
	a8
rlf_0885b3
	lda #$00
rlf_0885b5
	sta.w $0034,y
rlf_0885b8
	rtl
	shorta
	longi
retail_setcameraanim_l
	a16
rlf_0888c9
	tya
rlf_0888ca
	sec
rlf_0888cb
	sbc #viewanimtab&WM
rlf_0888ce
	sta.w al_sword2,x
rlf_0888d1
	a8
rlf_0888d3
	jsl retail_nextcameraanim_l
rlf_0888d7
	rtl
retail_nextcameraanim_l
	phx
rlf_0888d9
	a16
rlf_0888db
	txy
rlf_0888dc
	lda.w al_sword2,x
rlf_0888df
	tax
rlf_0888e0
	lda.l viewanimtab,x
rlf_0888e4
	cmp #$0003
rlf_0888e7
	beq rlf_0888f8
rlf_0888e9
	cmp #$0001
rlf_0888ec
	beq rlf_088952
rlf_0888ee
	cmp #$0002
rlf_0888f1
	beq rlf_08893a
rlf_0888f3
	tyx
rlf_0888f4
	sec
rlf_0888f5
	jmp rlf_0889e2
rlf_0888f8
	phy
rlf_0888f9
	phx
rlf_0888fa
	tyx
rlf_0888fb
	ldy.w al_viewpt,x
rlf_0888fe
	plx
rlf_0888ff
	lda.l viewanimtab+2,x
rlf_088903
	sta.w $0020,y
rlf_088906
	sta.w $001a,y
rlf_088909
	lda.l viewanimtab+4,x
rlf_08890d
	sta.w $0022,y
rlf_088910
	sta.w $001c,y
rlf_088913
	lda.l viewanimtab+6,x
rlf_088917
	sta.w $0024,y
rlf_08891a
	sta.w $001e,y
rlf_08891d
	ply
rlf_08891e
	lda #$0000
rlf_088921
	sta.w al_vx,y
rlf_088924
	sta.w al_vy,y
rlf_088927
	sta.w al_vz,y
rlf_08892a
	sta.w al_sword1,y
rlf_08892d
	lda.w al_sword2,y
rlf_088930
	clc
rlf_088931
	adc #$0008
rlf_088934
	sta.w al_sword2,y
rlf_088937
	jmp rlf_0889e1
rlf_08893a
	lda.l viewanimtab+2,x
rlf_08893e
	tyx
rlf_08893f
	ldy.w al_viewpt,x
rlf_088942
	sta.w $0000,y
rlf_088945
	lda.w al_sword2,x
rlf_088948
	clc
rlf_088949
	adc #$0004
rlf_08894c
	sta.w al_sword2,x
rlf_08894f
	jmp rlf_0889e1
rlf_088952
	phy
rlf_088953
	lda.l viewanimtab+2,x
rlf_088957
	and #$00ff
rlf_08895a
	sta.w al_sword1,y
rlf_08895d
	phx
rlf_08895e
	tyx
rlf_08895f
	ldy.w al_viewpt,x
rlf_088962
	plx
rlf_088963
	lda.l viewanimtab+3,x
rlf_088967
	and #$00ff
rlf_08896a
	sta.w race_callback
rlf_08896d
	lda.l viewanimtab+4,x
rlf_088971
	sec
rlf_088972
	sbc.w $0020,y
rlf_088975
	sta.w race_visualoffset
rlf_088978
	lda.l viewanimtab+6,x
rlf_08897c
	sec
rlf_08897d
	sbc.w $0022,y
rlf_088980
	sta.w race_visualowner
rlf_088983
	lda.l viewanimtab+8,x
rlf_088987
	sec
rlf_088988
	sbc.w $0024,y
rlf_08898b
	sta.w race_visualsize
rlf_08898e
	plx
rlf_08898f
	ldy.w race_callback
rlf_088992
	iny
rlf_088993
	dey
rlf_088994
	beq rlf_0889c5
rlf_088996
	lda.w race_visualoffset
rlf_088999
	cmp #$8000
rlf_08899c
	ror a
rlf_08899d
	bpl rlf_0889a2
rlf_08899f
	adc #$0000
rlf_0889a2
	sta.w race_visualoffset
rlf_0889a5
	lda.w race_visualowner
rlf_0889a8
	cmp #$8000
rlf_0889ab
	ror a
rlf_0889ac
	bpl rlf_0889b1
rlf_0889ae
	adc #$0000
rlf_0889b1
	sta.w race_visualowner
rlf_0889b4
	lda.w race_visualsize
rlf_0889b7
	cmp #$8000
rlf_0889ba
	ror a
rlf_0889bb
	bpl rlf_0889c0
rlf_0889bd
	adc #$0000
rlf_0889c0
	sta.w race_visualsize
rlf_0889c3
	bra rlf_088993
rlf_0889c5
	lda.w race_visualoffset
rlf_0889c8
	sta.w al_vx,x
rlf_0889cb
	lda.w race_visualowner
rlf_0889ce
	sta.w al_vy,x
rlf_0889d1
	lda.w race_visualsize
rlf_0889d4
	sta.w al_vz,x
rlf_0889d7
	lda.w al_sword2,x
rlf_0889da
	clc
rlf_0889db
	adc #$000a
rlf_0889de
	sta.w al_sword2,x
rlf_0889e1
	clc
rlf_0889e2
	a8
rlf_0889e4
	plx
rlf_0889e5
	rtl
retail_cameraanim_l
	ldy.w al_viewpt,x
rlf_0889e9
	a16
rlf_0889eb
	lda.w $001a,y
rlf_0889ee
	sta tpx
rlf_0889f0
	lda.w $0020,y
rlf_0889f3
	jsl retail_easeactor8_l
rlf_0889f7
	sta.w $001a,y
rlf_0889fa
	a8
rlf_0889fc
	a16
rlf_0889fe
	lda.w $001c,y
rlf_088a01
	sta tpx
rlf_088a03
	lda.w $0022,y
rlf_088a06
	jsl retail_easeactor8_l
rlf_088a0a
	sta.w $001c,y
rlf_088a0d
	a8
rlf_088a0f
	a16
rlf_088a11
	lda.w $001e,y
rlf_088a14
	sta tpx
rlf_088a16
	lda.w $0024,y
rlf_088a19
	jsl retail_easeactor8_l
rlf_088a1d
	sta.w $001e,y
rlf_088a20
	a8
rlf_088a22
	a16
rlf_088a24
	lda.w al_sword1,x
rlf_088a27
	beq rlf_088a4f
rlf_088a29
	dec a
rlf_088a2a
	sta.w al_sword1,x
rlf_088a2d
	lda.w al_vx,x
rlf_088a30
	clc
rlf_088a31
	adc.w $0020,y
rlf_088a34
	sta.w $0020,y
rlf_088a37
	lda.w al_vy,x
rlf_088a3a
	clc
rlf_088a3b
	adc.w $0022,y
rlf_088a3e
	sta.w $0022,y
rlf_088a41
	lda.w al_vz,x
rlf_088a44
	clc
rlf_088a45
	adc.w $0024,y
rlf_088a48
	sta.w $0024,y
rlf_088a4b
	a8
rlf_088a4d
	bra rlf_088a57
rlf_088a4f
	a8
rlf_088a51
	jsl retail_nextcameraanim_l
rlf_088a55
	bcs rlf_088a58
rlf_088a57
	clc
rlf_088a58
	rtl
	shorta
	longi
retail_roadcamera_l
	phx
rlf_088c9a
	ldy.w al_ptr,x
rlf_088c9d
	a16
rlf_088c9f
	lda.w al_collobjptr,y
rlf_088ca2
	tax
rlf_088ca3
	lda.l $700058,x
rlf_088ca7
	plx
rlf_088ca8
	jsl retail_nextroute_l
rlf_088cac
	jsl retail_nextroute_l
rlf_088cb0
	sta.w race_scratch
rlf_088cb3
	jsl retail_routeposition_l
rlf_088cb7
	ldy.w al_viewpt,x
rlf_088cba
	lda.w race_callback
rlf_088cbd
	clc
rlf_088cbe
	adc #$03e8
rlf_088cc1
	sta.w $0008,y
rlf_088cc4
	lda.w race_visualoffset
rlf_088cc7
	clc
rlf_088cc8
	adc #$fe0c
rlf_088ccb
	sta.w $000a,y
rlf_088cce
	lda.w race_visualowner
rlf_088cd1
	clc
rlf_088cd2
	adc #$03e8
rlf_088cd5
	sta.w $000c,y
rlf_088cd8
	a8
rlf_088cda
	a16
rlf_088cdc
	lda #retail_roadcamera_step&WM
rlf_088cdf
	sta.w al_stratptr,x
rlf_088ce2
	a8
rlf_088ce4
	lda #retail_roadcamera_step>>16
rlf_088ce6
	sta.w al_stratptr+2,x
rlf_088ce9
	ldy.w al_viewpt,x
rlf_088cec
	a16
rlf_088cee
	lda #$0003
rlf_088cf1
	sta.w $0000,y
rlf_088cf4
	a8
rlf_088cf6
	a16
rlf_088cf8
	lda.l m_viewroadflags
rlf_088cfc
	and #$fffe
rlf_088cff
	sta.l m_viewroadflags
rlf_088d03
	a8
rlf_088d05
	a16
rlf_088d07
	lda #$0000
rlf_088d0a
	sta.w al_sword1,x
rlf_088d0d
	a8
rlf_088d0f
	a16
rlf_088d11
	lda #$0000
rlf_088d14
	sta.w al_vx,x
rlf_088d17
	a8
rlf_088d19
	a16
rlf_088d1b
	lda #$0000
rlf_088d1e
	sta.w al_vy,x
rlf_088d21
	a8
rlf_088d23
	a16
rlf_088d25
	lda #$0000
rlf_088d28
	sta.w al_vz,x
rlf_088d2b
	a8
retail_roadcamera_step
	phx
rlf_088d2e
	ldy.w al_ptr,x
rlf_088d31
	a16
rlf_088d33
	lda.w al_collobjptr,y
rlf_088d36
	tax
rlf_088d37
	lda.l $700058,x
rlf_088d3b
	plx
rlf_088d3c
	cmp #$0000
rlf_088d3f
	bne rlf_088d44
rlf_088d41
	brl rlf_088df4
rlf_088d44
	ldy.w al_viewpt,x
rlf_088d47
	cmp.w $0004,y
rlf_088d4a
	bne rlf_088d4f
rlf_088d4c
	brl rlf_088df4
rlf_088d4f
	bit #$0003
rlf_088d52
	beq rlf_088d57
rlf_088d54
	brl rlf_088df4
rlf_088d57
	sta.w $0004,y
rlf_088d5a
	jsl retail_nextroute_l
rlf_088d5e
	sta.w race_scratch
rlf_088d61
	jsl retail_routeposition_l
rlf_088d65
	ldy.w al_viewpt,x
rlf_088d68
	lda.w race_callback
rlf_088d6b
	clc
rlf_088d6c
	adc #$03e8
rlf_088d6f
	sta.w $0008,y
rlf_088d72
	lda.w race_visualoffset
rlf_088d75
	clc
rlf_088d76
	adc #$fa24
rlf_088d79
	sta.w $000a,y
rlf_088d7c
	lda.w race_visualowner
rlf_088d7f
	clc
rlf_088d80
	adc #$03e8
rlf_088d83
	sta.w $000c,y
rlf_088d86
	lda #$0018
rlf_088d89
	sta.w al_sword1,x
rlf_088d8c
	lda.w race_scratch
rlf_088d8f
	jsl retail_nextroute_l
rlf_088d93
	jsl retail_routeposition_l
rlf_088d97
	ldy.w al_viewpt,x
rlf_088d9a
	lda.w race_callback
rlf_088d9d
	sec
rlf_088d9e
	sbc.w $0008,y
rlf_088da1
	cmp #$8000
rlf_088da4
	ror a
rlf_088da5
	cmp #$8000
rlf_088da8
	ror a
rlf_088da9
	cmp #$8000
rlf_088dac
	ror a
rlf_088dad
	cmp #$8000
rlf_088db0
	ror a
rlf_088db1
	cmp #$8000
rlf_088db4
	ror a
rlf_088db5
	sta.w al_vx,x
rlf_088db8
	lda.w race_visualoffset
rlf_088dbb
	sec
rlf_088dbc
	sbc.w $000a,y
rlf_088dbf
	cmp #$8000
rlf_088dc2
	ror a
rlf_088dc3
	cmp #$8000
rlf_088dc6
	ror a
rlf_088dc7
	cmp #$8000
rlf_088dca
	ror a
rlf_088dcb
	cmp #$8000
rlf_088dce
	ror a
rlf_088dcf
	cmp #$8000
rlf_088dd2
	ror a
rlf_088dd3
	sta.w al_vy,x
rlf_088dd6
	lda.w race_visualowner
rlf_088dd9
	sec
rlf_088dda
	sbc.w $000c,y
rlf_088ddd
	cmp #$8000
rlf_088de0
	ror a
rlf_088de1
	cmp #$8000
rlf_088de4
	ror a
rlf_088de5
	cmp #$8000
rlf_088de8
	ror a
rlf_088de9
	cmp #$8000
rlf_088dec
	ror a
rlf_088ded
	cmp #$8000
rlf_088df0
	ror a
rlf_088df1
	sta.w al_vz,x
rlf_088df4
	lda.w al_sword1,x
rlf_088df7
	beq rlf_088e0a
rlf_088df9
	dec a
rlf_088dfa
	sta.w al_sword1,x
rlf_088dfd
	ldy.w al_viewpt,x
rlf_088e00
	lda.w $000a,y
rlf_088e03
	clc
rlf_088e04
	adc #$0019
rlf_088e07
	sta.w $000a,y
rlf_088e0a
	lda.w $0008,y
rlf_088e0d
	clc
rlf_088e0e
	adc.w al_vx,x
rlf_088e11
	sta.w $0008,y
rlf_088e14
	lda.w $000a,y
rlf_088e17
	clc
rlf_088e18
	adc.w al_vy,x
rlf_088e1b
	lda.w $000c,y
rlf_088e1e
	clc
rlf_088e1f
	adc.w al_vz,x
rlf_088e22
	sta.w $000c,y
rlf_088e25
	a8
rlf_088e27
	jmp retail_cameratick_l
retail_introcamera_l
	a16
rlf_088e2c
	lda #retail_introcamera_step&WM
rlf_088e2f
	sta.w al_stratptr,x
rlf_088e32
	a8
rlf_088e34
	lda #retail_introcamera_step>>16
rlf_088e36
	sta.w al_stratptr+2,x
rlf_088e39
	ldy.w al_viewpt,x
rlf_088e3c
	a16
rlf_088e3e
	lda #$0001
rlf_088e41
	sta.w $0000,y
rlf_088e44
	a8
rlf_088e46
	ldy #viewanim14&WM
rlf_088e49
	jsl retail_setcameraanim_l
rlf_088e4d
	jsl retail_updatecamera_l
retail_introcamera_step
	jsl retail_cameraanim_l
rlf_088e55
	bcs rlf_088e5a
rlf_088e57
	brl retail_cameratick_l
rlf_088e5a
	jmp retail_drivecamera_l
	shorta
	longi
retail_holdcamera_l
	ldy.w al_viewpt,x
rlf_088e60
	a16
rlf_088e62
	lda #$0021
rlf_088e65
	sta.w $0000,y
rlf_088e68
	a8
rlf_088e6a
	ldy.w al_viewpt,x
rlf_088e6d
	a16
rlf_088e6f
	lda #$0000
rlf_088e72
	sta.w $0020,y
rlf_088e75
	a8
rlf_088e77
	a16
rlf_088e79
	lda #$ff74
rlf_088e7c
	sta.w $0022,y
rlf_088e7f
	a8
rlf_088e81
	a16
rlf_088e83
	lda #$fe0c
rlf_088e86
	sta.w $0024,y
rlf_088e89
	a8
rlf_088e8b
	jsr rlf_snapcamera
rlf_088e8e
	a16
rlf_088e90
	lda #retail_holdcamera_step&WM
rlf_088e93
	sta.w al_stratptr,x
rlf_088e96
	a8
rlf_088e98
	lda #retail_holdcamera_step>>16
rlf_088e9a
	sta.w al_stratptr+2,x
rlf_088e9d
	lda #$50
rlf_088e9f
	sta.w al_sbyte1,x
retail_holdcamera_step
	lda.w al_sbyte1,x
rlf_088ea5
	bne rlf_088eab
rlf_088ea7
	jml retail_drivecamera_l
rlf_088eab
	dec.w al_sbyte1,x
rlf_088eae
	jmp retail_cameratick_l
	shorta
	longi
retail_snapcamera_l
	ldy.w al_viewpt,x
rlf_088eb4
	a16
rlf_088eb6
	lda #$0655
rlf_088eb9
	sta.w $0000,y
rlf_088ebc
	a8
rlf_088ebe
	jsr rlf_snapcamera
retail_drivecamera_l
	ldy.w al_viewpt,x
rlf_088ec4
	a16
rlf_088ec6
	lda #$0000
rlf_088ec9
	sta.w $0004,y
rlf_088ecc
	a8
rlf_088ece
	ldy.w al_viewpt,x
rlf_088ed1
	lda #$00
rlf_088ed3
	sta.w $0034,y
rlf_088ed6
	lda.w al_sflags2,x
rlf_088ed9
	and #$fe
rlf_088edb
	sta.w al_sflags2,x
rlf_088ede
	lda.w al_sflags2,x
rlf_088ee1
	and #$fd
rlf_088ee3
	sta.w al_sflags2,x
rlf_088ee6
	a16
rlf_088ee8
	lda #retail_drivecamera_step&WM
rlf_088eeb
	sta.w al_stratptr,x
rlf_088eee
	a8
rlf_088ef0
	lda #retail_drivecamera_step>>16
rlf_088ef2
	sta.w al_stratptr+2,x
retail_drivecamera_step
	jsl retail_camerapreset_l
retail_cameratick_l
	jsl retail_updatecamera_l
rlf_088efd
	lda #$03
rlf_088eff
	sta.w al_sbyte4,x
rlf_088f02
	rtl
rlf_snapcamera
	ldy.w al_viewpt,x
rlf_088f06
	a16
rlf_088f08
	lda.w $0000,y
rlf_088f0b
	pha
rlf_088f0c
	a8
rlf_088f0e
	ldy.w al_viewpt,x
rlf_088f11
	a16
rlf_088f13
	lda #$0001
rlf_088f16
	sta.w $0000,y
rlf_088f19
	a8
rlf_088f1b
	ldy.w al_viewpt,x
rlf_088f1e
	a16
rlf_088f20
	lda #$0000
rlf_088f23
	sta.w $0026,y
rlf_088f26
	a8
rlf_088f28
	a16
rlf_088f2a
	lda #$0000
rlf_088f2d
	sta.w $0028,y
rlf_088f30
	a8
rlf_088f32
	a16
rlf_088f34
	lda #$0000
rlf_088f37
	sta.w $002a,y
rlf_088f3a
	a8
rlf_088f3c
	ldy.w al_viewpt,x
rlf_088f3f
	a16
rlf_088f41
	lda #$0000
rlf_088f44
	sta.w $002c,y
rlf_088f47
	a8
rlf_088f49
	a16
rlf_088f4b
	lda #$0000
rlf_088f4e
	sta.w $002e,y
rlf_088f51
	a8
rlf_088f53
	a16
rlf_088f55
	lda #$0000
rlf_088f58
	sta.w $0030,y
rlf_088f5b
	a8
rlf_088f5d
	ldy.w al_viewpt,x
rlf_088f60
	a16
rlf_088f62
	lda.w $0020,y
rlf_088f65
	sta.w $001a,y
rlf_088f68
	a8
rlf_088f6a
	a16
rlf_088f6c
	lda.w $0022,y
rlf_088f6f
	sta.w $001c,y
rlf_088f72
	a8
rlf_088f74
	a16
rlf_088f76
	lda.w $0024,y
rlf_088f79
	sta.w $001e,y
rlf_088f7c
	a8
rlf_088f7e
	jsl retail_updatecamera_l
rlf_088f82
	ldy.w al_viewpt,x
rlf_088f85
	a16
rlf_088f87
	pla
rlf_088f88
	sta.w $0000,y
rlf_088f8b
	a8
rlf_088f8d
	rts
	shorta
	longi
retail_driftcamera30_l
	a16
rlf_0891ed
	lda #retail_driftcamera30_step&WM
rlf_0891f0
	sta.w al_stratptr,x
rlf_0891f3
	a8
rlf_0891f5
	lda #retail_driftcamera30_step>>16
rlf_0891f7
	sta.w al_stratptr+2,x
rlf_0891fa
	ldy.w al_viewpt,x
rlf_0891fd
	a16
rlf_0891ff
	lda #$0003
rlf_089202
	sta.w $0000,y
rlf_089205
	a8
rlf_089207
	lda #$1e
rlf_089209
	sta.w al_sbyte1,x
rlf_08920c
	ldy.w al_ptr,x
rlf_08920f
	jsl retail_copyrawvelocity_l
rlf_089213
	a16
rlf_089215
	lda #$0000
rlf_089218
	sta.w al_vy,x
rlf_08921b
	a8
retail_driftcamera30_step
	a16
rlf_08921f
	ldy.w al_viewpt,x
rlf_089222
	lda.w al_vx,x
rlf_089225
	clc
rlf_089226
	adc.w $0008,y
rlf_089229
	sta.w $0008,y
rlf_08922c
	lda.w al_vy,x
rlf_08922f
	clc
rlf_089230
	adc.w $000a,y
rlf_089233
	sta.w $000a,y
rlf_089236
	lda.w al_vz,x
rlf_089239
	clc
rlf_08923a
	adc.w $000c,y
rlf_08923d
	sta.w $000c,y
rlf_089240
	a8
rlf_089242
	a16
rlf_089244
	lda.w al_vx,x
rlf_089247
	sta tpx
rlf_089249
	lda #$0000
rlf_08924c
	jsl retail_easeactor8_l
rlf_089250
	sta.w al_vx,x
rlf_089253
	a8
rlf_089255
	a16
rlf_089257
	lda.w al_vy,x
rlf_08925a
	sta tpx
rlf_08925c
	lda #$0000
rlf_08925f
	jsl retail_easeactor8_l
rlf_089263
	sta.w al_vy,x
rlf_089266
	a8
rlf_089268
	a16
rlf_08926a
	lda.w al_vz,x
rlf_08926d
	sta tpx
rlf_08926f
	lda #$0000
rlf_089272
	jsl retail_easeactor8_l
rlf_089276
	sta.w al_vz,x
rlf_089279
	a8
rlf_08927b
	lda.w al_sbyte1,x
rlf_08927e
	bne rlf_089284
rlf_089280
	jml retail_roadcamera_l
rlf_089284
	dec.w al_sbyte1,x
rlf_089287
	jmp retail_cameratick_l
	shorta
	longi
retail_driftcamera40_l
	a16
rlf_0892e1
	lda #retail_driftcamera40_step&WM
rlf_0892e4
	sta.w al_stratptr,x
rlf_0892e7
	a8
rlf_0892e9
	lda #retail_driftcamera40_step>>16
rlf_0892eb
	sta.w al_stratptr+2,x
rlf_0892ee
	ldy.w al_viewpt,x
rlf_0892f1
	a16
rlf_0892f3
	lda #$0003
rlf_0892f6
	sta.w $0000,y
rlf_0892f9
	a8
rlf_0892fb
	lda #$28
rlf_0892fd
	sta.w al_sbyte1,x
rlf_089300
	ldy.w al_ptr,x
rlf_089303
	jsl retail_copyrawvelocity_l
rlf_089307
	a16
rlf_089309
	lda #$0000
rlf_08930c
	sta.w al_vy,x
rlf_08930f
	a8
retail_driftcamera40_step
	a16
rlf_089313
	ldy.w al_viewpt,x
rlf_089316
	lda.w al_vx,x
rlf_089319
	clc
rlf_08931a
	adc.w $0008,y
rlf_08931d
	sta.w $0008,y
rlf_089320
	lda.w al_vy,x
rlf_089323
	clc
rlf_089324
	adc.w $000a,y
rlf_089327
	sta.w $000a,y
rlf_08932a
	lda.w al_vz,x
rlf_08932d
	clc
rlf_08932e
	adc.w $000c,y
rlf_089331
	sta.w $000c,y
rlf_089334
	a8
rlf_089336
	a16
rlf_089338
	lda.w al_vx,x
rlf_08933b
	sta tpx
rlf_08933d
	lda #$0000
rlf_089340
	jsl retail_easeactor8_l
rlf_089344
	sta.w al_vx,x
rlf_089347
	a8
rlf_089349
	a16
rlf_08934b
	lda.w al_vy,x
rlf_08934e
	sta tpx
rlf_089350
	lda #$0000
rlf_089353
	jsl retail_easeactor8_l
rlf_089357
	sta.w al_vy,x
rlf_08935a
	a8
rlf_08935c
	a16
rlf_08935e
	lda.w al_vz,x
rlf_089361
	sta tpx
rlf_089363
	lda #$0000
rlf_089366
	jsl retail_easeactor8_l
rlf_08936a
	sta.w al_vz,x
rlf_08936d
	a8
rlf_08936f
	lda.w al_sbyte1,x
rlf_089372
	bne rlf_089378
rlf_089374
	jml retail_roadcamera_l
rlf_089378
	dec.w al_sbyte1,x
rlf_08937b
	jmp retail_cameratick_l
	shorta
	longi
retail_driftcamera_l
	a16
rlf_0893d9
	lda #retail_driftcamera_step&WM
rlf_0893dc
	sta.w al_stratptr,x
rlf_0893df
	a8
rlf_0893e1
	lda #retail_driftcamera_step>>16
rlf_0893e3
	sta.w al_stratptr+2,x
rlf_0893e6
	ldy.w al_viewpt,x
rlf_0893e9
	a16
rlf_0893eb
	lda #$0003
rlf_0893ee
	sta.w $0000,y
rlf_0893f1
	a8
rlf_0893f3
	lda #$28
rlf_0893f5
	sta.w al_sbyte1,x
rlf_0893f8
	ldy.w al_ptr,x
rlf_0893fb
	jsl retail_copyrawvelocity_l
retail_driftcamera_step
	a16
rlf_089401
	ldy.w al_viewpt,x
rlf_089404
	lda.w al_vx,x
rlf_089407
	clc
rlf_089408
	adc.w $0008,y
rlf_08940b
	sta.w $0008,y
rlf_08940e
	lda.w al_vy,x
rlf_089411
	clc
rlf_089412
	adc.w $000a,y
rlf_089415
	sta.w $000a,y
rlf_089418
	lda.w al_vz,x
rlf_08941b
	clc
rlf_08941c
	adc.w $000c,y
rlf_08941f
	sta.w $000c,y
rlf_089422
	a8
rlf_089424
	a16
rlf_089426
	lda.w al_vx,x
rlf_089429
	sta tpx
rlf_08942b
	lda #$0000
rlf_08942e
	jsl retail_easeactor8_l
rlf_089432
	sta.w al_vx,x
rlf_089435
	a8
rlf_089437
	a16
rlf_089439
	lda.w al_vy,x
rlf_08943c
	sta tpx
rlf_08943e
	lda #$fff6
rlf_089441
	jsl retail_easeactor8_l
rlf_089445
	sta.w al_vy,x
rlf_089448
	a8
rlf_08944a
	a16
rlf_08944c
	lda.w al_vz,x
rlf_08944f
	sta tpx
rlf_089451
	lda #$0000
rlf_089454
	jsl retail_easeactor8_l
rlf_089458
	sta.w al_vz,x
rlf_08945b
	a8
rlf_08945d
	lda.w al_sbyte1,x
rlf_089460
	bne rlf_089466
rlf_089462
	jml retail_tiltcamera_l
rlf_089466
	dec.w al_sbyte1,x
rlf_089469
	jmp retail_cameratick_l
	shorta
	longi
retail_tiltcamera_l
	a16
rlf_08946e
	lda #rlf_089488&WM
rlf_089471
	sta.w al_stratptr,x
rlf_089474
	a8
rlf_089476
	lda #rlf_089488>>16
rlf_089478
	sta.w al_stratptr+2,x
retail_tiltcamera_step
	ldy.w al_viewpt,x
rlf_08947e
	a16
rlf_089480
	lda #$0002
rlf_089483
	sta.w $0000,y
rlf_089486
	a8
rlf_089488
	ldy.w al_viewpt,x
rlf_08948b
	a16
rlf_08948d
	lda.w $000e,y
rlf_089490
	sta tpx
rlf_089492
	lda #$1000
rlf_089495
	jsl retail_easeactor32_l
rlf_089499
	sta.w $000e,y
rlf_08949c
	a8
rlf_08949e
	jmp retail_cameratick_l
	shorta
	longi
retail_endcamera_l
	a16
rlf_0894a3
	lda #retail_endcamera_step&WM
rlf_0894a6
	sta.w al_stratptr,x
rlf_0894a9
	a8
rlf_0894ab
	lda #retail_endcamera_step>>16
rlf_0894ad
	sta.w al_stratptr+2,x
rlf_0894b0
	ldy.w al_viewpt,x
rlf_0894b3
	a16
rlf_0894b5
	lda #$0655
rlf_0894b8
	sta.w $0000,y
rlf_0894bb
	a8
rlf_0894bd
	ldy #viewanim18&WM
rlf_0894c0
	jsl retail_setcameraanim_l
rlf_0894c4
	phx
rlf_0894c5
	a16
rlf_0894c7
	lda.w al_ptr,x
rlf_0894ca
	tax
rlf_0894cb
	lda.w al_collobjptr,x
rlf_0894ce
	tax
rlf_0894cf
	lda.l $700040,x
rlf_0894d3
	ora #$0004
rlf_0894d6
	sta.l $700040,x
rlf_0894da
	a8
rlf_0894dc
	plx
retail_endcamera_step
	jsl retail_cameraanim_l
rlf_0894e1
	bcs rlf_0894e6
rlf_0894e3
	jmp retail_cameratick_l
rlf_0894e6
	a16
rlf_0894e8
	lda #retail_endtilt_step&WM
rlf_0894eb
	sta.w al_stratptr,x
rlf_0894ee
	a8
rlf_0894f0
	lda #retail_endtilt_step>>16
rlf_0894f2
	sta.w al_stratptr+2,x
rlf_0894f5
	ldy.w al_viewpt,x
rlf_0894f8
	a16
rlf_0894fa
	lda #$0654
rlf_0894fd
	sta.w $0000,y
rlf_089500
	a8
retail_endtilt_step
	ldy.w al_viewpt,x
rlf_089505
	a16
rlf_089507
	lda.w $000e,y
rlf_08950a
	sta tpx
rlf_08950c
	lda #$2000
rlf_08950f
	jsl retail_easeactor64_l
rlf_089513
	sta.w $000e,y
rlf_089516
	a8
rlf_089518
	jmp retail_cameratick_l
	shorta
	longi
retail_brakecamera_l
	a16
rlf_08951d
	lda #retail_brakecamera_step&WM
rlf_089520
	sta.w al_stratptr,x
rlf_089523
	a8
rlf_089525
	lda #retail_brakecamera_step>>16
rlf_089527
	sta.w al_stratptr+2,x
rlf_08952a
	lda #$0a
rlf_08952c
	sta.w al_sbyte1,x
rlf_08952f
	ldy.w al_viewpt,x
rlf_089532
	a16
rlf_089534
	lda #$8000
rlf_089537
	sta.w $0037,y
rlf_08953a
	a8
retail_brakecamera_step
	ldy.w al_ptr,x
rlf_08953f
	phx
rlf_089540
	tyx
rlf_089541
	a16
rlf_089543
	lda.w al_collobjptr,x
rlf_089546
	tax
rlf_089547
	lda #$0410
rlf_08954a
	sta.l $700042,x
rlf_08954e
	a8
rlf_089550
	plx
rlf_089551
	lda.w al_sbyte1,x
rlf_089554
	bne rlf_08955a
rlf_089556
	jml rlf_089564
rlf_08955a
	dec.w al_sbyte1,x
rlf_08955d
	jsl retail_camerapreset_l
rlf_089561
	jmp retail_cameratick_l
rlf_089564
	a16
rlf_089566
	lda #retail_brakecamera_hold&WM
rlf_089569
	sta.w al_stratptr,x
rlf_08956c
	a8
rlf_08956e
	lda #retail_brakecamera_hold>>16
rlf_089570
	sta.w al_stratptr+2,x
rlf_089573
	ldy.w al_ptr,x
rlf_089576
	phx
rlf_089577
	tyx
rlf_089578
	a16
rlf_08957a
	lda.w al_collobjptr,x
rlf_08957d
	tax
rlf_08957e
	lda.l $70001c,x
rlf_089582
	lda #$0010
rlf_089585
	sta.l $70001c,x
rlf_089589
	a8
rlf_08958b
	plx
retail_brakecamera_hold
	jmp retail_cameratick_l
retail_updatecamera_l
	phx
rlf_089590
	ldy.w al_viewpt,x
rlf_089593
	tyx
rlf_089594
	jsl getviewpos_l
rlf_089598
	jsl getviewangles_l
rlf_08959c
	plx
rlf_08959d
	a8
rlf_08959f
	rtl
	shorta
	longi
retail_camerapreset_l
	ldy.w al_viewpt,x
rlf_089a52
	a16
rlf_089a54
	lda.w $0000,y
rlf_089a57
	and #$0020
rlf_089a5a
	a8
rlf_089a5c
	bne rlf_089acd
rlf_089a5e
	lda.w al_sflags2,x
rlf_089a61
	and #$01
rlf_089a63
	bne rlf_089a69
rlf_089a65
	jml rlf_089acd
rlf_089a69
	lda.w al_sflags2,x
rlf_089a6c
	and #$fe
rlf_089a6e
	sta.w al_sflags2,x
rlf_089a71
	lda #$24
rlf_089a73
	jsl queue_raceplayer_l
rlf_089a77
	phx
rlf_089a78
	a16
rlf_089a7a
	lda.w $0032,y
rlf_089a7d
	tax
rlf_089a7e
	a8
rlf_089a80
	lda.l viewpresettab,x
rlf_089a84
	sta.w race_scratch
rlf_089a87
	lda.l viewpresettab+1,x
rlf_089a8b
	sta.w race_griddef
rlf_089a8e
	plx
rlf_089a8f
	lda.w al_sflags2,x
rlf_089a92
	and #$02
rlf_089a94
	bne rlf_089a9a
rlf_089a96
	jml rlf_089ab5
rlf_089a9a
	lda.w al_sflags2,x
rlf_089a9d
	and #$fd
rlf_089a9f
	sta.w al_sflags2,x
rlf_089aa2
	lda.w race_griddef
rlf_089aa5
	beq rlf_089ab5
rlf_089aa7
	clc
rlf_089aa8
	adc.w race_scratch
rlf_089aab
	dec a
rlf_089aac
	cmp.w $0034,y
rlf_089aaf
	bne rlf_089ac0
rlf_089ab1
	lda #$00
rlf_089ab3
	bra rlf_089ac0
rlf_089ab5
	lda.w $0034,y
rlf_089ab8
	inc a
rlf_089ab9
	cmp.w race_scratch
rlf_089abc
	bmi rlf_089ac0
rlf_089abe
	lda #$00
rlf_089ac0
	sta.w $0034,y
rlf_089ac3
	a16
rlf_089ac5
	lda #$0007
rlf_089ac8
	sta.w al_sword1,x
rlf_089acb
	a8
rlf_089acd
	phy
rlf_089ace
	ldy.w al_ptr,x
rlf_089ad1
	lda.w al_sflags2,y
rlf_089ad4
	and #$04
rlf_089ad6
	bne rlf_089adc
rlf_089ad8
	jml rlf_089aef
rlf_089adc
	ply
rlf_089add
	a16
rlf_089adf
	lda #$0007
rlf_089ae2
	sta.w al_sword1,x
rlf_089ae5
	a8
rlf_089ae7
	a16
rlf_089ae9
	phx
rlf_089aea
	ldx #$0000
rlf_089aed
	bra rlf_089b01
rlf_089aef
	ply
rlf_089af0
	phx
rlf_089af1
	a16
rlf_089af3
	lda.w $0034,y
rlf_089af6
	and #$00ff
rlf_089af9
	asl a
rlf_089afa
	asl a
rlf_089afb
	asl a
rlf_089afc
	clc
rlf_089afd
	adc.w $0032,y
rlf_089b00
	tax
rlf_089b01
	inx
rlf_089b02
	inx
rlf_089b03
	lda.l viewpresettab,x
rlf_089b07
	sta.w $0000,y
rlf_089b0a
	lda.l viewpresettab+2,x
rlf_089b0e
	sta x1
rlf_089b10
	lda.l viewpresettab+4,x
rlf_089b14
	sta y1
rlf_089b16
	lda.l viewpresettab+6,x
rlf_089b1a
	sta z1
rlf_089b1c
	plx
rlf_089b1d
	phx
rlf_089b1e
	tyx
rlf_089b1f
	ply
rlf_089b20
	lda $00,x
rlf_089b22
	bit #$0080
rlf_089b25
	beq rlf_089b49
rlf_089b27
	lda.w al_sword1,y
rlf_089b2a
	beq rlf_089b42
rlf_089b2c
	dec a
rlf_089b2d
	sta.w al_sword1,y
rlf_089b30
	lda $00,x
rlf_089b32
	ora #$8201
rlf_089b35
	sta $00,x
rlf_089b37
	stz x1
rlf_089b39
	stz y1
rlf_089b3b
	lda #$ffce
rlf_089b3e
	sta z1
rlf_089b40
	bra rlf_089b49
rlf_089b42
	lda $00,x
rlf_089b44
	ora #$4000
rlf_089b47
	sta $00,x
rlf_089b49
	a8
rlf_089b4b
	a16
rlf_089b4d
	lda x1
rlf_089b4f
	clc
rlf_089b50
	adc $26,x
rlf_089b52
	sta x1
rlf_089b54
	a8
rlf_089b56
	a16
rlf_089b58
	lda y1
rlf_089b5a
	clc
rlf_089b5b
	adc $28,x
rlf_089b5d
	sta y1
rlf_089b5f
	a8
rlf_089b61
	a16
rlf_089b63
	lda z1
rlf_089b65
	clc
rlf_089b66
	adc $2a,x
rlf_089b68
	sta z1
rlf_089b6a
	a8
rlf_089b6c
	a16
rlf_089b6e
	lda x1
rlf_089b70
	clc
rlf_089b71
	adc $2c,x
rlf_089b73
	sta x1
rlf_089b75
	a8
rlf_089b77
	a16
rlf_089b79
	lda y1
rlf_089b7b
	clc
rlf_089b7c
	adc $2e,x
rlf_089b7e
	sta y1
rlf_089b80
	a8
rlf_089b82
	a16
rlf_089b84
	lda z1
rlf_089b86
	clc
rlf_089b87
	adc $30,x
rlf_089b89
	sta z1
rlf_089b8b
	a8
rlf_089b8d
	a16
rlf_089b8f
	lda $1a,x
rlf_089b91
	sta tpx
rlf_089b93
	lda x1
rlf_089b95
	jsl retail_easeactor_l
rlf_089b99
	sta $1a,x
rlf_089b9b
	a8
rlf_089b9d
	a16
rlf_089b9f
	lda $1c,x
rlf_089ba1
	sta tpx
rlf_089ba3
	lda y1
rlf_089ba5
	jsl retail_easeactor_l
rlf_089ba9
	sta $1c,x
rlf_089bab
	a8
rlf_089bad
	a16
rlf_089baf
	lda $1e,x
rlf_089bb1
	sta tpx
rlf_089bb3
	lda z1
rlf_089bb5
	jsl retail_easeactor_l
rlf_089bb9
	sta $1e,x
rlf_089bbb
	a8
rlf_089bbd
	a16
rlf_089bbf
	lda x1
rlf_089bc1
	sta $20,x
rlf_089bc3
	a8
rlf_089bc5
	a16
rlf_089bc7
	lda y1
rlf_089bc9
	sta $22,x
rlf_089bcb
	a8
rlf_089bcd
	a16
rlf_089bcf
	lda z1
rlf_089bd1
	sta $24,x
rlf_089bd3
	a8
rlf_089bd5
	phx
rlf_089bd6
	tyx
rlf_089bd7
	ply
rlf_089bd8
	rtl
	shorta
	longi
retail_player1_l
	lda #$01
rlf_08af11
	sta.w al_whocanseeme,x
rlf_08af14
	jsl retail_registercar_l
rlf_08af18
	a16
rlf_08af1a
	lda.w al_worldy,x
rlf_08af1d
	clc
rlf_08af1e
	adc #$ff60
rlf_08af21
	sta.w al_worldy,x
rlf_08af24
	a8
rlf_08af26
	a16
rlf_08af28
	lda.w race_scenephase
rlf_08af2b
	and #$00ff
rlf_08af2e
	bne rlf_08af41
rlf_08af30
	ldy.w race_cameraactor0
rlf_08af33
	lda.w al_stratptr,y
rlf_08af36
	cmp #retail_introcamera_l&WM
rlf_08af39
	bne rlf_08af41
rlf_08af3b
	lda #rcar8669&WM
rlf_08af3e
	sta.w al_sword1,x
rlf_08af41
	lda #$0001
rlf_08af44
	jsl retail_spawncarid_l
rlf_08af48
	a16
rlf_08af4a
	lda.w al_collobjptr,x
rlf_08af4d
	beq rlf_08af61
rlf_08af4f
	phx
rlf_08af50
	tax
rlf_08af51
	sta.l m_playercar
rlf_08af55
	lda.l $70001c,x
rlf_08af59
	ora #$0008
rlf_08af5c
	sta.l $70001c,x
rlf_08af60
	plx
	shorta
	longi
rlf_08af61
	a8
rlf_08af63
	a16
rlf_08af65
	lda #retail_player1_step&WM
rlf_08af68
	sta.w al_stratptr,x
rlf_08af6b
	a8
rlf_08af6d
	lda #retail_player1_step>>16
rlf_08af6f
	sta.w al_stratptr+2,x
rlf_08af72
	ldy.w race_cameraactor0
rlf_08af75
	jsl retail_bindcarcamera_l
rlf_08af79
	lda.w al_sbyte2,x
rlf_08af7c
	jsl retail_carview_l
rlf_08af7f
	a16
rlf_08af81
	lda #$0000
rlf_08af84
	sta.w race_carstate0
rlf_08af87
	a8
rlf_08af89
	a16
rlf_08af8b
	lda #$0000
rlf_08af8e
	sta.w al_sword2,x
rlf_08af91
	a8
retail_player1_step
	lda #$00
rlf_08af95
	sta.w racesound_player
rlf_08af98
	jsl retail_stuckcar_l
rlf_08af9b
	jsl retail_carfeedback_l
rlf_08af9f
	jsl retail_publishcar_l
rlf_08afa3
	jsr rlf_rechargeboost
rlf_08afa6
	jsr rlf_carshake
rlf_08afa9
	jsl retail_updateactorcell_l
rlf_08afad
	lda #$03
rlf_08afaf
	sta.w al_sbyte4,x
rlf_08afb2
	lda.w al_sflags,x
rlf_08afb5
	and #$fd
rlf_08afb7
	sta.w al_sflags,x
rlf_08afba
	txy
rlf_08afbb
	a16
rlf_08afbd
	phx
rlf_08afbe
	lda.w al_collobjptr,y
rlf_08afc1
	tax
rlf_08afc2
	lda.l $70001c,x
rlf_08afc6
	and #$0002
rlf_08afc9
	a8
rlf_08afcb
	beq rlf_08afd5
rlf_08afcd
	lda.w al_sflags,y
rlf_08afd0
	ora #$02
rlf_08afd2
	sta.w al_sflags,y
rlf_08afd5
	plx
rlf_08afd6
	rtl
	shorta
	longi
retail_player2_l
	lda #$02
rlf_08afd9
	sta.w al_whocanseeme,x
rlf_08afdc
	jsl retail_registercar_l
rlf_08afe0
	a16
rlf_08afe2
	lda.w al_worldy,x
rlf_08afe5
	clc
rlf_08afe6
	adc #$ff60
rlf_08afe9
	sta.w al_worldy,x
rlf_08afec
	a8
rlf_08afee
	a16
rlf_08aff0
	lda #$0002
rlf_08aff3
	jsl retail_spawncarid_l
rlf_08aff7
	a16
rlf_08aff9
	lda.w al_collobjptr,x
rlf_08affc
	beq rlf_08b017
rlf_08affe
	phx
rlf_08afff
	tax
rlf_08b000
	sta.l m_retailplayer2
rlf_08b004
	lda.l $700064,x
rlf_08b008
	ora #$0008
rlf_08b00b
	lda.l $70001c,x
rlf_08b00f
	ora #$0008
rlf_08b012
	sta.l $70001c,x
rlf_08b016
	plx
	shorta
	longi
rlf_08b017
	a8
rlf_08b019
	a16
rlf_08b01b
	lda #retail_player2_step&WM
rlf_08b01e
	sta.w al_stratptr,x
rlf_08b021
	a8
rlf_08b023
	lda #retail_player2_step>>16
rlf_08b025
	sta.w al_stratptr+2,x
rlf_08b028
	ldy.w race_cameraactor1
rlf_08b02b
	jsl retail_bindcarcamera_l
rlf_08b02f
	lda.w al_sbyte2,x
rlf_08b032
	jsl retail_carview_l
rlf_08b035
	a16
rlf_08b037
	lda #$0000
rlf_08b03a
	sta.w race_carstate0
rlf_08b03d
	a8
rlf_08b03f
	a16
rlf_08b041
	lda #$0000
rlf_08b044
	sta.w al_sword2,x
rlf_08b047
	a8
retail_player2_step
	lda #$01
rlf_08b04b
	sta.w racesound_player
rlf_08b04e
	a16
rlf_08b050
	lda.w race_input1
rlf_08b053
	sta.w race_buttons
rlf_08b056
	lda.w race_lastinput1
rlf_08b059
	sta.w race_previous
rlf_08b05c
	a8
rlf_08b05e
	jsl retail_stuckcar_l
rlf_08b061
	jsl retail_carfeedback_l
rlf_08b065
	jsl retail_publishcar_l
rlf_08b069
	jsr rlf_rechargeboost
rlf_08b06c
	jsr rlf_carshake
rlf_08b06f
	jsl retail_updateactorcell_l
rlf_08b073
	lda #$03
rlf_08b075
	sta.w al_sbyte4,x
rlf_08b078
	rtl
	shorta
	longi
retail_attractcar_l
	inc.w race_carphase
rlf_08b07c
	lda #$00
rlf_08b07e
	sta.w al_sbyte1,x
rlf_08b081
	lda #$00
rlf_08b083
	sta.w al_whocanseeme,x
rlf_08b086
	jsl retail_opponent_l
rlf_08b08a
	phx
rlf_08b08b
	a16
rlf_08b08d
	lda.w al_collobjptr,x
rlf_08b090
	tax
rlf_08b091
	lda.l $700064,x
rlf_08b095
	ora #$0010
rlf_08b098
	sta.l $700064,x
rlf_08b09c
	plx
rlf_08b09d
	a8
rlf_08b09f
	a16
rlf_08b0a1
	lda #retail_attractcar_step&WM
rlf_08b0a4
	sta.w al_stratptr,x
rlf_08b0a7
	a8
rlf_08b0a9
	lda #retail_attractcar_step>>16
rlf_08b0ab
	sta.w al_stratptr+2,x
rlf_08b0ae
	jmp retail_attractcar_step
	shorta
	longi
retail_attractcar2_l
	inc.w race_carphase
rlf_08b0b4
	lda #$00
rlf_08b0b6
	sta.w al_sbyte1,x
rlf_08b0b9
	lda #$00
rlf_08b0bb
	sta.w al_whocanseeme,x
rlf_08b0be
	jsl retail_opponent_l
rlf_08b0c2
	phx
rlf_08b0c3
	a16
rlf_08b0c5
	lda.w al_collobjptr,x
rlf_08b0c8
	tax
rlf_08b0c9
	lda.l $700064,x
rlf_08b0cd
	ora #$0010
rlf_08b0d0
	sta.l $700064,x
rlf_08b0d4
	lda.l $700070,x
rlf_08b0d8
	ora #$0002
rlf_08b0db
	sta.l $700070,x
rlf_08b0df
	plx
rlf_08b0e0
	a8
rlf_08b0e2
	a16
rlf_08b0e4
	lda #retail_attractcar_step&WM
rlf_08b0e7
	sta.w al_stratptr,x
rlf_08b0ea
	a8
rlf_08b0ec
	lda #retail_attractcar_step>>16
rlf_08b0ee
	sta.w al_stratptr+2,x
rlf_08b0f1
	jmp retail_attractcar_step
retail_attractcar_step
	a16
rlf_08b0f6
	lda.w race_feedbackmode
rlf_08b0f9
	and #$0400
rlf_08b0fc
	a8
rlf_08b0fe
	beq rlf_08b138
rlf_08b100
	lda.w al_sbyte4,x
rlf_08b103
	cmp #$01
rlf_08b105
	beq rlf_08b11e
rlf_08b107
	phx
rlf_08b108
	a16
rlf_08b10a
	lda.w al_collobjptr,x
rlf_08b10d
	tax
rlf_08b10e
	lda.l $70001c,x
rlf_08b112
	and #$ffdf
rlf_08b115
	sta.l $70001c,x
rlf_08b119
	a8
rlf_08b11b
	plx
rlf_08b11c
	bra rlf_08b138
	shorta
	longi
rlf_08b11e
	lda #$02
rlf_08b120
	sta.w al_sbyte4,x
rlf_08b123
	phx
rlf_08b124
	a16
rlf_08b126
	lda.w al_collobjptr,x
rlf_08b129
	tax
rlf_08b12a
	lda.l $70001c,x
rlf_08b12e
	ora #$0020
rlf_08b131
	sta.l $70001c,x
rlf_08b135
	a8
rlf_08b137
	plx
rlf_08b138
	jsl retail_random_l
rlf_08b13c
	cmp #$f2
rlf_08b13e
	bcs rlf_08b144
rlf_08b140
	jml rlf_08b159
rlf_08b144
	phx
rlf_08b145
	a16
rlf_08b147
	lda.w al_collobjptr,x
rlf_08b14a
	tax
rlf_08b14b
	lda.l $700070,x
rlf_08b14f
	eor #$0002
rlf_08b152
	sta.l $700070,x
rlf_08b156
	plx
rlf_08b157
	a8
rlf_08b159
	stx.w race_objowner
rlf_08b15c
	a16
rlf_08b15e
	lda.w al_collobjptr,x
rlf_08b161
	tax
rlf_08b162
	lda.l m_y1,x
rlf_08b166
	and #$0004
rlf_08b169
	beq rlf_08b19f
rlf_08b16b
	ldx.w race_objowner
rlf_08b16e
	a8
rlf_08b170
	lda.w al_sflags2,x
rlf_08b173
	ora #$10
rlf_08b175
	sta.w al_sflags2,x
rlf_08b178
	lda #$03
rlf_08b17a
	jsl retail_breakcar_l
rlf_08b17e
	bcs rlf_08b19f
rlf_08b180
	dec.w race_carphase
rlf_08b183
	a16
rlf_08b185
	lda.w al_collobjptr,x
rlf_08b188
	tax
rlf_08b189
	lda.l $700016,x
rlf_08b18d
	ora #$0020
rlf_08b190
	sta.l $700016,x
rlf_08b194
	lda.l $70001c,x
rlf_08b198
	ora #$0010
rlf_08b19b
	sta.l $70001c,x
rlf_08b19f
	a8
rlf_08b1a1
	ldx.w race_objowner
rlf_08b1a4
	lda.w al_sflags2,x
rlf_08b1a7
	and #$04
rlf_08b1a9
	bne rlf_08b1af
rlf_08b1ab
	jml rlf_08b1b7
rlf_08b1af
	lda.w al_sflags,x
rlf_08b1b2
	ora #$20
rlf_08b1b4
	sta.w al_sflags,x
rlf_08b1b7
	jmp retail_opponent_step
	shorta
	longi
retail_opponent3_l
	lda #$00
rlf_08b1bc
	sta.w al_sbyte1,x
rlf_08b1bf
	lda #$03
rlf_08b1c1
	sta.w al_whocanseeme,x
rlf_08b1c4
	jmp retail_opponent_l
	shorta
	longi
retail_opponent4_l
	lda #$05
rlf_08b1c9
	sta.w al_sbyte1,x
rlf_08b1cc
	lda #$04
rlf_08b1ce
	sta.w al_whocanseeme,x
rlf_08b1d1
	jmp retail_opponent_l
	shorta
	longi
retail_opponent5_l
	lda #$00
rlf_08b1d6
	sta.w al_sbyte1,x
rlf_08b1d9
	lda #$05
rlf_08b1db
	sta.w al_whocanseeme,x
rlf_08b1de
	jmp retail_opponent_l
retail_opponent_l
	jsl retail_registercar_l
retail_opponent_make
	a16
rlf_08b1e7
	lda.w al_worldy,x
rlf_08b1ea
	clc
rlf_08b1eb
	adc #$fe20
rlf_08b1ee
	sta.w al_worldy,x
rlf_08b1f1
	a8
rlf_08b1f3
	a16
rlf_08b1f5
	lda #$0004
rlf_08b1f8
	jsl retail_spawncarid_l
rlf_08b1fc
	a16
rlf_08b1fe
	lda.w al_collobjptr,x
rlf_08b201
	bne rlf_08b206
rlf_08b203
	brl rlf_08b292
rlf_08b206
	phx
rlf_08b207
	tax
rlf_08b208
	lda.l $700064,x
rlf_08b20c
	ora #$0008
rlf_08b20f
	sta.l $700064,x
rlf_08b213
	lda.l $700040,x
rlf_08b217
	ora #$0200
rlf_08b21a
	sta.l $700040,x
rlf_08b21e
	lda.l $700070,x
rlf_08b222
	ora #$0002
rlf_08b225
	plx
rlf_08b226
	a8
	shorta
	longi
rlf_08b228
	a16
rlf_08b22a
	lda #retail_opponent_step&WM
rlf_08b22d
	sta.w al_stratptr,x
rlf_08b230
	a8
rlf_08b232
	lda #retail_opponent_step>>16
rlf_08b234
	sta.w al_stratptr+2,x
	shorta
	longi
rlf_08b237
	lda.w al_sbyte2,x
rlf_08b23a
	jsl retail_carview_l
retail_opponent_step
	ldy.w race_playeractor
rlf_08b240
	lda.w al_sflags2,y
rlf_08b243
	and #$08
rlf_08b245
	bne rlf_08b24b
rlf_08b247
	jml rlf_08b25e
rlf_08b24b
	a16
rlf_08b24d
	phx
rlf_08b24e
	lda.w al_collobjptr,x
rlf_08b251
	tax
rlf_08b252
	lda.l $70001c,x
rlf_08b256
	plx
rlf_08b257
	and #$0010
rlf_08b25a
	a8
rlf_08b25c
	bne rlf_08b26f
rlf_08b25e
	jsl retail_freezecar_l
rlf_08b262
	jsl retail_cardistance_l
rlf_08b266
	jsl retail_publishcar_l
rlf_08b26a
	jsl retail_updateactorcell_l
rlf_08b26e
	rtl
rlf_08b26f
	phx
rlf_08b270
	a16
rlf_08b272
	lda.w al_collobjptr,x
rlf_08b275
	tax
rlf_08b276
	lda.l $700016,x
rlf_08b27a
	ora #$0420
rlf_08b27d
	sta.l $700016,x
rlf_08b281
	a8
rlf_08b283
	plx
rlf_08b284
	lda #$03
rlf_08b286
	sta.w al_sbyte4,x
rlf_08b289
	lda.w al_sflags,x
rlf_08b28c
	ora #$20
rlf_08b28e
	sta.w al_sflags,x
rlf_08b291
	rtl
rlf_08b292
	jsl retail_fatalcar_l
	shorta
	longi
retail_staticcar_l
	a16
rlf_08b298
	lda.w al_worldy,x
rlf_08b29b
	clc
rlf_08b29c
	adc #$ff60
rlf_08b29f
	sta.w al_worldy,x
rlf_08b2a2
	a8
rlf_08b2a4
	a16
rlf_08b2a6
	lda #$0004
rlf_08b2a9
	jsl retail_spawncarid_l
rlf_08b2ad
	a16
rlf_08b2af
	lda.w al_collobjptr,x
rlf_08b2b2
	beq rlf_08b2cd
rlf_08b2b4
	phx
rlf_08b2b5
	tax
rlf_08b2b6
	lda.l $700064,x
rlf_08b2ba
	ora #$0008
rlf_08b2bd
	sta.l $700064,x
rlf_08b2c1
	lda.l $700070,x
rlf_08b2c5
	ora #$0004
rlf_08b2c8
	sta.l $700070,x
rlf_08b2cc
	plx
rlf_08b2cd
	a8
rlf_08b2cf
	a16
rlf_08b2d1
	lda #retail_staticcar_step&WM
rlf_08b2d4
	sta.w al_stratptr,x
rlf_08b2d7
	a8
rlf_08b2d9
	lda #retail_staticcar_step>>16
rlf_08b2db
	sta.w al_stratptr+2,x
retail_staticcar_step
	jsl retail_updateactorcell_l
rlf_08b2e2
	jsl retail_publishcar_l
rlf_08b2e6
	jml retail_bodyframe_l
rlf_rechargeboost
	lda.w racesound_playmode
rlf_08b2ec
	beq rlf_08b32a
rlf_08b2ee
	phx
rlf_08b2ef
	a16
rlf_08b2f1
	lda.w al_collobjptr,x
rlf_08b2f4
	tax
rlf_08b2f5
	lda.l $700042,x
rlf_08b2f9
	bit #$0400
rlf_08b2fc
	bne rlf_08b327
rlf_08b2fe
	lda #$0001
rlf_08b301
	sta.w race_scratch
rlf_08b304
	lda.l $700088,x
rlf_08b308
	cmp #$0001
rlf_08b30b
	beq rlf_08b313
rlf_08b30d
	lda #$0003
rlf_08b310
	sta.w race_scratch
rlf_08b313
	lda.l $70006a,x
rlf_08b317
	clc
rlf_08b318
	adc.w race_scratch
rlf_08b31b
	cmp #$0180
rlf_08b31e
	bmi rlf_08b323
rlf_08b320
	lda #$0180
rlf_08b323
	sta.l $70006a,x
rlf_08b327
	a8
rlf_08b329
	plx
rlf_08b32a
	rts
	shorta
	longi
rlf_carshake
	phx
rlf_08b34c
	a16
rlf_08b34e
	lda.w al_collobjptr,x
rlf_08b351
	tax
rlf_08b352
	lda.l $70005e,x
rlf_08b356
	tax
rlf_08b357
	a8
rlf_08b359
	lda.l retail_carshakes,x
rlf_08b35d
	plx
rlf_08b35e
	sta y1
rlf_08b360
	bne rlf_08b365
rlf_08b362
	brl rlf_08b401
rlf_08b365
	lda #$00
rlf_08b367
	sta x1
rlf_08b369
	sta x2
rlf_08b36b
	bit #$80
rlf_08b36d
	beq rlf_08b375
rlf_08b36f
	lda #$ff
rlf_08b371
	sta x2+1
rlf_08b373
	bra rlf_08b377
rlf_08b375
	stz x2+1
rlf_08b377
	lda y1
rlf_08b379
	sta y1
rlf_08b37b
	sta y2
rlf_08b37d
	bit #$80
rlf_08b37f
	beq rlf_08b387
rlf_08b381
	lda #$ff
rlf_08b383
	sta y2+1
rlf_08b385
	bra rlf_08b389
rlf_08b387
	stz y2+1
rlf_08b389
	lda #$00
rlf_08b38b
	sta z1
rlf_08b38d
	sta.w z2
rlf_08b390
	bit #$80
rlf_08b392
	beq rlf_08b39b
rlf_08b394
	lda #$ff
rlf_08b396
	sta.w z2+1
rlf_08b399
	bra rlf_08b39e
rlf_08b39b
	stz.w z2+1
rlf_08b39e
	lda.w al_rotz,x
rlf_08b3a1
	jsl retail_actorrotz_l
rlf_08b3a5
	lda x2
rlf_08b3a7
	sta x1
rlf_08b3a9
	lda y2
rlf_08b3ab
	sta y1
rlf_08b3ad
	lda.w z2
rlf_08b3b0
	sta z1
rlf_08b3b2
	lda.w al_rotx,x
rlf_08b3b5
	jsl retail_actorrotx_l
rlf_08b3b9
	lda x2
rlf_08b3bb
	sta x1
rlf_08b3bd
	lda y2
rlf_08b3bf
	sta y1
rlf_08b3c1
	lda.w z2
rlf_08b3c4
	sta z1
rlf_08b3c6
	lda.w al_roty,x
rlf_08b3c9
	jsl retail_actorroty_l
rlf_08b3cd
	a16
rlf_08b3cf
	lda x2
rlf_08b3d1
	asl a
rlf_08b3d2
	asl a
rlf_08b3d3
	sta x2
rlf_08b3d5
	lda y2
rlf_08b3d7
	asl a
rlf_08b3d8
	asl a
rlf_08b3d9
	sta y2
rlf_08b3db
	lda.w z2
rlf_08b3de
	asl a
rlf_08b3df
	asl a
rlf_08b3e0
	sta.w z2
rlf_08b3e3
	lda.w al_worldx,x
rlf_08b3e6
	clc
rlf_08b3e7
	adc x2
rlf_08b3e9
	sta.w al_worldx,x
rlf_08b3ec
	lda.w al_worldz,x
rlf_08b3ef
	clc
rlf_08b3f0
	adc.w z2
rlf_08b3f3
	sta.w al_worldz,x
rlf_08b3f6
	lda.w al_worldy,x
rlf_08b3f9
	clc
rlf_08b3fa
	adc y2
rlf_08b3fc
	sta.w al_worldy,x
rlf_08b3ff
	a8
rlf_08b401
	rts
	shorta
	longi
retail_playerhandoff_l
	a8
rlf_08b4c8
	lda.w al_sflags2,x
rlf_08b4cb
	and #$08
rlf_08b4cd
	beq rlf_08b4d3
rlf_08b4cf
	jml rlf_08b5b2
rlf_08b4d3
	lda.w race_playerphase,y
rlf_08b4d6
	cmp #$08
rlf_08b4d8
	beq rlf_08b532
rlf_08b4da
	cmp #$0c
rlf_08b4dc
	beq rlf_08b501
rlf_08b4de
	cmp #$0a
rlf_08b4e0
	beq rlf_08b501
rlf_08b4e2
	lda.w race_gamephase
rlf_08b4e5
	cmp #$08
rlf_08b4e7
	beq rlf_08b4ec
rlf_08b4e9
	jmp rlf_08b5b2
	shorta
	longi
rlf_08b4ec
	ldy.w al_viewpt,x
rlf_08b4ef
	a16
rlf_08b4f1
	lda #retail_brakecamera_l&WM
rlf_08b4f4
	sta.w al_stratptr,y
rlf_08b4f7
	a8
rlf_08b4f9
	lda #retail_brakecamera_l>>16
rlf_08b4fb
	sta.w al_stratptr+2,y
rlf_08b4fe
	jmp rlf_08b59a
	shorta
	longi
rlf_08b501
	phx
rlf_08b502
	a16
rlf_08b504
	lda.w al_collobjptr,x
rlf_08b507
	tax
rlf_08b508
	lda.l $700042,x
rlf_08b50c
	and #$fbcf
rlf_08b50f
	sta.l $700042,x
rlf_08b513
	a8
rlf_08b515
	plx
rlf_08b516
	lda.w race_endcamera
rlf_08b519
	bne rlf_08b51e
rlf_08b51b
	brl rlf_08b5b2
rlf_08b51e
	ldy.w al_viewpt,x
rlf_08b521
	a16
rlf_08b523
	lda #retail_endcamera_l&WM
rlf_08b526
	sta.w al_stratptr,y
rlf_08b529
	a8
rlf_08b52b
	lda #retail_endcamera_l>>16
rlf_08b52d
	sta.w al_stratptr+2,y
rlf_08b530
	bra rlf_08b59a
	shorta
	longi
rlf_08b532
	phx
rlf_08b533
	a16
rlf_08b535
	lda.w al_collobjptr,x
rlf_08b538
	tax
rlf_08b539
	lda.l $700064,x
rlf_08b53d
	ora #$0008
rlf_08b540
	sta.l $700064,x
rlf_08b544
	lda.l $700070,x
rlf_08b548
	ora #$0020
rlf_08b54b
	sta.l $700070,x
rlf_08b54f
	lda.l $700088,x
rlf_08b553
	a8
rlf_08b555
	sta.w race_animcount
rlf_08b558
	plx
rlf_08b559
	ldy.w al_viewpt,x
rlf_08b55c
	lda.w race_animcount
rlf_08b55f
	cmp #$01
rlf_08b561
	beq rlf_08b589
rlf_08b563
	cmp #$04
rlf_08b565
	beq rlf_08b578
rlf_08b567
	a16
rlf_08b569
	lda #retail_driftcamera40_l&WM
rlf_08b56c
	sta.w al_stratptr,y
rlf_08b56f
	a8
rlf_08b571
	lda #retail_driftcamera40_l>>16
rlf_08b573
	sta.w al_stratptr+2,y
rlf_08b576
	bra rlf_08b59a
rlf_08b578
	a16
rlf_08b57a
	lda #retail_driftcamera_l&WM
rlf_08b57d
	sta.w al_stratptr,y
rlf_08b580
	a8
rlf_08b582
	lda #retail_driftcamera_l>>16
rlf_08b584
	sta.w al_stratptr+2,y
rlf_08b587
	bra rlf_08b59a
rlf_08b589
	a16
rlf_08b58b
	lda #retail_driftcamera30_l&WM
rlf_08b58e
	sta.w al_stratptr,y
rlf_08b591
	a8
rlf_08b593
	lda #retail_driftcamera30_l>>16
rlf_08b595
	sta.w al_stratptr+2,y
rlf_08b598
	bra rlf_08b59a
rlf_08b59a
	a16
rlf_08b59c
	lda.w race_sceneoptions
rlf_08b59f
	and #$0001
rlf_08b5a2
	a8
rlf_08b5a4
	bne rlf_08b5aa
rlf_08b5a6
	jsl retail_snapshotranks_l
	shorta
	longi
rlf_08b5aa
	lda.w al_sflags2,x
rlf_08b5ad
	ora #$08
rlf_08b5af
	sta.w al_sflags2,x
rlf_08b5b2
	rtl
	shorta
	longi
retail_freezecar_l
	a8
rlf_08b5b5
	lda.w racesound_voiceoff
rlf_08b5b8
	bne rlf_08b5c9
rlf_08b5ba
	lda.w al_sbyte1,x
rlf_08b5bd
	bne rlf_08b5c3
rlf_08b5bf
	jml rlf_08b5c9
rlf_08b5c3
	dec.w al_sbyte1,x
rlf_08b5c6
	jmp rlf_08b5f5
rlf_08b5c9
	a16
rlf_08b5cb
	phx
rlf_08b5cc
	lda.w al_collobjptr,x
rlf_08b5cf
	beq rlf_08b5f6
rlf_08b5d1
	tax
rlf_08b5d2
	lda.w racesound_voiceoff
rlf_08b5d5
	and #$00ff
rlf_08b5d8
	beq rlf_08b5e7
rlf_08b5da
	lda.l $700070,x
rlf_08b5de
	ora #$0004
rlf_08b5e1
	sta.l $700070,x
rlf_08b5e5
	bra rlf_08b5f2
	longa
	longi
rlf_08b5e7
	lda.l $700070,x
rlf_08b5eb
	and #$fffb
rlf_08b5ee
	sta.l $700070,x
rlf_08b5f2
	plx
rlf_08b5f3
	a8
rlf_08b5f5
	rtl
	longa
	longi
rlf_08b5f6
	jsl retail_fatalcar_l
	shorta
	longi
retail_cardistance_l
	a16
rlf_08b5fc
	ldy #viewcamera1
rlf_08b5ff
	lda.w $0008,y
rlf_08b602
	sec
rlf_08b603
	sbc.w al_worldx,x
rlf_08b606
	bpl rlf_08b60c
rlf_08b608
	eor #$ffff
rlf_08b60b
	inc a
rlf_08b60c
	sta.w race_scratch
rlf_08b60f
	lda.w $000c,y
rlf_08b612
	sec
rlf_08b613
	sbc.w al_worldz,x
rlf_08b616
	bpl rlf_08b61c
rlf_08b618
	eor #$ffff
rlf_08b61b
	inc a
rlf_08b61c
	clc
rlf_08b61d
	adc.w race_scratch
rlf_08b620
	cmp #$1194
rlf_08b623
	a8
rlf_08b625
	bpl rlf_08b63c
rlf_08b627
	lda.w al_sflags,x
rlf_08b62a
	and #$f7
rlf_08b62c
	sta.w al_sflags,x
rlf_08b62f
	lda #$00
rlf_08b631
	sta.w al_eyesize,x
rlf_08b634
	lda.w al_sbyte2,x
rlf_08b637
	jsl retail_carview_l
rlf_08b63a
	bra rlf_08b67f
rlf_08b63c
	lda.w al_sflags3,x
rlf_08b63f
	and #$03
rlf_08b641
	sta.w al_sflags3,x
rlf_08b644
	ldy #viewcamera1
rlf_08b647
	lda.w $0011,y
rlf_08b64a
	clc
rlf_08b64b
	adc.w al_roty,x
rlf_08b64e
	lsr a
rlf_08b64f
	lsr a
rlf_08b650
	lsr a
rlf_08b651
	and #$fc
rlf_08b653
	ora #$80
rlf_08b655
	ora.w al_sflags3,x
rlf_08b658
	sta.w al_sflags3,x
rlf_08b65b
	lda.w al_sflags,x
rlf_08b65e
	ora #$08
rlf_08b660
	sta.w al_sflags,x
rlf_08b663
	lda #$00
rlf_08b665
	sta.w al_lapcnt,x
rlf_08b668
	lda #$32
rlf_08b66a
	sta.w al_eyesize,x
rlf_08b66d
	lda.w al_sbyte2,x
rlf_08b670
	a16
rlf_08b672
	and #$00ff
rlf_08b675
	asl a
rlf_08b676
	clc
rlf_08b677
	adc #$99a3
rlf_08b67a
	sta.w al_coltab,x
rlf_08b67d
	a8
rlf_08b67f
	rtl
	shorta
	longi
retail_retiregroup_l
	ldy.w race_playeractor
rlf_08b683
	a16
rlf_08b685
	lda.w al_worldz,y
rlf_08b688
	sec
rlf_08b689
	sbc.w al_worldz,x
rlf_08b68c
	bpl rlf_08b692
rlf_08b68e
	eor #$ffff
rlf_08b691
	inc a
rlf_08b692
	cmp #$1f40
rlf_08b695
	a8
rlf_08b697
	bmi rlf_08b69d
rlf_08b699
	jml rlf_08b6c7
rlf_08b69d
	a16
rlf_08b69f
	lda.w al_worldz,x
rlf_08b6a2
	cmp.w al_worldz,y
rlf_08b6a5
	a8
rlf_08b6a7
	bmi rlf_08b6ad
rlf_08b6a9
	jml rlf_08b72d
rlf_08b6ad
	a16
rlf_08b6af
	lda.w al_worldz,y
rlf_08b6b2
	sec
rlf_08b6b3
	sbc.w al_worldz,x
rlf_08b6b6
	bpl rlf_08b6bc
rlf_08b6b8
	eor #$ffff
rlf_08b6bb
	inc a
rlf_08b6bc
	cmp #$05dc
rlf_08b6bf
	a8
rlf_08b6c1
	bpl rlf_08b6c7
rlf_08b6c3
	jml rlf_08b72d
rlf_08b6c7
	ldy.w al_vx,x
rlf_08b6ca
	a16
rlf_08b6cc
	lda #retail_endactor_l&WM
rlf_08b6cf
	sta.w al_stratptr,y
rlf_08b6d2
	a8
rlf_08b6d4
	lda #retail_endactor_l>>16
rlf_08b6d6
	sta.w al_stratptr+2,y
rlf_08b6d9
	ldy.w al_vy,x
rlf_08b6dc
	a16
rlf_08b6de
	lda #retail_endactor_l&WM
rlf_08b6e1
	sta.w al_stratptr,y
rlf_08b6e4
	a8
rlf_08b6e6
	lda #retail_endactor_l>>16
rlf_08b6e8
	sta.w al_stratptr+2,y
rlf_08b6eb
	ldy.w al_vz,x
rlf_08b6ee
	a16
rlf_08b6f0
	lda #retail_endactor_l&WM
rlf_08b6f3
	sta.w al_stratptr,y
rlf_08b6f6
	a8
rlf_08b6f8
	lda #retail_endactor_l>>16
rlf_08b6fa
	sta.w al_stratptr+2,y
rlf_08b6fd
	a16
rlf_08b6ff
	lda #retail_endactor_l&WM
rlf_08b702
	sta.w al_stratptr,y
rlf_08b705
	a8
rlf_08b707
	lda #retail_endactor_l>>16
rlf_08b709
	sta.w al_stratptr+2,y
rlf_08b70c
	ldy.w al_shadowobj,x
rlf_08b70f
	a16
rlf_08b711
	lda #retail_endactor_l&WM
rlf_08b714
	sta.w al_stratptr,y
rlf_08b717
	a8
rlf_08b719
	lda #retail_endactor_l>>16
rlf_08b71b
	sta.w al_stratptr+2,y
rlf_08b71e
	a16
rlf_08b720
	lda #retail_endactor_l&WM
rlf_08b723
	sta.w al_stratptr,x
rlf_08b726
	a8
rlf_08b728
	lda #retail_endactor_l>>16
rlf_08b72a
	sta.w al_stratptr+2,x
rlf_08b72d
	rtl
retail_carflagset_l
	phx
rlf_08b72f
	phy
rlf_08b730
	tyx
rlf_08b731
	a16
rlf_08b733
	and #$00ff
rlf_08b736
	ora.l $70008a,x
rlf_08b73a
	sta.l $70008a,x
rlf_08b73e
	a8
rlf_08b740
	ply
rlf_08b741
	plx
rlf_08b742
	rtl
retail_carflagclear_l
	phx
rlf_08b744
	phy
rlf_08b745
	tyx
rlf_08b746
	a16
rlf_08b748
	and #$00ff
rlf_08b74b
	eor #$00ff
rlf_08b74e
	and.l $70008a,x
rlf_08b752
	sta.l $70008a,x
rlf_08b756
	a8
rlf_08b758
	ply
rlf_08b759
	plx
rlf_08b75a
	rtl
retail_registercar_l
	phx
rlf_08b75c
	phy
rlf_08b75d
	a16
rlf_08b75f
	txy
rlf_08b760
	lda.l race_actorbytes
rlf_08b764
	cmp #$0040
rlf_08b767
	beq rlf_08b77d
rlf_08b769
	tax
rlf_08b76a
	tya
rlf_08b76b
	sta.l race_actorlist,x
rlf_08b76f
	inx
rlf_08b770
	inx
rlf_08b771
	txa
rlf_08b772
	sta.l race_actorbytes
rlf_08b776
	lda #$0000
rlf_08b779
	sta.l race_actorlist,x
rlf_08b77d
	a8
rlf_08b77f
	ply
rlf_08b780
	plx
rlf_08b781
	rtl
retail_unregistercar_l
	phx
rlf_08b783
	phy
rlf_08b784
	a16
rlf_08b786
	stx.w race_scratch
rlf_08b789
	ldx #$0000
rlf_08b78c
	lda.l race_actorlist,x
rlf_08b790
	beq rlf_08b7c1
rlf_08b792
	cmp.w race_scratch
rlf_08b795
	beq rlf_08b79b
rlf_08b797
	inx
rlf_08b798
	inx
rlf_08b799
	bra rlf_08b78c
rlf_08b79b
	phx
rlf_08b79c
	lda.l race_actorbytes
rlf_08b7a0
	tax
rlf_08b7a1
	lda.l race_actorlist-2,x
rlf_08b7a5
	plx
rlf_08b7a6
	sta.l race_actorlist,x
rlf_08b7aa
	lda.l race_actorbytes
rlf_08b7ae
	bne rlf_08b7b2
rlf_08b7b0
	inc a
rlf_08b7b1
	inc a
	longa
	longi
rlf_08b7b2
	tax
rlf_08b7b3
	lda #$0000
rlf_08b7b6
	sta.l race_actorlist-2,x
rlf_08b7ba
	dex
rlf_08b7bb
	dex
rlf_08b7bc
	txa
rlf_08b7bd
	sta.l race_actorbytes
rlf_08b7c1
	a8
rlf_08b7c3
	ply
rlf_08b7c4
	plx
rlf_08b7c5
	rtl
	shorta
	longi
retail_clearcarlist_l
	a16
rlf_08b7c8
	lda #$0000
rlf_08b7cb
	sta.l race_actorbytes
rlf_08b7cf
	sta.l race_actorlist
rlf_08b7d3
	a8
rlf_08b7d5
	rtl
	shorta
	longi
retail_recovercar_l
	phx
rlf_08b7d7
	a16
rlf_08b7d9
	and #$00ff
rlf_08b7dc
	xba
rlf_08b7dd
	sta.l m_dynvar2
rlf_08b7e1
	tya
rlf_08b7e2
	sta.l m_dynvar1
rlf_08b7e6
	tax
rlf_08b7e7
	lda.l $700040,x
rlf_08b7eb
	and #$0001
rlf_08b7ee
	bne rlf_08b806
rlf_08b7f0
	lda.l m_dynvar1
rlf_08b7f4
	jsr rlf_markplayerrepair
rlf_08b7f7
	a8
rlf_08b7f9
	lda #mretail_recoverboost>>16
rlf_08b7fb
	ldx #mretail_recoverboost&WM
rlf_08b7fe
	jsl retail_rawtask_l
rlf_08b802
	a16
rlf_08b804
	i16
rlf_08b806
	a8
rlf_08b808
	plx
rlf_08b809
	rtl
	shorta
	longi
retail_repaircar_l
	phx
rlf_08b80b
	a16
rlf_08b80d
	and #$00ff
rlf_08b810
	xba
rlf_08b811
	sta.l m_dynvar2
rlf_08b815
	tya
rlf_08b816
	sta.l m_dynvar1
rlf_08b81a
	jsr rlf_markplayerrepair
rlf_08b81d
	a8
rlf_08b81f
	lda #mretail_repairdamage>>16
rlf_08b821
	ldx #mretail_repairdamage&WM
rlf_08b824
	jsl retail_rawtask_l
rlf_08b828
	a16
rlf_08b82a
	i16
rlf_08b82c
	a8
rlf_08b82e
	plx
rlf_08b82f
	rtl
rlf_markplayerrepair
	a16
rlf_08b832
	cmp.l m_playercar
rlf_08b836
	bne rlf_08b845
rlf_08b838
	ldx.w race_playeractor
rlf_08b83b
	a8
rlf_08b83d
	lda.w al_sflags2,x
rlf_08b840
	ora #$40
rlf_08b842
	sta.w al_sflags2,x
	shorta
	longi
rlf_08b845
	rts
	shorta
	longi
retail_selectplayerdef_l
	a8
rlf_08b848
	i16
	shorta
	longi
rlf_08b84a
	ldy.w race_playeractor
rlf_08b84d
	cmp #$01
rlf_08b84f
	beq rlf_08b858
rlf_08b851
	cmp #$02
rlf_08b853
	bne rlf_08b862
rlf_08b855
	ldy.w race_playeractor2
rlf_08b858
	a16
rlf_08b85a
	txa
rlf_08b85b
	tyx
rlf_08b85c
	sta.l alx_sword1,x
rlf_08b860
	a8
rlf_08b862
	rtl
	shorta
	longi
retail_snapshotranks_l
	phx
rlf_08b864
	phy
rlf_08b865
	php
rlf_08b866
	ai16
rlf_08b868
	lda.l race_gridbytes
rlf_08b86c
	cmp #$8000
rlf_08b86f
	ror a
rlf_08b870
	sta x1
rlf_08b872
	ldx #$0000
rlf_08b875
	lda.l race_gridactors,x
rlf_08b879
	phx
rlf_08b87a
	tax
rlf_08b87b
	lda.l alx_collobjptr,x
rlf_08b87f
	tax
rlf_08b880
	lda.l $700088,x
rlf_08b884
	plx
rlf_08b885
	sta.l race_gridranks,x
rlf_08b889
	inx
rlf_08b88a
	inx
rlf_08b88b
	dec x1
rlf_08b88d
	bne rlf_08b875
rlf_08b88f
	plp
rlf_08b890
	ply
rlf_08b891
	plx
rlf_08b892
	rtl
	shorta
	longi
retail_defaultranks_l
	php
rlf_08b894
	a16
rlf_08b896
	lda #$0001
rlf_08b899
	sta.l race_gridranks
rlf_08b89d
	lda #$0002
rlf_08b8a0
	sta.l race_gridranks+2
rlf_08b8a4
	lda #$0003
rlf_08b8a7
	sta.l race_gridranks+4
rlf_08b8ab
	lda #$0004
rlf_08b8ae
	sta.l race_gridranks+6
rlf_08b8b2
	plp
rlf_08b8b3
	rtl
	shorta
	longi
retail_assigngrid_l
	phx
rlf_08b8b5
	phy
rlf_08b8b6
	php
rlf_08b8b7
	ai16
rlf_08b8b9
	lda.l race_gridbytes
rlf_08b8bd
	cmp #$8000
rlf_08b8c0
	ror a
rlf_08b8c1
	sta x1
rlf_08b8c3
	lda #$0001
rlf_08b8c6
	sta y1
rlf_08b8c8
	ldx #$0000
rlf_08b8cb
	lda.l race_gridkind,x
rlf_08b8cf
	sta.w race_scratch
rlf_08b8d2
	jsl retail_readgriddef_l
rlf_08b8d6
	sta.w race_griddef
rlf_08b8d9
	lda.l race_gridvariant,x
rlf_08b8dd
	sta.w race_callback
rlf_08b8e0
	lda.l race_gridranks,x
rlf_08b8e4
	phx
rlf_08b8e5
	tax
rlf_08b8e6
	lda y1
rlf_08b8e8
	jsl retail_gridcar_l
rlf_08b8ec
	plx
rlf_08b8ed
	inx
rlf_08b8ee
	inx
rlf_08b8ef
	inc y1
rlf_08b8f1
	dec x1
rlf_08b8f3
	bne rlf_08b8cb
rlf_08b8f5
	plp
rlf_08b8f6
	ply
rlf_08b8f7
	plx
rlf_08b8f8
	rtl
	shorta
	longi
retail_gridcar_l
	php
rlf_08b8fa
	a8
rlf_08b8fc
	i16
rlf_08b8fe
	phb
rlf_08b8ff
	pha
rlf_08b900
	lda #$7e
rlf_08b902
	pha
rlf_08b903
	plb
rlf_08b904
	pla
rlf_08b905
	a16
rlf_08b907
	phx
rlf_08b908
	and #$00ff
rlf_08b90b
	dec a
rlf_08b90c
	asl a
rlf_08b90d
	tax
rlf_08b90e
	lda.l race_gridactors,x
rlf_08b912
	tay
rlf_08b913
	plx
rlf_08b914
	txa
rlf_08b915
	and #$00ff
rlf_08b918
	dec a
rlf_08b919
	asl a
rlf_08b91a
	asl a
rlf_08b91b
	asl a
rlf_08b91c
	tax
rlf_08b91d
	lda.w race_griddef
rlf_08b920
	sta.w al_sword1,y
rlf_08b923
	lda.w race_sceneoptions
rlf_08b926
	and #$0001
rlf_08b929
	bne rlf_08b945
rlf_08b92b
	lda.w race_startgrid,x
rlf_08b92e
	sta.w al_worldx,y
rlf_08b931
	lda.w race_startgrid+2,x
rlf_08b934
	sta.w al_worldy,y
rlf_08b937
	lda.w race_startgrid+4,x
rlf_08b93a
	sta.w al_worldz,y
rlf_08b93d
	a8
rlf_08b93f
	lda.w race_startgrid+6,x
rlf_08b942
	sta.w al_roty,y
	shorta
	longi
rlf_08b945
	a8
rlf_08b947
	lda.w race_scratch
rlf_08b94a
	sta.w al_sbyte2,y
rlf_08b94d
	lda.w race_callback
rlf_08b950
	sta.w al_sbyte3,y
rlf_08b953
	plb
rlf_08b954
	plp
rlf_08b955
	rtl
	shorta
	longi
retail_playerinputs_l
	a8
rlf_08c5a7
	i16
rlf_08c5a9
	phb
rlf_08c5aa
	lda #$7e
rlf_08c5ac
	pha
rlf_08c5ad
	plb
rlf_08c5ae
	a16
rlf_08c5b0
	lda.w race_input0
rlf_08c5b3
	sta.w race_buttons
rlf_08c5b6
	lda.w race_lastinput0
rlf_08c5b9
	sta.w race_previous
rlf_08c5bc
	a8
rlf_08c5be
	stz.w racesound_player
rlf_08c5c1
	ldx.w race_playeractor
rlf_08c5c4
	jsl retail_carcontrols_l
rlf_08c5c8
	ldy #$0000
rlf_08c5cb
	jsl retail_playerhandoff_l
rlf_08c5cf
	lda.w racesound_playmode
rlf_08c5d2
	beq rlf_08c5f7
rlf_08c5d4
	a16
rlf_08c5d6
	lda.w race_input1
rlf_08c5d9
	sta.w race_buttons
rlf_08c5dc
	lda.w race_lastinput1
rlf_08c5df
	sta.w race_previous
rlf_08c5e2
	a8
rlf_08c5e4
	lda #$01
rlf_08c5e6
	sta.w racesound_player
rlf_08c5e9
	ldx.w race_playeractor2
rlf_08c5ec
	jsl retail_carcontrols_l
rlf_08c5f0
	ldy #$0001
rlf_08c5f3
	jsl retail_playerhandoff_l
rlf_08c5f7
	a16
rlf_08c5f9
	lda.w race_input0
rlf_08c5fc
	sta.w race_lastinput0
rlf_08c5ff
	lda.w race_input1
rlf_08c602
	sta.w race_lastinput1
rlf_08c605
	stz.w race_input0
rlf_08c608
	stz.w race_input1
rlf_08c60b
	a8
rlf_08c60d
	plb
rlf_08c60e
	rtl
	shorta
	longi
retail_liftcar_l
	a16
rlf_08eddf
	lda #$a91c
rlf_08ede2
	sta.w race_scratch
rlf_08ede5
	a8
rlf_08ede7
	jsl retail_makeactor_l
rlf_08edeb
	bcs rlf_08edf1
rlf_08eded
	jml rlf_08ee09
rlf_08edf1
	jsl retail_copyactorpos_l
rlf_08edf5
	pha
rlf_08edf6
	a16
rlf_08edf8
	tya
rlf_08edf9
	sta.w al_ptr,x
rlf_08edfc
	a8
rlf_08edfe
	pla
rlf_08edff
	phx
rlf_08ee00
	tyx
rlf_08ee01
	ply
rlf_08ee02
	jsl retail_updateactorcell_l
rlf_08ee06
	phx
rlf_08ee07
	tyx
rlf_08ee08
	ply
rlf_08ee09
	a16
rlf_08ee0b
	lda #retail_liftcar_step&WM
rlf_08ee0e
	sta.w al_stratptr,x
rlf_08ee11
	a8
rlf_08ee13
	lda #retail_liftcar_step>>16
rlf_08ee15
	sta.w al_stratptr+2,x
rlf_08ee18
	lda #$32
rlf_08ee1a
	sta.w al_sbyte1,x
rlf_08ee1d
	lda #$0f
rlf_08ee1f
	ora #$80
rlf_08ee21
	sta.w al_colframe,x
rlf_08ee24
	a16
rlf_08ee26
	lda #$d354
rlf_08ee29
	sta.w al_expshape,x
rlf_08ee2c
	a8
rlf_08ee2e
	jsl retail_makefragment_l
rlf_08ee32
	bpl rlf_08ee37
rlf_08ee34
	jml retail_scene_return
rlf_08ee37
	a16
rlf_08ee39
	lda #$02d0
rlf_08ee3c
	sta x1
rlf_08ee3e
	a8
rlf_08ee40
	a16
rlf_08ee42
	lda #$0190
rlf_08ee45
	sta y1
rlf_08ee47
	a8
rlf_08ee49
	a16
rlf_08ee4b
	lda #$02d0
rlf_08ee4e
	sta z1
rlf_08ee50
	a8
rlf_08ee52
	jsl retail_setrawbounds_l
rlf_08ee56
	a16
rlf_08ee58
	lda #$4000
rlf_08ee5b
	sta x1
rlf_08ee5d
	a8
rlf_08ee5f
	jsl retail_orrawtype_l
retail_liftcar_step
	lda.w al_sbyte1,x
rlf_08ee66
	bne rlf_08ee6c
rlf_08ee68
	jml rlf_08ee8b
rlf_08ee6c
	dec.w al_sbyte1,x
rlf_08ee6f
	phx
rlf_08ee70
	a16
rlf_08ee72
	lda.l m_playercar
rlf_08ee76
	tax
rlf_08ee77
	lda #$1000
rlf_08ee7a
	sta.l $700042,x
rlf_08ee7e
	a8
rlf_08ee80
	plx
rlf_08ee81
	jsl retail_publishbody_l
rlf_08ee85
	lda #$03
rlf_08ee87
	sta.w al_sbyte4,x
rlf_08ee8a
	rtl
rlf_08ee8b
	lda #$28
rlf_08ee8d
	sta.w al_sbyte1,x
rlf_08ee90
	a16
rlf_08ee92
	lda #retail_lowercar_step&WM
rlf_08ee95
	sta.w al_stratptr,x
rlf_08ee98
	a8
rlf_08ee9a
	lda #retail_lowercar_step>>16
rlf_08ee9c
	sta.w al_stratptr+2,x
retail_lowercar_step
	lda.w al_sbyte1,x
rlf_08eea2
	bne rlf_08eea8
rlf_08eea4
	jml rlf_08eee5
rlf_08eea8
	dec.w al_sbyte1,x
rlf_08eeab
	lda.w al_colframe,x
rlf_08eeae
	and #$7f
rlf_08eeb0
	cmp #$00
rlf_08eeb2
	beq rlf_08eed0
rlf_08eeb4
	lda.w al_colframe,x
rlf_08eeb7
	clc
rlf_08eeb8
	adc #$ff
rlf_08eeba
	bmi rlf_08eebf
rlf_08eebc
	clc
rlf_08eebd
	adc #$10
rlf_08eebf
	and #$7f
rlf_08eec1
	cmp #$10
rlf_08eec3
	bcc rlf_08eec8
rlf_08eec5
	sec
rlf_08eec6
	sbc #$10
rlf_08eec8
	ora #$80
rlf_08eeca
	sta.w al_colframe,x
rlf_08eecd
	jmp rlf_08ee6f
rlf_08eed0
	phx
rlf_08eed1
	a16
rlf_08eed3
	lda.l m_playercar
rlf_08eed7
	tax
rlf_08eed8
	lda #$1010
rlf_08eedb
	sta.l $700042,x
rlf_08eedf
	a8
rlf_08eee1
	plx
rlf_08eee2
	jmp rlf_08ee81
rlf_08eee5
	phx
rlf_08eee6
	a16
rlf_08eee8
	lda.l m_playercar
rlf_08eeec
	tax
rlf_08eeed
	lda.l $700042,x
rlf_08eef1
	and #$efff
rlf_08eef4
	sta.l $700042,x
rlf_08eef8
	a8
rlf_08eefa
	plx
rlf_08eefb
	ldy.w al_ptr,x
rlf_08eefe
	jsl rsc_03ccb0
rlf_08ef02
	jml retail_endactor_l
retail_finishcaractor_l
	jsl retail_opponent_make
rlf_08ef0a
	a16
rlf_08ef0c
	lda #retail_finishcaractor_step&WM
rlf_08ef0f
	sta.w al_stratptr,x
rlf_08ef12
	a8
rlf_08ef14
	lda #retail_finishcaractor_step>>16
rlf_08ef16
	sta.w al_stratptr+2,x
retail_finishcaractor_step
	jsl retail_cardistance_l
rlf_08ef1d
	jsl retail_updateactorcell_l
rlf_08ef21
	jsl retail_publishcar_l
rlf_08ef25
	phx
rlf_08ef26
	a16
rlf_08ef28
	txy
rlf_08ef29
	lda.w al_collobjptr,x
rlf_08ef2c
	tax
rlf_08ef2d
	lda.w race_carphase
rlf_08ef30
	and #$00ff
rlf_08ef33
	cmp #$0002
rlf_08ef36
	beq rlf_08ef73
rlf_08ef38
	lda.l m_bigy,x
rlf_08ef3c
	clc
rlf_08ef3d
	adc #$0258
rlf_08ef40
	cmp.w race_sequencez
rlf_08ef43
	bmi rlf_08ef4e
rlf_08ef45
	a8
rlf_08ef47
	lda #$01
rlf_08ef49
	sta.w race_carphase
rlf_08ef4c
	a16
rlf_08ef4e
	lda.l $700042,x
rlf_08ef52
	and #$f7ff
rlf_08ef55
	sta.l $700042,x
rlf_08ef59
	lda.l $70004a,x
rlf_08ef5d
	cmp #$001e
rlf_08ef60
	bpl rlf_08ef6d
rlf_08ef62
	lda.l $700042,x
rlf_08ef66
	ora #$0800
rlf_08ef69
	sta.l $700042,x
rlf_08ef6d
	a8
rlf_08ef6f
	plx
rlf_08ef70
	jml retail_bodyframe_l
	longa
	longi
rlf_08ef73
	lda.l $70001c,x
rlf_08ef77
	ora #$0010
rlf_08ef7a
	sta.l $70001c,x
rlf_08ef7e
	a8
rlf_08ef80
	plx
rlf_08ef81
	lda.w al_sflags,x
rlf_08ef84
	ora #$20
rlf_08ef86
	sta.w al_sflags,x
rlf_08ef89
	lda.w al_sflags,x
rlf_08ef8c
	ora #$08
rlf_08ef8e
	sta.w al_sflags,x
rlf_08ef91
	a16
rlf_08ef93
	lda.w al_worldy,x
rlf_08ef96
	clc
rlf_08ef97
	adc #$b1e0
rlf_08ef9a
	sta.w al_worldy,x
rlf_08ef9d
	a8
rlf_08ef9f
	a16
rlf_08efa1
	lda #$0000
rlf_08efa4
	sta.w al_stratptr,x
rlf_08efa7
	a8
rlf_08efa9
	lda #$00
rlf_08efab
	sta.w al_stratptr+2,x
rlf_08efae
	rtl
retail_carsequence_l
	lda.w race_scenephase
rlf_08efb2
	beq rlf_08efb7
rlf_08efb4
	jml retail_endactor_l
rlf_08efb7
	a16
rlf_08efb9
	lda.w al_worldz,x
rlf_08efbc
	sta.w race_sequencez
rlf_08efbf
	a8
rlf_08efc1
	lda #$00
rlf_08efc3
	sta.w race_carphase
rlf_08efc6
	a16
rlf_08efc8
	lda.w al_worldy,x
rlf_08efcb
	clc
rlf_08efcc
	adc #$ff9c
rlf_08efcf
	sta.w al_worldy,x
rlf_08efd2
	a8
rlf_08efd4
	a16
rlf_08efd6
	lda #$a040
rlf_08efd9
	sta.w race_scratch
rlf_08efdc
	a8
rlf_08efde
	jsl retail_makeactor_l
rlf_08efe2
	bcs rlf_08efe8
rlf_08efe4
	jml retail_scene_return
rlf_08efe8
	jsl retail_copyactorpos_l
rlf_08efec
	a16
rlf_08efee
	lda.w al_worldz,y
rlf_08eff1
	clc
rlf_08eff2
	adc #$f254
rlf_08eff5
	sta.w al_worldz,y
rlf_08eff8
	a8
rlf_08effa
	a16
rlf_08effc
	lda #$0000
rlf_08efff
	sta.w al_worldy,y
rlf_08f002
	a8
rlf_08f004
	a16
rlf_08f006
	lda.w race_def0
rlf_08f009
	sta.w al_sword1,y
rlf_08f00c
	a8
rlf_08f00e
	a16
rlf_08f010
	lda #retail_finishcaractor_l&WM
rlf_08f013
	sta.w al_stratptr,y
rlf_08f016
	a8
rlf_08f018
	lda #retail_finishcaractor_l>>16
rlf_08f01a
	sta.w al_stratptr+2,y
rlf_08f01d
	a16
rlf_08f01f
	lda #$a7b0
rlf_08f022
	sta.w race_scratch
rlf_08f025
	a8
rlf_08f027
	jsl retail_makeactor_l
rlf_08f02b
	bcs rlf_08f031
rlf_08f02d
	jml retail_scene_return
rlf_08f031
	jsl retail_copyactorpos_l
rlf_08f035
	a16
rlf_08f037
	lda.w al_worldy,y
rlf_08f03a
	clc
rlf_08f03b
	adc #$0032
rlf_08f03e
	sta.w al_worldy,y
rlf_08f041
	a8
rlf_08f043
	lda #$00
rlf_08f045
	ora #$80
rlf_08f047
	sta.w al_colframe,y
rlf_08f04a
	phx
rlf_08f04b
	tyx
rlf_08f04c
	ply
rlf_08f04d
	jsl retail_updateactorcell_l
rlf_08f051
	phx
rlf_08f052
	tyx
rlf_08f053
	ply
rlf_08f054
	pha
rlf_08f055
	a16
rlf_08f057
	tya
rlf_08f058
	sta.w al_ptr,x
rlf_08f05b
	a8
rlf_08f05d
	pla
rlf_08f05e
	a16
rlf_08f060
	lda #retail_carsequence_step&WM
rlf_08f063
	sta.w al_stratptr,x
rlf_08f066
	a8
rlf_08f068
	lda #retail_carsequence_step>>16
rlf_08f06a
	sta.w al_stratptr+2,x
rlf_08f06d
	a16
rlf_08f06f
	lda #$c6dc
rlf_08f072
	sta.w al_expshape,x
rlf_08f075
	a8
rlf_08f077
	jsl retail_makefragment_l
rlf_08f07b
	bpl rlf_08f080
rlf_08f07d
	jml retail_scene_return
rlf_08f080
	a16
rlf_08f082
	lda #$0640
rlf_08f085
	sta x1
rlf_08f087
	a8
rlf_08f089
	a16
rlf_08f08b
	lda #$0640
rlf_08f08e
	sta y1
rlf_08f090
	a8
rlf_08f092
	a16
rlf_08f094
	lda #$0640
rlf_08f097
	sta z1
rlf_08f099
	a8
rlf_08f09b
	jsl retail_setrawbounds_l
rlf_08f09f
	a16
rlf_08f0a1
	lda #$c100
rlf_08f0a4
	sta x1
rlf_08f0a6
	a8
rlf_08f0a8
	jsl retail_orrawtype_l
rlf_08f0ac
	lda #$14
rlf_08f0ae
	sta.w al_sbyte1,x
retail_carsequence_step
	lda.w race_carphase
rlf_08f0b4
	beq rlf_08f0e5
rlf_08f0b6
	ldy.w al_ptr,x
rlf_08f0b9
	a16
rlf_08f0bb
	lda #$a794
rlf_08f0be
	sta.w al_shape,y
rlf_08f0c1
	a8
rlf_08f0c3
	lda.w al_colframe,y
rlf_08f0c6
	and #$7f
rlf_08f0c8
	cmp #$07
rlf_08f0ca
	beq rlf_08f0ef
rlf_08f0cc
	lda.w al_colframe,y
rlf_08f0cf
	clc
rlf_08f0d0
	adc #$01
rlf_08f0d2
	bmi rlf_08f0d7
rlf_08f0d4
	clc
rlf_08f0d5
	adc #$08
rlf_08f0d7
	and #$7f
rlf_08f0d9
	cmp #$08
rlf_08f0db
	bcc rlf_08f0e0
rlf_08f0dd
	sec
rlf_08f0de
	sbc #$08
rlf_08f0e0
	ora #$80
rlf_08f0e2
	sta.w al_colframe,y
rlf_08f0e5
	jsl retail_publishbody_l
rlf_08f0e9
	lda #$03
rlf_08f0eb
	sta.w al_sbyte4,x
rlf_08f0ee
	rtl
rlf_08f0ef
	ldy.w race_playeractor
rlf_08f0f2
	a16
rlf_08f0f4
	lda #$a75c
rlf_08f0f7
	sta.w al_shape,y
rlf_08f0fa
	a8
rlf_08f0fc
	ldy.w al_ptr,x
rlf_08f0ff
	jsl rsc_03ccb0
rlf_08f103
	jsl retail_retireactor_l
rlf_08f107
	lda #$02
rlf_08f109
	sta.w race_carphase
rlf_08f10c
	rtl
	longa
	longi
retail_routeposition_l
	sta.w race_callback
rlf_08dc16
	phx
rlf_08dc17
	lda.l m_routebank
rlf_08dc1b
	a8
rlf_08dc1d
	and #$ff
rlf_08dc1f
	phb
rlf_08dc20
	pha
rlf_08dc21
	plb
rlf_08dc22
	a16
rlf_08dc24
	lda.w race_callback
rlf_08dc27
	dec a
rlf_08dc28
	asl a
rlf_08dc29
	asl a
rlf_08dc2a
	asl a
rlf_08dc2b
	clc
rlf_08dc2c
	adc.l m_routeptr
rlf_08dc30
	inc a
rlf_08dc31
	inc a
rlf_08dc32
	tax
rlf_08dc33
	lda.w $0000,x
rlf_08dc36
	sta.w race_callback
rlf_08dc39
	lda.w $0002,x
rlf_08dc3c
	sta.w race_visualoffset
rlf_08dc3f
	lda.w $0004,x
rlf_08dc42
	sta.w race_visualowner
rlf_08dc45
	plb
rlf_08dc46
	plx
rlf_08dc47
	rtl
retail_nextroute_l
	sta.w race_callback
rlf_08dc4b
	phx
rlf_08dc4c
	lda.l m_routebank
rlf_08dc50
	a8
rlf_08dc52
	and #$ff
rlf_08dc54
	phb
rlf_08dc55
	pha
rlf_08dc56
	plb
rlf_08dc57
	a16
rlf_08dc59
	lda.l m_routeptr
rlf_08dc5d
	tax
rlf_08dc5e
	lda.w race_callback
rlf_08dc61
	cmp.w $0000,x
rlf_08dc64
	bne rlf_08dc69
rlf_08dc66
	lda #$0000
rlf_08dc69
	inc a
rlf_08dc6a
	plb
rlf_08dc6b
	plx
rlf_08dc6c
	rtl
retail_fatalhdma
	db $54,$00,$01,$01,$01,$02,$01,$03,$01,$04,$01,$05,$01,$06,$01,$07
	db $01,$08,$01,$09,$01,$0a,$01,$0b,$01,$0c,$01,$0d,$01,$0e,$10,$0f
	db $01,$0e,$01,$0d,$01,$0c,$01,$0b,$01,$0a,$01,$09,$01,$08,$01,$07
	db $01,$06,$01,$05,$01,$04,$01,$03,$01,$02
retail_carshakes
	db $00,$ec,$e2,$d8,$d3,$ce,$c9,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6
	db $c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c6,$c9,$ce,$d3,$d8,$e2,$ec,$00

; Read the four native definition identities without moving the two existing
; audio-selection words. X is a byte offset 0,2,4,6; A16/I16; preserve C/V.
 longa
 longi
retail_readgriddef_l
 php
 cpx #4
 bcc .first
 plp
 lda.l race_def2-4,x
 rtl
.first
 plp
 lda.l race_def0,x
 rtl

; Resolve known native identities to the compiled RCAR definitions.
; Already compiled or other values retain the native unguarded contract.
 longa
retail_compiledef_l
 cmp #$81b9
 bne .next81b9
 lda #rcar81b9&WM
 rtl
.next81b9
 cmp #$82e5
 bne .next82e5
 lda #rcar82e5&WM
 rtl
.next82e5
 cmp #$8411
 bne .next8411
 lda #rcar8411&WM
 rtl
.next8411
 cmp #$853d
 bne .next853d
 lda #rcar853d&WM
 rtl
.next853d
 cmp #$8669
 bne .next8669
 lda #rcar8669&WM
 rtl
.next8669
 cmp #$876e
 bne .next876e
 lda #rcar876e&WM
 rtl
.next876e
 cmp #$8886
 bne .next8886
 lda #rcar8886&WM
 rtl
.next8886
 cmp #$8990
 bne .next8990
 lda #rcar8990&WM
 rtl
.next8990
 cmp #$8aa8
 bne .next8aa8
 lda #rcar8aa8&WM
 rtl
.next8aa8
 rtl

; A16 flags, X=CPU owner. Preserve constructor inputs across ID conversion.
; The existing composed entry creates raw, wheel and auxiliary records.
retail_spawncarid_l
 php
 a16
 pha
 lda.w al_sword1,x
 jsl retail_compiledef_l
 sta.w al_sword1,x
 pla
 plp
 jml retail_spawnvehicle_l
mrlife_end
