; Retail sorted draw-list consumer ($01:AB81-AD67).
; Main pass, with the retail record flags and the existing 30-byte records.
; Task inputs: R7 scene shade selector (0/1), R8/R9 queue base/exclusive limit.
; Queue storage, screen mode, clipping, depth thresholds and pixel assets
; belong to the caller. The list must be the linked output of the sorter.
; Particle draw records allocate/show using the 20-slot retail pool.
; Age the pool via the separate update task. Camera and HUD are separate.
mrlist_begin
mretail_renderlist
	sub r0
	ramb
	iwt r10,#m_stack&WM
	sms [m_shadowpass],r0
	from r7
	stw [r10]
	inc r10
	inc r10
	from r8
	stw [r10]
	inc r10
	inc r10
	from r9
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#rrl_binddepth&WM
	nop
	link #4
	iwt r15,#rrl_clear&WM
	nop
	link #4
	iwt r15,#rrl_ab81&WM
	nop
	iwt r10,#m_stack&WM
	sub r0
	cmode
	rpix
	stop
	nop
rrl_ab81
	lm r1,[m_dlptr]
rrl_ab85
	with r1
rrl_ab86
	from r1
rrl_ab87
	bne rrl_ab8c
rrl_ab89
	nop
rrl_ab8a
	jmp r11
rrl_ab8b
	nop
rrl_ab8c
	from r11
rrl_ab8d
	stw [r10]
rrl_ab8e
	inc r10
rrl_ab8f
	inc r10
rrl_ab90
	sub r0
rrl_ab91
	romb
rrl_ab93
	sub r0
rrl_ab94
	cmode
rrl_ab96
	sms [m_numpnts],r0
rrl_ab99
	from r1
rrl_ab9a
	stw [r10]
rrl_ab9b
	inc r10
rrl_ab9c
	inc r10
rrl_ab9d
	inc r1
rrl_ab9e
	inc r1
rrl_ab9f
	inc r1
rrl_aba0
	inc r1
rrl_aba1
	ldb [r1]
rrl_aba3
	sms [m_rotx],r0
rrl_aba6
	inc r1
rrl_aba7
	ldb [r1]
rrl_aba9
	sms [m_roty],r0
rrl_abac
	inc r1
rrl_abad
	ldb [r1]
rrl_abaf
	sms [m_rotz],r0
rrl_abb2
	inc r1
rrl_abb3
	to r4
rrl_abb4
	ldb [r1]
rrl_abb6
	inc r1
rrl_abb7
	to r3
rrl_abb8
	ldw [r1]
rrl_abb9
	with r3
rrl_abba
	from r3
rrl_abbb
	bne rrl_abc2
rrl_abbd
	nop
rrl_abbe
	iwt r15,#rrl_ad53&WM
rrl_abc1
	nop
rrl_abc2
	inc r1
rrl_abc3
	inc r1
rrl_abc4
	inc r1
rrl_abc5
	inc r1
rrl_abc6
	inc r1
rrl_abc7
	inc r1
rrl_abc8
	inc r1
rrl_abc9
	inc r1
rrl_abca
	ldw [r1]
rrl_abcb
	sms [m_bigy],r0
rrl_abce
	inc r1
rrl_abcf
	inc r1
rrl_abd0
	ldw [r1]
rrl_abd1
	sms [m_bigx],r0
rrl_abd4
	inc r1
rrl_abd5
	inc r1
rrl_abd6
	ldw [r1]
rrl_abd7
	sms [m_bigz],r0
rrl_abda
	with r0
rrl_abdb
	to r6
rrl_abdc
	inc r1
rrl_abdd
	inc r1
rrl_abde
	iwt r5,#$0004
rrl_abe1
	from r4
rrl_abe2
	and r5
rrl_abe3
	beq rrl_ac31
rrl_abe5
	nop
rrl_abe6
	ibt r0,#-12
