; Retail car breakup, collision feedback and debris strategies.
; A8/I16, direct page zero, binary arithmetic and DB=$7E unless noted.
; Call with retail-layout raw bodies, compiled RCAR definitions, valid
; CPU owner/camera chains and serialized GSU context. Shape and sprite
; words retain retail asset identities until the caller binds those assets.
; al_ptr holds the parent index for pieces and effects.
; al_sword1 is a compiled definition on car owners, a velocity/offset on
; sparks/debris, and an owner index on collision markers. Preserve its role.
; The early game dispatcher is unchanged; these are explicit callable entries.
	incpublics	mrcarfx.ext
mrcarfx_begin
	shorta
	longi
; US $03:D00F.
retail_easeangle4_l
	cmp tpx
rcf_03d011
	bne rcf_03d017
rcf_03d013
	jml rsc_easereturn+4
rcf_03d017
	sec
rcf_03d018
	sbc tpx
rcf_03d01a
	cmp #$00
rcf_03d01c
	bmi rcf_03d026
rcf_03d01e
	cmp #$04
rcf_03d020
	bpl rcf_03d02c
rcf_03d022
	lda #$04
rcf_03d024
	bra rcf_03d02c
rcf_03d026
	cmp #$fc
rcf_03d028
	bmi rcf_03d02c
rcf_03d02a
	lda #$fc
rcf_03d02c
	cmp #$80
rcf_03d02e
	ror a
rcf_03d02f
	bpl rcf_03d033
rcf_03d031
	adc #$00
rcf_03d033
	cmp #$80
rcf_03d035
	ror a
rcf_03d036
	bpl rcf_03d03a
rcf_03d038
	adc #$00
rcf_03d03a
	clc
rcf_03d03b
	adc tpx
rcf_03d03d
	sta tpx
rcf_03d03f
	brl rsc_easereturn
retail_easeangle8_l
	cmp tpx
rcf_03d044
	bne rcf_03d04a
rcf_03d046
	jml rsc_easereturn+4
rcf_03d04a
	sec
rcf_03d04b
	sbc tpx
rcf_03d04d
	cmp #$00
rcf_03d04f
	bmi rcf_03d059
rcf_03d051
	cmp #$08
rcf_03d053
	bpl rcf_03d05f
rcf_03d055
	lda #$08
rcf_03d057
	bra rcf_03d05f
rcf_03d059
	cmp #$f8
rcf_03d05b
	bmi rcf_03d05f
rcf_03d05d
	lda #$f8
rcf_03d05f
	cmp #$80
rcf_03d061
	ror a
rcf_03d062
	bpl rcf_03d066
rcf_03d064
	adc #$00
rcf_03d066
	cmp #$80
rcf_03d068
	ror a
rcf_03d069
	bpl rcf_03d06d
rcf_03d06b
	adc #$00
rcf_03d06d
	cmp #$80
rcf_03d06f
	ror a
rcf_03d070
	bpl rcf_03d074
rcf_03d072
	adc #$00
rcf_03d074
	clc
rcf_03d075
	adc tpx
rcf_03d077
	sta tpx
rcf_03d079
	brl rsc_easereturn
	shorta
	longi
; US $08:A034.
retail_breakcar_l
	sta.w race_animcount
rcf_08a037
	lda.w al_sflags2,x
rcf_08a03a
	and #$04
rcf_08a03c
	beq rcf_08a042
rcf_08a03e
	jml rcf_08a092
rcf_08a042
	lda.w al_sflags2,x
rcf_08a045
	and #$80
rcf_08a047
	beq rcf_08a04d
rcf_08a049
	jml rcf_08a092
rcf_08a04d
	a16
rcf_08a04f
	lda.w al_sword1,x
rcf_08a052
	cmp #rcar81b9&WM
rcf_08a055
	bne rcf_08a05a
rcf_08a057
	brl rcf_breakf1
rcf_08a05a
	cmp #rcar853d&WM
rcf_08a05d
	bne rcf_08a062
rcf_08a05f
	brl rcf_breakcoupe
rcf_08a062
	cmp #rcar8411&WM
rcf_08a065
	bne rcf_08a06a
rcf_08a067
	brl rcf_breaktruck
rcf_08a06a
	cmp #rcar82e5&WM
rcf_08a06d
	bne rcf_08a072
rcf_08a06f
	brl rcf_break4wd
rcf_08a072
	cmp #rcar876e&WM
rcf_08a075
	bne rcf_08a07a
rcf_08a077
	brl rcf_breakf1
rcf_08a07a
	cmp #rcar8aa8&WM
rcf_08a07d
	bne rcf_08a082
rcf_08a07f
	brl rcf_breakcoupe
rcf_08a082
	cmp #rcar8990&WM
rcf_08a085
	bne rcf_08a08a
rcf_08a087
	brl rcf_breaktruck
rcf_08a08a
	cmp #rcar8886&WM
rcf_08a08d
	bne rcf_08a092
rcf_08a08f
	brl rcf_break4wd
rcf_08a092
	a8
rcf_08a094
	sec
rcf_08a095
	rtl
	shorta
	longi
rcf_break4wd
	a8
rcf_08a098
	a16
rcf_08a09a
	lda #$a8c8
rcf_08a09d
	sta.w race_scratch
rcf_08a0a0
	a8
rcf_08a0a2
	jsl retail_makeactor_l
rcf_08a0a6
	bcs rcf_08a0ac
rcf_08a0a8
	jml rcf_08a092
rcf_08a0ac
	lda #$d8
rcf_08a0ae
	sta.w al_sbyte1,y
rcf_08a0b1
	lda #$ec
rcf_08a0b3
	sta.w al_sbyte2,y
rcf_08a0b6
	lda #$b6
rcf_08a0b8
	sta.w al_sbyte3,y
rcf_08a0bb
	pha
rcf_08a0bc
	a16
rcf_08a0be
	txa
rcf_08a0bf
	sta.w al_ptr,y
rcf_08a0c2
	a8
rcf_08a0c4
	pla
rcf_08a0c5
	lda #$23
rcf_08a0c7
	sta.w al_offroadtime,y
rcf_08a0ca
	lda #$ff
rcf_08a0cc
	sta.w al_sword1,y
rcf_08a0cf
	lda.w race_animcount
rcf_08a0d2
	and #$02
rcf_08a0d4
	beq rcf_08a0db
rcf_08a0d6
	lda #$14
rcf_08a0d8
	sta.w al_sword1,y
rcf_08a0db
	lda.w al_sflags2,y
rcf_08a0de
	ora #$02
rcf_08a0e0
	sta.w al_sflags2,y
rcf_08a0e3
	lda.w race_animcount
rcf_08a0e6
	and #$01
rcf_08a0e8
	bne rcf_08a0fb
rcf_08a0ea
	a16
rcf_08a0ec
	lda #retail_separatepiece_l&WM
rcf_08a0ef
	sta.w al_stratptr,y
rcf_08a0f2
	a8
rcf_08a0f4
	lda #mrcarfx_begin>>16
rcf_08a0f6
	sta.w al_stratptr+2,y
rcf_08a0f9
	bra rcf_08a118
rcf_08a0fb
	a16
rcf_08a0fd
	lda #retail_launchpiece_l&WM
rcf_08a100
	sta.w al_stratptr,y
rcf_08a103
	a8
rcf_08a105
	lda #mrcarfx_begin>>16
rcf_08a107
	sta.w al_stratptr+2,y
rcf_08a10a
	jsr rcf_callpiece
rcf_08a10d
	lda.w al_sflags2,x
rcf_08a110
	and #$04
rcf_08a112
	bne rcf_08a118
rcf_08a114
	jml rcf_08a092
rcf_08a118
	a16
rcf_08a11a
	lda #$a83c
rcf_08a11d
	sta.w race_scratch
rcf_08a120
	a8
rcf_08a122
	jsl retail_makeactor_l
rcf_08a126
	bcs rcf_08a12c
rcf_08a128
	jml rcf_08a182
rcf_08a12c
	lda #$00
rcf_08a12e
	sta.w al_sbyte1,y
rcf_08a131
	lda #$dc
rcf_08a133
	sta.w al_sbyte2,y
rcf_08a136
	lda #$14
rcf_08a138
	sta.w al_sbyte3,y
rcf_08a13b
	pha
rcf_08a13c
	a16
rcf_08a13e
	txa
rcf_08a13f
	sta.w al_ptr,y
rcf_08a142
	a8
rcf_08a144
	pla
rcf_08a145
	lda #$00
rcf_08a147
	sta.w al_offroadtime,y
rcf_08a14a
	lda #$ff
rcf_08a14c
	sta.w al_sword1,y
rcf_08a14f
	lda.w race_animcount
rcf_08a152
	and #$02
rcf_08a154
	beq rcf_08a15b
rcf_08a156
	lda #$14
rcf_08a158
	sta.w al_sword1,y
rcf_08a15b
	lda.w race_animcount
rcf_08a15e
	and #$01
rcf_08a160
	bne rcf_08a173
rcf_08a162
	a16
rcf_08a164
	lda #retail_separatepiece_l&WM
rcf_08a167
	sta.w al_stratptr,y
rcf_08a16a
	a8
rcf_08a16c
	lda #mrcarfx_begin>>16
rcf_08a16e
	sta.w al_stratptr+2,y
rcf_08a171
	bra rcf_08a182
rcf_08a173
	a16
rcf_08a175
	lda #retail_launchpiece_init&WM
rcf_08a178
	sta.w al_stratptr,y
rcf_08a17b
	a8
rcf_08a17d
	lda #mrcarfx_begin>>16
rcf_08a17f
	sta.w al_stratptr+2,y
rcf_08a182
	a16
rcf_08a184
	lda #$a858
rcf_08a187
	sta.w race_scratch
rcf_08a18a
	a8
rcf_08a18c
	jsl retail_makeactor_l
rcf_08a190
	bcs rcf_08a196
rcf_08a192
	jml rcf_08a1f4
rcf_08a196
	lda #$00
rcf_08a198
	sta.w al_sbyte1,y
rcf_08a19b
	lda #$ec
rcf_08a19d
	sta.w al_sbyte2,y
rcf_08a1a0
	lda #$1c
rcf_08a1a2
	sta.w al_sbyte3,y
rcf_08a1a5
	pha
rcf_08a1a6
	a16
rcf_08a1a8
	txa
rcf_08a1a9
	sta.w al_ptr,y
rcf_08a1ac
	a8
rcf_08a1ae
	pla
rcf_08a1af
	lda #$0a
rcf_08a1b1
	sta.w al_offroadtime,y
rcf_08a1b4
	lda #$ff
rcf_08a1b6
	sta.w al_sword1,y
rcf_08a1b9
	lda.w race_animcount
rcf_08a1bc
	and #$02
rcf_08a1be
	beq rcf_08a1c5
rcf_08a1c0
	lda #$14
rcf_08a1c2
	sta.w al_sword1,y
rcf_08a1c5
	lda.w al_sflags2,y
rcf_08a1c8
	ora #$02
rcf_08a1ca
	sta.w al_sflags2,y
rcf_08a1cd
	lda.w race_animcount
rcf_08a1d0
	and #$01
rcf_08a1d2
	bne rcf_08a1e5
rcf_08a1d4
	a16
rcf_08a1d6
	lda #retail_separatepiece_l&WM
rcf_08a1d9
	sta.w al_stratptr,y
rcf_08a1dc
	a8
rcf_08a1de
	lda #mrcarfx_begin>>16
rcf_08a1e0
	sta.w al_stratptr+2,y
rcf_08a1e3
	bra rcf_08a1f4
rcf_08a1e5
	a16
rcf_08a1e7
	lda #retail_launchpiece_init&WM
rcf_08a1ea
	sta.w al_stratptr,y
rcf_08a1ed
	a8
rcf_08a1ef
	lda #mrcarfx_begin>>16
rcf_08a1f1
	sta.w al_stratptr+2,y
rcf_08a1f4
	a16
rcf_08a1f6
	lda #$a874
rcf_08a1f9
	sta.w race_scratch
rcf_08a1fc
	a8
rcf_08a1fe
	jsl retail_makeactor_l
rcf_08a202
	bcs rcf_08a208
rcf_08a204
	jml rcf_08a25e
rcf_08a208
	lda #$00
rcf_08a20a
	sta.w al_sbyte1,y
rcf_08a20d
	lda #$e0
rcf_08a20f
	sta.w al_sbyte2,y
rcf_08a212
	lda #$e2
rcf_08a214
	sta.w al_sbyte3,y
rcf_08a217
	pha
rcf_08a218
	a16
rcf_08a21a
	txa
rcf_08a21b
	sta.w al_ptr,y
rcf_08a21e
	a8
rcf_08a220
	pla
rcf_08a221
	lda #$14
rcf_08a223
	sta.w al_offroadtime,y
rcf_08a226
	lda #$ff
rcf_08a228
	sta.w al_sword1,y
rcf_08a22b
	lda.w race_animcount
rcf_08a22e
	and #$02
rcf_08a230
	beq rcf_08a237
rcf_08a232
	lda #$14
rcf_08a234
	sta.w al_sword1,y
rcf_08a237
	lda.w race_animcount
rcf_08a23a
	and #$01
rcf_08a23c
	bne rcf_08a24f
rcf_08a23e
	a16
rcf_08a240
	lda #retail_separatepiece_l&WM
rcf_08a243
	sta.w al_stratptr,y
rcf_08a246
	a8
rcf_08a248
	lda #mrcarfx_begin>>16
rcf_08a24a
	sta.w al_stratptr+2,y
rcf_08a24d
	bra rcf_08a25e
rcf_08a24f
	a16
rcf_08a251
	lda #retail_launchpiece_init&WM
rcf_08a254
	sta.w al_stratptr,y
rcf_08a257
	a8
rcf_08a259
	lda #mrcarfx_begin>>16
rcf_08a25b
	sta.w al_stratptr+2,y
rcf_08a25e
	a16
rcf_08a260
	lda #$a890
rcf_08a263
	sta.w race_scratch
rcf_08a266
	a8
rcf_08a268
	jsl retail_makeactor_l
rcf_08a26c
	bcs rcf_08a272
rcf_08a26e
	jml rcf_08a2d0
rcf_08a272
	lda #$00
rcf_08a274
	sta.w al_sbyte1,y
rcf_08a277
	lda #$e8
rcf_08a279
	sta.w al_sbyte2,y
rcf_08a27c
	lda #$c6
rcf_08a27e
	sta.w al_sbyte3,y
rcf_08a281
	pha
rcf_08a282
	a16
rcf_08a284
	txa
rcf_08a285
	sta.w al_ptr,y
rcf_08a288
	a8
rcf_08a28a
	pla
rcf_08a28b
	lda #$19
rcf_08a28d
	sta.w al_offroadtime,y
rcf_08a290
	lda #$ff
rcf_08a292
	sta.w al_sword1,y
rcf_08a295
	lda.w race_animcount
rcf_08a298
	and #$02
