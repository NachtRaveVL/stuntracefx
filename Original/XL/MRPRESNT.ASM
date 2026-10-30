; Retail vehicle auxiliary actors and presentation strategies.
; A8/I16, direct page zero, binary arithmetic and DB=$7E unless noted.
; The native parent word is al_ptr. Raw strategy unions also use
; al_stratstate (native $2039), al_count ($2046), al_count1 ($204C)
; and al_HP ($204D), without moving any surviving record field.
; al_vx/vy/vz hold signed attachment offsets until a strategy reuses them.
; Shape and sprite words retain retail identities for caller asset binding.
; The compiled definition base replaces native $09:8090; relative offsets
; from the GSU constructor are unchanged. Callback triples are source code.
	incpublics	mrpresnt.ext
mrpresent_begin
	shorta
	longi
; US $03:C57C.
retail_actorrotz_l
	phy
rpr_03c57d
	phx
rpr_03c57e
	php
rpr_03c57f
	phb
rpr_03c580
	i8
rpr_03c582
	tax
rpr_03c583
	lda #$00
rpr_03c585
	pha
rpr_03c586
	plb
rpr_03c587
	lda.w costab&WM,x
rpr_03c58a
	sta.w race_trigbytes+1
rpr_03c58d
	lda.w sintab&WM,x
rpr_03c590
	sta.w race_trigbytes
rpr_03c593
	lda x1
rpr_03c595
	bmi rpr_03c5ad
rpr_03c597
	asl a
rpr_03c598
	sta.w $4202
rpr_03c59b
	lda.w race_trigbytes+1
rpr_03c59e
	bmi rpr_03c5d0
rpr_03c5a0
	sta.w $4203
rpr_03c5a3
	nop
rpr_03c5a4
	nop
rpr_03c5a5
	nop
rpr_03c5a6
	nop
rpr_03c5a7
	lda.w $4217
rpr_03c5aa
	jmp rpr_03c5de
rpr_03c5ad
	eor #$ff
rpr_03c5af
	inc a
rpr_03c5b0
	asl a
rpr_03c5b1
	sta.w $4202
rpr_03c5b4
	lda.w race_trigbytes+1
rpr_03c5b7
	bmi rpr_03c5c0
rpr_03c5b9
	sta.w $4203
rpr_03c5bc
	nop
rpr_03c5bd
	jmp rpr_03c5d8
rpr_03c5c0
	eor #$ff
rpr_03c5c2
	inc a
rpr_03c5c3
	sta.w $4203
rpr_03c5c6
	nop
rpr_03c5c7
	nop
rpr_03c5c8
	nop
rpr_03c5c9
	nop
rpr_03c5ca
	lda.w $4217
rpr_03c5cd
	jmp rpr_03c5de
rpr_03c5d0
	eor #$ff
rpr_03c5d2
	inc a
rpr_03c5d3
	sta.w $4203
rpr_03c5d6
	nop
rpr_03c5d7
	nop
rpr_03c5d8
	lda #$00
rpr_03c5da
	sec
rpr_03c5db
	sbc.w $4217
rpr_03c5de
	tax
rpr_03c5df
	stx x2
rpr_03c5e1
	lda y1
rpr_03c5e3
	bmi rpr_03c5fb
rpr_03c5e5
	asl a
rpr_03c5e6
	sta.w $4202
rpr_03c5e9
	lda.w race_trigbytes
rpr_03c5ec
	bmi rpr_03c61e
rpr_03c5ee
	sta.w $4203
rpr_03c5f1
	nop
rpr_03c5f2
	nop
rpr_03c5f3
	nop
rpr_03c5f4
	nop
rpr_03c5f5
	lda.w $4217
rpr_03c5f8
	jmp rpr_03c62c
rpr_03c5fb
	eor #$ff
rpr_03c5fd
	inc a
rpr_03c5fe
	asl a
rpr_03c5ff
	sta.w $4202
rpr_03c602
	lda.w race_trigbytes
rpr_03c605
	bmi rpr_03c60e
rpr_03c607
	sta.w $4203
rpr_03c60a
	nop
rpr_03c60b
	jmp rpr_03c626
rpr_03c60e
	eor #$ff
rpr_03c610
	inc a
rpr_03c611
	sta.w $4203
rpr_03c614
	nop
rpr_03c615
	nop
rpr_03c616
	nop
rpr_03c617
	nop
rpr_03c618
	lda.w $4217
rpr_03c61b
	jmp rpr_03c62c
rpr_03c61e
	eor #$ff
rpr_03c620
	inc a
rpr_03c621
	sta.w $4203
rpr_03c624
	nop
rpr_03c625
	nop
rpr_03c626
	lda #$00
rpr_03c628
	sec
rpr_03c629
	sbc.w $4217
rpr_03c62c
	tax
rpr_03c62d
	txa
rpr_03c62e
	clc
rpr_03c62f
	adc x2
rpr_03c631
	sta x2
rpr_03c633
	bit #$80
rpr_03c635
	beq rpr_03c63d
rpr_03c637
	lda #$ff
rpr_03c639
	sta x2+1
rpr_03c63b
	bra rpr_03c63f
rpr_03c63d
	stz x2+1
rpr_03c63f
	lda x1
rpr_03c641
	bmi rpr_03c659
rpr_03c643
	asl a
rpr_03c644
	sta.w $4202
rpr_03c647
	lda.w race_trigbytes
rpr_03c64a
	bmi rpr_03c67c
rpr_03c64c
	sta.w $4203
rpr_03c64f
	nop
rpr_03c650
	nop
rpr_03c651
	nop
rpr_03c652
	nop
rpr_03c653
	lda.w $4217
rpr_03c656
	jmp rpr_03c68a
rpr_03c659
	eor #$ff
rpr_03c65b
	inc a
rpr_03c65c
	asl a
rpr_03c65d
	sta.w $4202
rpr_03c660
	lda.w race_trigbytes
rpr_03c663
	bmi rpr_03c66c
rpr_03c665
	sta.w $4203
rpr_03c668
	nop
rpr_03c669
	jmp rpr_03c684
rpr_03c66c
	eor #$ff
rpr_03c66e
	inc a
rpr_03c66f
	sta.w $4203
rpr_03c672
	nop
rpr_03c673
	nop
rpr_03c674
	nop
rpr_03c675
	nop
rpr_03c676
	lda.w $4217
rpr_03c679
	jmp rpr_03c68a
rpr_03c67c
	eor #$ff
rpr_03c67e
	inc a
rpr_03c67f
	sta.w $4203
rpr_03c682
	nop
rpr_03c683
	nop
rpr_03c684
	lda #$00
rpr_03c686
	sec
rpr_03c687
	sbc.w $4217
rpr_03c68a
	tax
rpr_03c68b
	txa
rpr_03c68c
	eor #$ff
rpr_03c68e
	inc a
rpr_03c68f
	sta y2
rpr_03c691
	lda y1
rpr_03c693
	bmi rpr_03c6ab
rpr_03c695
	asl a
rpr_03c696
	sta.w $4202
rpr_03c699
	lda.w race_trigbytes+1
rpr_03c69c
	bmi rpr_03c6ce
rpr_03c69e
	sta.w $4203
rpr_03c6a1
	nop
rpr_03c6a2
	nop
rpr_03c6a3
	nop
rpr_03c6a4
	nop
rpr_03c6a5
	lda.w $4217
rpr_03c6a8
	jmp rpr_03c6dc
rpr_03c6ab
	eor #$ff
rpr_03c6ad
	inc a
rpr_03c6ae
	asl a
rpr_03c6af
	sta.w $4202
rpr_03c6b2
	lda.w race_trigbytes+1
rpr_03c6b5
	bmi rpr_03c6be
rpr_03c6b7
	sta.w $4203
rpr_03c6ba
	nop
rpr_03c6bb
	jmp rpr_03c6d6
rpr_03c6be
	eor #$ff
rpr_03c6c0
	inc a
rpr_03c6c1
	sta.w $4203
rpr_03c6c4
	nop
rpr_03c6c5
	nop
rpr_03c6c6
	nop
rpr_03c6c7
	nop
rpr_03c6c8
	lda.w $4217
rpr_03c6cb
	jmp rpr_03c6dc
rpr_03c6ce
	eor #$ff
rpr_03c6d0
	inc a
rpr_03c6d1
	sta.w $4203
rpr_03c6d4
	nop
rpr_03c6d5
	nop
rpr_03c6d6
	lda #$00
rpr_03c6d8
	sec
rpr_03c6d9
	sbc.w $4217
rpr_03c6dc
	tax
rpr_03c6dd
	txa
rpr_03c6de
	clc
rpr_03c6df
	adc y2
rpr_03c6e1
	sta y2
rpr_03c6e3
	bit #$80
rpr_03c6e5
	beq rpr_03c6ed
rpr_03c6e7
	lda #$ff
rpr_03c6e9
	sta y2+1
rpr_03c6eb
	bra rpr_03c6ef
rpr_03c6ed
	stz y2+1
rpr_03c6ef
	plb
rpr_03c6f0
	plp
rpr_03c6f1
	plx
rpr_03c6f2
	ply
rpr_03c6f3
	rtl
	longa
	longi
; US $03:CE30.
retail_easeactor8_l
	cmp tpx
rpr_03ce32
	bne rpr_03ce38
rpr_03ce34
	jml rsc_easereturn+4
rpr_03ce38
	sec
rpr_03ce39
	sbc tpx
rpr_03ce3b
	cmp #$0000
rpr_03ce3e
	bmi rpr_03ce4a
rpr_03ce40
	cmp #$0008
rpr_03ce43
	bpl rpr_03ce52
rpr_03ce45
	lda #$0008
rpr_03ce48
	bra rpr_03ce52
rpr_03ce4a
	cmp #$fff8
rpr_03ce4d
	bmi rpr_03ce52
rpr_03ce4f
	lda #$fff8
rpr_03ce52
	cmp #$8000
rpr_03ce55
	ror a
rpr_03ce56
	bpl rpr_03ce5b
rpr_03ce58
	adc #$0000
rpr_03ce5b
	cmp #$8000
rpr_03ce5e
	ror a
rpr_03ce5f
	bpl rpr_03ce64
rpr_03ce61
	adc #$0000
rpr_03ce64
	cmp #$8000
rpr_03ce67
	ror a
rpr_03ce68
	bpl rpr_03ce6d
rpr_03ce6a
	adc #$0000
rpr_03ce6d
	clc
rpr_03ce6e
	adc tpx
rpr_03ce70
	sta tpx
rpr_03ce72
	brl rsc_easereturn
	shorta
	longi
; US $03:D07C.
retail_easeangle_l
	cmp tpx
rpr_03d07e
	bne rpr_03d084
rpr_03d080
	jml rsc_easereturn+4
rpr_03d084
	sec
rpr_03d085
	sbc tpx
rpr_03d087
	cmp #$00
rpr_03d089
	bmi rpr_03d093
rpr_03d08b
	cmp #$10
rpr_03d08d
	bpl rpr_03d099
rpr_03d08f
	lda #$10
rpr_03d091
	bra rpr_03d099
rpr_03d093
	cmp #$f0
rpr_03d095
	bmi rpr_03d099
rpr_03d097
	lda #$f0
rpr_03d099
	cmp #$80
rpr_03d09b
	ror a
rpr_03d09c
	bpl rpr_03d0a0
rpr_03d09e
	adc #$00
rpr_03d0a0
	cmp #$80
rpr_03d0a2
	ror a
rpr_03d0a3
	bpl rpr_03d0a7
rpr_03d0a5
	adc #$00
rpr_03d0a7
	cmp #$80
rpr_03d0a9
	ror a
rpr_03d0aa
	bpl rpr_03d0ae
rpr_03d0ac
	adc #$00
rpr_03d0ae
	cmp #$80
rpr_03d0b0
	ror a
rpr_03d0b1
	bpl rpr_03d0b5
rpr_03d0b3
	adc #$00
rpr_03d0b5
	clc
rpr_03d0b6
	adc tpx
rpr_03d0b8
	sta tpx
rpr_03d0ba
	brl rsc_easereturn
	shorta
	longi
; US $03:D1FD.
retail_followactor_l
	a16
rpr_03d1ff
	lda.w al_worldx,y
rpr_03d202
	sta.w al_worldx,x
rpr_03d205
	lda.w al_worldy,y
rpr_03d208
	sta.w al_worldy,x
rpr_03d20b
	lda.w al_worldz,y
rpr_03d20e
	sta.w al_worldz,x
rpr_03d211
	a8
rpr_03d213
	rtl
retail_copyactorangles_l
	lda.w al_rotx,x
rpr_03d217
	sta.w al_rotx,y
rpr_03d21a
	lda.w al_roty,x
rpr_03d21d
	sta.w al_roty,y
rpr_03d220
	lda.w al_rotz,x
rpr_03d223
	sta.w al_rotz,y
rpr_03d226
	rtl
retail_followactorangles_l
	lda.w al_rotx,y
rpr_03d22a
	sta.w al_rotx,x
rpr_03d22d
	lda.w al_roty,y
rpr_03d230
	sta.w al_roty,x
rpr_03d233
	lda.w al_rotz,y
