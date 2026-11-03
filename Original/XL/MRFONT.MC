; Retail projected text, point projection/clipping and face-bitmap copy.
; All returning calls use R11 and the existing R10 software stack; RAM bank 0.
; projectpnt: R1/R2/R3=signed X/Y/Z; returns screen X/Y and packed outcode R0.
; Vanish/clip bounds come from the existing globals. Zero Z becomes one.
; projectmag takes ordered magnitudes R1>=R2 and nonzero unsigned R3;
; projectswap exchanges R1/R2 first. Both return untranslated magnitudes.
; projectlist: R0=count 1..70, R7=input triples, R8=output X/Y/outcodes.
; Input/output buffers must not overlap work variables or each other.
; sprint: R0=colour, m_bigx/y/z=position, m_sprsize=-127..128 and a
; terminated text stream at m_shapebank:m_shapeptr. At most127 bytes;
; the low7 bits of glyph codes1..80 bind the inherited80-glyph,16x16
; font. Zero terminates; other codes require caller-bound glyph data.
; Positive Z>128 is required to draw. Native centering subtracts101/51
; after the second projection. This call overwrites m_bigx/y,m_sprsize
; and clipping temporaries. Caller owns bitmap mode and cache flushing.
; copyface is a STOP task: ROM bank0 at m_faceptr, four160-byte strips
; to bitmap1+(low8(m_bigy)*4), stride1024. The native8-bit multiply by
;256 discards the X term; it is preserved. Bitmap RAM must be caller-owned.
; The original engine entries and frame/NMI ownership are unchanged.
mrfont_begin
mretail_projectpnt
rfn_947a
	from r11
rfn_947b
	stw [r10]
rfn_947c
	inc r10
rfn_947d
	inc r10
rfn_947e
	with r3
rfn_947f
	from r3
rfn_9480
	bpl rfn_9487
rfn_9482
	nop
rfn_9483
	iwt r15,#rfn_954a&WM
rfn_9486
	nop
rfn_9487
	nop
rfn_9488
	bne rfn_948c
rfn_948a
	nop
rfn_948b
	inc r3
rfn_948c
	ibt r5,#$00
rfn_948e
	with r1
rfn_948f
	from r1
rfn_9490
	bmi rfn_94e7
rfn_9492
	nop
rfn_9493
	with r2
rfn_9494
	from r2
rfn_9495
	bmi rfn_94bb
rfn_9497
	nop
rfn_9498
	from r1
rfn_9499
	sub r2
rfn_949a
	bcc rfn_94a6
rfn_949c
	nop
rfn_949d
	link #4
rfn_949e
	iwt r15,#rfn_9658&WM
rfn_94a1
	nop
rfn_94a2
	iwt r15,#rfn_9607&WM
rfn_94a5
	nop
rfn_94a6
	with r1
rfn_94a7
	to r0
rfn_94a8
	with r2
rfn_94a9
	to r1
rfn_94aa
	with r0
rfn_94ab
	to r2
rfn_94ac
	link #4
rfn_94ad
	iwt r15,#rfn_9658&WM
rfn_94b0
	nop
rfn_94b1
	with r1
rfn_94b2
	to r0
rfn_94b3
	with r2
rfn_94b4
	to r1
rfn_94b5
	with r0
rfn_94b6
	to r2
rfn_94b7
	iwt r15,#rfn_9607&WM
rfn_94ba
	nop
rfn_94bb
	with r2
rfn_94bc
	not
rfn_94bd
	inc r2
rfn_94be
	from r1
rfn_94bf
	sub r2
rfn_94c0
	bcc rfn_94cf
rfn_94c2
	nop
rfn_94c3
	link #4
rfn_94c4
	iwt r15,#rfn_9658&WM
rfn_94c7
	nop
rfn_94c8
	with r2
rfn_94c9
	not
rfn_94ca
	inc r2
rfn_94cb
	iwt r15,#rfn_9607&WM
rfn_94ce
	nop
rfn_94cf
	with r1
rfn_94d0
	to r0
rfn_94d1
	with r2
rfn_94d2
	to r1
rfn_94d3
	with r0
rfn_94d4
	to r2
rfn_94d5
	link #4
rfn_94d6
	iwt r15,#rfn_9658&WM
rfn_94d9
	nop
rfn_94da
	with r1
rfn_94db
	to r0
rfn_94dc
	with r2
rfn_94dd
	to r1
rfn_94de
	with r0
rfn_94df
	to r2
rfn_94e0
	with r2
rfn_94e1
	not
rfn_94e2
	inc r2
rfn_94e3
	iwt r15,#rfn_9607&WM
