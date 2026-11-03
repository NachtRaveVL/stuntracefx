; Retail textured polygon clipping, from queued XYUV to clipped XYUV.
; m_tr1=payload, m_fnumpnts=3 or 4 convex vertices, R5=packed clip mask,
; R14=next polygon header. Uses m_polybuf and m_clippolybuf as scratch.
; R0=final count (zero rejects), including near and screen plane handling.
mrtxclip_begin
; Shape-to-queue entry. R8 is the exclusive, non-wrapping queue end.
; R1 follows mretail_shapecontrols; with R1=4, R0 is the packet status.
; R0=5 means less than 208 bytes of scratch/queue space; R0=6 means
; a vertex count outside 2..24 (or outside texture-record support).
mretail_shapequeuefirst
	from r11
	stw [r10]
	inc r10
	inc r10
	from r8
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#mretail_shapecontrols&WM
	nop
	dec r10
	dec r10
	to r8
	ldw [r10]
	ibt r2,#4
	from r1
	cmp r2
	bne rtc_wrapexit
	nop
	lms r1,[m_tr2]
	from r8
	sub r1
	bcc rtc_queuefull
	nop
	iwt r2,#208
	cmp r2
	bcc rtc_queuefull
	nop
	lms r0,[m_fnumpnts]
	ibt r2,#2
	cmp r2
	bcc rtc_queuecount
	nop
	ibt r2,#25
	cmp r2
	bcs rtc_queuecount
	nop
	link #4
	iwt r15,#mretail_polygonall&WM
	nop
	bra rtc_queueexit
	nop
rtc_queuefull
	ibt r0,#5
	bra rtc_queueexit
	nop
rtc_queuecount
	ibt r0,#6
rtc_queueexit
	ibt r1,#4
	bra rtc_wrapexit
	nop
; Build, clip and publish a polygon packet. Use the flat entry for larger
; untextured polygons. Reserve queue room for up to nine textured vertices.
mretail_polygonall
	from r11
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#mretail_polygonflat&WM
	nop
	ibt r1,#2
	cmp r1
	bne rtc_wrapexit
	nop
	lms r0,[m_fnumpnts]
	ibt r1,#3
	cmp r1
	bcc rtc_wrapdefer
	nop
	ibt r1,#5
	cmp r1
	bcs rtc_wrapdefer
	nop
	link #4
	iwt r15,#mretail_textureclip&WM
	nop
	with r0
	from r0
	beq rtc_wrapreject
	nop
	link #4
	iwt r15,#mretail_packetpublish&WM
	nop
	sub r0
	bra rtc_wrapexit
	nop
rtc_wrapdefer
	ibt r0,#2
	bra rtc_wrapexit
	nop
rtc_wrapreject
	lms r0,[m_shapebank]
	romb
	lms r14,[m_shapeptr]
	ibt r0,#1
rtc_wrapexit
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
rtc_c1be
	cache
	lms r0,[m_tr1]
	to r2
	sub #4
	iwt r1,#(m_clippolybuf-4)&WM
	from r9
	umult #8
	to r2
	add r2
	from r9
	umult #10
	to r1
	add r1
	with r9
	to r12
	with r15
	to r13
	to r3
	ldw [r2]
	inc r2
	inc r2
	ldw [r2]
	with r3
	div2
	div2
	from r3
	stw [r1]
	inc r1
	inc r1
	stw [r1]
	with r2
	sub #10
	with r1
	sub #12
	loop
	nop
	lms r5,[m_bigx]
	lms r6,[m_bigy]
	lms r7,[m_bigz]
	iwt r2,#m_clippolybuf&WM
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
	with r2
	add #6
	loop
	nop
	jmp r11
	nop
rtc_c21e
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r5,#$3e80
	iwt r4,#$c180
	lms r12,[m_cnt]
	iwt r0,#m_clippolybuf&WM
	lms r7,[m_dy1]
	sub r7
	beq rtc_c255
	nop
	with r7
	add #4
	with r15
	to r13
	to r6
	ldw [r7]
	from r4
	sub r6
	bpl rtc_c246
	nop
	with r6
	to r4
	bra rtc_c24d
	nop
rtc_c246
	from r5
	sub r6
	bmi rtc_c24d
	nop
	with r6
	to r5
rtc_c24d
	with r7
	add #10
	loop
	nop
	bra rtc_c299
	nop
rtc_c255
	lms r2,[m_dy2]
	with r15
	to r13
	ldw [r7]
	inc r7
	inc r7
	stw [r2]
	inc r2
	inc r2
	ldw [r7]
	inc r7
	inc r7
	stw [r2]
	inc r2
	inc r2
	to r6
	ldw [r7]
	inc r7
	inc r7
	from r6
	stw [r2]
	inc r2
	inc r2
	from r4
	sub r6
	bpl rtc_c278
	nop
	with r6
	to r4
	bra rtc_c27f
	nop
