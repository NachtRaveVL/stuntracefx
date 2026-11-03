; Draw a whole shape, or a preprojected face stream at R14.
; R8=queue base, R9=exclusive capacity end (with a sentinel word reserved
; there). m_tr2 is initialized to the base. Geometry/texture bindings
; and the pixel cache belong to the caller. Input polygons must be convex.
; At most 19 flat vertices (plus up to five clip intersections), or 3..4 textured. R1 results: 0 unsupported
; face command, 1 complete, 2 culled, 3 unsupported point command,
; 4 unsupported polygon, 5 invalid queue. R0/R14 identify the boundary.
; Nested BSP/group continuations stay on the stack during drawing.
mrwhole_begin
mretail_drawshape
	from r11
	stw [r10]
	inc r10
	inc r10
	lms r2,[m_sp]
	from r2
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
	iwt r15,#rqs_far_shape&WM
	nop
	dec r10
	dec r10
	to r9
	ldw [r10]
	dec r10
	dec r10
	to r8
	ldw [r10]
	dec r10
	dec r10
	to r2
	ldw [r10]
	sms [m_sp],r2
	dec r10
	dec r10
	to r11
	ldw [r10]
	dec r1
	bne rqs_shapeboundary
	nop
	dec r14
	bra mretail_drawfaces
	nop
rqs_shapeboundary
	inc r1
	bne rqs_shapereturn
	nop
	ibt r1,#3
rqs_shapereturn
	jmp r11
	nop
mretail_drawfaces
	from r8
	or r9
	and #1
	bne rqs_badqueue
	nop
	from r9
	sub r8
	bcc rqs_badqueue
	nop
	iwt r1,#208
	cmp r1
	bcc rqs_badqueue
	nop
	iwt r1,#$ffff
	from r9
	cmp r1
	beq rqs_badqueue
	nop
	sms [m_tr2],r8
	bra rqs_enter
	nop
rqs_badqueue
	ibt r0,#0
	ibt r1,#5
	jmp r11
	nop
rqs_enter
	from r11
	stw [r10]
	inc r10
	inc r10
	lms r1,[m_sp]
	from r1
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
	sms [m_sp],r10
	lms r0,[m_shapebank]
	romb
	with r14
	to r14
	iwt r15,#rqs_fetch&WM
	nop
rqs_8d4d
	iwt r1,#m_bsplist&WM
	sms [m_bspptr],r1
	iwt r0,#rqs_8e7d&WM
	stw [r10]
	inc r10
	inc r10
	cache
	iwt r15,#rqs_fetch&WM
	nop
rqs_8d5d
	dec r14
	inc r14
	with r14
	to r0
	inc r0
	inc r0
	lms r1,[m_bspptr]
	stw [r1]
	inc r1
	inc r1
	sms [m_bspptr],r1
	getb
	inc r14
	getbh
	to r14
	add r14
	iwt r15,#rqs_fetch&WM
	nop
	iwt r15,#rqs_endzero&WM
	nop
rqs_8d7a
	getb
	inc r14
	iwt r1,#m_vistab&WM
	add r1
	ldb [r0]
	swap
	with r0
	from r0
	bmi rqs_8dbd
	nop
	from r14
	stw [r10]
	inc r10
	inc r10
	getb
	inc r14
	getbh
	to r14
	add r14
	iwt r0,#rqs_8d9b&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8d9b
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	inc r14
	inc r14
	from r14
	stw [r10]
	inc r10
	inc r10
	getb
	inc r14
	getbh
	to r14
	add r14
	iwt r0,#rqs_8db4&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8db4
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	inc r14
	inc r14
	iwt r15,#rqs_fetch&WM
	nop