rfn_94e6
	nop
rfn_94e7
	with r1
rfn_94e8
	not
rfn_94e9
	inc r1
rfn_94ea
	with r2
rfn_94eb
	from r2
rfn_94ec
	bmi rfn_9518
rfn_94ee
	nop
rfn_94ef
	from r1
rfn_94f0
	sub r2
rfn_94f1
	bcc rfn_9500
rfn_94f3
	nop
rfn_94f4
	link #4
rfn_94f5
	iwt r15,#rfn_9658&WM
rfn_94f8
	nop
rfn_94f9
	with r1
rfn_94fa
	not
rfn_94fb
	inc r1
rfn_94fc
	iwt r15,#rfn_9607&WM
rfn_94ff
	nop
rfn_9500
	with r1
rfn_9501
	to r0
rfn_9502
	with r2
rfn_9503
	to r1
rfn_9504
	with r0
rfn_9505
	to r2
rfn_9506
	link #4
rfn_9507
	iwt r15,#rfn_9658&WM
rfn_950a
	nop
rfn_950b
	with r1
rfn_950c
	to r0
rfn_950d
	with r2
rfn_950e
	to r1
rfn_950f
	with r0
rfn_9510
	to r2
rfn_9511
	with r1
rfn_9512
	not
rfn_9513
	inc r1
rfn_9514
	iwt r15,#rfn_9607&WM
rfn_9517
	nop
rfn_9518
	with r2
rfn_9519
	not
rfn_951a
	inc r2
rfn_951b
	from r1
rfn_951c
	sub r2
rfn_951d
	bcc rfn_952f
rfn_951f
	nop
rfn_9520
	link #4
rfn_9521
	iwt r15,#rfn_9658&WM
rfn_9524
	nop
rfn_9525
	with r2
rfn_9526
	not
rfn_9527
	inc r2
rfn_9528
	with r1
rfn_9529
	not
rfn_952a
	inc r1
rfn_952b
	iwt r15,#rfn_9607&WM
rfn_952e
	nop
rfn_952f
	with r1
rfn_9530
	to r0
rfn_9531
	with r2
rfn_9532
	to r1
rfn_9533
	with r0
rfn_9534
	to r2
rfn_9535
	link #4
rfn_9536
	iwt r15,#rfn_9658&WM
rfn_9539
	nop
rfn_953a
	with r1
rfn_953b
	to r0
rfn_953c
	with r2
rfn_953d
	to r1
rfn_953e
	with r0
rfn_953f
	to r2
rfn_9540
	with r2
rfn_9541
	not
rfn_9542
	inc r2
rfn_9543
	with r1
rfn_9544
	not
rfn_9545
	inc r1
rfn_9546
	iwt r15,#rfn_9607&WM
rfn_9549
	nop
rfn_954a
	with r3
rfn_954b
	not
rfn_954c
	inc r3
rfn_954d
	ibt r5,#$04
rfn_954f
	with r1
rfn_9550
	from r1
rfn_9551
	bmi rfn_95b4
rfn_9553
	nop
rfn_9554
	with r2
rfn_9555
	from r2
rfn_9556
	bmi rfn_9588
rfn_9558
	nop
rfn_9559
	from r1
rfn_955a
	sub r2
rfn_955b
	bcc rfn_956d
rfn_955d
	nop
rfn_955e
	link #4
rfn_955f
	iwt r15,#rfn_9658&WM
rfn_9562
	nop
rfn_9563
	with r1
rfn_9564
	not
rfn_9565
	inc r1
rfn_9566
	with r2
rfn_9567
	not
rfn_9568
	inc r2
rfn_9569
	iwt r15,#rfn_9607&WM
rfn_956c
	nop
rfn_956d
	with r1
rfn_956e
	to r0
rfn_956f
	with r2
rfn_9570
	to r1
rfn_9571
	with r0
rfn_9572
	to r2
rfn_9573
	link #4
rfn_9574
	iwt r15,#rfn_9658&WM
rfn_9577
	nop
rfn_9578
	with r1
rfn_9579
	to r0
rfn_957a
	with r2
rfn_957b
	to r1
rfn_957c
	with r0
rfn_957d
	to r2
rfn_957e
	with r1
rfn_957f
	not
rfn_9580
	inc r1
rfn_9581
	with r2
rfn_9582
	not
rfn_9583
	inc r2
rfn_9584
	iwt r15,#rfn_9607&WM
rfn_9587
	nop
rfn_9588
	with r2
rfn_9589
	not
rfn_958a
	inc r2
rfn_958b
	from r1
rfn_958c
	sub r2
rfn_958d
	bcc rfn_959c
