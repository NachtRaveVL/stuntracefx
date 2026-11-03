; Retail raw object callbacks, route logic and frame dispatch, bank 6.
; RAM bank zero; initialized heaps, aligned raw records, terminating lists
; and valid bound route/shape streams are required. The shared 86-byte
; polygon context, geometry cache and point buffer are not reentrant.
; Object +0A callbacks name entries in this bank. The object-frame task
; runs one or two substeps, releases unmarked objects, ranks cars and
; updates nearby-car audio state. CPU task selection and shape ownership
; remain separate; the early active dispatcher is unchanged.
; Preserve each native ROM bank selection. Cached generic-body response
; can retain an asset bank; its rotation reads the original offsets there.
; No heap, stack, rendering buffer or RAM allocation is reduced.

mrupdate_begin

; US $04:8AD0.
mretail_spawnmarker
	iwt	r10,#m_stack&WM
	iwt	r4,#$0028
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	with	r1
	from	r1
	beq	mrrt_8b2c
	nop
	lm	r2,[m_dynvar1]
	ibt	r0,#$1e
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_dynvar2]
	ibt	r0,#$20
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_dynvar3]
	ibt	r0,#$22
	add	r1
	from	r2
	stw	[r0]
	ibt	r2,#$16
	with	r2
	add	r1
	to	r2
	ldw	[r2]
	iwt	r0,#$00a0
	to	r2
	or	r2
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$ffff
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
	sm	[m_dynvar1],r1
	with	r1
	to	r8
	link	#4
	iwt	pc,#mretail_findrawroute&WM
	nop
	link	#4
	iwt	pc,#mrrt_cca4&WM
	nop
	sm	[m_dynvar2],r0
	stop
	nop
mrrt_8b2c
	sub	r0
	sm	[m_dynvar1],r0
	stop
	nop

; US $04:8B33.
mretail_spawnsolid
	iwt	r10,#m_stack&WM
	iwt	r4,#$0034
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8b62
	nop
	iwt	r2,#$0040
	ibt	r0,#$2a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0008
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0426
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
mrrt_8b62
	stop
	nop

; US $04:8B64.
mretail_spawnfragment
	iwt	r10,#m_stack&WM
	iwt	r4,#$002a
	lm	r3,[m_retailheap1]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8bab
	nop
	lm	r0,[m_retailobjectcount]
	inc	r0
	sbk
	lm	r2,[m_retailarg5]
	with	r2
	from	r2
	beq	mrrt_8b8f
	nop
	ibt	r0,#$26
	add	r2
	from	r1
	stw	[r0]
mrrt_8b8f
	sm	[m_retailarg5],r1
	ibt	r2,#$16
	with	r2
	add	r1
	to	r2
	ldw	[r2]
	iwt	r0,#$0181
	to	r2
	or	r2
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0422
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
mrrt_8bab
	stop
	nop
; US $04:8BAD, raw scene-object constructor.
mretail_spawn8bad
	iwt	r10,#m_stack&WM
	iwt	r4,#$002a
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8be0
	nop
	sm	[m_retailarg6],r1
	ibt	r2,#$16
	with	r2
	add	r1
	to	r2
	ldw	[r2]
	iwt	r0,#$0020
	to	r2
	or	r2
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$ffff
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
mrrt_8be0
	stop
	nop
; US $04:8BE2, raw scene-object constructor.
mretail_spawn8be2
	iwt	r10,#m_stack&WM
	sub	r0
	sm	[m_dynvar1],r0
	stop
	nop
	iwt	r4,#$002a
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8c08
	nop
	iwt	r2,#$0001
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
mrrt_8c08
	stop
	nop
; US $04:8C0A, raw scene-object constructor.
mretail_spawn8c0a
	iwt	r10,#m_stack&WM
	iwt	r4,#$0034
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8c39
	nop
	iwt	r2,#$0040
	ibt	r0,#$2a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0008
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0424
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
mrrt_8c39
	stop
	nop
; US $04:8C3B, raw scene-object constructor.
mretail_spawn8c3b
	iwt	r10,#m_stack&WM
	iwt	r4,#$0034
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8c6a
	nop
	iwt	r2,#$0040
	ibt	r0,#$2a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0020
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0426
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
mrrt_8c6a
	stop
	nop
; US $04:8C6C, raw scene-object constructor.
mretail_spawn8c6c
	iwt	r10,#m_stack&WM
	iwt	r4,#$0034
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8c93
	nop
	iwt	r2,#$0020
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$042e
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
mrrt_8c93
	stop
	nop
; US $04:8C95, raw scene-object constructor.
mretail_spawn8c95
	iwt	r10,#m_stack&WM
	iwt	r4,#$0034
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mr6_call_mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	beq	mrrt_8cc4
	nop
	iwt	r2,#$0000
	ibt	r0,#$2a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0020
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$042d
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
mrrt_8cc4
	stop
	nop

; US $04:8FCA.
; GSU task. m_mariokey enables work; zero returns immediately. Decrement
; the reset counter, scan contacts when it reaches zero, then run callbacks.
; Raw +1C bit 8 selects two substeps; bit 4 retains an object for this frame
; and is cleared after its callback. CPU strategies may mark static objects.
mretail_objectframe
	iwt	r10,#m_stack&WM
	sub	r0
	romb
	ramb
	lm	r0,[m_mariokey]
	with	r0
	from	r0
	bne	mrrt_8fdf
	nop
	iwt	pc,#mrrt_9078&WM
	nop
mrrt_8fdf
	lm	r0,[m_retailwheelreset]
	with	r0
	from	r0
	beq	mrrt_8fe9
	dec	r0
	sbk
mrrt_8fe9
	lm	r0,[m_dynframe]
	inc	r0
	sbk
	iwt	r0,#$ffff
	sm	[m_indynamics],r0
	lm	r0,[m_retailwheelreset]
	with	r0
	from	r0
	bne	mrrt_9004
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_scancontacts&WM
	nop
mrrt_9004
	lm	r0,[m_objects]
mrrt_9008
	with	r8
	from	r0
	beq	mrrt_9069
	nop
	ibt	r0,#$0a
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_903d
	nop
	with	r0
	to	r12
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r1,#$0008
	and	r1
	beq	mrrt_9034
	nop
	from	r12
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$00
	sm	[m_retaildynphase],r0
	link	#2
	jmp	r12
	nop
	dec	r10
	dec	r10
	to	r12
	ldw	[r10]
mrrt_9034
	ibt	r0,#$01
	sm	[m_retaildynphase],r0
	link	#2
	jmp	r12
	nop
mrrt_903d
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	with	r0
	to	r2
	iwt	r1,#$0004
	and	r1
	bne	mrrt_905e
	nop
	ibt	r0,#$04
	add	r8
	ldw	[r0]
	stw	[r10]
	inc	r10
	inc	r10
	with	r8
	to	r1
	link	#4
	iwt	pc,#mr6_call_mretail_releaseobject&WM
	nop
	dec	r10
	dec	r10
	ldw	[r10]
	bra	mrrt_9008
	nop
mrrt_905e
	from	r2
	bic	r1
	sbk
	ibt	r0,#$04
	add	r8
	ldw	[r0]
	bra	mrrt_9008
	nop
mrrt_9069
	link	#4
	iwt	pc,#mretail_rankrawcars&WM
	nop
	link	#4
	iwt	pc,#mretail_nearrawcar&WM
	nop
	sub	r0
	sm	[m_indynamics],r0

; US $04:9078.
mrrt_9078
	stop
	nop

; US $04:907A.
mretail_fallingbody
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	with	r8
	to	r9
	ibt	r1,#$30
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$0078
	to	r1
	add	r1
	ibt	r0,#$30
	add	r9
	from	r1
	stw	[r0]
	ibt	r1,#$03
	link	#4
	iwt	pc,#mr6_call_mretail_integrate&WM
	nop
	link	#4
	iwt	pc,#mretail_stepbody&WM
	nop
	lm	r0,[m_retailwheelcontact]
	with	r0
	from	r0
	beq	mrrt_90df
	nop
	bmi	mrrt_90b9
	nop
	ibt	r1,#$30
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	with	r1
	sub	r0
	ibt	r0,#$30
	add	r9
	from	r1
	stw	[r0]
mrrt_90b9
	ibt	r0,#$2e
	add	r9
	ldw	[r0]
	with	r0
	to	r1
	div2
	div2
	div2
	with	r1
	sub	r0
	ibt	r0,#$2e
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$32
	add	r9
	ldw	[r0]
	with	r0
	to	r1
	div2
	div2
	div2
	with	r1
	sub	r0
	ibt	r0,#$32
	add	r9
	from	r1
	stw	[r0]
