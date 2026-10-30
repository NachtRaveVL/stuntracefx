; Retail scene ownership, wheel actors and material trails.
; A8/I16, direct page zero, binary arithmetic and DB=$7E unless noted.
; Existing early CPU records contain raw GSU-body pointers. The native
; parent is a word in al_ptr, never the adjacent al_type byte.
; Map next/previous/cell use al_mapptr/al_mapcnt/al_mapobjid.
; Sprite-view frames use al_sflags3/4, sprite word al_coltab, height
; al_eyesize, and the initializer's opaque $69 byte al_eyerot.
; These fields belong to raw scene strategies while they are active.
; race_cellheads is a separate 32-by-32 ownership grid in bank $7F.
; The caller supplies an empty CPU pool/list before retail_initscene_l.
; NUMALX is the frame producer's count; allocation retains the native cap
; without changing that count. race_actorcurrent is an insertion cursor,
; separate from the original free-list head.
; Geometry/shape identities still require the caller's asset binding.
	incpublics	mrscene.ext
mrscene_begin
	shorta
	longi
; US $03:B8A1.
retail_removeactor_l
	jsr rsc_removeactor
rsc_03b8a4
	rtl
rsc_removeactor
	phx
rsc_03b8a6
	phy
rsc_03b8a7
	php
rsc_03b8a8
	jsl retail_unlinkactor_l
rsc_03b8ac
	a16
rsc_03b8ae
	ldy.w al_prev,x
rsc_03b8b1
	bne rsc_03b8c4
rsc_03b8b3
	ldy.w al_next,x
rsc_03b8b6
	sty.w alxlst
rsc_03b8b9
	lda #$0000
rsc_03b8bc
	sta.w al_prev,y
rsc_03b8bf
	stz.w race_actorcurrent
rsc_03b8c2
	bra rsc_03b8d8
	longa
	longi
rsc_03b8c4
	phx
rsc_03b8c5
	lda.w al_next,x
rsc_03b8c8
	tax
rsc_03b8c9
	sta.w al_next,y
rsc_03b8cc
	beq rsc_03b8d4
rsc_03b8ce
	tya
rsc_03b8cf
	sta.w al_prev,x
rsc_03b8d2
	bra rsc_03b8d7
rsc_03b8d4
	sty.w race_actorcurrent
rsc_03b8d7
	plx
	longa
	longi
rsc_03b8d8
	lda.w alxfreelst
rsc_03b8db
	sta.w al_next,x
rsc_03b8de
	stx.w alxfreelst
rsc_03b8e1
	a8
rsc_03b8e3
	plp
rsc_03b8e4
	ply
rsc_03b8e5
	plx
rsc_03b8e6
	rts
	shorta
	longi
; US $03:C06C.
retail_moveactor_l
	a16
rsc_03c06e
	lda.w al_worldx,x
rsc_03c071
	clc
rsc_03c072
	adc.w al_vx,x
rsc_03c075
	sta.w al_worldx,x
rsc_03c078
	lda.w al_worldy,x
rsc_03c07b
	clc
rsc_03c07c
	adc.w al_vy,x
rsc_03c07f
	sta.w al_worldy,x
rsc_03c082
	lda.w al_worldz,x
rsc_03c085
	clc
rsc_03c086
	adc.w al_vz,x
rsc_03c089
	sta.w al_worldz,x
rsc_03c08c
	a8
rsc_03c08e
	rtl
	shorta
	longi
; US $03:C27F.
retail_actorroty_l
	phy
rsc_03c280
	phx
rsc_03c281
	php
rsc_03c282
	phb
rsc_03c283
	i8
rsc_03c285
	eor #$ff
rsc_03c287
	inc a
rsc_03c288
	tax
rsc_03c289
	lda #$00
rsc_03c28b
	pha
rsc_03c28c
	plb
rsc_03c28d
	lda.w costab&WM,x
rsc_03c290
	sta.w race_trigbytes+1
rsc_03c293
	lda.w sintab&WM,x
rsc_03c296
	sta.w race_trigbytes
rsc_03c299
	lda x1
rsc_03c29b
	bmi rsc_03c2b3
rsc_03c29d
	asl a
rsc_03c29e
	sta.w $4202
rsc_03c2a1
	lda.w race_trigbytes+1
rsc_03c2a4
	bmi rsc_03c2d6
rsc_03c2a6
	sta.w $4203
rsc_03c2a9
	nop
rsc_03c2aa
	nop
rsc_03c2ab
	nop
rsc_03c2ac
	nop
rsc_03c2ad
	lda.w $4217
rsc_03c2b0
	jmp rsc_03c2e4
rsc_03c2b3
	eor #$ff
rsc_03c2b5
	inc a
rsc_03c2b6
	asl a
rsc_03c2b7
	sta.w $4202
rsc_03c2ba
	lda.w race_trigbytes+1
rsc_03c2bd
	bmi rsc_03c2c6
rsc_03c2bf
	sta.w $4203
rsc_03c2c2
	nop
rsc_03c2c3
	jmp rsc_03c2de
rsc_03c2c6
	eor #$ff
rsc_03c2c8
	inc a
rsc_03c2c9
	sta.w $4203
rsc_03c2cc
	nop
rsc_03c2cd
	nop
rsc_03c2ce
	nop
rsc_03c2cf
	nop
rsc_03c2d0
	lda.w $4217
rsc_03c2d3
	jmp rsc_03c2e4
rsc_03c2d6
	eor #$ff
rsc_03c2d8
	inc a
rsc_03c2d9
	sta.w $4203
rsc_03c2dc
	nop
rsc_03c2dd
	nop
rsc_03c2de
	lda #$00
rsc_03c2e0
	sec
rsc_03c2e1
	sbc.w $4217
rsc_03c2e4
	tax
rsc_03c2e5
	stx x2
rsc_03c2e7
	lda z1
rsc_03c2e9
	bmi rsc_03c301
rsc_03c2eb
	asl a
rsc_03c2ec
	sta.w $4202
rsc_03c2ef
	lda.w race_trigbytes
rsc_03c2f2
	bmi rsc_03c324
rsc_03c2f4
	sta.w $4203
rsc_03c2f7
	nop
rsc_03c2f8
	nop
rsc_03c2f9
	nop
rsc_03c2fa
	nop
rsc_03c2fb
	lda.w $4217
rsc_03c2fe
	jmp rsc_03c332
rsc_03c301
	eor #$ff
rsc_03c303
	inc a
rsc_03c304
	asl a
rsc_03c305
	sta.w $4202
rsc_03c308
	lda.w race_trigbytes
rsc_03c30b
	bmi rsc_03c314
rsc_03c30d
	sta.w $4203
rsc_03c310
	nop
rsc_03c311
	jmp rsc_03c32c
rsc_03c314
	eor #$ff
rsc_03c316
	inc a
rsc_03c317
	sta.w $4203
rsc_03c31a
	nop
rsc_03c31b
	nop
rsc_03c31c
	nop
rsc_03c31d
	nop
rsc_03c31e
	lda.w $4217
rsc_03c321
	jmp rsc_03c332
rsc_03c324
	eor #$ff
rsc_03c326
	inc a
rsc_03c327
	sta.w $4203
rsc_03c32a
	nop
rsc_03c32b
	nop
rsc_03c32c
	lda #$00
rsc_03c32e
	sec
rsc_03c32f
	sbc.w $4217
rsc_03c332
	tax
rsc_03c333
	txa
rsc_03c334
	clc
rsc_03c335
	adc x2
rsc_03c337
	sta x2
rsc_03c339
	bit #$80
rsc_03c33b
	beq rsc_03c343
rsc_03c33d
	lda #$ff
rsc_03c33f
	sta x2+1
rsc_03c341
	bra rsc_03c345
rsc_03c343
	stz x2+1
rsc_03c345
	lda x1
rsc_03c347
	bmi rsc_03c35f
rsc_03c349
	asl a
rsc_03c34a
	sta.w $4202
rsc_03c34d
	lda.w race_trigbytes
rsc_03c350
	bmi rsc_03c382
rsc_03c352
	sta.w $4203
rsc_03c355
	nop
rsc_03c356
	nop
rsc_03c357
	nop
rsc_03c358
	nop
rsc_03c359
	lda.w $4217
rsc_03c35c
	jmp rsc_03c390
rsc_03c35f
	eor #$ff
rsc_03c361
	inc a
rsc_03c362
	asl a
rsc_03c363
	sta.w $4202
rsc_03c366
	lda.w race_trigbytes
rsc_03c369
	bmi rsc_03c372
rsc_03c36b
	sta.w $4203
rsc_03c36e
	nop
rsc_03c36f
	jmp rsc_03c38a
rsc_03c372
	eor #$ff
rsc_03c374
	inc a
rsc_03c375
	sta.w $4203
rsc_03c378
	nop
rsc_03c379
	nop
rsc_03c37a
	nop
rsc_03c37b
	nop
rsc_03c37c
	lda.w $4217
rsc_03c37f
	jmp rsc_03c390
rsc_03c382
	eor #$ff
rsc_03c384
	inc a
rsc_03c385
	sta.w $4203
rsc_03c388
	nop
rsc_03c389
	nop
rsc_03c38a
	lda #$00
rsc_03c38c
	sec
rsc_03c38d
	sbc.w $4217
rsc_03c390
	tax
rsc_03c391
	txa
rsc_03c392
	eor #$ff
rsc_03c394
	inc a
rsc_03c395
	sta.w z2
rsc_03c398
	lda z1
rsc_03c39a
	bmi rsc_03c3b2
rsc_03c39c
	asl a
rsc_03c39d
	sta.w $4202
rsc_03c3a0
	lda.w race_trigbytes+1
rsc_03c3a3
	bmi rsc_03c3d5
rsc_03c3a5
	sta.w $4203
rsc_03c3a8
	nop
rsc_03c3a9
	nop
rsc_03c3aa
	nop
rsc_03c3ab
	nop
rsc_03c3ac
	lda.w $4217
rsc_03c3af
	jmp rsc_03c3e3
rsc_03c3b2
	eor #$ff
rsc_03c3b4
	inc a
rsc_03c3b5
	asl a
rsc_03c3b6
	sta.w $4202
rsc_03c3b9
	lda.w race_trigbytes+1
rsc_03c3bc
	bmi rsc_03c3c5
rsc_03c3be
	sta.w $4203
rsc_03c3c1
	nop
rsc_03c3c2
	jmp rsc_03c3dd
rsc_03c3c5
	eor #$ff
rsc_03c3c7
	inc a
rsc_03c3c8
	sta.w $4203
rsc_03c3cb
	nop
rsc_03c3cc
	nop
rsc_03c3cd
	nop
rsc_03c3ce
	nop
rsc_03c3cf
	lda.w $4217
rsc_03c3d2
	jmp rsc_03c3e3
rsc_03c3d5
	eor #$ff
rsc_03c3d7
	inc a
rsc_03c3d8
	sta.w $4203
rsc_03c3db
	nop
rsc_03c3dc
	nop
rsc_03c3dd
	lda #$00
rsc_03c3df
	sec
rsc_03c3e0
	sbc.w $4217
rsc_03c3e3
	tax
rsc_03c3e4
	txa
rsc_03c3e5
	clc
rsc_03c3e6
	adc.w z2
rsc_03c3e9
	sta.w z2
rsc_03c3ec
	bit #$80
rsc_03c3ee
	beq rsc_03c3f7
rsc_03c3f0
	lda #$ff
rsc_03c3f2
	sta.w z2+1
rsc_03c3f5
	bra rsc_03c3fa
rsc_03c3f7
	stz.w z2+1
rsc_03c3fa
	plb
rsc_03c3fb
	plp
rsc_03c3fc
	plx
rsc_03c3fd
	ply
rsc_03c3fe
	rtl
	shorta
	longi
; US $03:C3FF.
retail_actorrotx_l
	phx
rsc_03c400
	phy
rsc_03c401
	php
rsc_03c402
	phb
rsc_03c403
	i8
rsc_03c405
	tax
rsc_03c406
	lda #$00
rsc_03c408
	pha
rsc_03c409
	plb
rsc_03c40a
	lda.w costab&WM,x
rsc_03c40d
	sta.w race_trigbytes+1
rsc_03c410
	lda.w sintab&WM,x
rsc_03c413
	sta.w race_trigbytes
rsc_03c416
	lda y1
rsc_03c418
	bmi rsc_03c430
rsc_03c41a
	asl a