rfn_958f
	nop
rfn_9590
	link #4
rfn_9591
	iwt r15,#rfn_9658&WM
rfn_9594
	nop
rfn_9595
	with r1
rfn_9596
	not
rfn_9597
	inc r1
rfn_9598
	iwt r15,#rfn_9607&WM
rfn_959b
	nop
rfn_959c
	with r1
rfn_959d
	to r0
rfn_959e
	with r2
rfn_959f
	to r1
rfn_95a0
	with r0
rfn_95a1
	to r2
rfn_95a2
	link #4
rfn_95a3
	iwt r15,#rfn_9658&WM
rfn_95a6
	nop
rfn_95a7
	with r1
rfn_95a8
	to r0
rfn_95a9
	with r2
rfn_95aa
	to r1
rfn_95ab
	with r0
rfn_95ac
	to r2
rfn_95ad
	with r1
rfn_95ae
	not
rfn_95af
	inc r1
rfn_95b0
	iwt r15,#rfn_9607&WM
rfn_95b3
	nop
rfn_95b4
	with r1
rfn_95b5
	not
rfn_95b6
	inc r1
rfn_95b7
	with r2
rfn_95b8
	from r2
rfn_95b9
	bmi rfn_95e5
rfn_95bb
	nop
rfn_95bc
	from r1
rfn_95bd
	sub r2
rfn_95be
	bcc rfn_95cd
rfn_95c0
	nop
rfn_95c1
	link #4
rfn_95c2
	iwt r15,#rfn_9658&WM
rfn_95c5
	nop
rfn_95c6
	with r2
rfn_95c7
	not
rfn_95c8
	inc r2
rfn_95c9
	iwt r15,#rfn_9607&WM
rfn_95cc
	nop
rfn_95cd
	with r1
rfn_95ce
	to r0
rfn_95cf
	with r2
rfn_95d0
	to r1
rfn_95d1
	with r0
rfn_95d2
	to r2
rfn_95d3
	link #4
rfn_95d4
	iwt r15,#rfn_9658&WM
rfn_95d7
	nop
rfn_95d8
	with r1
rfn_95d9
	to r0
rfn_95da
	with r2
rfn_95db
	to r1
rfn_95dc
	with r0
rfn_95dd
	to r2
rfn_95de
	with r2
rfn_95df
	not
rfn_95e0
	inc r2
rfn_95e1
	iwt r15,#rfn_9607&WM
rfn_95e4
	nop
rfn_95e5
	with r2
rfn_95e6
	not
rfn_95e7
	inc r2
rfn_95e8
	from r1
rfn_95e9
	sub r2
rfn_95ea
	bcc rfn_95f6
rfn_95ec
	nop
rfn_95ed
	link #4
rfn_95ee
	iwt r15,#rfn_9658&WM
rfn_95f1
	nop
rfn_95f2
	iwt r15,#rfn_9607&WM
rfn_95f5
	nop
rfn_95f6
	with r1
rfn_95f7
	to r0
rfn_95f8
	with r2
rfn_95f9
	to r1
rfn_95fa
	with r0
rfn_95fb
	to r2
rfn_95fc
	link #4
rfn_95fd
	iwt r15,#rfn_9658&WM
rfn_9600
	nop
rfn_9601
	with r1
rfn_9602
	to r0
rfn_9603
	with r2
rfn_9604
	to r1
rfn_9605
	with r0
rfn_9606
	to r2
rfn_9607
	cache
rfn_9608
	lms r0,[m_vanishx]
rfn_960b
	with r1
rfn_960c
	add r0
rfn_960d
	lms r0,[m_vanishy]
rfn_9610
	with r2
rfn_9611
	add r0
rfn_9612
	lms r0,[m_xleft]
rfn_9615
	sub r1
rfn_9616
	bge rfn_9621
rfn_9618
	nop
rfn_9619
	lms r0,[m_xright]
rfn_961c
	sub r1
rfn_961d
	bge rfn_962b
rfn_961f
	nop
rfn_9620
	inc r5
rfn_9621
	inc r5
rfn_9622
	ibt r0,#$04
rfn_9624
	and r5
rfn_9625
	beq rfn_962b
rfn_9627
	nop
rfn_9628
	with r5
rfn_9629
	xor #3
rfn_962b
	with r5
rfn_962c
	mult #4
rfn_962e
	lms r0,[m_ytop]
rfn_9631
	sub r2
rfn_9632
	bge rfn_963d
rfn_9634
	nop
rfn_9635
	lms r0,[m_ybot]
rfn_9638
	sub r2
rfn_9639
	bge rfn_9647
rfn_963b
	nop