rtc_c278
	from r5
	sub r6
	bmi rtc_c27f
	nop
	with r6
	to r5
rtc_c27f
	ldw [r7]
	inc r7
	inc r7
	stw [r2]
	inc r2
	inc r2
	ldw [r7]
	inc r7
	inc r7
	stw [r2]
	inc r2
	inc r2
	loop
	nop
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
rtc_c299
	lms r0,[m_cnt]
	sms [m_spra],r0
	from r5
	add r5
	add r5
	to r6
	sub r4
	bmi rtc_c2ab
	nop
	iwt r15,#rtc_c331&WM
	nop
rtc_c2ab
	nop
	from r4
	add r0
	lsr
	lsr
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#rtc_ce34&WM
	nop
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	dec r10
	dec r10
	to r1
	ldw [r10]
	with r0
	from r0
	beq rtc_c334
	nop
	from r1
	stw [r10]
	inc r10
	inc r10
	lms r2,[m_tr1]
	with r2
	sub #8
	not
	stb [r2]
	not
	from r2
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#rtc_c412&WM
	nop
	dec r10
	dec r10
	to r1
	ldw [r10]
	nop
	ldw [r1]
	inc r1
	inc r1
	stw [r8]
	inc r8
	inc r8
	ldw [r1]
	inc r1
	inc r1
	stw [r8]
	inc r8
	inc r8
	ldw [r1]
	inc r1
	inc r1
	stw [r8]
	inc r8
	inc r8
	ldw [r1]
	inc r1
	inc r1
	stw [r8]
	inc r8
	inc r8
	sms [m_tr1],r8
	iwt r0,#m_clippolybuf&WM
	sms [m_dy2],r0
	iwt r0,#m_polybuf&WM
	sms [m_dy1],r0
	lms r0,[m_spra]
	sms [m_cnt],r0
	dec r10
	dec r10
	ldw [r10]
	not
	inc r0
	link #4
	iwt r15,#rtc_ce34&WM
	nop
	with r0
	from r0
	beq rtc_c334
	nop
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
rtc_c331
	lms r0,[m_cnt]
rtc_c334
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
mretail_textureclip
	from r11
	stw [r10]
	inc r10
	inc r10
	sms [m_or_of_outcodes],r5
	lms r9,[m_fnumpnts]
	sms [m_cnt],r9
	with r14
	sub r9
	link #4
	iwt r15,#rtc_c1be&WM
	nop
	iwt r0,#m_clippolybuf&WM
	sms [m_dy1],r0
	iwt r0,#m_polybuf&WM
	sms [m_dy2],r0
	lms r5,[m_or_of_outcodes]
	ibt r1,#$10
	with r1
	and r5
	beq rtc_c368
	nop
	ibt r5,#$0f
	sms [m_or_of_outcodes],r5
rtc_c368
	from r5
	to r1
	and #2
	beq rtc_c38c
	nop
	link #4
	iwt r15,#rtc_c668&WM
	nop
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	with r0
	from r0
	bne rtc_c389
	nop
	iwt r15,#rtc_c409&WM
	nop
rtc_c389
	lms r5,[m_or_of_outcodes]
rtc_c38c
	from r5
	to r1
	and #1
	beq rtc_c3b0
	nop
	link #4
	iwt r15,#rtc_cb63&WM
	nop
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	with r0
	from r0
	bne rtc_c3ad
	nop
	iwt r15,#rtc_c409&WM
	nop
rtc_c3ad
	lms r5,[m_or_of_outcodes]
rtc_c3b0
	from r5
	to r1
	and #8
	beq rtc_c3d4
	nop
	link #4
	iwt r15,#rtc_c933&WM
	nop
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	with r0
	from r0
	bne rtc_c3d1
	nop
	iwt r15,#rtc_c409&WM
	nop
rtc_c3d1
	lms r5,[m_or_of_outcodes]
rtc_c3d4
	from r5
	to r1
	and #4
	beq rtc_c3f5
	nop
	link #4
	iwt r15,#rtc_ca42&WM
	nop
	lms r1,[m_dy1]
	lms r2,[m_dy2]
	sms [m_dy1],r2
	sms [m_dy2],r1
	with r0
	from r0
	bne rtc_c3f5
	nop
	iwt r15,#rtc_c409&WM
	nop