rcf_08a29a
	beq rcf_08a2a1
rcf_08a29c
	lda #$14
rcf_08a29e
	sta.w al_sword1,y
rcf_08a2a1
	lda.w al_sflags2,y
rcf_08a2a4
	ora #$02
rcf_08a2a6
	sta.w al_sflags2,y
rcf_08a2a9
	lda.w race_animcount
rcf_08a2ac
	and #$01
rcf_08a2ae
	bne rcf_08a2c1
rcf_08a2b0
	a16
rcf_08a2b2
	lda #retail_separatepiece_l&WM
rcf_08a2b5
	sta.w al_stratptr,y
rcf_08a2b8
	a8
rcf_08a2ba
	lda #mrcarfx_begin>>16
rcf_08a2bc
	sta.w al_stratptr+2,y
rcf_08a2bf
	bra rcf_08a2d0
rcf_08a2c1
	a16
rcf_08a2c3
	lda #retail_launchpiece_init&WM
rcf_08a2c6
	sta.w al_stratptr,y
rcf_08a2c9
	a8
rcf_08a2cb
	lda #mrcarfx_begin>>16
rcf_08a2cd
	sta.w al_stratptr+2,y
rcf_08a2d0
	a16
rcf_08a2d2
	lda #$a8ac
rcf_08a2d5
	sta.w race_scratch
rcf_08a2d8
	a8
rcf_08a2da
	jsl retail_makeactor_l
rcf_08a2de
	bcs rcf_08a2e4
rcf_08a2e0
	jml rcf_08a33a
rcf_08a2e4
	lda #$28
rcf_08a2e6
	sta.w al_sbyte1,y
rcf_08a2e9
	lda #$ec
rcf_08a2eb
	sta.w al_sbyte2,y
rcf_08a2ee
	lda #$b6
rcf_08a2f0
	sta.w al_sbyte3,y
rcf_08a2f3
	pha
rcf_08a2f4
	a16
rcf_08a2f6
	txa
rcf_08a2f7
	sta.w al_ptr,y
rcf_08a2fa
	a8
rcf_08a2fc
	pla
rcf_08a2fd
	lda #$1e
rcf_08a2ff
	sta.w al_offroadtime,y
rcf_08a302
	lda #$ff
rcf_08a304
	sta.w al_sword1,y
rcf_08a307
	lda.w race_animcount
rcf_08a30a
	and #$02
rcf_08a30c
	beq rcf_08a313
rcf_08a30e
	lda #$14
rcf_08a310
	sta.w al_sword1,y
rcf_08a313
	lda.w race_animcount
rcf_08a316
	and #$01
rcf_08a318
	bne rcf_08a32b
rcf_08a31a
	a16
rcf_08a31c
	lda #retail_separatepiece_l&WM
rcf_08a31f
	sta.w al_stratptr,y
rcf_08a322
	a8
rcf_08a324
	lda #mrcarfx_begin>>16
rcf_08a326
	sta.w al_stratptr+2,y
rcf_08a329
	bra rcf_08a33a
rcf_08a32b
	a16
rcf_08a32d
	lda #retail_launchpiece_init&WM
rcf_08a330
	sta.w al_stratptr,y
rcf_08a333
	a8
rcf_08a335
	lda #mrcarfx_begin>>16
rcf_08a337
	sta.w al_stratptr+2,y
rcf_08a33a
	jmp rcf_08ab2f
	shorta
	longi
rcf_breaktruck
	a8
rcf_08a33f
	a16
rcf_08a341
	lda #$a44c
rcf_08a344
	sta.w race_scratch
rcf_08a347
	a8
rcf_08a349
	jsl retail_makeactor_l
rcf_08a34d
	bcs rcf_08a353
rcf_08a34f
	jml rcf_08a092
rcf_08a353
	lda #$00
rcf_08a355
	sta.w al_sbyte1,y
rcf_08a358
	lda #$ee
rcf_08a35a
	sta.w al_sbyte2,y
rcf_08a35d
	lda #$42
rcf_08a35f
	sta.w al_sbyte3,y
rcf_08a362
	pha
rcf_08a363
	a16
rcf_08a365
	txa
rcf_08a366
	sta.w al_ptr,y
rcf_08a369
	a8
rcf_08a36b
	pla
rcf_08a36c
	lda #$23
rcf_08a36e
	sta.w al_offroadtime,y
rcf_08a371
	lda #$ff
rcf_08a373
	sta.w al_sword1,y
rcf_08a376
	lda.w race_animcount
rcf_08a379
	and #$02
rcf_08a37b
	beq rcf_08a382
rcf_08a37d
	lda #$14
rcf_08a37f
	sta.w al_sword1,y
rcf_08a382
	lda.w al_sflags2,y
rcf_08a385
	ora #$02
rcf_08a387
	sta.w al_sflags2,y
rcf_08a38a
	lda.w race_animcount
rcf_08a38d
	and #$01
rcf_08a38f
	bne rcf_08a3a2
rcf_08a391
	a16
rcf_08a393
	lda #retail_separatepiece_l&WM
rcf_08a396
	sta.w al_stratptr,y
rcf_08a399
	a8
rcf_08a39b
	lda #mrcarfx_begin>>16
rcf_08a39d
	sta.w al_stratptr+2,y
rcf_08a3a0
	bra rcf_08a3bf
rcf_08a3a2
	a16
rcf_08a3a4
	lda #retail_launchpiece_l&WM
rcf_08a3a7
	sta.w al_stratptr,y
rcf_08a3aa
	a8
rcf_08a3ac
	lda #mrcarfx_begin>>16
rcf_08a3ae
	sta.w al_stratptr+2,y
rcf_08a3b1
	jsr rcf_callpiece
rcf_08a3b4
	lda.w al_sflags2,x
rcf_08a3b7
	and #$04
rcf_08a3b9
	bne rcf_08a3bf
rcf_08a3bb
	jml rcf_08a092
rcf_08a3bf
	a16
rcf_08a3c1
	lda #$a430
rcf_08a3c4
	sta.w race_scratch
rcf_08a3c7
	a8
rcf_08a3c9
	jsl retail_makeactor_l
rcf_08a3cd
	bcs rcf_08a3d3
rcf_08a3cf
	jml rcf_08a429
rcf_08a3d3
	lda #$00
rcf_08a3d5
	sta.w al_sbyte1,y
rcf_08a3d8
	lda #$f1
rcf_08a3da
	sta.w al_sbyte2,y
rcf_08a3dd
	lda #$3c
rcf_08a3df
	sta.w al_sbyte3,y
rcf_08a3e2
	pha
rcf_08a3e3
	a16
rcf_08a3e5
	txa
rcf_08a3e6
	sta.w al_ptr,y
rcf_08a3e9
	a8
rcf_08a3eb
	pla
rcf_08a3ec
	lda #$00
rcf_08a3ee
	sta.w al_offroadtime,y
rcf_08a3f1
	lda #$ff
rcf_08a3f3
	sta.w al_sword1,y
rcf_08a3f6
	lda.w race_animcount
rcf_08a3f9
	and #$02
rcf_08a3fb
	beq rcf_08a402
rcf_08a3fd
	lda #$14
rcf_08a3ff
	sta.w al_sword1,y
rcf_08a402
	lda.w race_animcount
rcf_08a405
	and #$01
rcf_08a407
	bne rcf_08a41a
rcf_08a409
	a16
rcf_08a40b
	lda #retail_separatepiece_l&WM
rcf_08a40e
	sta.w al_stratptr,y
rcf_08a411
	a8
rcf_08a413
	lda #mrcarfx_begin>>16
rcf_08a415
	sta.w al_stratptr+2,y
rcf_08a418
	bra rcf_08a429
rcf_08a41a
	a16
rcf_08a41c
	lda #retail_launchpiece_init&WM
rcf_08a41f
	sta.w al_stratptr,y
rcf_08a422
	a8
rcf_08a424
	lda #mrcarfx_begin>>16
rcf_08a426
	sta.w al_stratptr+2,y
rcf_08a429
	a16
rcf_08a42b
	lda #$a3c0
rcf_08a42e
	sta.w race_scratch
rcf_08a431
	a8
rcf_08a433
	jsl retail_makeactor_l
rcf_08a437
	bcs rcf_08a43d
rcf_08a439
	jml rcf_08a49b
rcf_08a43d
	lda #$00
rcf_08a43f
	sta.w al_sbyte1,y
rcf_08a442
	lda #$ce
rcf_08a444
	sta.w al_sbyte2,y
rcf_08a447
	lda #$0f
rcf_08a449
	sta.w al_sbyte3,y
rcf_08a44c
	pha
rcf_08a44d
	a16
rcf_08a44f
	txa
rcf_08a450
	sta.w al_ptr,y
rcf_08a453
	a8
rcf_08a455
	pla
rcf_08a456
	lda #$0a
rcf_08a458
	sta.w al_offroadtime,y
rcf_08a45b
	lda #$ff
rcf_08a45d
	sta.w al_sword1,y
rcf_08a460
	lda.w race_animcount
rcf_08a463
	and #$02
rcf_08a465
	beq rcf_08a46c
rcf_08a467
	lda #$14
rcf_08a469
	sta.w al_sword1,y
rcf_08a46c
	lda.w al_sflags2,y
rcf_08a46f
	ora #$02
rcf_08a471
	sta.w al_sflags2,y
rcf_08a474
	lda.w race_animcount
rcf_08a477
	and #$01
rcf_08a479
	bne rcf_08a48c
rcf_08a47b
	a16
rcf_08a47d
	lda #retail_separatepiece_l&WM
rcf_08a480
	sta.w al_stratptr,y
rcf_08a483
	a8
rcf_08a485
	lda #mrcarfx_begin>>16
rcf_08a487
	sta.w al_stratptr+2,y
rcf_08a48a
	bra rcf_08a49b
rcf_08a48c
	a16
rcf_08a48e
	lda #retail_launchpiece_init&WM
rcf_08a491
	sta.w al_stratptr,y
rcf_08a494
	a8
rcf_08a496
	lda #mrcarfx_begin>>16
rcf_08a498
	sta.w al_stratptr+2,y
rcf_08a49b
	a16
rcf_08a49d
	lda #$a3dc
rcf_08a4a0
	sta.w race_scratch
rcf_08a4a3
	a8
rcf_08a4a5
	jsl retail_makeactor_l
rcf_08a4a9
	bcs rcf_08a4af
rcf_08a4ab
	jml rcf_08a505
rcf_08a4af
	lda #$00
rcf_08a4b1
	sta.w al_sbyte1,y
rcf_08a4b4
	lda #$d0
rcf_08a4b6
	sta.w al_sbyte2,y
rcf_08a4b9
	lda #$e9
rcf_08a4bb
	sta.w al_sbyte3,y
rcf_08a4be
	pha
rcf_08a4bf
	a16
rcf_08a4c1
	txa
rcf_08a4c2
	sta.w al_ptr,y
rcf_08a4c5
	a8
rcf_08a4c7
	pla
rcf_08a4c8
	lda #$14
rcf_08a4ca
	sta.w al_offroadtime,y
rcf_08a4cd
	lda #$ff
rcf_08a4cf
	sta.w al_sword1,y
rcf_08a4d2
	lda.w race_animcount
rcf_08a4d5
	and #$02
rcf_08a4d7
	beq rcf_08a4de
rcf_08a4d9
	lda #$14
rcf_08a4db
	sta.w al_sword1,y
rcf_08a4de
	lda.w race_animcount
rcf_08a4e1
	and #$01
rcf_08a4e3
	bne rcf_08a4f6
rcf_08a4e5
	a16
rcf_08a4e7
	lda #retail_separatepiece_l&WM
rcf_08a4ea
	sta.w al_stratptr,y
rcf_08a4ed
	a8
rcf_08a4ef
	lda #mrcarfx_begin>>16
rcf_08a4f1
	sta.w al_stratptr+2,y
rcf_08a4f4
	bra rcf_08a505
rcf_08a4f6
	a16
rcf_08a4f8
	lda #retail_launchpiece_init&WM
rcf_08a4fb
	sta.w al_stratptr,y
rcf_08a4fe
	a8
rcf_08a500
	lda #mrcarfx_begin>>16
rcf_08a502
	sta.w al_stratptr+2,y
rcf_08a505
	a16
rcf_08a507
	lda #$a3f8
rcf_08a50a
	sta.w race_scratch
rcf_08a50d
	a8
rcf_08a50f
	jsl retail_makeactor_l
rcf_08a513
	bcs rcf_08a519
rcf_08a515
	jml rcf_08a577
rcf_08a519
	lda #$00
rcf_08a51b
	sta.w al_sbyte1,y
rcf_08a51e
	lda #$ef
rcf_08a520
	sta.w al_sbyte2,y
rcf_08a523
	lda #$f6
rcf_08a525
	sta.w al_sbyte3,y
rcf_08a528
	pha
rcf_08a529
	a16
rcf_08a52b
	txa
rcf_08a52c
	sta.w al_ptr,y
rcf_08a52f
	a8
rcf_08a531
	pla
rcf_08a532
	lda #$19
rcf_08a534
	sta.w al_offroadtime,y
rcf_08a537
	lda #$ff
rcf_08a539
	sta.w al_sword1,y
rcf_08a53c
	lda.w race_animcount
rcf_08a53f
	and #$02
rcf_08a541
	beq rcf_08a548
rcf_08a543
	lda #$14
rcf_08a545
	sta.w al_sword1,y
rcf_08a548
	lda.w al_sflags2,y
rcf_08a54b
	ora #$02
rcf_08a54d
	sta.w al_sflags2,y
rcf_08a550
	lda.w race_animcount
rcf_08a553
	and #$01
rcf_08a555
	bne rcf_08a568
rcf_08a557
	a16
rcf_08a559
	lda #retail_separatepiece_l&WM
rcf_08a55c
	sta.w al_stratptr,y
rcf_08a55f
	a8
rcf_08a561
	lda #mrcarfx_begin>>16
rcf_08a563
	sta.w al_stratptr+2,y
rcf_08a566
	bra rcf_08a577
rcf_08a568
	a16
rcf_08a56a
	lda #retail_launchpiece_init&WM
rcf_08a56d
	sta.w al_stratptr,y
rcf_08a570
	a8
rcf_08a572
	lda #mrcarfx_begin>>16
rcf_08a574
	sta.w al_stratptr+2,y
rcf_08a577
	a16
rcf_08a579
	lda #$a414
rcf_08a57c
	sta.w race_scratch
rcf_08a57f
	a8
rcf_08a581
	jsl retail_makeactor_l
rcf_08a585
	bcs rcf_08a58b
rcf_08a587
	jml rcf_08a5e1
rcf_08a58b
	lda #$00
rcf_08a58d
	sta.w al_sbyte1,y
rcf_08a590
	lda #$0f
rcf_08a592
	sta.w al_sbyte2,y
rcf_08a595
	lda #$02
rcf_08a597
	sta.w al_sbyte3,y
