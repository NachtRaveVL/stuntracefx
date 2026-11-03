; Project an already decoded retail shape and switch to the face stream.
; m_numpnts must be 1..70, points start at m_rotpnts. Shape bank/pointers,
; translation and clip limits must be initialized. R14 is the point cursor.
; The stream entry first decodes the verified point commands, then projects
; if the boundary opcode is $0c. Both entries restore R10/R11.
; R1 = 0 other point opcode, 1 face opcode, 2 shape rejected.
; R0 = boundary opcode, or zero if rejected; R14 follows a fetched opcode.
mrproj_begin
mretail_shapestream
	from r11
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#mretail_pointstream&WM
	nop
	ibt r1,#$0c
	cmp r1
	beq rpj_8baa
	nop
	ibt r1,#0
	iwt r15,#rpj_exit&WM
	nop
mretail_projectshape
	from r11
	stw [r10]
	inc r10
	inc r10
rpj_8baa
	iwt r15,#rpj_8c89&WM
rpj_8bad
	nop
rpj_8bae
	lms r12,[m_numpnts]
rpj_8bb1
	ibt r0,#$14
rpj_8bb3
	romb
rpj_8bb5
	iwt r7,#m_rotpnts&WM
rpj_8bb8
	sms [m_shapeptr],r14
rpj_8bbb
	iwt r8,#m_projpnts&WM
rpj_8bbe
	sub r0
rpj_8bbf
	sms [m_or_of_outcodes],r0
rpj_8bc2
	lms r9,[m_bigz]
rpj_8bc5
	lms r3,[m_bigx]
rpj_8bc8
	lms r13,[m_bigy]
rpj_8bcb
	cache
rpj_8bcc
	ldw [r7]
rpj_8bcd
	inc r7
rpj_8bce
	inc r7
rpj_8bcf
	to r1
rpj_8bd0
	add r3
rpj_8bd1
	ldw [r7]
rpj_8bd2
	inc r7
rpj_8bd3
	inc r7
rpj_8bd4
	to r2
rpj_8bd5
	add r13
rpj_8bd6
	ldw [r7]
rpj_8bd7
	inc r7
rpj_8bd8
	inc r7
rpj_8bd9
	to r6
rpj_8bda
	add r9
rpj_8bdb
	link #4
rpj_8bdc
	iwt r15,#rpj_8bff&WM
rpj_8bdf
	nop
rpj_8be0
	from r1
rpj_8be1
	stw [r8]
rpj_8be2
	inc r8
rpj_8be3
	inc r8
rpj_8be4
	from r2
rpj_8be5
	stw [r8]
rpj_8be6
	inc r8
rpj_8be7
	inc r8
rpj_8be8
	stw [r8]
rpj_8be9
	inc r8
rpj_8bea
	inc r8
rpj_8beb
	lms r6,[m_or_of_outcodes]
rpj_8bee
	or r6
rpj_8bef
	dec r12
rpj_8bf0
	bne rpj_8bcc
rpj_8bf2
	sbk
rpj_8bf3
	lms r0,[m_shapebank]
rpj_8bf6
	romb
rpj_8bf8
	lms r14,[m_shapeptr]
rpj_8bfb
	iwt r15,#rpj_8c79&WM
rpj_8bfe
	nop
rpj_8bff
	iwt r0,#$4400
rpj_8c02
	sub r6
rpj_8c03
	bpl rpj_8c0e
rpj_8c05
	nop
rpj_8c06
	with r1
rpj_8c07
	asr
rpj_8c08
	with r2
rpj_8c09
	asr
rpj_8c0a
	with r6
rpj_8c0b
	bra rpj_8bff
rpj_8c0d
	asr
rpj_8c0e
	iwt r0,#$0100
rpj_8c11
	sub r6
rpj_8c12
	bpl rpj_8c5c
rpj_8c14
	nop
rpj_8c15
	with r6
rpj_8c16
	bic #1
rpj_8c18
	iwt r14,#$4300
	from r6
	cmp r14
	bcc rpj_base_8c18
	nop
	ibt r0,#retail_spriteztail>>16
	from r0
	romb
	iwt r0,#(retail_spriteztail-$4300)&WM
	bra rpj_have_8c18
	nop
rpj_base_8c18
	ibt r0,#ztab>>16
	from r0
	romb
	iwt r0,#ztab&WM
rpj_have_8c18
rpj_8c1b
	to r14
rpj_8c1c
	add r6
rpj_8c1d
	to r6
rpj_8c1e
	getb
rpj_8c1f
	inc r14
rpj_8c20
	with r6
