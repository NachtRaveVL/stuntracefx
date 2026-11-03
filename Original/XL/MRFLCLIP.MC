; Retail flat line and polygon screen clipping.
; R0 = count (2 for a line, 3..24 for a convex polygon).
; m_tr1 is the in-place XY payload (including room for the closing
; vertex), m_polybuf is the alternate buffer, clip masks in m_or_of_outcodes.
; R0 returns clipped count, zero for rejection. R14 survives clipping.
; The caller owns queue space (up to four more vertices plus closing pair).
mrflclip_begin
; Packet entry that also clips and publishes flat screen crossings.
; Flat near-plane cases are reprojected before screen clipping.
; Textured clipping still returns its pending status.
mretail_polygonflat
	from r11
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#mretail_polygonpacket&WM
	nop
	ibt r1,#4
	cmp r1
	beq rfl_wrapscreen
	nop
	ibt r1,#3
	cmp r1
	bne rfl_wrapperexit
	nop
	lms r1,[m_texturemap]
	with r1
	hib
	bne rfl_wrapperexit
	nop
	lms r0,[m_fnumpnts]
	with r14
	sub r0
	link #4
	iwt r15,#mretail_flatnear&WM
	nop
	with r0
	from r0
	beq rfl_wrapperreject
	nop
	bra rfl_wrapclip
	nop
rfl_wrapscreen
	lms r0,[m_fnumpnts]
rfl_wrapclip
	link #4
	iwt r15,#mretail_flatclip&WM
	nop
	with r0
	from r0
	beq rfl_wrapperreject
	nop
	link #4
	iwt r15,#mretail_packetpublish&WM
	nop
	sub r0
	bra rfl_wrapperexit
	nop
rfl_wrapperreject
	lms r14,[m_shapeptr]
	ibt r0,#1
rfl_wrapperexit
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rfl_9f01
	sms [m_cnt],r0
	lms r8,[m_tr1]
	iwt r9,#m_polybuf&WM
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_9f1f
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_xleft]
	from r1
	sub r0
	bge rfl_9f75
	nop
	lms r0,[m_xleft]
	from r3
	sub r0
	blt rfl_9f6d
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xleft]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xleft]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_9fb3
	nop
rfl_9f6d
	lms r0,[m_spra]
	dec r0
	sbk
	bra rfl_9fb3
	nop
rfl_9f75
	lms r0,[m_xleft]
	from r3
	sub r0
	bge rfl_9fab
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xleft]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xleft]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_9fb3
	nop
rfl_9fab
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_9fb3
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_9fbf
	nop
	iwt r15,#rfl_9f1f&WM
	nop
rfl_9fbf
	lms r0,[m_spra]
	sub #2
	bpl rfl_9fcb
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_9fcb
	add #2
	sms [m_cnt],r0
	iwt r8,#m_polybuf&WM
	lms r9,[m_tr1]
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_9feb
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_xright]
	from r1
	sub r0
	sub #1
	blt rfl_a046
	nop
	lms r0,[m_xright]
	from r3
	sub r0
	sub #1
	bge rfl_a03d
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xright]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xright]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_a086
	nop
rfl_a03d
	lms r0,[m_spra]
	dec r0
	sbk
	iwt r15,#rfl_a086&WM
	nop
rfl_a046
	lms r0,[m_xright]
	from r3
	sub r0
	sub #1
	blt rfl_a07e
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xright]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xright]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_a086
	nop
rfl_a07e
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_a086
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_a092
	nop
	iwt r15,#rfl_9feb&WM
	nop
rfl_a092
	lms r0,[m_spra]
	sub #2
	bpl rfl_a09e
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_a09e
	add #2
	sms [m_cnt],r0
	lms r8,[m_tr1]
	iwt r9,#m_polybuf&WM
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_a0be
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_ytop]
	from r2
	sub r0
	bge rfl_a11a
	nop
	lms r0,[m_ytop]
	from r6
	sub r0
	blt rfl_a112
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ytop]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ytop]
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a15e
	nop
rfl_a112
	lms r0,[m_spra]
	dec r0
	sbk
	bra rfl_a15e
	nop
