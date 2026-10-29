; Retail wheel and body collision stages. Execute in bank 4, RAM bank zero.
; Raw records use retail offsets; these entries do not accept early CAR/WHL.
; Call mretail_preparewheelparams with the definition ROM bank selected,
; then supply the car matrix/world words and serialized dynamics workspace.
; m_retailwheelparams/flags/context share the existing polygon buffer; no
; renderer may use that buffer while this dynamics context is live.
; Valid contact/object/wheel lists must terminate. Shape streams must obey
; mretail_shapegroups' group and 70-point limits. No allocator for raw bodies,
; shape binder, CPU caller or live scheduler is installed by this module.

mrwheel_begin

; US $04:A1EC. Walk m_objects through raw +04 links, calling pair/contact maintenance.
; r1/r2/r6-r9 and flags scratch; r10 restored. Valid terminating raw lists only.
mretail_scancontacts
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	lm	r0,[m_objects]
	cache
mrwh_scan_next
	with	r1
	from	r0
	beq	mrwh_scan_done
	nop
	link	#4
	iwt	pc,#mretail_paircontacts&WM
	nop
	ibt	r0,#$04
	add	r1
	ldw	[r0]
	bra	mrwh_scan_next
	nop
mrwh_scan_done
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:A20B. r1 = raw body. Test later +04 list entries against summed XYZ bounds,
; optional car-approach filter and asymmetric type/mask gates; cache both
; permitted directions and sweep this owner. r1-r5/r10 restored; other scratch.
mretail_paircontacts
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r3,#$1e
	with	r3
	add	r1
	to	r3
	ldw	[r3]
	ibt	r4,#$20
	with	r4
	add	r1
	to	r4
	ldw	[r4]
	ibt	r5,#$22
	with	r5
	add	r1
	to	r5
	ldw	[r5]
	ibt	r0,#$0c
	add	r1
	ldw	[r0]
	sm	[m_normX],r0
	ibt	r0,#$0e
	add	r1
	ldw	[r0]
	sm	[m_normY],r0
	ibt	r0,#$10
	add	r1
	ldw	[r0]
	sm	[m_normZ],r0
	with	r1
	to	r2
mrwh_pair_next
	ibt	r0,#$04
	add	r2
	ldw	[r0]
	with	r2
	from	r0
	bne	mrwh_pair_z
	nop
	iwt	pc,#mrwh_pair_sweep&WM
	nop
mrwh_pair_z
	ibt	r6,#$10
	with	r6
	add	r2
	to	r6
	ldw	[r6]
	lm	r0,[m_normZ]
	with	r6
	add	r0
	ibt	r0,#$22
	add	r2
	ldw	[r0]
	sub	r5
	bpl	mrwh_pair_zabs
	nop
	not
	inc	r0
mrwh_pair_zabs
	sub	r6
	bpl	mrwh_pair_next
	nop
	ibt	r6,#$0c
	with	r6
	add	r2
	to	r6
	ldw	[r6]
	lm	r0,[m_normX]
	with	r6
	add	r0
	ibt	r0,#$1e
	add	r2
	ldw	[r0]
	sub	r3
	bpl	mrwh_pair_xabs
	nop
	not
	inc	r0
mrwh_pair_xabs
	sub	r6
	bpl	mrwh_pair_next
	nop
	ibt	r6,#$0e
	with	r6
	add	r2
	to	r6
	ldw	[r6]
	lm	r0,[m_normY]
	with	r6
	add	r0
	ibt	r0,#$20
	add	r2
	ldw	[r0]
	sub	r4
	bpl	mrwh_pair_yabs
	nop
	not
	inc	r0
mrwh_pair_yabs
	sub	r6
	bmi	mrwh_pair_carflags
	nop
	iwt	pc,#mrwh_pair_next&WM
	nop
mrwh_pair_carflags
	ibt	r0,#$16
	add	r1
	ldw	[r0]
	ibt	r6,#$16
	with	r6
	add	r2
	to	r6
	ldw	[r6]
	and	r6
	iwt	r6,#$0002
	and	r6
	beq	mrwh_pair_firstmask
	nop
	with	r1
	to	r7
	with	r2
	to	r8
	link	#4
	iwt	pc,#mretail_rawapproach&WM
	nop
	with	r0
	from	r0
	bne	mrwh_pair_advance
	nop
mrwh_pair_firstmask
	ibt	r0,#$1a
	add	r1
	ldw	[r0]
	ibt	r6,#$16
	with	r6
	add	r2
	to	r6
	ldw	[r6]
	and	r6
	bne	mrwh_pair_secondmask
	nop
	with	r1
	to	r6
	with	r2
	to	r8
	link	#4
	iwt	pc,#mretail_putcarcontact&WM
	nop
mrwh_pair_secondmask
	ibt	r0,#$1a
	add	r2
	ldw	[r0]
	ibt	r6,#$16
	with	r6
	add	r1
	to	r6
	ldw	[r6]
	and	r6
	bne	mrwh_pair_advance
	nop
	with	r2
	to	r6
	with	r1
	to	r8
	link	#4
	iwt	pc,#mretail_putcarcontact&WM
	nop
mrwh_pair_advance
	iwt	pc,#mrwh_pair_next&WM
	nop
mrwh_pair_sweep
	ibt	r0,#$18
	add	r1
	ldw	[r0]
	with	r0
	from	r0
	beq	mrwh_pair_done
	nop
	with	r1
	to	r6
	link	#4
	iwt	pc,#mretail_sweeprawcontacts&WM
	nop
mrwh_pair_done
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:A301. r7 = raw body. Read its first contact cache, or raw velocity fallback,
; into m_x1/m_y1/m_z1; cached Y is zero. r1/r11/flags scratch.
mretail_rawcontactvelocity
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$18
	with	r1
	add	r7
	to	r1
	ldw	[r1]
	with	r1
	from	r1
	beq	mrwh_velocity_fallback
	nop
	ibt	r0,#$04
	add	r1
	ldw	[r0]
	sm	[m_x1],r0
	ibt	r0,#$06
	add	r1
	ldw	[r0]
	sm	[m_z1],r0
	sub	r0
	sm	[m_y1],r0
	bra	mrwh_velocity_done
	nop
mrwh_velocity_fallback
	ibt	r0,#$2e
	add	r7
	ldw	[r0]
	sm	[m_x1],r0
	ibt	r0,#$30
	add	r7
	ldw	[r0]
	sm	[m_y1],r0
	ibt	r0,#$32
	add	r7
	ldw	[r0]
	sm	[m_z1],r0
mrwh_velocity_done
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:A345. r6 = raw owner, r8 = raw source. Owner +16 bit $80 suppresses
; contact lookup/allocation. Other permitted calls fall through to raw put.
mretail_putcarcontact
	ibt	r0,#$16
	add	r6
	ldw	[r0]
	iwt	r9,#$0080
	and	r9
	beq	mretail_putrawcontact
	nop
	iwt	pc,#mrwh_contact_done&WM
	nop

; US $04:A354. r6 = raw owner, r8 = raw source. Reuse or allocate an 18-byte
; contact in m_dynmem, keyed by source; update X/Z cache unless held.
; Retains exact/split/exhaustion allocation behavior. Owner head is +18.
mretail_putrawcontact
	ibt	r7,#$18
	with	r7
	add	r6
	to	r7
	ldw	[r7]
	with	r7
	from	r7
	beq	mrwh_contact_allocate
	nop
mrwh_contact_find
	ibt	r0,#$0c
	add	r7
	ldw	[r0]
	cmp	r8
	bne	mrwh_contact_next
	nop
	iwt	pc,#mrwh_contact_update&WM
	nop
mrwh_contact_next
	ibt	r0,#$0e
	add	r7
	ldw	[r0]
	with	r7
	from	r0
	bne	mrwh_contact_find
	nop
mrwh_contact_allocate
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r9,#m_dynmem&WM
	cache
	ibt	r7,#$12
	from	r9
	stw	[r10]
	inc	r10
	inc	r10
mrwh_a383
	to	r8
	ldw	[r9]
	inc	r9
	inc	r9
	ldw	[r9]
	sub	r7
	beq	mrwh_a3a8
	nop
	with	r9
	from	r8
	bne	mrwh_a383
	nop
	dec	r10
	dec	r10
	to	r9
	ldw	[r10]
mrwh_a395
	to	r8
	ldw	[r9]
	inc	r9
	inc	r9
	ldw	[r9]
	sub	r7
	bpl	mrwh_a3b2
	nop
	with	r9
	from	r8
	bne	mrwh_a395
	nop
	ibt	r7,#$00
	bra	mrwh_a3cc
	nop
mrwh_a3a8
	dec	r10
	dec	r10
	ldw	[r10]
	with	r7
	not
	inc	r7
	sub	r0
	bra	mrwh_a3c3
	nop
mrwh_a3b2
	sub	#4
	bpl	mrwh_a3c0
	nop
	add	#4
	with	r7
	add	r0
	with	r7
	not
	inc	r7
	ibt	r0,#-4
mrwh_a3c0
	add	#4
	stw	[r9]
mrwh_a3c3
	from	r9
	to	r8
	add	r0
	from	r7
	stw	[r8]
	dec	r8
	dec	r8
	with	r8
	to	r7
