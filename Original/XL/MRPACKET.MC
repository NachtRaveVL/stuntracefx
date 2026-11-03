; Packet stage for an admitted $14 record. R14 points to material;
; m_fnumpnts is the vertex count (2..24 flat, 3..4 textured).
; R10/R11 are the software stack/return.
; m_tr2 points to caller-owned queue RAM with room for header and payload.
; Caller supplies the queue bounds and performs flushes before this call.
; R0 result: 0 queued, 1 fully outside, 2 textured screen clip,
; 3 near clip, 4 flat screen clip. R14 points to the next polygon header.
; For 2..4 m_tr1 points at the tentative payload and m_or_of_outcodes
; holds the clip mask. The queue cursor is not advanced until publication.
; R0=6 rejects a texture record outside the four-UV limit.
; R6/R7 return payload end/start on pending clip paths.
mrpacket_begin
mretail_polygonpacket
	from r11
	stw [r10]
	inc r10
	inc r10
	lms r0,[m_shapebank]
	romb
	with r14
	to r14
	link #4
	iwt r15,#mretail_packetmaterial&WM
	nop
	lms r6,[m_tr2]
	with r0
	to r3
	with r3
	from r3
	bpl rpk_countok
	nop
	lms r1,[m_fnumpnts]
	ibt r0,#5
	from r1
	cmp r0
	bcc rpk_countok
	nop
	ibt r0,#6
	iwt r15,#rpk_exit&WM
	nop
rpk_countok
	with r14
	add #4
	lms r12,[m_fnumpnts]
	from r3
	lob
	swap
	or r12
	with r3
	from r3
	bpl rpk_9142
	nop
	from r12
	not
	to r1
	lob
	lms r0,[m_sprbank]
	lob
	swap
	or r1
	stw [r6]
	inc r6
	inc r6
	lms r0,[m_tcmodecol]
	stw [r6]
	inc r6
	inc r6
	lms r0,[m_sprdata]
	stw [r6]
	inc r6
	inc r6
	lms r0,[m_sprmask]
rpk_9142
	stw [r6]
	inc r6
	inc r6
	with r6
	to r7
	iwt r9,#m_projpnts&WM
	ibt r5,#$00
	with r15
	to r13
	to r4
	getb
	inc r14
	from r4
	umult #6
	to r8
	add r9
	ldw [r8]
	stw [r6]
	inc r6
	inc r6
	inc r8
	inc r8
	ldw [r8]
	stw [r6]
	inc r6
	inc r6
	inc r8
	inc r8
	ldw [r8]
	to r5
	or r5
	with r3
	from r3
	bpl rpk_918b
	nop
	sms [m_shapeptr],r14
	ibt r0,#$03
	romb
	lms r14,[m_texptr]
	getb
	inc r14
	swap
	stw [r6]
	inc r6
	inc r6
	getb
	inc r14
	swap
	stw [r6]
	inc r6
	inc r6
	lms r0,[m_shapebank]
	sms [m_texptr],r14
	romb
	lms r14,[m_shapeptr]
rpk_918b
	loop
	nop
	from r5
	lob
	bne rpk_9199
	nop
	sms [m_tr2],r6
	iwt r15,#rpk_queued&WM
	nop
rpk_9199
	iwt r1,#$1f00
	from r1
	and r5
	sub r1
	beq rpk_91a6
	nop
	iwt r15,#rpk_rejected&WM
	nop
rpk_91a6
	nop
	sms [m_or_of_outcodes],r5
	sms [m_shapeptr],r14
	sms [m_tr1],r7
; Retail order: textured side clipping before near clipping.
	lms r0,[m_texturemap]
	hib
	beq rpk_testnear
	nop
	ibt r0,#2
	bra rpk_exit
	nop
rpk_testnear
	ibt r0,#$10
	and r5
	beq rpk_flat
	nop
	ibt r0,#3
	bra rpk_exit
	nop
rpk_flat
	ibt r0,#4
	bra rpk_exit
	nop
rpk_queued
	ibt r0,#0
	bra rpk_exit
	nop
rpk_rejected
	ibt r0,#1
rpk_exit
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
; Publish the caller's clipped payload: R0=clipped vertex count,
; m_tr1=payload address, m_shapeptr=next polygon cursor.

mretail_packetpublish
	lms r3,[m_texturemap]
	lms r6,[m_tr1]
	with r0
	to r2
	with r3
	from r3
	bpl rpk_922c
	add r0
	add r0
	add r0
	add r6
	sms [m_tr2],r0
	with r6
	sub #8
	from r2
	not
	stb [r6]
	bra rpk_9237
	nop