rfn_963c
	inc r5
rfn_963d
	inc r5
rfn_963e
	ibt r0,#$10
rfn_9640
	and r5
rfn_9641
	beq rfn_9647
rfn_9643
	nop
rfn_9644
	with r5
rfn_9645
	xor #3
rfn_9647
	ibt r0,#$1f
rfn_9649
	xor r5
rfn_964b
	swap
rfn_964c
	or r5
rfn_964d
	dec r10
rfn_964e
	dec r10
rfn_964f
	to r15
rfn_9650
	ldw [r10]
rfn_9651
	nop
mretail_projectswap
rfn_9652
	with r1
rfn_9653
	to r0
rfn_9654
	with r2
rfn_9655
	to r1
rfn_9656
	with r0
rfn_9657
	to r2
mretail_projectmag
rfn_9658
	from r11
rfn_9659
	stw [r10]
rfn_965a
	inc r10
rfn_965b
	inc r10
rfn_965c
	with r1
rfn_965d
	asr
rfn_965e
	with r2
rfn_965f
	asr
rfn_9660
	from r1
rfn_9661
	lob
rfn_9662
	to r4
rfn_9663
	swap
rfn_9664
	from r1
rfn_9665
	hib
rfn_9666
	cmp r3
rfn_9668
	bcs rfn_96a0
rfn_966a
	nop
rfn_966b
	with r3
rfn_966c
	to r6
rfn_966d
	link #4
rfn_966e
	iwt r15,#mretail_sprdivide&WM
rfn_9671
	nop
rfn_9672
	iwt r0,#$3fff
rfn_9675
	sub r4
rfn_9676
	bcc rfn_968f
rfn_9678
	nop
rfn_9679
	with r4
rfn_967a
	to r1
rfn_967b
	from r2
rfn_967c
	lob
rfn_967d
	to r4
rfn_967e
	swap
rfn_967f
	from r2
rfn_9680
	hib
rfn_9681
	with r3
rfn_9682
	to r6
rfn_9683
	link #4
rfn_9684
	iwt r15,#mretail_sprdivide&WM
rfn_9687
	nop
rfn_9688
	with r4
rfn_9689
	to r2
rfn_968a
	dec r10
rfn_968b
	dec r10
rfn_968c
	to r15
rfn_968d
	ldw [r10]
rfn_968e
	nop
rfn_968f
	with r4
rfn_9690
	to r1
rfn_9691
	from r2
rfn_9692
	lob
rfn_9693
	to r4
rfn_9694
	swap
rfn_9695
	from r2
rfn_9696
	hib
rfn_9697
	with r3
rfn_9698
	to r6
rfn_9699
	link #4
rfn_969a
	iwt r15,#mretail_sprdivide&WM
rfn_969d
	nop
rfn_969e
	with r4
rfn_969f
	to r2
rfn_96a0
	ibt r4,#$00
rfn_96a2
	from r2
rfn_96a3
	lsr
rfn_96a4
	with r4
rfn_96a5
	ror
rfn_96a6
	lsr
rfn_96a7
	with r4
rfn_96a8
	ror
rfn_96a9
	with r4
rfn_96aa
	sub r2
rfn_96ab
	ibt r6,#$00
rfn_96ad
	sbc r6
rfn_96af
	with r1
rfn_96b0
	to r6
rfn_96b1
	link #4
rfn_96b2
	iwt r15,#mretail_sprdivide&WM
rfn_96b5
	nop
rfn_96b6
	with r4
rfn_96b7
	to r2
rfn_96b8
	iwt r1,#$3fff
rfn_96bb
	dec r10
rfn_96bc
	dec r10
rfn_96bd
	to r15
rfn_96be
	ldw [r10]
rfn_96bf
	nop
mretail_projectlist
rfn_96e7
	from r11
rfn_96e8
	stw [r10]
rfn_96e9
	inc r10
rfn_96ea
	inc r10
rfn_96eb
	sms [m_cnt],r0
rfn_96ee
	sub r0
rfn_96ef
	sms [m_or_of_outcodes],r0
rfn_96f2
	ldw [r7]
rfn_96f3
	inc r7
rfn_96f4
	inc r7
rfn_96f5
	lms r9,[m_bigx]
rfn_96f8
	to r1
rfn_96f9
	add r9
rfn_96fa
	ldw [r7]
rfn_96fb
	inc r7
rfn_96fc
	inc r7
rfn_96fd
	lms r9,[m_bigy]
rfn_9700
	to r2
rfn_9701
	add r9
rfn_9702
	ldw [r7]
rfn_9703
	inc r7
rfn_9704
	inc r7