rsc_03c41b
	sta.w $4202
rsc_03c41e
	lda.w race_trigbytes+1
rsc_03c421
	bmi rsc_03c453
rsc_03c423
	sta.w $4203
rsc_03c426
	nop
rsc_03c427
	nop
rsc_03c428
	nop
rsc_03c429
	nop
rsc_03c42a
	lda.w $4217
rsc_03c42d
	jmp rsc_03c461
rsc_03c430
	eor #$ff
rsc_03c432
	inc a
rsc_03c433
	asl a
rsc_03c434
	sta.w $4202
rsc_03c437
	lda.w race_trigbytes+1
rsc_03c43a
	bmi rsc_03c443
rsc_03c43c
	sta.w $4203
rsc_03c43f
	nop
rsc_03c440
	jmp rsc_03c45b
rsc_03c443
	eor #$ff
rsc_03c445
	inc a
rsc_03c446
	sta.w $4203
rsc_03c449
	nop
rsc_03c44a
	nop
rsc_03c44b
	nop
rsc_03c44c
	nop
rsc_03c44d
	lda.w $4217
rsc_03c450
	jmp rsc_03c461
rsc_03c453
	eor #$ff
rsc_03c455
	inc a
rsc_03c456
	sta.w $4203
rsc_03c459
	nop
rsc_03c45a
	nop
rsc_03c45b
	lda #$00
rsc_03c45d
	sec
rsc_03c45e
	sbc.w $4217
rsc_03c461
	tax
rsc_03c462
	stx y2
rsc_03c464
	lda z1
rsc_03c466
	bmi rsc_03c47e
rsc_03c468
	asl a
rsc_03c469
	sta.w $4202
rsc_03c46c
	lda.w race_trigbytes
rsc_03c46f
	bmi rsc_03c4a1
rsc_03c471
	sta.w $4203
rsc_03c474
	nop
rsc_03c475
	nop
rsc_03c476
	nop
rsc_03c477
	nop
rsc_03c478
	lda.w $4217
rsc_03c47b
	jmp rsc_03c4af
rsc_03c47e
	eor #$ff
rsc_03c480
	inc a
rsc_03c481
	asl a
rsc_03c482
	sta.w $4202
rsc_03c485
	lda.w race_trigbytes
rsc_03c488
	bmi rsc_03c491
rsc_03c48a
	sta.w $4203
rsc_03c48d
	nop
rsc_03c48e
	jmp rsc_03c4a9
rsc_03c491
	eor #$ff
rsc_03c493
	inc a
rsc_03c494
	sta.w $4203
rsc_03c497
	nop
rsc_03c498
	nop
rsc_03c499
	nop
rsc_03c49a
	nop
rsc_03c49b
	lda.w $4217
rsc_03c49e
	jmp rsc_03c4af
rsc_03c4a1
	eor #$ff
rsc_03c4a3
	inc a
rsc_03c4a4
	sta.w $4203
rsc_03c4a7
	nop
rsc_03c4a8
	nop
rsc_03c4a9
	lda #$00
rsc_03c4ab
	sec
rsc_03c4ac
	sbc.w $4217
rsc_03c4af
	tax
rsc_03c4b0
	txa
rsc_03c4b1
	clc
rsc_03c4b2
	adc y2
rsc_03c4b4
	sta y2
rsc_03c4b6
	bit #$80
rsc_03c4b8
	beq rsc_03c4c0
rsc_03c4ba
	lda #$ff
rsc_03c4bc
	sta y2+1
rsc_03c4be
	bra rsc_03c4c2
rsc_03c4c0
	stz y2+1
rsc_03c4c2
	lda y1
rsc_03c4c4
	bmi rsc_03c4dc
rsc_03c4c6
	asl a
rsc_03c4c7
	sta.w $4202
rsc_03c4ca
	lda.w race_trigbytes
rsc_03c4cd
	bmi rsc_03c4ff
rsc_03c4cf
	sta.w $4203
rsc_03c4d2
	nop
rsc_03c4d3
	nop
rsc_03c4d4
	nop
rsc_03c4d5
	nop
rsc_03c4d6
	lda.w $4217
rsc_03c4d9
	jmp rsc_03c50d
rsc_03c4dc
	eor #$ff
rsc_03c4de
	inc a
rsc_03c4df
	asl a
rsc_03c4e0
	sta.w $4202
rsc_03c4e3
	lda.w race_trigbytes
rsc_03c4e6
	bmi rsc_03c4ef
rsc_03c4e8
	sta.w $4203
rsc_03c4eb
	nop
rsc_03c4ec
	jmp rsc_03c507
rsc_03c4ef
	eor #$ff
rsc_03c4f1
	inc a
rsc_03c4f2
	sta.w $4203
rsc_03c4f5
	nop
rsc_03c4f6
	nop
rsc_03c4f7
	nop
rsc_03c4f8
	nop
rsc_03c4f9
	lda.w $4217
rsc_03c4fc
	jmp rsc_03c50d
rsc_03c4ff
	eor #$ff
rsc_03c501
	inc a
rsc_03c502
	sta.w $4203
rsc_03c505
	nop
rsc_03c506
	nop
rsc_03c507
	lda #$00
rsc_03c509
	sec
rsc_03c50a
	sbc.w $4217
rsc_03c50d
	tax
rsc_03c50e
	txa
rsc_03c50f
	eor #$ff
rsc_03c511
	inc a
rsc_03c512
	sta.w z2
rsc_03c515
	lda z1
rsc_03c517
	bmi rsc_03c52f
rsc_03c519
	asl a
rsc_03c51a
	sta.w $4202
rsc_03c51d
	lda.w race_trigbytes+1
rsc_03c520
	bmi rsc_03c552
rsc_03c522
	sta.w $4203
rsc_03c525
	nop
rsc_03c526
	nop
rsc_03c527
	nop
rsc_03c528
	nop
rsc_03c529
	lda.w $4217
rsc_03c52c
	jmp rsc_03c560
rsc_03c52f
	eor #$ff
rsc_03c531
	inc a
rsc_03c532
	asl a
rsc_03c533
	sta.w $4202
rsc_03c536
	lda.w race_trigbytes+1
rsc_03c539
	bmi rsc_03c542
rsc_03c53b
	sta.w $4203
rsc_03c53e
	nop
rsc_03c53f
	jmp rsc_03c55a
rsc_03c542
	eor #$ff
rsc_03c544
	inc a
rsc_03c545
	sta.w $4203
rsc_03c548
	nop
rsc_03c549
	nop
rsc_03c54a
	nop
rsc_03c54b
	nop
rsc_03c54c
	lda.w $4217
rsc_03c54f
	jmp rsc_03c560
rsc_03c552
	eor #$ff
rsc_03c554
	inc a
rsc_03c555
	sta.w $4203
rsc_03c558
	nop
rsc_03c559
	nop
rsc_03c55a
	lda #$00
rsc_03c55c
	sec
rsc_03c55d
	sbc.w $4217
rsc_03c560
	tax
rsc_03c561
	txa
rsc_03c562
	clc
rsc_03c563
	adc.w z2
rsc_03c566
	sta.w z2
rsc_03c569
	bit #$80
rsc_03c56b
	beq rsc_03c574
rsc_03c56d
	lda #$ff
rsc_03c56f
	sta.w z2+1
rsc_03c572
	bra rsc_03c577
rsc_03c574
	stz.w z2+1
rsc_03c577
	plb
rsc_03c578
	plp
rsc_03c579
	ply
rsc_03c57a
	plx
rsc_03c57b
	rtl
	shorta
	longi
; US $03:CB25.
retail_clearactor_l
	phb
rsc_03cb26
	lda #$7e
rsc_03cb28
	pha
rsc_03cb29
	plb
rsc_03cb2a
	phx
rsc_03cb2b
	tyx
rsc_03cb2c
	ply
rsc_03cb2d
	a16
rsc_03cb2f
	lda #$0000
rsc_03cb32
	phy
rsc_03cb33
	phx
rsc_03cb34
	ldy #(alx_size-4)/2
rsc_03cb37
	sta.w al_shape,x
rsc_03cb3a
	inx
rsc_03cb3b
	inx
rsc_03cb3c
	dey
rsc_03cb3d
	bne rsc_03cb37
; Clear the surviving record's odd trailing byte; links stay intact.
	a8
	sta.w al_shape,x
	a16
rsc_03cb3f
	plx
rsc_03cb40
	ply
rsc_03cb41
	lda #$0000
rsc_03cb44
	sta.w al_mapobjid,x
rsc_03cb47
	jsl retail_linkactor_l
rsc_03cb4b
	a8
rsc_03cb4d
	lda #$00
rsc_03cb4f
	sta.w al_sbyte4,x
rsc_03cb52
	lda #$69
rsc_03cb54
	sta.w al_eyerot,x
rsc_03cb57
	phx
rsc_03cb58
	tyx
rsc_03cb59
	ply
rsc_03cb5a
	plb
rsc_03cb5b
	rtl
retail_allocactor_l
	php
rsc_03cb5d
	a8
rsc_03cb5f
	phb
rsc_03cb60
	lda #$7e
rsc_03cb62
	pha
rsc_03cb63
	plb
rsc_03cb64
	ai16
rsc_03cb66
	ldx.w race_actorcurrent
rsc_03cb69
	txy
rsc_03cb6a
	ldx.w alxfreelst
rsc_03cb6d
	bne rsc_03cb73
rsc_03cb6f
	tyx
rsc_03cb70
	jmp rsc_03cbaa
rsc_03cb73
	lda.w al_next,x
rsc_03cb76
	sta.w alxfreelst
rsc_03cb79
	tya
rsc_03cb7a
	bne rsc_03cb8a
rsc_03cb7c
	lda.w alxlst
rsc_03cb7f
	sta.w al_next,x
rsc_03cb82
	stz.w al_prev,x
rsc_03cb85
	stx.w alxlst
rsc_03cb88
	bra rsc_03cb98
rsc_03cb8a
	lda.w al_next,y
rsc_03cb8d
	sta.w al_next,x
rsc_03cb90
	txa
rsc_03cb91
	sta.w al_next,y
rsc_03cb94
	tya
rsc_03cb95
	sta.w al_prev,x
rsc_03cb98
	stx.w race_actorcurrent
rsc_03cb9b
	ldy.w al_next,x
rsc_03cb9e
	beq rsc_03cba4
rsc_03cba0
	txa
rsc_03cba1
	sta.w al_prev,y
rsc_03cba4
	a8
rsc_03cba6
	plb
rsc_03cba7
	plp
rsc_03cba8
	sec
rsc_03cba9
	rtl
rsc_03cbaa
	a8
rsc_03cbac
	plb
rsc_03cbad
	plp
rsc_03cbae
	clc
rsc_03cbaf
	rtl
	longa
	longi
; US $03:CC5A.
retail_scaleactorvelocity_l
	cmp #$8000
rsc_03cc5d
	ror a
rsc_03cc5e
	sta tpx
rsc_03cc60
	cmp #$8000
rsc_03cc63
	ror a
rsc_03cc64
	clc
rsc_03cc65
	adc tpx
rsc_03cc67
	rtl
	shorta
	longi
; US $03:CCA1.
retail_retireactor_l
	cpx.w race_protectedactor
rsc_03cca4
	bne rsc_03ccab
rsc_03cca6
	inc.w race_removerequest
rsc_03cca9
	bra rsc_03ccaf
rsc_03ccab
	jsl retail_removeactor_l
rsc_03ccaf
	rtl
rsc_03ccb0
	phx
rsc_03ccb1
	tyx
rsc_03ccb2
	ply
rsc_03ccb3
	jsl retail_retireactor_l
rsc_03ccb7
	phx
rsc_03ccb8
	tyx
rsc_03ccb9
	ply
rsc_03ccba
	rtl
retail_makeactor_l
	stx tpx
rsc_03ccbd
	lda.w numalx
rsc_03ccc0
	cmp #$2e
rsc_03ccc2
	bpl rsc_03ccca
rsc_03ccc4
	jsl retail_allocactor_l
rsc_03ccc8
	bcs rsc_03ccd1
rsc_03ccca
	ldy #$0000
rsc_03cccd
	ldx tpx
rsc_03cccf
	clc
rsc_03ccd0
	rtl
rsc_03ccd1
	txy
rsc_03ccd2
	ldx tpx
rsc_03ccd4
	a8
rsc_03ccd6
	jsl retail_clearactor_l
rsc_03ccda
	lda #$03
