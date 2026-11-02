; Retail material selection and projected-face visibility.
; Material input: R0=index, R2=normal/face cursor, R11=return; RAM bank 0.
; Colour/animation/shade records live in ROM bank 3. Texture indices 0..199
; and coordinate records 0..16 must be caller-bound to pixel payloads.
; Native animation offsets use 13 bits and frame masks, not modulo.
; Face input: ROMBR=stream bank; R14=count/triples/next command.
; Raw object flags: $4000=byte projection, $8000=lighting enabled.
; Count 1..100, point indices 0..69; uses existing projected/visibility RAM.
; The callable face adapter saves R11, returns the next command in R0
; and advances R14 instead of jumping into the shape bytecode table.
; Facevalue: R14 is past its index; R0=visibility<<8 and R14+=6.
; No renderer, shape interpreter or raster/frame owner is installed.
mrcolr_begin
mretail_material
rcl_9276
	add r0
rcl_9277
	ibt r1,#$03
rcl_9279
	from r1
rcl_927a
	romb
rcl_927c
	lms r1,[m_colourptr]
rcl_927f
	to r14
rcl_9280
	add r1
rcl_9281
	to r3
rcl_9282
	getb
rcl_9283
	inc r14
rcl_9284
	with r3
rcl_9285
	getbh
rcl_9287
	with r3
rcl_9288
	from r3
rcl_9289
	bpl rcl_92bc
rcl_928b
	nop
rcl_928c
	from r3
rcl_928d
	add r3
rcl_928e
	bpl rcl_92aa
rcl_9290
	nop
rcl_9291
	iwt r0,#$fffe
rcl_9294
	sms [m_texturemap],r0
rcl_9297
	from r3
rcl_9298
	hib
rcl_9299
	and #15
rcl_929b
	add r0
rcl_929c
	add r0
rcl_929d
	add r0
rcl_929e
	add r0
rcl_929f
	swap
rcl_92a0
	or #8
rcl_92a2
	swap
rcl_92a3
	sms [m_tcmodecol],r0
rcl_92a6
	iwt r15,#rcl_939e&WM
rcl_92a9
	nop
rcl_92aa
	iwt r0,#$1fff
rcl_92ad
	to r14
rcl_92ae
	and r3
rcl_92af
	lms r0,[m_colframe]
rcl_92b2
	to r3
rcl_92b3
	getb
rcl_92b4
	dec r3
rcl_92b5
	and r3
rcl_92b6
	add r0
rcl_92b7
	inc r0
rcl_92b8
	to r14
rcl_92b9
	bra rcl_9281
rcl_92bb
	add r14
rcl_92bc
	from r3
rcl_92bd
	lob
rcl_92be
	iwt r1,#retail_texturepals&WM
rcl_92c1
	to r14
rcl_92c2
	add r1
rcl_92c3
	to r1
rcl_92c4
	getb
rcl_92c5
	iwt r0,#$0800
rcl_92c8
	add r1
rcl_92c9
	sms [m_tcmodecol],r0
rcl_92cc
	from r3
rcl_92cd
	add r3
rcl_92ce
	bpl rcl_92d2
rcl_92d0
	sub r0
rcl_92d1
	dec r0
rcl_92d2
	sms [m_texturemap],r0
rcl_92d5
	beq rcl_931e
rcl_92d7
	nop
rcl_92d8
	iwt r0,#$2000
rcl_92db
	and r3
rcl_92dc
	beq rcl_92e6
rcl_92de
	nop
rcl_92df
	iwt r0,#$0c00
rcl_92e2
	add r1
rcl_92e3
	sms [m_tcmodecol],r0
rcl_92e6
	from r3
rcl_92e7
	lob
rcl_92e8
	umult #3
rcl_92ea
	iwt r1,#retail_texturedefs&WM
rcl_92ed
	to r14
rcl_92ee
	add r1
rcl_92ef
	getb
rcl_92f0
	inc r14
rcl_92f1
	getbh
rcl_92f3
	inc r14
rcl_92f4
	sms [m_sprdata],r0
rcl_92f7
	getb
rcl_92f8
	sms [m_sprbank],r0
rcl_92fb
	from r3
rcl_92fc
	hib
rcl_92fd
	ibt r1,#$1f
rcl_92ff
	and r1
rcl_9300
	add r0
rcl_9301
	iwt r1,#retail_texturexys&WM
rcl_9304
	to r14
rcl_9305
	add r1
rcl_9306
	getb
rcl_9307
	inc r14
rcl_9308
	getbh
rcl_930a
	with r0
rcl_930b
	to r14
rcl_930c
	to r1
rcl_930d
	getb
rcl_930e
	inc r14
rcl_930f
	with r1
rcl_9310
	getbh
