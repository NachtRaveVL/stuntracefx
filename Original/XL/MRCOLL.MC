; Retail collision-response stages. Execute in bank 4.
; Geometry generation must fill the shared twenty-entry, ten-byte group
; buffer before response; raw bodies/cars do not use the early CAR layout.
; This module shares the dynamics workspace and is not reentrant.

mrcoll_begin

; US $04:9301. r1 = cache with velocity/position words at +04..+0A;
; r7 = other raw body, r9 = raw body.
; Build the horizontal contact normal, relative closing speed and mass-weighted
; synthetic group zero. Uses the inherited normalizer/divider through bridges.
; r1/r8/r9 restored; scratch r0/r2-r7/r12-r14 and shared workspace.
mretail_contactcache
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	with	r1
	to	r5
	ibt	r1,#$1e
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r0,#$08
	add	r5
	ldw	[r0]
	with	r1
	sub	r0
	sm	[m_facePX],r1
	ibt	r2,#$00
	sm	[m_facePY],r2
	ibt	r3,#$22
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	ibt	r0,#$0a
	add	r5
	ldw	[r0]
	with	r3
	sub	r0
	sm	[m_facePZ],r3
	from	r7
	stw	[r10]
	inc	r10
	inc	r10
	from	r9
	stw	[r10]
	inc	r10
	inc	r10
	from	r5
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_normalise&WM
	nop
	sms	[m_x1],r1
	sms	[m_y1],r2
	sms	[m_z1],r3
	dec	r10
	dec	r10
	to	r5
	ldw	[r10]
	dec	r10
	dec	r10
	to	r9
	ldw	[r10]
	dec	r10
	dec	r10
	to	r7
	ldw	[r10]
	ibt	r0,#$04
	add	r5
	ldw	[r0]
	ibt	r1,#$2e
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	sub	r1
	add	r0
	lm	r6,[m_x1]
	fmult
	with	r0
	to	r8
	ibt	r0,#$06
	add	r5
	ldw	[r0]
	ibt	r1,#$32
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	sub	r1
	add	r0
	lm	r6,[m_z1]
	fmult
	with	r8
	add	r0
	with	r8
	from	r8
	bmi	mrcoll_cacheclosing
	nop
	iwt	r0,#$04b0
	cmp	r8
	bmi	mrcoll_cacheclosing
	nop
	with	r0
	to	r8
mrcoll_cacheclosing
	sm	[m_t1],r8
	from	r7
	stw	[r10]
	inc	r10
	inc	r10
	from	r9
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$2a
	add	r7
	ldw	[r0]
	ibt	r6,#$2a
	with	r6
	add	r9
	to	r6
	ldw	[r6]
	with	r6
	add	r0
	ibt	r4,#$00
	link	#4
	iwt	pc,#mretail_contactdivide&WM
	nop
	to	r6
	from	r4
	lsr
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	r9
	ldw	[r10]
	dec	r10
	dec	r10
	to	r7
	ldw	[r10]
	with	r8
	to	r0
	add	r0
	fmult
	with	r0
	to	r8
	lm	r1,[m_x1]
	ibt	r2,#$00
	lm	r3,[m_z1]
	with	r8
	from	r8
	bmi	mrcoll_cacheflag
	sub	r0
	ibt	r0,#$01
mrcoll_cacheflag
	sm	[m_groupblocks],r0
	sm	[m_groupblocks+2],r8
	sm	[m_groupblocks+4],r1
	sm	[m_groupblocks+6],r2
	sm	[m_groupblocks+8],r3
	dec	r10
	dec	r10
	to	r8
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

; US $04:941C. Apply groups 1..19, accumulating eligible material bits and world force.
; ROM bank becomes zero; contact yaw is supplied in m_retailcontactyaw.
; r13 is the group counter; raw body pointers r8/r9 are preserved.
mretail_applygroups
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$00
	romb
	sub	r0
	sm	[m_groupPtype],r0
	iwt	r3,#m_groupblocks+10&WM
	ibt	r13,#$00
mrcoll_groupsloop
	inc	r13
	ibt	r0,#$14
	cmp	r13
	bne	mrcoll_groupsnext
	nop
	iwt	pc,#mrcoll_groupsdone&WM
	nop
mrcoll_groupsnext
	link	#4
	iwt	pc,#mretail_groupforce&WM
	nop
	iwt	pc,#mrcoll_groupsloop&WM
	nop
mrcoll_groupsdone
	lm	r0,[m_groupPtype]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:944C. r3 = ten-byte group. Skip empty/high-byte flags, negative distance or