mrrt_90df
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:90E8.
mretail_holdcontacts
	with	r8
	to	r8
	ibt	r1,#$18
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	with	r1
	from	r1
	beq	mrrt_9107
	nop
	iwt	r2,#$0002
mrrt_90f8
	ibt	r0,#$10
	add	r1
	ldw	[r0]
	or	r2
	sbk
	ibt	r0,#$0e
	add	r1
	ldw	[r0]
	with	r1
	from	r0
	bne	mrrt_90f8
	nop
mrrt_9107
	with	r11
	to	pc
	nop

; US $04:910A.
mretail_dragbody
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	with	r8
	to	r9
	ibt	r0,#$18
	add	r9
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_912d
	nop
	ibt	r1,#$30
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$0078
	to	r1
	add	r1
	ibt	r0,#$30
	add	r9
	from	r1
	stw	[r0]
mrrt_912d
	ibt	r1,#$03
	link	#4
	iwt	pc,#mr6_call_mretail_integrate&WM
	nop
	link	#4
	iwt	pc,#mretail_stepbody&WM
	nop
	lm	r0,[m_retailwheelcontact]
	with	r0
	from	r0
	beq	mrrt_9164
	nop
	ibt	r0,#$2e
	add	r9
	ldw	[r0]
	with	r0
	to	r1
	div2
	div2
	with	r1
	sub	r0
	ibt	r0,#$2e
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$32
	add	r9
	ldw	[r0]
	with	r0
	to	r1
	div2
	div2
	with	r1
	sub	r0
	ibt	r0,#$32
	add	r9
	from	r1
	stw	[r0]
mrrt_9164
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:916D.
mretail_contactbody
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	with	r8
	to	r9
	link	#4
	iwt	pc,#mretail_stepbody&WM
	nop
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:9185.
mretail_landingbody
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	with	r8
	to	r9
	ibt	r1,#$30
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	iwt	r0,#$003c
	to	r1
	add	r1
	ibt	r0,#$30
	add	r9
	from	r1
	stw	[r0]
	ibt	r1,#$00
	ibt	r0,#$32
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$32
	add	r9
	from	r1
	stw	[r0]
	ibt	r1,#$03
	link	#4
	iwt	pc,#mr6_call_mretail_integrate&WM
	nop
	ibt	r1,#$1e
	with	r1
	add	r9
	to	r1
	ldw	[r1]
	ibt	r3,#$22
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	from	r3
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_stepbody&WM
	nop
	dec	r10
	dec	r10
	to	r3
	ldw	[r10]
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	lm	r0,[m_retailwheelcontact]
	with	r0
	from	r0
	bne	mrrt_91ef
	nop
	ibt	r0,#$1e
	add	r9
	from	r1
	stw	[r0]
	ibt	r0,#$22
	add	r9
	from	r3
	stw	[r0]
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrrt_91ef
	ibt	r1,#$00
	ibt	r0,#$0a
	add	r9
	from	r1
	stw	[r0]
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:91FF.
mretail_stepbody
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r0,#sintab&WM
	sm	[m_retailtrigbase],r0
	sub	r0
	sm	[m_retailcontactyaw],r0
	sm	[m_retailwheelcontact],r0
	link	#4
	iwt	pc,#mr6_call_mretail_forceclear&WM
	nop
	iwt	r3,#$0001
	ibt	r0,#$1c
	add	r9
	ldw	[r0]
	bic	r3
	sbk
	ibt	r0,#$18
	add	r9
	ldw	[r0]
	with	r1
	from	r0
	bne	mrrt_9228
	nop
	iwt	pc,#mrrt_92c5&WM
	nop
mrrt_9228
	nop

; US $04:9229.
mretail_bodycacheloop
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r7,#$0c
	with	r7
	add	r1
	to	r7
	ldw	[r7]
	sm	[m_retailwheelobject],r7
	ibt	r0,#$10
	add	r1
	ldw	[r0]
	iwt	r3,#$0002
	bic	r3
	sbk
	sub	r0
	sm	[m_whlD],r0
	ibt	r0,#$16
	add	r7
	ldw	[r0]
	iwt	r2,#$0010
	and	r2
	bne	mrrt_926a
	nop
	link	#4
	iwt	pc,#mretail_rawgeometry&WM
	nop
	with	r0
	from	r0
	beq	mrrt_92b4
	nop
	link	#4
	iwt	pc,#mretail_applyrawgroups&WM
	nop
	lm	r2,[m_whlD]
	with	r2
	not
	inc	r2
	bra	mrrt_927b
	nop
mrrt_926a
	link	#4
	iwt	pc,#mr6_call_mretail_contactcache&WM
	nop
	iwt	r3,#m_groupblocks&WM
	link	#4
	iwt	pc,#mretail_rawgroupforce&WM
	nop
	lm	r2,[m_whlD]
mrrt_927b
	lm	r0,[m_retailwheelcontact]
	with	r0
	from	r0
	bne	mrrt_9288
	nop
	sm	[m_retailwheelcontact],r2
mrrt_9288
	with	r2
	from	r2
	beq	mrrt_92b4
	nop
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	lm	r0,[m_groupPtype]
	iwt	r3,#$0020
	and	r3
	beq	mrrt_92a7
	nop
	ibt	r3,#$2c
	with	r3
	add	r9
	to	r3
	ldw	[r3]
	iwt	r0,#$0020
	or	r3
	sbk
mrrt_92a7
	ibt	r3,#$10
	with	r3
	add	r1
	to	r3
	ldw	[r3]
	iwt	r0,#$0002
	or	r3
	bra	mrrt_92b8
	sbk
mrrt_92b4
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
mrrt_92b8
	ibt	r0,#$0e
	add	r1
	ldw	[r0]
	with	r1
	from	r0
	beq	mrrt_92c5
	nop
	iwt	pc,#mretail_bodycacheloop&WM
	nop

; US $04:92C5.
mrrt_92c5
	ibt	r2,#$20
	with	r2
	add	r9
	to	r2
	ldw	[r2]
	link	#4
	iwt	pc,#mr6_call_mretail_groundgroup&WM
	nop
	iwt	r3,#m_groupblocks&WM
	link	#4
	iwt	pc,#mretail_rawgroupforce&WM
	nop
	with	r0
	from	r0
	beq	mrrt_92f7
	nop
	iwt	r3,#$0001
	ibt	r0,#$1c
	add	r9
	ldw	[r0]
	or	r3
	sbk
	lm	r0,[m_retailwheelcontact]
	with	r0
	from	r0
	bne	mrrt_92f7
	nop
	lm	r0,[m_whlD]
	sm	[m_retailwheelcontact],r0
mrrt_92f7
	link	#4
	iwt	pc,#mr6_call_mretail_applycontact&WM
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; Raw car frame: reset, definition parameters, route and full physics.
; r8 = raw car, r10 = software stack. Definition data is in rcardefs' bank;
; bound route/player/peer lists and serialized workspace must be valid.
; Reset frames return after pose setup. Route thaw can unwind this frame.
; r8/r10 restored; math registers, flags and ROM bank are scratch.
mretail_updatecar
	mpush	r11
	link	#4
	iwt	pc,#mr6_call_mretail_resetwheels&WM
	nop
	lm	r0,[m_retailwheelreset]
	with	r0
	from	r0
	beq	mrrt_carrun
	nop
; Reset/setup frames return before the parameter and physics stages.
	mpop	pc
	nop
mrrt_carrun
	iwt	r0,#rcardefs_begin>>16
	romb
	link	#4
	iwt	pc,#mr6_call_mretail_preparewheelparams&WM
	nop

; US $04:B205.
mrrt_carfront
	ibt	r1,#$1c
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0020
	and	r1
	beq	mrrt_b216
	nop
	iwt	pc,#mrrt_cartail&WM
	nop
mrrt_b216
	nop
	iwt	r0,#$0010
	and	r1
	beq	mrrt_b23b
	nop
	ibt	r0,#$64
	add	r8
	ldw	[r0]
	iwt	r1,#$0008
	and	r1
	bne	mrrt_b22d
	nop
	iwt	pc,#mrrt_cartail&WM
	nop
mrrt_b22d
	link	#4
	iwt	pc,#mretail_rawroutemode&WM
	nop
	with	r0
	from	r0
	bne	mrrt_b23b
	nop
	iwt	pc,#mrrt_cartail&WM
	nop