rsc_03ccdc
	sta.w al_sbyte4,y
rsc_03ccdf
	a16
rsc_03cce1
	lda.w race_scratch
rsc_03cce4
	sta.w al_shape,y
rsc_03cce7
	a8
rsc_03cce9
	sec
rsc_03ccea
	rtl
	longa
	longi
; US $03:CDF4.
retail_easeactor_l
	cmp tpx
rsc_03cdf6
	bne rsc_03cdfc
rsc_03cdf8
	jml rsc_03d1ae
rsc_03cdfc
	sec
rsc_03cdfd
	sbc tpx
rsc_03cdff
	cmp #$0000
rsc_03ce02
	bmi rsc_03ce0e
rsc_03ce04
	cmp #$0004
rsc_03ce07
	bpl rsc_03ce16
rsc_03ce09
	lda #$0004
rsc_03ce0c
	bra rsc_03ce16
rsc_03ce0e
	cmp #$fffc
rsc_03ce11
	bmi rsc_03ce16
rsc_03ce13
	lda #$fffc
rsc_03ce16
	cmp #$8000
rsc_03ce19
	ror a
rsc_03ce1a
	bpl rsc_03ce1f
rsc_03ce1c
	adc #$0000
rsc_03ce1f
	cmp #$8000
rsc_03ce22
	ror a
rsc_03ce23
	bpl rsc_03ce28
rsc_03ce25
	adc #$0000
rsc_03ce28
	clc
rsc_03ce29
	adc tpx
rsc_03ce2b
	sta tpx
rsc_03ce2d
	brl rsc_easereturn
	longa
	longi
; US $03:D1AA.
rsc_easereturn
	lda tpx
rsc_03d1ac
	clc
rsc_03d1ad
	rtl
rsc_03d1ae
	lda tpx
rsc_03d1b0
	sec
rsc_03d1b1
	rtl
	shorta
	longi
; US $03:D1E6.
retail_copyactorpos_l
	a16
rsc_03d1e8
	lda.w al_worldx,x
rsc_03d1eb
	sta.w al_worldx,y
rsc_03d1ee
	lda.w al_worldy,x
rsc_03d1f1
	sta.w al_worldy,y
rsc_03d1f4
	lda.w al_worldz,x
rsc_03d1f7
	sta.w al_worldz,y
rsc_03d1fa
	a8
rsc_03d1fc
	rtl
	shorta
	longi
; US $08:8364.
retail_linkactor_l
	phb
rsc_088365
	phy
rsc_088366
	phx
rsc_088367
	a8
rsc_088369
	lda #$7e
rsc_08836b
	pha
rsc_08836c
	plb
rsc_08836d
	a16
rsc_08836f
	lda.w al_mapobjid,x
rsc_088372
	stz.w al_mapcnt,x
rsc_088375
	txy
rsc_088376
	tax
rsc_088377
	lda.l race_cellheads,x
rsc_08837b
	sta.w al_mapptr,y
rsc_08837e
	beq rsc_088389
rsc_088380
	sty tpy
rsc_088382
	tay
rsc_088383
	lda tpy
rsc_088385
	sta.w al_mapcnt,y
rsc_088388
	tay
rsc_088389
	tya
rsc_08838a
	sta.l race_cellheads,x
rsc_08838e
	plx
rsc_08838f
	ply
rsc_088390
	plb
rsc_088391
	rtl
retail_unlinkactor_l
	phb
rsc_088393
	phy
rsc_088394
	phx
rsc_088395
	a8
rsc_088397
	lda #$7e
rsc_088399
	pha
rsc_08839a
	plb
rsc_08839b
	a16
rsc_08839d
	txy
rsc_08839e
	lda.w al_mapcnt,x
rsc_0883a1
	beq rsc_0883b3
rsc_0883a3
	tax
rsc_0883a4
	lda.w al_mapptr,y
rsc_0883a7
	sta.w al_mapptr,x
rsc_0883aa
	beq rsc_0883c4
rsc_0883ac
	tay
rsc_0883ad
	txa
rsc_0883ae
	sta.w al_mapcnt,y
rsc_0883b1
	bra rsc_0883c4
rsc_0883b3
	lda.w al_mapobjid,x
rsc_0883b6
	tax
rsc_0883b7
	lda.w al_mapptr,y
rsc_0883ba
	sta.l race_cellheads,x
rsc_0883be
	beq rsc_0883c4
rsc_0883c0
	tax
rsc_0883c1
	stz.w al_mapcnt,x
rsc_0883c4
	plx
rsc_0883c5
	ply
rsc_0883c6
	plb
rsc_0883c7
	rtl
	shorta
	longi
; US $08:83CC.
retail_updateactorcell_l
	php
rsc_0883cd
	a16
rsc_0883cf
	jsr rsc_actorcell
rsc_0883d2
	cmp.l alx_mapobjid,x
rsc_0883d6
	beq rsc_0883e6
rsc_0883d8
	pha
rsc_0883d9
	jsl retail_unlinkactor_l
rsc_0883dd
	pla
rsc_0883de
	sta.l alx_mapobjid,x
rsc_0883e2
	jsl retail_linkactor_l
rsc_0883e6
	plp
rsc_0883e7
	rtl
retail_actorcell_l
	jsr rsc_pointcell
rsc_0883eb
	rtl
rsc_actorcell
	lda.l $7e200c,x
rsc_0883f0
	sta x1
rsc_0883f2
	lda.l $7e2010,x
rsc_0883f6
	sta z1
rsc_pointcell
	lda x1
rsc_0883fa
	cmp #$8000
rsc_0883fd
	ror a
rsc_0883fe
	cmp #$8000
rsc_088401
	ror a
rsc_088402
	xba
rsc_088403
	bit #$0080
rsc_088406
	beq rsc_08840d
rsc_088408
	ora #$ff00
rsc_08840b
	bra rsc_088410
rsc_08840d
	and #$00ff
rsc_088410
	clc
rsc_088411
	adc #$0020
rsc_088414
	and #$fffe
rsc_088417
	sta x1
rsc_088419
	lda z1
rsc_08841b
	and #$f800
rsc_08841e
	cmp #$8000
rsc_088421
	ror a
rsc_088422
	cmp #$8000
rsc_088425
	ror a
rsc_088426
	cmp #$8000
rsc_088429
	ror a
rsc_08842a
	cmp #$8000
rsc_08842d
	ror a
rsc_08842e
	cmp #$8000
rsc_088431
	ror a
rsc_088432
	clc
rsc_088433
	adc #$0400
rsc_088436
	sta z1
rsc_088438
	clc
rsc_088439
	adc x1
rsc_08843b
	rts
	shorta
	longi
; US $08:BA57.
retail_makewheels_l
	stx.w race_visualowner
rsc_08ba5a
	a16
rsc_08ba5c
	lda.w al_collobjptr,x
rsc_08ba5f
	bne rsc_08ba64
rsc_08ba61
	brl retail_scene_return
rsc_08ba64
	phx
rsc_08ba65
	tax
rsc_08ba66
	lda.l $70003e,x
rsc_08ba6a
	tax
rsc_08ba6b
	bne rsc_08ba70
rsc_08ba6d
	brl rsc_08bb12
rsc_08ba70
	lda.l $700046,x
rsc_08ba74
	and #$0200
rsc_08ba77
	beq rsc_08ba7c
rsc_08ba79
	brl rsc_08bb09
rsc_08ba7c
	phx
rsc_08ba7d
	lda.l $700012,x
rsc_08ba81
	tax
rsc_08ba82
	lda.l retail_visualdefs,x
rsc_08ba86
	sta.w race_callback
rsc_08ba89
	lda.l retail_visualdefs+2,x
rsc_08ba8d
	sta.w race_visualsize
rsc_08ba90
	lda.l retail_visualdefs+4,x
rsc_08ba94
	sta.w race_visualoffset
rsc_08ba97
	plx
rsc_08ba98
	a8
rsc_08ba9a
	a16
rsc_08ba9c
	lda.w race_callback
rsc_08ba9f
	sta.w race_scratch
rsc_08baa2
	a8
rsc_08baa4
	jsl retail_makeactor_l
rsc_08baa8
	bcs rsc_08baae
rsc_08baaa
	jml rsc_08bb09
rsc_08baae
	lda.w race_visualsize
rsc_08bab1
	ora.w race_visualsize+1
rsc_08bab4
	beq rsc_08bae6
rsc_08bab6
	lda.w al_sflags,y
rsc_08bab9
	ora #$08
rsc_08babb
	sta.w al_sflags,y
rsc_08babe
	lda #$00
rsc_08bac0
	sta.w al_lapcnt,y
rsc_08bac3
	lda.w race_visualoffset
rsc_08bac6
	sta.w al_eyesize,y
rsc_08bac9
	a16
rsc_08bacb
	lda.w race_visualsize
rsc_08bace
	sta.w al_sword2,y
rsc_08bad1
	a8
rsc_08bad3
	lda.w racesound_playmode
rsc_08bad6
	beq rsc_08bae6
rsc_08bad8
	a16
rsc_08bada
	lda.w al_sword2,y
rsc_08badd
	clc
rsc_08bade
	adc #$0002
rsc_08bae1
	sta.w al_sword2,y
rsc_08bae4
	a8
rsc_08bae6
	a16
rsc_08bae8
	lda #retail_wheelactor_l&WM
rsc_08baeb
	sta.w al_stratptr,y
rsc_08baee
	a8
rsc_08baf0
	lda #mrscene_begin>>16
rsc_08baf2
	sta.w al_stratptr+2,y
rsc_08baf5
	pha
rsc_08baf6
	a16
rsc_08baf8
	txa
rsc_08baf9
	sta.w al_collobjptr,y
rsc_08bafc
	a8
rsc_08bafe
	pla
rsc_08baff
	a16
rsc_08bb01
	lda.w race_visualowner
rsc_08bb04
	sta.w al_ptr,y
rsc_08bb07
	a8
rsc_08bb09
	a16
rsc_08bb0b
	lda.l $700034,x
rsc_08bb0f
	jmp rsc_08ba6a
rsc_08bb12
	plx
rsc_08bb13
	a8
rsc_08bb15
	rtl
retail_wheelactor_l
	a16
rsc_08bb18
	lda #retail_wheelactor_step&WM
rsc_08bb1b
	sta.w al_stratptr,x
rsc_08bb1e
	a8
rsc_08bb20
	lda #mrscene_begin>>16
rsc_08bb22
	sta.w al_stratptr+2,x
rsc_08bb25
	ldy.w al_ptr,x
rsc_08bb28
	lda.w al_whocanseeme,y
rsc_08bb2b
	sta.w al_whocanseeme,x
retail_wheelactor_step
	jsr rsc_wheelposition
rsc_08bb31
	ldy.w al_ptr,x
rsc_08bb34
	lda.w al_sflags2,y
rsc_08bb37
	and #$04
rsc_08bb39
	bne rsc_08bb3f
rsc_08bb3b
	jml rsc_08bb4e
rsc_08bb3f
	a16
rsc_08bb41
	lda #retail_loosewheel_l&WM
rsc_08bb44
	sta.w al_stratptr,x
rsc_08bb47
	a8
rsc_08bb49
	lda #mrscene_begin>>16
rsc_08bb4b
	sta.w al_stratptr+2,x
rsc_08bb4e
	ldy.w al_ptr,x
rsc_08bb51
	lda.w al_sflags,x
rsc_08bb54
	and #$bf
rsc_08bb56
	sta.w al_sflags,x
rsc_08bb59
	lda.w al_sflags,y
rsc_08bb5c
	bit #$08
rsc_08bb5e
	bne rsc_08bb6e
rsc_08bb60
	bit #$40
rsc_08bb62
	beq rsc_08bb76
rsc_08bb64
	lda.w al_sflags,x
rsc_08bb67
	ora #$40
rsc_08bb69
	sta.w al_sflags,x
rsc_08bb6c
	bra rsc_08bb76
rsc_08bb6e
	lda.w al_sflags,x
rsc_08bb71
	ora #$20
rsc_08bb73
	sta.w al_sflags,x
rsc_08bb76
	lda #$03
rsc_08bb78
	sta.w al_sbyte4,x
rsc_08bb7b
	rtl
retail_loosewheel_l
	a16
rsc_08bb7e
	lda #retail_loosewheel_step&WM
rsc_08bb81
	sta.w al_stratptr,x
rsc_08bb84
	a8
rsc_08bb86
	lda #mrscene_begin>>16
