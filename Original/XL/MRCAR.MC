; Retail constructor readers, US $04:8DAC-$04:8E58 and $04:8EA6-$04:8F42.
; Raw retail car/wheel layouts: these are not the early OBJ/CAR structures.
; Caller provides cleared, allocated records and selects the definition bank.
; Shape words are retail identities; allocation and live integration remain.

; r1 = raw car, r14 = 37-byte header, low r4 = alternate-shape selector.
; r5 = definition origin ($8090 in retail; rcardefs_begin-$A4 here).
; Output selected shape/tag in m_retailshape/m_retailshapetag; r14 += 37.
; r0/r2/r3/flags destroyed; r1/r4-r13, ROM/RAM banks preserved.
mread_retailcarheader
	mgetwi	r2
	mgetwi	r3
	sm	[m_retailshape],r2
	from	r4
	lob
	beq	.shape
	nop
	sm	[m_retailshape],r3
.shape
	mgetbi	r0
	sm	[m_retailshapetag],r0
; Native +05/+06 are fetched but not retained by this reader.
	mgetwi	r0
	mgetwi	r2
	ibt	r0,#$5a
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$5c
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$40
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$0c
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$0e
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$10
	add	r1
	from	r2
	stw	[r0]
; Native +17..+20 are skipped before the last two object words.
	from	r14
	sub	r5
	sm	[m_retaildefindex],r0
	with	r14
	add	#10
	mgetwi	r2
	ibt	r0,#$2a
	add	r1
	from	r2
	stw	[r0]
	mgetwi	r2
	ibt	r0,#$14
	add	r1
	from	r2
	stw	[r0]
	move	pc,r11
	nop

; US $04:8F78-$04:8FC4. r1 = raw car, r14 = auxiliary count byte,
; r5 = definition origin as above; m_retailrouteword supplies the native
; $26F2 initialization word. Skip count*5 bytes and retain the parameter
; pointer and route defaults. r0/r2/r4/r6/flags scratch; other regs preserved.
mfinish_retailcar
	from	r14
	sub	r5
	sm	[m_retailparamindex],r0
	mgetbi	r0
	ibt	r6,#5
	lmult
	with	r14
	add	r4
	with	r14
	to	r2
	ibt	r0,#$6e
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0180
	ibt	r0,#$6a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$1000
	iwt	r0,#$8c
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_retailrouteword]
	iwt	r0,#$8a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#0
	ibt	r0,#$7a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#2
	iwt	r0,#$86
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#1
	ibt	r0,#$58
	add	r1
	from	r2
	stw	[r0]
	move	pc,r11
	nop

; US $04:B1ED-$04:B204. r8 = raw car, r2 = caller's 50-byte work area.
; ROM bank already selected; raw car +6E points to 25 parameter words.
; Avoid a second fixed native RAM layout for the per-car work area.
; r0/r1/r12/r13/r14/flags scratch; other regs and banks preserved.
mload_retailcarparms
	ibt	r0,#$6e
	add	r8
	ldw	[r0]
	with	r0
	to	r14
	move	r1,r2
	iwt	r12,#25
	move	r13,pc
.copy
	mgetwi	r0
	stw	[r1]
	inc	r1
	inc	r1
	loop
	nop
	move	pc,r11
	nop