; $7D00 sentinel. Rotate valid normals, retain penetration and add clamped
; world force. r3 advances ten bytes; r8/r9 preserved.
mretail_groupforce
	ldw	[r3]
	inc	r3
	inc	r3
	with	r0
	from	r0
	bne	mrcoll_groupflags
	nop
	iwt	pc,#mrcoll_skipempty&WM
	nop
mrcoll_groupflags
	to	r7
	hib
	beq	mrcoll_groupactive
	nop
	iwt	pc,#mrcoll_skiphighflags&WM
	nop
mrcoll_groupactive
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	with	r0
	to	r1
	ldw	[r3]
	inc	r3
	inc	r3
	with	r7
	from	r0
	bpl	mrcoll_groupdistance
	nop
	iwt	pc,#mrcoll_skipdistance&WM
	nop
mrcoll_groupdistance
	iwt	r0,#$7d00
	cmp	r7
	bne	mrcoll_groupaccept
	nop
	iwt	pc,#mrcoll_skipdistance&WM
	nop
mrcoll_groupaccept
	lm	r0,[m_groupPtype]
	or	r1
	sbk
	with	r7
	add	r7
	sm	[m_whlD],r7
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
	lm	r0,[m_retailcontactyaw]
	with	r0
	from	r0
	bne	mrcoll_groupyaw
	nop
	iwt	pc,#mrcoll_normalready&WM
	nop
mrcoll_groupyaw
	iwt	r1,#$0040
	cmp	r1
	bne	mrcoll_yawleftquarter
	nop
	with	r6
	to	r0
	not
	inc	r0
	with	r4
	to	r6
	with	r0
	to	r4
	iwt	pc,#mrcoll_normalready&WM
	nop
mrcoll_yawleftquarter
	iwt	r1,#$00c0
	cmp	r1
	bne	mrcoll_yawhalf
	nop
	with	r4
	to	r0
	not
	inc	r0
	with	r6
	to	r4
	with	r0
	to	r6
	bra	mrcoll_normalready
	nop
mrcoll_yawhalf
	iwt	r1,#$0080
	cmp	r1
	bne	mrcoll_yawgeneral
	nop
	with	r4
	not
	inc	r4
	with	r6
	not
	inc	r6
	bra	mrcoll_normalready
	nop
mrcoll_yawgeneral
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
	beq	mrcoll_yawdone
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
mrcoll_yawdone
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
mrcoll_normalready
	sm	[m_normX],r4
	sm	[m_normY],r5
	sm	[m_normZ],r6
	with	r7
	to	r1
	lm	r6,[m_normX]
	from	r1
	fmult
	with	r0
	to	r4
	with	r7
	to	r5
	lm	r6,[m_normY]
	from	r5
	fmult
	with	r0
	to	r5
	lm	r6,[m_normZ]
	from	r7
	fmult
	with	r0
	to	r6
	link	#4
	iwt	pc,#mretail_forceworld&WM
	nop
	ibt	r0,#$01
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrcoll_skiphighflags
	ibt	r0,#$08
	with	r3
	add	r0
	with	r11
	to	pc
	nop
mrcoll_skipdistance
	ibt	r0,#$06
	with	r3
	add	r0
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrcoll_skipempty
	ibt	r0,#$08
	with	r3
	add	r0
	with	r11
	to	pc
	nop

; US $04:957C. Find nonzero flags and a valid distance in slots 1..19.
; Return r0 = 0/1; this scan does not reject high-byte flags.
; r3/r4/r13 and flags scratch; no group or car writes.
mretail_findgroup
	cache
	iwt	r3,#m_groupblocks+10&WM
	ibt	r13,#$00
mrcoll_findnext
	inc	r13
	ibt	r0,#$14
	cmp	r13
	beq	mrcoll_findnone
	nop
	ldw	[r3]
	inc	r3
	inc	r3
	with	r0
	from	r0
	beq	mrcoll_findskipempty
	nop
	to	r4
	ldw	[r3]
	inc	r3
	inc	r3
	iwt	r0,#$7d00
	cmp	r4
	beq	mrcoll_findskipdistance
	nop
	with	r4
	from	r4
	bpl	mrcoll_findhit
	nop
	bra	mrcoll_findskipdistance
	nop
mrcoll_findskipempty
	ibt	r0,#$08
	with	r3
	add	r0
	bra	mrcoll_findnext
	nop
mrcoll_findskipdistance
	ibt	r0,#$06
	with	r3
	add	r0
	bra	mrcoll_findnext
	nop
mrcoll_findnone
	ibt	r0,#$00
	with	r11
	to	pc
	nop