rqs_8dbd
	from r14
	stw [r10]
	inc r10
	inc r10
	inc r14
	inc r14
	getb
	inc r14
	getbh
	to r14
	add r14
	iwt r0,#rqs_8dd2&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8dd2
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	dec r14
	inc r14
	from r14
	stw [r10]
	inc r10
	inc r10
	getb
	inc r14
	getbh
	to r14
	add r14
	iwt r0,#rqs_8deb&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8deb
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	inc r14
	inc r14
	inc r14
	inc r14
	iwt r15,#rqs_fetch&WM
	nop
rqs_8df6
	iwt r1,#m_bsplist&WM
	sms [m_bspptr],r1
	iwt r0,#rqs_8e7d&WM
	stw [r10]
	inc r10
	inc r10
	cache
	iwt r15,#rqs_fetch&WM
	nop
rqs_8e06
	getb
	inc r14
	getbh
	add r14
	lms r1,[m_bspptr]
	stw [r1]
	inc r1
	inc r1
	sms [m_bspptr],r1
	iwt r15,#rqs_endzero&WM
	nop
rqs_8e19
	getb
	inc r14
	iwt r1,#m_vistab&WM
	add r1
	ldb [r0]
	swap
	with r0
	from r0
	bmi rqs_8e45
	nop
	inc r14
	inc r14
	from r14
	stw [r10]
	inc r10
	inc r10
	getb
	lob
	beq rqs_8e3d
	nop
	to r14
	add r14
	iwt r0,#rqs_8e3d&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8e3d
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	inc r14
	iwt r15,#rqs_fetch&WM
	nop
rqs_8e45
	getb
	inc r14
	getbh
	to r12
	add r14
	inc r14
	from r14
	stw [r10]
	inc r10
	inc r10
	inc r14
	from r12
	stw [r10]
	inc r10
	inc r10
	iwt r0,#rqs_8e5e&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8e5e
	inc r14
	dec r10
	dec r10
	ldw [r10]
	lms r1,[m_bspptr]
	stw [r1]
	inc r1
	inc r1
	sms [m_bspptr],r1
	dec r10
	dec r10
	to r14
	ldw [r10]
	getb
	lob
	beq rqs_8e78
	nop
	to r14
	add r14
	iwt r15,#rqs_fetch&WM
	nop
rqs_8e78
	iwt r15,#rqs_endzero&WM
	nop
rqs_8e7d
	sub r0
	lms r1,[m_bspptr]
	stw [r1]
	iwt r0,#m_bsplist&WM
	sms [m_bspptr],r0
rqs_8e88
	lms r1,[m_bspptr]
	to r14
	ldw [r1]
	inc r1
	inc r1
	sms [m_bspptr],r1
	with r14
	from r14
	beq rqs_8ea3
	nop
	iwt r0,#rqs_8ea0&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8ea0
	inc r14
	bra rqs_8e88
	nop
rqs_8ea3
	iwt r15,#rqs_flushzero&WM
	nop
rqs_8ea7
	to r12
	getb
	inc r14
	iwt r1,#m_zbuf&WM
	sub r0
	sub r1
	add r12
	add r14
	sms [m_grouptab],r0
	sms [m_groupnum],r12
	sms [m_numgroups],r12
	iwt r9,#(m_rotpnts+4)&WM
	iwt r5,#m_zbuf&WM
	with r15
	to r13
	getb
	inc r14
	umult #6
	add r9
	ldw [r0]
	stw [r5]
	inc r5
	loop
	inc r5
rqs_8eca
	iwt r5,#m_zbuf&WM
	iwt r7,#$8000
	lms r12,[m_numgroups]
	with r15
	to r13
	ldw [r5]
	cmp r7
	blt rqs_8edf
	nop
	with r0
	to r7
	with r5
	to r6
rqs_8edf
	inc r5
	loop
	inc r5
	iwt r0,#$8000
	stw [r6]
	lms r0,[m_grouptab]
	to r14
	add r6
	getb
	inc r14
	getbh
	with r0
	to r14
	iwt r0,#rqs_8efa&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rqs_fetch&WM
	nop
rqs_8efa
	inc r14
	lms r0,[m_groupnum]
	dec r0
	bne rqs_8eca
	sbk
	iwt r15,#rqs_flushzero&WM
	nop