mrwh_a3cc
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	with	r7
	from	r7
	bne	mrwh_a3d9
	nop
	iwt	pc,#mrwh_contact_nomem&WM
	nop
mrwh_a3d9
	nop
	iwt	r9,#$0012
	ibt	r0,#$0c
	add	r7
	from	r8
	stw	[r0]
	ibt	r9,#$18
	with	r9
	add	r6
	to	r9
	ldw	[r9]
	ibt	r0,#$0e
	add	r7
	from	r9
	stw	[r0]
	ibt	r0,#$18
	add	r6
	from	r7
	stw	[r0]
	ibt	r9,#$00
	ibt	r0,#$10
	add	r7
	from	r9
	stw	[r0]
mrwh_contact_update
	ibt	r9,#$10
	with	r9
	add	r7
	to	r9
	ldw	[r9]
	iwt	r0,#$0004
	and	r9
	bne	mrwh_contact_mark
	nop
	ibt	r9,#$2e
	with	r9
	add	r8
	to	r9
	ldw	[r9]
	ibt	r0,#$04
	add	r7
	from	r9
	stw	[r0]
	ibt	r9,#$32
	with	r9
	add	r8
	to	r9
	ldw	[r9]
	ibt	r0,#$06
	add	r7
	from	r9
	stw	[r0]
	ibt	r9,#$1e
	with	r9
	add	r8
	to	r9
	ldw	[r9]
	ibt	r0,#$08
	add	r7
	from	r9
	stw	[r0]
	ibt	r9,#$22
	with	r9
	add	r8
	to	r9
	ldw	[r9]
	ibt	r0,#$0a
	add	r7
	from	r9
	stw	[r0]
mrwh_contact_mark
	ibt	r0,#$10
	add	r7
	ldw	[r0]
	iwt	r9,#$0001
	or	r9
	sbk
mrwh_contact_done
	with	r11
	to	pc
	nop
mrwh_contact_nomem
	with	r11
	to	pc
	nop

; US $04:A441. r6 = raw owner. Clear only usage marks in its +18 contact list.
mretail_clearrawcontacts
	ibt	r8,#$18
	with	r8
	add	r6
	to	r8
	ldw	[r8]
	with	r8
	from	r8
	beq	mrwh_a45f
	nop
	iwt	r12,#$0001
mrwh_a44f
	ibt	r0,#$10
	add	r8
	ldw	[r0]
	bic	r12
	sbk
	ibt	r0,#$0e
	add	r8
	ldw	[r0]
	with	r8
	from	r0
	bne	mrwh_a44f
	nop
mrwh_a45f
	with	r11
	to	pc
	nop

; US $04:A462. r6 = raw owner. Sweep its +18 contacts; keep marked entries in order,
; clear their usage bit and return unmarked blocks to m_dynmem. No coalescing.
mretail_sweeprawcontacts
	ibt	r8,#$18
	with	r8
	add	r6
	to	r8
	ldw	[r8]
	with	r8
	from	r8
	beq	mrwh_a489
	nop
	iwt	r12,#$0001
	ibt	r2,#$00
mrwh_a472
	ibt	r0,#$10
	add	r8
	ldw	[r0]
	to	r9
	and	r12
	beq	mrwh_a48c
	nop
	bic	r12
	sbk
	with	r8
	to	r2
	ibt	r0,#$0e
	add	r8
	ldw	[r0]
mrwh_a484
	with	r8
	from	r0
	bne	mrwh_a472
	nop
mrwh_a489
	with	r11
	to	pc
	nop
mrwh_a48c
	ibt	r7,#$0e
	with	r7
	add	r8
	to	r7
	ldw	[r7]
	with	r2
	from	r2
	bne	mrwh_a49f
	nop
	ibt	r0,#$18
	add	r6
	from	r7
	stw	[r0]
	bra	mrwh_a4a4
	nop
mrwh_a49f
	ibt	r0,#$0e
	add	r2
	from	r7
	stw	[r0]
mrwh_a4a4
	from	r7
	stw	[r10]
	inc	r10
	inc	r10
	inc	r8
	inc	r8
	ldw	[r8]
	with	r7
	from	r0
	bpl	mrwh_a4b3
	nop
	with	r7
	not
	inc	r7
mrwh_a4b3
	dec	r8
	dec	r8
	iwt	r7,#m_dynmem&WM
	with	r8
	to	r9
	inc	r9
	inc	r9
	ldw	[r9]
	with	r0
	from	r0
	bpl	mrwh_a4c8
	nop
	not
	inc	r0
	stw	[r9]
	bra	mrwh_a4cc
	nop
mrwh_a4c8
	ldw	[r7]
	stw	[r8]
	from	r8
	stw	[r7]
mrwh_a4cc
	dec	r10
	dec	r10
	to	r7
	ldw	[r10]
	with	r7
	to	r0
	bra	mrwh_a484
	nop

; US $04:A4ED. r8 = raw car, prepared m_wmat/m_carworldXYZ. Traverse +3E wheels
; through +34 links; rotate offsets, update poses and eight-times velocities.
; Held wheels retain pose and zero velocity. r8/r10 and ROM bank preserved.
mretail_wheelpose
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$3e
	add	r8
	ldw	[r0]
	cache
mrwh_pose_next
	with	r9
	from	r0
	bne	mrwh_pose_wheel
	nop
	iwt	pc,#mrwh_pose_done&WM
	nop
mrwh_pose_wheel
	nop
	ibt	r1,#$46
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$0400
	and	r1
	beq	mrwh_pose_rotate
	nop
	iwt	pc,#mrwh_pose_hold&WM
	nop
mrwh_pose_rotate
	with	r8
	to	r12
	iwt	r8,#$003c
	with	r8
	add	r9
	iwt	r11,#$0036
	with	r11
	add	r9
	to	r1
	ldw	[r8]
	inc	r8
	inc	r8
	to	r2
	ldw	[r8]
	inc	r8
	inc	r8
	to	r3
	ldw	[r8]
	inc	r8
	inc	r8
	lms	r6,[m_wmat11]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat21]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat31]
	from	r3
	fmult
	rol
	add	r5
	stw	[r11]
	inc	r11
	inc	r11
	lms	r6,[m_wmat12]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat22]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat32]
	from	r3
	fmult
	rol
	add	r5
	stw	[r11]
	inc	r11
	inc	r11
	lms	r6,[m_wmat13]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat23]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat33]
	from	r3
	fmult
	rol
	add	r5
	stw	[r11]
	inc	r11
	inc	r11
	with	r12
	to	r8
	iwt	r6,#$0008
	ibt	r1,#$36
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	lm	r0,[m_carworldx]
	ibt	r2,#$1e
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	with	r1
	add	r0
	ibt	r0,#$1e
	add	r9
	from	r1
	stw	[r0]
	with	r1
	sub	r2
	with	r1
	lmult
	ibt	r0,#$2e
	add	r9
	from	r4
	stw	[r0]
	ibt	r1,#$38
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	lm	r0,[m_carworldy]
	ibt	r2,#$20
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	with	r1
	add	r0
	ibt	r0,#$20
	add	r9
	from	r1
	stw	[r0]
	with	r1
	sub	r2
	with	r1
	lmult
	ibt	r0,#$30
	add	r9
	from	r4
	stw	[r0]
	ibt	r1,#$3a
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	lm	r0,[m_carworldz]
	ibt	r2,#$22
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	with	r1
	add	r0
	ibt	r0,#$22
	add	r9
	from	r1
	stw	[r0]
	with	r1
	sub	r2
	with	r1
	lmult
	ibt	r0,#$32
	add	r9
	from	r4
	stw	[r0]
	ibt	r0,#$34
	add	r9
	ldw	[r0]
	iwt	pc,#mrwh_pose_next&WM
	nop
	nop
	bra	mrwh_pose_done
	nop
mrwh_pose_hold
	ibt	r1,#$00
	ibt	r0,#$2e
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$30
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$32
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$34
	add	r9
	ldw	[r0]
	iwt	pc,#mrwh_pose_next&WM
	nop
	nop
mrwh_pose_done
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:A607. r8 = raw car. Clear off/on-ground and skid totals, traverse +3E/+34
; wheels, select follower/ordinary dynamics and combine surface bits at +92.
; Prepared matrix, force workspace and 25 copied wheel parameters required.
mretail_wheels
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$00
	ibt	r0,#$44
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$46
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$56
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$3e
	add	r8
	ldw	[r0]
mrwh_wheels_next
	with	r9
	from	r0
	beq	mrwh_wheels_done
	nop
	ibt	r0,#$46
	add	r9
	ldw	[r0]
	iwt	r1,#$0800
	and	r1
	beq	mrwh_wheels_normal
	nop
	link	#4
	iwt	pc,#mretail_followwheel&WM
	nop
	bra	mrwh_wheels_surface
	nop
mrwh_wheels_normal
	link	#4
	iwt	pc,#mretail_wheel&WM
	nop
mrwh_wheels_surface
	ibt	r1,#$2c
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$0092
	add	r8
	ldw	[r0]
	or	r1
	sbk
	ibt	r0,#$34
	add	r9
	ldw	[r0]
	bra	mrwh_wheels_next
	nop