rsc_08bb88
	sta.w al_stratptr+2,x
rsc_08bb8b
	a16
rsc_08bb8d
	lda.w al_collobjptr,x
rsc_08bb90
	sta.w al_sword1,x
rsc_08bb93
	a8
rsc_08bb95
	jsl retail_makedragsolid_l
rsc_08bb99
	ldy.w al_ptr,x
rsc_08bb9c
	jsl retail_copyrawvelocity_l
rsc_08bba0
	bpl rsc_08bba5
rsc_08bba2
	brl rsc_08bd06
rsc_08bba5
	a16
rsc_08bba7
	phx
rsc_08bba8
	txy
rsc_08bba9
	lda.w al_sword1,x
rsc_08bbac
	tax
rsc_08bbad
	lda.l $700036,x
rsc_08bbb1
	cmp #$8000
rsc_08bbb4
	ror a
rsc_08bbb5
	sta.w al_vx,y
rsc_08bbb8
	lda #$ffce
rsc_08bbbb
	sta.w al_vy,y
rsc_08bbbe
	lda.l $70003a,x
rsc_08bbc2
	cmp #$8000
rsc_08bbc5
	ror a
rsc_08bbc6
	sta.w al_vz,y
rsc_08bbc9
	plx
rsc_08bbca
	a8
rsc_08bbcc
	jsl retail_actorvelocity_l
rsc_08bbd0
	jsl retail_random_l
rsc_08bbd4
	and #$0f
rsc_08bbd6
	sta.w al_offroadtime,x
rsc_08bbd9
	lda.w al_offroadtime,x
rsc_08bbdc
	clc
rsc_08bbdd
	adc #$0a
rsc_08bbdf
	sta.w al_offroadtime,x
retail_loosewheel_step
	jsl retail_publishbody_l
rsc_08bbe6
	and #$01
rsc_08bbe8
	bne rsc_08bc03
rsc_08bbea
	ldy.w al_ptr,x
rsc_08bbed
	lda.w al_sflags2,y
rsc_08bbf0
	and #$10
rsc_08bbf2
	bne rsc_08bbf8
rsc_08bbf4
	jml rsc_08bc03
rsc_08bbf8
	jsl retail_objectcontacts_l
rsc_08bbfc
	and #$80
rsc_08bbfe
	beq rsc_08bc03
rsc_08bc00
	jmp retail_wheelburst_l
rsc_08bc03
	ldy.w al_ptr,x
rsc_08bc06
	lda.w al_sflags2,y
rsc_08bc09
	and #$10
rsc_08bc0b
	bne rsc_08bc11
rsc_08bc0d
	jml rsc_08bc1a
rsc_08bc11
	lda.w al_offroadtime,x
rsc_08bc14
	bne rsc_08bc1a
rsc_08bc16
	jml rsc_08bc45
rsc_08bc1a
	lda.w al_offroadtime,x
rsc_08bc1d
	bne rsc_08bc23
rsc_08bc1f
	jml rsc_08bc64
rsc_08bc23
	dec.w al_offroadtime,x
rsc_08bc26
	a16
rsc_08bc28
	lda.w al_eyesize,x
rsc_08bc2b
	and #$00ff
rsc_08bc2e
	eor #$ffff
rsc_08bc31
	inc a
rsc_08bc32
	clc
rsc_08bc33
	adc #$ffec
rsc_08bc36
	clc
rsc_08bc37
	adc.w al_worldy,x
rsc_08bc3a
	sta.w al_worldy,x
rsc_08bc3d
	a8
rsc_08bc3f
	jsr rsc_emitdust
rsc_08bc42
	jmp rsc_08bb4e
rsc_08bc45
	phx
rsc_08bc46
	a16
rsc_08bc48
	ldy.w al_ptr,x
rsc_08bc4b
	lda.w al_collobjptr,y
rsc_08bc4e
	tax
rsc_08bc4f
	lda.l $700064,x
rsc_08bc53
	plx
rsc_08bc54
	and #$0010
rsc_08bc57
	a8
rsc_08bc59
	beq rsc_08bc5e
rsc_08bc5b
	brl retail_endactor_l
rsc_08bc5e
	jsr rsc_emitdust
rsc_08bc61
	jmp rsc_08bb4e
rsc_08bc64
	a16
rsc_08bc66
	lda #retail_returnwheel_step&WM
rsc_08bc69
	sta.w al_stratptr,x
rsc_08bc6c
	a8
rsc_08bc6e
	lda #mrscene_begin>>16
rsc_08bc70
	sta.w al_stratptr+2,x
retail_returnwheel_step
	ldy.w al_ptr,x
rsc_08bc76
	jsl retail_copyrawvelocity_l
rsc_08bc7a
	a16
rsc_08bc7c
	phx
rsc_08bc7d
	lda.w al_sword1,x
rsc_08bc80
	txy
rsc_08bc81
	tax
rsc_08bc82
	lda.l $70001e,x
rsc_08bc86
	clc
rsc_08bc87
	adc.l $70004a,x
rsc_08bc8b
	sta x2
rsc_08bc8d
	lda.w al_eyesize,y
rsc_08bc90
	and #$00ff
rsc_08bc93
	eor #$ffff
rsc_08bc96
	inc a
rsc_08bc97
	clc
rsc_08bc98
	adc #$ffec
rsc_08bc9b
	clc
rsc_08bc9c
	adc.l $700020,x
rsc_08bca0
	clc
rsc_08bca1
	adc.l $70004c,x
rsc_08bca5
	sta y2
rsc_08bca7
	lda.l $700022,x
rsc_08bcab
	clc
rsc_08bcac
	adc.l $70004e,x
rsc_08bcb0
	sta.w z2
rsc_08bcb3
	jsr rsc_wheelorientation
rsc_08bcb6
	plx
rsc_08bcb7
	a8
rsc_08bcb9
	ldy.w al_ptr,x
rsc_08bcbc
	a16
rsc_08bcbe
	lda.w al_worldx,x
rsc_08bcc1
	sta tpx
rsc_08bcc3
	lda x2
rsc_08bcc5
	jsl retail_easeactor_l
rsc_08bcc9
	sta.w al_worldx,x
rsc_08bccc
	a8
rsc_08bcce
	a16
rsc_08bcd0
	lda.w al_worldy,x
rsc_08bcd3
	sta tpx
rsc_08bcd5
	lda y2
rsc_08bcd7
	jsl retail_easeactor_l
rsc_08bcdb
	sta.w al_worldy,x
rsc_08bcde
	a8
rsc_08bce0
	a16
rsc_08bce2
	lda.w al_worldz,x
rsc_08bce5
	sta tpx
rsc_08bce7
	lda.w z2
rsc_08bcea
	jsl retail_easeactor_l
rsc_08bcee
	sta.w al_worldz,x
rsc_08bcf1
	a8
rsc_08bcf3
	jsl retail_moveactor_l
rsc_08bcf7
	jsl retail_updateactorcell_l
rsc_08bcfb
	lda.w al_sflags2,y
rsc_08bcfe
	and #$04
rsc_08bd00
	beq rsc_08bd06
rsc_08bd02
	jml rsc_08bb4e
rsc_08bd06
	a16
rsc_08bd08
	lda.w al_sword1,x
rsc_08bd0b
	sta.w al_collobjptr,x
rsc_08bd0e
	a8
rsc_08bd10
	a16
rsc_08bd12
	lda #retail_wheelactor_step&WM
rsc_08bd15
	sta.w al_stratptr,x
rsc_08bd18
	a8
rsc_08bd1a
	lda #mrscene_begin>>16
rsc_08bd1c
	sta.w al_stratptr+2,x
rsc_08bd1f
	jmp rsc_08bb4e
rsc_wheelposition
	phx
rsc_08bd23
	jsl retail_updateactorcell_l
rsc_08bd27
	txy
rsc_08bd28
	a16
rsc_08bd2a
	lda.w al_ptr,x
rsc_08bd2d
	tax
rsc_08bd2e
	lda.w al_collobjptr,x
rsc_08bd31
	tax
rsc_08bd32
	lda.l $700016,x
rsc_08bd36
	and #$0400
rsc_08bd39
	beq rsc_08bd57
rsc_08bd3b
	lda.w al_collobjptr,y
rsc_08bd3e
	tax
rsc_08bd3f
	lda.l $700016,x
rsc_08bd43
	ora #$0480
rsc_08bd46
	sta.l $700016,x
rsc_08bd4a
	a8
rsc_08bd4c
	lda.w al_sflags,y
rsc_08bd4f
	ora #$20
rsc_08bd51
	sta.w al_sflags,y
rsc_08bd54
	jmp rsc_08bf90
rsc_08bd57
	tyx
rsc_08bd58
	a8
rsc_08bd5a
	lda.w al_sflags,x
rsc_08bd5d
	and #$df
rsc_08bd5f
	sta.w al_sflags,x
rsc_08bd62
	phx
rsc_08bd63
	a16
rsc_08bd65
	lda.w al_collobjptr,x
rsc_08bd68
	tax
rsc_08bd69
	lda.l $700016,x
rsc_08bd6d
	and #$fb7f
rsc_08bd70
	sta.l $700016,x
rsc_08bd74
	tyx
rsc_08bd75
	lda.w al_ptr,x
rsc_08bd78
	tax
rsc_08bd79
	lda.w al_sflags,x
rsc_08bd7c
	and #$0040
rsc_08bd7f
	beq rsc_08bd84
rsc_08bd81
	brl rsc_08bf53
rsc_08bd84
	lda.w al_collobjptr,x
rsc_08bd87
	tax
rsc_08bd88
	lda.l $700040,x
rsc_08bd8c
	sta.w race_callback
rsc_08bd8f
	lda.l $700064,x
rsc_08bd93
	and #$0003
rsc_08bd96
	bne rsc_08bd9b
rsc_08bd98
	brl rsc_08bf53
rsc_08bd9b
	plx
rsc_08bd9c
	phx
rsc_08bd9d
	lda.w al_collobjptr,x
rsc_08bda0
	tax
rsc_08bda1
	lda.l $700046,x
rsc_08bda5
	bit #$0001
rsc_08bda8
	bne rsc_08bdad
rsc_08bdaa
	brl rsc_08bf53
rsc_08bdad
	bit #$0010
rsc_08bdb0
	bne rsc_08bdb5
rsc_08bdb2
	brl rsc_08bf53
rsc_08bdb5
	lda.l $70002c,x
rsc_08bdb9
	bit #$0080
rsc_08bdbc
	beq rsc_08bdc1
rsc_08bdbe
	brl rsc_08beef
rsc_08bdc1
	bit #$2000
rsc_08bdc4
	beq rsc_08bdc9
rsc_08bdc6
	brl rsc_08beb2
rsc_08bdc9
	bit #$0800
rsc_08bdcc
	beq rsc_08bdd1
rsc_08bdce
	brl rsc_08be38
rsc_08bdd1
	bit #$1000
rsc_08bdd4
	beq rsc_08bdd9
rsc_08bdd6
	brl rsc_08bdfb
rsc_08bdd9
	bit #$0060
rsc_08bddc
	beq rsc_08bde1
rsc_08bdde
	brl rsc_08be75
rsc_08bde1
	lda.w race_callback
rsc_08bde4
	bit #$0800
rsc_08bde7
	beq rsc_08bdec
rsc_08bde9
	brl rsc_08bf3f
rsc_08bdec
	lda.l $700046,x
rsc_08bdf0
	bit #$0020
rsc_08bdf3
	beq rsc_08bdf8
rsc_08bdf5
	brl rsc_08bf3f
rsc_08bdf8
	jmp rsc_08bf53
rsc_08bdfb
	lda.l $70002e,x
rsc_08bdff
	bpl rsc_08be05
rsc_08be01
	eor #$ffff
rsc_08be04
	inc a
rsc_08be05
	sta.w race_scratch
rsc_08be08
	lda.l $700032,x
rsc_08be0c
	bpl rsc_08be12
rsc_08be0e
	eor #$ffff
rsc_08be11
	inc a
rsc_08be12
	clc
rsc_08be13
	adc.w race_scratch
rsc_08be16
	cmp #$0064
rsc_08be19
	bpl rsc_08be1e
rsc_08be1b
	brl rsc_08bf53
rsc_08be1e
	jsr rsc_emitmaterial
rsc_08be21
	bcs rsc_08be26
rsc_08be23
	brl rsc_08bf53
rsc_08be26
	a16