rcf_08a59a
	pha
rcf_08a59b
	a16
rcf_08a59d
	txa
rcf_08a59e
	sta.w al_ptr,y
rcf_08a5a1
	a8
rcf_08a5a3
	pla
rcf_08a5a4
	lda #$1e
rcf_08a5a6
	sta.w al_offroadtime,y
rcf_08a5a9
	lda #$ff
rcf_08a5ab
	sta.w al_sword1,y
rcf_08a5ae
	lda.w race_animcount
rcf_08a5b1
	and #$02
rcf_08a5b3
	beq rcf_08a5ba
rcf_08a5b5
	lda #$14
rcf_08a5b7
	sta.w al_sword1,y
rcf_08a5ba
	lda.w race_animcount
rcf_08a5bd
	and #$01
rcf_08a5bf
	bne rcf_08a5d2
rcf_08a5c1
	a16
rcf_08a5c3
	lda #retail_separatepiece_l&WM
rcf_08a5c6
	sta.w al_stratptr,y
rcf_08a5c9
	a8
rcf_08a5cb
	lda #mrcarfx_begin>>16
rcf_08a5cd
	sta.w al_stratptr+2,y
rcf_08a5d0
	bra rcf_08a5e1
rcf_08a5d2
	a16
rcf_08a5d4
	lda #retail_launchpiece_init&WM
rcf_08a5d7
	sta.w al_stratptr,y
rcf_08a5da
	a8
rcf_08a5dc
	lda #mrcarfx_begin>>16
rcf_08a5de
	sta.w al_stratptr+2,y
rcf_08a5e1
	jmp rcf_08ab2f
	shorta
	longi
rcf_breakf1
	a8
rcf_08a5e6
	a16
rcf_08a5e8
	lda #$a3a4
rcf_08a5eb
	sta.w race_scratch
rcf_08a5ee
	a8
rcf_08a5f0
	jsl retail_makeactor_l
rcf_08a5f4
	bcs rcf_08a5fa
rcf_08a5f6
	jml rcf_08a092
rcf_08a5fa
	lda #$00
rcf_08a5fc
	sta.w al_sbyte1,y
rcf_08a5ff
	lda #$e3
rcf_08a601
	sta.w al_sbyte2,y
rcf_08a604
	lda #$c5
rcf_08a606
	sta.w al_sbyte3,y
rcf_08a609
	pha
rcf_08a60a
	a16
rcf_08a60c
	txa
rcf_08a60d
	sta.w al_ptr,y
rcf_08a610
	a8
rcf_08a612
	pla
rcf_08a613
	lda #$23
rcf_08a615
	sta.w al_offroadtime,y
rcf_08a618
	lda #$ff
rcf_08a61a
	sta.w al_sword1,y
rcf_08a61d
	lda.w race_animcount
rcf_08a620
	and #$02
rcf_08a622
	beq rcf_08a629
rcf_08a624
	lda #$14
rcf_08a626
	sta.w al_sword1,y
rcf_08a629
	lda.w al_sflags2,y
rcf_08a62c
	ora #$02
rcf_08a62e
	sta.w al_sflags2,y
rcf_08a631
	lda.w race_animcount
rcf_08a634
	and #$01
rcf_08a636
	bne rcf_08a649
rcf_08a638
	a16
rcf_08a63a
	lda #retail_separatepiece_l&WM
rcf_08a63d
	sta.w al_stratptr,y
rcf_08a640
	a8
rcf_08a642
	lda #mrcarfx_begin>>16
rcf_08a644
	sta.w al_stratptr+2,y
rcf_08a647
	bra rcf_08a666
rcf_08a649
	a16
rcf_08a64b
	lda #retail_launchpiece_l&WM
rcf_08a64e
	sta.w al_stratptr,y
rcf_08a651
	a8
rcf_08a653
	lda #mrcarfx_begin>>16
rcf_08a655
	sta.w al_stratptr+2,y
rcf_08a658
	jsr rcf_callpiece
rcf_08a65b
	lda.w al_sflags2,x
rcf_08a65e
	and #$04
rcf_08a660
	bne rcf_08a666
rcf_08a662
	jml rcf_08a092
rcf_08a666
	a16
rcf_08a668
	lda #$a318
rcf_08a66b
	sta.w race_scratch
rcf_08a66e
	a8
rcf_08a670
	jsl retail_makeactor_l
rcf_08a674
	bcs rcf_08a67a
rcf_08a676
	jml rcf_08a6d0
rcf_08a67a
	lda #$00
rcf_08a67c
	sta.w al_sbyte1,y
rcf_08a67f
	lda #$f9
rcf_08a681
	sta.w al_sbyte2,y
rcf_08a684
	lda #$2d
rcf_08a686
	sta.w al_sbyte3,y
rcf_08a689
	pha
rcf_08a68a
	a16
rcf_08a68c
	txa
rcf_08a68d
	sta.w al_ptr,y
rcf_08a690
	a8
rcf_08a692
	pla
rcf_08a693
	lda #$00
rcf_08a695
	sta.w al_offroadtime,y
rcf_08a698
	lda #$ff
rcf_08a69a
	sta.w al_sword1,y
rcf_08a69d
	lda.w race_animcount
rcf_08a6a0
	and #$02
rcf_08a6a2
	beq rcf_08a6a9
rcf_08a6a4
	lda #$14
rcf_08a6a6
	sta.w al_sword1,y
rcf_08a6a9
	lda.w race_animcount
rcf_08a6ac
	and #$01
rcf_08a6ae
	bne rcf_08a6c1
rcf_08a6b0
	a16
rcf_08a6b2
	lda #retail_separatepiece_l&WM
rcf_08a6b5
	sta.w al_stratptr,y
rcf_08a6b8
	a8
rcf_08a6ba
	lda #mrcarfx_begin>>16
rcf_08a6bc
	sta.w al_stratptr+2,y
rcf_08a6bf
	bra rcf_08a6d0
rcf_08a6c1
	a16
rcf_08a6c3
	lda #retail_launchpiece_init&WM
rcf_08a6c6
	sta.w al_stratptr,y
rcf_08a6c9
	a8
rcf_08a6cb
	lda #mrcarfx_begin>>16
rcf_08a6cd
	sta.w al_stratptr+2,y
rcf_08a6d0
	a16
rcf_08a6d2
	lda #$a334
rcf_08a6d5
	sta.w race_scratch
rcf_08a6d8
	a8
rcf_08a6da
	jsl retail_makeactor_l
rcf_08a6de
	bcs rcf_08a6e4
rcf_08a6e0
	jml rcf_08a742
rcf_08a6e4
	lda #$e9
rcf_08a6e6
	sta.w al_sbyte1,y
rcf_08a6e9
	lda #$fa
rcf_08a6eb
	sta.w al_sbyte2,y
rcf_08a6ee
	lda #$f8
rcf_08a6f0
	sta.w al_sbyte3,y
rcf_08a6f3
	pha
rcf_08a6f4
	a16
rcf_08a6f6
	txa
rcf_08a6f7
	sta.w al_ptr,y
rcf_08a6fa
	a8
rcf_08a6fc
	pla
rcf_08a6fd
	lda #$0a
rcf_08a6ff
	sta.w al_offroadtime,y
rcf_08a702
	lda #$ff
rcf_08a704
	sta.w al_sword1,y
rcf_08a707
	lda.w race_animcount
rcf_08a70a
	and #$02
rcf_08a70c
	beq rcf_08a713
rcf_08a70e
	lda #$14
rcf_08a710
	sta.w al_sword1,y
rcf_08a713
	lda.w al_sflags2,y
rcf_08a716
	ora #$02
rcf_08a718
	sta.w al_sflags2,y
rcf_08a71b
	lda.w race_animcount
rcf_08a71e
	and #$01
rcf_08a720
	bne rcf_08a733
rcf_08a722
	a16
rcf_08a724
	lda #retail_separatepiece_l&WM
rcf_08a727
	sta.w al_stratptr,y
rcf_08a72a
	a8
rcf_08a72c
	lda #mrcarfx_begin>>16
rcf_08a72e
	sta.w al_stratptr+2,y
rcf_08a731
	bra rcf_08a742
rcf_08a733
	a16
rcf_08a735
	lda #retail_launchpiece_init&WM
rcf_08a738
	sta.w al_stratptr,y
rcf_08a73b
	a8
rcf_08a73d
	lda #mrcarfx_begin>>16
rcf_08a73f
	sta.w al_stratptr+2,y
rcf_08a742
	a16
rcf_08a744
	lda #$a350
rcf_08a747
	sta.w race_scratch
rcf_08a74a
	a8
rcf_08a74c
	jsl retail_makeactor_l
rcf_08a750
	bcs rcf_08a756
rcf_08a752
	jml rcf_08a7ac
rcf_08a756
	lda #$17
rcf_08a758
	sta.w al_sbyte1,y
rcf_08a75b
	lda #$fa
rcf_08a75d
	sta.w al_sbyte2,y
rcf_08a760
	lda #$f8
rcf_08a762
	sta.w al_sbyte3,y
rcf_08a765
	pha
rcf_08a766
	a16
rcf_08a768
	txa
rcf_08a769
	sta.w al_ptr,y
rcf_08a76c
	a8
rcf_08a76e
	pla
rcf_08a76f
	lda #$14
rcf_08a771
	sta.w al_offroadtime,y
rcf_08a774
	lda #$ff
rcf_08a776
	sta.w al_sword1,y
rcf_08a779
	lda.w race_animcount
rcf_08a77c
	and #$02
rcf_08a77e
	beq rcf_08a785
rcf_08a780
	lda #$14
rcf_08a782
	sta.w al_sword1,y
rcf_08a785
	lda.w race_animcount
rcf_08a788
	and #$01
rcf_08a78a
	bne rcf_08a79d
rcf_08a78c
	a16
rcf_08a78e
	lda #retail_separatepiece_l&WM
rcf_08a791
	sta.w al_stratptr,y
rcf_08a794
	a8
rcf_08a796
	lda #mrcarfx_begin>>16
rcf_08a798
	sta.w al_stratptr+2,y
rcf_08a79b
	bra rcf_08a7ac
rcf_08a79d
	a16
rcf_08a79f
	lda #retail_launchpiece_init&WM
rcf_08a7a2
	sta.w al_stratptr,y
rcf_08a7a5
	a8
rcf_08a7a7
	lda #mrcarfx_begin>>16
rcf_08a7a9
	sta.w al_stratptr+2,y
rcf_08a7ac
	a16
rcf_08a7ae
	lda #$a36c
rcf_08a7b1
	sta.w race_scratch
rcf_08a7b4
	a8
rcf_08a7b6
	jsl retail_makeactor_l
rcf_08a7ba
	bcs rcf_08a7c0
rcf_08a7bc
	jml rcf_08a81e
rcf_08a7c0
	lda #$00
rcf_08a7c2
	sta.w al_sbyte1,y
rcf_08a7c5
	lda #$f6
rcf_08a7c7
	sta.w al_sbyte2,y
rcf_08a7ca
	lda #$f6
rcf_08a7cc
	sta.w al_sbyte3,y
rcf_08a7cf
	pha
rcf_08a7d0
	a16
rcf_08a7d2
	txa
rcf_08a7d3
	sta.w al_ptr,y
rcf_08a7d6
	a8
rcf_08a7d8
	pla
rcf_08a7d9
	lda #$19
rcf_08a7db
	sta.w al_offroadtime,y
rcf_08a7de
	lda #$ff
rcf_08a7e0
	sta.w al_sword1,y
rcf_08a7e3
	lda.w race_animcount
rcf_08a7e6
	and #$02
rcf_08a7e8
	beq rcf_08a7ef
rcf_08a7ea
	lda #$14
rcf_08a7ec
	sta.w al_sword1,y
rcf_08a7ef
	lda.w al_sflags2,y
rcf_08a7f2
	ora #$02
rcf_08a7f4
	sta.w al_sflags2,y
rcf_08a7f7
	lda.w race_animcount
rcf_08a7fa
	and #$01
rcf_08a7fc
	bne rcf_08a80f
rcf_08a7fe
	a16
rcf_08a800
	lda #retail_separatepiece_l&WM
rcf_08a803
	sta.w al_stratptr,y
rcf_08a806
	a8
rcf_08a808
	lda #mrcarfx_begin>>16
rcf_08a80a
	sta.w al_stratptr+2,y
rcf_08a80d
	bra rcf_08a81e
rcf_08a80f
	a16
rcf_08a811
	lda #retail_launchpiece_init&WM
rcf_08a814
	sta.w al_stratptr,y
rcf_08a817
	a8
rcf_08a819
	lda #mrcarfx_begin>>16
rcf_08a81b
	sta.w al_stratptr+2,y
rcf_08a81e
	a16
rcf_08a820
	lda #$a388
rcf_08a823
	sta.w race_scratch
rcf_08a826
	a8
rcf_08a828
	jsl retail_makeactor_l
rcf_08a82c
	bcs rcf_08a832
rcf_08a82e
	jml rcf_08a888
rcf_08a832
	lda #$00
rcf_08a834
	sta.w al_sbyte1,y
rcf_08a837
	lda #$f7
rcf_08a839
	sta.w al_sbyte2,y
rcf_08a83c
	lda #$da
rcf_08a83e
	sta.w al_sbyte3,y
rcf_08a841
	pha
rcf_08a842
	a16
rcf_08a844
	txa
rcf_08a845
	sta.w al_ptr,y
rcf_08a848
	a8
rcf_08a84a
	pla
rcf_08a84b
	lda #$1e
rcf_08a84d
	sta.w al_offroadtime,y
rcf_08a850
	lda #$ff
rcf_08a852
	sta.w al_sword1,y
rcf_08a855
	lda.w race_animcount
rcf_08a858
	and #$02
rcf_08a85a
	beq rcf_08a861
rcf_08a85c
	lda #$14
rcf_08a85e
	sta.w al_sword1,y
rcf_08a861
	lda.w race_animcount
rcf_08a864
	and #$01
rcf_08a866
	bne rcf_08a879
rcf_08a868
	a16
rcf_08a86a
	lda #retail_separatepiece_l&WM
rcf_08a86d
	sta.w al_stratptr,y
rcf_08a870
	a8
rcf_08a872
	lda #mrcarfx_begin>>16
rcf_08a874
	sta.w al_stratptr+2,y
rcf_08a877
	bra rcf_08a888
rcf_08a879
	a16
rcf_08a87b
	lda #retail_launchpiece_init&WM
rcf_08a87e
	sta.w al_stratptr,y
rcf_08a881
	a8
rcf_08a883
	lda #mrcarfx_begin>>16
rcf_08a885
	sta.w al_stratptr+2,y
rcf_08a888
	jmp rcf_08ab2f
	shorta
	longi
rcf_breakcoupe
	a8
rcf_08a88d
	a16
rcf_08a88f
	lda #$a4f4
rcf_08a892
	sta.w race_scratch
rcf_08a895
	a8