rpj_8c21
	getbh
rpj_8c23
	from r1
rpj_8c24
	fmult
rpj_8c25
	lms r1,[m_vanishx]
rpj_8c28
	add r1
rpj_8c29
	with r0
rpj_8c2a
	to r1
rpj_8c2b
	from r2
rpj_8c2c
	fmult
rpj_8c2d
	lms r2,[m_vanishy]
rpj_8c30
	add r2
rpj_8c31
	with r0
rpj_8c32
	to r2
rpj_8c33
	ibt r6,#$00
rpj_8c35
	with r0
rpj_8c36
	from r1
rpj_8c37
	bmi rpj_8c42
rpj_8c39
	nop
rpj_8c3a
	lms r5,[m_xright]
rpj_8c3d
	sub r5
rpj_8c3e
	bmi rpj_8c46
rpj_8c40
	nop
rpj_8c41
	inc r6
rpj_8c42
	inc r6
rpj_8c43
	with r6
rpj_8c44
	mult #4
rpj_8c46
	with r0
rpj_8c47
	from r2
rpj_8c48
	bmi rpj_8c53
rpj_8c4a
	nop
rpj_8c4b
	lms r5,[m_ybot]
rpj_8c4e
	sub r5
rpj_8c4f
	bmi rpj_8c54
rpj_8c51
	nop
rpj_8c52
	inc r6
rpj_8c53
	inc r6
rpj_8c54
	ibt r0,#$1f
rpj_8c56
	xor r6
rpj_8c58
	swap
rpj_8c59
	or r6
rpj_8c5a
	jmp r11
rpj_8c5b
	nop
rpj_8c5c
	with r12
rpj_8c5d
	to r14
rpj_8c5e
	with r6
rpj_8c5f
	to r3
rpj_8c60
	from r11
rpj_8c61
	stw [r10]
rpj_8c62
	inc r10
rpj_8c63
	inc r10
rpj_8c64
	link #4
rpj_8c65
	iwt r15,#mretail_projectpnt&WM
rpj_8c68
	nop
rpj_8c69
	with r14
rpj_8c6a
	to r12
rpj_8c6b
	lms r3,[m_bigx]
rpj_8c6e
	lms r13,[m_bigy]
rpj_8c71
	lms r9,[m_bigz]
rpj_8c74
	dec r10
rpj_8c75
	dec r10
rpj_8c76
	to r15
rpj_8c77
	ldw [r10]
rpj_8c78
	nop
rpj_8c79
	iwt r15,#rpj_8d23&WM
rpj_8c7c
	nop
rpj_8c7d
	with r7
rpj_8c7e
	sub #4
rpj_8c80
	with r10
rpj_8c81
	to r0
rpj_8c82
	lms r10,[m_sp]
rpj_8c85
	iwt r15,#rpj_8bbf&WM
rpj_8c88
	nop
rpj_8c89
	lms r11,[m_xright]
rpj_8c8c
	lms r13,[m_ybot]
rpj_8c8f
	lms r1,[m_vanishx]
rpj_8c92
	lms r9,[m_vanishy]
rpj_8c95
	lms r3,[m_bigx]
rpj_8c98
	lms r4,[m_bigy]
rpj_8c9b
	lms r5,[m_bigz]
rpj_8c9e
	lms r12,[m_numpnts]
rpj_8ca1
	sms [m_sp],r10
rpj_8ca4
	ibt r10,#$00
rpj_8ca6
	ibt r0,#$14
rpj_8ca8
	romb
rpj_8caa
	sms [m_shapeptr],r14
rpj_8cad
	iwt r7,#(m_rotpnts+4)&WM
rpj_8cb0
	iwt r8,#m_projpnts&WM
rpj_8cb3
	cache
rpj_8cb4
	ldw [r7]
rpj_8cb5
	add r5
rpj_8cb6
	iwt r6,#$0100
rpj_8cb9
	sub r6
rpj_8cba
	bpl rpj_8cc1
rpj_8cbc
	add r6
rpj_8cbd
	iwt r15,#rpj_8c7d&WM
rpj_8cc0
	nop
rpj_8cc1
	iwt r6,#$43fe
rpj_8cc4
	sub r6
rpj_8cc5
	bmi rpj_8cca
rpj_8cc7
	add r6
rpj_8cc8
	with r6
rpj_8cc9
	to r0
rpj_8cca
	bic #1
rpj_8ccc
	iwt r14,#$4300
	from r0
	cmp r14
	bcc rpj_base_8ccc
	nop
	ibt r2,#retail_spriteztail>>16
	from r2
	romb
	iwt r6,#(retail_spriteztail-$4300)&WM
	bra rpj_have_8ccc
	nop