rsc_08be28
	lda #retail_snowtrail_l&WM
rsc_08be2b
	sta.w al_stratptr,y
rsc_08be2e
	a8
rsc_08be30
	lda #mrscene_begin>>16
rsc_08be32
	sta.w al_stratptr+2,y
rsc_08be35
	jmp rsc_08bf53
	longa
	longi
rsc_08be38
	lda.l $70002e,x
rsc_08be3c
	bpl rsc_08be42
rsc_08be3e
	eor #$ffff
rsc_08be41
	inc a
rsc_08be42
	sta.w race_scratch
rsc_08be45
	lda.l $700032,x
rsc_08be49
	bpl rsc_08be4f
rsc_08be4b
	eor #$ffff
rsc_08be4e
	inc a
rsc_08be4f
	clc
rsc_08be50
	adc.w race_scratch
rsc_08be53
	cmp #$0064
rsc_08be56
	bpl rsc_08be5b
rsc_08be58
	brl rsc_08bf53
rsc_08be5b
	jsr rsc_emitmaterial
rsc_08be5e
	bcs rsc_08be63
rsc_08be60
	brl rsc_08bf53
rsc_08be63
	a16
rsc_08be65
	lda #retail_watertrail_l&WM
rsc_08be68
	sta.w al_stratptr,y
rsc_08be6b
	a8
rsc_08be6d
	lda #mrscene_begin>>16
rsc_08be6f
	sta.w al_stratptr+2,y
rsc_08be72
	jmp rsc_08bf53
	longa
	longi
rsc_08be75
	lda.l $70002e,x
rsc_08be79
	bpl rsc_08be7f
rsc_08be7b
	eor #$ffff
rsc_08be7e
	inc a
rsc_08be7f
	sta.w race_scratch
rsc_08be82
	lda.l $700032,x
rsc_08be86
	bpl rsc_08be8c
rsc_08be88
	eor #$ffff
rsc_08be8b
	inc a
rsc_08be8c
	clc
rsc_08be8d
	adc.w race_scratch
rsc_08be90
	cmp #$0064
rsc_08be93
	bpl rsc_08be98
rsc_08be95
	brl rsc_08bf53
rsc_08be98
	jsr rsc_emitmaterial
rsc_08be9b
	bcs rsc_08bea0
rsc_08be9d
	brl rsc_08bf53
rsc_08bea0
	a16
rsc_08bea2
	lda #retail_graveltrail_l&WM
rsc_08bea5
	sta.w al_stratptr,y
rsc_08bea8
	a8
rsc_08beaa
	lda #mrscene_begin>>16
rsc_08beac
	sta.w al_stratptr+2,y
rsc_08beaf
	jmp rsc_08bf53
	longa
	longi
rsc_08beb2
	lda.l $70002e,x
rsc_08beb6
	bpl rsc_08bebc
rsc_08beb8
	eor #$ffff
rsc_08bebb
	inc a
rsc_08bebc
	sta.w race_scratch
rsc_08bebf
	lda.l $700032,x
rsc_08bec3
	bpl rsc_08bec9
rsc_08bec5
	eor #$ffff
rsc_08bec8
	inc a
rsc_08bec9
	clc
rsc_08beca
	adc.w race_scratch
rsc_08becd
	cmp #$0064
rsc_08bed0
	bpl rsc_08bed5
rsc_08bed2
	brl rsc_08bf53
rsc_08bed5
	jsr rsc_emitmaterial
rsc_08bed8
	bcs rsc_08bedd
rsc_08beda
	brl rsc_08bf53
rsc_08bedd
	a16
rsc_08bedf
	lda #retail_sandtrail_l&WM
rsc_08bee2
	sta.w al_stratptr,y
rsc_08bee5
	a8
rsc_08bee7
	lda #mrscene_begin>>16
rsc_08bee9
	sta.w al_stratptr+2,y
rsc_08beec
	jmp rsc_08bf53
	shorta
	longi
rsc_08beef
	jsr rsc_emitmaterial
rsc_08bef2
	bcc rsc_08bf53
rsc_08bef4
	a16
rsc_08bef6
	lda.l $70002e,x
rsc_08befa
	bpl rsc_08bf00
rsc_08befc
	eor #$ffff
rsc_08beff
	inc a
rsc_08bf00
	sta.w race_scratch
rsc_08bf03
	lda.l $700032,x
rsc_08bf07
	bpl rsc_08bf0d
rsc_08bf09
	eor #$ffff
rsc_08bf0c
	inc a
rsc_08bf0d
	clc
rsc_08bf0e
	adc.w race_scratch
rsc_08bf11
	cmp #$0064
rsc_08bf14
	bpl rsc_08bf19
rsc_08bf16
	brl rsc_08bf2c
rsc_08bf19
	a8
rsc_08bf1b
	a16
rsc_08bf1d
	lda #retail_speedtrail_l&WM
rsc_08bf20
	sta.w al_stratptr,y
rsc_08bf23
	a8
rsc_08bf25
	lda #mrscene_begin>>16
rsc_08bf27
	sta.w al_stratptr+2,y
rsc_08bf2a
	bra rsc_08bf53
rsc_08bf2c
	a8
rsc_08bf2e
	a16
rsc_08bf30
	lda #retail_slowtrail_l&WM
rsc_08bf33
	sta.w al_stratptr,y
rsc_08bf36
	a8
rsc_08bf38
	lda #mrscene_begin>>16
rsc_08bf3a
	sta.w al_stratptr+2,y
rsc_08bf3d
	bra rsc_08bf53
	shorta
	longi
rsc_08bf3f
	jsr rsc_emitmaterial
rsc_08bf42
	bcc rsc_08bf53
rsc_08bf44
	a16
rsc_08bf46
	lda #retail_sparktrail_l&WM
rsc_08bf49
	sta.w al_stratptr,y
rsc_08bf4c
	a8
rsc_08bf4e
	lda #mrscene_begin>>16
rsc_08bf50
	sta.w al_stratptr+2,y
rsc_08bf53
	ply
rsc_08bf54
	a16
rsc_08bf56
	lda.w al_collobjptr,y
rsc_08bf59
	tax
rsc_08bf5a
	lda.l $70001e,x
rsc_08bf5e
	clc
rsc_08bf5f
	adc.l $70004a,x
rsc_08bf63
	sta.w al_worldx,y
rsc_08bf66
	lda.w al_eyesize,y
rsc_08bf69
	and #$00ff
rsc_08bf6c
	eor #$ffff
rsc_08bf6f
	inc a
rsc_08bf70
	clc
rsc_08bf71
	adc #$ffec
rsc_08bf74
	clc
rsc_08bf75
	adc.l $700020,x
rsc_08bf79
	clc
rsc_08bf7a
	adc.l $70004c,x
rsc_08bf7e
	sta.w al_worldy,y
rsc_08bf81
	lda.l $700022,x
rsc_08bf85
	clc
rsc_08bf86
	adc.l $70004e,x
rsc_08bf8a
	sta.w al_worldz,y
rsc_08bf8d
	jsr rsc_wheelorientation
rsc_08bf90
	a8
rsc_08bf92
	plx
rsc_08bf93
	rts
rsc_wheelorientation
	a8
rsc_08bf96
	lda.l $700029,x
rsc_08bf9a
	sta.w al_rotz,y
rsc_08bf9d
	lda.l $700025,x
rsc_08bfa1
	sta.w al_roty,y
rsc_wheelview
	phx
rsc_08bfa5
	ldx #viewcamera1
rsc_08bfa8
	lda $11,x
rsc_08bfaa
	eor #$ff
rsc_08bfac
	inc a
rsc_08bfad
	sta.w race_visualangle
rsc_08bfb0
	lda $13,x
rsc_08bfb2
	sta.w race_scratch
rsc_08bfb5
	plx
rsc_08bfb6
	lda.w al_rotz,y
rsc_08bfb9
	clc
rsc_08bfba
	adc.w race_scratch
rsc_08bfbd
	cmp #$80
rsc_08bfbf
	ror a
rsc_08bfc0
	bpl rsc_08bfca
rsc_08bfc2
	eor #$ff
rsc_08bfc4
	inc a
rsc_08bfc5
	and #$fc
rsc_08bfc7
	eor #$ff
rsc_08bfc9
	inc a
rsc_08bfca
	and #$fc
rsc_08bfcc
	cmp #$08
rsc_08bfce
	bmi rsc_08bfd2
rsc_08bfd0
	lda #$08
rsc_08bfd2
	cmp #$f8
rsc_08bfd4
	bpl rsc_08bfd8
rsc_08bfd6
	lda #$f8
rsc_08bfd8
	sta.w race_animcount
rsc_08bfdb
	lda.w al_roty,y
rsc_08bfde
	sec
rsc_08bfdf
	sbc.w race_visualangle
rsc_08bfe2
	bpl rsc_08bfe7
rsc_08bfe4
	eor #$ff
rsc_08bfe6
	inc a
rsc_08bfe7
	cmp #$40
rsc_08bfe9
	bmi rsc_08bff4
rsc_08bfeb
	lda.w race_animcount
rsc_08bfee
	eor #$ff
rsc_08bff0
	inc a
rsc_08bff1
	sta.w race_animcount
rsc_08bff4
	a16
rsc_08bff6
	lda.w race_animcount
rsc_08bff9
	bit #$0080
rsc_08bffc
	beq rsc_08c003
rsc_08bffe
	ora #$ff00
rsc_08c001
	bra rsc_08c006
rsc_08c003
	and #$00ff
rsc_08c006
	clc
rsc_08c007
	adc #$0008
rsc_08c00a
	clc
rsc_08c00b
	adc.w al_sword2,y
rsc_08c00e
	sta.w al_coltab,y
rsc_08c011
	a8
rsc_08c013
	jsr rsc_wheelframe
rsc_08c016
	lda.w race_visualangle
rsc_08c019
	ora #$80
rsc_08c01b
	sta.w al_sflags3,y
rsc_08c01e
	lda.w racesound_playmode
rsc_08c021
	beq rsc_08c03b
rsc_08c023
	phx
rsc_08c024
	ldx #viewcamera2
rsc_08c027
	lda $11,x
rsc_08c029
	eor #$ff
rsc_08c02b
	inc a
rsc_08c02c
	sta.w race_visualangle
rsc_08c02f
	plx
rsc_08c030
	jsr rsc_wheelframe
rsc_08c033
	lda.w race_visualangle
rsc_08c036
	ora #$80
rsc_08c038
	sta.w al_sflags4,y
rsc_08c03b
	rts
rsc_wheelframe
	lda.w al_roty,y
rsc_08c03f
	sec
rsc_08c040
	sbc.w race_visualangle
rsc_08c043
	phy
rsc_08c044
	phx
rsc_08c045
	i8
rsc_08c047
	lsr a
rsc_08c048
	lsr a
rsc_08c049
	tax
rsc_08c04a
	lda.l retail_wheelframes,x
rsc_08c04e
	sta.w race_visualangle
rsc_08c051
	i16
rsc_08c053
	plx
rsc_08c054
	ply
rsc_08c055
	rts
	shorta
	longi
; US $08:CE02.
retail_publishbody_l
	jsl retail_updateactorcell_l
rsc_08ce06
	jsl retail_keeprawobject_l
rsc_08ce0a
	lda.w al_sflags,x
rsc_08ce0d
	and #$fd
rsc_08ce0f
	sta.w al_sflags,x
rsc_08ce12
	a16
rsc_08ce14
	txy
rsc_08ce15
	lda.w al_collobjptr,y
rsc_08ce18
	beq rsc_08ce69
rsc_08ce1a
	tax
rsc_08ce1b
	lda.l $700018,x
rsc_08ce1f
	sta.w race_contactnext
rsc_08ce22
	lda.w al_roty,y
rsc_08ce25
	and #$00ff
rsc_08ce28
	xba
rsc_08ce29
	sta.l $700024,x
rsc_08ce2d
	lda.w al_colframe,y
rsc_08ce30
	and #$007f
rsc_08ce33
	sta.l $700012,x
rsc_08ce37
	lda.l $70001e,x
rsc_08ce3b
	sta.w al_worldx,y
rsc_08ce3e
	lda.l $700020,x
rsc_08ce42
	sta.w al_worldy,y
rsc_08ce45
	lda.l $700022,x
rsc_08ce49
	sta.w al_worldz,y
rsc_08ce4c
	lda.l $70001c,x
rsc_08ce50
	tyx
rsc_08ce51
	and #$0002