rfl_a11a
	lms r0,[m_ytop]
	from r6
	sub r0
	bge rfl_a156
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ytop]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ytop]
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a15e
	nop
rfl_a156
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_a15e
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_a16a
	nop
	iwt r15,#rfl_a0be&WM
	nop
rfl_a16a
	lms r0,[m_spra]
	sub #2
	bpl rfl_a176
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_a176
	add #2
	sms [m_cnt],r0
	iwt r8,#m_polybuf&WM
	lms r9,[m_tr1]
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_a196
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_ybot]
	from r2
	sub r0
	sub #1
	blt rfl_a1f7
	nop
	lms r0,[m_ybot]
	from r6
	sub r0
	sub #1
	bge rfl_a1ef
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ybot]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ybot]
	dec r6
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a23e
	nop
rfl_a1ef
	lms r0,[m_spra]
	dec r0
	sbk
	bra rfl_a23e
	nop
rfl_a1f7
	lms r0,[m_ybot]
	from r6
	sub r0
	sub #1
	blt rfl_a236
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ybot]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ybot]
	dec r6
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a23e
	nop
rfl_a236
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_a23e
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_a24a
	nop
	iwt r15,#rfl_a196&WM
	nop
rfl_a24a
	lms r0,[m_spra]
	sub #2
	bpl rfl_a256
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_a256
	add #2
	ibt r0,#$02
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
mretail_flatclip
	lms r8,[m_tr1]
	iwt r9,#m_polybuf&WM
	sms [m_dy1],r8
	sms [m_dy2],r9
	sms [m_spra],r0
	from r11
	stw [r10]
	inc r10
	inc r10
	ibt r1,#$03
	cmp r1
	bpl rfl_a27d
	nop
	iwt r15,#rfl_9f01&WM
	nop
rfl_a27d
	lms r1,[m_or_of_outcodes]
	with r1
	and #4
	bne rfl_a28a
	nop
	iwt r15,#rfl_a362&WM
	nop
rfl_a28a
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	sms [m_cnt],r0
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_a2a8
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_xleft]
	from r1
	sub r0
	bge rfl_a2fe
	nop
	lms r0,[m_xleft]
	from r3
	sub r0
	blt rfl_a2f6
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xleft]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xleft]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_a33c
	nop
rfl_a2f6
	lms r0,[m_spra]
	dec r0
	sbk
	bra rfl_a33c
	nop
rfl_a2fe
	lms r0,[m_xleft]
	from r3
	sub r0
	bge rfl_a334
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xleft]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xleft]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_a33c
	nop
rfl_a334
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_a33c
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_a348
	nop
	iwt r15,#rfl_a2a8&WM
	nop
rfl_a348
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	lms r0,[m_spra]
	sub #3
	bpl rfl_a360
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_a360
	add #3
rfl_a362
	lms r1,[m_or_of_outcodes]
	with r1
	and #8
	bne rfl_a36f
	nop
	iwt r15,#rfl_a44d&WM
	nop
rfl_a36f
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	sms [m_cnt],r0
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_a38d
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_xright]
	from r1
	sub r0
	sub #1
	blt rfl_a3e7
	nop
	lms r0,[m_xright]
	from r3
	sub r0
	sub #1
	bge rfl_a3df
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xright]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xright]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_a427
	nop
rfl_a3df
	lms r0,[m_spra]
	dec r0
	sbk
	bra rfl_a427
	nop
rfl_a3e7
	lms r0,[m_xright]
	from r3
	sub r0
	sub #1
	blt rfl_a41f
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	lms r0,[m_xright]
	sub r1
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r2
	lms r6,[m_xright]
	from r6
	stw [r9]
	inc r9
	inc r9
	stw [r9]
	inc r9
	inc r9
	bra rfl_a427
	nop
rfl_a41f
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_a427
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_a433
	nop
	iwt r15,#rfl_a38d&WM
	nop
rfl_a433
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	lms r0,[m_spra]
	sub #3
	bpl rfl_a44b
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_a44b
	add #3