rpk_922c
	add r0
	add r6
	sms [m_tr2],r0
	with r6
	sub #2
	from r2
	stb [r6]
rpk_9237
	lms r0,[m_shapebank]
	romb
	lms r14,[m_shapeptr]
	jmp r11
	nop
; Polygon material entry: R14=material byte, in the shape ROM bank.
; Returns flat colour, $ff textured, or $fe special textured in R0.
mretail_packetmaterial
	with r14
	to r2
	lms r0,[m_objflags]
	iwt r1,#$2000
	and r1
	beq rpk_8f98
	nop
	sub r0
	sms [m_texturemap],r0
	ibt r0,#$02
	cmode
	iwt r0,#$0009
	iwt r15,#rpk_90b6&WM
	nop
rpk_8f98
	getb
	add r0
	ibt r1,#$03
	from r1
	romb
	lms r1,[m_colourptr]
	to r14
	add r1
rpk_8fa4
	to r3
	getb
	inc r14
	with r3
	getbh
	with r3
	from r3
	bpl rpk_8fe1
	nop
	from r3
	add r3
	bpl rpk_8fcf
	nop
	iwt r0,#$fffe
	sms [m_texturemap],r0
	from r3
	hib
	and #15
	add r0
	add r0
	add r0
	add r0
	swap
	or #8
	swap
	sms [m_tcmodecol],r0
	ibt r0,#-2
	iwt r15,#rpk_90b6&WM
	nop
rpk_8fcf
	iwt r0,#$1fff
	to r14
	and r3
	lms r0,[m_colframe]
	to r3
	getb
	dec r3
	and r3
	add r0
	inc r0
	to r14
	bra rpk_8fa4
	add r14
rpk_8fe1
	from r3
	lob
	iwt r1,#retail_texturepals&WM
	to r14
	add r1
	to r1
	getb
	iwt r0,#$0800
	add r1
	sms [m_tcmodecol],r0
	from r3
	add r3
	bpl rpk_8ff7
	sub r0
	dec r0
rpk_8ff7
	sms [m_texturemap],r0
	beq rpk_9045
	nop
	iwt r0,#$2000
	and r3
	beq rpk_900b
	nop
	iwt r0,#$0c00
	add r1
	sms [m_tcmodecol],r0
rpk_900b
	from r3
	lob
	umult #3
	iwt r1,#retail_texturedefs&WM
	to r14
	add r1
	getb
	inc r14
	getbh
	inc r14
	sms [m_sprdata],r0
	getb
	sms [m_sprbank],r0
	from r3
	hib
	ibt r1,#$1f
	and r1
	add r0
	iwt r1,#retail_texturexys&WM
	to r14
	add r1
	getb
	inc r14
	getbh
	with r0
	to r14
	to r1
	getb
	inc r14
	with r1
	getbh
	sms [m_sprmask],r1
	inc r0
	inc r0
	sms [m_texptr],r0
	ibt r0,#-1
	iwt r15,#rpk_90b6&WM
	nop
rpk_9045
	ibt r1,#$3f
	from r3
	hib
	inc r0
	and r1
	beq rpk_90b3
	nop
	inc r0
	and r1
	bne rpk_905e
	nop
; Keep this slot fixed so the existing bank-29 entries do not move.
	iwt r15,#rrl_depthmaterial&WM
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
rpk_905e
	dec r0
	dec r0
	and r1
	with r0
	to r3
	lms r0,[m_shadestab]
	add r3
	to r14
	add r3
	to r6
	getb
	inc r14
	with r6
	getbh
	lms r0,[m_shapebank]
	romb
	with r2
	to r14
	inc r14
	getb
	inc r14
	lms r4,[m_rotlightx]
	to r5
	mult r4
	getb
	inc r14
	lms r4,[m_rotlighty]
	mult r4
	to r5
	add r5
	getb
	lms r4,[m_rotlightz]
	mult r4
	add r5
	asr
	asr
	hib
	sex
	ibt r4,#$06
	cmp r4
	bge rpk_909c
	nop
	ibt r0,#$06
	bra rpk_90a5
	nop
rpk_909c
	ibt r4,#$10
	cmp r4
	blt rpk_90a5
	nop
	ibt r0,#$0f
rpk_90a5
	to r1
	sub #6
	ibt r0,#$03
	romb
	from r6
	to r14
	add r1
	getb
	bra rpk_90b6
	colour
rpk_90b3
	from r3
	lob
	colour
rpk_90b6
	lms r1,[m_shapebank]
	from r1
	romb
	with r2
	to r14
	jmp r11
	nop
mrpacket_end