rrl_abe8
	to r1
rrl_abe9
	add r1
rrl_abea
	ldw [r1]
rrl_abeb
	sms [m_numgroups],r0
rrl_abee
	inc r1
rrl_abef
	inc r1
rrl_abf0
	ldb [r1]
rrl_abf2
	lob
rrl_abf3
	sms [m_groupnum],r0
rrl_abf6
	inc r1
rrl_abf7
	ldb [r1]
rrl_abf9
	lob
rrl_abfa
	sms [m_grouptab],r0
rrl_abfd
	inc r1
rrl_abfe
	ldb [r1]
rrl_ac00
	lob
rrl_ac01
	ibt r5,#$07
rrl_ac03
	and r5
rrl_ac04
	bne rrl_ac09
rrl_ac06
	nop
rrl_ac07
	ibt r0,#-1
rrl_ac09
	sms [m_numpnts],r0
rrl_ac0c
	lms r0,[m_numpnts]
rrl_ac0f
	with r0
rrl_ac10
	from r0
rrl_ac11
	beq rrl_ac2d
rrl_ac13
	nop
rrl_ac14
	bmi rrl_ac25
rrl_ac16
	nop
rrl_ac17
	lms r1,[m_grouptab]
rrl_ac1a
	lms r2,[m_numgroups]
rrl_ac1d
	lms r3,[m_groupnum]
rrl_ac20
	link #4
rrl_ac21
	iwt r15,#mretail_makeparticles&WM
rrl_ac24
	nop
rrl_ac25
	lms r2,[m_numgroups]
rrl_ac28
	link #4
rrl_ac29
	iwt r15,#mretail_showparticles&WM
rrl_ac2c
	nop
rrl_ac2d
	iwt r15,#rrl_ad53&WM
rrl_ac30
	nop
rrl_ac31
	ibt r5,#$02
rrl_ac33
	from r4
rrl_ac34
	and r5
rrl_ac35
	beq rrl_ac48
rrl_ac37
	nop
rrl_ac38
	ibt r5,#$08
rrl_ac3a
	from r4
rrl_ac3b
	and r5
rrl_ac3c
	bne rrl_ac48
rrl_ac3e
	nop
rrl_ac3f
	iwt r5,#white_c&WM
rrl_ac42
	sms [m_colourptr],r5
rrl_ac45
	bra rrl_ac6d
rrl_ac47
	nop
rrl_ac48
	ldw [r1]
rrl_ac49
	with r0
rrl_ac4a
	from r0
rrl_ac4b
	bne rrl_ac6a
rrl_ac4d
	nop
rrl_ac4e
	ibt r14,#$12
rrl_ac50
	from r3
rrl_ac51
	to r14
rrl_ac52
	add r14
rrl_ac53
	getb
rrl_ac54
	inc r14
rrl_ac55
	getbh
rrl_ac57
	iwt r5,#id_0_c&WM
rrl_ac5a
	cmp r5
rrl_ac5c
	bne rrl_ac6a
rrl_ac5e
	nop
rrl_ac5f
	lm r5,[m_defaultID]
rrl_ac63
	with r5
rrl_ac64
	from r5
rrl_ac65
	beq rrl_ac6a
rrl_ac67
	nop
rrl_ac68
	with r5
rrl_ac69
	to r0
rrl_ac6a
	sms [m_colourptr],r0
rrl_ac6d
	inc r1
rrl_ac6e
	inc r1
rrl_ac6f
	ibt r14,#$07
rrl_ac71
	from r3
rrl_ac72
	to r14
rrl_ac73
	add r14
rrl_ac74
	getb
rrl_ac75
	sms [m_shift],r0
rrl_ac78
	from r3
rrl_ac79
	stw [r10]
rrl_ac7a
	inc r10
rrl_ac7b
	inc r10
rrl_ac7c
	with r6
rrl_ac7d
	to r0