rcf_08a897
	jsl retail_makeactor_l
rcf_08a89b
	bcs rcf_08a8a1
rcf_08a89d
	jml rcf_08a092
rcf_08a8a1
	lda #$00
rcf_08a8a3
	sta.w al_sbyte1,y
rcf_08a8a6
	lda #$ec
rcf_08a8a8
	sta.w al_sbyte2,y
rcf_08a8ab
	lda #$c5
rcf_08a8ad
	sta.w al_sbyte3,y
rcf_08a8b0
	pha
rcf_08a8b1
	a16
rcf_08a8b3
	txa
rcf_08a8b4
	sta.w al_ptr,y
rcf_08a8b7
	a8
rcf_08a8b9
	pla
rcf_08a8ba
	lda #$23
rcf_08a8bc
	sta.w al_offroadtime,y
rcf_08a8bf
	lda #$ff
rcf_08a8c1
	sta.w al_sword1,y
rcf_08a8c4
	lda.w race_animcount
rcf_08a8c7
	and #$02
rcf_08a8c9
	beq rcf_08a8d0
rcf_08a8cb
	lda #$14
rcf_08a8cd
	sta.w al_sword1,y
rcf_08a8d0
	lda.w al_sflags2,y
rcf_08a8d3
	ora #$02
rcf_08a8d5
	sta.w al_sflags2,y
rcf_08a8d8
	lda.w race_animcount
rcf_08a8db
	and #$01
rcf_08a8dd
	bne rcf_08a8f0
rcf_08a8df
	a16
rcf_08a8e1
	lda #retail_separatepiece_l&WM
rcf_08a8e4
	sta.w al_stratptr,y
rcf_08a8e7
	a8
rcf_08a8e9
	lda #mrcarfx_begin>>16
rcf_08a8eb
	sta.w al_stratptr+2,y
rcf_08a8ee
	bra rcf_08a90d
rcf_08a8f0
	a16
rcf_08a8f2
	lda #retail_launchpiece_l&WM
rcf_08a8f5
	sta.w al_stratptr,y
rcf_08a8f8
	a8
rcf_08a8fa
	lda #mrcarfx_begin>>16
rcf_08a8fc
	sta.w al_stratptr+2,y
rcf_08a8ff
	jsr rcf_callpiece
rcf_08a902
	lda.w al_sflags2,x
rcf_08a905
	and #$04
rcf_08a907
	bne rcf_08a90d
rcf_08a909
	jml rcf_08a092
rcf_08a90d
	a16
rcf_08a90f
	lda #$a468
rcf_08a912
	sta.w race_scratch
rcf_08a915
	a8
rcf_08a917
	jsl retail_makeactor_l
rcf_08a91b
	bcs rcf_08a921
rcf_08a91d
	jml rcf_08a977
rcf_08a921
	lda #$00
rcf_08a923
	sta.w al_sbyte1,y
rcf_08a926
	lda #$fa
rcf_08a928
	sta.w al_sbyte2,y
rcf_08a92b
	lda #$21
rcf_08a92d
	sta.w al_sbyte3,y
rcf_08a930
	pha
rcf_08a931
	a16
rcf_08a933
	txa
rcf_08a934
	sta.w al_ptr,y
rcf_08a937
	a8
rcf_08a939
	pla
rcf_08a93a
	lda #$00
rcf_08a93c
	sta.w al_offroadtime,y
rcf_08a93f
	lda #$ff
rcf_08a941
	sta.w al_sword1,y
rcf_08a944
	lda.w race_animcount
rcf_08a947
	and #$02
rcf_08a949
	beq rcf_08a950
rcf_08a94b
	lda #$14
rcf_08a94d
	sta.w al_sword1,y
rcf_08a950
	lda.w race_animcount
rcf_08a953
	and #$01
rcf_08a955
	bne rcf_08a968
rcf_08a957
	a16
rcf_08a959
	lda #retail_separatepiece_l&WM
rcf_08a95c
	sta.w al_stratptr,y
rcf_08a95f
	a8
rcf_08a961
	lda #mrcarfx_begin>>16
rcf_08a963
	sta.w al_stratptr+2,y
rcf_08a966
	bra rcf_08a977
rcf_08a968
	a16
rcf_08a96a
	lda #retail_launchpiece_init&WM
rcf_08a96d
	sta.w al_stratptr,y
rcf_08a970
	a8
rcf_08a972
	lda #mrcarfx_begin>>16
rcf_08a974
	sta.w al_stratptr+2,y
rcf_08a977
	a16
rcf_08a979
	lda #$a484
rcf_08a97c
	sta.w race_scratch
rcf_08a97f
	a8
rcf_08a981
	jsl retail_makeactor_l
rcf_08a985
	bcs rcf_08a98b
rcf_08a987
	jml rcf_08a9e9
rcf_08a98b
	lda #$00
rcf_08a98d
	sta.w al_sbyte1,y
rcf_08a990
	lda #$d5
rcf_08a992
	sta.w al_sbyte2,y
rcf_08a995
	lda #$ee
rcf_08a997
	sta.w al_sbyte3,y
rcf_08a99a
	pha
rcf_08a99b
	a16
rcf_08a99d
	txa
rcf_08a99e
	sta.w al_ptr,y
rcf_08a9a1
	a8
rcf_08a9a3
	pla
rcf_08a9a4
	lda #$0a
rcf_08a9a6
	sta.w al_offroadtime,y
rcf_08a9a9
	lda #$ff
rcf_08a9ab
	sta.w al_sword1,y
rcf_08a9ae
	lda.w race_animcount
rcf_08a9b1
	and #$02
rcf_08a9b3
	beq rcf_08a9ba
rcf_08a9b5
	lda #$14
rcf_08a9b7
	sta.w al_sword1,y
rcf_08a9ba
	lda.w al_sflags2,y
rcf_08a9bd
	ora #$02
rcf_08a9bf
	sta.w al_sflags2,y
rcf_08a9c2
	lda.w race_animcount
rcf_08a9c5
	and #$01
rcf_08a9c7
	bne rcf_08a9da
rcf_08a9c9
	a16
rcf_08a9cb
	lda #retail_separatepiece_l&WM
rcf_08a9ce
	sta.w al_stratptr,y
rcf_08a9d1
	a8
rcf_08a9d3
	lda #mrcarfx_begin>>16
rcf_08a9d5
	sta.w al_stratptr+2,y
rcf_08a9d8
	bra rcf_08a9e9
rcf_08a9da
	a16
rcf_08a9dc
	lda #retail_launchpiece_init&WM
rcf_08a9df
	sta.w al_stratptr,y
rcf_08a9e2
	a8
rcf_08a9e4
	lda #mrcarfx_begin>>16
rcf_08a9e6
	sta.w al_stratptr+2,y
rcf_08a9e9
	a16
rcf_08a9eb
	lda #$a4a0
rcf_08a9ee
	sta.w race_scratch
rcf_08a9f1
	a8
rcf_08a9f3
	jsl retail_makeactor_l
rcf_08a9f7
	bcs rcf_08a9fd
rcf_08a9f9
	jml rcf_08aa53
rcf_08a9fd
	lda #$ef
rcf_08a9ff
	sta.w al_sbyte1,y
rcf_08aa02
	lda #$f6
rcf_08aa04
	sta.w al_sbyte2,y
rcf_08aa07
	lda #$ec
rcf_08aa09
	sta.w al_sbyte3,y
rcf_08aa0c
	pha
rcf_08aa0d
	a16
rcf_08aa0f
	txa
rcf_08aa10
	sta.w al_ptr,y
rcf_08aa13
	a8
rcf_08aa15
	pla
rcf_08aa16
	lda #$14
rcf_08aa18
	sta.w al_offroadtime,y
rcf_08aa1b
	lda #$ff
rcf_08aa1d
	sta.w al_sword1,y
rcf_08aa20
	lda.w race_animcount
rcf_08aa23
	and #$02
rcf_08aa25
	beq rcf_08aa2c
rcf_08aa27
	lda #$14
rcf_08aa29
	sta.w al_sword1,y
rcf_08aa2c
	lda.w race_animcount
rcf_08aa2f
	and #$01
rcf_08aa31
	bne rcf_08aa44
rcf_08aa33
	a16
rcf_08aa35
	lda #retail_separatepiece_l&WM
rcf_08aa38
	sta.w al_stratptr,y
rcf_08aa3b
	a8
rcf_08aa3d
	lda #mrcarfx_begin>>16
rcf_08aa3f
	sta.w al_stratptr+2,y
rcf_08aa42
	bra rcf_08aa53
rcf_08aa44
	a16
rcf_08aa46
	lda #retail_launchpiece_init&WM
rcf_08aa49
	sta.w al_stratptr,y
rcf_08aa4c
	a8
rcf_08aa4e
	lda #mrcarfx_begin>>16
rcf_08aa50
	sta.w al_stratptr+2,y
rcf_08aa53
	a16
rcf_08aa55
	lda #$a4bc
rcf_08aa58
	sta.w race_scratch
rcf_08aa5b
	a8
rcf_08aa5d
	jsl retail_makeactor_l
rcf_08aa61
	bcs rcf_08aa67
rcf_08aa63
	jml rcf_08aac5
rcf_08aa67
	lda #$11
rcf_08aa69
	sta.w al_sbyte1,y
rcf_08aa6c
	lda #$f6
rcf_08aa6e
	sta.w al_sbyte2,y
rcf_08aa71
	lda #$ec
rcf_08aa73
	sta.w al_sbyte3,y
rcf_08aa76
	pha
rcf_08aa77
	a16
rcf_08aa79
	txa
rcf_08aa7a
	sta.w al_ptr,y
rcf_08aa7d
	a8
rcf_08aa7f
	pla
rcf_08aa80
	lda #$19
rcf_08aa82
	sta.w al_offroadtime,y
rcf_08aa85
	lda #$ff
rcf_08aa87
	sta.w al_sword1,y
rcf_08aa8a
	lda.w race_animcount
rcf_08aa8d
	and #$02
rcf_08aa8f
	beq rcf_08aa96
rcf_08aa91
	lda #$14
rcf_08aa93
	sta.w al_sword1,y
rcf_08aa96
	lda.w al_sflags2,y
rcf_08aa99
	ora #$02
rcf_08aa9b
	sta.w al_sflags2,y
rcf_08aa9e
	lda.w race_animcount
rcf_08aaa1
	and #$01
rcf_08aaa3
	bne rcf_08aab6
rcf_08aaa5
	a16
rcf_08aaa7
	lda #retail_separatepiece_l&WM
rcf_08aaaa
	sta.w al_stratptr,y
rcf_08aaad
	a8
rcf_08aaaf
	lda #mrcarfx_begin>>16
rcf_08aab1
	sta.w al_stratptr+2,y
rcf_08aab4
	bra rcf_08aac5
rcf_08aab6
	a16
rcf_08aab8
	lda #retail_launchpiece_init&WM
rcf_08aabb
	sta.w al_stratptr,y
rcf_08aabe
	a8
rcf_08aac0
	lda #mrcarfx_begin>>16
rcf_08aac2
	sta.w al_stratptr+2,y
rcf_08aac5
	a16
rcf_08aac7
	lda #$a4d8
rcf_08aaca
	sta.w race_scratch
rcf_08aacd
	a8
rcf_08aacf
	jsl retail_makeactor_l
rcf_08aad3
	bcs rcf_08aad9
rcf_08aad5
	jml rcf_08ab2f
rcf_08aad9
	lda #$00
rcf_08aadb
	sta.w al_sbyte1,y
rcf_08aade
	lda #$f8
rcf_08aae0
	sta.w al_sbyte2,y
rcf_08aae3
	lda #$c9
rcf_08aae5
	sta.w al_sbyte3,y
rcf_08aae8
	pha
rcf_08aae9
	a16
rcf_08aaeb
	txa
rcf_08aaec
	sta.w al_ptr,y
rcf_08aaef
	a8
rcf_08aaf1
	pla
rcf_08aaf2
	lda #$1e
rcf_08aaf4
	sta.w al_offroadtime,y
rcf_08aaf7
	lda #$ff
rcf_08aaf9
	sta.w al_sword1,y
rcf_08aafc
	lda.w race_animcount
rcf_08aaff
	and #$02
rcf_08ab01
	beq rcf_08ab08
rcf_08ab03
	lda #$14
rcf_08ab05
	sta.w al_sword1,y
rcf_08ab08
	lda.w race_animcount
rcf_08ab0b
	and #$01
rcf_08ab0d
	bne rcf_08ab20
rcf_08ab0f
	a16
rcf_08ab11
	lda #retail_separatepiece_l&WM
rcf_08ab14
	sta.w al_stratptr,y
rcf_08ab17
	a8
rcf_08ab19
	lda #mrcarfx_begin>>16
rcf_08ab1b
	sta.w al_stratptr+2,y
rcf_08ab1e
	bra rcf_08ab2f
rcf_08ab20
	a16
rcf_08ab22
	lda #retail_launchpiece_init&WM
rcf_08ab25
	sta.w al_stratptr,y
rcf_08ab28
	a8
rcf_08ab2a
	lda #mrcarfx_begin>>16
rcf_08ab2c
	sta.w al_stratptr+2,y
rcf_08ab2f
	lda.w race_animcount
rcf_08ab32
	and #$01
rcf_08ab34
	beq rcf_08ab3e
rcf_08ab36
	lda #$5b
rcf_08ab38
	jsl queue_raceplayer_l
rcf_08ab3c
	bra rcf_08ab44
rcf_08ab3e
	lda #$43
rcf_08ab40
	jsl queue_raceplayer_l
rcf_08ab44
	clc
rcf_08ab45
	rtl
rcf_callpiece
	phx
rcf_08ab47
	phy
rcf_08ab48
	lda.w race_animcount
rcf_08ab4b
	pha
rcf_08ab4c
	tyx
rcf_08ab4d
	phy
rcf_08ab4e
	phx
rcf_08ab4f
	lda #mrcarfx_begin>>16
rcf_08ab51
	pha
rcf_08ab52
	a16
rcf_08ab54
	lda #rcf_08ab67&WM
rcf_08ab57
	pha
rcf_08ab58
	a8
rcf_08ab5a
	lda.w al_stratptr+2,x
rcf_08ab5d
	pha
rcf_08ab5e
	a16
rcf_08ab60
	lda.w al_stratptr,x
rcf_08ab63
	dec a
rcf_08ab64
	pha
rcf_08ab65
	a8
rcf_08ab67
	rtl
rcf_08ab68
	plx
rcf_08ab69
	ply
rcf_08ab6a
	pla
rcf_08ab6b
	sta.w race_animcount
rcf_08ab6e
	ply
rcf_08ab6f
	plx
rcf_08ab70
	rts
rcf_pieceoffset
	lda.w al_sbyte1,x
rcf_08ab74
	sta.w race_animcount
rcf_08ab77
	lda.w al_sbyte2,x
rcf_08ab7a
	sta.w race_animcount+1
