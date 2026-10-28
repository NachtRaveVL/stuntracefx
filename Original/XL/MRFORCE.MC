; Retail force resolution and post-integration motion stages.
; Execute in this bank; ordinary r11 returns remain in the caller's PBR.
; Raw retail car records are separate from the surviving early CAR layout.
; The shared force/matrix/position workspace is not reentrant.
; Local/world accumulators are distinct; no allocator or frame hook added.


mrforce_begin

; US $04:96A7. Clear world and local force vectors. r0/flags scratch.
mretail_forceclear
	sub	r0
	sm	[m_forceX],r0
	sm	[m_forceY],r0
	sm	[m_forceZ],r0
	sm	[m_retaillocalX],r0
	sm	[m_retaillocalY],r0
	sm	[m_retaillocalZ],r0
	with	r11
	to	pc
	nop

; US $04:96C3. Add r4/r5/r6 to world forces, clamping each input to +/-5000.
; r1/r2 preserved using the GSU stack; r0/r4-r6/flags scratch.
mretail_forceworld
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	from	r2
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r1,#$ec78
	iwt	r2,#$1388
	with	r4
	from	r4
	bmi	mrforce_worldnegx
	nop
	with	r4
	cmp	r2
	bmi	mrforce_worldlimity
	nop
	with	r2
	to	r4
	bra	mrforce_worldlimity
	nop
mrforce_worldnegx
	with	r4
	cmp	r1
	bpl	mrforce_worldlimity
	nop
	with	r1
	to	r4
mrforce_worldlimity
	with	r5
	from	r5
	bmi	mrforce_worldnegy
	nop
	with	r5
	cmp	r2
	bmi	mrforce_worldlimitz
	nop
	with	r2
	to	r5
	bra	mrforce_worldlimitz
	nop
mrforce_worldnegy
	with	r5
	cmp	r1
	bpl	mrforce_worldlimitz
	nop
	with	r1
	to	r5
mrforce_worldlimitz
	with	r6
	from	r6
	bmi	mrforce_worldnegz
	nop
	with	r6
	cmp	r2
	bmi	mrforce_worldadd
	nop
	with	r2
	to	r6
	bra	mrforce_worldadd
	nop
mrforce_worldnegz
	with	r6
	cmp	r1
	bpl	mrforce_worldadd
	nop
	with	r1
	to	r6
mrforce_worldadd
	dec	r10
	dec	r10
	to	r2
	ldw	[r10]
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	lm	r0,[m_forceX]
	add	r4
	sm	[m_forceX],r0
	lm	r0,[m_forceY]
	add	r5
	sm	[m_forceY],r0
	lm	r0,[m_forceZ]
	add	r6
	sm	[m_forceZ],r0
	with	r11
	to	pc
	nop

; US $04:973F. Add r4/r5/r6 to local forces with the same native clamps.
; r1/r2 preserved using the GSU stack; r0/r4-r6/flags scratch.
mretail_forcelocal
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	from	r2
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r1,#$ec78
	iwt	r2,#$1388
	with	r4
	from	r4
	bmi	mrforce_localnegx
	nop
	with	r4
	cmp	r2
	bmi	mrforce_locallimity
	nop
	with	r2
	to	r4
	bra	mrforce_locallimity
	nop
mrforce_localnegx
	with	r4
	cmp	r1
	bpl	mrforce_locallimity
	nop
	with	r1
	to	r4
mrforce_locallimity
	with	r5
	from	r5
	bmi	mrforce_localnegy
	nop
	with	r5
	cmp	r2
	bmi	mrforce_locallimitz
	nop
	with	r2
	to	r5
	bra	mrforce_locallimitz
	nop
mrforce_localnegy
	with	r5
	cmp	r1
	bpl	mrforce_locallimitz
	nop
	with	r1
	to	r5
mrforce_locallimitz
	with	r6
	from	r6
	bmi	mrforce_localnegz
	nop
	with	r6
	cmp	r2
	bmi	mrforce_localadd
	nop
	with	r2
	to	r6
	bra	mrforce_localadd
	nop