rpr_03d236
	sta.w al_rotz,x
rpr_03d239
	rtl
	shorta
	longi
; US $08:B9C8.
retail_finishcar_l
	jsl retail_makewheels_l
rpr_08b9cc
	jsl retail_makeattachments_l
rpr_08b9d0
	lda #$03
rpr_08b9d2
	sta.w al_count,x
rpr_08b9d5
	lda #$01
rpr_08b9d7
	sta.w al_HP,x
rpr_08b9da
	a8
rpr_08b9dc
	rtl
retail_createfollowercar_l
	a16
rpr_08b9df
	a8
rpr_08b9e1
	phx
rpr_08b9e2
	phy
rpr_08b9e3
	lda #mretail_spawncar>>16
rpr_08b9e5
	ldx #mretail_spawncar&WM
rpr_08b9e8
	jsl retail_rawtask_l
rpr_08b9ec
	ply
rpr_08b9ed
	plx
rpr_08b9ee
	a16
rpr_08b9f0
	lda.l m_dynvar2
rpr_08b9f4
	sta.w al_shape,x
rpr_08b9f7
	a8
rpr_08b9f9
	a16
rpr_08b9fb
	lda.l m_dynvar1
rpr_08b9ff
	bne rpr_08ba04
rpr_08ba01
	brl retail_scene_return
rpr_08ba04
	sta.w al_collobjptr,x
rpr_08ba07
	txy
rpr_08ba08
	lda.l m_dynvar1
rpr_08ba0c
	tax
rpr_08ba0d
	lda.w al_worldx,y
rpr_08ba10
	sta.l $70001e,x
rpr_08ba14
	lda.w al_worldy,y
rpr_08ba17
	sta.l $700020,x
rpr_08ba1b
	lda.w al_worldz,y
rpr_08ba1e
	sta.l m_bigy,x
rpr_08ba22
	lda.w al_roty,y
rpr_08ba25
	and #$00ff
rpr_08ba28
	xba
rpr_08ba29
	sta.l $700024,x
rpr_08ba2d
	tyx
rpr_08ba2e
	a8
rpr_08ba30
	a16
rpr_08ba32
	lda #$008c
rpr_08ba35
	sta.w al_expposx,x
rpr_08ba38
	a8
rpr_08ba3a
	a16
rpr_08ba3c
	lda #$003c
rpr_08ba3f
	sta.w al_expposy,x
rpr_08ba42
	a8
rpr_08ba44
	a16
rpr_08ba46
	lda #$008c
rpr_08ba49
	sta.w al_expposz,x
rpr_08ba4c
	a8
rpr_08ba4e
	jsl retail_synctoraw_l
rpr_08ba52
	jsl retail_makewheels_l
rpr_08ba56
	rtl
	shorta
	longi
; US $08:D09E.
retail_turnsprite0_l
	lda #$00
rpr_08d0a0
	ora #$80
rpr_08d0a2
	sta.w al_sflags3,x
rpr_08d0a5
	lda #$30
rpr_08d0a7
	sta.w al_roty,x
rpr_08d0aa
	bra rpr_08d0cf
retail_turnsprite1_l
	lda #$01
rpr_08d0ae
	ora #$80
rpr_08d0b0
	sta.w al_sflags3,x
rpr_08d0b3
	lda #$20
rpr_08d0b5
	sta.w al_roty,x
rpr_08d0b8
	bra rpr_08d0cf
retail_turnsprite2_l
	lda #$02
rpr_08d0bc
	ora #$80
rpr_08d0be
	sta.w al_sflags3,x
rpr_08d0c1
	lda #$10
rpr_08d0c3
	sta.w al_roty,x
rpr_08d0c6
	bra rpr_08d0cf
retail_turnsprite3_l
	lda #$03
rpr_08d0ca
	ora #$80
rpr_08d0cc
	sta.w al_sflags3,x
rpr_08d0cf
	a16
rpr_08d0d1
	lda #retail_turnsprite_step&WM
rpr_08d0d4
	sta.w al_stratptr,x
rpr_08d0d7
	a8
rpr_08d0d9
	lda #mrpresent_begin>>16
rpr_08d0db
	sta.w al_stratptr+2,x
retail_turnsprite_step
	lda.w al_roty,x
rpr_08d0e1
	clc
rpr_08d0e2
	adc #$08
rpr_08d0e4
	sta.w al_roty,x
rpr_08d0e7
	rtl
retail_surfaceactor_l
	a16
rpr_08d0ea
	lda #retail_surfaceactor_step&WM
rpr_08d0ed
	sta.w al_stratptr,x
rpr_08d0f0
	a8
rpr_08d0f2
	lda #mrpresent_begin>>16
rpr_08d0f4
	sta.w al_stratptr+2,x
retail_surfaceactor_step
	jsl retail_publishbody_l
rpr_08d0fb
	lda.w al_sflags,x
rpr_08d0fe
	and #$fd
rpr_08d100
	sta.w al_sflags,x
rpr_08d103
	txy
rpr_08d104
	ldx.w race_playeractor
rpr_08d107
	a16
rpr_08d109
	lda.w al_collobjptr,x
rpr_08d10c
	tax
rpr_08d10d
	lda.l $700058,x
rpr_08d111
	cmp.w al_sword2,y
rpr_08d114
	a8
rpr_08d116
	bne rpr_08d148
rpr_08d118
	lda.w al_sflags,y
rpr_08d11b
	ora #$02
rpr_08d11d
	sta.w al_sflags,y
rpr_08d120
	a16
rpr_08d122
	lda.w al_worldy,y
rpr_08d125
	eor #$ffff
rpr_08d128
	inc a
rpr_08d129
	cmp #$8000
rpr_08d12c
	ror a
rpr_08d12d
	cmp #$8000
rpr_08d130
	ror a
rpr_08d131
	cmp #$8000
rpr_08d134
	ror a
rpr_08d135
	cmp #$8000
rpr_08d138
	ror a
rpr_08d139
	cmp #$8000
rpr_08d13c
	ror a
rpr_08d13d
	sta.w race_groundheight
rpr_08d140
	lda.w al_sword2,y
rpr_08d143
	sta.w race_groundindex
rpr_08d146
	a8
rpr_08d148
	tyx
rpr_08d149
	rtl
	shorta
	longi
; US $08:D61B.
retail_makeburst_l
	lda #$0f
rpr_08d61d
	pha
rpr_08d61e
	a16
rpr_08d620
	lda #$a1ac
rpr_08d623
	sta.w race_scratch
rpr_08d626
	a8
rpr_08d628
	jsl retail_makeactor_l
rpr_08d62c
	bcs rpr_08d632
rpr_08d62e
	jml rpr_08d64f
rpr_08d632
	jsl retail_copyactorpos_l
rpr_08d636
	pha
rpr_08d637
	a16
rpr_08d639
	txa
rpr_08d63a
	sta.w al_ptr,y
rpr_08d63d
	a8
rpr_08d63f
	pla
rpr_08d640
	a16
rpr_08d642
	lda #retail_wheelburst_l&WM
rpr_08d645
	sta.w al_stratptr,y
rpr_08d648
	a8
rpr_08d64a
	lda #mrpresent_begin>>16
rpr_08d64c
	sta.w al_stratptr+2,y
rpr_08d64f
	pla
rpr_08d650
	dec a
rpr_08d651
	bne rpr_08d61d
rpr_08d653
	rtl
retail_makecolumn_l
	a16
rpr_08d656
	lda.w al_worldy,x
rpr_08d659
	clc
rpr_08d65a
	adc #$ff88
rpr_08d65d
	sta.w al_worldy,x
rpr_08d660
	a8
rpr_08d662
	lda.w al_sflags,x
rpr_08d665
	ora #$08
rpr_08d667
	sta.w al_sflags,x
rpr_08d66a
	lda #$00
rpr_08d66c
	sta.w al_lapcnt,x
rpr_08d66f
	lda #$28
rpr_08d671
	sta.w al_eyesize,x
rpr_08d674
	a16
rpr_08d676
	lda #$9971
rpr_08d679
	sta.w al_coltab,x
rpr_08d67c
	a8
rpr_08d67e
	a16
rpr_08d680
	lda #$a078
rpr_08d683
	sta.w race_scratch
rpr_08d686
	a8
rpr_08d688
	jsl retail_makeactor_l
rpr_08d68c
	bcs rpr_08d692
rpr_08d68e
	jml rpr_08d6c0
rpr_08d692
	lda.w al_sflags,y
rpr_08d695
	ora #$08
rpr_08d697
	sta.w al_sflags,y
rpr_08d69a
	lda #$00
rpr_08d69c
	sta.w al_lapcnt,y
rpr_08d69f
	lda #$50
rpr_08d6a1
	sta.w al_eyesize,y
rpr_08d6a4
	a16
rpr_08d6a6
	lda #$9973
rpr_08d6a9
	sta.w al_coltab,y
rpr_08d6ac
	a8
rpr_08d6ae
	jsl retail_copyactorpos_l
rpr_08d6b2
	a16
rpr_08d6b4
	lda.w al_worldy,y
rpr_08d6b7
	clc
rpr_08d6b8
	adc #$fec0
rpr_08d6bb
	sta.w al_worldy,y
rpr_08d6be
	a8
rpr_08d6c0
	a16
rpr_08d6c2
	lda #$0000
rpr_08d6c5
	sta.w al_stratptr,x
rpr_08d6c8
	a8
rpr_08d6ca
	lda #$00
rpr_08d6cc
	sta.w al_stratptr+2,x
rpr_08d6cf
	rtl
rpr_08d6d0
	a16
rpr_08d6d2
	lda.w al_worldy,x
rpr_08d6d5
	clc
rpr_08d6d6
	adc #$ffba
rpr_08d6d9
	sta.w al_worldy,x
rpr_08d6dc
	a8
rpr_08d6de
	a16
rpr_08d6e0
	lda #$9975
rpr_08d6e3
	sta.w al_coltab,x
rpr_08d6e6
	a8
rpr_08d6e8
	lda.w al_sflags,x
rpr_08d6eb
	ora #$08
rpr_08d6ed
	sta.w al_sflags,x
rpr_08d6f0
	lda #$00
rpr_08d6f2
	sta.w al_lapcnt,x
rpr_08d6f5
	lda #$1e
rpr_08d6f7
	sta.w al_eyesize,x
rpr_08d6fa
	a16
rpr_08d6fc
	lda #$a104
rpr_08d6ff
	sta.w race_scratch
rpr_08d702
	a8
rpr_08d704
	jsl retail_makeactor_l
rpr_08d708
	bcs rpr_08d70e
rpr_08d70a
	jml rpr_08d746
rpr_08d70e
	lda.w al_sflags,y
rpr_08d711
	ora #$08
rpr_08d713
	sta.w al_sflags,y
rpr_08d716
	lda #$00
rpr_08d718
	sta.w al_lapcnt,y
rpr_08d71b
	lda #$32
rpr_08d71d
	sta.w al_eyesize,y
rpr_08d720
	a16
rpr_08d722
	lda #$9975
rpr_08d725
	sta.w al_coltab,y
rpr_08d728
	a8
rpr_08d72a
	jsl retail_copyactorpos_l
rpr_08d72e
	a16
rpr_08d730
	lda.w al_worldy,y
rpr_08d733
	clc
rpr_08d734
	adc #$fd44
rpr_08d737
	sta.w al_worldy,y
rpr_08d73a
	a8
rpr_08d73c
	phx
rpr_08d73d
	tyx
rpr_08d73e
	ply
rpr_08d73f
	jsl retail_updateactorcell_l
rpr_08d743
	phx
rpr_08d744
	tyx
rpr_08d745
	ply
rpr_08d746
	a16
rpr_08d748
	lda #$a104
rpr_08d74b
	sta.w race_scratch
rpr_08d74e
	a8
rpr_08d750
	jsl retail_makeactor_l
rpr_08d754
	bcs rpr_08d75a
rpr_08d756
	jml rpr_08d792
rpr_08d75a
	lda.w al_sflags,y
rpr_08d75d
	ora #$08
rpr_08d75f
	sta.w al_sflags,y
rpr_08d762
	lda #$00
rpr_08d764
	sta.w al_lapcnt,y
rpr_08d767
	lda #$32
rpr_08d769
	sta.w al_eyesize,y
rpr_08d76c
	a16
rpr_08d76e
	lda #$9975
rpr_08d771
	sta.w al_coltab,y
rpr_08d774
	a8
rpr_08d776
	jsl retail_copyactorpos_l
rpr_08d77a
	a16
rpr_08d77c
	lda.w al_worldy,y
rpr_08d77f
	clc
rpr_08d780
	adc #$fa88
rpr_08d783
	sta.w al_worldy,y
rpr_08d786
	a8
rpr_08d788
	phx
rpr_08d789
	tyx
rpr_08d78a
	ply
rpr_08d78b
	jsl retail_updateactorcell_l
rpr_08d78f
	phx
rpr_08d790
	tyx
rpr_08d791
	ply
rpr_08d792
	a16
rpr_08d794
	lda #$0000
rpr_08d797
	sta.w al_stratptr,x
rpr_08d79a
	a8
rpr_08d79c
	lda #$00