rqs_fetch
	getb
	inc r14
rqs_dispatch
	ibt r1,#$14
	cmp r1
	bne rqs_next0
	nop
	iwt r15,#rqs_polygon&WM
	nop
rqs_next0
	ibt r1,#$58
	cmp r1
	bne rqs_next1
	nop
	iwt r15,#rqs_8d4d&WM
	nop
rqs_next1
	ibt r1,#$60
	cmp r1
	bne rqs_next2
	nop
	iwt r15,#rqs_8d5d&WM
	nop
rqs_next2
	ibt r1,#$5c
	cmp r1
	bne rqs_next3
	nop
	iwt r15,#rqs_8d7a&WM
	nop
rqs_next3
	ibt r1,#$3c
	cmp r1
	bne rqs_next4
	nop
	iwt r15,#rqs_8df6&WM
	nop
rqs_next4
	ibt r1,#$44
	cmp r1
	bne rqs_next5
	nop
	iwt r15,#rqs_8e06&WM
	nop
rqs_next5
	ibt r1,#$40
	cmp r1
	bne rqs_next6
	nop
	iwt r15,#rqs_endzero&WM
	nop
rqs_next6
	ibt r1,#$28
	cmp r1
	bne rqs_next7
	nop
	iwt r15,#rqs_8e19&WM
	nop
rqs_next7
	ibt r1,#$10
	cmp r1
	bne rqs_next8
	nop
	iwt r15,#rqs_8ea7&WM
	nop
rqs_next8
	ibt r1,#$30
	cmp r1
	bne rqs_next9
	nop
	iwt r15,#rqs_visibility&WM
	nop
rqs_next9
	ibt r1,#$20
	cmp r1
	bne rqs_next10
	nop
	iwt r15,#rqs_jump&WM
	nop
rqs_next10
	ibt r1,#$00
	cmp r1
	bne rqs_next11
	nop
	iwt r15,#rqs_flushend&WM
	nop
rqs_next11
	ibt r1,#$18
	cmp r1
	bne rqs_next12
	nop
	iwt r15,#rqs_end&WM
	nop
rqs_next12
	ibt r1,#$24
	cmp r1
	bne rqs_next13
	nop
	iwt r15,#rqs_end&WM
	nop
rqs_next13
	ibt r1,#$2c
	cmp r1
	bne rqs_next14
	nop
	iwt r15,#rqs_end&WM
	nop
rqs_next14
	ibt r1,#$48
	cmp r1
	bne rqs_next15
	nop
	iwt r15,#rqs_end&WM
	nop
rqs_next15
	ibt r1,#$64
	cmp r1
	bne rqs_next16
	nop
	iwt r15,#rqs_endzero&WM
	nop
rqs_next16
	ibt r1,#$50
	cmp r1
	beq rqs_sprite
	nop
	ibt r1,#$54
	cmp r1
	beq rqs_sprite
	nop
	ibt r1,#0
	iwt r15,#rqs_finish&WM
	nop
rqs_sprite
	link #4
	iwt r15,#rqs_far_sprite&WM
	nop
	iwt r15,#rqs_dispatch&WM
	nop
rqs_jump
	getb
	inc r14
	getbh
	with r14
	add r0
	iwt r15,#rqs_fetch&WM
	nop
; Retail $14 record admission, before material and raster state.
rqs_polygon
	cache
	getb
	lob
	bmi rqs_polyend
	inc r14
	inc r14
	with r0
	to r2
	sub #2
	beq rqs_polyline
	getb
	iwt r1,#m_vistab&WM
	add r1
	ldb [r0]
	lob
	bmi rqs_admit
	inc r14
	beq rqs_admit
	nop
	with r2
	add #4
	with r14
	bra rqs_polygon
	add r2
rqs_polyline
	inc r14
rqs_admit
	sms [m_fnumpnts],r2
	iwt r15,#rqs_packet&WM
	nop