rtc_c3f5
	link #4
	iwt r15,#rtc_c21e&WM
	nop
	with r0
	from r0
	beq rtc_c409
	nop
	link #4
	iwt r15,#rtc_c412&WM
	nop
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c409
	sub r0
	sms [m_cnt],r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c412
	from r11
	stw [r10]
	inc r10
	inc r10
	cache
	lms r3,[m_bigx]
	lms r13,[m_bigy]
	lms r9,[m_bigz]
	ibt r0,#$14
	romb
	sub r0
	sms [m_or_of_outcodes],r0
	sms [m_shapeptr],r14
	lms r12,[m_cnt]
	lms r7,[m_dy1]
	lms r8,[m_tr1]
rtc_c434
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
	stw [r10]
	inc r10
	inc r10
	and #15
	beq rtc_c467
	lsr
	bcc rtc_c453
	lsr
	lms r2,[m_ytop]
rtc_c453
	bcc rtc_c459
	lsr
	lms r2,[m_ybot]
rtc_c459
	bcc rtc_c461
	lsr
	lms r1,[m_xleft]
	ibt r1,#$00
rtc_c461
	bcc rtc_c467
	nop
	lms r1,[m_xright]
rtc_c467
	dec r10
	dec r10
	ldw [r10]
	from r1
	stw [r8]
	inc r8
	inc r8
	from r2
	stw [r8]
	inc r8
	inc r8
	to r6
	ldw [r7]
	inc r7
	inc r7
	with r6
	add r6
	from r6
	stw [r8]
	inc r8
	inc r8
	to r6
	ldw [r7]
	inc r7
	inc r7
	with r6
	add r6
	from r6
	stw [r8]
	inc r8
	inc r8
	lms r6,[m_or_of_outcodes]
	or r6
	dec r12
	bne rtc_c434
	sbk
	lms r0,[m_shapebank]
	romb
	lms r14,[m_shapeptr]
	sub r0
	sms [m_or_of_outcodes],r0
	lms r0,[m_cnt]
	sms [m_fnumpnts],r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c4aa
	cache
	from r11
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	from r2
	fmult
	adc r0
	add r0
	add r0
	from r3
	sub r0
	bmi rtc_c4d3
	nop
	from r5
	fmult
	adc r0
	add r0
	add r0
	from r7
	sub r0
	bmi rtc_c4ee
	nop
	dec r10
	dec r10
	to r14
	ldw [r10]
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c4d3
	from r5
	fmult
	adc r0
	add r0
	add r0
	from r7
	sub r0
	bmi rtc_c4e2
	nop
	iwt r15,#rtc_c5b4&WM
	nop
rtc_c4e2
	nop
	dec r10
	dec r10
	to r14
	ldw [r10]
	ibt r0,#-1
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c4ee
	sms [m_sprb],r1
	sms [m_sprc],r2
	sms [m_sprd],r3
	from r8
	stw [r10]
	inc r10
	inc r10
	from r9
	stw [r10]
	inc r10
	inc r10
	from r12
	stw [r10]
	inc r10
	inc r10
	from r13
	stw [r10]
	inc r10
	inc r10
	sms [m_sprxmin],r10
	ibt r10,#$0c
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
	with r7
	to r3
	with r0
	to r7
	lms r8,[m_clippnts]
	lms r9,[m_clipy]
	lms r12,[m_clipdx]
	lms r13,[m_clipx]
rtc_c52a
	from r2
	add r5
	to r14
	div2
	from r3
	add r7
	to r11
	div2
	from r14
	fmult
	adc r0
	add r0
	add r0
	from r11
	sub r0
	beq rtc_c574
	nop
	bmi rtc_c55b
	dec r10
	beq rtc_c574
	nop
	with r11
	to r7
	from r1
	add r4
	to r4
	div2
	with r14
	to r5
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	bra rtc_c52a
	nop
rtc_c55b
	beq rtc_c574
	nop
	with r11
	to r3
	from r1
	add r4
	to r1
	div2
	with r14
	to r2
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	bra rtc_c52a
	nop
rtc_c574
	with r11
	to r7
	from r1
	add r4
	to r4
	div2
	with r14
	to r5
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	lms r1,[m_sprb]
	lms r2,[m_sprc]
	lms r3,[m_sprd]
	sms [m_clippnts],r12
	sms [m_clipy],r13
	lms r10,[m_sprxmin]
	dec r10
	dec r10
	to r13
	ldw [r10]
	dec r10
	dec r10
	to r12
	ldw [r10]
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
	to r14
	ldw [r10]
	ibt r0,#$01
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c5b4
	sms [m_sprb],r4
	sms [m_sprc],r5
	sms [m_sprd],r7
	from r8
	stw [r10]
	inc r10
	inc r10
	from r9
	stw [r10]
	inc r10
	inc r10
	from r12
	stw [r10]
	inc r10
	inc r10
	from r13
	stw [r10]
	inc r10
	inc r10
	sms [m_sprxmin],r10
	ibt r10,#$0c
	lms r8,[m_clipdx]
	lms r9,[m_clipx]
	lms r12,[m_clippnts]
	lms r13,[m_clipy]