rfn_9705
	lms r9,[m_bigz]
rfn_9708
	to r3
rfn_9709
	add r9
rfn_970a
	link #4
rfn_970b
	iwt r15,#rfn_947a&WM
rfn_970e
	nop
rfn_970f
	from r1
rfn_9710
	stw [r8]
rfn_9711
	inc r8
rfn_9712
	inc r8
rfn_9713
	from r2
rfn_9714
	stw [r8]
rfn_9715
	inc r8
rfn_9716
	inc r8
rfn_9717
	stw [r8]
rfn_9718
	inc r8
rfn_9719
	inc r8
rfn_971a
	lms r3,[m_or_of_outcodes]
rfn_971d
	or r3
rfn_971e
	sbk
rfn_971f
	lms r0,[m_cnt]
rfn_9722
	dec r0
rfn_9723
	bne rfn_96f2
rfn_9725
	sbk
rfn_9726
	dec r10
rfn_9727
	dec r10
rfn_9728
	to r15
rfn_9729
	ldw [r10]
rfn_972a
	nop
mretail_sprint
rfn_b42f
	from r11
rfn_b430
	stw [r10]
rfn_b431
	inc r10
rfn_b432
	inc r10
rfn_b433
	colour
rfn_b434
	sub r0
rfn_b435
	ramb
rfn_b437
	cmode
rfn_b439
	iwt r0,#$0080
rfn_b43c
	lms r1,[m_bigx]
rfn_b43f
	lms r2,[m_bigy]
rfn_b442
	lms r3,[m_bigz]
rfn_b445
	cmp r3
rfn_b447
	bmi rfn_b44f
rfn_b449
	nop
rfn_b44a
	dec r10
rfn_b44b
	dec r10
rfn_b44c
	to r15
rfn_b44d
	ldw [r10]
rfn_b44e
	nop
rfn_b44f
	link #4
rfn_b450
	iwt r15,#rfn_947a&WM
rfn_b453
	nop
rfn_b454
	sms [m_bigx],r1
rfn_b457
	sms [m_bigy],r2
rfn_b45a
	lms r0,[m_shapebank]
rfn_b45d
	romb
rfn_b45f
	cache
rfn_b460
	lms r14,[m_shapeptr]
rfn_b463
	ibt r12,#-1
rfn_b465
	getb
rfn_b466
	inc r14
rfn_b467
	lob
rfn_b468
	bne rfn_b465
rfn_b46a
	inc r12
rfn_b46b
	ibt r3,#$10
rfn_b46d
	from r12
rfn_b46e
	mult r3
rfn_b46f
	stw [r10]
rfn_b470
	inc r10
rfn_b471
	inc r10
rfn_b472
	ibt r2,#$7f
rfn_b474
	lms r1,[m_sprsize]
rfn_b477
	with r1
rfn_b478
	add r2
rfn_b479
	from r1
rfn_b47a
	to r2
rfn_b47b
	umult r12
rfn_b47d
	lms r3,[m_bigz]
rfn_b480
	link #4
rfn_b481
	iwt r15,#rfn_947a&WM
rfn_b484
	nop
rfn_b485
	iwt r0,#$0065
rfn_b488
	with r1
rfn_b489
	sub r0
rfn_b48a
	iwt r0,#$0033
rfn_b48d
	with r2
rfn_b48e
	sub r0
rfn_b48f
	with r1
rfn_b490
	lob
rfn_b491
	sms [m_sprsize],r1
rfn_b494
	ibt r3,#-1
rfn_b496
	add #0
rfn_b498
	from r2
rfn_b499
	ror
rfn_b49a
	sbc r3
rfn_b49c
	lms r3,[m_bigx]
rfn_b49f
	from r3
rfn_b4a0
	sub r0
rfn_b4a1
	sbk
rfn_b4a2
	ibt r3,#-1
rfn_b4a4
	add #0
rfn_b4a6
	from r1
rfn_b4a7
	ror
rfn_b4a8
	sbc r3
rfn_b4aa
	lms r3,[m_bigy]
rfn_b4ad
	from r3
rfn_b4ae
	sub r0
rfn_b4af
	sbk
rfn_b4b0
	from r1
rfn_b4b1
	to r3
rfn_b4b2
	not
rfn_b4b3
	inc r3
rfn_b4b4
	sms [m_clipleft],r3
rfn_b4b7
	iwt r3,#$00e0
rfn_b4ba
	with r3
rfn_b4bb
	sub r1
rfn_b4bc
	sms [m_clipright],r3
rfn_b4bf
	dec r10
rfn_b4c0
	dec r10
rfn_b4c1
	to r6