rfl_a44d
	lms r1,[m_or_of_outcodes]
	with r1
	and #1
	bne rfl_a45a
	nop
	iwt r15,#rfl_a53e&WM
	nop
rfl_a45a
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	sms [m_cnt],r0
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_a478
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_ytop]
	from r2
	sub r0
	bge rfl_a4d4
	nop
	lms r0,[m_ytop]
	from r6
	sub r0
	blt rfl_a4cc
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ytop]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ytop]
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a518
	nop
rfl_a4cc
	lms r0,[m_spra]
	dec r0
	sbk
	bra rfl_a518
	nop
rfl_a4d4
	lms r0,[m_ytop]
	from r6
	sub r0
	bge rfl_a510
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ytop]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ytop]
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a518
	nop
rfl_a510
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_a518
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_a524
	nop
	iwt r15,#rfl_a478&WM
	nop
rfl_a524
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	lms r0,[m_spra]
	sub #3
	bpl rfl_a53c
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_a53c
	add #3
rfl_a53e
	lms r1,[m_or_of_outcodes]
	with r1
	and #2
	bne rfl_a54b
	nop
	iwt r15,#rfl_a635&WM
	nop
rfl_a54b
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	sms [m_cnt],r0
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_cnt]
	mult #4
	add r8
	from r1
	stw [r0]
	inc r0
	inc r0
	from r2
	stw [r0]
rfl_a569
	to r1
	ldw [r8]
	inc r8
	inc r8
	to r2
	ldw [r8]
	inc r8
	inc r8
	to r3
	ldw [r8]
	inc r8
	inc r8
	to r6
	ldw [r8]
	with r8
	sub #2
	lms r0,[m_ybot]
	from r2
	sub r0
	sub #1
	blt rfl_a5c9
	nop
	lms r0,[m_ybot]
	from r6
	sub r0
	sub #1
	bge rfl_a5c1
	nop
	with r1
	to r0
	with r3
	to r1
	with r0
	to r3
	with r2
	to r0
	with r6
	to r2
	with r0
	to r6
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ybot]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ybot]
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a60f
	nop
rfl_a5c1
	lms r0,[m_spra]
	dec r0
	sbk
	bra rfl_a60f
	nop
rfl_a5c9
	lms r0,[m_ybot]
	from r6
	sub r0
	sub #1
	blt rfl_a607
	nop
	lms r0,[m_spra]
	inc r0
	sbk
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	with r3
	sub r1
	with r6
	sub r2
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
	lms r0,[m_ybot]
	sub r2
	to r5
	lmult
	with r3
	to r6
	link #4
	iwt r15,#rfl_8186&WM
	nop
	from r4
	add r1
	lms r6,[m_ybot]
	stw [r9]
	inc r9
	inc r9
	from r6
	stw [r9]
	inc r9
	inc r9
	bra rfl_a60f
	nop
rfl_a607
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
rfl_a60f
	lms r0,[m_cnt]
	dec r0
	sbk
	beq rfl_a61b
	nop
	iwt r15,#rfl_a569&WM
	nop
rfl_a61b
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	lms r0,[m_spra]
	sub #3
	bpl rfl_a633
	nop
	iwt r15,#rfl_a65c&WM
	nop
rfl_a633
	add #3
rfl_a635
	lms r1,[m_tr1]
	lms r8,[m_dy1]
	with r1
	sub r8
	beq rfl_a657
	nop
	lms r9,[m_dy2]
	with r0
	to r12
	with r15
	to r13
	ldw [r8]
	stw [r9]
	inc r9
	inc r9
	inc r8
	inc r8
	ldw [r8]
	stw [r9]
	inc r9
	inc r9
	inc r8
	loop
	inc r8
	lms r0,[m_spra]
rfl_a657
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rfl_a65c
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rfl_8186
	cache
	from r5
	to r7
	xor r6
	sub r0
	with r6
	from r6
	bpl rfl_8192
	to r6
	sub r6
rfl_8192
	with r5
	from r5
	bpl rfl_819b
	to r4
	sub r4
	to r5
	sbc r5