rtc_c5de
	from r2
	add r5
	to r14
	div2
	from r3
	add r7
	to r11
	div2
	from r14
	fmult
	adc r0
	add r0
	add r0
	from r11
	sub r0
	beq rtc_c628
	nop
	bmi rtc_c60f
	dec r10
	beq rtc_c628
	nop
	with r11
	to r7
	from r1
	add r4
	to r4
	div2
	with r14
	to r5
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	bra rtc_c5de
	nop
rtc_c60f
	beq rtc_c628
	nop
	with r11
	to r3
	from r1
	add r4
	to r1
	div2
	with r14
	to r2
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	bra rtc_c5de
	nop
rtc_c628
	with r11
	to r3
	from r1
	add r4
	to r1
	div2
	with r14
	to r2
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	lms r4,[m_sprb]
	lms r5,[m_sprc]
	lms r7,[m_sprd]
	sms [m_clipdx],r8
	sms [m_clipx],r9
	lms r10,[m_sprxmin]
	dec r10
	dec r10
	to r13
	ldw [r10]
	dec r10
	dec r10
	to r12
	ldw [r10]
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
	to r14
	ldw [r10]
	ibt r0,#$01
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c668
	from r11
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	lms r6,[m_clip2drsp]
	lms r14,[m_cnt]
	sub r0
	sms [m_cnt],r0
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	from r14
	sub #2
	bne rtc_c68a
	nop
	iwt r15,#rtc_c770&WM
	nop
rtc_c68a
	nop
rtc_c68b
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
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipdx],r0
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipx],r0
	with r14
	to r0
	dec r0
	bne rtc_c6ac
	nop
	lms r8,[m_dy1]
rtc_c6ac
	to r4
	ldw [r8]
	inc r8
	inc r8
	to r5
	ldw [r8]
	inc r8
	inc r8
	to r7
	ldw [r8]
	inc r8
	inc r8
	ldw [r8]
	inc r8
	inc r8
	sms [m_clippnts],r0
	ldw [r8]
	sms [m_clipy],r0
	with r8
	sub #8
	from r2
	fmult
	adc r0
	add r0
	add r0
	from r3
	sub r0
	bpl rtc_c6e2
	nop
	from r5
	fmult
	adc r0
	add r0
	add r0
	from r7
	sub r0
	bpl rtc_c6df
	nop
	iwt r15,#rtc_c752&WM
	nop
rtc_c6df
	bra rtc_c730
	nop
rtc_c6e2
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	from r5
	fmult
	adc r0
	add r0
	add r0
	from r7
	sub r0
	bpl rtc_c752
	nop
	link #4
	iwt r15,#rtc_c4aa&WM
	nop
	from r4
	stw [r9]
	inc r9
	inc r9
	from r5
	stw [r9]
	inc r9
	inc r9
	from r7
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clippnts]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipy]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	iwt r15,#rtc_c752&WM
	nop
rtc_c730
	link #4
	iwt r15,#rtc_c4aa&WM
	nop
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
rtc_c752
	dec r14
	beq rtc_c75a
	nop
	iwt r15,#rtc_c68b&WM
	nop
rtc_c75a
	lms r0,[m_cnt]
	to r1
	sub #3
	bpl rtc_c767
	nop
	iwt r15,#rtc_c770&WM
	nop
rtc_c767
	dec r10
	dec r10
	to r14
	ldw [r10]
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c770
	dec r10
	dec r10
	to r14
	ldw [r10]
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c77a
	cache
	from r11
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	from r1
	fmult
	adc r0
	add r0
	from r3
	sub r0
	bmi rtc_c7a1
	nop
	from r4
	fmult
	adc r0
	add r0
	from r7
	sub r0
	bmi rtc_c7bb
	nop
	dec r10
	dec r10
	to r14
	ldw [r10]
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c7a1
	from r4
	fmult
	adc r0
	add r0
	from r7
	sub r0
	bmi rtc_c7af
	nop
	iwt r15,#rtc_c880&WM
	nop
rtc_c7af
	nop
	dec r10
	dec r10
	to r14
	ldw [r10]
	ibt r0,#-1
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c7bb
	sms [m_sprb],r1
	sms [m_sprc],r2
	sms [m_sprd],r3
	from r8
	stw [r10]
	inc r10
	inc r10
	from r9
	stw [r10]
	inc r10
	inc r10
	from r12
	stw [r10]
	inc r10
	inc r10
	from r13
	stw [r10]
	inc r10
	inc r10
	sms [m_sprxmin],r10
	ibt r10,#$0c
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
	with r7
	to r3
	with r0
	to r7
	lms r8,[m_clippnts]
	lms r9,[m_clipy]
	lms r12,[m_clipdx]
	lms r13,[m_clipx]