rfn_b4c2
	ldw [r10]
rfn_b4c3
	from r2
rfn_b4c4
	sub r6
rfn_b4c5
	bcc rfn_b4cc
rfn_b4c7
	nop
rfn_b4c8
	iwt r15,#rfn_b57d&WM
rfn_b4cb
	nop
rfn_b4cc
	with r2
rfn_b4cd
	to r0
rfn_b4ce
	ibt r4,#$00
rfn_b4d0
	link #4
rfn_b4d1
	iwt r15,#mretail_sprdivide&WM
rfn_b4d4
	nop
rfn_b4d5
	with r4
rfn_b4d6
	to r9
rfn_b4d7
	with r4
rfn_b4d8
	to r8
rfn_b4d9
	ibt r3,#$00
rfn_b4db
	sms [m_clipleft],r3
rfn_b4de
	cache
rfn_b4df
	lms r2,[m_bigy]
rfn_b4e2
	ibt r6,#$00
rfn_b4e4
	ibt r4,#$00
rfn_b4e6
	with r2
rfn_b4e7
	from r2
rfn_b4e8
	bpl rfn_b4ef
rfn_b4ea
	nop
rfn_b4eb
	iwt r15,#rfn_b55a&WM
rfn_b4ee
	nop
rfn_b4ef
	iwt r0,#$00bf
rfn_b4f2
	cmp r2
rfn_b4f4
	bpl rfn_b4fb
rfn_b4f6
	nop
rfn_b4f7
	iwt r15,#rfn_b55a&WM
rfn_b4fa
	nop
rfn_b4fb
	lms r1,[m_bigx]
rfn_b4fe
	ibt r7,#$00
rfn_b500
	lms r5,[m_shapeptr]
rfn_b503
	lms r0,[m_shapebank]
rfn_b506
	romb
rfn_b508
	with r5
rfn_b509
	to r14
rfn_b50a
	getb
rfn_b50b
	inc r5
rfn_b50c
	add r0
rfn_b50d
	beq rfn_b55a
rfn_b50f
	nop
rfn_b510
	ibt r3,#$14
rfn_b512
	from r3
rfn_b513
	romb
rfn_b515
	ibt r3,#$10
rfn_b517
	umult r3
rfn_b519
	iwt r3,#(mscalechars-$20)&WM
rfn_b51c
	add r4
rfn_b51d
	add r4
rfn_b51e
	to r14
rfn_b51f
	add r3
rfn_b520
	lms r0,[m_clipleft]
rfn_b523
	cmp r1
rfn_b525
	bmi rfn_b530
rfn_b527
	nop
rfn_b528
	lms r0,[m_sprsize]
rfn_b52b
	to r1
rfn_b52c
	add r1
rfn_b52d
	bra rfn_b503
rfn_b52f
	nop
rfn_b530
	lms r3,[m_clipright]
rfn_b533
	dec r3
rfn_b534
	dec r3
rfn_b535
	with r3
rfn_b536
	cmp r1
rfn_b538
	bmi rfn_b55a
rfn_b53a
	nop
rfn_b53b
	getb
rfn_b53c
	inc r14
rfn_b53d
	getbh
rfn_b53f
	ibt r12,#$10
rfn_b541
	with r15
rfn_b542
	to r13
rfn_b543
	with r7
rfn_b544
	sub r9
rfn_b545
	bcc rfn_b54d
rfn_b547
	rol
rfn_b548
	loop
rfn_b549
	nop
rfn_b54a
	bra rfn_b503
rfn_b54c
	nop
rfn_b54d
	bcs rfn_b555
rfn_b54f
	nop
rfn_b550
	loop
rfn_b551
	inc r1
rfn_b552
	bra rfn_b503
rfn_b554
	nop
rfn_b555
	loop
rfn_b556
	plot
rfn_b557
	bra rfn_b503
rfn_b559
	nop
rfn_b55a
	with r6
rfn_b55b
	sub r8
rfn_b55c
	bcc rfn_b56a
rfn_b55e
	nop
rfn_b55f
	inc r4
rfn_b560
	ibt r3,#$10
rfn_b562
	from r4
rfn_b563
	sub r3
rfn_b564
	bne rfn_b55a
rfn_b566
	nop
rfn_b567
	bra rfn_b578
rfn_b569
	nop
rfn_b56a
	inc r2
rfn_b56b
	inc r4
rfn_b56c
	ibt r3,#$10
rfn_b56e
	from r4
rfn_b56f
	sub r3
rfn_b570
	beq rfn_b577
rfn_b572
	nop
rfn_b573
	iwt r15,#rfn_b4e6&WM