rpr_08d79e
	sta.w al_stratptr+2,x
rpr_08d7a1
	rtl
retail_loweredsprite_l
	a16
rpr_08d7a4
	lda #$9b8f
rpr_08d7a7
	sta.w al_coltab,x
rpr_08d7aa
	a8
rpr_08d7ac
	a16
rpr_08d7ae
	lda.w al_worldy,x
rpr_08d7b1
	clc
rpr_08d7b2
	adc #$ffe2
rpr_08d7b5
	sta.w al_worldy,x
rpr_08d7b8
	a8
rpr_08d7ba
	bra retail_staticsprite_l
retail_fallingsprite_l
	bra rpr_08d7c0
rpr_fallingsprite2
	bra rpr_08d7c0
rpr_08d7c0
	a16
rpr_08d7c2
	lda.w al_worldy,x
rpr_08d7c5
	clc
rpr_08d7c6
	adc #$fed4
rpr_08d7c9
	sta.w al_worldy,x
rpr_08d7cc
	a8
rpr_08d7ce
	a16
rpr_08d7d0
	lda #rpr_fallingsprite_init&WM
rpr_08d7d3
	sta.w al_tempstratptr,x
rpr_08d7d6
	a8
rpr_08d7d8
	lda #mrpresent_begin>>16
rpr_08d7da
	sta.w al_tempstratptr+2,x
rpr_08d7dd
	lda.w al_sflags,x
rpr_08d7e0
	ora #$08
rpr_08d7e2
	sta.w al_sflags,x
rpr_08d7e5
	lda #$00
rpr_08d7e7
	sta.w al_lapcnt,x
rpr_08d7ea
	lda #$14
rpr_08d7ec
	sta.w al_eyesize,x
rpr_08d7ef
	a16
rpr_08d7f1
	lda #$ff9c
rpr_08d7f4
	sta.w al_vy,x
rpr_08d7f7
	a8
rpr_08d7f9
	a16
rpr_08d7fb
	lda #retail_fallingsprite_step&WM
rpr_08d7fe
	sta.w al_stratptr,x
rpr_08d801
	a8
rpr_08d803
	lda #mrpresent_begin>>16
rpr_08d805
	sta.w al_stratptr+2,x
rpr_fallingsprite_init
	jsl retail_makedragbody_l
rpr_08d80c
	jsl retail_makecollidable_l
rpr_08d810
	lda #$20
rpr_08d812
	jsl retail_setrawmass_l
retail_fallingsprite_step
	jsl retail_publishbody_l
rpr_08d81a
	rtl
retail_staticsprite_l
	lda.w al_sflags,x
rpr_08d81e
	ora #$08
rpr_08d820
	sta.w al_sflags,x
rpr_08d823
	lda #$00
rpr_08d825
	sta.w al_lapcnt,x
rpr_08d828
	lda #$14
rpr_08d82a
	sta.w al_eyesize,x
rpr_08d82d
	a16
rpr_08d82f
	lda #$0000
rpr_08d832
	sta.w al_stratptr,x
rpr_08d835
	a8
rpr_08d837
	lda #$00
rpr_08d839
	sta.w al_stratptr+2,x
rpr_08d83c
	rtl
	shorta
	longi
; US $08:D8E4.
rpr_makepanels
	phx
rpr_08d8e5
	phy
rpr_08d8e6
	tyx
rpr_08d8e7
	a16
rpr_08d8e9
	lda #$a660
rpr_08d8ec
	sta.w race_scratch
rpr_08d8ef
	a8
rpr_08d8f1
	jsl retail_makeactor_l
rpr_08d8f5
	bcs rpr_08d8fb
rpr_08d8f7
	jml rpr_08d939
rpr_08d8fb
	a16
rpr_08d8fd
	lda #retail_floatpanel_l&WM
rpr_08d900
	sta.w al_stratptr,y
rpr_08d903
	a8
rpr_08d905
	lda #mrpresent_begin>>16
rpr_08d907
	sta.w al_stratptr+2,y
rpr_08d90a
	a16
rpr_08d90c
	lda #$fe3e
rpr_08d90f
	sta.w al_vx,y
rpr_08d912
	lda #$03e8
rpr_08d915
	sta.w al_vy,y
rpr_08d918
	lda #$1770
rpr_08d91b
	sta.w al_vz,y
rpr_08d91e
	a8
rpr_08d920
	a16
rpr_08d922
	lda #$fc7c
rpr_08d925
	sta.w al_sword2,y
rpr_08d928
	a8
rpr_08d92a
	pha
rpr_08d92b
	a16
rpr_08d92d
	txa
rpr_08d92e
	sta.w al_sword1,y
rpr_08d931
	a8
rpr_08d933
	pla
rpr_08d934
	lda #$00
rpr_08d936
	sta.w al_roty,y
rpr_08d939
	a16
rpr_08d93b
	lda #$a67c
rpr_08d93e
	sta.w race_scratch
rpr_08d941
	a8
rpr_08d943
	jsl retail_makeactor_l
rpr_08d947
	bcs rpr_08d94d
rpr_08d949
	jml rpr_08d98b
rpr_08d94d
	a16
rpr_08d94f
	lda #retail_floatpanel_l&WM
rpr_08d952
	sta.w al_stratptr,y
rpr_08d955
	a8
rpr_08d957
	lda #mrpresent_begin>>16
rpr_08d959
	sta.w al_stratptr+2,y
rpr_08d95c
	a16
rpr_08d95e
	lda #$ff6a
rpr_08d961
	sta.w al_vx,y
rpr_08d964
	lda #$03e8
rpr_08d967
	sta.w al_vy,y
rpr_08d96a
	lda #$1770
rpr_08d96d
	sta.w al_vz,y
rpr_08d970
	a8
rpr_08d972
	a16
rpr_08d974
	lda #$fc7c
rpr_08d977
	sta.w al_sword2,y
rpr_08d97a
	a8
rpr_08d97c
	pha
rpr_08d97d
	a16
rpr_08d97f
	txa
rpr_08d980
	sta.w al_sword1,y
rpr_08d983
	a8
rpr_08d985
	pla
rpr_08d986
	lda #$fc
rpr_08d988
	sta.w al_roty,y
rpr_08d98b
	a16
rpr_08d98d
	lda #$a698
rpr_08d990
	sta.w race_scratch
rpr_08d993
	a8
rpr_08d995
	jsl retail_makeactor_l
rpr_08d999
	bcs rpr_08d99f
rpr_08d99b
	jml rpr_08d9dd
rpr_08d99f
	a16
rpr_08d9a1
	lda #retail_floatpanel_l&WM
rpr_08d9a4
	sta.w al_stratptr,y
rpr_08d9a7
	a8
rpr_08d9a9
	lda #mrpresent_begin>>16
rpr_08d9ab
	sta.w al_stratptr+2,y
rpr_08d9ae
	a16
rpr_08d9b0
	lda #$0096
rpr_08d9b3
	sta.w al_vx,y
rpr_08d9b6
	lda #$03e8
rpr_08d9b9
	sta.w al_vy,y
rpr_08d9bc
	lda #$1770
rpr_08d9bf
	sta.w al_vz,y
rpr_08d9c2
	a8
rpr_08d9c4
	a16
rpr_08d9c6
	lda #$fc7c
rpr_08d9c9
	sta.w al_sword2,y
rpr_08d9cc
	a8
rpr_08d9ce
	pha
rpr_08d9cf
	a16
rpr_08d9d1
	txa
rpr_08d9d2
	sta.w al_sword1,y
rpr_08d9d5
	a8
rpr_08d9d7
	pla
rpr_08d9d8
	lda #$f8
rpr_08d9da
	sta.w al_roty,y
rpr_08d9dd
	a16
rpr_08d9df
	lda #$a6b4
rpr_08d9e2
	sta.w race_scratch
rpr_08d9e5
	a8
rpr_08d9e7
	jsl retail_makeactor_l
rpr_08d9eb
	bcs rpr_08d9f1
rpr_08d9ed
	jml rpr_08da2f
rpr_08d9f1
	a16
rpr_08d9f3
	lda #retail_floatpanel_l&WM
rpr_08d9f6
	sta.w al_stratptr,y
rpr_08d9f9
	a8
rpr_08d9fb
	lda #mrpresent_begin>>16
rpr_08d9fd
	sta.w al_stratptr+2,y
rpr_08da00
	a16
rpr_08da02
	lda #$01c2
rpr_08da05
	sta.w al_vx,y
rpr_08da08
	lda #$03e8
rpr_08da0b
	sta.w al_vy,y
rpr_08da0e
	lda #$1770
rpr_08da11
	sta.w al_vz,y
rpr_08da14
	a8
rpr_08da16
	a16
rpr_08da18
	lda #$fc7c
rpr_08da1b
	sta.w al_sword2,y
rpr_08da1e
	a8
rpr_08da20
	pha
rpr_08da21
	a16
rpr_08da23
	txa
rpr_08da24
	sta.w al_sword1,y
rpr_08da27
	a8
rpr_08da29
	pla
rpr_08da2a
	lda #$f4
rpr_08da2c
	sta.w al_roty,y
rpr_08da2f
	a16
rpr_08da31
	lda #$a6d0
rpr_08da34
	sta.w race_scratch
rpr_08da37
	a8
rpr_08da39
	jsl retail_makeactor_l
rpr_08da3d
	bcs rpr_08da43
rpr_08da3f
	jml rpr_08da81
rpr_08da43
	a16
rpr_08da45
	lda #retail_floatpanel_l&WM
rpr_08da48
	sta.w al_stratptr,y
rpr_08da4b
	a8
rpr_08da4d
	lda #mrpresent_begin>>16
rpr_08da4f
	sta.w al_stratptr+2,y
rpr_08da52
	a16
rpr_08da54
	lda #$fe3e
rpr_08da57
	sta.w al_vx,y
rpr_08da5a
	lda #$03e8
rpr_08da5d
	sta.w al_vy,y
rpr_08da60
	lda #$1770
rpr_08da63
	sta.w al_vz,y
rpr_08da66
	a8
rpr_08da68
	a16
rpr_08da6a
	lda #$fe70
rpr_08da6d
	sta.w al_sword2,y
rpr_08da70
	a8
rpr_08da72
	pha
rpr_08da73
	a16
rpr_08da75
	txa
rpr_08da76
	sta.w al_sword1,y
rpr_08da79
	a8
rpr_08da7b
	pla
rpr_08da7c
	lda #$f0
rpr_08da7e
	sta.w al_roty,y
rpr_08da81
	a16
rpr_08da83
	lda #$a6ec
rpr_08da86
	sta.w race_scratch
rpr_08da89
	a8
rpr_08da8b
	jsl retail_makeactor_l
rpr_08da8f
	bcs rpr_08da95
rpr_08da91
	jml rpr_08dad3
rpr_08da95
	a16
rpr_08da97
	lda #retail_floatpanel_l&WM
rpr_08da9a
	sta.w al_stratptr,y
rpr_08da9d
	a8
rpr_08da9f
	lda #mrpresent_begin>>16
rpr_08daa1
	sta.w al_stratptr+2,y
rpr_08daa4
	a16
rpr_08daa6
	lda #$ff6a
rpr_08daa9
	sta.w al_vx,y
rpr_08daac
	lda #$03e8
rpr_08daaf
	sta.w al_vy,y
rpr_08dab2
	lda #$1770
rpr_08dab5
	sta.w al_vz,y
rpr_08dab8
	a8
rpr_08daba
	a16
rpr_08dabc
	lda #$fe70
rpr_08dabf
	sta.w al_sword2,y
rpr_08dac2
	a8
rpr_08dac4
	pha
rpr_08dac5
	a16
rpr_08dac7
	txa
rpr_08dac8
	sta.w al_sword1,y
rpr_08dacb
	a8
rpr_08dacd
	pla
rpr_08dace
	lda #$ec
rpr_08dad0
	sta.w al_roty,y
rpr_08dad3
	a16
rpr_08dad5
	lda #$a6b4
rpr_08dad8
	sta.w race_scratch
rpr_08dadb
	a8
rpr_08dadd
	jsl retail_makeactor_l
rpr_08dae1
	bcs rpr_08dae7
rpr_08dae3
	jml rpr_08db25
rpr_08dae7
	a16
rpr_08dae9
	lda #retail_floatpanel_l&WM
rpr_08daec
	sta.w al_stratptr,y
rpr_08daef
	a8
rpr_08daf1
	lda #mrpresent_begin>>16
rpr_08daf3
	sta.w al_stratptr+2,y
rpr_08daf6
	a16
rpr_08daf8
	lda #$0096
rpr_08dafb
	sta.w al_vx,y
rpr_08dafe
	lda #$03e8
rpr_08db01
	sta.w al_vy,y
rpr_08db04
	lda #$1770
rpr_08db07
	sta.w al_vz,y
rpr_08db0a
	a8
rpr_08db0c
	a16
rpr_08db0e
	lda #$fe70
rpr_08db11
	sta.w al_sword2,y
rpr_08db14
	a8
rpr_08db16
	pha
rpr_08db17
	a16
rpr_08db19
	txa
rpr_08db1a
	sta.w al_sword1,y
rpr_08db1d
	a8
