; Byte offsets in the copied 25-word retail parameter block.
RCP_ACCEL	equ	6
RCP_BOOST	equ	8
RCP_DECEL	equ	10
RCP_BRAKE	equ	12
RCP_COAST	equ	14
RCP_TURNSTEP	equ	16
RCP_HARDSTEP	equ	18
RCP_TURNLIMIT	equ	20
RCP_HARDLIMIT	equ	22
RCP_CENTERSTEP	equ	24
RCP_SPEEDGRAVITY	equ	30
RCP_JUMP	equ	32
RCP_SHIFTS	equ	40
RCP_CURVES	equ	42
RCP_BOOSTCOST	equ	44

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
	iwt	r0,#RCP_SHIFTS
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
	iwt	r0,#RCP_CURVES
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

; Retail driving stages. These share the early dynamics accumulators but
; operate only on allocated retail-layout records, never early CAR fields.
; A caller must supply the selected definition bank and copied parameters.
; Collision, optional impulses, the complete frame and live dispatch remain.

; Parameter access keeps r0 intact unless r0 is the destination.
mretailparm	macro
	iwt	\1,#\2
	with	\1
	add	r9
	to	\1
	ldw	[\1]
	endm

; US $04:B29A-$B435. Clear force/torque accumulators; speed-dependent gravity, world/route state,
; friction, restricted controls and jump cooldown. Returns controls in r2.
; r8 = allocated raw car, r9 = caller-owned 25-word parameter buffer.
; Uses the shared dynamics workspace and m_retaildriveflags; no allocation.
; r0-r7/flags scratch; r8-r14 and banks preserved.
mretail_driveprep
	sub	r0
	sm	[m_DISPx],r0
	sm	[m_DISPy],r0
	sm	[m_DISPz],r0
	sm	[m_TORQUEy],r0
	sm	[m_TORQUEx],r0
	sm	[m_TORQUEz],r0
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	mretailparm	r6,RCP_SPEEDGRAVITY
	fmult
	bpl	.gravity
	nop
	not
	inc	r0
.gravity
	iwt	r6,#$0078
	with	r6
	add	r0
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r1,#$0008
	and	r1
	bne	.savegravity
	nop
	iwt	r0,#$003c
	with	r6
	add	r0
.savegravity
	sm	[m_DISPy],r6
	ibt	r0,#$1e
	add	r8
	ldw	[r0]
	sm	[m_carworldx],r0
	ibt	r0,#$20
	add	r8
	ldw	[r0]
	sm	[m_carworldy],r0
	ibt	r0,#$22
	add	r8
	ldw	[r0]
	sm	[m_carworldz],r0
	iwt	r0,#$008a
	add	r8
	ldw	[r0]
	sm	[m_retaildriveflags],r0
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0100
	iwt	r2,#$086a
	bic	r2
	or	r1
	sbk
	ibt	r2,#$42
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	ibt	r1,#$64
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0008
	and	r1
	beq	.roadfriction
	nop
	ibt	r0,#$7c
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	.aifriction
	nop
	iwt	r3,#$3e80
	iwt	r7,#$3e80
	bra	.savefriction
	nop
.aifriction
	iwt	r3,#$7d00
	iwt	r7,#$7d00
	bra	.savefriction
	nop
.roadfriction
	iwt	r3,#$3e80
	iwt	r7,#$4650
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0010
	and	r1
	beq	.terrain
	nop
	iwt	pc,#.savefriction&WM
	nop
.terrain
	lm	r1,[m_retaildriveflags]
	iwt	r0,#$0004
	and	r1
	beq	.terrain1
	nop
	iwt	r3,#$445c
	iwt	r7,#$4524
	bra	.savefriction
	nop
.terrain1
	iwt	r0,#$0001
	and	r1
	beq	.terrain42
	nop
	iwt	r3,#$3e80
	iwt	r7,#$4074
	bra	.savefriction
	nop
.terrain42
	iwt	r0,#$0042
	and	r1
	beq	.savefriction
	nop
	iwt	r3,#$4268
	iwt	r7,#$3a98