mrrt_b23b
	ibt	r1,#$06
	link	#4
	iwt	pc,#mr6_call_mretail_integrate&WM
	nop
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
	iwt	pc,#mr6_call_mcrotmatzxy16&WM
	nop
	iwt	r9,#m_wmat11&WM
	link	#4
	iwt	pc,#mr6_call_mtransmat16&WM
	nop
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	ibt	r0,#$64
	add	r8
	ldw	[r0]
	iwt	r1,#$0008
	and	r1
	beq	mrrt_b28e
	nop
	link	#4
	iwt	pc,#mretail_rawroutemode&WM
	nop
	with	r0
	from	r0
	bne	mrrt_b29a
	nop
	iwt	pc,#mrrt_cartail&WM
	nop
mrrt_b28e
	link	#4
	iwt	pc,#mretail_findrawroute&WM
	nop
	with	r0
	to	r7
	ibt	r0,#$58
	add	r8
	from	r7
	stw	[r0]
mrrt_b29a
	iwt	r9,#m_retailwheelparams&WM
	link	#4
	iwt	pc,#mr6_call_mretail_driveinputs&WM
	nop
	lm	r0,[m_dynframe]
	sm	[m_retailgearframe],r0
	iwt	r0,#rcardefs_begin>>16
	romb
	link	#4
	iwt	pc,#mr6_call_mretail_gearforce&WM
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_forceimpulse&WM
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_dragrate&WM
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_collisionstep&WM
	nop
	iwt	pc,#mrrt_carheading&WM
	nop

; US $04:B662.
mrrt_carheading
	ibt	r1,#$70
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0080
	and	r1
	beq	mrrt_b6c1
	nop
	ibt	r0,#$58
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	mrrt_b67c
	nop
	iwt	pc,#mrrt_b6b7&WM
	nop
mrrt_b67c
	iwt	r1,#$008a
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0100
	and	r1
	bne	mrrt_b68e
	nop
	iwt	pc,#mrrt_b6b7&WM
	nop
mrrt_b68e
	link	#4
	iwt	pc,#mretail_carrouteangle&WM
	nop
	with	r0
	to	r2
	ibt	r1,#$24
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	sub	r1
	div2
	div2
	add	r1
	sbk
	sub	r0
	sm	[m_TORQUEx],r0
	with	r0
	to	r3
	ibt	r0,#$34
	add	r8
	from	r3
	stw	[r0]
	from	r1
	sub	r2
	hib
	sex
	div2
	bne	mrrt_b6c1
	nop

; US $04:B6B7.
mrrt_b6b7
	iwt	r1,#$0080
	ibt	r0,#$70
	add	r8
	ldw	[r0]
	bic	r1
	sbk
mrrt_b6c1
	link	#4
	iwt	pc,#mr6_call_mretail_limitmotion&WM
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_motiontail&WM
	nop
	iwt	pc,#mrrt_cartail&WM
	nop

; US $04:B990.
mrrt_cartail
	link	#4
	iwt	pc,#mrrt_cdca&WM
	nop
	iwt	r0,#$0086
	add	r8
	ldw	[r0]
	link	#4
	iwt	pc,#mrrt_ced6&WM
	nop
	with	r0
	to	r1
	iwt	r0,#$0084
	add	r8
	from	r1
	stw	[r0]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:BCA5.
mretail_damagefactor
	iwt	r1,#$0100
	sub	r1
	bmi	mrrt_bcb7
	nop
	iwt	r6,#$0080
	lmult
	from	r4
	swap
	lob
	with	r11
	to	pc
	nop
mrrt_bcb7
	with	r11
	to	pc
	nop

; US $04:C2F8.
mretail_atanraw
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r14
	stw	[r10]
	inc	r10
	inc	r10
	with	r6
	from	r1
	bpl	mrrt_c308
	nop
	with	r6
	not
	inc	r6
mrrt_c308
	with	r0
	from	r2
	bpl	mrrt_c30f
	nop
	not
	inc	r0
mrrt_c30f
	bne	mrrt_c319
	nop
	iwt	r0,#$4000
	iwt	pc,#mrrt_c35d&WM
	nop
mrrt_c319
	ibt	r5,#$00
	cmp	r6
	bne	mrrt_c327
	nop
	iwt	r0,#$2000
	iwt	pc,#mrrt_c35d&WM
	nop
mrrt_c327
	blt	mrrt_c331
	nop
	with	r6
	to	r4
	with	r0
	to	r6
	with	r4
	to	r0
	dec	r5
mrrt_c331
	ibt	r4,#$00
	lsr
	with	r4
	ror
	lsr
	with	r4
	ror
	link	#4
	iwt	pc,#mr6_call_mdivu3115&WM
	nop
	ibt	r0,#mretail_atanwindow>>16
	romb
	from	r4
	lsr
	lsr
	lsr
	lsr
	lsr
	bic	#1
	iwt	r4,#mretail_atanwindow&WM
	to	r14
	add	r4
	getb
	inc	r14
	getbh
	with	r5
	from	r5
	bmi	mrrt_c35d
	nop
	not
	inc	r0
	iwt	r4,#$4000
	add	r4

; US $04:C35D.
mrrt_c35d
	from	r1
	to	r4
	xor	r2
	bpl	mrrt_c366
	nop
	not
	inc	r0
mrrt_c366
	with	r2
	from	r2
	bpl	mrrt_c36f
	nop
	iwt	r4,#$8000
	add	r4
mrrt_c36f
	dec	r10
	dec	r10
	to	r14
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C378.
mretail_carrouteangle
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$1e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r2,#$20
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	ibt	r3,#$22
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	link	#4
	iwt	pc,#mrrt_cc06&WM
	nop
	link	#4
	iwt	pc,#mrrt_cca4&WM
	nop
	link	#4
	iwt	pc,#mrrt_cbe8&WM
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C3A2.
mretail_nearestcarroute
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_findrawroute&WM
	nop
	link	#4
	iwt	pc,#mrrt_cca4&WM
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C3B5.
mretail_findrawroute
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$1e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r2,#$20
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	ibt	r3,#$22
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	link	#4
	iwt	pc,#mrrt_cc06&WM
	nop
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C3D5.
mretail_rawroutemode
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$16
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0400
	and	r1
	bne	mrrt_c3ea
	nop
	iwt	pc,#mrrt_c43d&WM
	nop
mrrt_c3ea
	nop
	ibt	r0,#$18
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_c3fd
	nop
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r1,#$0040
	or	r1
	sbk
mrrt_c3fd
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r1,#$0010
	to	r2
	and	r1
	bne	mrrt_c423
	nop
	or	r1
	sbk
	ibt	r1,#-1
	ibt	r0,#$72
	add	r8
	from	r1
	stw	[r0]
	ibt	r1,#$00
	ibt	r0,#$2e
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$30
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$32
	add	r8
	from	r1
	stw	[r0]
mrrt_c423
	ibt	r2,#$70
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0004
	and	r2
	beq	mrrt_c434
	nop
	iwt	pc,#mrrt_c4be&WM
	nop
mrrt_c434
	link	#4
	iwt	pc,#mrrt_c595&WM
	nop
	iwt	pc,#mrrt_c4b7&WM
	nop

; US $04:C43D.
mrrt_c43d
	ibt	r0,#$1c
	add	r8
	ldw	[r0]
	iwt	r1,#$0010
	to	r2
	and	r1
	beq	mrrt_c456
	nop
	bic	r1
	sbk
	link	#4
	iwt	pc,#mr6_call_mretail_setupwheels&WM
	nop
	link	#4
	iwt	pc,#mrrt_c72f&WM
	nop
mrrt_c456
	ibt	r2,#$70
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0004
	and	r2
	beq	mrrt_c467
	nop
	iwt	pc,#mrrt_c4be&WM
	nop
mrrt_c467
	ibt	r2,#$2c
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	iwt	r0,#$0040
	and	r2
	beq	mrrt_c478
	nop
	iwt	pc,#mrrt_c4ab&WM
	nop
mrrt_c478
	ibt	r1,#$1e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r2,#$20
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	ibt	r3,#$22
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	link	#4
	iwt	pc,#mrrt_cc06&WM
	nop
	with	r0
	from	r0
	bne	mrrt_c498
	nop
	iwt	pc,#mrrt_c4ab&WM
	nop
mrrt_c498
	with	r0
	to	r7
	ibt	r0,#$58
	add	r8
	from	r7
	stw	[r0]
	with	r7
	to	r0
	link	#4
	iwt	pc,#mrrt_cca4&WM
	nop
	link	#4
	iwt	pc,#mrrt_c7d5&WM
	nop