rpr_08db1f
	pla
rpr_08db20
	lda #$e8
rpr_08db22
	sta.w al_roty,y
rpr_08db25
	a16
rpr_08db27
	lda #$a708
rpr_08db2a
	sta.w race_scratch
rpr_08db2d
	a8
rpr_08db2f
	jsl retail_makeactor_l
rpr_08db33
	bcs rpr_08db39
rpr_08db35
	jml rpr_08db77
rpr_08db39
	a16
rpr_08db3b
	lda #retail_floatpanel_l&WM
rpr_08db3e
	sta.w al_stratptr,y
rpr_08db41
	a8
rpr_08db43
	lda #mrpresent_begin>>16
rpr_08db45
	sta.w al_stratptr+2,y
rpr_08db48
	a16
rpr_08db4a
	lda #$01c2
rpr_08db4d
	sta.w al_vx,y
rpr_08db50
	lda #$03e8
rpr_08db53
	sta.w al_vy,y
rpr_08db56
	lda #$1770
rpr_08db59
	sta.w al_vz,y
rpr_08db5c
	a8
rpr_08db5e
	a16
rpr_08db60
	lda #$fe70
rpr_08db63
	sta.w al_sword2,y
rpr_08db66
	a8
rpr_08db68
	pha
rpr_08db69
	a16
rpr_08db6b
	txa
rpr_08db6c
	sta.w al_sword1,y
rpr_08db6f
	a8
rpr_08db71
	pla
rpr_08db72
	lda #$e4
rpr_08db74
	sta.w al_roty,y
rpr_08db77
	ply
rpr_08db78
	plx
rpr_08db79
	rts
retail_floatpanel_l
	a16
rpr_08db7c
	lda #retail_floatpanel_step&WM
rpr_08db7f
	sta.w al_stratptr,x
rpr_08db82
	a8
rpr_08db84
	lda #mrpresent_begin>>16
rpr_08db86
	sta.w al_stratptr+2,x
rpr_08db89
	jsl retail_random_l
rpr_08db8d
	sta.w al_rotx,x
retail_floatpanel_step
	lda.w al_rotx,x
rpr_08db93
	sta tpx
rpr_08db95
	lda #$00
rpr_08db97
	jsl retail_easeangle_l
rpr_08db9b
	sta.w al_rotx,x
rpr_08db9e
	lda.w al_roty,x
rpr_08dba1
	clc
rpr_08dba2
	adc #$08
rpr_08dba4
	sta.w al_roty,x
rpr_08dba7
	ldy.w al_sword1,x
rpr_08dbaa
	jsl retail_followactor_l
rpr_08dbae
	jsl retail_moveactor_l
rpr_08dbb2
	a16
rpr_08dbb4
	lda.w al_vy,x
rpr_08dbb7
	sta tpx
rpr_08dbb9
	lda.w al_sword2,x
rpr_08dbbc
	jsl retail_easeactor8_l
rpr_08dbc0
	sta.w al_vy,x
rpr_08dbc3
	a8
rpr_08dbc5
	a16
rpr_08dbc7
	lda.w al_vz,x
rpr_08dbca
	sta tpx
rpr_08dbcc
	lda #$05dc
rpr_08dbcf
	jsl retail_easeactor8_l
rpr_08dbd3
	sta.w al_vz,x
rpr_08dbd6
	a8
rpr_08dbd8
	rtl
retail_checkactornear_l
	lda.w al_sflags2,x
rpr_08dbdc
	and #$01
rpr_08dbde
	beq rpr_08dbe4
rpr_08dbe0
	jml rpr_08dc12
rpr_08dbe4
	ldy.w race_playeractor
rpr_08dbe7
	a16
rpr_08dbe9
	lda.w al_worldz,y
rpr_08dbec
	sec
rpr_08dbed
	sbc.w al_worldz,x
rpr_08dbf0
	bpl rpr_08dbf6
rpr_08dbf2
	eor #$ffff
rpr_08dbf5
	inc a
rpr_08dbf6
	cmp #$01f4
rpr_08dbf9
	a8
rpr_08dbfb
	bpl rpr_08dc12
rpr_08dbfd
	lda.w al_count1,y
rpr_08dc00
	inc a
rpr_08dc01
	sta.w al_count1,y
rpr_08dc04
	cmp #$01
rpr_08dc06
	beq rpr_08dc0a
rpr_08dc08
	bra rpr_08dc0a
rpr_08dc0a
	lda.w al_sflags2,x
rpr_08dc0d
	ora #$01
rpr_08dc0f
	sta.w al_sflags2,x
rpr_08dc12
	rtl
	shorta
	longi
; US $08:DCB4.
retail_makeattachments_l
	stx.w race_callback
rpr_08dcb7
	a16
rpr_08dcb9
	lda.l m_dynvar3
rpr_08dcbd
	tax
rpr_08dcbe
	a8
rpr_08dcc0
	lda.l rcardefs_begin-$a4,x
rpr_08dcc4
	bne rpr_08dcc9
rpr_08dcc6
	brl rpr_08dd89
rpr_08dcc9
	inx
rpr_08dcca
	pha
rpr_08dccb
	a16
rpr_08dccd
	lda #$a040
rpr_08dcd0
	sta.w race_scratch
rpr_08dcd3
	a8
rpr_08dcd5
	jsl retail_makeactor_l
rpr_08dcd9
	bcs rpr_08dcdf
rpr_08dcdb
	jml rpr_08dd78
rpr_08dcdf
	phx
rpr_08dce0
	a16
rpr_08dce2
	lda.w race_callback
rpr_08dce5
	sta.w al_ptr,y
rpr_08dce8
	lda.l rcardefs_begin-$a4,x
rpr_08dcec
	tax
rpr_08dced
	lda.l retail_visualdefs,x
rpr_08dcf1
	sta.w al_shape,y
rpr_08dcf4
	lda.l retail_visualdefs+2,x
rpr_08dcf8
	sta.w race_visualowner
rpr_08dcfb
	lda.l retail_visualdefs+4,x
rpr_08dcff
	sta.w race_visualsize
rpr_08dd02
	lda.l retail_visualdefs+6,x
rpr_08dd06
	sta.w al_stratptr,y
rpr_08dd09
	a8
rpr_08dd0b
	lda.l retail_visualdefs+8,x
rpr_08dd0f
	sta.w al_stratptr+2,y
rpr_08dd12
	plx
rpr_08dd13
	lda.w race_visualowner
rpr_08dd16
	ora.w race_visualowner+1
rpr_08dd19
	beq rpr_08dd38
rpr_08dd1b
	lda.w al_sflags,y
rpr_08dd1e
	ora #$08
rpr_08dd20
	sta.w al_sflags,y
rpr_08dd23
	lda #$00
rpr_08dd25
	sta.w al_lapcnt,y
rpr_08dd28
	lda.w race_visualsize
rpr_08dd2b
	sta.w al_eyesize,y
rpr_08dd2e
	a16
rpr_08dd30
	lda.w race_visualowner
rpr_08dd33
	sta.w al_coltab,y
rpr_08dd36
	a8
rpr_08dd38
	a16
rpr_08dd3a
	lda.l rcardefs_begin-$a4+2,x
rpr_08dd3e
	bit #$0080
rpr_08dd41
	beq rpr_08dd48
rpr_08dd43
	ora #$ff00
rpr_08dd46
	bra rpr_08dd4b
rpr_08dd48
	and #$00ff
rpr_08dd4b
	sta.w al_vx,y
rpr_08dd4e
	lda.l rcardefs_begin-$a4+3,x
rpr_08dd52
	bit #$0080
rpr_08dd55
	beq rpr_08dd5c
rpr_08dd57
	ora #$ff00
rpr_08dd5a
	bra rpr_08dd5f
rpr_08dd5c
	and #$00ff
rpr_08dd5f
	sta.w al_vy,y
rpr_08dd62
	lda.l rcardefs_begin-$a4+4,x
rpr_08dd66
	bit #$0080
rpr_08dd69
	beq rpr_08dd70
rpr_08dd6b
	ora #$ff00
rpr_08dd6e
	bra rpr_08dd73
rpr_08dd70
	and #$00ff
rpr_08dd73
	sta.w al_vz,y
rpr_08dd76
	a8
rpr_08dd78
	a16
rpr_08dd7a
	txa
rpr_08dd7b
	clc
rpr_08dd7c
	adc #$0005
rpr_08dd7f
	tax
rpr_08dd80
	a8
rpr_08dd82
	pla
rpr_08dd83
	dec a
rpr_08dd84
	beq rpr_08dd89
rpr_08dd86
	brl rpr_08dcca
rpr_08dd89
	ldx.w race_callback
rpr_08dd8c
	rtl
	shorta
	longi
; US $08:DE31.
retail_fourattachments_l
	a16
rpr_08de33
	lda #retail_attachment_step&WM
rpr_08de36
	sta.w al_stratptr,x
rpr_08de39
	a8
rpr_08de3b
	lda #mrpresent_begin>>16
rpr_08de3d
	sta.w al_stratptr+2,x
rpr_08de40
	a16
rpr_08de42
	lda #$a1e4
rpr_08de45
	sta.w race_scratch
rpr_08de48
	a8
rpr_08de4a
	jsl retail_makeactor_l
rpr_08de4e
	bcs rpr_08de54
rpr_08de50
	jml rpr_08de83
rpr_08de54
	pha
rpr_08de55
	a16
rpr_08de57
	txa
rpr_08de58
	sta.w al_ptr,y
rpr_08de5b
	a8
rpr_08de5d
	pla
rpr_08de5e
	a16
rpr_08de60
	lda #retail_attachmentwheel_l&WM
rpr_08de63
	sta.w al_stratptr,y
rpr_08de66
	a8
rpr_08de68
	lda #mrpresent_begin>>16
rpr_08de6a
	sta.w al_stratptr+2,y
rpr_08de6d
	a16
rpr_08de6f
	lda #$ffe2
rpr_08de72
	sta.w al_vx,y
rpr_08de75
	lda #$000a
rpr_08de78
	sta.w al_vy,y
rpr_08de7b
	lda #$003c
rpr_08de7e
	sta.w al_vz,y
rpr_08de81
	a8
rpr_08de83
	a16
rpr_08de85
	lda #$a1e4
rpr_08de88
	sta.w race_scratch
rpr_08de8b
	a8
rpr_08de8d
	jsl retail_makeactor_l
rpr_08de91
	bcs rpr_08de97
rpr_08de93
	jml rpr_08dec6
rpr_08de97
	pha
rpr_08de98
	a16
rpr_08de9a
	txa
rpr_08de9b
	sta.w al_ptr,y
rpr_08de9e
	a8
rpr_08dea0
	pla
rpr_08dea1
	a16
rpr_08dea3
	lda #retail_attachmentwheel_l&WM
rpr_08dea6
	sta.w al_stratptr,y
rpr_08dea9
	a8
rpr_08deab
	lda #mrpresent_begin>>16
rpr_08dead
	sta.w al_stratptr+2,y
rpr_08deb0
	a16
rpr_08deb2
	lda #$001e
rpr_08deb5
	sta.w al_vx,y
rpr_08deb8
	lda #$000a
rpr_08debb
	sta.w al_vy,y
rpr_08debe
	lda #$003c
rpr_08dec1
	sta.w al_vz,y
rpr_08dec4
	a8
rpr_08dec6
	a16
rpr_08dec8
	lda #$a1e4
rpr_08decb
	sta.w race_scratch
rpr_08dece
	a8
rpr_08ded0
	jsl retail_makeactor_l
rpr_08ded4
	bcs rpr_08deda
rpr_08ded6
	jml rpr_08df09
rpr_08deda
	pha
rpr_08dedb
	a16
rpr_08dedd
	txa
rpr_08dede
	sta.w al_ptr,y
rpr_08dee1
	a8
rpr_08dee3
	pla
rpr_08dee4
	a16
rpr_08dee6
	lda #retail_attachmentwheel_l&WM
rpr_08dee9
	sta.w al_stratptr,y
rpr_08deec
	a8
rpr_08deee
	lda #mrpresent_begin>>16
rpr_08def0
	sta.w al_stratptr+2,y
rpr_08def3
	a16
rpr_08def5
	lda #$ffe2
rpr_08def8
	sta.w al_vx,y
rpr_08defb
	lda #$000a
rpr_08defe
	sta.w al_vy,y
rpr_08df01
	lda #$ffec
rpr_08df04
	sta.w al_vz,y
rpr_08df07
	a8
rpr_08df09
	a16
rpr_08df0b
	lda #$a1e4
rpr_08df0e
	sta.w race_scratch
rpr_08df11
	a8
rpr_08df13
	jsl retail_makeactor_l
rpr_08df17
	bcs rpr_08df1d
rpr_08df19
	jml retail_attachment_step
rpr_08df1d
	pha
rpr_08df1e
	a16
rpr_08df20
	txa
rpr_08df21
	sta.w al_ptr,y
rpr_08df24
	a8
rpr_08df26
	pla
rpr_08df27
	a16
rpr_08df29
	lda #retail_attachmentwheel_l&WM
rpr_08df2c
	sta.w al_stratptr,y
rpr_08df2f
	a8