mrforce_localnegz
	with	r6
	cmp	r1
	bpl	mrforce_localadd
	nop
	with	r1
	to	r6
mrforce_localadd
	dec	r10
	dec	r10
	to	r2
	ldw	[r10]
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	lm	r0,[m_retaillocalX]
	add	r4
	sm	[m_retaillocalX],r0
	lm	r0,[m_retaillocalY]
	add	r5
	sm	[m_retaillocalY],r0
	lm	r0,[m_retaillocalZ]
	add	r6
	sm	[m_retaillocalZ],r0
	with	r11
	to	pc
	nop

; US $04:97BB. Rotate the accumulated local vector into world forces. r2 returns
; the rotated Y contribution before adding the old world Y force.
mretail_resolvelocal
	lm	r1,[m_retaillocalX]
	lm	r2,[m_retaillocalY]
	lm	r3,[m_retaillocalZ]
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
	lm	r4,[m_forceX]
	add	r4
	sbk
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
	lm	r4,[m_forceZ]
	add	r4
	sbk
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
	with	r0
	to	r2
	lm	r4,[m_forceY]
	add	r4
	sbk
	with	r11
	to	pc
	nop

; US $04:9820. Rotate r1/r2/r3, then normalize and apply the world force.
mretail_forcedisprot
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
	sm	[m_t1],r0
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
	sm	[m_t2],r0
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
	sm	[m_t3],r0
	lm	r1,[m_t1]
	lm	r2,[m_t2]
	lm	r3,[m_t3]
	bra	mretail_forcedisp
	nop

; US $04:987D. Multiply the application vector r1/r2/r3 by low-word scale r6,
; take component magnitudes and add weighted displacement. Zero vector
; uses $7FFF on every axis, as does the native routine.
mretail_forcescaleddisp
	from	r11
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
	from	r1
	or	r2
	or	r3
	bne	mrforce_scaledvector
	nop
	iwt	r1,#$7fff
	with	r1
	to	r2
	with	r1
	to	r3
	bra	mrforce_dispapply
	nop
mrforce_scaledvector
	from	r1
	lmult
	with	r4
	to	r1
	from	r2
	lmult
	with	r4
	to	r2
	from	r3
	lmult
	with	r4
	to	r3
	bra	mrforce_dispmagnitudes
	nop

; US $04:98AB. Normalize r1/r2/r3, take component magnitudes and add weighted
; displacement. r8/r9/link preserved; r0-r7/r12/r13/flags scratch.
mretail_forcedisp
	from	r11
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
	from	r1
	or	r2
	or	r3
	bne	mrforce_normalizevector
	nop
	iwt	r1,#$7fff
	with	r1
	to	r2
	with	r1
	to	r3
	bra	mrforce_dispapply
	nop
mrforce_normalizevector
	link	#4
	iwt	pc,#mretail_normalise&WM
	nop
mrforce_dispmagnitudes
	with	r1
	from	r1
	bpl	mrforce_absy
	nop
	with	r1
	not
	inc	r1
mrforce_absy
	with	r2
	from	r2
	bpl	mrforce_absz
	nop
	with	r2
	not
	inc	r2
mrforce_absz
	with	r3
	from	r3
	bpl	mrforce_dispapply
	nop
	with	r3
	not
	inc	r3
mrforce_dispapply
	lm	r6,[m_forceX]
	with	r6
	div2
	with	r1
	fmult
	lm	r0,[m_DISPx]
	add	r1
	sm	[m_DISPx],r0
	lm	r6,[m_forceY]
	with	r6
	div2
	with	r2
	fmult
	lm	r0,[m_DISPy]
	add	r2
	sm	[m_DISPy],r0
	lm	r6,[m_forceZ]
	with	r6
	div2
	with	r3
	fmult
	lm	r0,[m_DISPz]
	add	r3
	sm	[m_DISPz],r0
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
	to	pc
	ldw	[r10]
	nop

; US $04:9927. Rotate the force-application vector, then calculate torque.
mretail_torquerot
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
	sm	[m_t1],r0
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
	sm	[m_t2],r0
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
	sm	[m_t3],r0
	lm	r1,[m_t1]
	lm	r2,[m_t2]
	lm	r3,[m_t3]
	iwt	pc,#mretail_torque&WM
	nop

