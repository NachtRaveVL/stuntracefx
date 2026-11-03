; Retail HUD command interpreter. R6/R7=Y/X, R8=script address,
; R9=script ROM bank. Trusted zero-terminated retail command stream.
; Use after geometry; the clipping buffer holds the retail HUD palettes.
mrhudgsu_begin
mretail_hudscript
	sub r0
	ramb
	iwt r10,#m_stack&WM
	from r9
	stw [r10]
	inc r10
	inc r10
	ibt r0,#hud_palettes>>16
	romb
	iwt r14,#hud_palettes&WM
	iwt r9,#m_clippolybuf&WM
	ibt r12,#48
	with r15
	to r13
	getb
	stb [r9]
	inc r14
	loop
	inc r9
	ibt r5,#0
	iwt r9,#m_clippolybuf&WM
	with r6
	to r2
	ibt r6,#32
	with r7
	to r4
	sub r0
	cmode
	iwt r15,#hud_d33b&WM
	nop
hud_task_done
	dec r10
	dec r10
	stop
	nop
hud_d33b
	ibt r0,#-2
	add r10
	ldw [r0]
	lob
	romb
hud_d342
	with r8
hud_d343
	to r14
hud_d344
	getb
hud_d345
	inc r8
hud_d346
	sex
hud_d347
	bne hud_d34e
hud_d349
	nop
hud_d34a
	iwt r15,#hud_d4dd&WM
hud_d34d
	nop
hud_d34e
	bmi hud_d355
hud_d350
	nop
hud_d351
	iwt r15,#hud_d46f&WM
hud_d354
	nop
hud_d355
	inc r14
hud_d356
	ibt r3,#-1
hud_d358
	cmp r3
hud_d35a
	bne hud_d36a
hud_d35c
	nop
hud_d35d
	to r7
hud_d35e
	getb
hud_d35f
	inc r14
hud_d360
	to r2
hud_d361
	getb
hud_d362
	inc r14
hud_d363
	with r7
hud_d364
	to r4
hud_d365
	with r14
hud_d366
	to r8
hud_d367
	bra hud_d33b
hud_d369
	nop
hud_d36a
	ibt r3,#-2
hud_d36c
	cmp r3
hud_d36e
	bne hud_d37c
hud_d370
	nop
hud_d371
	getb
hud_d372
	inc r8
hud_d373
	add r0
hud_d374
	add r0
hud_d375
	iwt r9,#m_clippolybuf&WM
hud_d378
	to r9
hud_d379
	bra hud_d33b
hud_d37b
	add r9
hud_d37c
	ibt r3,#-3
hud_d37e
	cmp r3
hud_d380
	bne hud_d39c
hud_d382
	nop
hud_d383
	getb
hud_d384
	inc r8
hud_d385
	with r0
hud_d386
	from r0
hud_d387
	beq hud_d393
hud_d389
	nop
hud_d38a
	iwt r6,#$0010
hud_d38d
	ibt r5,#$01
hud_d38f
	iwt r15,#hud_d33b&WM
hud_d392
	nop
hud_d393
	iwt r6,#$0020
hud_d396
	ibt r5,#$00
hud_d398
	iwt r15,#hud_d33b&WM
hud_d39b
	nop
hud_d39c
	ibt r3,#-4
hud_d39e
	cmp r3
hud_d3a0
	bne hud_d3b4
hud_d3a2
	nop
hud_d3a3
	iwt r0,#$0004
hud_d3a6
	with r5
hud_d3a7
	from r5
hud_d3a8
	bne hud_d3ae
hud_d3aa
	nop
hud_d3ab
	iwt r0,#$0008
hud_d3ae
	with r4
hud_d3af
	add r0
hud_d3b0
	iwt r15,#hud_d33b&WM
hud_d3b3
	nop
hud_d3b4
	ibt r3,#-11
hud_d3b6
	cmp r3
hud_d3b8
	bne hud_d3c7
hud_d3ba
	nop
hud_d3bb
	with r7