rsc_08ce54
	a8
rsc_08ce56
	beq rsc_08ce60
rsc_08ce58
	lda.w al_sflags,x
rsc_08ce5b
	ora #$02
rsc_08ce5d
	sta.w al_sflags,x
rsc_08ce60
	ldy.w race_contactnext
rsc_08ce63
	beq rsc_08ce67
rsc_08ce65
	lda #$01
rsc_08ce67
	clc
rsc_08ce68
	rtl
rsc_08ce69
	a16
rsc_08ce6b
	lda #$0000
rsc_08ce6e
	sta.w race_contactnext
rsc_08ce71
	a8
rsc_08ce73
	a8
rsc_08ce75
	lda #$00
rsc_08ce77
	sec
rsc_08ce78
	rtl
retail_offsetbody_l
	jsl retail_updateactorcell_l
rsc_08ce7d
	jsl retail_keeprawobject_l
rsc_08ce81
	a16
rsc_08ce83
	txy
rsc_08ce84
	lda.w al_collobjptr,y
rsc_08ce87
	tax
rsc_08ce88
	lda.w al_roty,y
rsc_08ce8b
	and #$00ff
rsc_08ce8e
	xba
rsc_08ce8f
	sta.l $700024,x
rsc_08ce93
	lda.w al_colframe,y
rsc_08ce96
	and #$007f
rsc_08ce99
	sta.l $700012,x
rsc_08ce9d
	lda.l $700018,x
rsc_08cea1
	sta.w race_contactnext
rsc_08cea4
	lda.l $70001e,x
rsc_08cea8
	sta.w al_worldx,y
rsc_08ceab
	lda.l $700020,x
rsc_08ceaf
	clc
rsc_08ceb0
	adc.w al_vy,y
rsc_08ceb3
	sta.w al_worldy,y
rsc_08ceb6
	lda.l $700022,x
rsc_08ceba
	sta.w al_worldz,y
rsc_08cebd
	tyx
rsc_08cebe
	a8
rsc_08cec0
	jmp rsc_08ce60
retail_pinbody_l
	jsl retail_updateactorcell_l
rsc_08cec7
	jsl retail_keeprawobject_l
rsc_08cecb
	a16
rsc_08cecd
	txy
rsc_08cece
	lda.w al_collobjptr,y
rsc_08ced1
	beq rsc_08ce69
rsc_08ced3
	tax
rsc_08ced4
	lda.w al_roty,y
rsc_08ced7
	and #$00ff
rsc_08ceda
	xba
rsc_08cedb
	sta.l $700024,x
rsc_08cedf
	lda.w al_colframe,y
rsc_08cee2
	and #$007f
rsc_08cee5
	sta.l $700012,x
rsc_08cee9
	lda.l $700018,x
rsc_08ceed
	sta.w race_contactnext
rsc_08cef0
	lda.w al_worldx,y
rsc_08cef3
	sta.l $70001e,x
rsc_08cef7
	lda.w al_worldy,y
rsc_08cefa
	sta.l $700020,x
rsc_08cefe
	lda.w al_worldz,y
rsc_08cf01
	sta.l $700022,x
rsc_08cf05
	tyx
rsc_08cf06
	a8
rsc_08cf08
	jmp rsc_08ce60
retail_bodycontacthead_l
	jsl retail_updateactorcell_l
rsc_08cf0f
	jsl retail_keeprawobject_l
rsc_08cf13
	a16
rsc_08cf15
	txy
rsc_08cf16
	lda.w al_collobjptr,y
rsc_08cf19
	bne rsc_08cf1e
rsc_08cf1b
	brl rsc_08ce69
rsc_08cf1e
	tax
rsc_08cf1f
	lda.w al_roty,y
rsc_08cf22
	and #$00ff
rsc_08cf25
	xba
rsc_08cf26
	sta.l $700024,x
rsc_08cf2a
	lda.w al_colframe,y
rsc_08cf2d
	and #$007f
rsc_08cf30
	sta.l $700012,x
rsc_08cf34
	lda.l $700018,x
rsc_08cf38
	sta.w race_contactnext
rsc_08cf3b
	tyx
rsc_08cf3c
	a8
rsc_08cf3e
	jmp rsc_08ce60
	shorta
	longi
; US $08:D14A.
rsc_emittrail
	lda.w racesound_playmode
rsc_08d14d
	bne rsc_08d180
rsc_08d14f
	a16
rsc_08d151
	lda #$a158
rsc_08d154
	sta.w race_scratch
rsc_08d157
	a8
rsc_08d159
	jsl retail_makeactor_l
rsc_08d15d
	bcs rsc_08d163
rsc_08d15f
	jml rsc_08d180
rsc_08d163
	a16
rsc_08d165
	lda #retail_dusttrail_l&WM
rsc_08d168
	sta.w al_stratptr,y
rsc_08d16b
	a8
rsc_08d16d
	lda #mrscene_begin>>16
rsc_08d16f
	sta.w al_stratptr+2,y
rsc_08d172
	jsl retail_copyactorpos_l
rsc_08d176
	pha
rsc_08d177
	a16
rsc_08d179
	txa
rsc_08d17a
	sta.w al_sword1,y
rsc_08d17d
	a8
rsc_08d17f
	pla
rsc_08d180
	rts
rsc_emitdust
	jsl retail_random_l
rsc_08d185
	cmp #$b2
rsc_08d187
	bcs rsc_08d18d
rsc_08d189
	jml rsc_08d1be
rsc_08d18d
	a16
rsc_08d18f
	lda #$a158
rsc_08d192
	sta.w race_scratch
rsc_08d195
	a8
rsc_08d197
	jsl retail_makeactor_l
rsc_08d19b
	bcs rsc_08d1a1
rsc_08d19d
	jml rsc_08d1be
rsc_08d1a1
	a16
rsc_08d1a3
	lda #retail_dusttrail_l&WM
rsc_08d1a6
	sta.w al_stratptr,y
rsc_08d1a9
	a8
rsc_08d1ab
	lda #mrscene_begin>>16
rsc_08d1ad
	sta.w al_stratptr+2,y
rsc_08d1b0
	jsl retail_copyactorpos_l
rsc_08d1b4
	pha
rsc_08d1b5
	a16
rsc_08d1b7
	txa
rsc_08d1b8
	sta.w al_sword1,y
rsc_08d1bb
	a8
rsc_08d1bd
	pla
rsc_08d1be
	rts
rsc_emitmaterial
	a8
rsc_08d1c1
	phx
rsc_08d1c2
	tyx
rsc_08d1c3
	jsl retail_random_l
rsc_08d1c7
	cmp #$7f
rsc_08d1c9
	bcs rsc_08d1cf
rsc_08d1cb
	jml rsc_08d1f4
rsc_08d1cf
	a16
rsc_08d1d1
	lda #$a1ac
rsc_08d1d4
	sta.w race_scratch
rsc_08d1d7
	a8
rsc_08d1d9
	jsl retail_makeactor_l
rsc_08d1dd
	bcs rsc_08d1e3
rsc_08d1df
	jml rsc_08d1f4
rsc_08d1e3
	jsl retail_copyactorpos_l
rsc_08d1e7
	a16
rsc_08d1e9
	lda.w al_ptr,x
rsc_08d1ec
	sta.w al_sword1,y
rsc_08d1ef
	a8
rsc_08d1f1
	plx
rsc_08d1f2
	sec
rsc_08d1f3
	rts
rsc_08d1f4
	plx
rsc_08d1f5
	clc
rsc_08d1f6
	rts
retail_snowtrail_l
	a16
rsc_08d1f9
	lda #$998d
rsc_08d1fc
	sta.w al_coltab,x
rsc_08d1ff
	a8
rsc_08d201
	lda.w al_sflags,x
rsc_08d204
	ora #$08
rsc_08d206
	sta.w al_sflags,x
rsc_08d209
	lda #$00
rsc_08d20b
	sta.w al_lapcnt,x
rsc_08d20e
	lda #$14
rsc_08d210
	sta.w al_eyesize,x
rsc_08d213
	jsr rsc_trailjitter
rsc_08d216
	a16
rsc_08d218
	lda.w al_worldy,x
rsc_08d21b
	clc
rsc_08d21c
	adc #$0028
rsc_08d21f
	sta.w al_worldy,x
rsc_08d222
	a8
rsc_08d224
	a16
rsc_08d226
	lda #retail_trail_step&WM
rsc_08d229
	sta.w al_stratptr,x
rsc_08d22c
	a8
rsc_08d22e
	lda #mrscene_begin>>16
rsc_08d230
	sta.w al_stratptr+2,x
rsc_08d233
	lda #$00
rsc_08d235
	sta.w al_sbyte1,x
rsc_08d238
	lda.w al_sflags2,x
rsc_08d23b
	ora #$01
rsc_08d23d
	sta.w al_sflags2,x
rsc_08d240
	lda #$04
rsc_08d242
	sta.w al_sbyte2,x
rsc_08d245
	jml retail_trail_step
retail_watertrail_l
	a16
rsc_08d24b
	lda #$9b96
rsc_08d24e
	sta.w al_coltab,x
rsc_08d251
	a8
rsc_08d253
	lda.w al_sflags,x
rsc_08d256
	ora #$08
rsc_08d258
	sta.w al_sflags,x
rsc_08d25b
	lda #$00
rsc_08d25d
	sta.w al_lapcnt,x
rsc_08d260
	lda #$14
rsc_08d262
	sta.w al_eyesize,x
rsc_08d265
	jsr rsc_trailvelocity
rsc_08d268
	a16
rsc_08d26a
	lda.w al_worldy,x
rsc_08d26d
	clc
rsc_08d26e
	adc #$0028
rsc_08d271
	sta.w al_worldy,x
rsc_08d274
	a8
rsc_08d276
	a16
rsc_08d278
	lda #retail_trail_step&WM
rsc_08d27b
	sta.w al_stratptr,x
rsc_08d27e
	a8
rsc_08d280
	lda #mrscene_begin>>16
rsc_08d282
	sta.w al_stratptr+2,x
rsc_08d285
	lda #$00
rsc_08d287
	sta.w al_sbyte1,x
rsc_08d28a
	lda.w al_sflags2,x
rsc_08d28d
	ora #$01
rsc_08d28f
	sta.w al_sflags2,x
rsc_08d292
	lda #$03
rsc_08d294
	sta.w al_sbyte2,x
rsc_08d297
	jml retail_trail_step
	shorta
	longi
retail_mudtrail_l
	a16
rsc_08d29d
	lda #$9b9f
rsc_08d2a0
	sta.w al_coltab,x
rsc_08d2a3
	a8
rsc_08d2a5
	jsr rsc_splittrail
rsc_08d2a8
	lda.w al_sflags,x
rsc_08d2ab
	ora #$08
rsc_08d2ad
	sta.w al_sflags,x
rsc_08d2b0
	lda #$00
rsc_08d2b2
	sta.w al_lapcnt,x
rsc_08d2b5
	lda #$14
rsc_08d2b7
	sta.w al_eyesize,x
rsc_08d2ba
	jsr rsc_trailvelocity
rsc_08d2bd
	a16
rsc_08d2bf
	lda.w al_worldy,x
rsc_08d2c2
	clc
rsc_08d2c3
	adc #$0028
rsc_08d2c6
	sta.w al_worldy,x
rsc_08d2c9
	a8
rsc_08d2cb
	jml rsc_trailinit
	shorta
	longi
retail_sandtrail_l
	a16
rsc_08d2d1
	lda #$9b8f
rsc_08d2d4
	sta.w al_coltab,x
rsc_08d2d7
	a8
rsc_08d2d9
	jsr rsc_splittrail
rsc_08d2dc
	lda.w al_sflags,x
rsc_08d2df
	ora #$08
rsc_08d2e1
	sta.w al_sflags,x
rsc_08d2e4
	lda #$00
rsc_08d2e6
	sta.w al_lapcnt,x
rsc_08d2e9
	lda #$14
rsc_08d2eb
	sta.w al_eyesize,x
rsc_08d2ee
	jsr rsc_trailvelocity
rsc_08d2f1
	a16
rsc_08d2f3
	lda.w al_worldy,x
rsc_08d2f6
	clc
rsc_08d2f7
	adc #$0028
rsc_08d2fa
	sta.w al_worldy,x
rsc_08d2fd
	a8
rsc_08d2ff
	jml rsc_trailinit
	shorta
	longi
retail_slowtrail_l
	a16