rpr_08df31
	lda #mrpresent_begin>>16
rpr_08df33
	sta.w al_stratptr+2,y
rpr_08df36
	a16
rpr_08df38
	lda #$001e
rpr_08df3b
	sta.w al_vx,y
rpr_08df3e
	lda #$000a
rpr_08df41
	sta.w al_vy,y
rpr_08df44
	lda #$ffec
rpr_08df47
	sta.w al_vz,y
rpr_08df4a
	a8
retail_attachment_step
	ldy.w al_ptr,x
rpr_08df4f
	lda.w al_sflags,y
rpr_08df52
	and #$08
rpr_08df54
	beq rpr_08df5a
rpr_08df56
	jml retail_hideactor_l
rpr_08df5a
	lda.w al_sflags2,y
rpr_08df5d
	and #$04
rpr_08df5f
	beq rpr_08df65
rpr_08df61
	jml retail_hideactor_l
rpr_08df65
	phx
rpr_08df66
	phy
rpr_08df67
	a16
rpr_08df69
	tyx
rpr_08df6a
	lda.w al_collobjptr,x
rpr_08df6d
	tax
rpr_08df6e
	lda.l $70003a,x
rpr_08df72
	xba
rpr_08df73
	a8
rpr_08df75
	ply
rpr_08df76
	plx
rpr_08df77
	clc
rpr_08df78
	adc.w al_roty,y
rpr_08df7b
	sta.w al_roty,x
rpr_08df7e
	lda.w al_rotx,y
rpr_08df81
	sta.w al_rotx,x
rpr_08df84
	lda.w al_rotz,y
rpr_08df87
	sta.w al_rotz,x
rpr_08df8a
	lda.w al_vx,x
rpr_08df8d
	sta.w race_animcount
rpr_08df90
	lda.w al_vy,x
rpr_08df93
	sta.w race_animcount+1
rpr_08df96
	lda.w al_vz,x
rpr_08df99
	sta.w race_visualangle
rpr_08df9c
	lda.w race_animcount
rpr_08df9f
	sta x1
rpr_08dfa1
	sta x2
rpr_08dfa3
	bit #$80
rpr_08dfa5
	beq rpr_08dfad
rpr_08dfa7
	lda #$ff
rpr_08dfa9
	sta x2+1
rpr_08dfab
	bra rpr_08dfaf
rpr_08dfad
	stz x2+1
rpr_08dfaf
	lda.w race_animcount+1
rpr_08dfb2
	sta y1
rpr_08dfb4
	sta y2
rpr_08dfb6
	bit #$80
rpr_08dfb8
	beq rpr_08dfc0
rpr_08dfba
	lda #$ff
rpr_08dfbc
	sta y2+1
rpr_08dfbe
	bra rpr_08dfc2
rpr_08dfc0
	stz y2+1
rpr_08dfc2
	lda.w race_visualangle
rpr_08dfc5
	sta z1
rpr_08dfc7
	sta.w z2
rpr_08dfca
	bit #$80
rpr_08dfcc
	beq rpr_08dfd5
rpr_08dfce
	lda #$ff
rpr_08dfd0
	sta.w z2+1
rpr_08dfd3
	bra rpr_08dfd8
rpr_08dfd5
	stz.w z2+1
rpr_08dfd8
	lda.w al_rotz,y
rpr_08dfdb
	jsl retail_actorrotz_l
rpr_08dfdf
	lda x2
rpr_08dfe1
	sta x1
rpr_08dfe3
	lda y2
rpr_08dfe5
	sta y1
rpr_08dfe7
	lda.w z2
rpr_08dfea
	sta z1
rpr_08dfec
	lda.w al_rotx,y
rpr_08dfef
	jsl retail_actorrotx_l
rpr_08dff3
	lda x2
rpr_08dff5
	sta x1
rpr_08dff7
	lda y2
rpr_08dff9
	sta y1
rpr_08dffb
	lda.w z2
rpr_08dffe
	sta z1
rpr_08e000
	lda.w al_roty,y
rpr_08e003
	jsl retail_actorroty_l
rpr_08e007
	a16
rpr_08e009
	lda x2
rpr_08e00b
	asl a
rpr_08e00c
	asl a
rpr_08e00d
	asl a
rpr_08e00e
	sta x2
rpr_08e010
	lda y2
rpr_08e012
	asl a
rpr_08e013
	asl a
rpr_08e014
	asl a
rpr_08e015
	sta y2
rpr_08e017
	lda.w z2
rpr_08e01a
	asl a
rpr_08e01b
	asl a
rpr_08e01c
	asl a
rpr_08e01d
	sta.w z2
rpr_08e020
	lda.w al_worldx,y
rpr_08e023
	clc
rpr_08e024
	adc x2
rpr_08e026
	sta.w al_worldx,x
rpr_08e029
	lda.w al_worldz,y
rpr_08e02c
	clc
rpr_08e02d
	adc.w z2
rpr_08e030
	sta.w al_worldz,x
rpr_08e033
	lda.w al_worldy,y
rpr_08e036
	clc
rpr_08e037
	adc y2
rpr_08e039
	sta.w al_worldy,x
rpr_08e03c
	a8
rpr_08e03e
	jsl retail_updateactorcell_l
rpr_08e042
	lda #$03
rpr_08e044
	sta.w al_sbyte4,x
rpr_08e047
	rtl
retail_attachmentwheel_l
	lda.w al_sflags,x
rpr_08e04b
	ora #$08
rpr_08e04d
	sta.w al_sflags,x
rpr_08e050
	lda #$00
rpr_08e052
	sta.w al_lapcnt,x
rpr_08e055
	lda #$6e
rpr_08e057
	sta.w al_eyesize,x
rpr_08e05a
	a16
rpr_08e05c
	lda #retail_attachmentwheel_step&WM
rpr_08e05f
	sta.w al_stratptr,x
rpr_08e062
	a8
rpr_08e064
	lda #mrpresent_begin>>16
rpr_08e066
	sta.w al_stratptr+2,x
rpr_08e069
	a16
rpr_08e06b
	lda #$9bbf
rpr_08e06e
	sta.w al_sword2,x
rpr_08e071
	a8
retail_attachmentwheel_step
	ldy.w al_ptr,x
rpr_08e076
	lda.w al_vx,x
rpr_08e079
	sta.w race_animcount
rpr_08e07c
	lda.w al_vy,x
rpr_08e07f
	sta.w race_animcount+1
rpr_08e082
	lda.w al_vz,x
rpr_08e085
	sta.w race_visualangle
rpr_08e088
	lda.w race_animcount
rpr_08e08b
	sta x1
rpr_08e08d
	sta x2
rpr_08e08f
	bit #$80
rpr_08e091
	beq rpr_08e099
rpr_08e093
	lda #$ff
rpr_08e095
	sta x2+1
rpr_08e097
	bra rpr_08e09b
rpr_08e099
	stz x2+1
rpr_08e09b
	lda.w race_animcount+1
rpr_08e09e
	sta y1
rpr_08e0a0
	sta y2
rpr_08e0a2
	bit #$80
rpr_08e0a4
	beq rpr_08e0ac
rpr_08e0a6
	lda #$ff
rpr_08e0a8
	sta y2+1
rpr_08e0aa
	bra rpr_08e0ae
rpr_08e0ac
	stz y2+1
rpr_08e0ae
	lda.w race_visualangle
rpr_08e0b1
	sta z1
rpr_08e0b3
	sta.w z2
rpr_08e0b6
	bit #$80
rpr_08e0b8
	beq rpr_08e0c1
rpr_08e0ba
	lda #$ff
rpr_08e0bc
	sta.w z2+1
rpr_08e0bf
	bra rpr_08e0c4
rpr_08e0c1
	stz.w z2+1
rpr_08e0c4
	lda.w al_rotz,y
rpr_08e0c7
	jsl retail_actorrotz_l
rpr_08e0cb
	lda x2
rpr_08e0cd
	sta x1
rpr_08e0cf
	lda y2
rpr_08e0d1
	sta y1
rpr_08e0d3
	lda.w z2
rpr_08e0d6
	sta z1
rpr_08e0d8
	lda.w al_rotx,y
rpr_08e0db
	jsl retail_actorrotx_l
rpr_08e0df
	lda x2
rpr_08e0e1
	sta x1
rpr_08e0e3
	lda y2
rpr_08e0e5
	sta y1
rpr_08e0e7
	lda.w z2
rpr_08e0ea
	sta z1
rpr_08e0ec
	lda.w al_roty,y
rpr_08e0ef
	jsl retail_actorroty_l
rpr_08e0f3
	a16
rpr_08e0f5
	lda x2
rpr_08e0f7
	asl a
rpr_08e0f8
	asl a
rpr_08e0f9
	asl a
rpr_08e0fa
	sta x2
rpr_08e0fc
	lda y2
rpr_08e0fe
	asl a
rpr_08e0ff
	asl a
rpr_08e100
	asl a
rpr_08e101
	sta y2
rpr_08e103
	lda.w z2
rpr_08e106
	asl a
rpr_08e107
	asl a
rpr_08e108
	asl a
rpr_08e109
	sta.w z2
rpr_08e10c
	lda.w al_worldx,y
rpr_08e10f
	clc
rpr_08e110
	adc x2
rpr_08e112
	sta.w al_worldx,x
rpr_08e115
	lda.w al_worldz,y
rpr_08e118
	clc
rpr_08e119
	adc.w z2
rpr_08e11c
	sta.w al_worldz,x
rpr_08e11f
	lda.w al_worldy,y
rpr_08e122
	clc
rpr_08e123
	adc y2
rpr_08e125
	sta.w al_worldy,x
rpr_08e128
	a8
rpr_08e12a
	jsl retail_followactorangles_l
rpr_08e12e
	txy
rpr_08e12f
	jsr rsc_wheelview
rpr_08e132
	jsl retail_updateactorcell_l
rpr_08e136
	lda #$03
rpr_08e138
	sta.w al_sbyte4,x
rpr_08e13b
	rtl
	shorta
	longi
; US $08:E158.
retail_pairedcar_l
	ldy.w al_ptr,x
rpr_08e15b
	jsl retail_followactor_l
rpr_08e15f
	a16
rpr_08e161
	lda.w al_worldz,x
rpr_08e164
	sec
rpr_08e165
	sbc #$0640
rpr_08e168
	sta.w al_worldz,x
rpr_08e16b
	a8
rpr_08e16d
	a16
rpr_08e16f
	lda.w al_worldy,x
rpr_08e172
	clc
rpr_08e173
	adc #$fe20
rpr_08e176
	sta.w al_worldy,x
rpr_08e179
	a8
rpr_08e17b
	a16
rpr_08e17d
	lda #$0000
rpr_08e180
	jsl retail_spawnvehicle_l
rpr_08e184
	a8
rpr_08e186
	ldy.w al_ptr,x
rpr_08e189
	a16
rpr_08e18b
	phx
rpr_08e18c
	lda.w al_collobjptr,x
rpr_08e18f
	tax
rpr_08e190
	lda.w al_collobjptr,y
rpr_08e193
	sta.l $70008e,x
rpr_08e197
	lda.l $70001c,x
rpr_08e19b
	ora #$0008
rpr_08e19e
	sta.l $70001c,x
rpr_08e1a2
	plx
rpr_08e1a3
	phx
rpr_08e1a4
	tyx
rpr_08e1a5
	ply
rpr_08e1a6
	phx
rpr_08e1a7
	lda.w al_collobjptr,x
rpr_08e1aa
	tax
rpr_08e1ab
	lda.w al_collobjptr,y
rpr_08e1ae
	sta.l $70008e,x
rpr_08e1b2
	plx
rpr_08e1b3
	phx
rpr_08e1b4
	tyx
rpr_08e1b5
	ply
rpr_08e1b6
	a8
rpr_08e1b8
	a16
rpr_08e1ba
	lda #retail_pairedcar_step&WM
rpr_08e1bd
	sta.w al_stratptr,x
rpr_08e1c0
	a8
rpr_08e1c2
	lda #mrpresent_begin>>16
rpr_08e1c4
	sta.w al_stratptr+2,x
retail_pairedcar_step
	jsl retail_updateactorcell_l
rpr_08e1cb
	jsl retail_publishcar_l
rpr_08e1cf
	jmp retail_bodyframe_l
retail_carindicator_l
	phx
rpr_08e1d3
	a16
rpr_08e1d5
	lda.w al_ptr,x
rpr_08e1d8
	tax
rpr_08e1d9
	lda.w al_collobjptr,x
rpr_08e1dc
	tax
rpr_08e1dd
	lda.l $700070,x
rpr_08e1e1
	plx
rpr_08e1e2
	and #$0008
rpr_08e1e5
	bne rpr_08e201
rpr_08e1e7
	lda.l m_retailrouteword
rpr_08e1eb
	and #$0100
rpr_08e1ee
	beq rpr_08e201
rpr_08e1f0
	a8
rpr_08e1f2
	lda.w race_scenephase
rpr_08e1f5
	cmp #$01
rpr_08e1f7
	beq rpr_08e201
rpr_08e1f9
	cmp #$02
rpr_08e1fb
	beq rpr_08e201
rpr_08e1fd
	cmp #$03
