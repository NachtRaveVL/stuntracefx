; Face-stream control, after shape projection. R14 points at an opcode.
; Run conditional substreams, deferred BSP playback, depth-sorted groups,
; visibility batches, and polygon admission. R0/R14 identify the boundary.
; R1=1 completed, 0 unsupported opcode, 4 admitted polygon/line.
; On admission R0=$14 and R14 points to the material byte.
; mretail_shapecontrols adds the point/projection stage: R1=2 if culled,
; 3 if the point stream stopped before projection, and 0/1/4 as above otherwise.
; A drawing boundary unwinds pending substreams; it is not resumable.
; ROM input is trusted: at most 19 deferred entries and 8 depth groups.
; Reserve stack space for nested substreams and one visibility call.
; Do not nest a BSP list or a depth sort within another of the same kind.
mrface_begin
mretail_shapecontrols
	from r11
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#mretail_shapestream&WM
	nop
	dec r1
	bne rfc_shape_boundary
	nop
	dec r14
	dec r10
	dec r10
	to r11
	ldw [r10]
	bra mretail_facecontrol
	nop
rfc_shape_boundary
	inc r1
	bne rfc_shape_return
	nop
	ibt r1,#3
rfc_shape_return
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
mretail_facecontrol
	from r11
	stw [r10]
	inc r10
	inc r10
	lms r1,[m_sp]
	from r1
	stw [r10]
	inc r10
	inc r10
	sms [m_sp],r10
	lms r0,[m_shapebank]
	romb
	with r14
	to r14
	iwt r15,#rfc_fetch&WM
	nop
rfc_8d4d
	iwt r1,#m_bsplist&WM
	sms [m_bspptr],r1
	iwt r0,#rfc_8e7d&WM
	stw [r10]
	inc r10
	inc r10
	cache
	iwt r15,#rfc_fetch&WM
	nop
rfc_8d5d
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
	iwt r15,#rfc_fetch&WM
	nop
	iwt r15,#rfc_endzero&WM
	nop
rfc_8d7a
	getb
	inc r14
	iwt r1,#m_vistab&WM
	add r1
	ldb [r0]
	swap
	with r0
	from r0
	bmi rfc_8dbd
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
	iwt r0,#rfc_8d9b&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8d9b
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
	iwt r0,#rfc_8db4&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8db4
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	inc r14
	inc r14
	iwt r15,#rfc_fetch&WM
	nop
rfc_8dbd
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
	iwt r0,#rfc_8dd2&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8dd2
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
	iwt r0,#rfc_8deb&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8deb
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	inc r14
	inc r14
	inc r14
	inc r14
	iwt r15,#rfc_fetch&WM
	nop
rfc_8df6
	iwt r1,#m_bsplist&WM
	sms [m_bspptr],r1
	iwt r0,#rfc_8e7d&WM
	stw [r10]
	inc r10
	inc r10
	cache
	iwt r15,#rfc_fetch&WM
	nop
rfc_8e06
	getb
	inc r14
	getbh
	add r14
	lms r1,[m_bspptr]
	stw [r1]
	inc r1
	inc r1
	sms [m_bspptr],r1
	iwt r15,#rfc_endzero&WM
	nop
rfc_8e19
	getb
	inc r14
	iwt r1,#m_vistab&WM
	add r1
	ldb [r0]
	swap
	with r0
	from r0
	bmi rfc_8e45
	nop
	inc r14
	inc r14
	from r14
	stw [r10]
	inc r10
	inc r10
	getb
	lob
	beq rfc_8e3d
	nop
	to r14
	add r14
	iwt r0,#rfc_8e3d&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8e3d
	inc r14
	dec r10
	dec r10
	to r14
	ldw [r10]
	inc r14
	iwt r15,#rfc_fetch&WM
	nop
rfc_8e45
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
	iwt r0,#rfc_8e5e&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8e5e
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
	beq rfc_8e78
	nop
	to r14
	add r14
	iwt r15,#rfc_fetch&WM
	nop
rfc_8e78
	iwt r15,#rfc_endzero&WM
	nop
rfc_8e7d
	sub r0
	lms r1,[m_bspptr]
	stw [r1]
	iwt r0,#m_bsplist&WM
	sms [m_bspptr],r0
rfc_8e88
	lms r1,[m_bspptr]
	to r14
	ldw [r1]
	inc r1
	inc r1
	sms [m_bspptr],r1
	with r14
	from r14
	beq rfc_8ea3
	nop
	iwt r0,#rfc_8ea0&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8ea0
	inc r14
	bra rfc_8e88
	nop
rfc_8ea3
	iwt r15,#rfc_endzero&WM
	nop
rfc_8ea7
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
rfc_8eca
	iwt r5,#m_zbuf&WM
	iwt r7,#$8000
	lms r12,[m_numgroups]
	with r15
	to r13
	ldw [r5]
	cmp r7
	blt rfc_8edf
	nop
	with r0
	to r7
	with r5
	to r6