; US $04:C4AB.
mrrt_c4ab
	link	#4
	iwt	pc,#mrrt_c933&WM
	nop
	ibt	r0,#$01
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C4B7.
mrrt_c4b7
	ibt	r0,#$00
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C4BE.
mrrt_c4be
	link	#4
	iwt	pc,#mretail_findrawroute&WM
	nop
	with	r0
	to	r7
	ibt	r0,#$58
	add	r8
	from	r7
	stw	[r0]
	ibt	r0,#$01
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C595.
mrrt_c595
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#6
	romb
	iwt	r14,#mretail_rawtimings&WM
	lm	r0,[m_mapnumber]
	lob
	add	r0
	with	r14
	add	r0
	getb
	inc	r14
	getbh
	with	r0
	to	r14
	lm	r2,[m_playercar]
	iwt	r1,#$0088
	with	r1
	add	r2
	to	r1
	ldw	[r1]
	iwt	r0,#$0088
	add	r8
	ldw	[r0]
	sub	r1
	add	r0
	add	r0
	with	r14
	add	r0
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	to	r6
	getb
	inc	r14
	with	r6
	getbh
	inc	r14
	from	r6
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$72
	add	r8
	ldw	[r0]
	inc	r0
	beq	mrrt_c5e8
	sbk
	cmp	r3
	bpl	mrrt_c5e6
	nop
	iwt	pc,#mrrt_c60b&WM
	nop
mrrt_c5e6
	sub	r0
	sbk
mrrt_c5e8
	ibt	r0,#$58
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	mrrt_c5f5
	nop
	iwt	pc,#mrrt_c60b&WM
	nop
mrrt_c5f5
	link	#4
	iwt	pc,#mrrt_cd83&WM
	nop
	link	#4
	iwt	pc,#mrrt_cca4&WM
	nop
	with	r0
	to	r6
	ibt	r0,#$58
	add	r8
	from	r6
	stw	[r0]
	link	#4
	iwt	pc,#mrrt_c65a&WM
	nop

; US $04:C60B.
mrrt_c60b
	dec	r10
	dec	r10
	to	r6
	ldw	[r10]
	ibt	r0,#$2e
	add	r8
	ldw	[r0]
	ibt	r1,#$1e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	fmult
	add	r1
	sbk
	ibt	r0,#$30
	add	r8
	ldw	[r0]
	ibt	r2,#$20
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	fmult
	add	r2
	sbk
	ibt	r0,#$32
	add	r8
	ldw	[r0]
	ibt	r3,#$22
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	fmult
	add	r3
	sbk
	ibt	r0,#$3e
	add	r8
	ldw	[r0]
mrrt_c63a
	with	r6
	from	r0
	beq	mrrt_c655
	nop
	ibt	r0,#$1e
	add	r6
	from	r1
	stw	[r0]
	ibt	r0,#$20
	add	r6
	from	r2
	stw	[r0]
	ibt	r0,#$22
	add	r6
	from	r3
	stw	[r0]
	ibt	r0,#$34
	add	r6
	ldw	[r0]
	bra	mrrt_c63a
	nop
mrrt_c655
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C65A.
mrrt_c65a
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$58
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	mrrt_c66b
	nop
	iwt	pc,#mrrt_c72a&WM
	nop
mrrt_c66b
	link	#4
	iwt	pc,#mrrt_cd83&WM
	nop
	link	#4
	iwt	pc,#mrrt_cd56&WM
	nop
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r0,#$ff60
	with	r2
	add	r0
	sm	[m_t1],r1
	sm	[m_avoidcary],r2
	sm	[m_avoidcarz],r3
	ibt	r0,#$1e
	add	r8
	ldw	[r0]
	sub	r1
	not
	inc	r0
	with	r0
	to	r4
	ibt	r0,#$2e
	add	r8
	from	r4
	stw	[r0]
	ibt	r0,#$20
	add	r8
	ldw	[r0]
	sub	r2
	not
	inc	r0
	with	r0
	to	r4
	ibt	r0,#$30
	add	r8
	from	r4
	stw	[r0]
	ibt	r0,#$22
	add	r8
	ldw	[r0]
	sub	r3
	not
	inc	r0
	with	r0
	to	r4
	ibt	r0,#$32
	add	r8
	from	r4
	stw	[r0]
	ibt	r1,#$00
	ibt	r0,#$26
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$28
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$36
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$34
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$38
	add	r8
	from	r1
	stw	[r0]
	dec	r10
	dec	r10
	ldw	[r10]
	link	#4
	iwt	pc,#mrrt_cca4&WM
	nop
	link	#4
	iwt	pc,#mrrt_cbe8&WM
	nop
	with	r0
	to	r1
	ibt	r0,#$24
	add	r8
	from	r1
	stw	[r0]
	with	r1
	to	r0
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$3e
	add	r8
	ldw	[r0]
mrrt_c6ec
	with	r6
	from	r0
	beq	mrrt_c70b
	nop
	ibt	r0,#$18
	add	r6
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_c704
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_clearrawcontacts&WM
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_sweeprawcontacts&WM
	nop
mrrt_c704
	ibt	r0,#$34
	add	r6
	ldw	[r0]
	bra	mrrt_c6ec
	nop
mrrt_c70b
	dec	r10
	dec	r10
	to	r6
	ldw	[r10]
	from	r6
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$18
	add	r6
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_c726
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_clearrawcontacts&WM
	nop
	link	#4
	iwt	pc,#mr6_call_mretail_sweeprawcontacts&WM
	nop
mrrt_c726
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]

; US $04:C72A.
mrrt_c72a
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C72F.
mrrt_c72f
	dec	r10
	dec	r10
	to	r11
	ldw	[r10]
	ibt	r0,#$58
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	mrrt_c740
	nop
	iwt	pc,#mrrt_c77c&WM
	nop
mrrt_c740
	link	#4
	iwt	pc,#mrrt_cd83&WM
	nop
	link	#4
	iwt	pc,#mrrt_cd56&WM
	nop
	ibt	r0,#6
	romb
	lm	r0,[m_mapnumber]
	lob
	add	r0
	iwt	r14,#mretail_rawspeedscales&WM
	with	r14
	add	r0
	to	r6
	getb
	inc	r14
	with	r6
	getbh
	from	r4
	add	r4
	fmult
	with	r0
	to	r4
	ibt	r0,#$24
	add	r8
	ldw	[r0]
	link	#4
	iwt	pc,#mrrt_cd98&WM
	nop
	ibt	r0,#$2e
	add	r8
	from	r1
	stw	[r0]
	ibt	r0,#$30
	add	r8
	from	r2
	stw	[r0]
	ibt	r0,#$32
	add	r8
	from	r3
	stw	[r0]

; US $04:C77C.
mrrt_c77c
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C7D5.
mrrt_c7d5
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$70
	add	r8
	ldw	[r0]
	iwt	r5,#$0020
	and	r5
	beq	mrrt_c7ec
	nop
	with	r4
	div2
	from	r4
	div2
	with	r4
	add	r0
mrrt_c7ec
	from	r4
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mrrt_cbe8&WM
	nop
	with	r0
	to	r1
	ibt	r0,#$24
	add	r8
	ldw	[r0]
	with	r1
	sub	r0
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r2,#$0100
	and	r2
	beq	mrrt_c816
	nop
	ibt	r0,#$26
	add	r8
	ldw	[r0]
	with	r0
	to	r2
	div2
	div2
	with	r2
	sub	r0
	from	r2
	sbk
mrrt_c816
	dec	r10
	dec	r10
	to	r4
	ldw	[r10]
	ibt	r9,#$00
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	with	r4
	to	r3
	cmp	r3
	bpl	mrrt_c840
	nop
	iwt	r2,#$0227
	from	r4
	cmp	r2
	bmi	mrrt_c838
	nop
	iwt	r0,#$0400
	to	r9
	or	r9
	bra	mrrt_c845
	nop
mrrt_c838
	iwt	r0,#$0010
	to	r9
	or	r9
	bra	mrrt_c845
	nop
mrrt_c840
	iwt	r0,#$0040
	to	r9
	or	r9
mrrt_c845
	ibt	r2,#$3a
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	with	r1
	to	r0
	sub	r2
	bpl	mrrt_c87e
	nop
	iwt	r1,#$fc72
	cmp	r1
	bpl	mrrt_c8ab
	nop
	iwt	r1,#$f05c
	cmp	r1
	bpl	mrrt_c866
	nop
	iwt	r0,#$ffef
	to	r9
	and	r9