rpr_08e1ff
	bne rpr_08e208
	shorta
	longi
rpr_08e201
	a8
rpr_08e203
	jsl retail_retireactor_l
rpr_08e207
	rtl
rpr_08e208
	a16
rpr_08e20a
	lda #retail_carindicator_step&WM
rpr_08e20d
	sta.w al_stratptr,x
rpr_08e210
	a8
rpr_08e212
	lda #mrpresent_begin>>16
rpr_08e214
	sta.w al_stratptr+2,x
rpr_08e217
	jsr rpr_readindicatorstate
rpr_08e21a
	sta.w al_sbyte3,x
rpr_08e21d
	lda #$00
rpr_08e21f
	sta.w al_sbyte2,x
rpr_08e222
	a16
rpr_08e224
	lda.w al_vy,x
rpr_08e227
	bit #$0080
rpr_08e22a
	beq rpr_08e231
rpr_08e22c
	ora #$ff00
rpr_08e22f
	bra rpr_08e234
rpr_08e231
	and #$00ff
rpr_08e234
	asl a
rpr_08e235
	sta.w al_vy,x
rpr_08e238
	a8
rpr_08e23a
	lda #$0a
rpr_08e23c
	sta.w al_offroadtime,x
rpr_08e23f
	lda #$01
rpr_08e241
	sta.w al_stratstate,x
retail_carindicator_step
	lda.w al_offroadtime,x
rpr_08e247
	bne rpr_08e24d
rpr_08e249
	jml rpr_08e256
rpr_08e24d
	dec.w al_offroadtime,x
rpr_08e250
	jsr rpr_readindicatorframe
rpr_08e253
	sta.w al_sbyte1,x
rpr_08e256
	ldy.w al_ptr,x
rpr_08e259
	lda.w al_sflags2,y
rpr_08e25c
	and #$08
rpr_08e25e
	beq rpr_08e264
rpr_08e260
	jml rpr_08e3e0
rpr_08e264
	lda.w al_sflags2,y
rpr_08e267
	and #$10
rpr_08e269
	beq rpr_08e26f
rpr_08e26b
	jml rpr_08e3e0
rpr_08e26f
	jsr rpr_readcarflag
rpr_08e272
	bcc rpr_08e277
rpr_08e274
	brl rpr_08e3e0
rpr_08e277
	lda.w al_stratstate,x
rpr_08e27a
	cmp #$01
rpr_08e27c
	beq rpr_08e282
rpr_08e27e
	jml rpr_08e2cd
rpr_08e282
	jsr rpr_readindicatorframe
rpr_08e285
	cmp.w al_sbyte1,x
rpr_08e288
	beq rpr_08e29e
rpr_08e28a
	bpl rpr_08e291
rpr_08e28c
	sta.w al_sbyte1,x
rpr_08e28f
	bra rpr_08e294
rpr_08e291
	sta.w al_sbyte1,x
rpr_08e294
	lda #$02
rpr_08e296
	sta.w al_stratstate,x
rpr_08e299
	lda #$08
rpr_08e29b
	sta.w al_sbyte2,x
rpr_08e29e
	jsr rpr_readindicatorstate
rpr_08e2a1
	sta.w race_scratch
rpr_08e2a4
	bcs rpr_08e2c7
rpr_08e2a6
	sec
rpr_08e2a7
	sbc.w al_sbyte3,x
rpr_08e2aa
	bpl rpr_08e2c7
rpr_08e2ac
	eor #$ff
rpr_08e2ae
	inc a
rpr_08e2af
	cmp #$02
rpr_08e2b1
	bmi rpr_08e2cd
rpr_08e2b3
	cmp #$0a
rpr_08e2b5
	bpl rpr_08e2c7
rpr_08e2b7
	lda #$03
rpr_08e2b9
	sta.w al_stratstate,x
rpr_08e2bc
	lda #$08
rpr_08e2be
	sta.w al_sbyte2,x
rpr_08e2c1
	lda #$3b
rpr_08e2c3
	jsl queue_raceplayer_l
rpr_08e2c7
	lda.w race_scratch
rpr_08e2ca
	sta.w al_sbyte3,x
rpr_08e2cd
	lda.w al_stratstate,x
rpr_08e2d0
	cmp #$02
rpr_08e2d2
	beq rpr_08e2d8
rpr_08e2d4
	jml rpr_08e2e6
rpr_08e2d8
	jsr rpr_readindicatorframe
rpr_08e2db
	sta.w race_animcount
rpr_08e2de
	lda.w race_animcount
rpr_08e2e1
	ora #$80
rpr_08e2e3
	sta.w al_sflags3,x
rpr_08e2e6
	lda.w al_stratstate,x
rpr_08e2e9
	cmp #$03
rpr_08e2eb
	beq rpr_08e2f1
rpr_08e2ed
	jml rpr_08e2fe
rpr_08e2f1
	lda #$04
rpr_08e2f3
	ora #$80
rpr_08e2f5
	sta.w al_sflags3,x
rpr_08e2f8
	jsr rpr_readindicatorstate
rpr_08e2fb
	sta.w al_sbyte3,x
rpr_08e2fe
	lda.w al_sbyte2,x
rpr_08e301
	bne rpr_08e306
rpr_08e303
	brl rpr_08e3e0
rpr_08e306
	dec a
rpr_08e307
	beq rpr_08e315
rpr_08e309
	sta.w al_sbyte2,x
rpr_08e30c
	and #$03
rpr_08e30e
	bne rpr_08e313
rpr_08e310
	brl rpr_08e3e0
rpr_08e313
	bra rpr_08e320
rpr_08e315
	sta.w al_sbyte2,x
rpr_08e318
	lda #$01
rpr_08e31a
	sta.w al_stratstate,x
rpr_08e31d
	jmp rpr_08e3e0
rpr_08e320
	lda.w al_sflags,x
rpr_08e323
	and #$df
rpr_08e325
	sta.w al_sflags,x
rpr_08e328
	ldy.w al_ptr,x
rpr_08e32b
	jsl retail_followactor_l
rpr_08e32f
	jsl retail_moveactor_l
rpr_08e333
	lda.w al_sflags,x
rpr_08e336
	and #$7f
rpr_08e338
	sta.w al_sflags,x
rpr_08e33b
	a16
rpr_08e33d
	lda.w al_viewpt,y
rpr_08e340
	tay
rpr_08e341
	lda.w al_viewpt,y
rpr_08e344
	tay
rpr_08e345
	lda.w $0008,y
rpr_08e348
	sta.w race_callback
rpr_08e34b
	lda.w $000a,y
rpr_08e34e
	sta.w race_visualoffset
rpr_08e351
	lda.w $000c,y
rpr_08e354
	sta.w race_visualowner
rpr_08e357
	lda.w $0000,y
rpr_08e35a
	and #$4000
rpr_08e35d
	bne rpr_08e362
rpr_08e35f
	brl rpr_08e3d8
rpr_08e362
	lda #$0000
rpr_08e365
	sta.w al_worldx,x
rpr_08e368
	lda #$ff9c
rpr_08e36b
	sta.w al_worldy,x
rpr_08e36e
	lda #$01f4
rpr_08e371
	sta.w al_worldz,x
rpr_08e374
	a8
rpr_08e376
	lda.w al_sflags,x
rpr_08e379
	ora #$80
rpr_08e37b
	sta.w al_sflags,x
rpr_08e37e
	a16
rpr_08e380
	lda.w al_worldx,x
rpr_08e383
	clc
rpr_08e384
	adc.w race_callback
rpr_08e387
	sta.w al_worldx,x
rpr_08e38a
	a8
rpr_08e38c
	a16
rpr_08e38e
	lda.w al_worldy,x
rpr_08e391
	clc
rpr_08e392
	adc.w race_visualoffset
rpr_08e395
	sta.w al_worldy,x
rpr_08e398
	a8
rpr_08e39a
	a16
rpr_08e39c
	lda.w al_worldz,x
rpr_08e39f
	clc
rpr_08e3a0
	adc.w race_visualowner
rpr_08e3a3
	sta.w al_worldz,x
rpr_08e3a6
	a8
rpr_08e3a8
	jsl retail_updateactorcell_l
rpr_08e3ac
	a16
rpr_08e3ae
	lda.w al_worldx,x
rpr_08e3b1
	sec
rpr_08e3b2
	sbc.w race_callback
rpr_08e3b5
	sta.w al_worldx,x
rpr_08e3b8
	a8
rpr_08e3ba
	a16
rpr_08e3bc
	lda.w al_worldy,x
rpr_08e3bf
	sec
rpr_08e3c0
	sbc.w race_visualoffset
rpr_08e3c3
	sta.w al_worldy,x
rpr_08e3c6
	a8
rpr_08e3c8
	a16
rpr_08e3ca
	lda.w al_worldz,x
rpr_08e3cd
	sec
rpr_08e3ce
	sbc.w race_visualowner
rpr_08e3d1
	sta.w al_worldz,x
rpr_08e3d4
	a8
rpr_08e3d6
	bra rpr_08e3e8
rpr_08e3d8
	a8
rpr_08e3da
	jsl retail_updateactorcell_l
rpr_08e3de
	bra rpr_08e3e8
rpr_08e3e0
	lda.w al_sflags,x
rpr_08e3e3
	ora #$20
rpr_08e3e5
	sta.w al_sflags,x
rpr_08e3e8
	lda #$03
rpr_08e3ea
	sta.w al_sbyte4,x
rpr_08e3ed
	rtl
rpr_readindicatorframe
	ldy.w al_ptr,x
rpr_08e3f1
	phx
rpr_08e3f2
	a16
rpr_08e3f4
	lda.w al_collobjptr,y
rpr_08e3f7
	tax
rpr_08e3f8
	lda.l $700088,x
rpr_08e3fc
	dec a
rpr_08e3fd
	a8
rpr_08e3ff
	plx
rpr_08e400
	rts
rpr_readindicatorstate
	ldy.w al_ptr,x
rpr_08e404
	phx
rpr_08e405
	a16
rpr_08e407
	lda.w al_collobjptr,y
rpr_08e40a
	tax
rpr_08e40b
	lda.l $700042,x
rpr_08e40f
	and #$0410
rpr_08e412
	beq rpr_08e41d
rpr_08e414
	lda.l $700058,x
rpr_08e418
	a8
rpr_08e41a
	plx
rpr_08e41b
	clc
rpr_08e41c
	rts
rpr_08e41d
	lda.l $700058,x
rpr_08e421
	a8
rpr_08e423
	plx
rpr_08e424
	sec
rpr_08e425
	rts
rpr_readcarflag
	ldy.w al_ptr,x
rpr_08e429
	phx
rpr_08e42a
	a16
rpr_08e42c
	lda.w al_collobjptr,y
rpr_08e42f
	tax
rpr_08e430
	lda.l $700040,x
rpr_08e434
	and #$0100
rpr_08e437
	bne rpr_08e43e
rpr_08e439
	a8
rpr_08e43b
	plx
rpr_08e43c
	clc
rpr_08e43d
	rts
rpr_08e43e
	a8
rpr_08e440
	plx
rpr_08e441
	sec
rpr_08e442
	rts
retail_fixedeye_l
	ldy.w al_ptr,x
rpr_08e446
	lda.w al_sflags,y
rpr_08e449
	and #$08
rpr_08e44b
	beq rpr_08e451
rpr_08e44d
	jml retail_hideactor_l
rpr_08e451
	lda.w al_sflags,y
rpr_08e454
	and #$20
rpr_08e456
	beq rpr_08e45c
rpr_08e458
	jml retail_hideactor_l
rpr_08e45c
	lda #$00
rpr_08e45e
	ora #$80
rpr_08e460
	sta.w al_sflags3,x
rpr_08e463
	lda.w al_vx,x
rpr_08e466
	sta.w race_animcount
rpr_08e469
	lda.w al_vy,x
rpr_08e46c
	sta.w race_animcount+1
rpr_08e46f
	lda.w al_vz,x
rpr_08e472
	sta.w race_visualangle
rpr_08e475
	lda.w race_animcount
rpr_08e478
	sta x1
rpr_08e47a
	sta x2
rpr_08e47c
	bit #$80
rpr_08e47e
	beq rpr_08e486
rpr_08e480
	lda #$ff
rpr_08e482
	sta x2+1
rpr_08e484
	bra rpr_08e488
rpr_08e486
	stz x2+1
rpr_08e488
	lda.w race_animcount+1
rpr_08e48b
	sta y1
rpr_08e48d
	sta y2
rpr_08e48f
	bit #$80
rpr_08e491
	beq rpr_08e499
rpr_08e493
	lda #$ff
rpr_08e495
	sta y2+1
rpr_08e497
	bra rpr_08e49b
rpr_08e499
	stz y2+1
rpr_08e49b
	lda.w race_visualangle
rpr_08e49e
	sta z1
rpr_08e4a0
	sta.w z2
rpr_08e4a3
	bit #$80
rpr_08e4a5
	beq rpr_08e4ae
rpr_08e4a7
	lda #$ff
rpr_08e4a9
	sta.w z2+1
rpr_08e4ac
	bra rpr_08e4b1
rpr_08e4ae
	stz.w z2+1