; US $04:9985. Retain the native no-op normalization wrapper before torque.
mretail_torquenorm
	from	r11
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
	to	r11
	ldw	[r10]
	iwt	pc,#mretail_torque&WM
	nop

; US $04:99A1. Torque with world force doubled before rotation.
mretail_torque2
	from	r11
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
	lm	r0,[m_forceX]
	add	r0
	sms	[m_mat11],r0
	lm	r0,[m_forceY]
	add	r0
	sms	[m_mat22],r0
	lm	r0,[m_forceZ]
	add	r0
	sms	[m_mat33],r0
	iwt	pc,#mrforce_torquework&WM
	nop

; US $04:99C9. Torque with the unscaled world force.
mretail_torque1
	from	r11
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
	lm	r0,[m_forceX]
	sms	[m_mat11],r0
	lm	r0,[m_forceY]
	sms	[m_mat22],r0
	lm	r0,[m_forceZ]
	sms	[m_mat33],r0
	iwt	pc,#mrforce_torquework&WM
	nop

; US $04:99EE. Torque with world force DIV2 before rotation.
mretail_torquehalf
	from	r11
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
	lm	r0,[m_forceX]
	div2
	sms	[m_mat11],r0
	lm	r0,[m_forceY]
	div2
	sms	[m_mat22],r0
	lm	r0,[m_forceZ]
	div2
	sms	[m_mat33],r0
	iwt	pc,#mrforce_torquework&WM
	nop

; US $04:9A19. Torque with world force DIV2 twice before rotation.
mretail_torquequarter
	from	r11
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
	lm	r0,[m_forceX]
	div2
	div2
	sms	[m_mat11],r0
	lm	r0,[m_forceY]
	div2
	div2
	sms	[m_mat22],r0
	lm	r0,[m_forceZ]
	div2
	div2
	sms	[m_mat33],r0
	iwt	pc,#mrforce_torquework&WM
	nop

; US $04:9A4A. Base torque followed by an additional eightfold Y contribution.
mretail_torqueextra
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_torque&WM
	nop
	lm	r0,[m_x1]
	lm	r4,[m_TORQUEy]
	add	r0
	add	r0
	add	r0
	add	r4
	sbk
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:9A65. Scale each world force by signed r6, retaining product bits 8..23.
mretail_forcescale
	lm	r1,[m_forceX]
	lm	r2,[m_forceY]
	lm	r3,[m_forceZ]
	from	r1
	lmult
	lob
	swap
	with	r4
	hib
	to	r1
	or	r4
	from	r2
	lmult
	lob
	swap
	with	r4
	hib
	to	r2
	or	r4
	from	r3
	lmult
	lob
	swap
	with	r4
	hib
	to	r3
	or	r4
	sm	[m_forceX],r1
	sm	[m_forceY],r2
	sm	[m_forceZ],r3
	with	r11
	to	pc
	nop

; US $04:9A9B. Torque with world force multiplied by four, a wrapped application
; vector multiplied by sixteen, rotated force and full-product cross
; differences. r8/r9/link preserved; matrix and vector work words scratch.
mretail_torque
	from	r11
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
	lm	r0,[m_forceX]
	add	r0
	add	r0
	sms	[m_mat11],r0
	lm	r0,[m_forceY]
	add	r0
	add	r0
	sms	[m_mat22],r0
	lm	r0,[m_forceZ]
	add	r0
	add	r0
	sms	[m_mat33],r0