.savefriction
	sm	[m_offroadfriction],r3
	sm	[m_onroadfriction],r7
	iwt	r3,#$00f0
	iwt	r0,#$0400
	and	r2
	beq	.boostlimit
	nop
	iwt	r3,#$014a
.boostlimit
	ibt	r4,#$40
	with	r4
	add	r8
	to	r4
	ldw	[r4]
	iwt	r0,#$2000
	and	r4
	bne	.wheelcontact
	nop
	lm	r0,[m_retaildriveflags]
	iwt	r1,#$0080
	and	r1
	bne	.speedlimit
	nop
	iwt	r0,#$0010
	and	r4
	bne	.wheelcontact
	nop
	ibt	r0,#$46
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	.wheelcontact
	nop
.speedlimit
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bpl	.speedtest
	nop
	not
	inc	r0
.speedtest
	cmp	r3
	bmi	.wheelcontact
	nop
	iwt	r1,#$0040
	with	r2
	or	r1
	iwt	r1,#$0430
	with	r2
	bic	r1
.wheelcontact
	ibt	r0,#$44
	add	r8
	ldw	[r0]
	sub	#3
	bmi	.restrict
	nop
	iwt	r1,#$0430
	with	r2
	bic	r1
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0008
	or	r1
	sbk
.restrict
	ibt	r0,#$54
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	.clearcontrols
	nop
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0004
	and	r1
	beq	.jump
	nop
.clearcontrols
	iwt	r1,#$043f
	with	r2
	bic	r1
.jump
	ibt	r0,#$5e
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	.jumpready
	nop
	dec	r0
	sbk
	bra	.done
	nop
.jumpready
	iwt	r0,#$0080
	and	r2
	beq	.done
	nop
	mretailparm	r1,RCP_JUMP
	with	r1
	from	r1
	beq	.done
	nop
	lm	r0,[m_DISPy]
	add	r1
	sm	[m_DISPy],r0
	iwt	r1,#$0020
	ibt	r0,#$5e
	add	r8
	from	r1
	stw	[r0]
.done
	move	pc,r11
	nop

; US $04:BA05-$BB16. Retail steering response. r8 = raw car, r9 = parameter buffer, r2 = controls.
; Returns r3 steering word; no RAM writes. r0/r1/r4-r7/flags scratch.
; r2/r8-r14 and banks preserved, including native wrapped comparisons.
mretail_steer
	mretailparm	r5,RCP_TURNSTEP
	ibt	r7,#$00
	ibt	r1,#$40
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0400
	and	r1
	beq	.steering
	nop
	ibt	r7,#$01
	iwt	r6,#$007f
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
	cmp	r6
	bmi	.scaled
	nop
	with	r6
	to	r0
.scaled
	to	r6
	swap
	with	r5
	add	r5
	with	r5
	fmult
.steering
	ibt	r3,#$3a
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	with	r5
	to	r4
	with	r4
	not
	inc	r4
	iwt	r0,#$000f
	and	r2
	bne	.turn
	nop
	with	r7
	from	r7
	beq	.recenter
	nop
	iwt	pc,#.done&WM
	nop
.recenter
	mretailparm	r1,RCP_CENTERSTEP
	with	r3
	from	r3
	bne	.centerdir
	nop
	iwt	pc,#.done&WM
	nop
.centerdir
	bpl	.centerpositive
	nop
	with	r3
	add	r1
	bpl	.centerzero
	nop
	iwt	pc,#.done&WM
	nop
.centerzero
	ibt	r3,#$00
	iwt	pc,#.done&WM
	nop
.centerpositive
	with	r3
	sub	r1
	bmi	.centerzero2
	nop
	iwt	pc,#.done&WM
	nop
.centerzero2
	ibt	r3,#$00
	iwt	pc,#.done&WM
	nop