hud_d3bc
	to r4
hud_d3bd
	with r6
hud_d3be
	to r0
hud_d3bf
	div2
hud_d3c1
	with r2
hud_d3c2
	add r0
hud_d3c3
	iwt r15,#hud_d33b&WM
hud_d3c6
	nop
hud_d3c7
	ibt r3,#-5
hud_d3c9
	cmp r3
hud_d3cb
	bne hud_d3e3
hud_d3cd
	nop
hud_d3ce
	ibt r0,#hud_pic_e35a>>16
	romb
	iwt r14,#hud_pic_e35a&WM
hud_d3da
	link #4
hud_d3db
	iwt r15,#hud_e35a&WM
hud_d3de
	nop
hud_d3df
	iwt r15,#hud_d33b&WM
hud_d3e2
	nop
hud_d3e3
	ibt r3,#-6
hud_d3e5
	cmp r3
hud_d3e7
	bne hud_d3ff
hud_d3e9
	nop
hud_d3ea
	ibt r0,#hud_pic_e9de>>16
	romb
	iwt r14,#hud_pic_e9de&WM
hud_d3f6
	link #4
hud_d3f7
	iwt r15,#hud_e9de&WM
hud_d3fa
	nop
hud_d3fb
	iwt r15,#hud_d33b&WM
hud_d3fe
	nop
hud_d3ff
	ibt r3,#-7
hud_d401
	cmp r3
hud_d403
	bne hud_d41b
hud_d405
	nop
hud_d406
	ibt r0,#hud_pic_f062>>16
	romb
	iwt r14,#hud_pic_f062&WM
hud_d412
	link #4
hud_d413
	iwt r15,#hud_f062&WM
hud_d416
	nop
hud_d417
	iwt r15,#hud_d33b&WM
hud_d41a
	nop
hud_d41b
	ibt r3,#-8
hud_d41d
	cmp r3
hud_d41f
	bne hud_d437
hud_d421
	nop
hud_d422
	ibt r0,#hud_pic_dcd6>>16
	romb
	iwt r14,#hud_pic_dcd6&WM
hud_d42e
	link #4
hud_d42f
	iwt r15,#hud_dcd6&WM
hud_d432
	nop
hud_d433
	iwt r15,#hud_d33b&WM
hud_d436
	nop
hud_d437
	ibt r3,#-9
hud_d439
	cmp r3
hud_d43b
	bne hud_d453
hud_d43d
	nop
hud_d43e
	ibt r0,#hud_pic_alt>>16
	romb
	iwt r14,#hud_pic_alt&WM
hud_d44a
	link #4
hud_d44b
	iwt r15,#hud_alt&WM
hud_d44e
	nop
hud_d44f
	iwt r15,#hud_d33b&WM
hud_d452
	nop
hud_d453
	ibt r3,#-10
hud_d455
	cmp r3
hud_d457
	bne hud_d46f
hud_d459
	nop
hud_d45a
	ibt r0,#hud_pic_f3e4>>16
	romb
	iwt r14,#hud_pic_f3e4&WM
hud_d466
	link #4
hud_d467
	iwt r15,#hud_f3e4&WM
hud_d46a
	nop
hud_d46b
	iwt r15,#hud_d33b&WM
hud_d46e
	nop
hud_d46f
	ibt r3,#$0d
hud_d471
	cmp r3
hud_d473
	bne hud_d47e
hud_d475
	nop
hud_d476
	with r7
hud_d477
	to r4
hud_d478
	with r2
hud_d479
	add r6
hud_d47a
	iwt r15,#hud_d33b&WM
hud_d47d
	nop
hud_d47e
	ibt r3,#$5e
	cmp r3
	bcc hud_asciilow
	nop
	iwt r15,#hud_d4cc&WM
	nop
hud_asciilow
	ibt r3,#$30
hud_d480
	sub r3
hud_d481
	bpl hud_d488
hud_d483
	nop
hud_d484
	iwt r15,#hud_d4cc&WM
hud_d487
	nop