mrwh_wheels_done
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:A656. r8 = raw car, r9 = raw follower wheel. One-time initialization gate,
; selected leader tracking, dead-zone/sign-sensitive velocity forces,
; displacement and parameter-selected torque. Native asymmetric Z path retained.
mretail_followwheel
	ibt	r0,#$64
	add	r8
	ldw	[r0]
	iwt	r4,#$0001
	and	r4
	beq	mrwh_a665
	nop
	iwt	pc,#mretail_followdirect&WM
	nop
mrwh_a665
	nop
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$46
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$0004
	and	r1
	bne	mrwh_follow_leader
	nop
	iwt	r0,#$0004
	or	r1
	sbk
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_follow_leader
	iwt	r2,#$0800
	iwt	r7,#$008e
	with	r7
	add	r8
	to	r7
	ldw	[r7]
	ibt	r1,#$28
	with	r1
	add	r7
	to	r1
	ldw	[r1]
	ibt	r0,#$28
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$3e
	add	r7
	ldw	[r0]
mrwh_follow_find
	with	r0
	from	r0
	beq	mrwh_follow_delta
	nop
	with	r0
	to	r7
	ibt	r0,#$46
	add	r7
	ldw	[r0]
	and	r2
	bne	mrwh_follow_delta
	nop
	ibt	r0,#$34
	add	r7
	ldw	[r0]
	bra	mrwh_follow_find
	nop
mrwh_follow_delta
	ibt	r1,#$1e
	with	r1
	add	r7
	to	r1
	ldw	[r1]
	ibt	r2,#$20
	with	r2
	add	r7
	to	r2
	ldw	[r2]
	ibt	r3,#$22
	with	r3
	add	r7
	to	r3
	ldw	[r3]
	ibt	r0,#$1e
	add	r9
	ldw	[r0]
	with	r1
	sub	r0
	ibt	r0,#$20
	add	r9
	ldw	[r0]
	with	r2
	sub	r0
	ibt	r0,#$22
	add	r9
	ldw	[r0]
	with	r3
	sub	r0
	sm	[m_test1],r3
	iwt	r4,#$00c8
	with	r0
	from	r1
	bpl	mrwh_a6e2
	nop
	not
	inc	r0
mrwh_a6e2
	cmp	r4
	bpl	mrwh_a6e9
	nop
	ibt	r1,#$00
mrwh_a6e9
	with	r0
	from	r2
	bpl	mrwh_a6f0
	nop
	not
	inc	r0
mrwh_a6f0
	cmp	r4
	bpl	mrwh_a6f7
	nop
	ibt	r2,#$00
mrwh_a6f7
	with	r0
	from	r3
	bpl	mrwh_a6fe
	nop
	not
	inc	r0
mrwh_a6fe
	cmp	r4
	bpl	mrwh_a705
	nop
	ibt	r3,#$00
mrwh_a705
	with	r1
	add	r1
	with	r2
	add	r2
	with	r3
	add	r3
	with	r1
	add	r1
	with	r2
	add	r2
	with	r3
	add	r3
	ibt	r4,#$2e
	with	r4
	add	r7
	to	r4
	ldw	[r4]
	ibt	r5,#$30
	with	r5
	add	r7
	to	r5
	ldw	[r5]
	ibt	r6,#$32
	with	r6
	add	r7
	to	r6
	ldw	[r6]
	ibt	r5,#$00
	with	r4
	add	r4
	with	r5
	add	r5
	with	r6
	add	r6
	with	r4
	add	r4
	with	r5
	add	r5
	with	r6
	add	r6
	ibt	r0,#$2e
	add	r9
	ldw	[r0]
	to	r7
	xor	r1
	bpl	mrwh_a73d
	nop
	with	r1
	sub	r0
mrwh_a73d
	ibt	r0,#$30
	add	r9
	ldw	[r0]
	to	r7
	xor	r2
	bpl	mrwh_a749
	nop
	with	r2
	sub	r0
mrwh_a749
	ibt	r0,#$32
	add	r9
	ldw	[r0]
	sm	[m_test2],r0
	to	r7
	xor	r3
	bpl	mrwh_a759
	nop
	with	r2
	sub	r0
mrwh_a759
	with	r1
	add	r4
	with	r2
	add	r5
	with	r3
	add	r6
	with	r1
	to	r4
	with	r2
	to	r5
	with	r3
	to	r6
	link	#4
	iwt	pc,#mretail_forceworld&WM
	nop
	ibt	r1,#$36
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r2,#$38
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	ibt	r3,#$3a
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	ibt	r1,#$00
	ibt	r2,#$00
	ibt	r3,#$00
	link	#4
	iwt	pc,#mretail_forcedisp&WM
	nop
	ibt	r1,#$3c
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r2,#$3e
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	ibt	r3,#$40
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	ibt	r0,#$04
	romb
	lm	r0,[m_retailwheelparams+2]
	iwt	r14,#mretail_wheeltorques&WM
	with	r14
	add	r0
	getb
	inc	r14
	getbh
	with	r0
	to	r12
	link	#2
	jmp	r12
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:A7B4. Direct follower variant: seed wheel velocity from displacement before
; tracking the selected leader. Shares the native wheel-flag initialization gate.
mretail_followdirect
	lm	r1,[m_DISPx]
	ibt	r0,#$2e
	add	r9
	from	r1
	stw	[r0]
	lm	r1,[m_DISPy]
	ibt	r0,#$30
	add	r9
	from	r1
	stw	[r0]
	lm	r1,[m_DISPz]
	ibt	r0,#$32
	add	r9
	from	r1
	stw	[r0]
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$46
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$0004
	and	r1
	bne	mrwh_direct_leader
	nop
	iwt	r0,#$0004
	or	r1
	sbk
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_direct_leader
	iwt	r2,#$0800
	iwt	r7,#$008e
	with	r7
	add	r8
	to	r7
	ldw	[r7]
	ibt	r0,#$3e
	add	r7
	ldw	[r0]
mrwh_direct_find
	with	r0
	from	r0
	beq	mrwh_direct_delta
	nop
	with	r0
	to	r7
	ibt	r0,#$46
	add	r7
	ldw	[r0]
	and	r2
	bne	mrwh_direct_delta
	nop
	ibt	r0,#$34
	add	r7
	ldw	[r0]
	bra	mrwh_direct_find
	nop
mrwh_direct_delta
	ibt	r1,#$1e
	with	r1
	add	r7
	to	r1
	ldw	[r1]
	ibt	r2,#$20
	with	r2
	add	r7
	to	r2
	ldw	[r2]
	ibt	r3,#$22
	with	r3
	add	r7
	to	r3
	ldw	[r3]
	ibt	r0,#$1e
	add	r9
	ldw	[r0]
	with	r1
	sub	r0
	ibt	r0,#$20
	add	r9
	ldw	[r0]
	with	r2
	sub	r0
	ibt	r0,#$22
	add	r9
	ldw	[r0]
	with	r3
	sub	r0
	with	r1
	add	r1
	with	r2
	add	r2
	with	r3
	add	r3
	with	r1
	add	r1
	with	r2
	add	r2
	with	r3
	add	r3
	with	r1
	to	r4
	with	r2
	to	r5
	with	r3
	to	r6
	link	#4
	iwt	pc,#mretail_forceworld&WM
	nop
	ibt	r1,#$36
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r2,#$38
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	ibt	r3,#$3a
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	ibt	r1,#$00
	ibt	r2,#$00
	ibt	r3,#$00
	link	#4
	iwt	pc,#mretail_forcedisp&WM
	nop
	ibt	r1,#$3c
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r2,#$3e
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	ibt	r3,#$40
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	ibt	r0,#$04
	romb
	lm	r0,[m_retailwheelparams+2]
	iwt	r14,#mretail_wheeltorques&WM
	with	r14
	add	r0
	getb
	inc	r14
	getbh
	with	r0
	to	r12
	link	#2
	jmp	r12
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:A893. r8 = raw car, r9 = raw wheel. Definition flags, contacts/shape groups,
; material response, procedural ground, grip/skid/brake forces, spring
; displacement and selected torque are processed as one native stage.
; Shared aliases below are serialized with rendering; raw lists must terminate.
mretail_wheel
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$46
	add	r9
	ldw	[r0]
	sm	[m_retailwheeldefs],r0
	ibt	r1,#$00
	ibt	r0,#$2c
	add	r9
	from	r1
	stw	[r0]
	iwt	r3,#$0400
	ibt	r2,#$40
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	lm	r1,[m_retailwheeldefs]
	with	r1
	bic	r3
	iwt	r0,#$0200
	and	r1
	beq	mrwh_wheel_active
	nop
	iwt	r0,#$0000
	and	r2
	bne	mrwh_wheel_active
	nop
	with	r1
	or	r3
	from	r1
	sbk
	iwt	pc,#mrwh_wheel_done&WM
	nop
mrwh_wheel_active
	from	r1
	sbk
	ibt	r1,#$24
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r0,#$24
	add	r9
	from	r1
	stw	[r0]
	ibt	r1,#$28
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r0,#$28
	add	r9
	from	r1
	stw	[r0]
	lm	r2,[m_retailwheeldefs]
	iwt	r0,#$0002
	and	r2
	beq	mrwh_wheel_contact
	nop
	ibt	r0,#$3a
	add	r8
	ldw	[r0]
	ibt	r1,#$24
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	add	r1
	sbk