mrcoll_findhit
	ibt	r0,#$01
	with	r11
	to	pc
	nop

; US $04:95BE. r8 = raw body, r1 = 6 for position plus angle, otherwise position only.
; Integrate raw +2E..+38 into +1E..+28 with native per-mode DIV2 rates.
; r0/r2/r3/r5/flags scratch; other registers and banks preserved.
mretail_integrate
	iwt	r5,#$002e
	with	r5
	add	r8
	iwt	r2,#$001e
	with	r2
	add	r8
	ibt	r3,#$1c
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	iwt	r0,#$0008
	and	r3
	beq	mrcoll_integrateordinary
	nop
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	div2
	div2
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	div2
	div2
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	div2
	div2
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	from	r1
	sub	#6
	bne	mrcoll_integratereturn
	nop
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
mrcoll_integratereturn
	bra	mrcoll_integratedone
	nop
mrcoll_integrateordinary
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	div2
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	div2
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	div2
	div2
	div2
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	from	r1
	sub	#6
	bne	mrcoll_integratedone
	nop
	ldw	[r5]
	inc	r5
	inc	r5
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
	ldw	[r5]
	inc	r5
	inc	r5
	to	r3
	ldw	[r2]
	add	r3
	stw	[r2]
	inc	r2
	inc	r2
mrcoll_integratedone
	with	r11
	to	pc
	nop

; US $04:9683. r2 = ground distance. Initialize synthetic group zero: sign flag,
; distance and vertical normal $8100. r0/r2/flags scratch.
mretail_groundgroup
	sub	r0
	with	r2
	from	r2
	bmi	mrcoll_groundflag
	nop
	ibt	r0,#$01
mrcoll_groundflag
	sm	[m_groupblocks],r0
	sm	[m_groupblocks+2],r2
	ibt	r2,#$00
	sm	[m_groupblocks+4],r2
	sm	[m_groupblocks+8],r2
	iwt	r2,#$8100
	sm	[m_groupblocks+6],r2
	with	r11
	to	pc
	nop

; US $04:9BD2. r9 = raw body. Apply nonzero world force to position and velocity,
; retaining native half position steps and 2/8/2 velocity multipliers.
; r0/r1/r4-r6/flags scratch; other registers and banks preserved.
mretail_applycontact
	lm	r4,[m_forceX]
	lm	r5,[m_forceY]
	lm	r6,[m_forceZ]
	with	r4
	to	r0
	or	r5
	or	r6
	beq	mrcoll_contactdone
	nop
	ibt	r1,#$1e
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	from	r4
	div2
	add	r1
	sbk
	ibt	r1,#$20
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	from	r5
	div2
	add	r1
	sbk
	ibt	r1,#$22
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	from	r6
	div2
	add	r1
	sbk
	ibt	r1,#$2e
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	with	r4
	to	r0
	add	r0
	add	r1
	sbk
	ibt	r1,#$30
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	with	r5
	to	r0
	add	r0
	add	r0
	add	r0
	add	r1
	sbk
	ibt	r1,#$32
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	with	r6
	to	r0
	add	r0
	add	r1
	sbk
mrcoll_contactdone
	with	r11
	to	pc
	nop

; US $04:BB17. r8 = raw car, r9 = copied parameter block. Update impact history,
; damage thresholds and flags; eligible player impacts impulse nearby raw
; cars through m_avoidcarhead. m_retaildynphase selects the native substep.
; m_playercar/m_avoidcarhead must refer to retail-layout cars for this call.
; r8 and caller parameter pointer r9 preserved; math registers/flags scratch.
mretail_impactdamage
	mpush	r9
	ibt	r1,#$64
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0008
	and	r1
	beq	mrcoll_impactflags
	nop
	iwt	pc,#mrcoll_impactdone&WM
	nop
mrcoll_impactflags
	ibt	r1,#$40
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$2201
	and	r1
	beq	mrcoll_impactroute
	nop
	iwt	pc,#mrcoll_impactsuppressed&WM
	nop
mrcoll_impactroute
	iwt	r1,#$008a
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0200
	and	r1
	beq	mrcoll_impactvertical
	nop
	iwt	pc,#mrcoll_impactsuppressed&WM
	nop
mrcoll_impactvertical
	lm	r0,[m_DISPy]
	div2
	div2
	with	r0
	to	r1
	ibt	r0,#$62
	add	r8
	from	r1
	stw	[r0]
	with	r1
	to	r0
	with	r0
	from	r0
	bpl	mrcoll_impactcontacts
	nop
	not
	inc	r0