mrforce_torquework
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
	sub	r0
	sms	[m_mat12],r0
	sm	[m_t1],r1
	sm	[m_t2],r2
	sm	[m_t3],r3
	lms	r1,[m_mat11]
	lms	r2,[m_mat22]
	lms	r3,[m_mat33]
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
	sms	[m_mat11],r0
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
	sms	[m_mat22],r0
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
	sms	[m_mat33],r0
	lm	r1,[m_t1]
	lm	r2,[m_t2]
	lm	r3,[m_t3]
	lms	r6,[m_mat22]
	from	r3
	lmult
	with	r4
	to	r7
	lms	r6,[m_mat33]
	from	r2
	to	r5
	lmult
	with	r7
	sub	r4
	sbc	r5
	with	r7
	add	r7
	rol
	sms	[m_x1],r0
	lms	r6,[m_mat33]
	from	r1
	lmult
	with	r4
	to	r7
	lms	r6,[m_mat11]
	from	r3
	to	r5
	lmult
	with	r7
	sub	r4
	sbc	r5
	with	r7
	add	r7
	rol
	sms	[m_y1],r0
	lms	r6,[m_mat11]
	from	r2
	lmult
	with	r4
	to	r7
	lms	r6,[m_mat22]
	from	r1
	to	r5
	lmult
	with	r7
	sub	r4
	sbc	r5
	with	r7
	add	r7
	rol
	sms	[m_z1],r0
	lm	r0,[m_x1]
	lm	r4,[m_TORQUEy]
	add	r0
	add	r0
	add	r4
	sbk
	lm	r0,[m_z1]
	lm	r5,[m_TORQUEz]
	add	r0
	add	r0
	add	r5
	sbk
	lm	r0,[m_y1]
	lm	r6,[m_TORQUEx]
	add	r0
	add	r0
	add	r6
	sbk
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
	to	pc
	ldw	[r10]
	nop

; US $04:B57B. Optional control bit $0800 impulse: local (0,0,600), resolve and
; apply displacement. Existing force vectors must be initialized.
; r2 controls/r8/r9 preserved; other math registers and flags scratch.
mretail_forceimpulse
	mpush	r11
	iwt	r0,#$0800
	and	r2
	beq	mrforce_impulsedone
	nop
	from	r2
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r4,#$0000
	iwt	r5,#$0000
	iwt	r6,#$0258
	link	#4
	iwt	pc,#mretail_forcelocal&WM
	nop
	link	#4
	iwt	pc,#mretail_resolvelocal&WM
	nop
	iwt	r1,#$0000
	iwt	r2,#$0000
	iwt	r3,#$0000
	iwt	r6,#$7fff
	link	#4
	iwt	pc,#mretail_forcescaleddisp&WM
	nop
	dec	r10
	dec	r10
	to	r2
	ldw	[r10]
mrforce_impulsedone
	mpop	r11
	move	pc,r11
	nop

; US $04:B827. Raw retail car r8: settle unpowered low velocities, calculate ground
; speed from the world matrix, damp airborne tilt and update roll/revs
; history. r8-r14/RAM bank preserved; ROM bank becomes this code bank.
; r0-r6 and flags are scratch.
mretail_motiontail
	ibt	r2,#$64
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0008
	and	r2
	beq	mrforce_settlecontrols
	nop
	iwt	pc,#mrforce_groundspeed&WM
	nop
mrforce_settlecontrols
	ibt	r2,#$42
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0430
	and	r2
	beq	mrforce_settlemask
	nop
	iwt	pc,#mrforce_settletorquex&WM
	nop
mrforce_settlemask
	ibt	r2,#$2c
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0400
	and	r2
	beq	mrforce_settlex
	nop
	iwt	pc,#mrforce_settletorquex&WM
	nop
mrforce_settlex
	ibt	r0,#$2e
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	mrforce_settlenegx
	nop
	iwt	r2,#$00c8
	cmp	r2
	bpl	mrforce_settlez
	nop
	ibt	r0,#$00
	bra	mrforce_settlez
	nop
mrforce_settlenegx
	iwt	r2,#$ff38
	cmp	r2
	bmi	mrforce_settlez
	nop
	ibt	r0,#$00
mrforce_settlez
	sbk
	ibt	r0,#$32
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	mrforce_settlenegz
	nop
	iwt	r2,#$00c8
	cmp	r2
	bpl	mrforce_settley
	nop
	ibt	r0,#$00
	bra	mrforce_settley
	nop
mrforce_settlenegz
	iwt	r2,#$ff38
	cmp	r2
	bmi	mrforce_settley
	nop
	ibt	r0,#$00