rsc_08d305
	lda #$9b79
rsc_08d308
	sta.w al_coltab,x
rsc_08d30b
	a8
rsc_08d30d
	jsr rsc_splittrail
rsc_08d310
	lda.w al_sflags,x
rsc_08d313
	ora #$08
rsc_08d315
	sta.w al_sflags,x
rsc_08d318
	lda #$00
rsc_08d31a
	sta.w al_lapcnt,x
rsc_08d31d
	lda #$14
rsc_08d31f
	sta.w al_eyesize,x
rsc_08d322
	jsr rsc_trailvelocity
rsc_08d325
	a16
rsc_08d327
	lda.w al_worldy,x
rsc_08d32a
	clc
rsc_08d32b
	adc #$0028
rsc_08d32e
	sta.w al_worldy,x
rsc_08d331
	a8
rsc_08d333
	jml rsc_trailinit
	shorta
	longi
retail_wheelburst_l
	lda #$6e
rsc_08d339
	sta.w race_animcount
rsc_08d33c
	jmp rsc_08d36d
	shorta
	longi
retail_speedtrail_l
	a16
rsc_08d341
	phx
rsc_08d342
	lda.w al_sword1,x
rsc_08d345
	tax
rsc_08d346
	lda.w al_collobjptr,x
rsc_08d349
	tax
rsc_08d34a
	lda.l $70004a,x
rsc_08d34e
	bpl rsc_08d354
rsc_08d350
	eor #$ffff
rsc_08d353
	inc a
rsc_08d354
	cmp #$8000
rsc_08d357
	ror a
rsc_08d358
	clc
rsc_08d359
	adc #$0014
rsc_08d35c
	cmp #$0078
rsc_08d35f
	bmi rsc_08d364
rsc_08d361
	lda #$0078
rsc_08d364
	a8
rsc_08d366
	sta.w race_animcount
rsc_08d369
	plx
rsc_08d36a
	jsr rsc_trailvelocity
rsc_08d36d
	a16
rsc_08d36f
	lda #$9b63
rsc_08d372
	sta.w al_coltab,x
rsc_08d375
	a8
rsc_08d377
	jsr rsc_splittrail
rsc_08d37a
	lda.w al_sflags,x
rsc_08d37d
	ora #$08
rsc_08d37f
	sta.w al_sflags,x
rsc_08d382
	lda #$00
rsc_08d384
	sta.w al_lapcnt,x
rsc_08d387
	lda.w race_animcount
rsc_08d38a
	sta.w al_eyesize,x
rsc_08d38d
	a16
rsc_08d38f
	lda.w al_worldy,x
rsc_08d392
	clc
rsc_08d393
	adc #$0028
rsc_08d396
	sta.w al_worldy,x
rsc_08d399
	a8
rsc_08d39b
	jml rsc_trailinit
	shorta
	longi
retail_graveltrail_l
	a16
rsc_08d3a1
	lda #$9b56
rsc_08d3a4
	sta.w al_coltab,x
rsc_08d3a7
	a8
rsc_08d3a9
	jsr rsc_splittrail
rsc_08d3ac
	lda.w al_sflags,x
rsc_08d3af
	ora #$08
rsc_08d3b1
	sta.w al_sflags,x
rsc_08d3b4
	lda #$00
rsc_08d3b6
	sta.w al_lapcnt,x
rsc_08d3b9
	lda #$14
rsc_08d3bb
	sta.w al_eyesize,x
rsc_08d3be
	a16
rsc_08d3c0
	lda.w al_worldy,x
rsc_08d3c3
	clc
rsc_08d3c4
	adc #$0028
rsc_08d3c7
	sta.w al_worldy,x
rsc_08d3ca
	a8
rsc_08d3cc
	jsr rsc_trailjitter
rsc_08d3cf
	jml rsc_trailinit
	shorta
	longi
retail_sparktrail_l
	a16
rsc_08d3d5
	lda #$9b40
rsc_08d3d8
	sta.w al_coltab,x
rsc_08d3db
	a8
rsc_08d3dd
	jsr rsc_splittrail
rsc_08d3e0
	lda.w al_sflags,x
rsc_08d3e3
	ora #$08
rsc_08d3e5
	sta.w al_sflags,x
rsc_08d3e8
	lda #$00
rsc_08d3ea
	sta.w al_lapcnt,x
rsc_08d3ed
	lda #$0a
rsc_08d3ef
	sta.w al_eyesize,x
rsc_08d3f2
	a16
rsc_08d3f4
	lda.w al_worldy,x
rsc_08d3f7
	clc
rsc_08d3f8
	adc #$0028
rsc_08d3fb
	sta.w al_worldy,x
rsc_08d3fe
	a8
rsc_08d400
	jsr rsc_trailjitter
rsc_trailinit
	a16
rsc_08d405
	lda #retail_trail_step&WM
rsc_08d408
	sta.w al_stratptr,x
rsc_08d40b
	a8
rsc_08d40d
	lda #mrscene_begin>>16
rsc_08d40f
	sta.w al_stratptr+2,x
rsc_08d412
	lda #$00
rsc_08d414
	sta.w al_sbyte1,x
rsc_08d417
	lda.w al_sflags2,x
rsc_08d41a
	ora #$01
rsc_08d41c
	sta.w al_sflags2,x
rsc_08d41f
	lda #$04
rsc_08d421
	sta.w al_sbyte2,x
rsc_08d424
	jml retail_trail_step
	shorta
	longi
retail_smalltrail_l
	a16
rsc_08d42a
	lda #retail_trail_step&WM
rsc_08d42d
	sta.w al_stratptr,x
rsc_08d430
	a8
rsc_08d432
	lda #mrscene_begin>>16
rsc_08d434
	sta.w al_stratptr+2,x
rsc_08d437
	lda #$00
rsc_08d439
	sta.w al_sbyte1,x
rsc_08d43c
	lda #$06
rsc_08d43e
	sta.w al_sbyte2,x
rsc_08d441
	a16
rsc_08d443
	lda #$997c
rsc_08d446
	sta.w al_coltab,x
rsc_08d449
	a8
rsc_08d44b
	lda.w al_sflags,x
rsc_08d44e
	ora #$08
rsc_08d450
	sta.w al_sflags,x
rsc_08d453
	lda #$00
rsc_08d455
	sta.w al_lapcnt,x
rsc_08d458
	lda #$0a
rsc_08d45a
	sta.w al_eyesize,x
rsc_08d45d
	jmp retail_trail_step
	shorta
	longi
retail_dusttrail_l
	a16
rsc_08d462
	lda #retail_trail_step&WM
rsc_08d465
	sta.w al_stratptr,x
rsc_08d468
	a8
rsc_08d46a
	lda #mrscene_begin>>16
rsc_08d46c
	sta.w al_stratptr+2,x
rsc_08d46f
	lda #$00
rsc_08d471
	sta.w al_sbyte1,x
rsc_08d474
	lda #$06
rsc_08d476
	sta.w al_sbyte2,x
rsc_08d479
	jsl retail_random_l
rsc_08d47d
	and #$0f
rsc_08d47f
	sta.w race_callback
rsc_08d482
	a16
rsc_08d484
	lda.w race_callback
rsc_08d487
	clc
rsc_08d488
	adc #$ffd8
rsc_08d48b
	sta.w race_callback
rsc_08d48e
	a8
rsc_08d490
	a16
rsc_08d492
	lda #$997c
rsc_08d495
	sta.w al_coltab,x
rsc_08d498
	a8
rsc_08d49a
	lda.w al_sflags,x
rsc_08d49d
	ora #$08
rsc_08d49f
	sta.w al_sflags,x
rsc_08d4a2
	lda #$00
rsc_08d4a4
	sta.w al_lapcnt,x
rsc_08d4a7
	lda #$0a
rsc_08d4a9
	sta.w al_eyesize,x
rsc_08d4ac
	ldy.w al_sword1,x
rsc_08d4af
	lda #$00
rsc_08d4b1
	sta x1
rsc_08d4b3
	sta x2
rsc_08d4b5
	bit #$80
rsc_08d4b7
	beq rsc_08d4bf
rsc_08d4b9
	lda #$ff
rsc_08d4bb
	sta x2+1
rsc_08d4bd
	bra rsc_08d4c1
rsc_08d4bf
	stz x2+1
rsc_08d4c1
	lda #$00
rsc_08d4c3
	sta y1
rsc_08d4c5
	sta y2
rsc_08d4c7
	bit #$80
rsc_08d4c9
	beq rsc_08d4d1
rsc_08d4cb
	lda #$ff
rsc_08d4cd
	sta y2+1
rsc_08d4cf
	bra rsc_08d4d3
rsc_08d4d1
	stz y2+1
rsc_08d4d3
	lda.w race_callback
rsc_08d4d6
	sta z1
rsc_08d4d8
	sta.w z2
rsc_08d4db
	bit #$80
rsc_08d4dd
	beq rsc_08d4e6
rsc_08d4df
	lda #$ff
rsc_08d4e1
	sta.w z2+1
rsc_08d4e4
	bra rsc_08d4e9
rsc_08d4e6
	stz.w z2+1
rsc_08d4e9
	lda.w al_rotx,y
rsc_08d4ec
	jsl retail_actorrotx_l
rsc_08d4f0
	lda x2
rsc_08d4f2
	sta x1
rsc_08d4f4
	lda y2
rsc_08d4f6
	sta y1
rsc_08d4f8
	lda.w z2
rsc_08d4fb
	sta z1
rsc_08d4fd
	lda.w al_roty,y
rsc_08d500
	jsl retail_actorroty_l
rsc_08d504
	a16
rsc_08d506
	lda x2
rsc_08d508
	asl a
rsc_08d509
	sta x2
rsc_08d50b
	lda y2
rsc_08d50d
	asl a
rsc_08d50e
	sta y2
rsc_08d510
	lda.w z2
rsc_08d513
	asl a
rsc_08d514
	sta.w z2
rsc_08d517
	lda.w al_worldx,x
rsc_08d51a
	clc
rsc_08d51b
	adc x2
rsc_08d51d
	sta.w al_worldx,x
rsc_08d520
	lda.w al_worldz,x
rsc_08d523
	clc
rsc_08d524
	adc.w z2
rsc_08d527
	sta.w al_worldz,x
rsc_08d52a
	lda.w al_worldy,x
rsc_08d52d
	clc
rsc_08d52e
	adc y2
rsc_08d530
	sta.w al_worldy,x
rsc_08d533
	a8
rsc_08d535
	jsr rsc_trailjitter
rsc_08d538
	a16
rsc_08d53a
	lda.w al_vy,x
rsc_08d53d
	clc
rsc_08d53e
	adc #$ffec
rsc_08d541
	sta.w al_vy,x
rsc_08d544
	a8
rsc_08d546
	jsr rsc_splittrail
retail_trail_step
	jsl retail_updateactorcell_l
rsc_08d54d
	lda.w al_sbyte1,x
rsc_08d550
	sta.w race_animcount
rsc_08d553
	lda.w race_animcount
rsc_08d556
	ora #$80
rsc_08d558
	sta.w al_sflags3,x
rsc_08d55b
	lda.w al_sflags3,x
rsc_08d55e
	sta.w al_sflags4,x
rsc_08d561
	lda.w al_sbyte2,x
rsc_08d564
	sta.w race_animcount+1
rsc_08d567
	lda.w al_sbyte1,x
rsc_08d56a
	cmp.w race_animcount+1
rsc_08d56d
	bne rsc_08d573
rsc_08d56f
	jml retail_endactor_l
rsc_08d573
	inc.w al_sbyte1,x
rsc_08d576
	jsl retail_moveactor_l
rsc_08d57a
	lda #$03
rsc_08d57c
	sta.w al_sbyte4,x
rsc_08d57f
	rtl
	shorta
	longi
; US $08:D5AB.
rsc_trailvelocity
	ldy.w al_sword1,x
rsc_08d5ae
	a16
rsc_08d5b0
	lda.w al_collobjptr,y
rsc_08d5b3
	txy
rsc_08d5b4
	tax
rsc_08d5b5
	lda.l $70002e,x
rsc_08d5b9
	cmp #$8000
rsc_08d5bc
	ror a
rsc_08d5bd
	cmp #$8000
rsc_08d5c0
	ror a
rsc_08d5c1
	cmp #$8000
rsc_08d5c4
	ror a
rsc_08d5c5
	sta.w al_vx,y
rsc_08d5c8
	lda.l $700032,x