hud_d488
	with r0
	to r3
	ibt r0,#hud_palettes>>16
	romb
	from r3
	add r3
hud_d48e
	with r5
hud_d48f
	from r5
hud_d490
	bne hud_d4b1
hud_d492
	nop
hud_d493
	iwt r14,#hud_font_big&WM
hud_d496
	to r14
hud_d497
	add r14
hud_d498
	to r1
hud_d499
	getb
hud_d49a
	inc r14
hud_d49b
	with r1
hud_d49c
	getbh
hud_d49e
	iwt r0,#$ffff
	from r1
	cmp r0
	bne hud_big_valid
	nop
	iwt r15,#hud_d4cc&WM
	nop
hud_big_valid
	with r1
	to r14
hud_d4a7
	link #4
hud_d4a8
	iwt r15,#hud_d4e4&WM
hud_d4ab
	nop
hud_d4ac
	with r2
hud_d4ad
	sub r6
hud_d4ae
	bra hud_d4cc
hud_d4b0
	nop
hud_d4b1
	iwt r14,#hud_font_small&WM
hud_d4b4
	to r14
hud_d4b5
	add r14
hud_d4b6
	to r1
hud_d4b7
	getb
hud_d4b8
	inc r14
hud_d4b9
	with r1
hud_d4ba
	getbh
hud_d4bc
	iwt r0,#$ffff
	from r1
	cmp r0
	beq hud_d4cc
	nop
	with r1
	to r14
hud_d4c5
	link #4
hud_d4c6
	iwt r15,#hud_d5d2&WM
hud_d4c9
	nop
hud_d4ca
	with r2
hud_d4cb
	sub r6
hud_d4cc
	iwt r0,#$000a
hud_d4cf
	with r5
hud_d4d0
	from r5
hud_d4d1
	bne hud_d4d7
hud_d4d3
	nop
hud_d4d4
	iwt r0,#$0014
hud_d4d7
	with r4
hud_d4d8
	add r0
hud_d4d9
	iwt r15,#hud_d33b&WM
hud_d4dc
	nop
hud_d4dd
	rpix
hud_d4df
	iwt r15,#hud_task_done&WM
	nop
hud_skipchar
	iwt r15,#hud_d4cc&WM
	nop
hud_d4e4
	ibt r12,#32
	ibt r13,#4
	bra hud_blit
	nop
hud_d5d2
	ibt r12,#16
	ibt r13,#2
	bra hud_blit
	nop
hud_dcd6
	ibt r12,#24
	ibt r13,#30
	bra hud_blit
	nop
hud_alt
	ibt r12,#24
	ibt r13,#30
	bra hud_blit
	nop
hud_e35a
	ibt r12,#32
	ibt r13,#30
	bra hud_blit
	nop
hud_e9de
	ibt r12,#16
	ibt r13,#30
	bra hud_blit
	nop
hud_f062
	ibt r12,#16
	ibt r13,#16
	bra hud_blit
	nop
hud_f3e4
	ibt r12,#24
	ibt r13,#4
	bra hud_blit
	nop
hud_blit
	from r7
	stw [r10]
	inc r10
	inc r10
	from r8
	stw [r10]
	inc r10
	inc r10
	from r6
	stw [r10]
	inc r10
	inc r10
	with r12
	to r7
	with r13
	to r6
hud_row
	with r4
	to r1
	with r6
	to r8
hud_byte
	to r3
	getb
	inc r14
	ibt r12,#4
	with r15
	to r13
	from r3
	and #3
	add r9
	ldb [r0]
	colour
	plot
	with r3
	lsr
	with r3
	lsr
	loop
	nop
	dec r8
	bne hud_byte
	nop
	dec r7
	bne hud_row
	inc r2
	dec r10
	dec r10
	to r6
	ldw [r10]
	dec r10
	dec r10
	to r8
	ldw [r10]
	dec r10
	dec r10
	to r7
	ldw [r10]
	jmp r11
	nop
mrhudgsu_end