rrl_ac7e
	iwt r5,#$0bb8
rrl_ac81
	cmp r5
rrl_ac83
	bcs rrl_ac99
rrl_ac85
	nop
rrl_ac86
	iwt r5,#$07d0
rrl_ac89
	cmp r5
rrl_ac8b
	bcs rrl_aca7
rrl_ac8d
	nop
rrl_ac8e
	iwt r5,#$03e8
rrl_ac91
	cmp r5
rrl_ac93
	bcs rrl_acb5
rrl_ac95
	nop
rrl_ac96
	bra rrl_acc0
rrl_ac98
	nop
rrl_ac99
	ibt r14,#$1a
rrl_ac9b
	from r3
rrl_ac9c
	to r14
rrl_ac9d
	add r14
rrl_ac9e
	to r3
rrl_ac9f
	getb
rrl_aca0
	inc r14
rrl_aca1
	with r3
rrl_aca2
	getbh
rrl_aca4
	bra rrl_acc0
rrl_aca6
	nop
rrl_aca7
	ibt r14,#$18
rrl_aca9
	from r3
rrl_acaa
	to r14
rrl_acab
	add r14
rrl_acac
	to r3
rrl_acad
	getb
rrl_acae
	inc r14
rrl_acaf
	with r3
rrl_acb0
	getbh
rrl_acb2
	bra rrl_acc0
rrl_acb4
	nop
rrl_acb5
	ibt r14,#$16
rrl_acb7
	from r3
rrl_acb8
	to r14
rrl_acb9
	add r14
rrl_acba
	to r3
rrl_acbb
	getb
rrl_acbc
	inc r14
rrl_acbd
	with r3
rrl_acbe
	getbh
rrl_acc0
	ibt r14,#$00
rrl_acc2
	from r3
rrl_acc3
	to r14
rrl_acc4
	add r14
rrl_acc5
	getb
rrl_acc6
	inc r14
rrl_acc7
	getbh
rrl_acc9
	sms [m_pntptr],r0
rrl_accc
	ibt r14,#$02
rrl_acce
	from r3
rrl_accf
	to r14
rrl_acd0
	add r14
rrl_acd1
	getb
rrl_acd2
	sms [m_shapebank],r0
rrl_acd5
	ibt r14,#$03
rrl_acd7
	from r3
rrl_acd8
	to r14
rrl_acd9
	add r14
rrl_acda
	getb
rrl_acdb
	inc r14
rrl_acdc
	getbh
rrl_acde
	sms [m_faceptr],r0
rrl_ace1
	dec r10
rrl_ace2
	dec r10
rrl_ace3
	to r3
rrl_ace4
	ldw [r10]
rrl_ace5
	ldb [r1]
rrl_ace7
	inc r1
rrl_ace8
	sms [m_expcnt],r0
rrl_aceb
	ldb [r1]
rrl_aced
	sms [m_framenum],r0
rrl_acf0
	inc r1
rrl_acf1
	ldb [r1]
rrl_acf3
	sms [m_colframe],r0
rrl_acf6
	inc r1
rrl_acf7
	ibt r5,#$08
rrl_acf9
	from r4
rrl_acfa
	and r5
rrl_acfb
	beq rrl_ad31
rrl_acfd
	nop
rrl_acfe
	lms r0,[m_shadowpass]
rrl_ad01
	lob
rrl_ad02
	bne rrl_ad31
rrl_ad04
	nop
rrl_ad05
	sub r0
rrl_ad06
	romb
rrl_ad08
	ibt r14,#$10
rrl_ad0a
	from r3
rrl_ad0b
	to r14
rrl_ad0c
	add r14
rrl_ad0d
	getb
rrl_ad0e
	inc r14
rrl_ad0f
	getbh
rrl_ad11
	sms [m_spra],r0
rrl_ad14
	ldb [r1]
rrl_ad16
	sms [m_spr0],r0