rtc_c7f7
	from r1
	add r4
	to r14
	div2
	from r3
	add r7
	to r11
	div2
	from r14
	fmult
	adc r0
	add r0
	from r11
	sub r0
	beq rtc_c840
	nop
	bmi rtc_c827
	dec r10
	beq rtc_c840
	nop
	with r11
	to r7
	from r2
	add r5
	to r5
	div2
	with r14
	to r4
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	bra rtc_c7f7
	nop
rtc_c827
	beq rtc_c840
	nop
	with r11
	to r3
	from r2
	add r5
	to r2
	div2
	with r14
	to r1
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	bra rtc_c7f7
	nop
rtc_c840
	with r11
	to r7
	from r2
	add r5
	to r5
	div2
	with r14
	to r4
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	lms r1,[m_sprb]
	lms r2,[m_sprc]
	lms r3,[m_sprd]
	sms [m_clippnts],r12
	sms [m_clipy],r13
	lms r10,[m_sprxmin]
	dec r10
	dec r10
	to r13
	ldw [r10]
	dec r10
	dec r10
	to r12
	ldw [r10]
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
	to r14
	ldw [r10]
	ibt r0,#$01
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c880
	sms [m_sprb],r4
	sms [m_sprc],r5
	sms [m_sprd],r7
	from r8
	stw [r10]
	inc r10
	inc r10
	from r9
	stw [r10]
	inc r10
	inc r10
	from r12
	stw [r10]
	inc r10
	inc r10
	from r13
	stw [r10]
	inc r10
	inc r10
	sms [m_sprxmin],r10
	ibt r10,#$0c
	lms r8,[m_clipdx]
	lms r9,[m_clipx]
	lms r12,[m_clippnts]
	lms r13,[m_clipy]
rtc_c8aa
	from r1
	add r4
	to r14
	div2
	from r3
	add r7
	to r11
	div2
	from r14
	fmult
	adc r0
	add r0
	from r11
	sub r0
	beq rtc_c8f3
	nop
	bmi rtc_c8da
	dec r10
	beq rtc_c8f3
	nop
	with r11
	to r7
	from r2
	add r5
	to r5
	div2
	with r14
	to r4
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	bra rtc_c8aa
	nop
rtc_c8da
	beq rtc_c8f3
	nop
	with r11
	to r3
	from r2
	add r5
	to r2
	div2
	with r14
	to r1
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	bra rtc_c8aa
	nop
rtc_c8f3
	with r11
	to r3
	from r2
	add r5
	to r2
	div2
	with r14
	to r1
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	lms r4,[m_sprb]
	lms r5,[m_sprc]
	lms r7,[m_sprd]
	sms [m_clipdx],r8
	sms [m_clipx],r9
	lms r10,[m_sprxmin]
	dec r10
	dec r10
	to r13
	ldw [r10]
	dec r10
	dec r10
	to r12
	ldw [r10]
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
	to r14
	ldw [r10]
	ibt r0,#$01
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_c933
	from r11
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	lms r6,[m_clipz]
	lms r14,[m_cnt]
	sub r0
	sms [m_cnt],r0
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	from r14
	sub #2
	bne rtc_c955
	nop
	iwt r15,#rtc_ca38&WM
	nop
rtc_c955
	nop
rtc_c956
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
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipdx],r0
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipx],r0
	with r14
	to r0
	dec r0
	bne rtc_c977
	nop
	lms r8,[m_dy1]
rtc_c977
	to r4
	ldw [r8]
	inc r8
	inc r8
	to r5
	ldw [r8]
	inc r8
	inc r8
	to r7
	ldw [r8]
	inc r8
	inc r8
	ldw [r8]
	inc r8
	inc r8
	sms [m_clippnts],r0
	ldw [r8]
	sms [m_clipy],r0
	with r8
	sub #8
	from r1
	fmult
	adc r0
	add r0
	from r3
	sub r0
	bpl rtc_c9ab
	nop
	from r4
	fmult
	adc r0
	add r0
	from r7
	sub r0
	bpl rtc_c9a8
	nop
	iwt r15,#rtc_ca1a&WM
	nop
rtc_c9a8
	bra rtc_c9f8
	nop
rtc_c9ab
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	from r4
	fmult
	adc r0
	add r0
	from r7
	sub r0
	bpl rtc_ca1a
	nop
	link #4
	iwt r15,#rtc_c77a&WM
	nop
	from r4
	stw [r9]
	inc r9
	inc r9
	from r5
	stw [r9]
	inc r9
	inc r9
	from r7
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clippnts]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipy]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	iwt r15,#rtc_ca1a&WM
	nop