mrrt_c866
	iwt	r0,#$0002
	to	r9
	or	r9
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$4000
	and	r1
	beq	mrrt_c8ab
	nop
	iwt	r0,#$0008
	to	r9
	or	r9
	bra	mrrt_c8ab
	nop
mrrt_c87e
	iwt	r1,#$038e
	cmp	r1
	bmi	mrrt_c8ab
	nop
	iwt	r1,#$0fa4
	cmp	r1
	bmi	mrrt_c893
	nop
	iwt	r0,#$ffef
	to	r9
	and	r9
mrrt_c893
	iwt	r0,#$0001
	to	r9
	or	r9
	ibt	r0,#$40
	add	r8
	ldw	[r0]
	iwt	r1,#$4000
	and	r1
	beq	mrrt_c8ab
	nop
	iwt	r0,#$0004
	to	r9
	or	r9
	bra	mrrt_c8ab
	nop
mrrt_c8ab
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	iwt	r3,#$00c8
	cmp	r3
	bpl	mrrt_c8bc
	nop
	iwt	r0,#$0010
	to	r9
	or	r9
mrrt_c8bc
	ibt	r0,#$7c
	add	r8
	ldw	[r0]
	with	r1
	from	r0
	beq	mrrt_c8cb
	dec	r0
	sbk
	iwt	r0,#$fbef
	to	r9
	and	r9
mrrt_c8cb
	ibt	r0,#$7e
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	mrrt_c8df
	nop
	iwt	r1,#$0014
	cmp	r1
	bmi	mrrt_c8fc
	nop
	iwt	r0,#$ffd8
mrrt_c8df
	inc	r0
	sbk
	iwt	r1,#$ffec
	cmp	r1
	bpl	mrrt_c91b
	nop
	iwt	r0,#$fbaf
	to	r9
	and	r9
	iwt	r0,#$0020
	to	r9
	or	r9
	iwt	r0,#$0003
	to	r9
	xor	r9
	bra	mrrt_c91b
	nop
mrrt_c8fc
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	iwt	r1,#$000a
	cmp	r1
	bpl	mrrt_c911
	nop
	ibt	r0,#$7e
	add	r8
	ldw	[r0]
	inc	r0
	sbk
	bra	mrrt_c91b
	nop
mrrt_c911
	ibt	r0,#$7e
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_c91b
	dec	r0
	sbk
mrrt_c91b
	ibt	r0,#$44
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_c929
	nop
	iwt	r0,#$fbef
	to	r9
	and	r9
mrrt_c929
	ibt	r0,#$42
	add	r8
	from	r9
	stw	[r0]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:C933.
mrrt_c933
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r9,#$42
	with	r9
	add	r8
	to	r9
	ldw	[r9]
	ibt	r0,#$1e
	add	r8
	ldw	[r0]
	sm	[m_t1],r0
	ibt	r0,#$22
	add	r8
	ldw	[r0]
	sm	[m_avoidcarz],r0
	ibt	r0,#$2e
	add	r8
	ldw	[r0]
	sm	[m_avoidcarvx],r0
	ibt	r0,#$32
	add	r8
	ldw	[r0]
	sm	[m_retailruntime3],r0
	lm	r0,[m_avoidcarhead]

; US $04:C961.
mrrt_c961
	with	r7
	from	r0
	bne	mrrt_c96a
	nop
	iwt	pc,#mrrt_ca94&WM
	nop
mrrt_c96a
	cmp	r8
	bne	mrrt_c973
	nop
	iwt	pc,#mrrt_ca8c&WM
	nop
mrrt_c973
	ibt	r1,#$16
	with	r1
	add	r7
	to	r1
	ldw	[r1]
	iwt	r0,#$0400
	and	r1
	beq	mrrt_c984
	nop
	iwt	pc,#mrrt_ca8c&WM
	nop
mrrt_c984
	nop
	ibt	r1,#$4a
	with	r1
	add	r7
	to	r1
	ldw	[r1]
	ibt	r0,#$4a
	add	r8
	ldw	[r0]
	sub	r1
	bpl	mrrt_c997
	nop
	iwt	pc,#mrrt_ca8c&WM
	nop
mrrt_c997
	ibt	r0,#$1e
	add	r7
	ldw	[r0]
	lm	r1,[m_t1]
	sub	r1
	sms	[m_x1],r0
	with	r1
	from	r0
	bpl	mrrt_c9ab
	nop
	with	r1
	not
	inc	r1
mrrt_c9ab
	ibt	r0,#$22
	add	r7
	ldw	[r0]
	lm	r3,[m_avoidcarz]
	sub	r3
	sms	[m_z1],r0
	with	r3
	from	r0
	bpl	mrrt_c9bf
	nop
	with	r3
	not
	inc	r3
mrrt_c9bf
	sub	r0
	sms	[m_y1],r0
	from	r1
	add	r3
	div2
	div2
	div2
	div2
	div2
	sm	[m_retailruntime2],r0
	ibt	r0,#$2e
	add	r7
	ldw	[r0]
	lm	r1,[m_avoidcarvx]
	with	r1
	sub	r0
	ibt	r0,#$32
	add	r7
	ldw	[r0]
	lm	r3,[m_retailruntime3]
	with	r3
	sub	r0
	ibt	r2,#$00
	lms	r6,[m_x1]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_y1]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_z1]
	from	r3
	fmult
	rol
	add	r5
	iwt	r1,#$0014
	add	r1
	sm	[m_retailruntime1],r0
	lm	r1,[m_retailruntime2]
	cmp	r1
	bpl	mrrt_ca14
	nop
	iwt	pc,#mrrt_ca8c&WM
	nop
mrrt_ca14
	lms	r1,[m_wmat11]
	lms	r2,[m_wmat12]
	lms	r3,[m_wmat13]
	lms	r6,[m_x1]
	from	r1
	fmult
	to	r5
	rol
	lms	r6,[m_y1]
	from	r2
	fmult
	rol
	with	r5
	add	r0
	lms	r6,[m_z1]
	from	r3
	fmult
	rol
	add	r5
	sm	[m_retailruntime2],r0
	with	r0
	to	r1
	with	r0
	from	r0
	bpl	mrrt_ca40
	nop
	not
	inc	r0
mrrt_ca40
	iwt	r2,#$0200
	cmp	r2
	bmi	mrrt_ca4e
	nop
	ibt	r2,#-1
	sm	[m_retailruntime1],r2
mrrt_ca4e
	ibt	r6,#$42
	with	r6
	add	r8
	to	r6
	ldw	[r6]
	lm	r0,[m_retailruntime1]
	with	r0
	from	r0
	bmi	mrrt_ca87
	nop
	with	r1
	from	r1
	bpl	mrrt_ca76
	nop
	iwt	r0,#$0001
	and	r9
	beq	mrrt_ca6e
	nop
	iwt	r0,#$fffe
	to	r6
	and	r6
mrrt_ca6e
	iwt	r0,#$0002
	to	r6
	or	r6
	bra	mrrt_ca87
	nop
mrrt_ca76
	iwt	r0,#$0002
	and	r9
	beq	mrrt_ca82
	nop
	iwt	r0,#$fffd
	to	r6
	and	r6
mrrt_ca82
	iwt	r0,#$0001
	to	r6
	or	r6
mrrt_ca87
	ibt	r0,#$42
	add	r8
	from	r6
	stw	[r0]

; US $04:CA8C.
mrrt_ca8c
	ibt	r0,#$74
	add	r7
	ldw	[r0]
	iwt	pc,#mrrt_c961&WM
	nop

; US $04:CA94.
mrrt_ca94
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
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
	iwt	pc,#mr6_call_mretail_normalise&WM
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
	bpl	mrrt_cb3b
	nop
	sub	r0
mrrt_cb3b
	lm	r1,[m_x2]
	add	r1
	lm	r1,[m_x1]
	cmp	r1
	bmi	mrrt_cb63
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
mrrt_cb63
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
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r1,#$1e
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	ibt	r2,#$20
	with	r2
	add	r8
	to	r2
	ldw	[r2]
	ibt	r3,#$22
	with	r3
	add	r8
	to	r3
	ldw	[r3]
	with	r5
	from	r5
	beq	mrrt_cbdd
	nop
	ibt	r1,#$26
	with	r1
	add	r5
	to	r1
	ldw	[r1]
	with	r1
	from	r1
	beq	mrrt_cbaa
	nop
	with	r1
	to	r5