; r1 = raw car, r2 = allocated raw wheel, r14 = 14-byte descriptor.
; m_retailwheelword is the header word immediately after wheel count.
; Native attachment/list writes are retained, including the wheel's old
; flag bits OR 4, first-coordinate negation and the 20/20/20 bounds.
; r0/r3/flags destroyed; r1/r2/r4-r13 and ROM/RAM banks preserved.
mread_retailwheel
	mgetwi	r3
	ibt	r0,#$12
	add	r2
	from	r3
	stw	[r0]
	mgetwi	r3
	with	r3
	not
	inc	r3
	ibt	r0,#$3c
	add	r2
	from	r3
	stw	[r0]
	mgetwi	r3
	ibt	r0,#$3e
	add	r2
	from	r3
	stw	[r0]
	mgetwi	r3
	ibt	r0,#$40
	add	r2
	from	r3
	stw	[r0]
	mgetwi	r3
	ibt	r0,#$44
	add	r2
	from	r3
	stw	[r0]
	mgetwi	r3
	ibt	r0,#$50
	add	r2
	from	r3
	stw	[r0]
	mgetwi	r3
	ibt	r0,#$46
	add	r2
	from	r3
	stw	[r0]
	ibt	r3,#$3e
	with	r3
	add	r1
	to	r3
	ldw	[r3]
	ibt	r0,#$34
	add	r2
	from	r3
	stw	[r0]
	ibt	r0,#$3e
	add	r1
	from	r2
	stw	[r0]
	iwt	r3,#20
	ibt	r0,#$0c
	add	r2
	from	r3
	stw	[r0]
	ibt	r0,#$0e
	add	r2
	from	r3
	stw	[r0]
	ibt	r0,#$10
	add	r2
	from	r3
	stw	[r0]
	ibt	r3,#$16
	with	r3
	add	r2
	to	r3
	ldw	[r3]
	iwt	r0,#4
	to	r3
	or	r3
	ibt	r0,#$16
	add	r2
	from	r3
	stw	[r0]
	lm	r3,[m_retailwheelword]
	ibt	r0,#$1a
	add	r2
	from	r3
	stw	[r0]
	ibt	r3,#$2a
	with	r3
	add	r1
	to	r3
	ldw	[r3]
	ibt	r0,#$2a
	add	r2
	from	r3
	stw	[r0]
	move	pc,r11
	nop

; Gear/torque/revs stage, US $04:B4CA-$04:B57A.
; Raw car r8; r1 = force, r2 = controls, r7 = 25-word parameter work area.
; ROM bank already selected. m_retailgearframe supplies native $2470.
; Work words 20/21 point to shift thresholds and forward torque curves;
; the reverse row is the 17 bytes immediately before the forward rows.
; Raw car +4E gear updates every fourth frame. All arithmetic is native
; signed/wrapped arithmetic, including the -1 DIV2 case and rev smoothing.
; r0/r1/r3-r6/r13/r14/flags scratch; r2/r7-r12 and banks preserved.
mretail_gearforce
	iwt	r0,#40
	add	r7
	to	r14
	ldw	[r0]
	ibt	r4,#1
	ibt	r5,#0
	ibt	r3,#$4a
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	with	r3
	from	r3
	bpl	.threshold
	nop
	iwt	r0,#$0410
	and	r2
	beq	.reverse
	nop
	ibt	r4,#1
	ibt	r5,#15
	iwt	pc,#.torque&WM
	nop
.reverse
	ibt	r4,#0
	bra	.shift
	nop
.threshold
	mgetwi	r0
	with	r0
	from	r0
	beq	.lastgear
	nop
	cmp	r3
	bpl	.shift
	nop
	with	r0
	to	r5
	bra	.threshold
	inc	r4
.lastgear
	dec	r4
.shift
	lm	r0,[m_retailgearframe]
	and	#3
	bne	.curve
	nop
	ibt	r0,#$4e
	add	r8
	ldw	[r0]
	cmp	r4
	beq	.curve
	nop
	from	r4
	sbk
	from	r4
	sub	#4
	bne	.curve
	nop
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r6,#2
	or	r6
	sbk
.curve
	iwt	r0,#42
	add	r7
	to	r14
	ldw	[r0]
	ibt	r0,#$4e
	add	r8
	ldw	[r0]
	dec	r0
	iwt	r6,#17
	mult	r6
	with	r14
	add	r0
	sub	r0
	to	r6
	getbh
	with	r6
	to	r4
	inc	r14
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bpl	.speed
	nop
	not
	inc	r0
.speed
	sub	r5
	add	r0
	fmult
	ibt	r3,#15
	cmp	r3
	bmi	.phase
	nop
	with	r3
	to	r0
.phase
	with	r0
	to	r5
	with	r14
	add	r0
	sub	r0
	to	r6
	getbh
	with	r1
	add	r1
	with	r1
	fmult
.torque
	ibt	r0,#$3c
	add	r8
	from	r1
	stw	[r0]
	ibt	r1,#$50
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	with	r5
	to	r0
	ibt	r6,#$40
	lmult
	from	r4
	sub	r1
	div2
	div2
	add	r1
	sbk
	move	pc,r11
	nop