.turn
	ibt	r6,#$00
	iwt	r0,#$0003
	and	r2
	beq	.hardturn
	nop
	mretailparm	r6,RCP_TURNLIMIT
	iwt	r0,#$0001
	and	r2
	beq	.righttest
	nop
	with	r3
	from	r3
	bpl	.left
	nop
	with	r7
	from	r7
	bne	.left
	nop
	ibt	r3,#$00
.left
	with	r3
	from	r3
	beq	.leftzero
	nop
	iwt	r0,#$0080
	with	r3
	bra	.hardturn
	add	r0
.leftzero
	with	r3
	bra	.hardturn
	add	r5
.righttest
	iwt	r0,#$0002
	and	r2
	beq	.hardturn
	nop
	with	r3
	from	r3
	bmi	.right
	nop
	with	r7
	from	r7
	bne	.right
	nop
	ibt	r3,#$00
.right
	with	r3
	from	r3
	beq	.rightzero
	nop
	iwt	r0,#$0080
	with	r3
	bra	.hardturn
	sub	r0
.rightzero
	with	r3
	add	r4
.hardturn
	iwt	r0,#$000c
	and	r2
	beq	.limit
	nop
	mretailparm	r0,RCP_HARDLIMIT
	with	r6
	add	r0
	mretailparm	r5,RCP_HARDSTEP
	with	r5
	to	r4
	with	r4
	not
	inc	r4
	iwt	r0,#$0004
	and	r2
	beq	.hardright
	nop
	with	r3
	add	r5
.hardright
	iwt	r0,#$0008
	and	r2
	beq	.limit
	nop
	with	r3
	add	r4
.limit
	with	r6
	to	r4
	with	r4
	not
	inc	r4
	with	r3
	from	r3
	bmi	.negative
	nop
	with	r3
	cmp	r6
	bmi	.done
	nop
	with	r6
	to	r3
	bra	.done
	nop
.negative
	with	r3
	cmp	r4
	bpl	.done
	nop
	with	r4
	to	r3
.done
	with	r11
	to	pc
	nop

; US $04:B43B-$B4C4. r3 = steering result, r2 = prepared controls, r8 = raw car, r9 = parameters.
; Stores steering and requested power; returns r1 force for mretail_gearforce.
; m_retailrouteword supplies scene flags ($26F2), separate from car +8A.
; Boost consumption observes the car and scene flags. r0/r4/r6/flags scratch;
; r2/r5/r7-r14 and banks preserved; r3 may be doubled.
mretail_driveforce
	ibt	r1,#$70
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0008
	and	r1
	beq	.savesteer
	nop
	with	r3
	add	r3
.savesteer
	ibt	r0,#$3a
	add	r8
	from	r3
	stw	[r0]
	ibt	r1,#$00
	iwt	r0,#$0020
	and	r2
	beq	.boost
	nop
	mretailparm	r1,RCP_DECEL
	with	r1
	not
	inc	r1
.boost
	iwt	r0,#$0400
	and	r2
	beq	.accel
	nop
	mretailparm	r1,RCP_ACCEL
	ibt	r6,#$6a
	with	r6
	add	r8
	to	r6
	ldw	[r6]
	with	r6
	from	r6
	beq	.normalforce
	nop
	ibt	r4,#$40
	with	r4
	add	r8
	to	r4
	ldw	[r4]
	iwt	r0,#$2000
	and	r4
	bne	.boostforce
	nop
	mretailparm	r0,RCP_BOOSTCOST
	with	r6
	sub	r0
	bpl	.saveboost
	nop
	ibt	r6,#$00
.saveboost
	lm	r0,[m_retailrouteword]
	iwt	r1,#$0200
	and	r1
	bne	.boostforce
	nop
	ibt	r0,#$6a
	add	r8
	from	r6
	stw	[r0]
.boostforce
	mretailparm	r1,RCP_BOOST
	bra	.forceflags
	nop
.accel
	iwt	r0,#$0010
	and	r2
	beq	.forceflags
	nop
.normalforce
	mretailparm	r1,RCP_ACCEL