mrrt_cbaa
	ibt	r0,#$58
	add	r8
	from	r5
	stw	[r0]
	with	r0
	to	r1
	ibt	r0,#$24
	add	r8
	ldw	[r0]
	with	r1
	sub	r0
	dec	r10
	dec	r10
	to	r3
	ldw	[r10]
	with	r3
	to	r2
	with	r2
	not
	inc	r2
	with	r1
	from	r1
	bmi	mrrt_cbd0
	nop
	with	r1
	cmp	r3
	bmi	mrrt_cbd8
	nop
	with	r3
	to	r1
	bra	mrrt_cbd8
	nop
mrrt_cbd0
	with	r1
	cmp	r2
	bpl	mrrt_cbd8
	nop
	with	r2
	to	r1
mrrt_cbd8
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrrt_cbdd
	dec	r10
	dec	r10
	ldw	[r10]
	iwt	r1,#$0000
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:CBE8.
mrrt_cbe8
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$1e
	add	r8
	ldw	[r0]
	with	r1
	sub	r0
	ibt	r0,#$22
	add	r8
	ldw	[r0]
	with	r3
	sub	r0
	with	r3
	to	r2
	link	#4
	iwt	pc,#mretail_atanraw&WM
	nop
	not
	inc	r0
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:CC06.
mrrt_cc06
	lm	r0,[m_routebank]
	romb
	lm	r0,[m_routeptr]
	with	r14
	from	r0
	bne	mrrt_cc19
	nop
	iwt	pc,#mrrt_cca0&WM
	nop
mrrt_cc19
	getb
	inc	r14
	getbh
	inc	r14
	with	r12
	from	r0
	bne	mrrt_cc27
	nop
	iwt	pc,#mrrt_cca0&WM
	nop
mrrt_cc27
	ibt	r5,#$00
	iwt	r6,#$7fff
	ibt	r4,#$00
	ibt	r7,#$00
	cache
	with	pc
	to	r13
	inc	r4
	getb
	inc	r14
	getbh
	inc	r14
	sub	r1
	bvs	mrrt_cc7a
	nop
	bpl	mrrt_cc42
	nop
	not
	inc	r0
mrrt_cc42
	with	r0
	to	r9
	getb
	inc	r14
	getbh
	inc	r14
	sub	r2
	bpl	mrrt_cc4f
	nop
	not
	inc	r0
mrrt_cc4f
	add	r0
	add	r0
	with	r9
	add	r0
	bvs	mrrt_cc76
	nop
	getb
	inc	r14
	getbh
	inc	r14
	sub	r3
	bvs	mrrt_cc7d
	nop
	bpl	mrrt_cc64
	nop
	not
	inc	r0
mrrt_cc64
	add	r9
	bvs	mrrt_cc7d
	nop
	cmp	r6
	bcs	mrrt_cc7d
	nop
	with	r0
	to	r6
	with	r14
	to	r5
	with	r4
	to	r7
	bra	mrrt_cc7d
	nop
mrrt_cc76
	inc	r14
	bra	mrrt_cc7d
	inc	r14
mrrt_cc7a
	with	r14
	add	#4
mrrt_cc7d
	inc	r14
	loop
	inc	r14
	with	r7
	to	r0
	from	r5
	to	r5
	sub	#6
	with	r5
	to	r14
	to	r1
	getb
	inc	r14
	with	r1
	getbh
	inc	r14
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	with	r11
	to	pc
	nop

; US $04:CCA0.
mrrt_cca0
	sub	r0
	with	r11
	to	pc
	nop

; US $04:CCA4.
mrrt_cca4
	with	r0
	to	r6
	lm	r0,[m_routebank]
	romb
	ibt	r1,#$70
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	iwt	r0,#$0002
	and	r1
	with	r6
	to	r0
	beq	mrrt_ccbf
	nop
	iwt	pc,#mrrt_cd05&WM
	nop
mrrt_ccbf
	with	r0
	to	r6
	inc	r6
	lm	r14,[m_routeptr]
	to	r1
	getb
	inc	r14
	with	r1
	getbh
	cmp	r1
	bne	mrrt_ccde
	nop
	lm	r0,[m_routeptr]
	add	#2
	with	r0
	to	r14
	ibt	r6,#$01
	bra	mrrt_cce2
	nop
mrrt_ccde
	from	r5
	to	r14
	add	#8
mrrt_cce2
	with	r14
	to	r5
	to	r1
	getb
	inc	r14
	with	r1
	getbh
	inc	r14
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	to	r4
	getb
	inc	r14
	with	r4
	getbh
	inc	r14
	with	r6
	to	r0
	with	r11
	to	pc
	nop

; US $04:CD05.
mrrt_cd05
	with	r0
	to	r6
	lm	r0,[m_routebank]
	romb
	dec	r6
	bne	mrrt_cd2f
	nop
	lm	r14,[m_routeptr]
	getb
	inc	r14
	getbh
	with	r0
	to	r1
	dec	r0
	iwt	r6,#$0008
	lmult
	lm	r0,[m_routeptr]
	add	#2
	from	r4
	to	r14
	add	r0
	with	r1
	to	r6
	bra	mrrt_cd33
	nop
mrrt_cd2f
	from	r5
	to	r14
	sub	#8
mrrt_cd33
	with	r14
	to	r5
	to	r1
	getb
	inc	r14
	with	r1
	getbh
	inc	r14
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	to	r4
	getb
	inc	r14
	with	r4
	getbh
	inc	r14
	with	r6
	to	r0
	with	r11
	to	pc
	nop

; US $04:CD56.
mrrt_cd56
	stw	[r10]
	inc	r10
	inc	r10
	lm	r0,[m_routebank]
	romb
	with	r5
	to	r14
	to	r1
	getb
	inc	r14
	with	r1
	getbh
	inc	r14
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	to	r4
	getb
	inc	r14
	with	r4
	getbh
	inc	r14
	dec	r10
	dec	r10
	ldw	[r10]
	with	r11
	to	pc
	nop

; US $04:CD83.
mrrt_cd83
	with	r0
	to	r1
	dec	r0
	iwt	r6,#$0008
	lmult
	lm	r0,[m_routeptr]
	add	#2
	to	r5
	add	r4
	with	r1
	to	r0
	with	r11
	to	pc
	nop

; US $04:CD98.
mrrt_cd98
	hib
	with	r0
	to	r3
	ibt	r0,#$00
	romb
	with	r4
	to	r6
	with	r3
	to	r0
	lob
	iwt	r14,#sintab&WM
	to	r14
	add	r14
	getb
	swap
	fmult
	not
	inc	r0
	add	r0
	add	r0
	add	r0
	add	r0
	with	r0
	to	r1
	with	r3
	to	r0
	lob
	iwt	r14,#costab&WM
	to	r14
	add	r14
	getb
	swap
	fmult
	add	r0
	add	r0
	add	r0
	add	r0
	with	r0
	to	r3
	ibt	r2,#$00
	with	r11
	to	pc
	nop

; US $04:CDCA.
mrrt_cdca
	ibt	r0,#$58
	add	r8
	ldw	[r0]
	iwt	r1,#$0086
	with	r1
	add	r8
	to	r1
	ldw	[r1]
	with	r0
	to	r3
	cmp	r1
	beq	mrrt_ce1a
	nop
	lm	r0,[m_routebank]
	romb
	lm	r0,[m_routeptr]
	with	r14
	from	r0
	beq	mrrt_ce1a
	nop
	to	r4
	getb
	inc	r14
	with	r4
	getbh
	from	r3
	sub	r1
	bpl	mrrt_cdff
	nop
	with	r1
	cmp	r4
	beq	mrrt_ce06
	nop
	bra	mrrt_ce1a
	nop
mrrt_cdff
	ibt	r2,#$05
	cmp	r2
	bpl	mrrt_ce1a
	nop
mrrt_ce06
	iwt	r0,#$0086
	add	r8
	from	r3
	stw	[r0]
	ibt	r2,#$01
	with	r3
	cmp	r2
	bne	mrrt_ce1a
	nop
	ibt	r0,#$7a
	add	r8
	ldw	[r0]
	inc	r0
	sbk
mrrt_ce1a
	with	r11
	to	pc
	nop

; US $04:CE1D.
mretail_rankrawcars
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	cache
	ibt	r5,#$00
	lm	r0,[m_avoidcarhead]
	with	r0
	from	r0
	beq	mrrt_ce60
	nop
mrrt_ce2d
	with	r8
	from	r0
	beq	mrrt_ce3f
	nop
	iwt	r0,#$0088
	add	r8
	from	r5
	stw	[r0]
	ibt	r0,#$74
	add	r8
	ldw	[r0]
	bra	mrrt_ce2d
	nop