mrwh_wheel_contact
	lm	r0,[m_retailwheeldefs]
	iwt	r1,#$0080
	and	r1
	beq	mrwh_wheel_clearforces
	nop
	iwt	pc,#mrwh_wheel_steer&WM
	nop
mrwh_wheel_clearforces
	link	#4
	iwt	pc,#mretail_forceclear&WM
	nop
	iwt	r0,#$0000
	iwt	r1,#$7d00
	sm	[m_groupblocks+10],r0
	sm	[m_groupblocks+12],r1
	sm	[m_groupblocks+20],r0
	sm	[m_groupblocks+22],r1
	sm	[m_groupblocks+30],r0
	sm	[m_groupblocks+32],r1
	sm	[m_groupblocks+40],r0
	sm	[m_groupblocks+42],r1
	sm	[m_groupblocks+50],r0
	sm	[m_groupblocks+52],r1
	sm	[m_groupblocks+60],r0
	sm	[m_groupblocks+62],r1
	sm	[m_groupblocks+70],r0
	sm	[m_groupblocks+72],r1
	sm	[m_groupblocks+80],r0
	sm	[m_groupblocks+82],r1
	sm	[m_groupblocks+90],r0
	sm	[m_groupblocks+92],r1
	sm	[m_groupblocks+100],r0
	sm	[m_groupblocks+102],r1
	sm	[m_groupblocks+110],r0
	sm	[m_groupblocks+112],r1
	sm	[m_groupblocks+120],r0
	sm	[m_groupblocks+122],r1
	sm	[m_groupblocks+130],r0
	sm	[m_groupblocks+132],r1
	sm	[m_groupblocks+140],r0
	sm	[m_groupblocks+142],r1
	sm	[m_groupblocks+150],r0
	sm	[m_groupblocks+152],r1
	sm	[m_groupblocks+160],r0
	sm	[m_groupblocks+162],r1
	sm	[m_groupblocks+170],r0
	sm	[m_groupblocks+172],r1
	sm	[m_groupblocks+180],r0
	sm	[m_groupblocks+182],r1
	sm	[m_groupblocks+190],r0
	sm	[m_groupblocks+192],r1
	sub	r0
	sm	[m_whlspringx],r0
	sm	[m_whlspringy],r0
	sm	[m_whlspringz],r0
	iwt	r0,#$7d00
	sm	[m_wheelgndoff],r0
	sub	r0
	sm	[m_retailwheelvertical],r0
	lm	r0,[m_retailwheeldefs]
	iwt	r1,#$0030
	bic	r1
	sbk
	ibt	r0,#$18
	add	r9
	ldw	[r0]
	with	r1
	from	r0
	bne	mrwh_wheel_geometry
	nop
	iwt	pc,#mrwh_wheel_offroad&WM
	nop
mrwh_wheel_geometry
	ibt	r7,#$0c
	with	r7
	add	r1
	to	r7
	ldw	[r7]
	sm	[m_retailwheelobject],r7
	link	#4
	iwt	pc,#mretail_shapegroups&WM
	nop
	with	r0
	from	r0
	beq	mrwh_wheel_material
	nop
	link	#4
	iwt	pc,#mretail_wheelgroups&WM
	nop
	with	r1
	from	r0
	beq	mrwh_wheel_material
	nop
	iwt	r0,#$001f
	and	r1
	bne	mrwh_aa06
	nop
	iwt	pc,#mrwh_wheel_offroad&WM
	nop
mrwh_aa06
	iwt	r0,#$0020
	and	r1
	beq	mrwh_wheel_routeflags
	nop
mrwh_wheel_material
	lm	r2,[m_retailwheelobject]
	ibt	r1,#$16
	with	r1
	add	r2
	to	r1
	ldw	[r1]
	iwt	r0,#$0040
	and	r1
	bne	mrwh_wheel_routeflags
	nop
	iwt	r0,#$3800
	to	r1
	and	r1
	beq	mrwh_aa8e
	nop
	iwt	r2,#$00a0
	iwt	r0,#$0800
	cmp	r1
	beq	mrwh_aa52
	nop
	iwt	r2,#$2020
	iwt	r0,#$2000
	cmp	r1
	beq	mrwh_aa52
	nop
	iwt	r2,#$1020
	iwt	r0,#$1000
	cmp	r1
	beq	mrwh_aa52
	nop
	iwt	r2,#$0820
	iwt	r0,#$1800
	cmp	r1
	bne	mrwh_wheel_routeflags
	nop
mrwh_aa52
	ibt	r0,#$2c
	add	r9
	ldw	[r0]
	or	r2
	bra	mrwh_wheel_clearroute
	sbk
mrwh_wheel_routeflags
	lm	r2,[m_retailwheelobject]
	ibt	r1,#$16
	with	r1
	add	r2
	to	r1
	ldw	[r1]
	iwt	r0,#$4000
	and	r1
	bne	mrwh_wheel_clearroute
	nop
	iwt	r1,#$008a
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0040
	and	r1
	beq	mrwh_wheel_clearroute
	nop
	iwt	r2,#$1000
	ibt	r0,#$2c
	add	r9
	ldw	[r0]
	or	r2
	sbk
mrwh_wheel_clearroute
	ibt	r0,#$2c
	add	r8
	ldw	[r0]
	iwt	r2,#$0040
	bic	r2
	bra	mrwh_wheel_ground
	sbk
mrwh_aa8e
	ibt	r0,#$2c
	add	r8
	ldw	[r0]
	iwt	r2,#$0040
	bic	r2
	sbk
mrwh_wheel_offroad
	iwt	r1,#$008a
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r2,#$0040
	iwt	r0,#$0004
	and	r1
	bne	mrwh_wheel_setoffroad
	nop
	iwt	r2,#$00c0
	iwt	r0,#$0020
	and	r1
	bne	mrwh_wheel_setoffroad
	nop
	iwt	r2,#$1040
	iwt	r0,#$0040
	and	r1
	bne	mrwh_wheel_setoffroad
	nop
	iwt	r2,#$0840
	iwt	r0,#$0002
	and	r1
	bne	mrwh_wheel_setoffroad
	nop
	iwt	r2,#$0060
mrwh_wheel_setoffroad
	ibt	r0,#$2c
	add	r9
	ldw	[r0]
	or	r2
	sbk
mrwh_wheel_ground
	ibt	r2,#$20
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	with	r2
	from	r2
	bmi	mrwh_wheel_friction
	nop
	ibt	r0,#$2c
	add	r9
	ldw	[r0]
	iwt	r1,#$0020
	and	r1
	beq	mrwh_ab01
	nop
	iwt	r0,#$000a
	with	r2
	add	r0
	ibt	r0,#$1e
	add	r9
	ldw	[r0]
	ibt	r1,#$22
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	add	r1
	div2
	div2
	div2
	ibt	r1,#$0f
	and	r1
	with	r2
	add	r0
mrwh_ab01
	link	#4
	iwt	pc,#mretail_groundgroup&WM
	nop
	with	r0
	from	r0
	beq	mrwh_wheel_friction
	nop
	iwt	r3,#m_groupblocks&WM
	ibt	r2,#$00
	link	#4
	iwt	pc,#mretail_wheelgroup&WM
	nop
mrwh_wheel_friction
	lm	r0,[m_onroadfriction]
	sm	[m_whlgndfriction],r0
	ibt	r1,#$2c
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$0020
	and	r1
	beq	mrwh_wheel_onground
	nop
	lm	r0,[m_offroadfriction]
	sm	[m_whlgndfriction],r0
	ibt	r0,#$46
	add	r8
	ldw	[r0]
	inc	r0
	sbk
	lm	r0,[m_forceY]
	with	r0
	from	r0
	bne	mrwh_wheel_onground
	nop
	ibt	r0,#$2c
	add	r9
	ldw	[r0]
	iwt	r1,#$0020
	bic	r1
	sbk
mrwh_wheel_onground
	lm	r2,[m_retailwheeldefs]
	lm	r0,[m_wheelgndoff]
	iwt	r1,#$7d00
	cmp	r1
	bne	mrwh_wheel_groundflags
	nop
	iwt	pc,#mrwh_wheel_air&WM
	nop
mrwh_wheel_groundflags
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0100
	bic	r1
	sbk
	iwt	r0,#$0010
	to	r1
	or	r2
	sm	[m_retailwheeldefs],r1
	lm	r2,[m_retailwheeldefs]
	iwt	r0,#$0008
	and	r2
	beq	mrwh_wheel_axes
	nop
	sub	r0
	sm	[m_enginex],r0
	ibt	r0,#$50
	add	r9
	ldw	[r0]
	add	r0
	lm	r6,[m_whlgndfriction]
	fmult
	ibt	r6,#$3c
	with	r6
	add	r8
	to	r6
	ldw	[r6]
	ibt	r1,#$4e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	with	r1
	sub	#2
	bpl	mrwh_abc8
	nop
	with	r6
	from	r6
	beq	mrwh_wheel_axes
	nop
	bmi	mrwh_abc8
	nop
	cmp	r6
	bpl	mrwh_abc8
	nop
	with	r0
	to	r6
	iwt	r0,#$0020
	to	r1
	or	r2
	sm	[m_retailwheeldefs],r1
	ibt	r1,#$56
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$1f40
	add	r1
	sbk
	lm	r0,[m_whlgndfriction]
	div2
	sbk
