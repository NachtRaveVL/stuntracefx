; Retail draw-list world rotation, sphere culling and insertion sort.
; US $01:AEF8-B026. Uses the existing 30-byte draw records and matrix.
; Count is the low byte of m_numshapes; shape headers are in ROM bank0.
; The $80 flag bypasses rotation. Equal sort keys insert newest first.
; GSU/ROM/RAM ownership and shape bindings belong to the caller.
mrsort_begin
mretail_sortdrawlist
rst_aef8
	sub r0
rst_aef9
	romb
rst_aefb
	sm [m_dlptr],r0
rst_aeff
	iwt r9,#m_drawlist&WM
rst_af02
	lms r12,[m_numshapes]
rst_af05
	with r12
rst_af06
	lob
rst_af07
	bne rst_af0c
rst_af09
	nop
rst_af0a
	stop
rst_af0b
	nop
rst_af0c
	cache
rst_af0d
	with r15
rst_af0e
	to r13
rst_af0f
	ibt r8,#$07
rst_af11
	with r8
rst_af12
	add r9
rst_af13
	ldb [r8]
rst_af15
	iwt r1,#$0080
rst_af18
	and r1
rst_af19
	bne rst_af7f
rst_af1b
	nop
rst_af1c
	ibt r8,#$12
rst_af1e
	with r8
rst_af1f
	add r9
rst_af20
	to r1
rst_af21
	ldw [r8]
rst_af22
	ibt r8,#$10
rst_af24
	with r8
rst_af25
	add r9
rst_af26
	to r2
rst_af27
	ldw [r8]
rst_af28
	ibt r8,#$14
rst_af2a
	with r8
rst_af2b
	add r9
rst_af2c
	to r3
rst_af2d
	ldw [r8]
rst_af2e
	lms r6,[m_wmat11]
rst_af31
	from r1
rst_af32
	fmult
rst_af33
	to r5
rst_af34
	rol
rst_af35
	lms r6,[m_wmat21]
rst_af38
	from r2
rst_af39
	fmult
rst_af3a
	rol
rst_af3b
	with r5
rst_af3c
	add r0
rst_af3d
	lms r6,[m_wmat31]
rst_af40
	from r3
rst_af41
	fmult
rst_af42
	rol
rst_af43
	add r5
rst_af44
	ibt r8,#$12
rst_af46
	with r8
rst_af47
	add r9
rst_af48
	stw [r8]
rst_af49
	lms r6,[m_wmat12]
rst_af4c
	from r1
rst_af4d
	fmult
rst_af4e
	to r5
rst_af4f
	rol
rst_af50
	lms r6,[m_wmat22]
rst_af53
	from r2
rst_af54
	fmult
rst_af55
	rol
rst_af56
	with r5
rst_af57
	add r0
rst_af58
	lms r6,[m_wmat32]
rst_af5b
	from r3
rst_af5c
	fmult
rst_af5d
	rol
rst_af5e
	add r5
rst_af5f
	ibt r8,#$10
rst_af61
	with r8
rst_af62
	add r9
rst_af63
	stw [r8]
rst_af64
	lms r6,[m_wmat13]
rst_af67
	from r1
rst_af68
	fmult
rst_af69
	to r5
rst_af6a
	rol
rst_af6b
	lms r6,[m_wmat23]
rst_af6e
	from r2
rst_af6f
	fmult
rst_af70
	rol
rst_af71
	with r5
rst_af72
	add r0
rst_af73
	lms r6,[m_wmat33]
rst_af76
	from r3
rst_af77
	fmult
rst_af78
	rol
rst_af79
	add r5
rst_af7a
	ibt r8,#$14
rst_af7c
	with r8
rst_af7d
	add r9
rst_af7e
	stw [r8]
rst_af7f
	ibt r8,#$08
rst_af81
	with r8
rst_af82
	add r9
rst_af83
	ldw [r8]
rst_af84
	ibt r14,#$10
rst_af86
	with r14
rst_af87
	add r0