mrforce_settley
	sbk
	ibt	r0,#$30
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	mrforce_settlenegy
	nop
	iwt	r2,#$0032
	cmp	r2
	bpl	mrforce_settleyend
	nop
	ibt	r0,#$00
	bra	mrforce_settleyend
	nop
mrforce_settlenegy
	iwt	r2,#$ffce
	cmp	r2
	bmi	mrforce_settleyend
	nop
	ibt	r0,#$00
mrforce_settleyend
	sbk
mrforce_settletorquex
	iwt	r1,#$0034
	with	r1
	add	r8
	ldw	[r1]
	inc	r1
	inc	r1
	with	r0
	from	r0
	bmi	mrforce_settlenegtorquex
	nop
	iwt	r2,#$0040
	cmp	r2
	bpl	mrforce_settletorquey
	nop
	ibt	r0,#$00
	bra	mrforce_settletorquey
	nop
mrforce_settlenegtorquex
	iwt	r2,#$ffc0
	cmp	r2
	bmi	mrforce_settletorquey
	nop
	ibt	r0,#$00
mrforce_settletorquey
	sbk
	ldw	[r1]
	inc	r1
	inc	r1
	with	r0
	from	r0
	bmi	mrforce_settlenegtorquey
	nop
	iwt	r2,#$0040
	cmp	r2
	bpl	mrforce_settletorquez
	nop
	ibt	r0,#$00
	bra	mrforce_settletorquez
	nop
mrforce_settlenegtorquey
	iwt	r2,#$ffc0
	cmp	r2
	bmi	mrforce_settletorquez
	nop
	ibt	r0,#$00
mrforce_settletorquez
	sbk
	ldw	[r1]
	with	r0
	from	r0
	bmi	mrforce_settlenegtorquez
	nop
	iwt	r2,#$0040
	cmp	r2
	bpl	mrforce_settletorqueend
	nop
	ibt	r0,#$00
	bra	mrforce_settletorqueend
	nop
mrforce_settlenegtorquez
	iwt	r2,#$ffc0
	cmp	r2
	bmi	mrforce_settletorqueend
	nop
	ibt	r0,#$00
mrforce_settletorqueend
	sbk
mrforce_groundspeed
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
	div2
	div2
	div2
	with	r0
	to	r1
	ibt	r0,#$4a
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#mrforce_begin>>16
	romb
	ibt	r2,#$50
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	ibt	r0,#$44
	add	r8
	ldw	[r0]
	ibt	r1,#$04
	cmp	r1
	bmi	mrforce_smoothrevs
	nop
	with	r2
	add	r2
	ibt	r1,#$28
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	with	r1
	to	r0
	div2
	div2
	with	r1
	sub	r0
	ibt	r0,#$28
	add	r8
	from	r1
	stw	[r0]
mrforce_smoothrevs
	ibt	r1,#$52
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	from	r2
	sub	r1
	div2
	to	r1
	add	r1
	ibt	r0,#$52
	add	r8
	from	r1
	stw	[r0]
	move	pc,r11
	nop

; US $04:BC7B. Raw retail car r8: conditional height-history reset and downward
; comparison update. r0/r1/flags scratch; other registers/banks preserved.
mretail_heighthistory
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$0100
	and	r1
	bne	mrforce_compareheight
	nop
	ibt	r1,#$20
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r0,#$60
	add	r8
	from	r1
	stw	[r0]
mrforce_compareheight
	ibt	r1,#$20
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r0,#$60
	add	r8
	ldw	[r0]
	cmp	r1
	bpl	mrforce_heightdone
	nop
	sub	r0
	sbk
mrforce_heightdone
	with	r11
	to	pc
	nop

; Use the inherited bank-1 normalizer through a real bank switch. The
; bridge preserves the three normalized components; r0/r13/flags scratch.
; The outer displacement routine already saves car, parameter and link state.
mretail_normalise
	mpush	r11
	iwt	r11,#mretail_normalreturn1&WM
	iwt	r13,#mnormalise16>>16
	iwt	r0,#mnormalise16&WM
	from	r0
	ljmp	r13
	nop
mretail_normalreturn4
	mpop	r11
	move	pc,r11
	nop
mrforce_end