mrwh_abc8
	with	r6
	add	r6
	sm	[m_enginex],r6
	lms	r0,[m_wmat31]
	lms	r1,[m_wmat32]
	lms	r2,[m_wmat33]
	fmult
	with	r0
	to	r4
	from	r1
	to	r5
	fmult
	from	r2
	to	r6
	fmult
	link	#4
	iwt	pc,#mretail_forceworld&WM
	nop
mrwh_wheel_axes
	ibt	r0,#$00
	romb
	ibt	r0,#$24
	add	r9
	ldw	[r0]
	ibt	r1,#$24
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	sub	r1
	hib
	with	r0
	to	r1
	iwt	r2,#$f060
	iwt	r3,#$0fa0
	lob
	iwt	r14,#sintab&WM
	to	r14
	add	r14
	getb
	swap
	div2
	div2
	with	r0
	from	r0
	bmi	mrwh_ac18
	nop
	cmp	r3
	bmi	mrwh_ac1f
	nop
	with	r3
	to	r0
	bra	mrwh_ac1f
	nop
mrwh_ac18
	cmp	r2
	bpl	mrwh_ac1f
	nop
	with	r2
	to	r0
mrwh_ac1f
	sm	[m_mat13],r0
	with	r1
	to	r0
	lob
	iwt	r14,#costab&WM
	to	r14
	add	r14
	getb
	swap
	with	r0
	from	r0
	bpl	mrwh_ac34
	nop
	not
	inc	r0
mrwh_ac34
	sm	[m_mat33],r0
	ibt	r1,#$2e
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	with	r1
	not
	inc	r1
	ibt	r2,#$30
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	with	r2
	not
	inc	r2
	ibt	r3,#$32
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	with	r3
	not
	inc	r3
	lms	r6,[m_wmat11]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat12]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat13]
	from	r3
	fmult
	rol
	add	r5
	sm	[m_frictdispX],r0
	lms	r6,[m_wmat31]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat32]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat33]
	from	r3
	fmult
	rol
	add	r5
	sm	[m_frictdispZ],r0
	with	r0
	to	r1
	ibt	r0,#$26
	add	r9
	ldw	[r0]
	to	r1
	add	r1
	ibt	r0,#$26
	add	r9
	from	r1
	stw	[r0]
	lm	r1,[m_frictdispX]
	lm	r3,[m_frictdispZ]
	lms	r6,[m_mat33]
	with	r1
	fmult
	lms	r6,[m_mat13]
	from	r3
	add	r3
	fmult
	add	r1
	add	r0
	add	r0
	with	r0
	to	r4
	with	r0
	to	r1
	ibt	r5,#$50
	with	r5
	add	r9
	to	r5
	ldw	[r5]
	ibt	r0,#$3c
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	mrwh_wheel_turngrip
	nop
	lm	r6,[m_retailwheelparams+26]
	from	r5
	add	r5
	fmult
	with	r5
	add	r0
mrwh_wheel_turngrip
	ibt	r1,#$3a
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	with	r1
	from	r1
	beq	mrwh_wheel_frontgrip
	nop
	ibt	r2,#$34
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	with	r2
	from	r2
	bpl	mrwh_ace4
	nop
	with	r1
	from	r1
	bpl	mrwh_wheel_frontgrip
	nop
	bra	mrwh_wheel_brakegrip
	nop
mrwh_ace4
	with	r1
	from	r1
	bpl	mrwh_wheel_brakegrip
	nop
mrwh_wheel_frontgrip
	lm	r2,[m_retailwheeldefs]
	iwt	r0,#$0002
	and	r2
	beq	mrwh_wheel_brakegrip
	nop
	lm	r6,[m_retailwheelparams+28]
	with	r5
	add	r5
	with	r5
	fmult
mrwh_wheel_brakegrip
	lm	r2,[m_retailwheeldefs]
	ibt	r1,#$42
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$000c
	and	r1
	beq	mrwh_wheel_roadgrip
	nop
	iwt	r0,#$0002
	and	r2
	beq	mrwh_ad1f
	nop
	lm	r6,[m_retailwheelparams+34]
	from	r5
	add	r5
	fmult
	with	r5
	bra	mrwh_wheel_roadgrip
	add	r0
mrwh_ad1f
	iwt	r0,#$0001
	and	r2
	beq	mrwh_wheel_roadgrip
	nop
	lm	r6,[m_retailwheelparams+36]
	from	r5
	add	r5
	fmult
	with	r5
	add	r0
mrwh_wheel_roadgrip
	iwt	r0,#$0002
	and	r2
	beq	mrwh_wheel_griplimit
	nop
	iwt	r0,#$4650
	sm	[m_whlgndfriction],r0
mrwh_wheel_griplimit
	lm	r6,[m_whlgndfriction]
	with	r5
	add	r5
	with	r5
	fmult
	with	r0
	from	r4
	bpl	mrwh_ad4c
	nop
	not
	inc	r0
mrwh_ad4c
	sub	r5
	bmi	mrwh_wheel_addside
	nop
	with	r0
	to	r2
	with	r4
	from	r4
	bpl	mrwh_ad5a
	nop
	with	r5
	not
	inc	r5
mrwh_ad5a
	with	r4
	to	r1
	with	r5
	to	r4
	from	r1
	sub	r5
	with	r1
	from	r0
	bpl	mrwh_ad68
	nop
	with	r1
	not
	inc	r1
mrwh_ad68
	lm	r0,[m_retailwheelparams+46]
	cmp	r1
	bpl	mrwh_wheel_addside
	nop
	ibt	r0,#$56
	add	r8
	ldw	[r0]
	add	r1
	sbk
	lm	r2,[m_retailwheeldefs]
	iwt	r0,#$0020
	or	r2
	sbk
mrwh_wheel_addside
	iwt	r5,#$0000
	iwt	r6,#$0000
	link	#4
	iwt	pc,#mretail_forcelocal&WM
	nop
	ibt	r6,#$48
	with	r6
	add	r8
	to	r6
	ldw	[r6]
	with	r6
	from	r6
	beq	mrwh_wheel_resolve
	nop
	lm	r0,[m_frictdispZ]
	add	r0
	to	r6
	fmult
	iwt	r4,#$ff38
	iwt	r5,#$00c8
	with	r6
	from	r6
	bmi	mrwh_adb3
	nop
	with	r6
	cmp	r5
	bmi	mrwh_adbb
	nop
	with	r5
	to	r6
	bra	mrwh_adbb
	nop
mrwh_adb3
	with	r6
	cmp	r4
	bpl	mrwh_adbb
	nop
	with	r4
	to	r6
mrwh_adbb
	ibt	r4,#$00
	ibt	r5,#$00
	link	#4
	iwt	pc,#mretail_forcelocal&WM
	nop
mrwh_wheel_resolve
	link	#4
	iwt	pc,#mretail_resolvelocal&WM
	nop
	lm	r0,[m_forceX]
	lm	r1,[m_forceY]
	lm	r2,[m_forceZ]
	or	r1
	or	r2
	bne	mrwh_wheel_displace
	nop
	iwt	pc,#mrwh_wheel_springs&WM
	nop
mrwh_wheel_displace
	nop
	ibt	r1,#$36
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r2,#$38
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	ibt	r3,#$3a
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	lm	r6,[m_retailwheelparams]
	link	#4
	iwt	pc,#mretail_forcescaleddisp&WM
	nop
	lm	r2,[m_retailwheeldefs]
	iwt	r0,#$0200
	and	r2
	beq	mrwh_ae05
	nop
mrwh_ae05
	ibt	r1,#$3c
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r2,#$3e
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	ibt	r3,#$40
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	ibt	r0,#$5a
	add	r8
	ldw	[r0]
	with	r2
	add	r0
	ibt	r0,#$5c
	add	r8
	ldw	[r0]
	with	r3
	add	r0
	ibt	r0,#$04
	romb
	lm	r0,[m_retailwheelparams+2]
	iwt	r14,#mretail_wheeltorques&WM
	with	r14
	add	r0
	getb
	inc	r14
	getbh
	with	r0
	to	r12
	link	#2
	jmp	r12
	nop
mrwh_wheel_springs
	lm	r3,[m_retailwheelparams+4]
	with	r3
	to	r2
	with	r2
	not
	inc	r2
	lm	r0,[m_whlspringx]
	div2
	div2
	div2
	with	r0
	from	r0
	bmi	mrwh_ae5b
	nop
	cmp	r3
	bmi	mrwh_ae62
	nop
	with	r3
	to	r0
	bra	mrwh_ae62
	nop
mrwh_ae5b
	cmp	r2
	bpl	mrwh_ae62
	nop
	with	r2
	to	r0
mrwh_ae62
	with	r0
	to	r1
	ibt	r0,#$4a
	add	r9
	from	r1
	stw	[r0]
	lm	r0,[m_whlspringz]
	div2
	div2
	div2
	with	r0
	from	r0
	bmi	mrwh_ae82
	nop
	cmp	r3
	bmi	mrwh_ae89
	nop
	with	r3
	to	r0
	bra	mrwh_ae89
	nop
mrwh_ae82
	cmp	r2
	bpl	mrwh_ae89
	nop
	with	r2
	to	r0