.forceflags
	ibt	r4,#$40
	with	r4
	add	r8
	to	r4
	ldw	[r4]
	iwt	r0,#$2000
	and	r4
	beq	.saveforce
	nop
	with	r1
	add	r1
	with	r1
	add	r1
.saveforce
	ibt	r0,#$78
	add	r8
	from	r1
	stw	[r0]
	move	pc,r11
	nop

; US $04:B5AE-$B610. Coasting/brake drag and final control word, after optional external forces.
; r2 = prepared controls, r8 = raw car, r9 = parameter buffer.
; r0/r1/r3/r6/flags scratch; other registers and banks preserved.
mretail_dragrate
	iwt	r1,#$0000
	iwt	r0,#$0410
	and	r2
	bne	.brake
	nop
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	add	r0
	add	r0
	add	r0
	bpl	.coasting
	nop
	not
	inc	r0
.coasting
	mretailparm	r6,RCP_COAST
	add	r0
	fmult
	iwt	r1,#$0800
	cmp	r1
	bpl	.coastforce
	nop
	with	r1
	to	r0
.coastforce
	with	r0
	to	r1
.brake
	iwt	r0,#$0040
	and	r2
	beq	.save
	nop
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	.save
	nop
	with	r0
	to	r3
	iwt	r0,#$00c8
	cmp	r3
	bpl	.brakeforce
	nop
	ibt	r1,#$40
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0800
	or	r1
	sbk
.brakeforce
	mretailparm	r1,RCP_BRAKE
.save
	ibt	r0,#$48
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$42
	add	r8
	from	r2
	stw	[r0]
	iwt	r1,#$0040
	ibt	r0,#$2c
	add	r8
	from	r1
	stw	[r0]
	move	pc,r11
	nop

; US $04:B6C1-$B826. Clamp four force/torque accumulators and car tilt, damp high-speed motion,
; then add all six accumulators to raw car velocity/torque words +2E..+38.
; r8 = raw car; shared dynamics workspace contains the accumulated forces.
; Retains the two native zero flag masks and their unreachable branch.
; r0-r4/r12/r13/flags scratch; r5-r11/r14 and banks preserved.
mretail_limitmotion
	iwt	r1,#$f448
	iwt	r2,#$0bb8
	lm	r0,[m_DISPy]
	with	r0
	from	r0
	bmi	.negy
	nop
	cmp	r2
	bmi	.savey
	nop
	with	r2
	to	r0
	bra	.savey
	nop
.negy
	cmp	r1
	bpl	.savey
	nop
	with	r1
	to	r0
.savey
	sbk
	lm	r0,[m_TORQUEz]
	with	r0
	from	r0
	bmi	.negz
	nop
	cmp	r2
	bmi	.savez
	nop
	with	r2
	to	r0
	bra	.savez
	nop
.negz
	cmp	r1
	bpl	.savez
	nop
	with	r1
	to	r0
.savez
	sbk
	lm	r0,[m_TORQUEy]
	with	r0
	from	r0
	bmi	.negtorquey
	nop
	cmp	r2
	bmi	.savetorquey
	nop
	with	r2
	to	r0
	bra	.savetorquey
	nop
.negtorquey
	cmp	r1
	bpl	.savetorquey
	nop
	with	r1
	to	r0
.savetorquey
	sbk
	lm	r0,[m_TORQUEx]
	with	r0
	from	r0
	bmi	.negtorquex
	nop
	cmp	r2
	bmi	.savetorquex
	nop
	with	r2
	to	r0
	bra	.savetorquex
	nop
.negtorquex
	cmp	r1
	bpl	.savetorquex
	nop
	with	r1
	to	r0
.savetorquex
	sbk
	ibt	r2,#$00
	ibt	r0,#$28
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	.negtiltz
	nop
	iwt	r1,#$2000
	cmp	r1
	bmi	.tiltx
	nop
	from	r1
	sbk
	ibt	r0,#$38
	add	r8
	from	r2
	stw	[r0]
	bra	.tiltx
	nop