rfl_819b
	with r4
	add r4
	from r5
	rol
	ibt r12,#$10
	with r15
	to r13
	sub r6
	bcc rfl_81ae
	nop
	with r4
	rol
	loop
	rol
	bra rfl_81b3
	nop
rfl_81ae
	add r6
	with r4
	add r4
	loop
	rol
rfl_81b3
	with r7
	from r7
	bpl rfl_81ba
	with r4
	not
	inc r4
rfl_81ba
	jmp r11
	nop
rfl_981a
	cache
	with r3
	from r3
	bmi rfl_9828
	nop
	with r6
	from r6
	bmi rfl_9831
	nop
	sub r0
	jmp r11
	nop
rfl_9828
	with r6
	from r6
	bpl rfl_988d
	nop
	ibt r0,#-1
	jmp r11
	nop
rfl_9831
	sms [m_sprb],r1
	sms [m_sprc],r2
	sms [m_sprd],r3
	with r1
	to r0
	with r4
	to r1
	with r0
	to r4
	with r2
	to r0
	with r5
	to r2
	with r0
	to r5
	with r3
	to r0
	with r6
	to r3
	with r0
	to r6
rfl_984c
	from r3
	add r6
	div2
	beq rfl_9874
	nop
	bmi rfl_9865
	nop
	with r0
	to r6
	from r1
	add r4
	to r4
	div2
	from r2
	add r5
	to r5
	div2
	bra rfl_984c
	nop
rfl_9865
	with r0
	to r3
	from r1
	add r4
	to r1
	div2
	from r2
	add r5
	to r2
	div2
	bra rfl_984c
	nop
rfl_9874
	with r0
	to r6
	from r1
	add r4
	to r4
	div2
	from r2
	add r5
	to r5
	div2
	lms r1,[m_sprb]
	lms r2,[m_sprc]
	lms r3,[m_sprd]
	ibt r0,#$01
	jmp r11
	nop
rfl_988d
	sms [m_sprb],r4
	sms [m_sprc],r5
	sms [m_sprd],r6
rfl_9896
	from r3
	add r6
	div2
	beq rfl_98be
	nop
	bmi rfl_98af
	nop
	with r0
	to r6
	from r1
	add r4
	to r4
	div2
	from r2
	add r5
	to r5
	div2
	bra rfl_9896
	nop
rfl_98af
	with r0
	to r3
	from r1
	add r4
	to r1
	div2
	from r2
	add r5
	to r2
	div2
	bra rfl_9896
	nop
rfl_98be
	with r0
	to r3
	from r1
	add r4
	to r1
	div2
	from r2
	add r5
	to r2
	div2
	lms r4,[m_sprb]
	lms r5,[m_sprc]
	lms r6,[m_sprd]
	ibt r0,#$01
	jmp r11
	nop
; R0=count, R14=first vertex index, m_tr1=reserved flat payload.
mretail_flatnear
	from r11
	stw [r10]
	inc r10
	inc r10
	with r0
	to r9
	lms r5,[m_bigx]
	lms r6,[m_bigy]
	lms r7,[m_bigz]
	lms r2,[m_tr1]
	with r9
	to r12
	with r15
	to r13
	getb
	inc r14
	umult #6
	iwt r1,#m_rotpnts&WM
	with r1
	add r0
	ldw [r1]
	inc r1
	inc r1
	add r5
	stw [r2]
	inc r2
	inc r2
	ldw [r1]
	inc r1
	inc r1
	add r6
	stw [r2]
	inc r2
	inc r2
	ldw [r1]
	add r7
	stw [r2]
	inc r2
	loop
	inc r2
	with r9
	to r9
	sub r0
	sms [m_cnt],r0
	lms r7,[m_tr1]
	iwt r8,#m_polybuf&WM
	from r9
	sub #2
	bne rfl_9958
	nop
	to r1
	ldw [r7]
	inc r7
	inc r7
	to r2
	ldw [r7]
	inc r7
	inc r7
	to r3
	ldw [r7]
	inc r7
	inc r7
	to r4
	ldw [r7]
	inc r7
	inc r7
	to r5
	ldw [r7]
	inc r7
	inc r7
	to r6
	ldw [r7]
	link #4
	iwt r15,#rfl_981a&WM
	nop
	from r1
	stw [r8]
	inc r8
	inc r8
	from r2
	stw [r8]
	inc r8
	inc r8
	from r3
	stw [r8]
	inc r8
	inc r8
	from r4
	stw [r8]
	inc r8
	inc r8
	from r5
	stw [r8]
	inc r8
	inc r8
	from r6
	stw [r8]
	inc r8
	inc r8
	ibt r0,#$02
	sms [m_cnt],r0
	iwt r15,#rfl_99ea&WM
	nop