rtc_c9f8
	link #4
	iwt r15,#rtc_c77a&WM
	nop
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
rtc_ca1a
	dec r14
	beq rtc_ca22
	nop
	iwt r15,#rtc_c956&WM
	nop
rtc_ca22
	lms r0,[m_cnt]
	to r1
	sub #3
	bpl rtc_ca2f
	nop
	iwt r15,#rtc_ca38&WM
	nop
rtc_ca2f
	dec r10
	dec r10
	to r14
	ldw [r10]
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_ca38
	dec r10
	dec r10
	to r14
	ldw [r10]
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_ca42
	from r11
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	lms r6,[m_clipz]
	lms r14,[m_cnt]
	sub r0
	sms [m_cnt],r0
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	from r14
	sub #2
	bne rtc_ca64
	nop
	iwt r15,#rtc_cb59&WM
	nop
rtc_ca64
	nop
rtc_ca65
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
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipdx],r0
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipx],r0
	with r14
	to r0
	dec r0
	bne rtc_ca86
	nop
	lms r8,[m_dy1]
rtc_ca86
	to r4
	ldw [r8]
	inc r8
	inc r8
	to r5
	ldw [r8]
	inc r8
	inc r8
	to r7
	ldw [r8]
	inc r8
	inc r8
	ldw [r8]
	inc r8
	inc r8
	sms [m_clippnts],r0
	ldw [r8]
	sms [m_clipy],r0
	with r8
	sub #8
	from r1
	fmult
	adc r0
	add r0
	from r3
	add r0
	bpl rtc_caba
	nop
	from r4
	fmult
	adc r0
	add r0
	from r7
	add r0
	bpl rtc_cab7
	nop
	iwt r15,#rtc_cb3b&WM
	nop
rtc_cab7
	bra rtc_cb10
	nop
rtc_caba
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	from r4
	fmult
	adc r0
	add r0
	from r7
	add r0
	bpl rtc_cb3b
	nop
	with r1
	not
	inc r1
	with r4
	not
	inc r4
	link #4
	iwt r15,#rtc_c77a&WM
	nop
	with r4
	not
	inc r4
	from r4
	stw [r9]
	inc r9
	inc r9
	from r5
	stw [r9]
	inc r9
	inc r9
	from r7
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clippnts]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipy]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	iwt r15,#rtc_cb3b&WM
	nop
rtc_cb10
	with r1
	not
	inc r1
	with r4
	not
	inc r4
	link #4
	iwt r15,#rtc_c77a&WM
	nop
	with r1
	not
	inc r1
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
rtc_cb3b
	dec r14
	beq rtc_cb43
	nop
	iwt r15,#rtc_ca65&WM
	nop
rtc_cb43
	lms r0,[m_cnt]
	to r1
	sub #3
	bpl rtc_cb50
	nop
	iwt r15,#rtc_cb59&WM
	nop
rtc_cb50
	dec r10
	dec r10
	to r14
	ldw [r10]
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_cb59
	dec r10
	dec r10
	to r14
	ldw [r10]
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_cb63
	from r11
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	lms r6,[m_clip2drsp]
	lms r14,[m_cnt]
	sub r0
	sms [m_cnt],r0
	lms r8,[m_dy1]
	lms r9,[m_dy2]
	from r14
	sub #2
	bne rtc_cb85
	nop
	iwt r15,#rtc_cc7d&WM
	nop
rtc_cb85
	nop
rtc_cb86
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
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipdx],r0
	ldw [r8]
	inc r8
	inc r8
	sms [m_clipx],r0
	with r14
	to r0
	dec r0
	bne rtc_cba7
	nop
	lms r8,[m_dy1]
rtc_cba7
	to r4
	ldw [r8]
	inc r8
	inc r8
	to r5
	ldw [r8]
	inc r8
	inc r8
	to r7
	ldw [r8]
	inc r8
	inc r8
	ldw [r8]
	inc r8
	inc r8
	sms [m_clippnts],r0
	ldw [r8]
	sms [m_clipy],r0
	with r8
	sub #8
	from r2
	fmult
	adc r0
	add r0
	add r0
	from r3
	add r0
	bpl rtc_cbdd
	nop
	from r5
	fmult
	adc r0
	add r0
	add r0
	from r7
	add r0
	bpl rtc_cbda
	nop
	iwt r15,#rtc_cc5f&WM
	nop
rtc_cbda
	bra rtc_cc34
	nop