mrcoll_impactcontacts
	ibt	r1,#$44
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r2,#$0002
	with	r1
	cmp	r2
	bpl	mrcoll_impactvelocity
	nop
	div2
	div2
mrcoll_impactvelocity
	with	r0
	to	r1
	ibt	r0,#$30
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bpl	mrcoll_impactx
	nop
	ibt	r1,#$00
mrcoll_impactx
	lm	r0,[m_DISPx]
	with	r0
	from	r0
	bpl	mrcoll_impactz
	nop
	not
	inc	r0
mrcoll_impactz
	div2
	div2
	div2
	with	r1
	add	r0
	lm	r0,[m_DISPz]
	with	r0
	from	r0
	bpl	mrcoll_impactscale
	nop
	not
	inc	r0
mrcoll_impactscale
	div2
	div2
	div2
	with	r1
	add	r0
	iwt	r6,#38
	with	r6
	add	r9
	to	r6
	ldw	[r6]
	with	r1
	fmult
	ibt	r0,#$18
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	mrcoll_impactsum
	nop
	with	r1
	div2
mrcoll_impactsum
	lm	r2,[m_retaildynphase]
	with	r2
	from	r2
	bne	mrcoll_impactadd
	sub	r0
	sm	[m_retailimpact],r0
mrcoll_impactadd
	lm	r0,[m_retailimpact]
	add	r1
	sbk
	with	r0
	to	r1
	with	r2
	from	r2
	bne	mrcoll_impactevent
	nop
	iwt	pc,#mrcoll_impactdone&WM
	nop
mrcoll_impactevent
	with	r1
	div2
	iwt	r2,#$0010
	with	r1
	cmp	r2
	bpl	mrcoll_impactlimit
	nop
	iwt	pc,#mrcoll_impactdone&WM
	nop
mrcoll_impactlimit
	iwt	r2,#$0060
	with	r1
	cmp	r2
	bmi	mrcoll_damageadd
	nop
	with	r2
	to	r1
mrcoll_damageadd
	iwt	r0,#$0082
	add	r8
	ldw	[r0]
	add	r1
	sbk
	iwt	r2,#$0018
	with	r1
	cmp	r2
	bmi	mrcoll_impactsmall
	nop
	ibt	r0,#$70
	add	r8
	ldw	[r0]
	iwt	r2,#$0080
	or	r2
	sbk
	iwt	r2,#$0038
	with	r1
	cmp	r2
	bmi	mrcoll_impactmedium
	nop
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r2,#$0020
	or	r2
	bra	mrcoll_impactowner
	sbk
mrcoll_impactsmall
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r2,#$0080
	or	r2
	bra	mrcoll_impactowner
	sbk
mrcoll_impactmedium
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r2,#$0040
	or	r2
	sbk
mrcoll_impactowner
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r2,#$0020
	and	r2
	beq	mrcoll_damagecheck
	nop
	lm	r0,[m_playercar]
	cmp	r8
	bne	mrcoll_damagecheck
	nop
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_peerimpulse&WM
	nop
	dec	r10
	dec	r10
	to	r11
	ldw	[r10]
mrcoll_damagecheck
	iwt	r0,#$0082
	add	r8
	ldw	[r0]
	iwt	r2,#$0200
	cmp	r2
	bmi	mrcoll_impactdone
	nop
	ibt	r2,#$40
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0001
	or	r2
	sbk
mrcoll_impactdone
	mpop	r9
	with	r11
	to	pc
	nop
mrcoll_impactsuppressed
	ibt	r1,#$00
	ibt	r0,#$62
	add	r8
	from	r1
	stw	[r0]
	mpop	r9
	with	r11
	to	pc
	nop

; US $04:BF51. STOP service using m_dynvar1 raw-car pointer and m_dynvar2 strength.
; Recover boost toward $0180. Native ROM/RAM bank reset is retained.
mretail_recoverboost
	sub	r0
	romb
	ramb
	lm	r8,[m_dynvar1]
	lm	r6,[m_dynvar2]
	ibt	r1,#$6a
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r2,#$0180
	from	r2
	add	r2
	fmult
	add	r1
	cmp	r2
	bmi	mrcoll_boostdone
	nop
	with	r2
	to	r0
mrcoll_boostdone
	sbk
	stop
	nop

; US $04:BF75. STOP service with the same argument words; reduce damage toward zero.
; Arithmetic and signed lower-bound test match the native service.
mretail_repairdamage
	sub	r0
	romb
	ramb
	lm	r8,[m_dynvar1]
	lm	r6,[m_dynvar2]
	iwt	r1,#$0082
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r2,#$0200
	from	r2
	add	r2
	fmult
	from	r1
	sub	r0
	bpl	mrcoll_repairdone
	nop
	sub	r0