mrwh_ae89
	with	r0
	to	r1
	ibt	r0,#$4e
	add	r9
	from	r1
	stw	[r0]
	lm	r0,[m_whlspringy]
	div2
	div2
	div2
	with	r0
	to	r4
	with	r0
	from	r0
	bmi	mrwh_aeab
	nop
	cmp	r3
	bmi	mrwh_aeb2
	nop
	with	r3
	to	r0
	bra	mrwh_aeb2
	nop
mrwh_aeab
	cmp	r2
	bpl	mrwh_aeb2
	nop
	with	r2
	to	r0
mrwh_aeb2
	with	r0
	to	r1
	ibt	r0,#$4c
	add	r9
	from	r1
	stw	[r0]
mrwh_wheel_steer
	ibt	r2,#$46
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	iwt	r0,#$0002
	and	r2
	beq	mrwh_wheel_done
	nop
	ibt	r1,#$24
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r0,#$3a
	add	r8
	ldw	[r0]
	with	r1
	add	r0
	ibt	r0,#$24
	add	r9
	from	r1
	stw	[r0]
mrwh_wheel_done
	lm	r1,[m_retailwheeldefs]
	ibt	r0,#$46
	add	r9
	from	r1
	stw	[r0]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_wheel_air
	ibt	r1,#$00
	ibt	r0,#$4a
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$4c
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$4e
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$44
	add	r8
	ldw	[r0]
	inc	r0
	sbk
	bra	mrwh_wheel_steer
	nop

; US $04:AEFF. r8 = raw car, r9 = raw wheel. Scan groups 1..19, accumulate surface
; and contact bits and restore car +2C from the updated contact word.
mretail_wheelgroups
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$00
	romb
	sub	r0
	sm	[m_groupPtype],r0
	ibt	r0,#$2c
	add	r8
	ldw	[r0]
	sm	[m_retailwheelcontact],r0
	iwt	r3,#m_groupblocks+10&WM
	ibt	r13,#$00
	cache
mrwh_groups_next
	inc	r13
	ibt	r0,#$14
	cmp	r13
	bne	mrwh_groups_force
	nop
	iwt	pc,#mrwh_groups_done&WM
	nop
mrwh_groups_force
	ldw	[r3]
	with	r0
	from	r0
	beq	mrwh_groups_skip
	nop
	link	#4
	iwt	pc,#mretail_wheelgroup&WM
	nop
	lm	r0,[m_onroadfriction]
	sm	[m_whlgndfriction],r0
	bra	mrwh_groups_next
	nop
mrwh_groups_done
	lm	r1,[m_retailwheelcontact]
	ibt	r0,#$2c
	add	r8
	from	r1
	stw	[r0]
	lm	r0,[m_groupPtype]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_groups_skip
	ibt	r0,#$0a
	with	r3
	bra	mrwh_groups_next
	add	r0

; US $04:AF54. r3 = ten-byte group, r8 = raw car, r9 = raw wheel. Accumulate flags,
; nearest distance, rotated normal, spring/damping force and contact bits.
; Mutates accepted group normals in place; r3 advances one record.
mretail_wheelgroup
	ldw	[r3]
	inc	r3
	inc	r3
	with	r1
	from	r0
	bne	mrwh_group_flags
	nop
	iwt	pc,#mrwh_group_skipempty&WM
	nop
mrwh_group_flags
	lm	r2,[m_groupPtype]
	or	r2
	sbk
	from	r1
	hib
	beq	mrwh_group_distance
	nop
	iwt	pc,#mrwh_group_skiphigh&WM
	nop
mrwh_group_distance
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ldw	[r3]
	inc	r3
	inc	r3
	with	r7
	from	r0
	bpl	mrwh_af7f
	nop
	iwt	pc,#mrwh_group_skipdistance&WM
	nop
mrwh_af7f
	lm	r0,[m_wheelgndoff]
	with	r5
	from	r0
	bpl	mrwh_af8b
	nop
	with	r5
	not
	inc	r5
mrwh_af8b
	with	r4
	from	r7
	bpl	mrwh_af93
	nop
	with	r4
	not
	inc	r4
mrwh_af93
	with	r5
	cmp	r4
	bmi	mrwh_group_sentinel
	nop
	sm	[m_wheelgndoff],r7
mrwh_group_sentinel
	iwt	r0,#$7d00
	cmp	r7
	bne	mrwh_group_normal
	nop
	iwt	pc,#mrwh_group_skipdistance&WM
	nop
mrwh_group_normal
	with	r7
	add	r7
	with	r7
	add	r7
	with	r7
	add	r7
	with	r7
	add	r7
	to	r4
	ldw	[r3]
	inc	r3
	inc	r3
	to	r5
	ldw	[r3]
	inc	r3
	inc	r3
	to	r6
	ldw	[r3]
	inc	r3
	inc	r3
	from	r4
	or	r6
	bne	mrwh_group_yaw
	nop
	lm	r0,[m_retailwheelvertical]
	with	r0
	from	r0
	beq	mrwh_afcf
	nop
	iwt	pc,#mrwh_group_return&WM
	nop
mrwh_afcf
	ibt	r0,#$01
	sbk
mrwh_group_yaw
	lm	r0,[m_retailcontactyaw]
	with	r0
	from	r0
	bne	mrwh_afdf
	nop
	iwt	pc,#mrwh_group_store_normal&WM
	nop
mrwh_afdf
	iwt	r1,#$0040
	cmp	r1
	bne	mrwh_aff3
	nop
	with	r6
	to	r0
	not
	inc	r0
	with	r4
	to	r6
	with	r0
	to	r4
	iwt	pc,#mrwh_group_store_normal&WM
	nop
mrwh_aff3
	iwt	r1,#$00c0
	cmp	r1
	bne	mrwh_b006
	nop
	with	r4
	to	r0
	not
	inc	r0
	with	r6
	to	r4
	with	r0
	to	r6
	bra	mrwh_group_store_normal
	nop
mrwh_b006
	iwt	r1,#$0080
	cmp	r1
	bne	mrwh_b017
	nop
	with	r4
	not
	inc	r4
	with	r6
	not
	inc	r6
	bra	mrwh_group_store_normal
	nop
mrwh_b017
	from	r2
	stw	[r10]
	inc	r10
	inc	r10
	from	r3
	stw	[r10]
	inc	r10
	inc	r10
	from	r5
	stw	[r10]
	inc	r10
	inc	r10
	from	r7
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	from	r9
	stw	[r10]
	inc	r10
	inc	r10
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	with	r4
	to	r1
	with	r6
	to	r3
	with	r0
	to	r2
	with	r1
	to	r0
	or	r3
	beq	mrwh_b04c
	nop
	link	#4
	iwt	pc,#mretail_contactrotate&WM
	nop
	with	r1
	add	r1
	with	r1
	add	r1
	with	r3
	add	r3
	with	r3
	add	r3
mrwh_b04c
	dec	r10
	dec	r10
	to	r11
	ldw	[r10]
	with	r3
	to	r4
	with	r1
	to	r6
	dec	r10
	dec	r10
	to	r9
	ldw	[r10]
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	r7
	ldw	[r10]
	dec	r10
	dec	r10
	to	r5
	ldw	[r10]
	dec	r10
	dec	r10
	to	r3
	ldw	[r10]
	dec	r10
	dec	r10
	to	r2
	ldw	[r10]
mrwh_group_store_normal
	with	r3
	sub	#6
	from	r4
	stw	[r3]
	inc	r3
	inc	r3
	from	r5
	stw	[r3]
	inc	r3
	inc	r3
	from	r6
	stw	[r3]
	inc	r3
	inc	r3
	sm	[m_normX],r4
	sm	[m_normY],r5
	sm	[m_normZ],r6
	ibt	r0,#$2e
	add	r9
	ldw	[r0]
	add	r0
	lm	r6,[m_normX]
	fmult
	with	r0
	to	r1
	ibt	r0,#$30
	add	r9
	ldw	[r0]
	add	r0
	lm	r6,[m_normY]
	fmult
	with	r1
	add	r0
	ibt	r0,#$32
	add	r9
	ldw	[r0]
	add	r0
	lm	r6,[m_normZ]
	fmult
	with	r1
	add	r0
	with	r1
	not
	inc	r1
	with	r1
	to	r2
	ibt	r0,#$42
	add	r9
	from	r1
	stw	[r0]
	with	r1
	to	r0
	ibt	r6,#$44
	with	r6
	add	r9
	to	r6
	ldw	[r6]
	lmult
	lob
	swap
	with	r4
	hib
	or	r4
	with	r0
	from	r0
	bpl	mrwh_group_compression
	nop
	div2
	add	r7
	lm	r1,[m_retailwheeldefs]
	iwt	r4,#$0100
	with	r4
	and	r1
	beq	mrwh_group_normalforce
	nop
	bra	mrwh_group_normalforce
	sub	r0
mrwh_group_compression
	iwt	r1,#$07d0
	cmp	r1
	bpl	mrwh_group_normalforce
	nop
	add	r7
mrwh_group_normalforce
	with	r0
	to	r1
	lm	r6,[m_normY]
	with	r1
	to	r0
	fmult
	with	r0
	to	r5
	with	r6
	from	r6
	bne	mrwh_group_wall
	nop
	with	r0
	from	r2
	bpl	mrwh_b0fa
	nop
	sub	r0