rcf_08ab7d
	lda.w al_sbyte3,x
rcf_08ab80
	sta.w race_visualangle
rcf_08ab83
	lda.w race_animcount
rcf_08ab86
	sta x1
rcf_08ab88
	sta x2
rcf_08ab8a
	bit #$80
rcf_08ab8c
	beq rcf_08ab94
rcf_08ab8e
	lda #$ff
rcf_08ab90
	sta x2+1
rcf_08ab92
	bra rcf_08ab96
rcf_08ab94
	stz x2+1
rcf_08ab96
	lda.w race_animcount+1
rcf_08ab99
	sta y1
rcf_08ab9b
	sta y2
rcf_08ab9d
	bit #$80
rcf_08ab9f
	beq rcf_08aba7
rcf_08aba1
	lda #$ff
rcf_08aba3
	sta y2+1
rcf_08aba5
	bra rcf_08aba9
rcf_08aba7
	stz y2+1
rcf_08aba9
	lda.w race_visualangle
rcf_08abac
	sta z1
rcf_08abae
	sta.w z2
rcf_08abb1
	bit #$80
rcf_08abb3
	beq rcf_08abbc
rcf_08abb5
	lda #$ff
rcf_08abb7
	sta.w z2+1
rcf_08abba
	bra rcf_08abbf
rcf_08abbc
	stz.w z2+1
rcf_08abbf
	lda.w al_rotz,y
rcf_08abc2
	jsl retail_actorrotz_l
rcf_08abc6
	lda x2
rcf_08abc8
	sta x1
rcf_08abca
	lda y2
rcf_08abcc
	sta y1
rcf_08abce
	lda.w z2
rcf_08abd1
	sta z1
rcf_08abd3
	lda.w al_rotx,y
rcf_08abd6
	jsl retail_actorrotx_l
rcf_08abda
	lda x2
rcf_08abdc
	sta x1
rcf_08abde
	lda y2
rcf_08abe0
	sta y1
rcf_08abe2
	lda.w z2
rcf_08abe5
	sta z1
rcf_08abe7
	lda.w al_roty,y
rcf_08abea
	jsl retail_actorroty_l
rcf_08abee
	a16
rcf_08abf0
	lda x2
rcf_08abf2
	asl a
rcf_08abf3
	sta x2
rcf_08abf5
	lda y2
rcf_08abf7
	asl a
rcf_08abf8
	sta y2
rcf_08abfa
	lda.w z2
rcf_08abfd
	asl a
rcf_08abfe
	sta.w z2
rcf_08ac01
	a8
rcf_08ac03
	rts
retail_separatepiece_l
	ldy.w al_ptr,x
rcf_08ac07
	lda.w al_sflags2,y
rcf_08ac0a
	ora #$80
rcf_08ac0c
	sta.w al_sflags2,y
rcf_08ac0f
	lda.w al_sbyte2,y
rcf_08ac12
	jsr rcf_carview
rcf_08ac15
	stz.w al_offroadtime,x
rcf_08ac18
	a16
rcf_08ac1a
	lda #retail_separatepiece_step&WM
rcf_08ac1d
	sta.w al_stratptr,x
rcf_08ac20
	a8
rcf_08ac22
	lda #mrcarfx_begin>>16
rcf_08ac24
	sta.w al_stratptr+2,x
retail_separatepiece_step
	ldy.w al_ptr,x
rcf_08ac2a
	lda.w al_offroadtime,x
rcf_08ac2d
	cmp #$08
rcf_08ac2f
	bne rcf_08ac35
rcf_08ac31
	jml retail_endactor_l
rcf_08ac35
	lda.w al_offroadtime,x
rcf_08ac38
	cmp #$07
rcf_08ac3a
	beq rcf_08ac40
rcf_08ac3c
	jml rcf_08ac48
rcf_08ac40
	lda.w al_sflags2,y
rcf_08ac43
	and #$7f
rcf_08ac45
	sta.w al_sflags2,y
rcf_08ac48
	inc.w al_offroadtime,x
rcf_08ac4b
	jsr rcf_pieceoffset
rcf_08ac4e
	jsl retail_followactor_l
rcf_08ac52
	jsl retail_followactorangles_l
rcf_08ac56
	lda.w al_offroadtime,x
rcf_08ac59
	cmp #$04
rcf_08ac5b
	bmi rcf_08ac65
rcf_08ac5d
	sec
rcf_08ac5e
	sbc #$09
rcf_08ac60
	beq rcf_08ac92
rcf_08ac62
	eor #$ff
rcf_08ac64
	inc a
rcf_08ac65
	pha
rcf_08ac66
	a16
rcf_08ac68
	lda.w al_worldx,x
rcf_08ac6b
	clc
rcf_08ac6c
	adc x2
rcf_08ac6e
	sta.w al_worldx,x
rcf_08ac71
	a8
rcf_08ac73
	a16
rcf_08ac75
	lda.w al_worldy,x
rcf_08ac78
	clc
rcf_08ac79
	adc y2
rcf_08ac7b
	sta.w al_worldy,x
rcf_08ac7e
	a8
rcf_08ac80
	a16
rcf_08ac82
	lda.w al_worldz,x
rcf_08ac85
	clc
rcf_08ac86
	adc.w z2
rcf_08ac89
	sta.w al_worldz,x
rcf_08ac8c
	a8
rcf_08ac8e
	pla
rcf_08ac8f
	dec a
rcf_08ac90
	bne rcf_08ac65
rcf_08ac92
	jsl retail_updateactorcell_l
rcf_08ac96
	rtl
retail_launchpiece_l
	phx
rcf_08ac98
	phy
rcf_08ac99
	lda #mretail_coalescetask>>16
rcf_08ac9b
	ldx #mretail_coalescetask&WM
rcf_08ac9e
	jsl retail_rawtask_l
rcf_08aca2
	ply
rcf_08aca3
	plx
rcf_08aca4
	lda.w al_sflags2,x
rcf_08aca7
	ora #$01
rcf_08aca9
	sta.w al_sflags2,x
rcf_08acac
	ldy.w al_ptr,x
rcf_08acaf
	lda.w al_sflags2,y
rcf_08acb2
	ora #$04
rcf_08acb4
	sta.w al_sflags2,y
rcf_08acb7
	bra retail_launchpiece_init
retail_launchpiece_init
	ldy.w al_ptr,x
rcf_08acbc
	lda.w al_sbyte2,y
rcf_08acbf
	jsr rcf_carview
rcf_08acc2
	jsr rcf_pieceoffset
rcf_08acc5
	jsl retail_followactor_l
rcf_08acc9
	jsl retail_followactorangles_l
rcf_08accd
	a16
rcf_08accf
	lda.w al_worldx,x
rcf_08acd2
	clc
rcf_08acd3
	adc x2
rcf_08acd5
	sta.w al_worldx,x
rcf_08acd8
	a8
rcf_08acda
	a16
rcf_08acdc
	lda.w al_worldy,x
rcf_08acdf
	clc
rcf_08ace0
	adc y2
rcf_08ace2
	sta.w al_worldy,x
rcf_08ace5
	a8
rcf_08ace7
	a16
rcf_08ace9
	lda.w al_worldz,x
rcf_08acec
	clc
rcf_08aced
	adc.w z2
rcf_08acf0
	sta.w al_worldz,x
rcf_08acf3
	a8
rcf_08acf5
	jsl retail_copyrawvelocity_l
rcf_08acf9
	jsl retail_makedragsolid_l
rcf_08acfd
	bpl rcf_08ad22
rcf_08acff
	lda.w al_sflags2,x
rcf_08ad02
	and #$01
rcf_08ad04
	bne rcf_08ad0a
rcf_08ad06
	jml rcf_08ad1d
rcf_08ad0a
	ldy.w al_ptr,x
rcf_08ad0d
	lda.w al_sflags2,y
rcf_08ad10
	and #$fb
rcf_08ad12
	sta.w al_sflags2,y
rcf_08ad15
	lda.w al_sflags2,y
rcf_08ad18
	and #$ef
rcf_08ad1a
	sta.w al_sflags2,y
rcf_08ad1d
	jsl retail_retireactor_l
rcf_08ad21
	rtl
	shorta
	longi
rcf_08ad22
	lda.w al_sword1,x
rcf_08ad25
	bmi rcf_08ad3c
rcf_08ad27
	phx
rcf_08ad28
	a16
rcf_08ad2a
	lda.w al_collobjptr,x
rcf_08ad2d
	tax
rcf_08ad2e
	lda.l $700016,x
rcf_08ad32
	ora #$0080
rcf_08ad35
	sta.l $700016,x
rcf_08ad39
	plx
rcf_08ad3a
	a8
rcf_08ad3c
	a16
rcf_08ad3e
	lda x2
rcf_08ad40
	clc
rcf_08ad41
	adc.w al_vx,x
rcf_08ad44
	sta.w al_vx,x
rcf_08ad47
	lda y2
rcf_08ad49
	asl a
rcf_08ad4a
	clc
rcf_08ad4b
	adc.w al_vy,x
rcf_08ad4e
	sta.w al_vy,x
rcf_08ad51
	lda.w z2
rcf_08ad54
	clc
rcf_08ad55
	adc.w al_vz,x
rcf_08ad58
	sta.w al_vz,x
rcf_08ad5b
	a8
rcf_08ad5d
	jsl retail_actorvelocity_l
rcf_08ad61
	a16
rcf_08ad63
	lda #retail_launchedpiece_step&WM
rcf_08ad66
	sta.w al_stratptr,x
rcf_08ad69
	a8
rcf_08ad6b
	lda #mrcarfx_begin>>16
rcf_08ad6d
	sta.w al_stratptr+2,x
retail_launchedpiece_step
	lda #$03
rcf_08ad72
	sta.w al_sbyte4,x
rcf_08ad75
	jsl retail_publishbody_l
rcf_08ad79
	and #$01
rcf_08ad7b
	bne rcf_08ad96
rcf_08ad7d
	ldy.w al_ptr,x
rcf_08ad80
	lda.w al_sflags2,y
rcf_08ad83
	and #$10
rcf_08ad85
	bne rcf_08ad8b
rcf_08ad87
	jml rcf_08ad96
rcf_08ad8b
	jsl retail_objectcontacts_l
rcf_08ad8f
	and #$80
rcf_08ad91
	beq rcf_08ad96
rcf_08ad93
	jmp retail_wheelburst_l
rcf_08ad96
	lda #$03
rcf_08ad98
	sta.w al_sbyte4,x
rcf_08ad9b
	ldy.w al_ptr,x
rcf_08ad9e
	lda.w al_sflags2,y
rcf_08ada1
	and #$10
rcf_08ada3
	bne rcf_08ada9
rcf_08ada5
	jml rcf_08adb2
rcf_08ada9
	lda.w al_offroadtime,x
rcf_08adac
	bne rcf_08adb2
rcf_08adae
	jml rcf_08add0
rcf_08adb2
	lda.w al_offroadtime,x
rcf_08adb5
	bne rcf_08adbb
rcf_08adb7
	jml rcf_08ade2
rcf_08adbb
	dec.w al_offroadtime,x
rcf_08adbe
	lda.w al_rotx,x
rcf_08adc1
	clc
rcf_08adc2
	adc #$08
rcf_08adc4
	sta.w al_rotx,x
rcf_08adc7
	lda.w al_roty,x
rcf_08adca
	clc
rcf_08adcb
	adc #$04
rcf_08adcd
	sta.w al_roty,x
rcf_08add0
	lda.w al_sword1,x
rcf_08add3
	bmi rcf_08adde
rcf_08add5
	dec a
rcf_08add6
	bne rcf_08addb
rcf_08add8
	brl retail_endactor_l
rcf_08addb
	sta.w al_sword1,x
rcf_08adde
	jsr rsc_emitdust
rcf_08ade1
	rtl
rcf_08ade2
	a16
rcf_08ade4
	lda #retail_returnpiece_step&WM
rcf_08ade7
	sta.w al_stratptr,x
rcf_08adea
	a8
rcf_08adec
	lda #mrcarfx_begin>>16
rcf_08adee
	sta.w al_stratptr+2,x
rcf_08adf1
	lda #$0a
rcf_08adf3
	sta.w al_offroadtime,x
rcf_08adf6
	lda.w al_sflags2,x
rcf_08adf9
	and #$02
rcf_08adfb
	beq rcf_08ae01
rcf_08adfd
	jml rcf_08ae09
rcf_08ae01
	lda #$4b
rcf_08ae03
	jsl queue_raceplayer_l
rcf_08ae07
	bra retail_returnpiece_step
rcf_08ae09
	lda #$4c
rcf_08ae0b
	jsl queue_raceplayer_l
retail_returnpiece_step
	lda #$03
rcf_08ae11
	sta.w al_sbyte4,x
rcf_08ae14
	ldy.w al_ptr,x
rcf_08ae17
	jsl retail_copyrawvelocity_l
rcf_08ae1b
	jsr rcf_pieceoffset
rcf_08ae1e
	a16
rcf_08ae20
	lda.w al_worldx,y
rcf_08ae23
	clc
rcf_08ae24
	adc x2
rcf_08ae26
	sta x2
rcf_08ae28
	lda.w al_worldy,y
rcf_08ae2b
	clc
rcf_08ae2c
	adc y2
rcf_08ae2e
	sta y2
rcf_08ae30
	lda.w al_worldz,y
rcf_08ae33
	clc
rcf_08ae34
	adc.w z2
rcf_08ae37
	sta.w z2
rcf_08ae3a
	a8
rcf_08ae3c
	a16
rcf_08ae3e
	lda.w al_worldx,x
rcf_08ae41
	sta tpx
rcf_08ae43
	lda x2
rcf_08ae45
	jsl retail_easeactor_l
rcf_08ae49
	sta.w al_worldx,x
rcf_08ae4c
	a8
rcf_08ae4e
	a16
rcf_08ae50
	lda.w al_worldy,x
rcf_08ae53
	sta tpx
rcf_08ae55
	lda y2
rcf_08ae57
	jsl retail_easeactor_l
rcf_08ae5b
	sta.w al_worldy,x
rcf_08ae5e
	a8
rcf_08ae60
	a16
rcf_08ae62
	lda.w al_worldz,x
rcf_08ae65
	sta tpx
rcf_08ae67
	lda.w z2
rcf_08ae6a
	jsl retail_easeactor_l
rcf_08ae6e
	sta.w al_worldz,x
rcf_08ae71
	a8
rcf_08ae73
	lda.w al_rotx,x
rcf_08ae76
	sta tpx
rcf_08ae78
	lda.w al_rotx,y
rcf_08ae7b
	jsl retail_easeangle4_l
rcf_08ae7f
	sta.w al_rotx,x
rcf_08ae82
	lda.w al_roty,x
rcf_08ae85
	sta tpx
rcf_08ae87
	lda.w al_roty,y
rcf_08ae8a
	jsl retail_easeangle4_l
rcf_08ae8e
	sta.w al_roty,x