mrcoll_repairdone
	sbk
	stop
	nop

; US $04:BF98. r8 = impact owner. Walk m_avoidcarhead through raw car +74 links,
; skip self, apply distance-weighted horizontal/roll impulses and cooldown.
; r8 and software stack preserved; other math registers/flags scratch.
; The caller supplies a valid, terminating retail-layout list.
mretail_peerimpulse
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r6,#$1e
	with	r6
	add	r8
	to	r6
	ldw	[r6]
	ibt	r5,#$20
	with	r5
	add	r8
	to	r5
	ldw	[r5]
	ibt	r7,#$22
	with	r7
	add	r8
	to	r7
	ldw	[r7]
	iwt	r2,#$07d0
	lm	r0,[m_avoidcarhead]
mrcoll_peernext
	with	r9
	from	r0
	bne	mrcoll_peerself
	nop
	iwt	pc,#mrcoll_peerdone&WM
	nop
mrcoll_peerself
	cmp	r8
	bne	mrcoll_peerdistance
	nop
	iwt	pc,#mrcoll_peeradvance&WM
	nop
mrcoll_peerdistance
	ibt	r0,#$1e
	add	r9
	ldw	[r0]
	sub	r6
	with	r0
	to	r1
	div2
	bpl	mrcoll_peery
	nop
	not
	inc	r0
mrcoll_peery
	with	r0
	to	r4
	ibt	r0,#$20
	add	r9
	ldw	[r0]
	sub	r5
	div2
	bpl	mrcoll_peerz
	nop
	not
	inc	r0
mrcoll_peerz
	with	r4
	add	r0
	ibt	r0,#$22
	add	r9
	ldw	[r0]
	sub	r7
	with	r0
	to	r3
	div2
	bpl	mrcoll_peerthreshold
	nop
	not
	inc	r0
mrcoll_peerthreshold
	add	r4
	sub	r2
	bpl	mrcoll_peeradvance
	nop
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	from	r6
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
	from	r2
	stw	[r10]
	inc	r10
	inc	r10
	with	r0
	from	r0
	bpl	mrcoll_peerstrength
	nop
	not
	inc	r0
mrcoll_peerstrength
	add	r0
	stw	[r10]
	inc	r10
	inc	r10
	from	r9
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r2,#$00
	link	#4
	iwt	pc,#mretail_normalise&WM
	nop
	dec	r10
	dec	r10
	to	r9
	ldw	[r10]
	dec	r10
	dec	r10
	to	r6
	ldw	[r10]
	from	r1
	fmult
	ibt	r4,#$2e
	with	r4
	add	r9
	to	r4
	ldw	[r4]
	add	r4
	sbk
	from	r3
	fmult
	ibt	r4,#$32
	with	r4
	add	r9
	to	r4
	ldw	[r4]
	add	r4
	sbk
	ibt	r0,#$34
	add	r9
	ldw	[r0]
	with	r0
	to	r1
	iwt	r0,#$c180
	with	r1
	from	r1
	bmi	mrcoll_peerroll
	nop
	iwt	r0,#$3e80
mrcoll_peerroll
	with	r6
	add	r6
	with	r6
	add	r6
	fmult
	add	r1
	sbk
	iwt	r4,#$001e
	ibt	r0,#$7c
	add	r9
	from	r4
	stw	[r0]
	dec	r10
	dec	r10
	to	r2
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
	to	r6
	ldw	[r10]
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
mrcoll_peeradvance
	ibt	r0,#$74
	add	r9
	ldw	[r0]
	iwt	pc,#mrcoll_peernext&WM
	nop
mrcoll_peerdone
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; Rotation preserves the scan counter r13 across the bank switch.
mretail_contactrotate
	mpush	r11
	mpush	r13
	iwt	r11,#mretail_rotreturn1&WM
	iwt	r13,#mrotate_xz8>>16
	iwt	r0,#mrotate_xz8&WM
	from	r0
	ljmp	r13
	nop
mretail_rotreturn4
	mpop	r13
	mpop	r11
	move	pc,r11
	nop

; Preserve r0 dividend-high on entry. The contact caller consumes r4;
; the bridge's r0/r12/r13 and flags are scratch, including the remainder.
mretail_contactdivide
	mpush	r11
	iwt	r11,#mretail_divreturn1&WM
	iwt	r13,#mdivu3216>>16
	iwt	r12,#mdivu3216&WM
	from	r12
	ljmp	r13
	nop
mretail_divreturn4
	mpop	r11
	move	pc,r11
	nop
mrcoll_end