rsc_08d5cc
	cmp #$8000
rsc_08d5cf
	ror a
rsc_08d5d0
	cmp #$8000
rsc_08d5d3
	ror a
rsc_08d5d4
	cmp #$8000
rsc_08d5d7
	ror a
rsc_08d5d8
	sta.w al_vz,y
rsc_08d5db
	tyx
rsc_08d5dc
	a8
rsc_08d5de
	rts
	shorta
	longi
rsc_trailjitter
	ldy.w al_sword1,x
rsc_08d5e2
	a16
rsc_08d5e4
	lda.w al_collobjptr,y
rsc_08d5e7
	txy
rsc_08d5e8
	tax
rsc_08d5e9
	lda.l $70002e,x
rsc_08d5ed
	cmp #$8000
rsc_08d5f0
	ror a
rsc_08d5f1
	cmp #$8000
rsc_08d5f4
	ror a
rsc_08d5f5
	cmp #$8000
rsc_08d5f8
	ror a
rsc_08d5f9
	jsl retail_scaleactorvelocity_l
rsc_08d5fd
	sta.w al_vx,y
rsc_08d600
	lda.l $700032,x
rsc_08d604
	cmp #$8000
rsc_08d607
	ror a
rsc_08d608
	cmp #$8000
rsc_08d60b
	ror a
rsc_08d60c
	cmp #$8000
rsc_08d60f
	ror a
rsc_08d610
	jsl retail_scaleactorvelocity_l
rsc_08d614
	sta.w al_vz,y
rsc_08d617
	tyx
rsc_08d618
	a8
rsc_08d61a
	rts
	shorta
	longi
; US $08:D83D.
retail_actorvelocity_l
	a16
rsc_08d83f
	lda.w al_collobjptr,x
rsc_08d842
	beq rsc_08d86a
rsc_08d844
	txy
rsc_08d845
	tax
rsc_08d846
	lda.w al_vx,y
rsc_08d849
	asl a
rsc_08d84a
	asl a
rsc_08d84b
	asl a
rsc_08d84c
	sta.l $70002e,x
rsc_08d850
	lda.w al_vy,y
rsc_08d853
	asl a
rsc_08d854
	asl a
rsc_08d855
	asl a
rsc_08d856
	sta.l $700030,x
rsc_08d85a
	lda.w al_vz,y
rsc_08d85d
	asl a
rsc_08d85e
	asl a
rsc_08d85f
	asl a
rsc_08d860
	sta.l $700032,x
rsc_08d864
	tyx
rsc_08d865
	a8
rsc_08d867
	lda #$00
rsc_08d869
	rtl
rsc_08d86a
	a8
rsc_08d86c
	lda #$ff
rsc_08d86e
	rtl
	shorta
	longi
; US $08:DC6D.
retail_copyrawvelocity_l
	phx
rsc_08dc6e
	phy
rsc_08dc6f
	a16
rsc_08dc71
	lda.w al_collobjptr,y
rsc_08dc74
	txy
rsc_08dc75
	tax
rsc_08dc76
	lda.l $70002e,x
rsc_08dc7a
	cmp #$8000
rsc_08dc7d
	ror a
rsc_08dc7e
	cmp #$8000
rsc_08dc81
	ror a
rsc_08dc82
	cmp #$8000
rsc_08dc85
	ror a
rsc_08dc86
	sta.w al_vx,y
rsc_08dc89
	lda.l $700030,x
rsc_08dc8d
	cmp #$8000
rsc_08dc90
	ror a
rsc_08dc91
	cmp #$8000
rsc_08dc94
	ror a
rsc_08dc95
	cmp #$8000
rsc_08dc98
	ror a
rsc_08dc99
	sta.w al_vy,y
rsc_08dc9c
	lda.l $700032,x
rsc_08dca0
	cmp #$8000
rsc_08dca3
	ror a
rsc_08dca4
	cmp #$8000
rsc_08dca7
	ror a
rsc_08dca8
	cmp #$8000
rsc_08dcab
	ror a
rsc_08dcac
	sta.w al_vz,y
rsc_08dcaf
	a8
rsc_08dcb1
	ply
rsc_08dcb2
	plx
rsc_08dcb3
	rtl
	shorta
	longi
; US $08:DD8D.
retail_shadowactor_l
	a16
rsc_08dd8f
	lda #retail_shadowactor_step&WM
rsc_08dd92
	sta.w al_stratptr,x
rsc_08dd95
	a8
rsc_08dd97
	lda #mrscene_begin>>16
rsc_08dd99
	sta.w al_stratptr+2,x
rsc_08dd9c
	a16
rsc_08dd9e
	lda.w al_vy,x
rsc_08dda1
	bit #$0080
rsc_08dda4
	beq rsc_08ddab
rsc_08dda6
	ora #$ff00
rsc_08dda9
	bra rsc_08ddae
rsc_08ddab
	and #$00ff
rsc_08ddae
	asl a
rsc_08ddaf
	sta.w al_vy,x
rsc_08ddb2
	a8
retail_shadowactor_step
	ldy.w al_ptr,x
rsc_08ddb7
	lda.w al_sflags,y
rsc_08ddba
	and #$08
rsc_08ddbc
	beq rsc_08ddc2
rsc_08ddbe
	jml retail_hideactor_l
rsc_08ddc2
	lda.w al_sflags2,y
rsc_08ddc5
	and #$04
rsc_08ddc7
	beq rsc_08ddcd
rsc_08ddc9
	jml retail_hideactor_l
rsc_08ddcd
	phx
rsc_08ddce
	a16
rsc_08ddd0
	lda.w al_collobjptr,y
rsc_08ddd3
	txy
rsc_08ddd4
	tax
rsc_08ddd5
	lda.l $70001c,x
rsc_08ddd9
	and #$0010
rsc_08dddc
	beq rsc_08dde4
rsc_08ddde
	a8
rsc_08dde0
	plx
rsc_08dde1
	jmp retail_hideactor_l
rsc_08dde4
	lda.l $70001e,x
rsc_08dde8
	sta.w al_worldx,y
rsc_08ddeb
	lda.l $700022,x
rsc_08ddef
	sta.w al_worldz,y
rsc_08ddf2
	lda.l $700060,x
rsc_08ddf6
	sta.w al_worldy,y
rsc_08ddf9
	a8
rsc_08ddfb
	lda.l $700027,x
rsc_08ddff
	sta.w al_rotx,y
rsc_08de02
	lda.l $700025,x
rsc_08de06
	sta.w al_roty,y
rsc_08de09
	plx
rsc_08de0a
	jsl retail_moveactor_l
rsc_08de0e
	jsl retail_updateactorcell_l
rsc_08de12
	lda.w al_sflags,x
rsc_08de15
	and #$df
rsc_08de17
	sta.w al_sflags,x
rsc_08de1a
	lda.w al_sflags,x
rsc_08de1d
	and #$bf
rsc_08de1f
	sta.w al_sflags,x
rsc_08de22
	ldy.w al_ptr,x
rsc_08de25
	lda.w al_sflags,y
rsc_08de28
	and #$40
rsc_08de2a
	beq rsc_08de30
rsc_08de2c
	jml retail_flagactor_l
rsc_08de30
	rtl
	shorta
	longi
; US $08:E13C.
retail_hideactor_l
	lda.w al_sflags,x
rsc_08e13f
	ora #$20
rsc_08e141
	sta.w al_sflags,x
rsc_08e144
	lda #$03
rsc_08e146
	sta.w al_sbyte4,x
rsc_08e149
	rtl
retail_flagactor_l
	lda.w al_sflags,x
rsc_08e14d
	ora #$40
rsc_08e14f
	sta.w al_sflags,x
rsc_08e152
	lda #$03
rsc_08e154
	sta.w al_sbyte4,x
rsc_08e157
	rtl
	shorta
	longi
; US $08:F911.
rsc_splittrail
	a8
rsc_08f913
	lda.w racesound_playmode
rsc_08f916
	beq rsc_08f926
rsc_08f918
	a16
rsc_08f91a
	lda.w al_coltab,x
rsc_08f91d
	clc
rsc_08f91e
	adc #$0002
rsc_08f921
	sta.w al_coltab,x
rsc_08f924
	a8
rsc_08f926
	rts
retail_endactor_l
	a8
rsc_08f929
	jsl retail_retireactor_l
rsc_08f92d
	rtl
	shorta
	longi
retail_wheelframes
	db $0f,$0e,$0d,$0c,$0b,$0a,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00
	db $1f,$1e,$1d,$1c,$1b,$1a,$19,$18,$17,$16,$15,$14,$13,$12,$11,$10
	db $0f,$0e,$0d,$0c,$0b,$0a,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00
	db $1f,$1e,$1d,$1c,$1b,$1a,$19,$18,$17,$16,$15,$14,$13,$12,$11,$10
; Retail visual descriptors: shape, sprite, height/control and callback.
; Callback triples are rebound to reconstructed source strategies.
; Shape and sprite words still require the caller's retail asset binding.
retail_visualdefs
	dw $a040,$0000
	db $00,$00
	dl $000000
	dw $a740,$0000
	db $00,$00
	dl retail_fourattachments_l
	dw $a75c,$0000
	db $00,$00
	dl retail_pairedcar_l
	dw $a1c8,$9bbf
	db $05,$00
	dl $000000
	dw $a1c8,$9bbf
	db $0a,$00
	dl $000000
	dw $a1c8,$9bbf
	db $1e,$00
	dl $000000
	dw $a1c8,$9bbf
	db $3c,$00
	dl $000000
	dw $a1c8,$9bbf
	db $6e,$00
	dl $000000
	dw $a1e4,$9bbf
	db $6e,$00
	dl $000000
	dw $a270,$0000
	db $00,$00
	dl retail_shadowactor_l
	dw $a254,$0000
	db $00,$00
	dl retail_shadowactor_l
	dw $a8e4,$0000
	db $00,$00
	dl retail_shadowactor_l
	dw $a238,$0000
	db $00,$00
	dl retail_shadowactor_l
	dw $a190,$9aaf
	db $05,$00
	dl retail_eyeactor_l
	dw $a190,$9aaf
	db $05,$00
	dl retail_fixedeye_l
	dw $a158,$995e
	db $e1,$ff
	dl retail_carindicator_l

; Empty-list scene boundary only. CPU pool storage and list heads are
; supplied by the original allocator setup; no heap or actor is freed here.
retail_initscene_l
 php
 phx
 a16
 stz race_actorcurrent
 stz race_protectedactor
 stz race_removerequest
 lda #0
 ldx #2046
.clear
 sta.l race_cellheads,x
 dex
 dex
 bpl .clear
 a8
 plx
 plp
 rtl

; X=owner, A16=shadow descriptor ($51/$5A/$63/$6C), I16, DB=$7E.
; race_attachx/y/z supply signed bytes in their low bytes. This explicit
; shadow factory leaves other auxiliary descriptor/strategy families separate.
; Return C set/Y=actor or C clear/Y=zero. X and original owner are retained.
 longa
retail_makeshadow_l
 cmp #$0051
 beq .valid
 cmp #$005a
 beq .valid
 cmp #$0063
 beq .valid
 cmp #$006c
 bne .fail16
.valid
 sta race_shadowkind
 a8
 jsl retail_makeactor_l
 bcc .fail
 a16
 phx
 lda race_shadowkind
 tax
 lda.l retail_visualdefs,x
 sta.w al_shape,y
 plx
 txa
 sta.w al_ptr,y
 lda #retail_shadowactor_l&WM
 sta.w al_stratptr,y
 a8
 lda #retail_shadowactor_l>>16
 sta.w al_stratptr+2,y
 a16
 lda race_attachx
 and #$00ff
 bit #$0080
 beq .xpos
 ora #$ff00
.xpos
 sta.w al_vx,y
 lda race_attachy
 and #$00ff
 bit #$0080
 beq .ypos
 ora #$ff00
.ypos
 sta.w al_vy,y
 lda race_attachz
 and #$00ff
 bit #$0080
 beq .zpos
 ora #$ff00
.zpos
 sta.w al_vz,y
 a8
 sec
 rtl
.fail16
 a8
 ldy #0
.fail
 clc
 rtl

; Standalone pose/orientation wrapper; the wheel strategy also invokes
; the native material-response and detachment paths before this stage.
retail_wheelpose_l
 jsr .pose
 rtl
.pose
 phx
 txy
 jmp rsc_08bf54

retail_scene_return
 rtl
mrscene_end