rpr_08e4b1
	lda.w al_rotz,y
rpr_08e4b4
	jsl retail_actorrotz_l
rpr_08e4b8
	lda x2
rpr_08e4ba
	sta x1
rpr_08e4bc
	lda y2
rpr_08e4be
	sta y1
rpr_08e4c0
	lda.w z2
rpr_08e4c3
	sta z1
rpr_08e4c5
	lda.w al_rotx,y
rpr_08e4c8
	jsl retail_actorrotx_l
rpr_08e4cc
	lda x2
rpr_08e4ce
	sta x1
rpr_08e4d0
	lda y2
rpr_08e4d2
	sta y1
rpr_08e4d4
	lda.w z2
rpr_08e4d7
	sta z1
rpr_08e4d9
	lda.w al_roty,y
rpr_08e4dc
	jsl retail_actorroty_l
rpr_08e4e0
	a16
rpr_08e4e2
	lda x2
rpr_08e4e4
	asl a
rpr_08e4e5
	sta x2
rpr_08e4e7
	lda y2
rpr_08e4e9
	asl a
rpr_08e4ea
	sta y2
rpr_08e4ec
	lda.w z2
rpr_08e4ef
	asl a
rpr_08e4f0
	sta.w z2
rpr_08e4f3
	lda.w al_worldx,y
rpr_08e4f6
	clc
rpr_08e4f7
	adc x2
rpr_08e4f9
	sta.w al_worldx,x
rpr_08e4fc
	lda.w al_worldz,y
rpr_08e4ff
	clc
rpr_08e500
	adc.w z2
rpr_08e503
	sta.w al_worldz,x
rpr_08e506
	lda.w al_worldy,y
rpr_08e509
	clc
rpr_08e50a
	adc y2
rpr_08e50c
	sta.w al_worldy,x
rpr_08e50f
	a8
rpr_08e511
	lda.w al_sflags,x
rpr_08e514
	and #$df
rpr_08e516
	sta.w al_sflags,x
rpr_08e519
	jsl retail_updateactorcell_l
rpr_08e51d
	rtl
retail_eyeturn_step
	lda.w race_visualmode
rpr_08e521
	and #$1c
rpr_08e523
	cmp #$08
rpr_08e525
	bne rpr_08e52a
rpr_08e527
	brl rpr_08e589
rpr_08e52a
	cmp #$04
rpr_08e52c
	bne rpr_08e531
rpr_08e52e
	brl rpr_08e55b
rpr_08e531
	cmp #$0c
rpr_08e533
	bne rpr_08e538
rpr_08e535
	brl rpr_08e5b7
rpr_08e538
	cmp #$1c
rpr_08e53a
	bne rpr_08e53f
rpr_08e53c
	brl rpr_08e5e5
rpr_08e53f
	cmp #$10
rpr_08e541
	bne rpr_08e546
rpr_08e543
	brl rpr_08e54e
rpr_08e546
	lda #$00
rpr_08e548
	sta.w al_offroadtime,x
rpr_08e54b
	jmp retail_eyeactor_step
rpr_08e54e
	a16
rpr_08e550
	lda #$9aaf
rpr_08e553
	sta.w al_coltab,x
rpr_08e556
	a8
rpr_08e558
	jmp retail_eyeactor_step
rpr_08e55b
	lda.w al_offroadtime,x
rpr_08e55e
	cmp #$04
rpr_08e560
	bne rpr_08e565
rpr_08e562
	brl retail_eyeactor_step
rpr_08e565
	inc a
rpr_08e566
	sta.w al_offroadtime,x
rpr_08e569
	phx
rpr_08e56a
	asl a
rpr_08e56b
	i8
rpr_08e56d
	tax
rpr_08e56e
	a16
rpr_08e570
	lda.l retail_eyeturn0,x
rpr_08e574
	i16
rpr_08e576
	plx
rpr_08e577
	sta.w al_coltab,x
rpr_08e57a
	a8
rpr_08e57c
	jmp retail_eyeactor_step
	shorta
	longi
; US $08:E589.
	shorta
	longi
rpr_08e589
	lda.w al_offroadtime,x
rpr_08e58c
	cmp #$04
rpr_08e58e
	bne rpr_08e593
rpr_08e590
	brl retail_eyeactor_step
rpr_08e593
	inc a
rpr_08e594
	sta.w al_offroadtime,x
rpr_08e597
	phx
rpr_08e598
	asl a
rpr_08e599
	i8
rpr_08e59b
	tax
rpr_08e59c
	a16
rpr_08e59e
	lda.l retail_eyeturn1,x
rpr_08e5a2
	i16
rpr_08e5a4
	plx
rpr_08e5a5
	sta.w al_coltab,x
rpr_08e5a8
	a8
rpr_08e5aa
	jmp retail_eyeactor_step
	shorta
	longi
; US $08:E5B7.
rpr_08e5b7
	lda.w al_offroadtime,x
rpr_08e5ba
	cmp #$04
rpr_08e5bc
	bne rpr_08e5c1
rpr_08e5be
	brl retail_eyeactor_step
rpr_08e5c1
	inc a
rpr_08e5c2
	sta.w al_offroadtime,x
rpr_08e5c5
	phx
rpr_08e5c6
	asl a
rpr_08e5c7
	i8
rpr_08e5c9
	tax
rpr_08e5ca
	a16
rpr_08e5cc
	lda.l retail_eyeturn2,x
rpr_08e5d0
	i16
rpr_08e5d2
	plx
rpr_08e5d3
	sta.w al_coltab,x
rpr_08e5d6
	a8
rpr_08e5d8
	jmp retail_eyeactor_step
	shorta
	longi
; US $08:E5E5.
	shorta
	longi
rpr_08e5e5
	lda.w al_offroadtime,x
rpr_08e5e8
	cmp #$04
rpr_08e5ea
	bne rpr_08e5ef
rpr_08e5ec
	brl retail_eyeactor_step
rpr_08e5ef
	inc a
rpr_08e5f0
	sta.w al_offroadtime,x
rpr_08e5f3
	phx
rpr_08e5f4
	asl a
rpr_08e5f5
	i8
rpr_08e5f7
	tax
rpr_08e5f8
	a16
rpr_08e5fa
	lda.l retail_eyeturn3,x
rpr_08e5fe
	i16
rpr_08e600
	plx
rpr_08e601
	sta.w al_coltab,x
rpr_08e604
	a8
rpr_08e606
	jmp retail_eyeactor_step
	shorta
	longi
; US $08:E613.
retail_eyeactor_l
	ldy.w al_ptr,x
rpr_08e616
	lda.w al_whocanseeme,y
rpr_08e619
	sta.w al_whocanseeme,x
rpr_eyeactor_init
	lda.w race_visualmode
rpr_08e61f
	and #$20
rpr_08e621
	beq rpr_08e63a
rpr_08e623
	lda #$00
rpr_08e625
	sta.w al_offroadtime,x
rpr_08e628
	a16
rpr_08e62a
	lda #retail_eyeturn_step&WM
rpr_08e62d
	sta.w al_stratptr,x
rpr_08e630
	a8
rpr_08e632
	lda #mrpresent_begin>>16
rpr_08e634
	sta.w al_stratptr+2,x
rpr_08e637
	jmp retail_eyeturn_step
rpr_08e63a
	a16
rpr_08e63c
	lda #$9aaf
rpr_08e63f
	sta.w al_coltab,x
rpr_08e642
	a8
rpr_08e644
	a16
rpr_08e646
	lda #retail_eyeactor_step&WM
rpr_08e649
	sta.w al_stratptr,x
rpr_08e64c
	a8
rpr_08e64e
	lda #mrpresent_begin>>16
rpr_08e650
	sta.w al_stratptr+2,x
retail_eyeactor_step
	ldy.w al_ptr,x
rpr_08e656
	lda.w al_sflags,y
rpr_08e659
	and #$08
rpr_08e65b
	beq rpr_08e661
rpr_08e65d
	jml retail_hideactor_l
rpr_08e661
	lda.w al_sflags2,y
rpr_08e664
	and #$04
rpr_08e666
	beq rpr_08e66c
rpr_08e668
	jml rpr_08e6be
rpr_08e66c
	lda.w al_sflags2,y
rpr_08e66f
	and #$20
rpr_08e671
	beq rpr_08e677
rpr_08e673
	jml rpr_08e712
rpr_08e677
	lda.w al_sflags2,y
rpr_08e67a
	and #$40
rpr_08e67c
	beq rpr_08e682
rpr_08e67e
	jml rpr_08e6b4
rpr_08e682
	ldy.w al_ptr,x
rpr_08e685
	phx
rpr_08e686
	tyx
rpr_08e687
	ply
rpr_08e688
	jsr rpr_eyepose
rpr_08e68b
	tyx
rpr_08e68c
	jsl retail_updateactorcell_l
rpr_08e690
	lda.w al_sflags,x
rpr_08e693
	and #$df
rpr_08e695
	sta.w al_sflags,x
rpr_08e698
	lda.w al_sflags,x
rpr_08e69b
	and #$bf
rpr_08e69d
	sta.w al_sflags,x
rpr_08e6a0
	ldy.w al_ptr,x
rpr_08e6a3
	lda.w al_sflags,y
rpr_08e6a6
	and #$40
rpr_08e6a8
	beq rpr_08e6ae
rpr_08e6aa
	jml retail_flagactor_l
rpr_08e6ae
	lda #$03
rpr_08e6b0
	sta.w al_sbyte4,x
rpr_08e6b3
	rtl
rpr_08e6b4
	a16
rpr_08e6b6
	lda #$9ab1
rpr_08e6b9
	sta.w al_coltab,x
rpr_08e6bc
	a8
rpr_08e6be
	ldy.w al_ptr,x
rpr_08e6c1
	lda.w al_sflags2,y
rpr_08e6c4
	and #$10
rpr_08e6c6
	beq rpr_08e6cc
rpr_08e6c8
	jml retail_endactor_l
rpr_08e6cc
	a16
rpr_08e6ce
	lda #retail_eyebounce_step&WM
rpr_08e6d1
	sta.w al_stratptr,x
rpr_08e6d4
	a8
rpr_08e6d6
	lda #mrpresent_begin>>16
rpr_08e6d8
	sta.w al_stratptr+2,x
rpr_08e6db
	stz.w al_sbyte2,x
retail_eyebounce_step
	lda.w al_sbyte1,x
rpr_08e6e1
	clc
rpr_08e6e2
	adc #$10
rpr_08e6e4
	sta.w al_sbyte1,x
rpr_08e6e7
	lda #$08
rpr_08e6e9
	sta.w race_animcount
rpr_08e6ec
	lda #$10
rpr_08e6ee
	sta.w race_animcount+1
rpr_08e6f1
	lda #$05
rpr_08e6f3
	sta.w race_visualangle
rpr_08e6f6
	jsr rpr_eyeheight
rpr_08e6f9
	bcc rpr_08e682
rpr_08e6fb
	lda #$00
rpr_08e6fd
	sta.w al_sbyte1,x
rpr_08e700
	a16
rpr_08e702
	lda #rpr_eyeactor_init&WM
rpr_08e705
	sta.w al_stratptr,x
rpr_08e708
	a8
rpr_08e70a
	lda #mrpresent_begin>>16
rpr_08e70c
	sta.w al_stratptr+2,x
rpr_08e70f
	jmp rpr_08e682
rpr_08e712
	a16
rpr_08e714
	lda #retail_eyeblink_step&WM
rpr_08e717
	sta.w al_stratptr,x
rpr_08e71a
	a8
rpr_08e71c
	lda #mrpresent_begin>>16
rpr_08e71e
	sta.w al_stratptr+2,x
rpr_08e721
	stz.w al_sbyte2,x
rpr_08e724
	lda.w al_sflags2,x
rpr_08e727
	ora #$01
rpr_08e729
	sta.w al_sflags2,x
retail_eyeblink_step
	lda #$03
rpr_08e72e
	sta.w race_animcount
rpr_08e731
	lda #$06
rpr_08e733
	sta.w race_animcount+1
rpr_08e736
	lda #$0a
rpr_08e738
	sta.w race_visualangle
rpr_08e73b
	jsr rpr_eyeheight
rpr_08e73e
	bcs rpr_08e743
rpr_08e740
	brl rpr_08e682
rpr_08e743
	stz.w al_sbyte2,x
rpr_08e746
	a16
rpr_08e748
	lda #rpr_eyeactor_init&WM
rpr_08e74b
	sta.w al_stratptr,x
rpr_08e74e
	a8
rpr_08e750
	lda #mrpresent_begin>>16
rpr_08e752
	sta.w al_stratptr+2,x
rpr_08e755
	lda.w al_sflags2,x
rpr_08e758
	and #$fe
rpr_08e75a
	sta.w al_sflags2,x
rpr_08e75d
	jmp rpr_08e682
rpr_eyeheight
	inc.w al_sbyte2,x
rpr_08e763
	lda.w al_sbyte2,x
rpr_08e766
	cmp.w race_animcount
rpr_08e769
	beq rpr_08e771
rpr_08e76b
	bmi rpr_08e771
rpr_08e76d
	jml rpr_08e77e