rcf_08ae91
	lda.w al_rotz,x
rcf_08ae94
	sta tpx
rcf_08ae96
	lda.w al_rotz,y
rcf_08ae99
	jsl retail_easeangle4_l
rcf_08ae9d
	sta.w al_rotz,x
rcf_08aea0
	jsl retail_moveactor_l
rcf_08aea4
	lda.w al_offroadtime,x
rcf_08aea7
	cmp #$01
rcf_08aea9
	beq rcf_08aeaf
rcf_08aeab
	jml rcf_08aec8
rcf_08aeaf
	lda.w al_sflags2,x
rcf_08aeb2
	and #$02
rcf_08aeb4
	beq rcf_08aeba
rcf_08aeb6
	jml rcf_08aec2
rcf_08aeba
	lda #$4e
rcf_08aebc
	jsl queue_raceplayer_l
rcf_08aec0
	bra rcf_08aec8
rcf_08aec2
	lda #$4d
rcf_08aec4
	jsl queue_raceplayer_l
rcf_08aec8
	jsl retail_updateactorcell_l
rcf_08aecc
	lda #$03
rcf_08aece
	sta.w al_sbyte4,x
rcf_08aed1
	lda.w al_offroadtime,x
rcf_08aed4
	bne rcf_08aeda
rcf_08aed6
	jml rcf_08aede
rcf_08aeda
	dec.w al_offroadtime,x
rcf_08aedd
	rtl
rcf_08aede
	ldy.w al_ptr,x
rcf_08aee1
	lda.w al_sflags2,y
rcf_08aee4
	and #$04
rcf_08aee6
	beq rcf_08aeec
rcf_08aee8
	jml rcf_08aefb
rcf_08aeec
	a16
rcf_08aeee
	lda #retail_endactor_l&WM
rcf_08aef1
	sta.w al_stratptr,x
rcf_08aef4
	a8
rcf_08aef6
	lda #mrcarfx_begin>>16
rcf_08aef8
	sta.w al_stratptr+2,x
rcf_08aefb
	lda.w al_sflags2,x
rcf_08aefe
	and #$01
rcf_08af00
	bne rcf_08af06
rcf_08af02
	jml rcf_08af0e
rcf_08af06
	lda.w al_sflags2,y
rcf_08af09
	and #$fb
rcf_08af0b
	sta.w al_sflags2,y
rcf_08af0e
	rtl
	shorta
	longi
; US $08:B48A.
retail_carview_l
	jsr rcf_carview
rcf_08b48d
	rtl
rcf_carview
	cmp #$01
rcf_08b490
	beq rcf_08b4a5
rcf_08b492
	cmp #$02
rcf_08b494
	beq rcf_08b4b0
rcf_08b496
	cmp #$03
rcf_08b498
	beq rcf_08b4bb
rcf_08b49a
	a16
rcf_08b49c
	lda #$8f91
rcf_08b49f
	sta.w al_coltab,x
rcf_08b4a2
	a8
rcf_08b4a4
	rts
	shorta
	longi
rcf_08b4a5
	a16
rcf_08b4a7
	lda #$9163
rcf_08b4aa
	sta.w al_coltab,x
rcf_08b4ad
	a8
rcf_08b4af
	rts
	shorta
	longi
rcf_08b4b0
	a16
rcf_08b4b2
	lda #$9335
rcf_08b4b5
	sta.w al_coltab,x
rcf_08b4b8
	a8
rcf_08b4ba
	rts
	shorta
	longi
rcf_08b4bb
	a16
rcf_08b4bd
	lda #$9507
rcf_08b4c0
	sta.w al_coltab,x
rcf_08b4c3
	a8
rcf_08b4c5
	rts
	shorta
	longi
; US $08:C124.
retail_carfeedback_l
	stx.w race_objowner
rcf_08c127
	a16
rcf_08c129
	phx
rcf_08c12a
	txy
rcf_08c12b
	lda.w al_collobjptr,x
rcf_08c12e
	tax
rcf_08c12f
	lda.w al_sflags2,y
rcf_08c132
	and #$0010
rcf_08c135
	beq rcf_08c13b
rcf_08c137
	jml rcf_08c554
rcf_08c13b
	lda.l $700040,x
rcf_08c13f
	and #$0100
rcf_08c142
	beq rcf_08c147
rcf_08c144
	brl rcf_08c213
rcf_08c147
	lda.w race_feedbackmode
rcf_08c14a
	and #$0020
rcf_08c14d
	bne rcf_08c152
rcf_08c14f
	brl rcf_08c1a6
rcf_08c152
	stz.w race_callback
rcf_08c155
	phx
rcf_08c156
	lda.l $70003e,x
rcf_08c15a
	tax
rcf_08c15b
	lda.l m_y1,x
rcf_08c15f
	bit #$0080
rcf_08c162
	beq rcf_08c178
rcf_08c164
	lda.l $700046,x
rcf_08c168
	bit #$0001
rcf_08c16b
	beq rcf_08c178
rcf_08c16d
	bit #$0010
rcf_08c170
	beq rcf_08c178
rcf_08c172
	lda #$0001
rcf_08c175
	sta.w race_callback
rcf_08c178
	lda.l $700034,x
rcf_08c17c
	bne rcf_08c15a
rcf_08c17e
	plx
rcf_08c17f
	lda.w race_callback
rcf_08c182
	bne rcf_08c187
rcf_08c184
	brl rcf_08c213
rcf_08c187
	lda.w racesound_playmode
rcf_08c18a
	and #$00ff
rcf_08c18d
	bne rcf_08c196
rcf_08c18f
	lda #$0010
rcf_08c192
	sta.l m_retailimpactflash
rcf_08c196
	lda.l $70004a,x
rcf_08c19a
	bpl rcf_08c1a0
rcf_08c19c
	eor #$ffff
rcf_08c19f
	inc a
rcf_08c1a0
	jsr rcf_skidsound
rcf_08c1a3
	jmp rcf_08c213
	longa
	longi
rcf_08c1a6
	lda.l $700092,x
rcf_08c1aa
	bit #$0020
rcf_08c1ad
	beq rcf_08c1e2
rcf_08c1af
	lda.w racesound_player
rcf_08c1b2
	and #$00ff
rcf_08c1b5
	beq rcf_08c1bc
rcf_08c1b7
	lda.w race_carstate1
rcf_08c1ba
	bra rcf_08c1bf
rcf_08c1bc
	lda.w race_carstate0
rcf_08c1bf
	bit #$0004
rcf_08c1c2
	bne rcf_08c1e0
rcf_08c1c4
	pha
rcf_08c1c5
	jsl racesound_cmd12_l
rcf_08c1c9
	pla
rcf_08c1ca
	ora #$0004
rcf_08c1cd
	pha
rcf_08c1ce
	lda.w racesound_player
rcf_08c1d1
	and #$00ff
rcf_08c1d4
	beq rcf_08c1dc
rcf_08c1d6
	pla
rcf_08c1d7
	sta.w race_carstate1
rcf_08c1da
	bra rcf_08c1e0
rcf_08c1dc
	pla
rcf_08c1dd
	sta.w race_carstate0
rcf_08c1e0
	bra rcf_08c213
rcf_08c1e2
	lda.w racesound_player
rcf_08c1e5
	and #$00ff
rcf_08c1e8
	beq rcf_08c1ef
rcf_08c1ea
	lda.w race_carstate1
rcf_08c1ed
	bra rcf_08c1f2
rcf_08c1ef
	lda.w race_carstate0
rcf_08c1f2
	bit #$0004
rcf_08c1f5
	beq rcf_08c213
rcf_08c1f7
	pha
rcf_08c1f8
	jsl racesound_cmd0c_l
rcf_08c1fc
	pla
rcf_08c1fd
	and #$fffb
rcf_08c200
	pha
rcf_08c201
	lda.w racesound_player
rcf_08c204
	and #$00ff
rcf_08c207
	beq rcf_08c20f
rcf_08c209
	pla
rcf_08c20a
	sta.w race_carstate1
rcf_08c20d
	bra rcf_08c213
rcf_08c20f
	pla
rcf_08c210
	sta.w race_carstate0
rcf_08c213
	lda.l $700042,x
rcf_08c217
	and #$0400
rcf_08c21a
	beq rcf_08c24f
rcf_08c21c
	lda.w racesound_player
rcf_08c21f
	and #$00ff
rcf_08c222
	beq rcf_08c229
rcf_08c224
	lda.w race_carstate1
rcf_08c227
	bra rcf_08c22c
rcf_08c229
	lda.w race_carstate0
rcf_08c22c
	bit #$0001
rcf_08c22f
	bne rcf_08c24d
rcf_08c231
	pha
rcf_08c232
	jsl racesound_cmd23_l
rcf_08c236
	pla
rcf_08c237
	ora #$0001
rcf_08c23a
	pha
rcf_08c23b
	lda.w racesound_player
rcf_08c23e
	and #$00ff
rcf_08c241
	beq rcf_08c249
rcf_08c243
	pla
rcf_08c244
	sta.w race_carstate1
rcf_08c247
	bra rcf_08c24d
rcf_08c249
	pla
rcf_08c24a
	sta.w race_carstate0
rcf_08c24d
	bra rcf_08c280
rcf_08c24f
	lda.w racesound_player
rcf_08c252
	and #$00ff
rcf_08c255
	beq rcf_08c25c
rcf_08c257
	lda.w race_carstate1
rcf_08c25a
	bra rcf_08c25f
rcf_08c25c
	lda.w race_carstate0
rcf_08c25f
	bit #$0001
rcf_08c262
	beq rcf_08c280
rcf_08c264
	pha
rcf_08c265
	jsl racesound_cmd24_l
rcf_08c269
	pla
rcf_08c26a
	and #$fffe
rcf_08c26d
	pha
rcf_08c26e
	lda.w racesound_player
rcf_08c271
	and #$00ff
rcf_08c274
	beq rcf_08c27c
rcf_08c276
	pla
rcf_08c277
	sta.w race_carstate1
rcf_08c27a
	bra rcf_08c280
rcf_08c27c
	pla
rcf_08c27d
	sta.w race_carstate0
rcf_08c280
	lda.l $700042,x
rcf_08c284
	and #$0080
rcf_08c287
	beq rcf_08c289
rcf_08c289
	lda.l $700042,x
rcf_08c28d
	bit #$2000
rcf_08c290
	beq rcf_08c2d3
rcf_08c292
	lda.l $700040,x
rcf_08c296
	bit #$0800
rcf_08c299
	beq rcf_08c2d3
rcf_08c29b
	bit #$0100
rcf_08c29e
	bne rcf_08c2d3
rcf_08c2a0
	lda.w racesound_player
rcf_08c2a3
	and #$00ff
rcf_08c2a6
	beq rcf_08c2ad
rcf_08c2a8
	lda.w race_carstate1
rcf_08c2ab
	bra rcf_08c2b0
rcf_08c2ad
	lda.w race_carstate0
rcf_08c2b0
	bit #$0002
rcf_08c2b3
	bne rcf_08c2d1
rcf_08c2b5
	pha
rcf_08c2b6
	jsl racesound_cmd0d_l
rcf_08c2ba
	pla
rcf_08c2bb
	ora #$0002
rcf_08c2be
	pha
rcf_08c2bf
	lda.w racesound_player
rcf_08c2c2
	and #$00ff
rcf_08c2c5
	beq rcf_08c2cd
rcf_08c2c7
	pla
rcf_08c2c8
	sta.w race_carstate1
rcf_08c2cb
	bra rcf_08c2d1
rcf_08c2cd
	pla
rcf_08c2ce
	sta.w race_carstate0
rcf_08c2d1
	bra rcf_08c304
rcf_08c2d3
	lda.w racesound_player
rcf_08c2d6
	and #$00ff
rcf_08c2d9
	beq rcf_08c2e0
rcf_08c2db
	lda.w race_carstate1
rcf_08c2de
	bra rcf_08c2e3
rcf_08c2e0
	lda.w race_carstate0
rcf_08c2e3
	bit #$0002
rcf_08c2e6
	beq rcf_08c304
rcf_08c2e8
	pha
rcf_08c2e9
	jsl racesound_cmd0b_l
rcf_08c2ed
	pla
rcf_08c2ee
	and #$fffd
rcf_08c2f1
	pha
rcf_08c2f2
	lda.w racesound_player
rcf_08c2f5
	and #$00ff
rcf_08c2f8
	beq rcf_08c300
rcf_08c2fa
	pla
rcf_08c2fb
	sta.w race_carstate1
rcf_08c2fe
	bra rcf_08c304
rcf_08c300
	pla
rcf_08c301
	sta.w race_carstate0
rcf_08c304
	a8
rcf_08c306
	lda.l $700057,x
rcf_08c30a
	sta.w race_impactcode
rcf_08c30d
	pha
rcf_08c30e
	cmp #$00
rcf_08c310
	bmi rcf_08c344
rcf_08c312
	cmp #$01
rcf_08c314
	bpl rcf_08c31c
rcf_08c316
	jsl racesound_effectend_l
rcf_08c31a
	bra rcf_08c344
rcf_08c31c
	cmp #$02
rcf_08c31e
	bpl rcf_08c326
rcf_08c320
	jsl racesound_effect1_l
rcf_08c324
	bra rcf_08c344
rcf_08c326
	cmp #$04
rcf_08c328
	bpl rcf_08c330
rcf_08c32a
	jsl racesound_effect2_l
rcf_08c32e
	bra rcf_08c344
rcf_08c330
	cmp #$05
rcf_08c332
	bpl rcf_08c33a
rcf_08c334
	jsl racesound_effect3_l
rcf_08c338
	bra rcf_08c344
rcf_08c33a
	cmp #$64
rcf_08c33c
	bpl rcf_08c344
rcf_08c33e
	jsl racesound_effect4_l
rcf_08c342
	bra rcf_08c344
rcf_08c344
	pla
rcf_08c345
	a16
rcf_08c347
	lda.l $700094,x
rcf_08c34b
	beq rcf_08c3a3
rcf_08c34d
	bmi rcf_08c3a3
rcf_08c34f
	pha
rcf_08c350
	pha
rcf_08c351
	cmp #$0032
rcf_08c354
	bmi rcf_08c38e
rcf_08c356
	cmp #$01f4
rcf_08c359
	bpl rcf_08c364
rcf_08c35b
	lda #$0054
rcf_08c35e
	jsl queue_raceplayer_l
rcf_08c362
	bra rcf_08c38e
rcf_08c364
	cmp #$0320
rcf_08c367
	bpl rcf_08c372
rcf_08c369
	lda #$0055
rcf_08c36c
	jsl queue_raceplayer_l
rcf_08c370
	bra rcf_08c38e
rcf_08c372
	cmp #$044c
rcf_08c375
	bpl rcf_08c380
rcf_08c377
	lda #$0056
rcf_08c37a
	jsl queue_raceplayer_l
rcf_08c37e
	bra rcf_08c38e
