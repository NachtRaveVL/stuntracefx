; Shape opcodes $50/$54. R0=opcode, R14=first operand. Return the next
; opcode in R0 and its operand cursor in R14. R1=0 invisible, 1 near,
; or 2 prepared. The corresponding retail sprite callback is a stub.
mrsprgate_begin
mretail_shapespritegate
	from r11
	stw [r10]
	inc r10
	inc r10
	lms r1,[m_shapebank]
	from r1
	romb
	with r14
	to r14
	ibt r1,#$54
	cmp r1
	beq rsg_8f05
	nop
	bra rsg_8f18
	nop
rsg_8f05
	getb
	inc r14
	iwt r1,#m_vistab&WM
	add r1
	ldb [r0]
	swap
	hib
	bmi rsg_8f18
	nop
	inc r14
	inc r14
	inc r14
	getb
	inc r14
	ibt r1,#0
	iwt r15,#rsg_exit&WM
	nop
rsg_8f18
	getb
	inc r14
	to r3
	umult #6
	iwt r1,#m_projpnts&WM
	from r3
	to r2
	add r1
	ldw [r2]
	inc r2
	inc r2
	sms [m_sprx],r0
	ldw [r2]
	sms [m_spry],r0
	iwt r1,#m_projpnts&WM
	iwt r1,#(m_rotpnts+4)&WM
	from r3
	add r1
	ldw [r0]
	lms r1,[m_bigz]
	add r1
	sms [m_sprz],r0
	iwt r1,#$0020
	sub r1
	bmi rsg_8f78
	nop
	link #4
	iwt r15,#rsg_9250&WM
	nop
	inc r14
	getb
	inc r14
	lms r0,[m_sprmask]
	lob
	inc r0
	sms [m_sprsize],r0
	iwt r1,#$0100
	add r0
	swap
	bpl rsg_8f5e
	nop
	with r1
	lsr
rsg_8f5e
	sms [m_sprxscale],r1
	sms [m_shapeptr],r14
	sub r0
	sms [m_spr0],r0
	link #4
	iwt r15,#rsg_stub&WM
	nop
	lms r0,[m_shapebank]
	romb
	lms r14,[m_shapeptr]
	getb
	inc r14
	ibt r1,#2
	iwt r15,#rsg_exit&WM
	nop
rsg_8f78
	inc r14
	inc r14
	getb
	inc r14
	ibt r1,#1
	iwt r15,#rsg_exit&WM
	nop
rsg_exit
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
rsg_stub
	jmp r11
	nop
rsg_9250
	with r14
	to r2
	lms r0,[m_objflags]
	iwt r1,#$2000
	to r1
	and r1
	beq rsg_9275
	nop
	iwt r1,#$1000
	and r1
	bne rsg_9275
	nop
	sub r0
	cmode
	ibt r0,#$09
	colour
	sub r0
	sms [m_tcmodecol],r0
	sms [m_texturemap],r0
	iwt r15,#rsg_shadowret&WM
	nop
rsg_9275
	getb
	iwt r15,#mretail_material&WM
	nop
rsg_shadowret
	lms r0,[m_shapebank]
	romb
	with r2
	to r14
	jmp r11
	nop
mrsprgate_end