.negtiltz
	iwt	r1,#$e000
	cmp	r1
	bpl	.tiltx
	nop
	from	r1
	sbk
	ibt	r0,#$38
	add	r8
	from	r2
	stw	[r0]
.tiltx
	ibt	r1,#$40
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0000
	and	r1
	bne	.inverted
	nop
	ibt	r0,#$26
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	.negtiltx
	nop
	iwt	r1,#$2000
	cmp	r1
	bmi	.clearflag
	nop
	from	r1
	sbk
	ibt	r0,#$36
	add	r8
	from	r2
	stw	[r0]
	bra	.clearflag
	nop
.negtiltx
	iwt	r1,#$e000
	cmp	r1
	bpl	.clearflag
	nop
	from	r1
	sbk
	ibt	r0,#$36
	add	r8
	from	r2
	stw	[r0]
	bra	.clearflag
	nop
.inverted
	ibt	r0,#$26
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bpl	.invertedtest
	nop
	not
	inc	r0
.invertedtest
	iwt	r1,#$4000
	cmp	r1
	bmi	.clearflag
	nop
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0000
	or	r1
	sbk
	ibt	r0,#$76
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	.invertforce
	nop
	ibt	r0,#$28
	sbk
.invertforce
	lm	r0,[m_TORQUEx]
	not
	inc	r0
	bra	.speed
	sbk
.clearflag
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0000
	bic	r1
	sbk
.speed
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bpl	.speedtest
	nop
	not
	inc	r0
.speedtest
	iwt	r1,#$0258
	cmp	r1
	bmi	.integrate
	sub	r0
	sm	[m_DISPx],r0
	sm	[m_DISPz],r0
	ibt	r1,#$2e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	from	r1
	div2
	div2
	div2
	from	r1
	sub	r0
	sbk
	ibt	r1,#$32
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	from	r1
	div2
	div2
	div2
	from	r1
	sub	r0
	sbk
.integrate
	cache
	iwt	r4,#m_DISPx&WM
	iwt	r2,#$002e
	with	r2
	add	r8
	ibt	r12,#$06
	with	pc
	to	r13
	ldw	[r4]
	inc	r4
	inc	r4
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	loop
	nop
	move	pc,r11
	nop

; Contiguous driving-input stage, US $04:B29A-$04:B4C4. Caller supplies
; r8 raw car/r9 parameters. Returns r1 force/r2 controls/r7 parameter buffer
; for mretail_gearforce; steering is stored at car +3A and power at +78.
; ROM bank selects compiled definitions; m_retailrouteword supplies scene flags.
; Saves only the caller's link on the GSU stack; r8/r9/r10/r11 preserved.
mretail_driveinputs
	mpush	r11
	mcall	mretail_driveprep
	nop
	mcall	mretail_steer
	nop
	mcall	mretail_driveforce
	nop
	move	r7,r9
	mpop	r11
	move	pc,r11
	nop

; Return from the inherited normalizer to the bank-4 force resolver.
; r1/r2/r3 contain the result; r0/r13 and flags are scratch.
	extern	mretail_normalreturn4
mretail_normalreturn1
	iwt	r13,#mretail_normalreturn4>>16
	iwt	r0,#mretail_normalreturn4&WM
	from	r0
	ljmp	r13
	nop

; Bank-4 contact math uses the inherited rotation and divider routines.
	extern	mretail_rotreturn4,mretail_divreturn4
mretail_rotreturn1
	iwt	r13,#mretail_rotreturn4>>16
	iwt	r0,#mretail_rotreturn4&WM
	from	r0
	ljmp	r13
	nop
mretail_divreturn1
	iwt	r13,#mretail_divreturn4>>16
	iwt	r0,#mretail_divreturn4&WM
	from	r0
	ljmp	r13
	nop

; Bank-4 collision geometry shares the original point-stream copier.
	extern	mretail_pointsreturn4
mretail_pointsreturn1
	iwt	r13,#mretail_pointsreturn4>>16
	iwt	r0,#mretail_pointsreturn4&WM
	from	r0
	ljmp	r13
	nop