rfn_b576
	nop
rfn_b577
	nop
rfn_b578
	dec r10
rfn_b579
	dec r10
rfn_b57a
	to r15
rfn_b57b
	ldw [r10]
rfn_b57c
	nop
rfn_b57d
	with r6
rfn_b57e
	to r0
rfn_b57f
	with r2
rfn_b580
	to r6
rfn_b581
	cmp r6
rfn_b583
	bne rfn_b58c
rfn_b585
	nop
rfn_b586
	iwt r4,#$ffff
rfn_b589
	bra rfn_b593
rfn_b58b
	nop
rfn_b58c
	ibt r4,#$00
rfn_b58e
	link #4
rfn_b58f
	iwt r15,#mretail_sprdivide&WM
rfn_b592
	nop
rfn_b593
	with r4
rfn_b594
	to r9
rfn_b595
	with r4
rfn_b596
	to r8
rfn_b597
	cache
rfn_b598
	lms r2,[m_bigy]
rfn_b59b
	ibt r6,#$00
rfn_b59d
	ibt r4,#$00
rfn_b59f
	with r2
rfn_b5a0
	from r2
rfn_b5a1
	bpl rfn_b5a8
rfn_b5a3
	nop
rfn_b5a4
	iwt r15,#rfn_b67e&WM
rfn_b5a7
	nop
rfn_b5a8
	iwt r0,#$00bf
rfn_b5ab
	cmp r2
rfn_b5ad
	bpl rfn_b5b4
rfn_b5af
	nop
rfn_b5b0
	iwt r15,#rfn_b67e&WM
rfn_b5b3
	nop
rfn_b5b4
	lms r1,[m_bigx]
rfn_b5b7
	ibt r7,#$00
rfn_b5b9
	lms r5,[m_shapeptr]
rfn_b5bc
	lms r0,[m_shapebank]
rfn_b5bf
	romb
rfn_b5c1
	with r5
rfn_b5c2
	to r14
rfn_b5c3
	getb
rfn_b5c4
	inc r5
rfn_b5c5
	add r0
rfn_b5c6
	bne rfn_b5cd
rfn_b5c8
	nop
rfn_b5c9
	iwt r15,#rfn_b67e&WM
rfn_b5cc
	nop
rfn_b5cd
	ibt r3,#$14
rfn_b5cf
	from r3
rfn_b5d0
	romb
rfn_b5d2
	ibt r3,#$10
rfn_b5d4
	umult r3
rfn_b5d6
	iwt r3,#(mscalechars-$20)&WM
rfn_b5d9
	add r4
rfn_b5da
	add r4
rfn_b5db
	to r14
rfn_b5dc
	add r3
rfn_b5dd
	lms r0,[m_clipleft]
rfn_b5e0
	cmp r1
rfn_b5e2
	bmi rfn_b5e9
rfn_b5e4
	nop
rfn_b5e5
	iwt r15,#rfn_b66e&WM
rfn_b5e8
	nop
rfn_b5e9
	with r1
rfn_b5ea
	from r1
rfn_b5eb
	bpl rfn_b618
rfn_b5ed
	getb
rfn_b5ee
	inc r14
rfn_b5ef
	getbh
rfn_b5f1
	ibt r12,#$10
rfn_b5f3
	with r15
rfn_b5f4
	to r13
rfn_b5f5
	rol
rfn_b5f6
	bcs rfn_b603
rfn_b5f8
	nop
rfn_b5f9
	with r7
rfn_b5fa
	sub r9
rfn_b5fb
	bcs rfn_b5f9
rfn_b5fd
	inc r1
rfn_b5fe
	loop
rfn_b5ff
	nop
rfn_b600
	bra rfn_b5bc
rfn_b602
	nop
rfn_b603
	with r7
rfn_b604
	sub r9
rfn_b605
	bcs rfn_b603
rfn_b607
	inc r1
rfn_b608
	bmi rfn_b613
rfn_b60a
	nop
rfn_b60b
	iwt r13,#rfn_b629&WM
rfn_b60e
	loop
rfn_b60f
	nop
rfn_b610
	bra rfn_b5bc
rfn_b612
	nop
rfn_b613
	loop
rfn_b614
	nop
rfn_b615
	bra rfn_b5bc
rfn_b617
	nop
rfn_b618
	inc r14
rfn_b619
	lms r3,[m_clipright]
rfn_b61c
	dec r3
rfn_b61d
	with r3
rfn_b61e
	cmp r1
rfn_b620
	bmi rfn_b642
rfn_b622
	nop
rfn_b623
	getbh
rfn_b625
	ibt r12,#$10