mrrt_ce3f
	lm	r0,[m_avoidcarhead]
	ibt	r9,#$01
	cache
mrrt_ce46
	with	r8
	from	r0
	beq	mrrt_ce60
	nop
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mrrt_ce65&WM
	nop
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
	inc	r9
	ibt	r0,#$74
	add	r8
	ldw	[r0]
	bra	mrrt_ce46
	nop
mrrt_ce60
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:CE65.
mrrt_ce65
	sub	r0
	with	r0
	to	r2
	with	r0
	to	r3
	ibt	r1,#-1
	lm	r0,[m_avoidcarhead]
	with	r4
	from	r0
mrrt_ce72
	with	r8
	from	r0
	beq	mrrt_cecd
	nop
	iwt	r0,#$0088
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bne	mrrt_cec6
	nop
	ibt	r5,#$7a
	with	r5
	add	r8
	to	r5
	ldw	[r5]
	iwt	r6,#$0086
	with	r6
	add	r8
	to	r6
	ldw	[r6]
	iwt	r7,#$0084
	with	r7
	add	r8
	to	r7
	ldw	[r7]
	with	r5
	from	r5
	bne	mrrt_cea6
	nop
	iwt	r0,#$0086
	add	r8
	ldw	[r0]
	sub	r6
	add	#5
	bpl	mrrt_cea6
	nop
	dec	r5
mrrt_cea6
	with	r5
	cmp	r1
	bmi	mrrt_cec6
	nop
	bne	mrrt_cebe
	nop
	with	r6
	cmp	r2
	bmi	mrrt_cec6
	nop
	bne	mrrt_cebe
	nop
	with	r7
	cmp	r3
	bpl	mrrt_cec6
	nop
mrrt_cebe
	with	r8
	to	r4
	with	r5
	to	r1
	with	r6
	to	r2
	with	r7
	to	r3
mrrt_cec6
	ibt	r0,#$74
	add	r8
	ldw	[r0]
	bra	mrrt_ce72
	nop
mrrt_cecd
	iwt	r0,#$0088
	add	r4
	from	r9
	stw	[r0]
	with	r11
	to	pc
	nop

; US $04:CED6.
mrrt_ced6
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mrrt_cd83&WM
	nop
	link	#4
	iwt	pc,#mrrt_cca4&WM
	nop
	ibt	r0,#$1e
	add	r8
	ldw	[r0]
	sub	r1
	bpl	mrrt_ceee
	nop
	not
	inc	r0
mrrt_ceee
	div2
	div2
	with	r0
	to	r4
	ibt	r0,#$22
	add	r8
	ldw	[r0]
	sub	r3
	bpl	mrrt_cefe
	nop
	not
	inc	r0
mrrt_cefe
	div2
	div2
	add	r4
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:CF08.
mretail_nearrawcar
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	lm	r3,[m_playercar]
	with	r3
	from	r3
	bne	mrrt_cf19
	nop
	iwt	pc,#mrrt_d030&WM
	nop
mrrt_cf19
	ibt	r1,#$1e
	with	r1
	add	r3
	to	r1
	ldw	[r1]
	ibt	r2,#$22
	with	r2
	add	r3
	to	r2
	ldw	[r2]
	ibt	r8,#$64
	with	r8
	add	r3
	to	r8
	ldw	[r8]
	iwt	r0,#$0008
	and	r8
	beq	mrrt_cf3a
	nop
	ibt	r3,#$00
	lms	r1,[m_viewposx]
	lms	r2,[m_viewposz]
mrrt_cf3a
	iwt	r5,#$1000
	ibt	r6,#$00
	lm	r0,[m_avoidcarhead]
	with	r0
	from	r0
	bne	mrrt_cf4c
	nop
	iwt	pc,#mrrt_d030&WM
	nop
mrrt_cf4c
	cache
mrrt_cf4d
	with	r8
	from	r0
	beq	mrrt_cf90
	nop
	cmp	r3
	beq	mrrt_cf89
	nop
	ibt	r0,#$1e
	add	r8
	ldw	[r0]
	sub	r1
	bpl	mrrt_cf61
	nop
	not
	inc	r0
mrrt_cf61
	with	r0
	to	r4
	ibt	r0,#$22
	add	r8
	ldw	[r0]
	sub	r2
	bpl	mrrt_cf6d
	nop
	not
	inc	r0
mrrt_cf6d
	with	r4
	add	r0
	bvs	mrrt_cf89
	nop
	with	r4
	cmp	r5
	bpl	mrrt_cf83
	nop
	iwt	r6,#$008c
	with	r6
	add	r8
	to	r6
	ldw	[r6]
	with	r4
	to	r5
	with	r8
	to	r7
mrrt_cf83
	iwt	r0,#$008c
	add	r8
	from	r4
	stw	[r0]
mrrt_cf89
	ibt	r0,#$74
	add	r8
	ldw	[r0]
	bra	mrrt_cf4d
	nop
mrrt_cf90
	with	r0
	from	r6
	bne	mrrt_cf99
	nop
	iwt	pc,#mrrt_d030&WM
	nop
mrrt_cf99
	from	r6
	sub	r5
	to	r6
	div2
	iwt	r0,#$0080
	with	r6
	add	r0
	bpl	mrrt_cfa8
	nop
	ibt	r6,#$00
mrrt_cfa8
	lm	r0,[m_nearcarapproach]
	with	r0
	from	r0
	bpl	mrrt_cfb7
	nop
	with	r6
	to	r0
	sm	[m_nearcarapproach],r0
mrrt_cfb7
	sub	r6
	div2
	div2
	lm	r8,[m_nearcarapproach]
	from	r8
	sub	r0
	sbk
	iwt	r6,#$0080
	from	r5
	fmult
	iwt	r8,#$0007
	cmp	r8
	bmi	mrrt_cfd2
	nop
	with	r8
	to	r0
mrrt_cfd2
	sm	[m_nearcarband],r0
	iwt	r8,#$00ff
	lm	r0,[m_nearcarapproach]
	cmp	r8
	bmi	mrrt_cfe4
	nop
	from	r8
	sbk
mrrt_cfe4
	sm	[m_nearcar],r7
	ibt	r0,#$1e
	add	r7
	ldw	[r0]
	to	r1
	sub	r1
	ibt	r0,#$22
	add	r7
	ldw	[r0]
	to	r3
	sub	r2
	lms	r0,[m_viewroty]
	to	r2
	hib
	ibt	r0,#$00
	romb
	link	#4
	iwt	pc,#mr6_call_mrotate_xz8&WM
	nop
	sm	[m_nearcarside],r3
	with	r1
	not
	inc	r1
	sm	[m_nearcardepth],r1
	from	r3
	div2
	div2
	div2
	div2
	div2
	add	#7
	bpl	mrrt_d01e
	nop
	sub	r0
mrrt_d01e
	ibt	r3,#$0f
	cmp	r3
	bmi	mrrt_d027
	nop
	with	r3
	to	r0
mrrt_d027
	sm	[m_nearcarpan],r0
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:D030.
mrrt_d030
	ibt	r0,#-1
	sm	[m_nearcarapproach],r0
	sub	r0
	sm	[m_nearcar],r0
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

mretail_rawtimings
	dw	mretail_rawtimings+$007c
	dw	mretail_rawtimings+$007c
	dw	mretail_rawtimings+$007c
	dw	mretail_rawtimings+$007c
	dw	mretail_rawtimings+$0098
	dw	mretail_rawtimings+$0098
	dw	mretail_rawtimings+$0098
	dw	mretail_rawtimings+$0098
	dw	mretail_rawtimings+$00b4
	dw	mretail_rawtimings+$00b4
	dw	mretail_rawtimings+$00b4
	dw	mretail_rawtimings+$00b4
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	mretail_rawtimings+$0060
	dw	$0006
	dw	$2aaa
	dw	$0006
	dw	$2aaa
	dw	$0006
	dw	$2aaa
	dw	$0000
	dw	$0000
	dw	$0006
	dw	$2aaa
	dw	$0006
	dw	$2aaa
	dw	$0006
	dw	$2aaa
	dw	$0008
	dw	$1fff
	dw	$0009
	dw	$1c71
	dw	$000a
	dw	$1999
	dw	$0000
	dw	$0000
	dw	$0005
	dw	$3333
	dw	$0007
	dw	$2492
	dw	$0008
	dw	$1fff
	dw	$0007
	dw	$2492
	dw	$0007
	dw	$2492
	dw	$0008
	dw	$1fff
	dw	$0000
	dw	$0000
	dw	$0005
	dw	$3333
	dw	$0006
	dw	$2aaa
	dw	$0007
	dw	$2492
	dw	$0006
	dw	$2aaa
	dw	$0006
	dw	$2aaa
	dw	$0007
	dw	$2492
	dw	$0000
	dw	$0000
	dw	$0004
	dw	$3fff
	dw	$0006
	dw	$2aaa
	dw	$0006
	dw	$2aaa