rpr_08e771
	lda.w al_eyesize,x
rpr_08e774
	clc
rpr_08e775
	adc.w race_visualangle
rpr_08e778
	sta.w al_eyesize,x
rpr_08e77b
	jmp rpr_08e794
rpr_08e77e
	lda.w al_eyesize,x
rpr_08e781
	sec
rpr_08e782
	sbc.w race_visualangle
rpr_08e785
	sta.w al_eyesize,x
rpr_08e788
	lda.w al_sbyte2,x
rpr_08e78b
	cmp.w race_animcount+1
rpr_08e78e
	bne rpr_08e794
rpr_08e790
	jml rpr_08e796
rpr_08e794
	clc
rpr_08e795
	rts
rpr_08e796
	sec
rpr_08e797
	rts
rpr_eyepose
	lda.w al_sflags2,y
rpr_08e79b
	and #$01
rpr_08e79d
	beq rpr_08e7a3
rpr_08e79f
	jml rpr_08e7bf
rpr_08e7a3
	phx
rpr_08e7a4
	a16
rpr_08e7a6
	lda.w al_collobjptr,x
rpr_08e7a9
	tax
rpr_08e7aa
	beq rpr_08e7b3
rpr_08e7ac
	lda.l $70003a,x
rpr_08e7b0
	asl a
rpr_08e7b1
	asl a
rpr_08e7b2
	xba
rpr_08e7b3
	a8
rpr_08e7b5
	clc
rpr_08e7b6
	adc.w al_sbyte1,y
rpr_08e7b9
	sta.w race_callback
rpr_08e7bc
	plx
rpr_08e7bd
	bra rpr_08e7c9
rpr_08e7bf
	lda #$8c
rpr_08e7c1
	sta.w al_sflags3,y
rpr_08e7c4
	sta.w al_sflags4,y
rpr_08e7c7
	bra rpr_08e7e7
rpr_08e7c9
	phx
rpr_08e7ca
	ldx #viewcamera1
rpr_08e7cd
	lda $11,x
rpr_08e7cf
	plx
rpr_08e7d0
	jsr rpr_eyeframe
rpr_08e7d3
	ora #$80
rpr_08e7d5
	sta.w al_sflags3,y
rpr_08e7d8
	phx
rpr_08e7d9
	ldx #viewcamera2
rpr_08e7dc
	lda $11,x
rpr_08e7de
	plx
rpr_08e7df
	jsr rpr_eyeframe
rpr_08e7e2
	ora #$80
rpr_08e7e4
	sta.w al_sflags4,y
rpr_08e7e7
	lda.w al_vx,y
rpr_08e7ea
	sta.w race_animcount
rpr_08e7ed
	lda.w al_vy,y
rpr_08e7f0
	sta.w race_animcount+1
rpr_08e7f3
	lda.w al_vz,y
rpr_08e7f6
	sta.w race_visualangle
rpr_08e7f9
	lda.w race_animcount
rpr_08e7fc
	sta x1
rpr_08e7fe
	sta x2
rpr_08e800
	bit #$80
rpr_08e802
	beq rpr_08e80a
rpr_08e804
	lda #$ff
rpr_08e806
	sta x2+1
rpr_08e808
	bra rpr_08e80c
rpr_08e80a
	stz x2+1
rpr_08e80c
	lda.w race_animcount+1
rpr_08e80f
	sta y1
rpr_08e811
	sta y2
rpr_08e813
	bit #$80
rpr_08e815
	beq rpr_08e81d
rpr_08e817
	lda #$ff
rpr_08e819
	sta y2+1
rpr_08e81b
	bra rpr_08e81f
rpr_08e81d
	stz y2+1
rpr_08e81f
	lda.w race_visualangle
rpr_08e822
	sta z1
rpr_08e824
	sta.w z2
rpr_08e827
	bit #$80
rpr_08e829
	beq rpr_08e832
rpr_08e82b
	lda #$ff
rpr_08e82d
	sta.w z2+1
rpr_08e830
	bra rpr_08e835
rpr_08e832
	stz.w z2+1
rpr_08e835
	lda.w al_rotz,x
rpr_08e838
	jsl retail_actorrotz_l
rpr_08e83c
	lda x2
rpr_08e83e
	sta x1
rpr_08e840
	lda y2
rpr_08e842
	sta y1
rpr_08e844
	lda.w z2
rpr_08e847
	sta z1
rpr_08e849
	lda.w al_rotx,x
rpr_08e84c
	jsl retail_actorrotx_l
rpr_08e850
	lda x2
rpr_08e852
	sta x1
rpr_08e854
	lda y2
rpr_08e856
	sta y1
rpr_08e858
	lda.w z2
rpr_08e85b
	sta z1
rpr_08e85d
	lda.w al_roty,x
rpr_08e860
	jsl retail_actorroty_l
rpr_08e864
	a16
rpr_08e866
	lda x2
rpr_08e868
	asl a
rpr_08e869
	sta x2
rpr_08e86b
	lda y2
rpr_08e86d
	asl a
rpr_08e86e
	sta y2
rpr_08e870
	lda.w z2
rpr_08e873
	asl a
rpr_08e874
	sta.w z2
rpr_08e877
	lda.w al_worldx,x
rpr_08e87a
	clc
rpr_08e87b
	adc x2
rpr_08e87d
	sta.w al_worldx,y
rpr_08e880
	lda.w al_worldz,x
rpr_08e883
	clc
rpr_08e884
	adc.w z2
rpr_08e887
	sta.w al_worldz,y
rpr_08e88a
	lda.w al_worldy,x
rpr_08e88d
	clc
rpr_08e88e
	adc y2
rpr_08e890
	sta.w al_worldy,y
rpr_08e893
	a8
rpr_08e895
	rts
rpr_eyeframe
	clc
rpr_08e897
	adc.w al_roty,x
rpr_08e89a
	clc
rpr_08e89b
	adc.w race_callback
rpr_08e89e
	phx
rpr_08e89f
	phy
rpr_08e8a0
	i8
rpr_08e8a2
	lsr a
rpr_08e8a3
	lsr a
rpr_08e8a4
	lsr a
rpr_08e8a5
	tax
rpr_08e8a6
	lda.l retail_eyeframes,x
rpr_08e8aa
	i16
rpr_08e8ac
	ply
rpr_08e8ad
	plx
rpr_08e8ae
	rts
	shorta
	longi
; US $08:E8CF.
retail_makeimpact_l
	lda.w racesound_playmode
rpr_08e8d2
	bne rpr_08e918
rpr_08e8d4
	a16
rpr_08e8d6
	lda #$a158
rpr_08e8d9
	sta.w race_scratch
rpr_08e8dc
	a8
rpr_08e8de
	jsl retail_makeactor_l
rpr_08e8e2
	bcs rpr_08e8e8
rpr_08e8e4
	jml rpr_08e918
rpr_08e8e8
	lda.w al_sflags,y
rpr_08e8eb
	ora #$04
rpr_08e8ed
	sta.w al_sflags,y
rpr_08e8f0
	lda #$03
rpr_08e8f2
	sta.w al_sbyte3,y
rpr_08e8f5
	lda #$14
rpr_08e8f7
	sta.w al_sbyte1,y
rpr_08e8fa
	lda #$0a
rpr_08e8fc
	sta.w al_sbyte2,y
rpr_08e8ff
	a16
rpr_08e901
	lda #retail_impactactor_l&WM
rpr_08e904
	sta.w al_stratptr,y
rpr_08e907
	a8
rpr_08e909
	lda #mrpresent_begin>>16
rpr_08e90b
	sta.w al_stratptr+2,y
rpr_08e90e
	pha
rpr_08e90f
	a16
rpr_08e911
	txa
rpr_08e912
	sta.w al_sword1,y
rpr_08e915
	a8
rpr_08e917
	pla
rpr_08e918
	rtl
retail_impactactor_l
	lda #$0c
rpr_08e91b
	sta.w al_offroadtime,x
rpr_08e91e
	a16
rpr_08e920
	lda #retail_impactactor_step&WM
rpr_08e923
	sta.w al_stratptr,x
rpr_08e926
	a8
rpr_08e928
	lda #mrpresent_begin>>16
rpr_08e92a
	sta.w al_stratptr+2,x
rpr_08e92d
	lda #$d8
rpr_08e92f
	sta.w al_vz,x
rpr_08e932
	bra rpr_08e957
retail_impactactor_step
	lda.w al_sflags,x
rpr_08e937
	ora #$04
rpr_08e939
	sta.w al_sflags,x
rpr_08e93c
	lda #$00
rpr_08e93e
	sta.w al_sbyte3,x
rpr_08e941
	lda #$00
rpr_08e943
	sta.w al_sbyte1,x
rpr_08e946
	lda #$00
rpr_08e948
	sta.w al_sbyte2,x
rpr_08e94b
	lda.w al_offroadtime,x
rpr_08e94e
	bne rpr_08e954
rpr_08e950
	jml retail_endactor_l
rpr_08e954
	dec.w al_offroadtime,x
rpr_08e957
	ldy.w al_sword1,x
rpr_08e95a
	lda.w al_vz,x
rpr_08e95d
	sta.w race_animcount
rpr_08e960
	lda #$00
rpr_08e962
	sta x1
rpr_08e964
	sta x2
rpr_08e966
	bit #$80
rpr_08e968
	beq rpr_08e970
rpr_08e96a
	lda #$ff
rpr_08e96c
	sta x2+1
rpr_08e96e
	bra rpr_08e972
rpr_08e970
	stz x2+1
rpr_08e972
	lda #$f6
rpr_08e974
	sta y1
rpr_08e976
	sta y2
rpr_08e978
	bit #$80
rpr_08e97a
	beq rpr_08e982
rpr_08e97c
	lda #$ff
rpr_08e97e
	sta y2+1
rpr_08e980
	bra rpr_08e984
rpr_08e982
	stz y2+1
rpr_08e984
	lda.w race_animcount
rpr_08e987
	sta z1
rpr_08e989
	sta.w z2
rpr_08e98c
	bit #$80
rpr_08e98e
	beq rpr_08e997
rpr_08e990
	lda #$ff
rpr_08e992
	sta.w z2+1
rpr_08e995
	bra rpr_08e99a
rpr_08e997
	stz.w z2+1
rpr_08e99a
	lda.w al_rotx,y
rpr_08e99d
	jsl retail_actorrotx_l
rpr_08e9a1
	lda x2
rpr_08e9a3
	sta x1
rpr_08e9a5
	lda y2
rpr_08e9a7
	sta y1
rpr_08e9a9
	lda.w z2
rpr_08e9ac
	sta z1
rpr_08e9ae
	lda.w al_roty,y
rpr_08e9b1
	jsl retail_actorroty_l
rpr_08e9b5
	a16
rpr_08e9b7
	lda x2
rpr_08e9b9
	asl a
rpr_08e9ba
	sta x2
rpr_08e9bc
	lda y2
rpr_08e9be
	asl a
rpr_08e9bf
	sta y2
rpr_08e9c1
	lda.w z2
rpr_08e9c4
	asl a
rpr_08e9c5
	sta.w z2
rpr_08e9c8
	lda.w al_worldx,y
rpr_08e9cb
	clc
rpr_08e9cc
	adc x2
rpr_08e9ce
	sta.w al_worldx,x
rpr_08e9d1
	lda.w al_worldz,y
rpr_08e9d4
	clc
rpr_08e9d5
	adc.w z2
rpr_08e9d8
	sta.w al_worldz,x
rpr_08e9db
	lda.w al_worldy,y
rpr_08e9de
	clc
rpr_08e9df
	adc y2
rpr_08e9e1
	sta.w al_worldy,x
rpr_08e9e4
	a8
rpr_08e9e6
	lda.w al_vz,x
rpr_08e9e9
	clc
rpr_08e9ea
	adc #$fb
rpr_08e9ec
	sta.w al_vz,x
rpr_08e9ef
	jsl retail_updateactorcell_l
rpr_08e9f3
	rtl
	shorta
	longi
retail_eyeturn0
	dw $9aaf,$9ab3,$9ab5,$9ab3,$9aaf
retail_eyeturn1
	dw $9aaf,$9ab3,$9ab5,$9ab7,$9ab1
retail_eyeturn2
	dw $9ab1,$9ab7,$9ab5,$9ab3,$9aaf
retail_eyeturn3
	dw $9ab1,$9ab7,$9ab5,$9ab7,$9ab1
retail_eyeframes
	db $06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01,$00,$00,$00,$00
	db $00,$00,$0b,$0b,$0a,$0a,$09,$09,$08,$08,$07,$07,$06,$06,$06,$06

; A16 mode and X=cleared CPU owner, with a compiled definition in al_sword1.
; Build the existing raw car, then the native wheel/auxiliary presentation tail.
; Failure retains the existing constructor's A16 zero return; success is A8.
 longa
retail_spawnvehicle_l
 jsl retail_createcar_l
 a16
 lda.l m_dynvar1
 beq .failed
 a8
 jml retail_finishcar_l
.failed
 rtl

; Long entry for the native local eight-panel constructor. Y is the owner.
 shorta
retail_makepanels_l
 jsr rpr_makepanels
 rtl
mrpresent_end