rcl_9312
	sms [m_sprmask],r1
rcl_9315
	inc r0
rcl_9316
	inc r0
rcl_9317
	sms [m_texptr],r0
rcl_931a
	iwt r15,#rcl_939e&WM
rcl_931d
	nop
rcl_931e
	ibt r1,#$3f
rcl_9320
	from r3
rcl_9321
	hib
rcl_9322
	inc r0
rcl_9323
	and r1
rcl_9324
	bne rcl_932b
rcl_9326
	nop
rcl_9327
	iwt r15,#rcl_939b&WM
rcl_932a
	nop
rcl_932b
	inc r0
rcl_932c
	and r1
rcl_932d
	beq rcl_9334
rcl_932f
	nop
rcl_9330
	iwt r15,#rcl_9340&WM
rcl_9333
	nop
rcl_9334
	from r3
rcl_9335
	lob
rcl_9336
	lms r3,[m_depthsptr]
rcl_9339
	to r14
rcl_933a
	add r3
rcl_933b
	getc
rcl_933c
	iwt r15,#rcl_939e&WM
rcl_933f
	nop
rcl_9340
	dec r0
rcl_9341
	dec r0
rcl_9342
	and r1
rcl_9343
	with r0
rcl_9344
	to r3
rcl_9345
	lms r0,[m_objflags]
rcl_9348
	hib
rcl_9349
	bpl rcl_939b
rcl_934b
	nop
rcl_934c
	lms r0,[m_shadestab]
rcl_934f
	add r3
rcl_9350
	to r14
rcl_9351
	add r3
rcl_9352
	to r6
rcl_9353
	getb
rcl_9354
	inc r14
rcl_9355
	with r6
rcl_9356
	getbh
rcl_9358
	lms r0,[m_shapebank]
rcl_935b
	romb
rcl_935d
	with r2
rcl_935e
	to r14
rcl_935f
	inc r14
rcl_9360
	getb
rcl_9361
	inc r14
rcl_9362
	lms r4,[m_rotlightx]
rcl_9365
	to r5
rcl_9366
	mult r4
rcl_9367
	getb
rcl_9368
	inc r14
rcl_9369
	lms r4,[m_rotlighty]
rcl_936c
	mult r4
rcl_936d
	to r5
rcl_936e
	add r5
rcl_936f
	getb
rcl_9370
	lms r4,[m_rotlightz]
rcl_9373
	mult r4
rcl_9374
	add r5
rcl_9375
	asr
rcl_9376
	asr
rcl_9377
	hib
rcl_9378
	sex
rcl_9379
	ibt r4,#$06
rcl_937b
	cmp r4
rcl_937d
	bge rcl_9385
rcl_937f
	nop
rcl_9380
	ibt r0,#$06
rcl_9382
	bra rcl_938e
rcl_9384
	nop
rcl_9385
	ibt r4,#$10
rcl_9387
	cmp r4
rcl_9389
	blt rcl_938e
rcl_938b
	nop
rcl_938c
	ibt r0,#$0f
rcl_938e
	to r1
rcl_938f
	sub #6
rcl_9391
	ibt r0,#$03
rcl_9393
	romb
rcl_9395
	from r6
rcl_9396
	to r14
rcl_9397
	add r1
rcl_9398
	bra rcl_939e
rcl_939a
	getc
rcl_939b
	from r3
rcl_939c
	lob
rcl_939d
	colour
rcl_939e
	lms r0,[m_shapebank]
rcl_93a1
	romb
rcl_93a3
	with r2
rcl_93a4
	to r14
rcl_93a5
	jmp r11
rcl_93a6
	nop
mretail_facevis
	from r11
	stw [r10]
	inc r10
	inc r10
rcl_93a7
	lms r0,[m_objflags]
rcl_93aa
	iwt r1,#$4000
rcl_93ad
	and r1
rcl_93ae
	beq rcl_93b5
rcl_93b0
	nop
rcl_93b1
	iwt r15,#rcl_941b&WM
rcl_93b4
	nop
rcl_93b5
	to r12
rcl_93b6
	getb
rcl_93b7
	inc r14
rcl_93b8
	iwt r9,#m_projpnts&WM
rcl_93bb
	iwt r11,#m_vistab&WM
rcl_93be
	cache
rcl_93bf
	with r15
rcl_93c0
	to r13
rcl_93c1
	getb
rcl_93c2
	inc r14
rcl_93c3
	mult #6
rcl_93c5
	add r9
rcl_93c6
	to r1
rcl_93c7
	ldw [r0]
rcl_93c8
	inc r0
rcl_93c9
	inc r0
rcl_93ca
	to r2
rcl_93cb
	ldw [r0]
rcl_93cc
	inc r0
rcl_93cd
	inc r0