rst_af88
	to r1
rst_af89
	getb
rst_af8a
	inc r14
rst_af8b
	with r1
rst_af8c
	getbh
rst_af8e
	ibt r8,#$14
rst_af90
	with r8
rst_af91
	add r9
rst_af92
	to r3
rst_af93
	ldw [r8]
rst_af94
	from r3
rst_af95
	add r1
rst_af96
	bpl rst_af9d
rst_af98
	nop
rst_af99
	iwt r15,#rst_b01f&WM
rst_af9c
	nop
rst_af9d
	with r3
rst_af9e
	from r3
rst_af9f
	bpl rst_afa5
rst_afa1
	nop
rst_afa2
	with r3
rst_afa3
	not
rst_afa4
	inc r3
rst_afa5
	ibt r8,#$12
rst_afa7
	with r8
rst_afa8
	add r9
rst_afa9
	ldw [r8]
rst_afaa
	with r0
rst_afab
	from r0
rst_afac
	bpl rst_afb1
rst_afae
	nop
rst_afaf
	not
rst_afb0
	inc r0
rst_afb1
	sub r1
rst_afb2
	cmp r3
rst_afb4
	bmi rst_afbb
rst_afb6
	nop
rst_afb7
	iwt r15,#rst_b01f&WM
rst_afba
	nop
rst_afbb
	ibt r8,#$08
rst_afbd
	with r8
rst_afbe
	add r9
rst_afbf
	ldw [r8]
rst_afc0
	iwt r1,#$0005
rst_afc3
	to r14
rst_afc4
	add r1
rst_afc5
	getb
rst_afc6
	inc r14
rst_afc7
	ibt r8,#$14
rst_afc9
	with r8
rst_afca
	add r9
rst_afcb
	to r1
rst_afcc
	ldw [r8]
rst_afcd
	getbh
rst_afcf
	to r1
rst_afd0
	add r1
rst_afd1
	ibt r8,#$02
rst_afd3
	with r8
rst_afd4
	add r9
rst_afd5
	ldw [r8]
rst_afd6
	to r1
rst_afd7
	add r1
rst_afd8
	ibt r2,#$00
rst_afda
	lm r7,[m_dlptr]
rst_afde
	with r7
rst_afdf
	from r7
rst_afe0
	bne rst_afec
rst_afe2
	nop
rst_afe3
	sm [m_dlptr],r9
rst_afe7
	with r2
rst_afe8
	to r7
rst_afe9
	bra rst_b013
rst_afeb
	nop
rst_afec
	inc r7
rst_afed
	inc r7
rst_afee
	ldw [r7]
rst_afef
	dec r7
rst_aff0
	dec r0
rst_aff1
	cmp r1
rst_aff3
	bpl rst_b007
rst_aff5
	dec r7
rst_aff6
	with r2
rst_aff7
	from r2
rst_aff8
	bne rst_b002
rst_affa
	nop
rst_affb
	sm [m_dlptr],r9
rst_afff
	bra rst_b013
rst_b001
	nop
rst_b002
	from r9
rst_b003
	stw [r2]
rst_b004
	bra rst_b013
rst_b006
	nop
rst_b007
	with r7
rst_b008
	to r2
rst_b009
	to r7
rst_b00a
	ldw [r7]
rst_b00b
	with r7
rst_b00c
	from r7
rst_b00d
	bne rst_afec
rst_b00f
	nop
rst_b010
	bra rst_b002
rst_b012
	nop
rst_b013
	ibt r8,#$02
rst_b015
	with r8
rst_b016
	add r9
rst_b017
	from r1
rst_b018
	stw [r8]
rst_b019
	ibt r8,#$00
rst_b01b
	with r8
rst_b01c
	add r9
rst_b01d
	from r7
rst_b01e
	stw [r8]
rst_b01f
	ibt r0,#$1e
rst_b021
	to r9
rst_b022
	add r9
rst_b023
	loop
rst_b024
	nop
rst_b025
	stop
rst_b026
	nop
mrsort_end
