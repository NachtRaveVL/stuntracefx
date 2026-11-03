; Retail object flags and depth cue selection, before geometry setup.
; R7 low byte selects the alternate shade group; replaces the native scene byte.
; R10/R11 use the existing bank-0 software stack. m_depthoffset low byte is
; 0 for caller thresholds at m_depthtable, or 1..10 for the retail presets.
; m_depthstab is the caller depth-colour base. Use bank 3 for the generic
; material decoder, or bind a scene palette with mretail_binddepth.
; The shade pointers cover indices 0..21. This call does not draw a shape.
mrshade_begin
mretail_shadesetup
rsh_8561
	lms r0,[m_shadowpass]
rsh_8564
	lob
rsh_8565
	beq rsh_8584
rsh_8567
	nop
rsh_8568
	from r11
rsh_8569
	stw [r10]
rsh_856a
	inc r10
rsh_856b
	inc r10
rsh_856c
	link #4
rsh_856d
	iwt r15,#rsh_8576&WM
rsh_8570
	nop
rsh_8571
	dec r10
rsh_8572
	dec r10
rsh_8573
	to r15
rsh_8574
	ldw [r10]
rsh_8575
	nop
rsh_8576
	iwt r2,#$1000
rsh_8579
	iwt r1,#$2000
rsh_857c
	lms r0,[m_objflags]
rsh_857f
	and r2
rsh_8580
	or r1
rsh_8581
	bra rsh_858f
rsh_8583
	nop
rsh_8584
	from r11
rsh_8585
	stw [r10]
rsh_8586
	inc r10
rsh_8587
	inc r10
rsh_8588
	dec r10
rsh_8589
	dec r10
rsh_858a
	to r11
rsh_858b
	ldw [r10]
rsh_858c
	iwt r0,#$8000
rsh_858f
	sms [m_objflags],r0
rsh_8592
	from r11
rsh_8593
	stw [r10]
rsh_8594
	inc r10
rsh_8595
	inc r10
rsh_8596
	ibt r0,#$03
rsh_8598
	romb
rsh_859a
	iwt r0,#$08aa
rsh_859d
	sms [m_tr2],r0
rsh_85a0
	ibt r0,#$03
rsh_85a2
	romb
rsh_85a4
	lms r14,[m_depthtable]
rsh_85a7
	lms r0,[m_depthoffset]
rsh_85aa
	lob
rsh_85ab
	beq rsh_85b6
rsh_85ad
	nop
rsh_85ae
	dec r0
rsh_85af
	add r0
rsh_85b0
	add r0
rsh_85b1
	iwt r2,#retail_shdepth&WM
rsh_85b4
	to r14
rsh_85b5
	add r2
rsh_85b6
	with r7
	to r0
	nop
	nop
rsh_85ba
	lob
rsh_85bb
	beq rsh_8609
rsh_85bd
	sub r0
rsh_85be
	lms r1,[m_bigz]
rsh_85c1
	getbh
rsh_85c3
	inc r14
rsh_85c4
	add r1
rsh_85c5
	bpl rsh_85d2
rsh_85c7
	nop
rsh_85c8
	iwt r0,#retail_shgroup4&WM
rsh_85cb
	iwt r2,#$0000
rsh_85ce
	iwt r15,#rsh_85fc&WM
rsh_85d1
	nop
rsh_85d2
	sub r0
rsh_85d3
	getbh
rsh_85d5
	inc r14
rsh_85d6
	add r1
rsh_85d7
	bpl rsh_85e4
rsh_85d9
	nop
rsh_85da
	iwt r0,#retail_shgroup5&WM
rsh_85dd
	iwt r2,#$0088
rsh_85e0
	iwt r15,#rsh_85fc&WM
rsh_85e3
	nop
rsh_85e4
	sub r0
rsh_85e5
	getbh
rsh_85e7
	inc r14
rsh_85e8
	add r1
rsh_85e9
	bpl rsh_85f6
rsh_85eb
	nop
rsh_85ec
	iwt r0,#retail_shgroup6&WM
rsh_85ef
	iwt r2,#$0110
rsh_85f2
	iwt r15,#rsh_85fc&WM
rsh_85f5
	nop
rsh_85f6
	iwt r0,#retail_shgroup7&WM
rsh_85f9
	iwt r2,#$0198
rsh_85fc
	sms [m_shadestab],r0
rsh_85ff
	lms r0,[m_depthstab]
rsh_8602
	add r2
rsh_8603
	sms [m_depthsptr],r0
rsh_8606
	bra rsh_8651
rsh_8608
	nop
rsh_8609
	lms r1,[m_bigz]
rsh_860c
	getbh
rsh_860e
	inc r14
rsh_860f
	add r1
rsh_8610
	bpl rsh_861d
rsh_8612
	nop
rsh_8613
	iwt r0,#retail_shgroup0&WM
rsh_8616
	iwt r2,#$0000
rsh_8619
	iwt r15,#rsh_8647&WM
rsh_861c
	nop
rsh_861d
	sub r0
rsh_861e
	getbh
rsh_8620
	inc r14
rsh_8621
	add r1
rsh_8622
	bpl rsh_862f
rsh_8624
	nop
rsh_8625
	iwt r0,#retail_shgroup1&WM
rsh_8628
	iwt r2,#$0088
rsh_862b
	iwt r15,#rsh_8647&WM
rsh_862e
	nop
rsh_862f
	sub r0
rsh_8630
	getbh
rsh_8632
	inc r14
rsh_8633
	add r1
rsh_8634
	bpl rsh_8641
rsh_8636
	nop
rsh_8637
	iwt r0,#retail_shgroup2&WM
rsh_863a
	iwt r2,#$0110
rsh_863d
	iwt r15,#rsh_8647&WM
rsh_8640
	nop
rsh_8641
	iwt r0,#retail_shgroup3&WM
rsh_8644
	iwt r2,#$0198
rsh_8647
	sms [m_shadestab],r0
rsh_864a
	lms r0,[m_depthstab]
rsh_864d
	add r2
rsh_864e
	sms [m_depthsptr],r0
rsh_8651
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
mrshade_end