rcl_93ce
	to r5
rcl_93cf
	ldb [r0]
rcl_93d1
	getb
rcl_93d2
	inc r14
rcl_93d3
	mult #6
rcl_93d5
	to r8
rcl_93d6
	add r9
rcl_93d7
	ldw [r8]
rcl_93d8
	inc r8
rcl_93d9
	inc r8
rcl_93da
	to r3
rcl_93db
	sub r1
rcl_93dc
	ldw [r8]
rcl_93dd
	inc r8
rcl_93de
	inc r8
rcl_93df
	to r7
rcl_93e0
	sub r2
rcl_93e1
	ldb [r8]
rcl_93e3
	to r5
rcl_93e4
	xor r5
rcl_93e6
	getb
rcl_93e7
	inc r14
rcl_93e8
	mult #6
rcl_93ea
	to r8
rcl_93eb
	add r9
rcl_93ec
	ldw [r8]
rcl_93ed
	inc r8
rcl_93ee
	inc r8
rcl_93ef
	to r1
rcl_93f0
	sub r1
rcl_93f1
	ldw [r8]
rcl_93f2
	inc r8
rcl_93f3
	inc r8
rcl_93f4
	to r2
rcl_93f5
	sub r2
rcl_93f6
	ldb [r8]
rcl_93f8
	to r5
rcl_93f9
	xor r5
rcl_93fb
	with r1
rcl_93fc
	to r6
rcl_93fd
	with r7
rcl_93fe
	lmult
rcl_9400
	with r4
rcl_9401
	to r1
rcl_9402
	with r3
rcl_9403
	to r6
rcl_9404
	with r2
rcl_9405
	lmult
rcl_9407
	with r4
rcl_9408
	sub r1
rcl_9409
	with r2
rcl_940a
	sbc r7
rcl_940c
	from r5
rcl_940d
	add r5
rcl_940e
	add r0
rcl_940f
	add r0
rcl_9410
	swap
rcl_9411
	xor r2
rcl_9413
	hib
rcl_9414
	stb [r11]
rcl_9416
	loop
rcl_9417
	inc r11
rcl_9418
	to r0
rcl_9419
	getb
rcl_941a
	inc r14
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
rcl_941b
	to r12
rcl_941c
	getb
rcl_941d
	inc r14
rcl_941e
	iwt r9,#m_projpnts&WM
rcl_9421
	iwt r11,#m_vistab&WM
rcl_9424
	cache
rcl_9425
	with r15
rcl_9426
	to r13
rcl_9427
	getb
rcl_9428
	inc r14
rcl_9429
	umult #6
rcl_942b
	add r9
rcl_942c
	to r1
rcl_942d
	ldb [r0]
rcl_942f
	inc r0
rcl_9430
	inc r0
rcl_9431
	to r2
rcl_9432
	ldb [r0]
rcl_9434
	getb
rcl_9435
	inc r14
rcl_9436
	umult #6
rcl_9438
	to r8
rcl_9439
	add r9
rcl_943a
	ldb [r8]
rcl_943c
	inc r8
rcl_943d
	inc r8
rcl_943e
	to r3
rcl_943f
	sub r1
rcl_9440
	ldb [r8]
rcl_9442
	to r7
rcl_9443
	sub r2
rcl_9444
	getb
rcl_9445
	inc r14
rcl_9446
	umult #6
rcl_9448
	to r8
rcl_9449
	add r9
rcl_944a
	ldb [r8]
rcl_944c
	inc r8
rcl_944d
	inc r8
rcl_944e
	to r1
rcl_944f
	sub r1
rcl_9450
	ldb [r8]
rcl_9452
	to r2
rcl_9453
	sub r2
rcl_9454
	with r1
rcl_9455
	to r6
rcl_9456
	with r7
rcl_9457
	lmult
rcl_9459
	with r4
rcl_945a
	to r1
rcl_945b
	with r3
rcl_945c
	to r6
rcl_945d
	with r2
rcl_945e
	lmult
rcl_9460
	with r4
rcl_9461
	sub r1
rcl_9462
	from r2
rcl_9463
	sbc r7
rcl_9465
	hib
rcl_9466
	stb [r11]
rcl_9468
	loop
rcl_9469
	inc r11
rcl_946a
	to r0
rcl_946b
	getb
rcl_946c
	inc r14
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
mretail_facevalue
rcl_946d
	dec r14
rcl_946e
	getb
rcl_946f
	with r14
rcl_9470
	add #7
rcl_9472
	iwt r1,#m_vistab&WM
rcl_9475
	add r1
rcl_9476
	ldb [r0]
rcl_9478
	jmp r11
rcl_9479
	swap
mretail_facevis8
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rcl_941b&WM
	nop
mrcolr_end