mrwh_b0fa
	add	r0
	add	r0
	add	r7
	with	r0
	to	r1
	iwt	r6,#$1000
	add	r0
	fmult
	with	r1
	add	r0
	with	r6
	from	r0
	bpl	mrwh_b10e
	nop
	with	r6
	not
	inc	r6
mrwh_b10e
	iwt	r0,#$0064
	cmp	r6
	bpl	mrwh_group_wall
	nop
	ibt	r0,#$3c
	add	r9
	ldw	[r0]
	with	r0
	from	r0
	bpl	mrwh_b12a
	nop
	lm	r0,[m_retailwheelcontact]
	iwt	r6,#$0100
	or	r6
	bra	mrwh_group_wall
	sbk
mrwh_b12a
	lm	r0,[m_retailwheelcontact]
	iwt	r6,#$0200
	or	r6
	sbk
mrwh_group_wall
	lm	r0,[m_normX]
	lm	r6,[m_normZ]
	or	r6
	beq	mrwh_group_addforce
	nop
	lm	r0,[m_retailwheelcontact]
	iwt	r6,#$0400
	or	r6
	sbk
mrwh_group_addforce
	lm	r6,[m_normX]
	with	r1
	to	r0
	fmult
	with	r0
	to	r4
	lm	r6,[m_normZ]
	with	r1
	to	r0
	fmult
	with	r0
	to	r6
	link	#4
	iwt	pc,#mretail_forceworld&WM
	nop
	lm	r6,[m_normX]
	from	r7
	fmult
	lm	r1,[m_whlspringx]
	add	r1
	sbk
	lm	r6,[m_normY]
	from	r7
	fmult
	with	r0
	to	r2
	lm	r1,[m_whlspringy]
	add	r1
	sbk
	lm	r6,[m_normZ]
	from	r7
	fmult
	lm	r1,[m_whlspringz]
	add	r1
	sbk
mrwh_group_return
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_group_skiphigh
	ibt	r0,#$08
	with	r3
	add	r0
	with	r11
	to	pc
	nop
mrwh_group_skipdistance
	ibt	r0,#$06
	with	r3
	add	r0
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_group_skipempty
	ibt	r0,#$08
	with	r3
	add	r0
	with	r11
	to	pc
	nop

; US $04:B1A1. r8 = raw car. Set pending flags on car/wheels. The supplied
; m_retailwheelreset selects setup/pose or clear-route-state behavior.
; Callable return replaces the native fall-through into full car dispatch.
mretail_resetwheels
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r1,#$0004
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	or	r1
	sbk
	ibt	r0,#$3e
	add	r8
	ldw	[r0]
mrwh_reset_next
	with	r2
	from	r0
	beq	mrwh_reset_mode
	nop
	ibt	r0,#$1c
	add	r2
	ldw	[r0]
	or	r1
	sbk
	ibt	r0,#$34
	add	r2
	ldw	[r0]
	bra	mrwh_reset_next
	nop
mrwh_reset_mode
	lm	r0,[m_retailwheelreset]
	with	r0
	from	r0
	beq	mrwh_reset_route
	nop
	link	#4
	iwt	pc,#mretail_setupwheels&WM
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_reset_route
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r1,#$0002
	bic	r1
	sbk
	ibt	r1,#$00
	iwt	r0,#$0092
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$09
	romb
; Native continues into full car dispatch here; this entry is callable.
	mpop	pc
	nop

; US $04:B9AC. r8 = raw car. Build/transposed matrix from negated Z/Y/X, save
; car world position and refresh raw wheel poses. r8/r10 preserved.
; Existing bank-1 matrix routines are shared through one return bridge.
mretail_setupwheels
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$26
	add	r8
	ldw	[r0]
	not
	inc	r0
	sms	[m_rotx],r0
	ibt	r0,#$24
	add	r8
	ldw	[r0]
	not
	inc	r0
	sms	[m_roty],r0
	ibt	r0,#$28
	add	r8
	ldw	[r0]
	not
	inc	r0
	sms	[m_rotz],r0
	iwt	r9,#m_wmat11&WM
	link	#4
	iwt	pc,#mretail_wheelmatrix&WM
	nop
	iwt	r9,#m_wmat11&WM
	link	#4
	iwt	pc,#mretail_wheeltranspose&WM
	nop
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
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
	link	#4
	iwt	pc,#mretail_wheelpose&WM
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:BD20. r8 = raw car. Walk contact-cache +0E links; apply type/mask/cooldown
; gates, reverse geometry or cached horizontal contact force, displacement
; and torque; collect impact history across the supplied substep selector.
; m_retaildynphase and m_mapnumber must be supplied by the caller.
mretail_bodycontacts
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	sub	r0
	sm	[m_retailcontactyaw],r0
	sm	[m_retailwheelcontact],r0
	sm	[m_whlD],r0
	sm	[m_t1],r0
	lm	r0,[m_retaildynphase]
	with	r0
	from	r0
	bne	mrwh_body_head
	nop
	ibt	r1,#$00
	iwt	r0,#$0094
	add	r8
	from	r1
	stw	[r0]
mrwh_body_head
	with	r8
	to	r9
	ibt	r0,#$18
	add	r8
	ldw	[r0]
	with	r1
	from	r0
	bne	mrwh_body_type
	nop
	iwt	pc,#mrwh_body_empty&WM
	nop
mrwh_body_type
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r2,#$0040
	and	r2
	beq	mrwh_body_next
	nop
	iwt	pc,#mrwh_body_done&WM
	nop
mrwh_body_next
	ibt	r7,#$0c
	with	r7
	add	r1
	to	r7
	ldw	[r7]
	sm	[m_retailwheelobject],r7
	ibt	r2,#$1a
	with	r2
	add	r7
	to	r2
	ldw	[r2]
	iwt	r0,#$0002
	and	r2
	beq	mrwh_bd7f
	nop
	iwt	pc,#mrwh_body_advance&WM
	nop
mrwh_bd7f
	ibt	r2,#$16
	with	r2
	add	r7
	to	r2
	ldw	[r2]
	iwt	r0,#$0020
	and	r2
	beq	mrwh_bd90
	nop
	iwt	pc,#mrwh_body_advance&WM
	nop
mrwh_bd90
	iwt	r0,#$0002
	and	r2
	beq	mrwh_body_force
	nop
	iwt	r3,#$0014
	lm	r0,[m_mapnumber]
	add	r0
	with	r3
	sub	r0
	bpl	mrwh_bda6
	nop
	ibt	r3,#$00
mrwh_bda6
	ibt	r0,#$7c
	add	r8
	from	r3
	stw	[r0]
	ibt	r0,#$5e
	add	r8
	ldw	[r0]
	ibt	r3,#$5e
	with	r3
	add	r7
	to	r3
	ldw	[r3]
	add	r3
	beq	mrwh_body_force
	nop
	iwt	pc,#mrwh_body_advance&WM
	nop
mrwh_body_force
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_forceclear&WM
	nop
	iwt	r0,#$0002
	and	r2
	beq	mrwh_body_mode
	nop
	ibt	r0,#$64
	add	r8
	ldw	[r0]
	iwt	r3,#$0010
	and	r3
	beq	mrwh_bde7
	nop
	ibt	r0,#$64
	add	r7
	ldw	[r0]
	iwt	r3,#$0003
	and	r3
	beq	mrwh_body_mode
	nop
mrwh_bde7
	ibt	r0,#$2c
	add	r8
	ldw	[r0]
	iwt	r3,#$0004
	or	r3
	sbk
mrwh_body_mode
	ibt	r0,#$16
	add	r8
	ldw	[r0]
	iwt	r2,#$0010
	and	r2
	beq	mrwh_body_geometry
	nop
	iwt	pc,#mrwh_body_cached&WM
	nop
mrwh_body_geometry
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	from	r7
	stw	[r10]
	inc	r10
	inc	r10
	from	r9
	stw	[r10]
	inc	r10
	inc	r10
	with	r9
	to	r0
	with	r7
	to	r9
	with	r0
	to	r7
	link	#4
	iwt	pc,#mretail_shapegroups&WM
	nop
	dec	r10
	dec	r10
	to	r9
	ldw	[r10]
	dec	r10
	dec	r10
	to	r7
	ldw	[r10]
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	with	r0
	from	r0
	bne	mrwh_body_findgroup
	nop
	iwt	pc,#mrwh_body_pop&WM
	nop
mrwh_body_findgroup
	link	#4
	iwt	pc,#mretail_findgroup&WM
	nop
	with	r0
	from	r0
	bne	mrwh_body_response
	nop
	iwt	pc,#mrwh_body_pop&WM
	nop