rcf_08c380
	cmp #$07d0
rcf_08c383
	bpl rcf_08c38e
rcf_08c385
	lda #$0057
rcf_08c388
	jsl queue_raceplayer_l
rcf_08c38c
	bra rcf_08c38e
rcf_08c38e
	pla
rcf_08c38f
	pla
rcf_08c390
	cmp #$0032
rcf_08c393
	bmi rcf_08c3a3
rcf_08c395
	nop
rcf_08c396
	phx
rcf_08c397
	a8
rcf_08c399
	ldx.w race_objowner
rcf_08c39c
	jsl retail_makecollisionsparks_l
rcf_08c3a0
	a16
rcf_08c3a2
	plx
rcf_08c3a3
	lda.l m_y1,x
rcf_08c3a7
	bit #$0100
rcf_08c3aa
	beq rcf_08c3b5
rcf_08c3ac
	lda #$000a
rcf_08c3af
	jsl queue_raceplayer_l
rcf_08c3b3
	bra rcf_08c3c1
rcf_08c3b5
	bit #$0200
rcf_08c3b8
	beq rcf_08c3c1
rcf_08c3ba
	lda #$000d
rcf_08c3bd
	jsl queue_raceplayer_l
rcf_08c3c1
	lda.l $700062,x
rcf_08c3c5
	bpl rcf_08c42e
rcf_08c3c7
	eor #$ffff
rcf_08c3ca
	inc a
rcf_08c3cb
	pha
rcf_08c3cc
	cmp #$0041
rcf_08c3cf
	bmi rcf_08c409
rcf_08c3d1
	cmp #$0050
rcf_08c3d4
	bpl rcf_08c3df
rcf_08c3d6
	lda #$0016
rcf_08c3d9
	jsl queue_raceplayer_l
rcf_08c3dd
	bra rcf_08c409
rcf_08c3df
	cmp #$005a
rcf_08c3e2
	bpl rcf_08c3ed
rcf_08c3e4
	lda #$0017
rcf_08c3e7
	jsl queue_raceplayer_l
rcf_08c3eb
	bra rcf_08c409
rcf_08c3ed
	cmp #$006e
rcf_08c3f0
	bpl rcf_08c3fb
rcf_08c3f2
	lda #$0018
rcf_08c3f5
	jsl queue_raceplayer_l
rcf_08c3f9
	bra rcf_08c409
rcf_08c3fb
	cmp #$03e8
rcf_08c3fe
	bpl rcf_08c409
rcf_08c400
	lda #$0019
rcf_08c403
	jsl queue_raceplayer_l
rcf_08c407
	bra rcf_08c409
rcf_08c409
	pla
rcf_08c40a
	cmp #$0046
rcf_08c40d
	bmi rcf_08c42e
rcf_08c40f
	phx
rcf_08c410
	phy
rcf_08c411
	tyx
rcf_08c412
	a8
rcf_08c414
	lda.w al_sflags2,x
rcf_08c417
	ora #$20
rcf_08c419
	sta.w al_sflags2,x
rcf_08c41c
	lda #$0a
rcf_08c41e
	sta.w race_animcount+1
rcf_08c421
	lda #$00
rcf_08c423
	sta.w race_visualangle
rcf_08c426
	jsl retail_makecollisionmarker_l
rcf_08c42a
	a16
rcf_08c42c
	ply
rcf_08c42d
	plx
rcf_08c42e
	lda.l $700040,x
rcf_08c432
	and #$0001
rcf_08c435
	beq rcf_08c45b
rcf_08c437
	a8
rcf_08c439
	phx
rcf_08c43a
	ldx.w race_objowner
rcf_08c43d
	lda #$01
rcf_08c43f
	jsl retail_breakcar_l
rcf_08c443
	bcs rcf_08c456
rcf_08c445
	lda.w al_sflags2,x
rcf_08c448
	ora #$10
rcf_08c44a
	sta.w al_sflags2,x
rcf_08c44d
	lda.w racesound_playmode
rcf_08c450
	bne rcf_08c456
rcf_08c452
	jsl retail_makecardebris_l
rcf_08c456
	a16
rcf_08c458
	plx
rcf_08c459
	bra rcf_08c4a2
rcf_08c45b
	lda.l $700040,x
rcf_08c45f
	and #$0040
rcf_08c462
	beq rcf_08c481
rcf_08c464
	phx
rcf_08c465
	a8
rcf_08c467
	ldx.w race_objowner
rcf_08c46a
	lda.w al_sflags2,x
rcf_08c46d
	ora #$20
rcf_08c46f
	sta.w al_sflags2,x
rcf_08c472
	jsl retail_makecollisionsparks_l
rcf_08c476
	lda #$00
rcf_08c478
	jsl retail_breakcar_l
rcf_08c47c
	a16
rcf_08c47e
	plx
rcf_08c47f
	bra rcf_08c4a2
rcf_08c481
	lda.l $700040,x
rcf_08c485
	and #$0020
rcf_08c488
	beq rcf_08c4a2
rcf_08c48a
	phx
rcf_08c48b
	a8
rcf_08c48d
	ldx.w race_objowner
rcf_08c490
	lda #$01
rcf_08c492
	jsl retail_breakcar_l
rcf_08c496
	lda.w racesound_playmode
rcf_08c499
	bne rcf_08c49f
rcf_08c49b
	jsl retail_makecardebris_l
rcf_08c49f
	a16
rcf_08c4a1
	plx
rcf_08c4a2
	ldy.w race_objowner
rcf_08c4a5
	lda.w al_sflags,y
rcf_08c4a8
	and #$0040
rcf_08c4ab
	beq rcf_08c4b0
rcf_08c4ad
	brl rcf_08c554
rcf_08c4b0
	lda.l $700040,x
rcf_08c4b4
	and #$0002
rcf_08c4b7
	beq rcf_08c4cb
rcf_08c4b9
	phx
rcf_08c4ba
	a8
rcf_08c4bc
	ldx.w race_objowner
rcf_08c4bf
	jsl retail_makeimpact_l
rcf_08c4c3
	jsr rsc_emittrail
rcf_08c4c6
	a16
rcf_08c4c8
	plx
rcf_08c4c9
	bra rcf_08c4ef
rcf_08c4cb
	lda.l $700042,x
rcf_08c4cf
	and #$0400
rcf_08c4d2
	beq rcf_08c4ef
rcf_08c4d4
	a8
rcf_08c4d6
	jsl retail_random_l
rcf_08c4da
	cmp #$f2
rcf_08c4dc
	bcs rcf_08c4e2
rcf_08c4de
	jml rcf_08c4ef
rcf_08c4e2
	phx
rcf_08c4e3
	a8
rcf_08c4e5
	ldx.w race_objowner
rcf_08c4e8
	jsl retail_makeimpact_l
rcf_08c4ec
	a16
rcf_08c4ee
	plx
	longa
	longi
rcf_08c4ef
	a16
rcf_08c4f1
	lda.l $700082,x
rcf_08c4f5
	cmp #$0199
rcf_08c4f8
	bmi rcf_08c554
rcf_08c4fa
	a8
rcf_08c4fc
	lda.w racesound_player
rcf_08c4ff
	and #$ff
rcf_08c501
	beq rcf_08c508
rcf_08c503
	lda.w race_carstate1
rcf_08c506
	bra rcf_08c50b
rcf_08c508
	lda.w race_carstate0
rcf_08c50b
	bit #$20
rcf_08c50d
	bne rcf_08c533
rcf_08c50f
	pha
rcf_08c510
	pha
rcf_08c511
	lda #$11
rcf_08c513
	sta.l race_debugmark
rcf_08c517
	pla
rcf_08c518
	lda #$3d
rcf_08c51a
	jsl queue_raceplayer_l
rcf_08c51e
	pla
rcf_08c51f
	ora #$20
rcf_08c521
	pha
rcf_08c522
	lda.w racesound_player
rcf_08c525
	and #$ff
rcf_08c527
	beq rcf_08c52f
rcf_08c529
	pla
rcf_08c52a
	sta.w race_carstate1
rcf_08c52d
	bra rcf_08c533
rcf_08c52f
	pla
rcf_08c530
	sta.w race_carstate0
rcf_08c533
	phx
rcf_08c534
	ldx.w race_objowner
rcf_08c537
	lda.w al_sflags2,x
rcf_08c53a
	and #$04
rcf_08c53c
	beq rcf_08c542
rcf_08c53e
	jml rcf_08c551
rcf_08c542
	jsl retail_random_l
rcf_08c546
	cmp #$4c
rcf_08c548
	bcs rcf_08c54e
rcf_08c54a
	jml rcf_08c551
rcf_08c54e
	jsr rsc_emittrail
rcf_08c551
	a16
rcf_08c553
	plx
rcf_08c554
	plx
rcf_08c555
	a8
rcf_08c557
	lda.w al_sflags2,x
rcf_08c55a
	and #$04
rcf_08c55c
	beq rcf_08c562
rcf_08c55e
	jml rcf_08c577
rcf_08c562
	lda.w al_sflags2,x
rcf_08c565
	and #$80
rcf_08c567
	beq rcf_08c56d
rcf_08c569
	jml rcf_08c577
rcf_08c56d
	lda.w al_sflags,x
rcf_08c570
	and #$df
rcf_08c572
	sta.w al_sflags,x
rcf_08c575
	bra rcf_08c57f
rcf_08c577
	lda.w al_sflags,x
rcf_08c57a
	ora #$20
rcf_08c57c
	sta.w al_sflags,x
rcf_08c57f
	ldy.w al_viewpt,x
rcf_08c582
	a16
rcf_08c584
	lda.w al_viewpt,y
rcf_08c587
	tay
rcf_08c588
	lda.w $0000,y
rcf_08c58b
	and #$4000
rcf_08c58e
	a8
rcf_08c590
	beq rcf_08c59c
rcf_08c592
	lda.w al_sflags,x
rcf_08c595
	ora #$40
rcf_08c597
	sta.w al_sflags,x
rcf_08c59a
	bra rcf_08c5a4
rcf_08c59c
	lda.w al_sflags,x
rcf_08c59f
	and #$bf
rcf_08c5a1
	sta.w al_sflags,x
rcf_08c5a4
	rtl
	longa
	longi
; US $08:D580.
rcf_skidsound
	cmp #$0028
rcf_08d583
	bmi rcf_08d5aa
rcf_08d585
	cmp #$00a0
rcf_08d588
	bpl rcf_08d59b
rcf_08d58a
	lda.w race_effectclock
rcf_08d58d
	and #$0003
rcf_08d590
	bne rcf_08d5aa
rcf_08d592
	lda #$0023
rcf_08d595
	jsl queue_racesound0_l
rcf_08d599
	bra rcf_08d5aa
	longa
	longi
rcf_08d59b
	lda.w race_effectclock
rcf_08d59e
	and #$0001
rcf_08d5a1
	bne rcf_08d5aa
rcf_08d5a3
	lda #$0023
rcf_08d5a6
	jsl queue_racesound0_l
rcf_08d5aa
	rts
	shorta
	longi
; US $08:E9F4.
retail_makecollisionsparks_l
	a16
rcf_08e9f6
	lda #$a158
rcf_08e9f9
	sta.w race_scratch
rcf_08e9fc
	a8
rcf_08e9fe
	jsl retail_makeactor_l
rcf_08ea02
	bcs rcf_08ea08
rcf_08ea04
	jml rcf_08ea2f
rcf_08ea08
	a16
rcf_08ea0a
	lda #retail_collisionspark_l&WM
rcf_08ea0d
	sta.w al_stratptr,y
rcf_08ea10
	a8
rcf_08ea12
	lda #mrcarfx_begin>>16
rcf_08ea14
	sta.w al_stratptr+2,y
rcf_08ea17
	pha
rcf_08ea18
	a16
rcf_08ea1a
	txa
rcf_08ea1b
	sta.w al_ptr,y
rcf_08ea1e
	a8
rcf_08ea20
	pla
rcf_08ea21
	jsl retail_copyactorpos_l
rcf_08ea25
	phx
rcf_08ea26
	tyx
rcf_08ea27
	ply
rcf_08ea28
	jsl retail_updateactorcell_l
rcf_08ea2c
	phx
rcf_08ea2d
	tyx
rcf_08ea2e
	ply
rcf_08ea2f
	a16
rcf_08ea31
	lda #$a158
rcf_08ea34
	sta.w race_scratch
rcf_08ea37
	a8
rcf_08ea39
	jsl retail_makeactor_l
rcf_08ea3d
	bcs rcf_08ea43
rcf_08ea3f
	jml rcf_08ea6a
rcf_08ea43
	a16
rcf_08ea45
	lda #retail_collisionspark_l&WM
rcf_08ea48
	sta.w al_stratptr,y
rcf_08ea4b
	a8
rcf_08ea4d
	lda #mrcarfx_begin>>16
rcf_08ea4f
	sta.w al_stratptr+2,y
rcf_08ea52
	pha
rcf_08ea53
	a16
rcf_08ea55
	txa
rcf_08ea56
	sta.w al_ptr,y
rcf_08ea59
	a8
rcf_08ea5b
	pla
rcf_08ea5c
	jsl retail_copyactorpos_l
rcf_08ea60
	phx
rcf_08ea61
	tyx
rcf_08ea62
	ply
rcf_08ea63
	jsl retail_updateactorcell_l
rcf_08ea67
	phx
rcf_08ea68
	tyx
rcf_08ea69
	ply
rcf_08ea6a
	rtl
retail_collisionspark_l
	lda.w al_sflags,x
rcf_08ea6e
	ora #$08
rcf_08ea70
	sta.w al_sflags,x
rcf_08ea73
	a16
rcf_08ea75
	lda #$9998
rcf_08ea78
	sta.w al_coltab,x
rcf_08ea7b
	a8
rcf_08ea7d
	jsl retail_random_l
rcf_08ea81
	and #$03
rcf_08ea83
	sta.w race_animcount
rcf_08ea86
	lda.w race_animcount
rcf_08ea89
	ora #$80
rcf_08ea8b
	sta.w al_sflags3,x
rcf_08ea8e
	a16
rcf_08ea90
	lda #retail_collisionspark_step&WM
rcf_08ea93
	sta.w al_stratptr,x
rcf_08ea96
	a8
rcf_08ea98
	lda #mrcarfx_begin>>16
rcf_08ea9a
	sta.w al_stratptr+2,x
rcf_08ea9d
	lda #$0a
rcf_08ea9f
	sta.w al_eyesize,x
rcf_08eaa2
	lda #$05
rcf_08eaa4
	sta.w al_sbyte1,x
rcf_08eaa7
	jsl retail_random_l
rcf_08eaab
	a16
rcf_08eaad
	and #$007f
rcf_08eab0
	clc
rcf_08eab1
	adc.w al_sword1,x
rcf_08eab4
	sta.w al_sword1,x
rcf_08eab7
	a8
rcf_08eab9
	jsl retail_random_l
rcf_08eabd
	a16