rfc_8edf
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
	iwt r0,#rfc_8efa&WM
	stw [r10]
	inc r10
	inc r10
	iwt r15,#rfc_fetch&WM
	nop
rfc_8efa
	inc r14
	lms r0,[m_groupnum]
	dec r0
	bne rfc_8eca
	sbk
	iwt r15,#rfc_endzero&WM
	nop
rfc_fetch
	getb
	inc r14
rfc_dispatch
	ibt r1,#$14
	cmp r1
	bne rfc_next0
	nop
	iwt r15,#rfc_polygon&WM
	nop
rfc_next0
	ibt r1,#$58
	cmp r1
	bne rfc_next1
	nop
	iwt r15,#rfc_8d4d&WM
	nop
rfc_next1
	ibt r1,#$60
	cmp r1
	bne rfc_next2
	nop
	iwt r15,#rfc_8d5d&WM
	nop
rfc_next2
	ibt r1,#$5c
	cmp r1
	bne rfc_next3
	nop
	iwt r15,#rfc_8d7a&WM
	nop
rfc_next3
	ibt r1,#$3c
	cmp r1
	bne rfc_next4
	nop
	iwt r15,#rfc_8df6&WM
	nop
rfc_next4
	ibt r1,#$44
	cmp r1
	bne rfc_next5
	nop
	iwt r15,#rfc_8e06&WM
	nop
rfc_next5
	ibt r1,#$40
	cmp r1
	bne rfc_next6
	nop
	iwt r15,#rfc_endzero&WM
	nop
rfc_next6
	ibt r1,#$28
	cmp r1
	bne rfc_next7
	nop
	iwt r15,#rfc_8e19&WM
	nop
rfc_next7
	ibt r1,#$10
	cmp r1
	bne rfc_next8
	nop
	iwt r15,#rfc_8ea7&WM
	nop
rfc_next8
	ibt r1,#$30
	cmp r1
	bne rfc_next9
	nop
	iwt r15,#rfc_visibility&WM
	nop
rfc_next9
	ibt r1,#$20
	cmp r1
	bne rfc_next10
	nop
	iwt r15,#rfc_jump&WM
	nop
rfc_next10
	ibt r1,#$00
	cmp r1
	bne rfc_next11
	nop
	iwt r15,#rfc_end&WM
	nop
rfc_next11
	ibt r1,#$18
	cmp r1
	bne rfc_next12
	nop
	iwt r15,#rfc_end&WM
	nop
rfc_next12
	ibt r1,#$24
	cmp r1
	bne rfc_next13
	nop
	iwt r15,#rfc_end&WM
	nop
rfc_next13
	ibt r1,#$2c
	cmp r1
	bne rfc_next14
	nop
	iwt r15,#rfc_end&WM
	nop
rfc_next14
	ibt r1,#$48
	cmp r1
	bne rfc_next15
	nop
	iwt r15,#rfc_end&WM
	nop
rfc_next15
	ibt r1,#$64
	cmp r1
	bne rfc_next16
	nop
	iwt r15,#rfc_endzero&WM
	nop
rfc_next16
	ibt r1,#0
	iwt r15,#rfc_finish&WM
	nop
rfc_jump
	getb
	inc r14
	getbh
	with r14
	add r0
	iwt r15,#rfc_fetch&WM
	nop
; Retail $14 record admission, before material and raster state.
rfc_polygon
	cache
	getb
	lob
	bmi rfc_polyend
	inc r14
	inc r14
	with r0
	to r2
	sub #2
	beq rfc_polyline
	getb
	iwt r1,#m_vistab&WM
	add r1
	ldb [r0]
	lob
	bmi rfc_admit
	inc r14
	beq rfc_admit
	nop
	with r2
	add #4
	with r14
	bra rfc_polygon
	add r2
rfc_polyline
	inc r14
rfc_admit
	sms [m_fnumpnts],r2
	ibt r0,#$14
	ibt r1,#4
	iwt r15,#rfc_finish&WM
	nop
rfc_polyend
	inc r0
	lob
	beq rfc_polyquit
	nop
	iwt r15,#rfc_fetch&WM
	nop
rfc_polyquit
	iwt r15,#rfc_endzero&WM
	nop
rfc_visibility
	link #4
	iwt r15,#mretail_facevis&WM
	nop
	iwt r15,#rfc_dispatch&WM
	nop
rfc_endzero
	sub r0
rfc_end
	with r0
	to r2
	lms r1,[m_sp]
	from r10
	cmp r1
	beq rfc_done
	nop
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rfc_done
	with r2
	to r0
	ibt r1,#1
rfc_finish
	lms r10,[m_sp]
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
mrface_end