rpj_base_8ccc
	ibt r2,#ztab>>16
	from r2
	romb
	iwt r6,#ztab&WM
rpj_have_8ccc
rpj_8ccf
	to r14
rpj_8cd0
	add r6
rpj_8cd1
	dec r7
rpj_8cd2
	dec r7
rpj_8cd3
	ldw [r7]
rpj_8cd4
	to r2
rpj_8cd5
	add r4
rpj_8cd6
	to r6
rpj_8cd7
	getb
rpj_8cd8
	inc r14
rpj_8cd9
	dec r7
rpj_8cda
	dec r7
rpj_8cdb
	ldw [r7]
rpj_8cdc
	add r3
rpj_8cdd
	with r6
rpj_8cde
	getbh
rpj_8ce0
	fmult
rpj_8ce1
	add r1
rpj_8ce2
	stw [r8]
rpj_8ce3
	ibt r14,#$00
rpj_8ce5
	bmi rpj_8cec
rpj_8ce7
	sub r11
rpj_8ce8
	bmi rpj_8cf0
rpj_8cea
	nop
rpj_8ceb
	inc r14
rpj_8cec
	inc r14
rpj_8ced
	with r14
rpj_8cee
	mult #4
rpj_8cf0
	inc r8
rpj_8cf1
	inc r8
rpj_8cf2
	from r2
rpj_8cf3
	fmult
rpj_8cf4
	add r9
rpj_8cf5
	stw [r8]
rpj_8cf6
	bmi rpj_8cfd
rpj_8cf8
	sub r13
rpj_8cf9
	bmi rpj_8cfe
rpj_8cfb
	nop
rpj_8cfc
	inc r14
rpj_8cfd
	inc r14
rpj_8cfe
	inc r8
rpj_8cff
	inc r8
rpj_8d00
	ibt r0,#$1f
rpj_8d02
	xor r14
rpj_8d04
	swap
rpj_8d05
	or r14
rpj_8d06
	stw [r8]
rpj_8d07
	to r10
rpj_8d08
	or r10
rpj_8d09
	inc r8
rpj_8d0a
	with r7
rpj_8d0b
	add #10
rpj_8d0d
	dec r12
rpj_8d0e
	bne rpj_8cb4
rpj_8d10
	inc r8
rpj_8d11
	iwt r15,#rpj_8d15&WM
rpj_8d14
	nop
rpj_8d15
	sms [m_or_of_outcodes],r10
rpj_8d18
	lms r10,[m_sp]
rpj_8d1b
	lms r0,[m_shapebank]
rpj_8d1e
	romb
rpj_8d20
	lms r14,[m_shapeptr]
rpj_8d23
	lms r0,[m_or_of_outcodes]
rpj_8d26
	iwt r1,#$1f00
rpj_8d29
	and r1
rpj_8d2a
	cmp r1
rpj_8d2c
	beq rpj_8d33
rpj_8d2e
	nop
rpj_8d2f
	iwt r15,#rpj_reject&WM
rpj_8d32
	nop
rpj_8d33
	lms r1,[m_or_of_outcodes]
rpj_8d36
	ibt r0,#$1f
rpj_8d38
	and r1
rpj_8d39
	bne rpj_8d44
rpj_8d3b
	nop
rpj_8d3c
	lms r0,[m_objflags]
rpj_8d3f
	iwt r1,#$4000
rpj_8d42
	or r1
rpj_8d43
	sbk
rpj_8d44
	lms r14,[m_faceptr]
rpj_8d47
	sms [m_shapeptr],r14
rpj_8d4a
rpj_8d4b
	getb
rpj_8d4c
	inc r14
	ibt r1,#1
	iwt r15,#rpj_exit&WM
	nop
rpj_reject
	sub r0
	ibt r1,#2
rpj_exit
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
; Run the first visibility command when the projected face stream starts
; with $30. Returns R1=3 after visibility and R0/R14 at the next command.
mretail_shapevisstream
	from r11
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#mretail_shapestream&WM
	nop
	dec r1
	bne rpj_vis_other
	nop
	ibt r1,#$30
	cmp r1
	bne rpj_vis_face
	nop
	link #4
	iwt r15,#mretail_facevis&WM
	nop
	ibt r1,#3
	iwt r15,#rpj_exit&WM
	nop
rpj_vis_face
	ibt r1,#0
rpj_vis_other
	inc r1
	iwt r15,#rpj_exit&WM
	nop
mrproj_end