rfl_9958
	to r1
	ldw [r7]
	inc r7
	inc r7
	to r2
	ldw [r7]
	inc r7
	inc r7
	to r3
	ldw [r7]
	inc r7
	inc r7
	with r9
	to r0
	dec r0
	bne rfl_996d
	nop
	lms r7,[m_tr1]
rfl_996d
	to r4
	ldw [r7]
	inc r7
	inc r7
	to r5
	ldw [r7]
	inc r7
	inc r7
	to r6
	ldw [r7]
	with r7
	sub #4
	from r6
	and r3
	bpl rfl_9983
	nop
	iwt r15,#rfl_99d6&WM
	nop
rfl_9983
	with r3
	from r3
	bpl rfl_998c
	nop
	iwt r15,#rfl_99c0&WM
	nop
rfl_998c
	from r1
	stw [r8]
	inc r8
	inc r8
	from r2
	stw [r8]
	inc r8
	inc r8
	from r3
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_cnt]
	inc r0
	sbk
	with r6
	from r6
	bmi rfl_99a6
	nop
	iwt r15,#rfl_99d6&WM
	nop
rfl_99a6
	link #4
	iwt r15,#rfl_981a&WM
	nop
	from r4
	stw [r8]
	inc r8
	inc r8
	from r5
	stw [r8]
	inc r8
	inc r8
	from r6
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_cnt]
	inc r0
	sbk
	iwt r15,#rfl_99d6&WM
	nop
rfl_99c0
	link #4
	iwt r15,#rfl_981a&WM
	nop
	from r1
	stw [r8]
	inc r8
	inc r8
	from r2
	stw [r8]
	inc r8
	inc r8
	from r3
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_cnt]
	inc r0
	sbk
rfl_99d6
	dec r9
	beq rfl_99de
	nop
	iwt r15,#rfl_9958&WM
	nop
rfl_99de
	lms r0,[m_cnt]
	sub #3
	bpl rfl_99ea
	nop
	iwt r15,#rfl_9a4c&WM
	nop
rfl_99ea
	lms r3,[m_bigx]
	lms r13,[m_bigy]
	lms r9,[m_bigz]
	ibt r0,#$14
	romb
	sub r0
	sms [m_or_of_outcodes],r0
	sms [m_shapeptr],r14
	lms r12,[m_cnt]
	iwt r7,#m_polybuf&WM
	lms r8,[m_tr1]
rfl_9a07
	to r1
	ldw [r7]
	inc r7
	inc r7
	to r2
	ldw [r7]
	inc r7
	inc r7
	to r6
	ldw [r7]
	inc r7
	inc r7
	link #4
	iwt r15,#rpj_8bff&WM
	nop
	from r1
	stw [r8]
	inc r8
	inc r8
	from r2
	stw [r8]
	inc r8
	inc r8
	lms r6,[m_or_of_outcodes]
	or r6
	dec r12
	bne rfl_9a07
	sbk
	lms r0,[m_shapebank]
	romb
	lms r14,[m_shapeptr]
	lms r3,[m_tr1]
	lms r0,[m_or_of_outcodes]
	iwt r1,#$0f00
	and r1
	cmp r1
	beq rfl_9a43
	nop
	iwt r15,#rfl_9a4c&WM
	nop
rfl_9a43
	nop
	lms r0,[m_cnt]
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rfl_9a4c
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
mrflclip_end