rfn_b627
	with r15
rfn_b628
	to r13
rfn_b629
	rol
rfn_b62a
	bcs rfn_b637
rfn_b62c
	nop
rfn_b62d
	with r7
rfn_b62e
	sub r9
rfn_b62f
	bcs rfn_b62d
rfn_b631
	inc r1
rfn_b632
	loop
rfn_b633
	nop
rfn_b634
	bra rfn_b5bc
rfn_b636
	nop
rfn_b637
	with r7
rfn_b638
	sub r9
rfn_b639
	bcs rfn_b637
rfn_b63b
	plot
rfn_b63c
	loop
rfn_b63d
	nop
rfn_b63e
	iwt r15,#rfn_b5bc&WM
rfn_b641
	nop
rfn_b642
	getbh
rfn_b644
	iwt r3,#$00df
rfn_b647
	ibt r12,#$10
rfn_b649
	with r15
rfn_b64a
	to r13
rfn_b64b
	rol
rfn_b64c
	bcs rfn_b65f
rfn_b64e
	nop
rfn_b64f
	with r7
rfn_b650
	sub r9
rfn_b651
	bcs rfn_b64f
rfn_b653
	inc r1
rfn_b654
	with r1
rfn_b655
	cmp r3
rfn_b657
	bpl rfn_b67e
rfn_b659
	nop
rfn_b65a
	loop
rfn_b65b
	nop
rfn_b65c
	bra rfn_b67e
rfn_b65e
	nop
rfn_b65f
	with r1
rfn_b660
	cmp r3
rfn_b662
	bpl rfn_b67e
rfn_b664
	with r7
rfn_b665
	sub r9
rfn_b666
	bcs rfn_b65f
rfn_b668
	plot
rfn_b669
	loop
rfn_b66a
	nop
rfn_b66b
	bra rfn_b67e
rfn_b66d
	nop
rfn_b66e
	lms r3,[m_sprsize]
rfn_b671
	with r1
rfn_b672
	add r3
rfn_b673
	with r7
rfn_b674
	sub r9
rfn_b675
	bcc rfn_b679
rfn_b677
	nop
rfn_b678
	inc r1
rfn_b679
	iwt r15,#rfn_b5bc&WM
rfn_b67c
	nop
rfn_b67d
	nop
rfn_b67e
	nop
rfn_b67f
	inc r2
rfn_b680
	with r6
rfn_b681
	sub r8
rfn_b682
	bcc rfn_b689
rfn_b684
	nop
rfn_b685
	iwt r15,#rfn_b59f&WM
rfn_b688
	nop
rfn_b689
	inc r4
rfn_b68a
	ibt r3,#$10
rfn_b68c
	from r4
rfn_b68d
	sub r3
rfn_b68e
	beq rfn_b695
rfn_b690
	nop
rfn_b691
	iwt r15,#rfn_b59f&WM
rfn_b694
	nop
rfn_b695
	dec r10
rfn_b696
	dec r10
rfn_b697
	to r15
rfn_b698
	ldw [r10]
rfn_b699
	nop
mretail_copyface
rfn_b69a
	sub r0
rfn_b69b
	ramb
rfn_b69d
	romb
rfn_b69f
	cache
rfn_b6a0
	lms r4,[m_bigx]
rfn_b6a3
	iwt r0,#$0100
rfn_b6a6
	umult r4
rfn_b6a8
	add r0
rfn_b6a9
	to r4
rfn_b6aa
	add r0
rfn_b6ab
	lms r0,[m_bigy]
rfn_b6ae
	umult #4
rfn_b6b0
	add r4
rfn_b6b1
	iwt r4,#bitmap1&WM
rfn_b6b4
	to r4
rfn_b6b5
	add r4
rfn_b6b6
	iwt r5,#$0400
rfn_b6b9
	lms r14,[m_faceptr]
rfn_b6bc
	ibt r3,#$04
rfn_b6be
	with r4
rfn_b6bf
	to r1
rfn_b6c0
	ibt r12,#$50
rfn_b6c2
	with r15
rfn_b6c3
	to r13
rfn_b6c4
	getb
rfn_b6c5
	inc r14
rfn_b6c6
	getbh
rfn_b6c8
	inc r14
rfn_b6c9
	stw [r1]
rfn_b6ca
	inc r1
rfn_b6cb
	loop
rfn_b6cc
	inc r1
rfn_b6cd
	with r4
rfn_b6ce
	add r5
rfn_b6cf
	dec r3
rfn_b6d0
	bne rfn_b6be
rfn_b6d2
	nop
rfn_b6d3
	stop
rfn_b6d4
	nop
mrfont_end