rcf_08eabf
	and #$003f
rcf_08eac2
	clc
rcf_08eac3
	adc.w al_sword2,x
rcf_08eac6
	sta.w al_sword2,x
rcf_08eac9
	a8
rcf_08eacb
	jsl retail_random_l
rcf_08eacf
	a16
rcf_08ead1
	and #$007f
rcf_08ead4
	clc
rcf_08ead5
	adc.w al_weapontype,x
rcf_08ead8
	sta.w al_weapontype,x
rcf_08eadb
	a8
rcf_08eadd
	a16
rcf_08eadf
	lda.w al_sword1,x
rcf_08eae2
	sec
rcf_08eae3
	sbc #$003f
rcf_08eae6
	sta.w al_sword1,x
rcf_08eae9
	a8
rcf_08eaeb
	a16
rcf_08eaed
	lda.w al_sword2,x
rcf_08eaf0
	eor #$ffff
rcf_08eaf3
	inc a
rcf_08eaf4
	sta.w al_sword2,x
rcf_08eaf7
	a8
rcf_08eaf9
	a16
rcf_08eafb
	lda.w al_weapontype,x
rcf_08eafe
	sec
rcf_08eaff
	sbc #$003f
rcf_08eb02
	sta.w al_weapontype,x
rcf_08eb05
	a8
retail_collisionspark_step
	ldy.w al_ptr,x
rcf_08eb0a
	jsl retail_followactor_l
rcf_08eb0e
	jsl retail_moveactor_l
rcf_08eb12
	a16
rcf_08eb14
	lda.w al_vx,x
rcf_08eb17
	clc
rcf_08eb18
	adc.w al_sword1,x
rcf_08eb1b
	sta.w al_vx,x
rcf_08eb1e
	a8
rcf_08eb20
	a16
rcf_08eb22
	lda.w al_vy,x
rcf_08eb25
	clc
rcf_08eb26
	adc.w al_sword2,x
rcf_08eb29
	sta.w al_vy,x
rcf_08eb2c
	a8
rcf_08eb2e
	a16
rcf_08eb30
	lda.w al_vz,x
rcf_08eb33
	clc
rcf_08eb34
	adc.w al_weapontype,x
rcf_08eb37
	sta.w al_vz,x
rcf_08eb3a
	a8
rcf_08eb3c
	lda.w al_sbyte1,x
rcf_08eb3f
	bne rcf_08eb45
rcf_08eb41
	jml retail_endactor_l
rcf_08eb45
	dec.w al_sbyte1,x
rcf_08eb48
	jsl retail_updateactorcell_l
rcf_08eb4c
	rtl
retail_makecollisionmarker_l
	lda.w racesound_playmode
rcf_08eb50
	bne rcf_08eba2
rcf_08eb52
	a16
rcf_08eb54
	lda #$a158
rcf_08eb57
	sta.w race_scratch
rcf_08eb5a
	a8
rcf_08eb5c
	jsl retail_makeactor_l
rcf_08eb60
	bcs rcf_08eb66
rcf_08eb62
	jml rcf_08eba2
rcf_08eb66
	lda.w al_sflags,y
rcf_08eb69
	ora #$04
rcf_08eb6b
	sta.w al_sflags,y
rcf_08eb6e
	lda #$02
rcf_08eb70
	sta.w al_sbyte3,y
rcf_08eb73
	lda #$05
rcf_08eb75
	sta.w al_sbyte1,y
rcf_08eb78
	lda #$0a
rcf_08eb7a
	sta.w al_sbyte2,y
rcf_08eb7d
	a16
rcf_08eb7f
	lda #retail_collisionmarker_l&WM
rcf_08eb82
	sta.w al_stratptr,y
rcf_08eb85
	a8
rcf_08eb87
	lda #mrcarfx_begin>>16
rcf_08eb89
	sta.w al_stratptr+2,y
rcf_08eb8c
	pha
rcf_08eb8d
	a16
rcf_08eb8f
	txa
rcf_08eb90
	sta.w al_sword1,y
rcf_08eb93
	a8
rcf_08eb95
	pla
rcf_08eb96
	lda.w race_animcount+1
rcf_08eb99
	sta.w al_vy,y
rcf_08eb9c
	lda.w race_visualangle
rcf_08eb9f
	sta.w al_vz,y
rcf_08eba2
	rtl
retail_collisionmarker_l
	lda #$0c
rcf_08eba5
	sta.w al_offroadtime,x
rcf_08eba8
	a16
rcf_08ebaa
	lda #retail_collisionmarker_step&WM
rcf_08ebad
	sta.w al_stratptr,x
rcf_08ebb0
	a8
rcf_08ebb2
	lda #mrcarfx_begin>>16
rcf_08ebb4
	sta.w al_stratptr+2,x
rcf_08ebb7
	bra rcf_08ebdc
retail_collisionmarker_step
	lda.w al_sflags,x
rcf_08ebbc
	ora #$04
rcf_08ebbe
	sta.w al_sflags,x
rcf_08ebc1
	lda #$00
rcf_08ebc3
	sta.w al_sbyte3,x
rcf_08ebc6
	lda #$00
rcf_08ebc8
	sta.w al_sbyte1,x
rcf_08ebcb
	lda #$00
rcf_08ebcd
	sta.w al_sbyte2,x
rcf_08ebd0
	lda.w al_offroadtime,x
rcf_08ebd3
	bne rcf_08ebd9
rcf_08ebd5
	jml retail_endactor_l
rcf_08ebd9
	dec.w al_offroadtime,x
rcf_08ebdc
	ldy.w al_sword1,x
rcf_08ebdf
	lda.w al_vy,x
rcf_08ebe2
	sta.w race_animcount+1
rcf_08ebe5
	lda.w al_vz,x
rcf_08ebe8
	sta.w race_visualangle
rcf_08ebeb
	lda #$00
rcf_08ebed
	sta x1
rcf_08ebef
	sta x2
rcf_08ebf1
	bit #$80
rcf_08ebf3
	beq rcf_08ebfb
rcf_08ebf5
	lda #$ff
rcf_08ebf7
	sta x2+1
rcf_08ebf9
	bra rcf_08ebfd
rcf_08ebfb
	stz x2+1
rcf_08ebfd
	lda.w race_animcount+1
rcf_08ec00
	sta y1
rcf_08ec02
	sta y2
rcf_08ec04
	bit #$80
rcf_08ec06
	beq rcf_08ec0e
rcf_08ec08
	lda #$ff
rcf_08ec0a
	sta y2+1
rcf_08ec0c
	bra rcf_08ec10
rcf_08ec0e
	stz y2+1
rcf_08ec10
	lda.w race_visualangle
rcf_08ec13
	sta z1
rcf_08ec15
	sta.w z2
rcf_08ec18
	bit #$80
rcf_08ec1a
	beq rcf_08ec23
rcf_08ec1c
	lda #$ff
rcf_08ec1e
	sta.w z2+1
rcf_08ec21
	bra rcf_08ec26
rcf_08ec23
	stz.w z2+1
rcf_08ec26
	lda.w al_rotx,y
rcf_08ec29
	jsl retail_actorrotx_l
rcf_08ec2d
	lda x2
rcf_08ec2f
	sta x1
rcf_08ec31
	lda y2
rcf_08ec33
	sta y1
rcf_08ec35
	lda.w z2
rcf_08ec38
	sta z1
rcf_08ec3a
	lda.w al_roty,y
rcf_08ec3d
	jsl retail_actorroty_l
rcf_08ec41
	a16
rcf_08ec43
	lda x2
rcf_08ec45
	asl a
rcf_08ec46
	sta x2
rcf_08ec48
	lda y2
rcf_08ec4a
	asl a
rcf_08ec4b
	sta y2
rcf_08ec4d
	lda.w z2
rcf_08ec50
	asl a
rcf_08ec51
	sta.w z2
rcf_08ec54
	lda.w al_worldx,y
rcf_08ec57
	clc
rcf_08ec58
	adc x2
rcf_08ec5a
	sta.w al_worldx,x
rcf_08ec5d
	lda.w al_worldz,y
rcf_08ec60
	clc
rcf_08ec61
	adc.w z2
rcf_08ec64
	sta.w al_worldz,x
rcf_08ec67
	lda.w al_worldy,y
rcf_08ec6a
	clc
rcf_08ec6b
	adc y2
rcf_08ec6d
	sta.w al_worldy,x
rcf_08ec70
	a8
rcf_08ec72
	jsl retail_updateactorcell_l
rcf_08ec76
	rtl
retail_timedactor_l
	a16
rcf_08ec79
	lda #retail_timedactor_step&WM
rcf_08ec7c
	sta.w al_stratptr,x
rcf_08ec7f
	a8
rcf_08ec81
	lda #mrcarfx_begin>>16
rcf_08ec83
	sta.w al_stratptr+2,x
rcf_08ec86
	lda #$14
rcf_08ec88
	sta.w al_offroadtime,x
retail_timedactor_step
	jsl retail_updateactorcell_l
rcf_08ec8f
	lda.w al_offroadtime,x
rcf_08ec92
	bne rcf_08ec98
rcf_08ec94
	jml retail_endactor_l
rcf_08ec98
	dec.w al_offroadtime,x
rcf_08ec9b
	rtl
retail_makecardebris_l
	a16
rcf_08ec9e
	lda #$a5f0
rcf_08eca1
	sta.w race_scratch
rcf_08eca4
	a8
rcf_08eca6
	jsl retail_makeactor_l
rcf_08ecaa
	bcs rcf_08ecb0
rcf_08ecac
	jml rcf_08ecc3
rcf_08ecb0
	a16
rcf_08ecb2
	lda #retail_cardebris_l&WM
rcf_08ecb5
	sta.w al_stratptr,y
rcf_08ecb8
	a8
rcf_08ecba
	lda #mrcarfx_begin>>16
rcf_08ecbc
	sta.w al_stratptr+2,y
rcf_08ecbf
	jsl retail_copyactorpos_l
rcf_08ecc3
	a16
rcf_08ecc5
	lda #$a60c
rcf_08ecc8
	sta.w race_scratch
rcf_08eccb
	a8
rcf_08eccd
	jsl retail_makeactor_l
rcf_08ecd1
	bcs rcf_08ecd7
rcf_08ecd3
	jml rcf_08ecea
rcf_08ecd7
	a16
rcf_08ecd9
	lda #retail_cardebris_l&WM
rcf_08ecdc
	sta.w al_stratptr,y
rcf_08ecdf
	a8
rcf_08ece1
	lda #mrcarfx_begin>>16
rcf_08ece3
	sta.w al_stratptr+2,y
rcf_08ece6
	jsl retail_copyactorpos_l
rcf_08ecea
	a16
rcf_08ecec
	lda #$a628
rcf_08ecef
	sta.w race_scratch
rcf_08ecf2
	a8
rcf_08ecf4
	jsl retail_makeactor_l
rcf_08ecf8
	bcs rcf_08ecfe
rcf_08ecfa
	jml rcf_08ed11
rcf_08ecfe
	a16
rcf_08ed00
	lda #retail_cardebris_l&WM
rcf_08ed03
	sta.w al_stratptr,y
rcf_08ed06
	a8
rcf_08ed08
	lda #mrcarfx_begin>>16
rcf_08ed0a
	sta.w al_stratptr+2,y
rcf_08ed0d
	jsl retail_copyactorpos_l
rcf_08ed11
	a16
rcf_08ed13
	lda #$a644
rcf_08ed16
	sta.w race_scratch
rcf_08ed19
	a8
rcf_08ed1b
	jsl retail_makeactor_l
rcf_08ed1f
	bcs rcf_08ed25
rcf_08ed21
	jml rcf_08ed38
rcf_08ed25
	a16
rcf_08ed27
	lda #retail_cardebris_l&WM
rcf_08ed2a
	sta.w al_stratptr,y
rcf_08ed2d
	a8
rcf_08ed2f
	lda #mrcarfx_begin>>16
rcf_08ed31
	sta.w al_stratptr+2,y
rcf_08ed34
	jsl retail_copyactorpos_l
rcf_08ed38
	rtl
retail_cardebris_l
	a16
rcf_08ed3b
	lda #retail_cardebris_step&WM
rcf_08ed3e
	sta.w al_stratptr,x
rcf_08ed41
	a8
rcf_08ed43
	lda #mrcarfx_begin>>16
rcf_08ed45
	sta.w al_stratptr+2,x
rcf_08ed48
	jsl retail_random_l
rcf_08ed4c
	and #$3f
rcf_08ed4e
	sta.w al_vx,x
rcf_08ed51
	a16
rcf_08ed53
	lda.w al_vx,x
rcf_08ed56
	sec
rcf_08ed57
	sbc #$001f
rcf_08ed5a
	sta.w al_vx,x
rcf_08ed5d
	a8
rcf_08ed5f
	jsl retail_random_l
rcf_08ed63
	and #$3f
rcf_08ed65
	sta.w al_vy,x
rcf_08ed68
	a16
rcf_08ed6a
	lda.w al_vy,x
rcf_08ed6d
	clc
rcf_08ed6e
	adc #$001e
rcf_08ed71
	sta.w al_vy,x
rcf_08ed74
	a8
rcf_08ed76
	a16
rcf_08ed78
	lda.w al_vy,x
rcf_08ed7b
	eor #$ffff
rcf_08ed7e
	inc a
rcf_08ed7f
	sta.w al_vy,x
rcf_08ed82
	a8
rcf_08ed84
	jsl retail_random_l
rcf_08ed88
	and #$3f
rcf_08ed8a
	sta.w al_vz,x
rcf_08ed8d
	a16
rcf_08ed8f
	lda.w al_vz,x
rcf_08ed92
	sec
rcf_08ed93
	sbc #$001f
rcf_08ed96
	sta.w al_vz,x
rcf_08ed99
	a8
rcf_08ed9b
	lda #$28
rcf_08ed9d
	sta.w al_sbyte1,x
rcf_08eda0
	jsl retail_random_l
rcf_08eda4
	sta.w al_roty,x
rcf_08eda7
	jsl retail_random_l
rcf_08edab
	sta.w al_rotx,x
rcf_08edae
	jsl retail_makedragsolid_l
rcf_08edb2
	jsl retail_actorvelocity_l
retail_cardebris_step
	jsl retail_publishbody_l
rcf_08edba
	bcc rcf_08edbf
rcf_08edbc
	brl retail_endactor_l
rcf_08edbf
	and #$01
rcf_08edc1
	bne rcf_08edce
rcf_08edc3
	jsl retail_objectcontacts_l
rcf_08edc7
	and #$80
rcf_08edc9
	beq rcf_08edce
rcf_08edcb
	jmp retail_wheelburst_l
rcf_08edce
	lda.w al_sbyte1,x
rcf_08edd1
	bne rcf_08edd7
rcf_08edd3
	jml retail_endactor_l
rcf_08edd7
	dec.w al_sbyte1,x
rcf_08edda
	rtl
mrcarfx_end