rqs_polyend
	inc r0
	lob
	beq rqs_polyquit
	nop
	iwt r15,#rqs_fetch&WM
	nop
rqs_polyquit
	iwt r15,#rqs_endzero&WM
	nop
rqs_visibility
	link #4
	iwt r15,#rqs_far_vis&WM
	nop
	iwt r15,#rqs_dispatch&WM
	nop
rqs_endzero
	sub r0
rqs_end
	with r0
	to r2
	lms r1,[m_sp]
	from r10
	cmp r1
	beq rqs_done
	nop
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rqs_done
	with r2
	to r0
	ibt r1,#1
rqs_finish
	link #4
	iwt r15,#rqs_flush&WM
	nop
	lms r10,[m_sp]
	with r10
	sub #4
	dec r10
	dec r10
	to r2
	ldw [r10]
	sms [m_sp],r2
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
rqs_flushzero
	sub r0
rqs_flushend
	link #4
	iwt r15,#rqs_flush&WM
	nop
	iwt r15,#rqs_end&WM
	nop
rqs_packet
	lms r0,[m_fnumpnts]
	ibt r1,#2
	cmp r1
	bcc rqs_polybad
	nop
	ibt r1,#20
	cmp r1
	bcs rqs_polybad
	nop
	lms r1,[m_sp]
	dec r1
	dec r1
	to r0
	ldw [r1]
	lms r1,[m_tr2]
	sub r1
	iwt r1,#208
	cmp r1
	bcs rqs_room
	nop
	link #4
	iwt r15,#rqs_flush&WM
	nop
rqs_room
	lms r2,[m_tr2]
	from r2
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#rqs_far_packet&WM
	nop
	dec r10
	dec r10
	to r2
	ldw [r10]
	ibt r1,#2
	cmp r1
	bcs rqs_polybad
	nop
	lms r1,[m_fnumpnts]
	dec r1
	dec r1
	bne rqs_packetnext
	nop
	lms r1,[m_texturemap]
	with r1
	from r1
	bpl rqs_packetnext
	nop
	sms [m_tr2],r2
	bra rqs_polybad
	nop
rqs_packetnext
	iwt r15,#rqs_polygon&WM
	nop
rqs_polybad
	ibt r0,#$14
	ibt r1,#4
	iwt r15,#rqs_finish&WM
	nop
rqs_flush
	from r11
	stw [r10]
	inc r10
	inc r10
	from r0
	stw [r10]
	inc r10
	inc r10
	from r1
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	lms r1,[m_sp]
	from r1
	stw [r10]
	inc r10
	inc r10
	with r1
	sub #4
	to r8
	ldw [r1]
	link #4
	iwt r15,#mretail_mixedflush&WM
	nop
	dec r10
	dec r10
	to r2
	ldw [r10]
	sms [m_sp],r2
	dec r10
	dec r10
	to r14
	ldw [r10]
	dec r10
	dec r10
	to r1
	ldw [r10]
	dec r10
	dec r10
	to r0
	ldw [r10]
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
rqs_far_shape
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#rqs_return29&WM
	iwt r13,#rqs_bridge_shape>>16
	iwt r12,#rqs_bridge_shape&WM
	from r12
	ljmp r13
	nop
rqs_far_vis
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#rqs_return29&WM
	iwt r13,#rqs_bridge_vis>>16
	iwt r12,#rqs_bridge_vis&WM
	from r12
	ljmp r13
	nop
rqs_far_packet
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#rqs_return29&WM
	iwt r13,#rqs_bridge_packet>>16
	iwt r12,#rqs_bridge_packet&WM
	from r12
	ljmp r13
	nop
rqs_far_sprite
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#rqs_return29&WM
	iwt r13,#rqs_bridge_sprite>>16
	iwt r12,#rqs_bridge_sprite&WM
	from r12
	ljmp r13
	nop
rqs_return30
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
mrwhole_end