mretail_rawspeedscales
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$72f6
	dw	$72f6
	dw	$72f6
	dw	$72f6
	dw	$7d2e
	dw	$7d2e
	dw	$7d2e
	dw	$7d2e
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4
	dw	$4ca4

mr6_call_mcrotmatzxy16
	iwt	r12,#mcrotmatzxy16&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_call_mdivu3115
	iwt	r12,#mdivu3115&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_call_mretail_allocobject
	iwt	r12,#mretail_allocobject&WM
	iwt	pc,#mr6_far5&WM
	nop

mr6_call_mretail_applycontact
	iwt	r12,#mretail_applycontact&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_applygroups
	iwt	r12,#mretail_applygroups&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_clearrawcontacts
	iwt	r12,#mretail_clearrawcontacts&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_collisionstep
	iwt	r12,#mretail_collisionstep&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_contactcache
	iwt	r12,#mretail_contactcache&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_dragrate
	iwt	r12,#mretail_dragrate&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_call_mretail_driveinputs
	iwt	r12,#mretail_driveinputs&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_call_mretail_forceclear
	iwt	r12,#mretail_forceclear&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_forceimpulse
	iwt	r12,#mretail_forceimpulse&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_gearforce
	iwt	r12,#mretail_gearforce&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_call_mretail_groundgroup
	iwt	r12,#mretail_groundgroup&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_groupforce
	iwt	r12,#mretail_groupforce&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_integrate
	iwt	r12,#mretail_integrate&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_limitmotion
	iwt	r12,#mretail_limitmotion&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_call_mretail_motiontail
	iwt	r12,#mretail_motiontail&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_normalise
	iwt	r12,#mretail_normalise&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_preparewheelparams
	iwt	r12,#mretail_preparewheelparams&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_releaseobject
	iwt	r12,#mretail_releaseobject&WM
	iwt	pc,#mr6_far5&WM
	nop

mr6_call_mretail_resetwheels
	iwt	r12,#mretail_resetwheels&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_scancontacts
	iwt	r12,#mretail_scancontacts&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_setupwheels
	iwt	r12,#mretail_setupwheels&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_shapegroups
	iwt	r12,#mretail_shapegroups&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mretail_sweeprawcontacts
	iwt	r12,#mretail_sweeprawcontacts&WM
	iwt	pc,#mr6_far4&WM
	nop

mr6_call_mrotate_xz8
	iwt	r12,#mrotate_xz8&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_call_mtransmat16
	iwt	r12,#mtransmat16&WM
	iwt	pc,#mr6_far1&WM
	nop

mr6_far1
	mpush	r11
	iwt	r11,#mretail_runtimereturn1&WM
	iwt	r13,#1
	from	r12
	ljmp	r13
	nop

mr6_far4
	mpush	r11
	iwt	r11,#mretail_runtimereturn4&WM
	iwt	r13,#4
	from	r12
	ljmp	r13
	nop

mr6_far5
	mpush	r11
	iwt	r11,#mretail_heapreturn5&WM
	iwt	r13,#5
	from	r12
	ljmp	r13
	nop

mrrt_farreturn6
	mpop	r11
	move	pc,r11
	nop


; US $04:944C; keep the caller-selected ROM bank for normal rotation.
; r3 = group; m_retailtrigbase selects the sine-table address in that bank.
; r3 advances ten bytes; raw body pointers r8/r9 are preserved.
mretail_rawgroupforce
	ldw	[r3]
	inc	r3
	inc	r3
	with	r0
	from	r0
	bne	mrrg_9458
	nop
	iwt	pc,#mrrg_9575&WM
	nop
mrrg_9458
	to	r7
	hib
	beq	mrrg_9461
	nop
	iwt	pc,#mrrg_9565&WM
	nop
mrrg_9461
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
	bpl	mrrg_9473
	nop
	iwt	pc,#mrrg_956c&WM
	nop
mrrg_9473
	iwt	r0,#$7d00
	cmp	r7
	bne	mrrg_947f
	nop
	iwt	pc,#mrrg_956c&WM
	nop
mrrg_947f
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
	bne	mrrg_94a4
	nop
	iwt	pc,#mrrg_9531&WM
	nop
mrrg_94a4
	iwt	r1,#$0040
	cmp	r1
	bne	mrrg_94b8
	nop
	with	r6
	to	r0
	not
	inc	r0
	with	r4
	to	r6
	with	r0
	to	r4
	iwt	pc,#mrrg_9531&WM
	nop
mrrg_94b8
	iwt	r1,#$00c0
	cmp	r1
	bne	mrrg_94cb
	nop
	with	r4
	to	r0
	not
	inc	r0
	with	r6
	to	r4
	with	r0
	to	r6
	bra	mrrg_9531
	nop
mrrg_94cb
	iwt	r1,#$0080
	cmp	r1
	bne	mrrg_94dc
	nop
	with	r4
	not
	inc	r4
	with	r6
	not
	inc	r6
	bra	mrrg_9531
	nop
mrrg_94dc
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
	beq	mrrg_9511
	nop
	link	#4
	iwt	pc,#mretail_rawrotate&WM
	nop
	with	r1
	add	r1
	with	r1
	add	r1
	with	r3
	add	r3
	with	r3
	add	r3
mrrg_9511
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
mrrg_9531
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
	iwt	pc,#mr6_call_mretail_forceworld&WM
	nop
	ibt	r0,#$01
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrrg_9565
	ibt	r0,#$08
	with	r3
	add	r0
	with	r11
	to	pc
	nop
mrrg_956c
	ibt	r0,#$06
	with	r3
	add	r0
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop
mrrg_9575
	ibt	r0,#$08
	with	r3
	add	r0
	with	r11
	to	pc
	nop

; US $04:C15C; keep the caller-selected ROM bank for normal rotation.
mretail_rawrotate
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	lm	r0,[m_retailtrigbase]
	ibt	r14,#64
	add	r14
	to	r14
	add	r2
	getb
	to	r5
	swap
	lm	r0,[m_retailtrigbase]
	to	r14
	add	r2
	getb
	to	r9
	swap
	with	r1
	to	r6
	from	r9
	to	r8
	lmult
	with	r4
	to	r7
	with	r3
	to	r6
	from	r5
	lmult
	with	r7
	add	r4
	adc	r8
	to	r2
	asr
	with	r3
	to	r6
	from	r9
	to	r8
	lmult
	with	r4
	to	r7
	with	r1
	to	r6
	from	r5
	lmult
	with	r7
	sub	r4
	sbc	r8
	to	r3
	asr
	with	r2
	to	r1
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; Geometry selects its asset ROM bank even when no contact group survives.
; Track the table address within that bank for a later cached response.
mretail_rawgeometry
	mpush	r11
	ibt	r0,#0
	romb
	ibt	r0,#$14
	add	r7
	to	r1
	ldw	[r0]
	with	r1
	from	r1
	beq	mrrg_bankzero
	nop
	ibt	r0,#12
	with	r0
	add	r1
	to	r14
	getb
	inc	r14
	getbh
	with	r0
	from	r0
	beq	mrrg_bankzero
	nop
	ibt	r0,#2
	with	r0
	add	r1
	to	r14
	getb
	with	r0
	from	r0
	beq	mrrg_bankzero
	nop
	iwt	r0,#$96fe
	bra	mrrg_bankstore
	nop
mrrg_bankzero
	iwt	r0,#sintab&WM
mrrg_bankstore
	sm	[m_retailtrigbase],r0
	link	#4
	iwt	pc,#mr6_call_mretail_shapegroups&WM
	nop
	mpop	r11
	move	pc,r11
	nop

; Group scans explicitly select bank zero, as in the retail entry.
mretail_applyrawgroups
	iwt	r0,#sintab&WM
	sm	[m_retailtrigbase],r0
	iwt	pc,#mr6_call_mretail_applygroups&WM
	nop

mr6_call_mretail_forceworld
	iwt	r12,#mretail_forceworld&WM
	iwt	pc,#mr6_far4&WM
	nop

mrupdate_end