mrwh_body_response
	link	#4
	iwt	pc,#mretail_applygroups&WM
	nop
	lm	r0,[m_forceX]
	not
	inc	r0
	add	r0
	sbk
	lm	r0,[m_forceY]
	ibt	r0,#$00
	sbk
	lm	r0,[m_forceZ]
	not
	inc	r0
	add	r0
	sbk
	ibt	r1,#$00
	ibt	r2,#$00
	ibt	r3,#$00
	link	#4
	iwt	pc,#mretail_forcedisp&WM
	nop
	lms	r1,[m_bigx]
	with	r1
	div2
	with	r1
	div2
	ibt	r2,#$00
	lms	r3,[m_bigz]
	with	r3
	div2
	with	r3
	div2
	lms	r6,[m_wmat11]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat12]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat13]
	from	r3
	fmult
	rol
	add	r5
	sms	[m_bigx],r0
	lms	r6,[m_wmat21]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat22]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat23]
	from	r3
	fmult
	rol
	add	r5
	sms	[m_bigy],r0
	lms	r6,[m_wmat31]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_wmat32]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_wmat33]
	from	r3
	fmult
	rol
	add	r5
	sms	[m_bigz],r0
	lms	r1,[m_bigx]
	lms	r2,[m_bigy]
	lms	r3,[m_bigz]
	link	#4
	iwt	pc,#mretail_torque&WM
	nop
	iwt	pc,#mrwh_body_pop&WM
	nop
mrwh_body_cached
	link	#4
	iwt	pc,#mretail_contactcache&WM
	nop
	sub	r0
	sm	[m_retailcontactyaw],r0
	iwt	r3,#m_groupblocks&WM
	lm	r2,[m_retailwheelobject]
	link	#4
	iwt	pc,#mretail_groupforce&WM
	nop
	with	r0
	from	r0
	beq	mrwh_body_cachedforce
	nop
	lm	r1,[m_t1]
	with	r1
	from	r1
	bmi	mrwh_body_cachedforce
	nop
	iwt	r0,#$0094
	add	r8
	ldw	[r0]
	add	r1
	sbk
mrwh_body_cachedforce
	lm	r0,[m_forceX]
	add	r0
	sbk
	with	r0
	to	r1
	lm	r0,[m_forceZ]
	add	r0
	sbk
	lm	r1,[m_forceX]
	lm	r0,[m_DISPx]
	add	r1
	sbk
	lm	r1,[m_forceZ]
	lm	r0,[m_DISPz]
	add	r1
	sbk
	sub	r0
	sm	[m_forceY],r0
	sub	r0
	sm	[m_forceY],r0
mrwh_body_pop
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
mrwh_body_advance
	ibt	r0,#$0e
	add	r1
	ldw	[r0]
	with	r1
	from	r0
	beq	mrwh_body_done
	nop
	iwt	pc,#mrwh_body_next&WM
	nop
mrwh_body_done
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_body_empty
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r1,#$0040
	bic	r1
	sbk
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:CA99. r7/r8 = raw cars. Relative closing/distance gate for broad-phase pairs.
; r1-r5/r7/r8/r10 restored; r0 = 0/1, other math/workspace scratch.
mretail_rawapproach
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	from	r2
	stw	[r10]
	inc	r10
	inc	r10
	from	r3
	stw	[r10]
	inc	r10
	inc	r10
	from	r4
	stw	[r10]
	inc	r10
	inc	r10
	from	r5
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$1e
	with	r1
	add	r7
	to	r1
	ldw	[r1]
	ibt	r0,#$1e
	add	r8
	ldw	[r0]
	with	r1
	sub	r0
	sm	[m_x1],r1
	ibt	r3,#$22
	with	r3
	add	r7
	to	r3
	ldw	[r3]
	ibt	r0,#$22
	add	r8
	ldw	[r0]
	with	r3
	sub	r0
	sm	[m_z1],r3
	ibt	r2,#$00
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	from	r7
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_normalise&WM
	nop
	dec	r10
	dec	r10
	to	r7
	ldw	[r10]
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	lm	r0,[m_x1]
	add	r0
	with	r1
	to	r6
	fmult
	with	r0
	to	r5
	lm	r0,[m_z1]
	add	r0
	with	r3
	to	r6
	fmult
	add	r5
	sm	[m_x1],r0
	ibt	r0,#$2e
	add	r7
	ldw	[r0]
	ibt	r4,#$2e
	with	r4
	add	r8
	to	r4
	ldw	[r4]
	sub	r4
	div2
	with	r1
	to	r6
	fmult
	with	r0
	to	r5
	ibt	r0,#$32
	add	r7
	ldw	[r0]
	ibt	r4,#$32
	with	r4
	add	r8
	to	r4
	ldw	[r4]
	sub	r4
	div2
	with	r3
	to	r6
	fmult
	add	r5
	not
	inc	r0
	sm	[m_x2],r0
	ibt	r0,#$0c
	add	r7
	ldw	[r0]
	ibt	r1,#$0c
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	add	r1
	iwt	r1,#$0294
	sub	r1
	bpl	mrwh_approach_margin
	nop
	sub	r0
mrwh_approach_margin
	lm	r1,[m_x2]
	add	r1
	lm	r1,[m_x1]
	cmp	r1
	bmi	mrwh_approach_apart
	nop
	sub	r0
	dec	r10
	dec	r10
	to	r5
	ldw	[r10]
	dec	r10
	dec	r10
	to	r4
	ldw	[r10]
	dec	r10
	dec	r10
	to	r3
	ldw	[r10]
	dec	r10
	dec	r10
	to	r2
	ldw	[r10]
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwh_approach_apart
	ibt	r0,#$01
	dec	r10
	dec	r10
	to	r5
	ldw	[r10]
	dec	r10
	dec	r10
	to	r4
	ldw	[r10]
	dec	r10
	dec	r10
	to	r3
	ldw	[r10]
	dec	r10
	dec	r10
	to	r2
	ldw	[r10]
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:9BC6. Even byte selector 0/2/4/6/8/10 from parameter word 1.
mretail_wheeltorques
	dw	mretail_torque&WM,mretail_torque2&WM,mretail_torque1&WM
	dw	mretail_torquehalf&WM,mretail_torquequarter&WM,mretail_torqueextra&WM

; Copy all 25 definition words into the shared wheel context. r8 = raw car,
; definition ROM bank already selected; r8/r9 and banks preserved.
mretail_preparewheelparams
	iwt	r2,#m_retailwheelparams&WM
	iwt	r0,#mload_retailcarparms&WM
	bra	mrwh_farcall
	nop
mretail_wheelmatrix
	iwt	r0,#mcrotmatzxy16&WM
	bra	mrwh_farcall
	nop
mretail_wheeltranspose
	iwt	r0,#mtransmat16&WM
mrwh_farcall
	mpush	r11
	iwt	r11,#mretail_wheelreturn1&WM
	iwt	r13,#mcrotmatzxy16>>16
	from	r0
	ljmp	r13
	nop
mretail_wheelreturn4
	mpop	r11
	move	pc,r11
	nop

; US $04:B611-$B661. r8 = raw car; matrix/world and the copied 25-word
; wheel context must be prepared. Run wheel pose/dynamics, height history,
; optional boost torque, body contacts, velocity alignment and impact damage.
; r8/r10 restored; r9 and other math registers/flags scratch. The parameter
; pointer for the reconstructed impact entry is supplied by this adapter.
; Native continues with hit-heading correction and motion limits; this
; callable stage returns after impact handling. No live dispatch is changed.
mretail_collisionstep
	mpush	r11
	link	#4
	iwt	pc,#mretail_wheelpose&WM
	nop
	link	#4
	iwt	pc,#mretail_wheels&WM
	nop
	link	#4
	iwt	pc,#mretail_heighthistory&WM
	nop
	ibt	r2,#$42
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0400
	and	r2
	beq	mrwh_step_body
	nop
	lm	r2,[m_retailwheelparams+48]
	with	r2
	from	r2
	beq	mrwh_step_body
	nop
	ibt	r0,#$4e
	add	r8
	ldw	[r0]
	ibt	r1,#$02
	cmp	r1
	bpl	mrwh_step_body
	nop
	ibt	r0,#$26
	add	r8
	ldw	[r0]
	iwt	r1,#$eaab
	cmp	r1
	bmi	mrwh_step_body
	nop
	lm	r0,[m_TORQUEy]
	sub	r2
	sbk
mrwh_step_body
	link	#4
	iwt	pc,#mretail_bodycontacts&WM
	nop
	link	#4
	iwt	pc,#mretail_velalignraw&WM
	nop
	iwt	r9,#m_retailwheelparams&WM
	link	#4
	iwt	pc,#mretail_impactdamage&WM
	nop
mrwh_step_done
	mpop	pc
	nop

; US $04:BCBA-$BD1F, raw-layout velocity alignment. Normalize velocity and
; form the full-product forward dot; absolute ground speed below ten uses
; $7FFF. Store raw car +6C. r8/r10 restored; math registers/flags scratch.
mretail_velalignraw
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$2e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r2,#$30
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	ibt	r3,#$32
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	link	#4
	iwt	pc,#mretail_normalise&WM
	nop
	lms	r6,[m_wmat31]
	from	r1
	lmult
	with	r4
	to	r7
	lms	r6,[m_wmat32]
	from	r2
	to	r5
	lmult
	with	r7
	add	r4
	adc	r5
	lms	r6,[m_wmat33]
	from	r3
	to	r5
	lmult
	with	r7
	add	r4
	adc	r5
	with	r7
	add	r7
	rol
	with	r0
	to	r1
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bpl	mrwh_align_speed
	nop
	not
	inc	r0
mrwh_align_speed
	iwt	r2,#$000a
	cmp	r2
	bpl	mrwh_align_store
	nop
	iwt	r1,#$7fff
mrwh_align_store
	ibt	r0,#$6c
	add	r8
	from	r1
	stw	[r0]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrwheel_end