rtc_cbdd
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	from r5
	fmult
	adc r0
	add r0
	add r0
	from r7
	add r0
	bpl rtc_cc5f
	nop
	with r2
	not
	inc r2
	with r5
	not
	inc r5
	link #4
	iwt r15,#rtc_c4aa&WM
	nop
	with r5
	not
	inc r5
	from r4
	stw [r9]
	inc r9
	inc r9
	from r5
	stw [r9]
	inc r9
	inc r9
	from r7
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clippnts]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipy]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
	iwt r15,#rtc_cc5f&WM
	nop
rtc_cc34
	with r2
	not
	inc r2
	with r5
	not
	inc r5
	link #4
	iwt r15,#rtc_c4aa&WM
	nop
	with r2
	not
	inc r2
	from r1
	stw [r9]
	inc r9
	inc r9
	from r2
	stw [r9]
	inc r9
	inc r9
	from r3
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipdx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_clipx]
	stw [r9]
	inc r9
	inc r9
	lms r0,[m_cnt]
	inc r0
	sbk
rtc_cc5f
	dec r14
	beq rtc_cc67
	nop
	iwt r15,#rtc_cb86&WM
	nop
rtc_cc67
	lms r0,[m_cnt]
	to r1
	sub #3
	bpl rtc_cc74
	nop
	iwt r15,#rtc_cc7d&WM
	nop
rtc_cc74
	dec r10
	dec r10
	to r14
	ldw [r10]
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_cc7d
	dec r10
	dec r10
	to r14
	ldw [r10]
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_cc87
	cache
	from r11
	stw [r10]
	inc r10
	inc r10
	with r0
	from r14
	bpl rtc_cc93
	sub r3
	from r14
	add r3
rtc_cc93
	bmi rtc_cca6
	nop
	with r0
	from r14
	bpl rtc_cc9d
	sub r7
	from r14
	add r7
rtc_cc9d
	bmi rtc_ccbc
	nop
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_cca6
	with r0
	from r14
	bpl rtc_ccad
	sub r7
	from r14
	add r7
rtc_ccad
	bmi rtc_ccb4
	nop
	iwt r15,#rtc_cd81&WM
	nop
rtc_ccb4
	nop
	ibt r0,#-1
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_ccbc
	sms [m_sprb],r1
	sms [m_sprc],r2
	sms [m_sprd],r3
	from r8
	stw [r10]
	inc r10
	inc r10
	from r9
	stw [r10]
	inc r10
	inc r10
	from r12
	stw [r10]
	inc r10
	inc r10
	from r13
	stw [r10]
	inc r10
	inc r10
	sms [m_sprxmin],r10
	ibt r10,#$0c
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
	with r7
	to r3
	with r0
	to r7
	lms r8,[m_clippnts]
	lms r9,[m_clipy]
	lms r12,[m_clipdx]
	lms r13,[m_clipx]
rtc_ccf8
	from r3
	add r7
	to r11
	div2
	with r0
	from r14
	bpl rtc_cd04
	sub r11
	from r14
	add r11
rtc_cd04
	beq rtc_cd42
	nop
	bmi rtc_cd26
	dec r10
	beq rtc_cd42
	nop
	with r11
	to r7
	from r1
	add r4
	to r4
	div2
	from r2
	add r5
	to r5
	div2
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	bra rtc_ccf8
	nop
rtc_cd26
	beq rtc_cd42
	nop
	with r11
	to r3
	from r1
	add r4
	to r1
	div2
	from r2
	add r5
	to r2
	div2
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	bra rtc_ccf8
	nop
rtc_cd42
	with r11
	to r7
	from r1
	add r4
	to r4
	div2
	from r2
	add r5
	to r5
	div2
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	lms r1,[m_sprb]
	lms r2,[m_sprc]
	lms r3,[m_sprd]
	sms [m_clippnts],r12
	sms [m_clipy],r13
	lms r10,[m_sprxmin]
	dec r10
	dec r10
	to r13
	ldw [r10]
	dec r10
	dec r10
	to r12
	ldw [r10]
	dec r10
	dec r10
	to r9
	ldw [r10]
	dec r10
	dec r10
	to r8
	ldw [r10]
	ibt r0,#$01
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_cd81
	sms [m_sprb],r4
	sms [m_sprc],r5
	sms [m_sprd],r7
	from r8
	stw [r10]
	inc r10
	inc r10
	from r9
	stw [r10]
	inc r10
	inc r10
	from r12
	stw [r10]
	inc r10
	inc r10
	from r13
	stw [r10]
	inc r10
	inc r10
	sms [m_sprxmin],r10
	ibt r10,#$0c
	lms r8,[m_clipdx]
	lms r9,[m_clipx]
	lms r12,[m_clippnts]
	lms r13,[m_clipy]
rtc_cdab
	from r3
	add r7
	to r11
	div2
	with r0
	from r14
	bpl rtc_cdb7
	sub r11
	from r14
	add r11