rrl_ad19
	inc r1
rrl_ad1a
	ldb [r1]
rrl_ad1c
	sex
rrl_ad1d
	sms [m_sprxscale],r0
rrl_ad20
	lms r0,[m_pntptr]
rrl_ad23
	with r0
rrl_ad24
	from r0
rrl_ad25
	beq rrl_ad2d
rrl_ad27
	nop
rrl_ad28
	link #4
rrl_ad29
	iwt r15,#rrl_sprite&WM
rrl_ad2c
	nop
rrl_ad2d
	iwt r15,#rrl_ad53&WM
rrl_ad30
	nop
rrl_ad31
	ldb [r1]
rrl_ad33
	sms [m_depthoffset],r0
rrl_ad36
	inc r1
rrl_ad37
	sub r0
rrl_ad38
	ldb [r1]
rrl_ad3a
	swap
rrl_ad3b
	sms [m_sprxscroll],r0
rrl_ad3e
	inc r1
rrl_ad3f
	ldb [r1]
rrl_ad41
	swap
rrl_ad42
	sms [m_spryscroll],r0
rrl_ad45
	inc r1
rrl_ad46
	lms r0,[m_faceptr]
rrl_ad49
	with r0
rrl_ad4a
	from r0
rrl_ad4b
	beq rrl_ad53
rrl_ad4d
	nop
rrl_ad4e
	link #4
rrl_ad4f
	iwt r15,#rrl_shape&WM
rrl_ad52
	nop
rrl_ad53
	dec r10
rrl_ad54
	dec r10
rrl_ad55
	to r1
rrl_ad56
	ldw [r10]
rrl_ad57
	to r1
rrl_ad58
	ldw [r1]
rrl_ad59
	with r1
rrl_ad5a
	from r1
rrl_ad5b
	beq rrl_ad62
rrl_ad5d
	nop
rrl_ad5e
	iwt r15,#rrl_ab90&WM
rrl_ad61
	nop
rrl_ad62
	nop
rrl_ad63
	dec r10
rrl_ad64
	dec r10
rrl_ad65
	to r15
rrl_ad66
	ldw [r10]
rrl_ad67
	nop
; The list frame owns scene/base/limit. Two native words (return and
; current list record) follow them, plus this adapter's return word.
rrl_shape
	from r11
	stw [r10]
	inc r10
	inc r10
	ibt r7,#-12
	with r7
	add r10
	to r7
	ldw [r7]
	link #4
	iwt r15,#rrl_geometry&WM
	nop
	ibt r6,#-10
	with r6
	add r10
	to r8
	ldw [r6]
	inc r6
	inc r6
	to r9
	ldw [r6]
	link #4
	iwt r15,#mretail_drawshape&WM
	nop
	dec r10
	dec r10
	to r11
	ldw [r10]
rrl_shape_return
	jmp r11
	nop
rrl_geometry
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#rrl_return29&WM
	iwt r13,#mretail_shadegeometry>>16
	iwt r12,#mretail_shadegeometry&WM
	from r12
	ljmp r13
	nop
rrl_sprite
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#rrl_return29&WM
	iwt r13,#mretail_ssprite>>16
	iwt r12,#mretail_ssprite&WM
	from r12
	ljmp r13
	nop
rrl_binddepth
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#rrl_return29&WM
	with r7
	to r0
	iwt r13,#mretail_binddepth>>16
	iwt r12,#mretail_binddepth&WM
	from r12
	ljmp r13
	nop
rrl_clear
	lms r0,[m_clrbitmaps]
	lob
	beq rrl_clear_done
	nop
	sub r0
	lm r1,[m_bitmapbase]
	iwt r12,#gameBMPSZ/2
	cache
	with r15
	to r13
	stw [r1]
	inc r1
	loop
	inc r1
rrl_clear_done
	jmp r11
	nop
rrl_return30
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
mrlist_end