rtc_cdb7
	beq rtc_cdf5
	nop
	bmi rtc_cdd9
	dec r10
	beq rtc_cdf5
	nop
	with r11
	to r7
	from r1
	add r4
	to r4
	div2
	from r2
	add r5
	to r5
	div2
	from r8
	add r12
	to r12
	div2
	from r9
	add r13
	to r13
	div2
	bra rtc_cdab
	nop
rtc_cdd9
	beq rtc_cdf5
	nop
	with r11
	to r3
	from r1
	add r4
	to r1
	div2
	from r2
	add r5
	to r2
	div2
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	bra rtc_cdab
	nop
rtc_cdf5
	with r11
	to r3
	from r1
	add r4
	to r1
	div2
	from r2
	add r5
	to r2
	div2
	from r8
	add r12
	to r8
	div2
	from r9
	add r13
	to r9
	div2
	lms r4,[m_sprb]
	lms r5,[m_sprc]
	lms r7,[m_sprd]
	sms [m_clipdx],r8
	sms [m_clipx],r9
	lms r10,[m_sprxmin]
	dec r10
	dec r10
	to r13
	ldw [r10]
	dec r10
	dec r10
	to r12
	ldw [r10]
	dec r10
	dec r10
	to r9
	ldw [r10]
	dec r10
	dec r10
	to r8
	ldw [r10]
	ibt r0,#$01
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_ce34
	from r11
	stw [r10]
	inc r10
	inc r10
	from r14
	stw [r10]
	inc r10
	inc r10
	with r0
	to r14
	lms r9,[m_cnt]
	sub r0
	sms [m_cnt],r0
	lms r6,[m_dy1]
	lms r8,[m_dy2]
	from r9
	sub #2
	bne rtc_ce55
	nop
	iwt r15,#rtc_cf38&WM
	nop
rtc_ce55
	nop
rtc_ce56
	to r1
	ldw [r6]
	inc r6
	inc r6
	to r2
	ldw [r6]
	inc r6
	inc r6
	to r3
	ldw [r6]
	inc r6
	inc r6
	ldw [r6]
	inc r6
	inc r6
	sms [m_clipdx],r0
	ldw [r6]
	inc r6
	inc r6
	sms [m_clipx],r0
	with r9
	to r0
	dec r0
	bne rtc_ce77
	nop
	lms r6,[m_dy1]
rtc_ce77
	to r4
	ldw [r6]
	inc r6
	inc r6
	to r5
	ldw [r6]
	inc r6
	inc r6
	to r7
	ldw [r6]
	inc r6
	inc r6
	ldw [r6]
	inc r6
	inc r6
	sms [m_clippnts],r0
	ldw [r6]
	sms [m_clipy],r0
	with r6
	sub #8
	with r0
	from r14
	bpl rtc_ce97
	sub r3
	from r14
	add r3
rtc_ce97
	bpl rtc_ceab
	nop
	with r0
	from r14
	bpl rtc_cea1
	sub r7
	from r14
	add r7
rtc_cea1
	bpl rtc_cea8
	nop
	iwt r15,#rtc_cf1a&WM
	nop
rtc_cea8
	bra rtc_cef8
	nop
rtc_ceab
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
	lms r0,[m_clipdx]
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_clipx]
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_cnt]
	inc r0
	sbk
	with r0
	from r14
	bpl rtc_cecf
	sub r7
	from r14
	add r7
rtc_cecf
	bpl rtc_cf1a
	nop
	link #4
	iwt r15,#rtc_cc87&WM
	nop
	from r4
	stw [r8]
	inc r8
	inc r8
	from r5
	stw [r8]
	inc r8
	inc r8
	from r7
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_clippnts]
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_clipy]
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_cnt]
	inc r0
	sbk
	iwt r15,#rtc_cf1a&WM
	nop
rtc_cef8
	link #4
	iwt r15,#rtc_cc87&WM
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
	lms r0,[m_clipdx]
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_clipx]
	stw [r8]
	inc r8
	inc r8
	lms r0,[m_cnt]
	inc r0
	sbk
rtc_cf1a
	dec r9
	beq rtc_cf22
	nop
	iwt r15,#rtc_ce56&WM
	nop
rtc_cf22
	lms r0,[m_cnt]
	to r1
	sub #3
	bpl rtc_cf2f
	nop
	iwt r15,#rtc_cf38&WM
	nop
rtc_cf2f
	dec r10
	dec r10
	to r14
	ldw [r10]
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
rtc_cf38
	dec r10
	dec r10
	to r14
	ldw [r10]
	sub r0
	dec r10
	dec r10
	to r15
	ldw [r10]
	nop
mrtxclip_end
