; Retail raw object allocation, destruction and vehicle construction, bank 5.
; RAM bank zero; aligned records and terminating heap/object/wheel lists.
; Bind initialized heap roots before use. This module does not reserve or
; resize heaps, and raw records must not be mixed with early CAR/WHL records.
; Object +04/+06 links, +08 heap owner and +18 contacts use the retail ABI.
; The shared polygon/geometry context is serialized with rendering.
; Scene-level ownership of the separate car/AI list remains with the caller.

mrheap_begin

; r1/r2 = initialized primary/secondary heap roots. They may be the same.
; Bind before construction; this does not clear heaps or the object lists.
mretail_bindrawheaps
	sm	[m_retailheap0],r1
	sm	[m_retailheap1],r2
	move	pc,r11
	nop

; US $04:893A.
; r3 = initialized heap, r4 = positive aligned size including its header
; (at least 32 bytes). Return r1 = cleared, linked raw object or zero.
mretail_allocobject
	from	r4
	stw	[r10]
	inc	r10
	inc	r10
	from	r3
	stw	[r10]
	inc	r10
	inc	r10
	cache
	with	r4
	to	r1
	from	r3
	stw	[r10]
	inc	r10
	inc	r10
mrrt_8949
	to	r2
	ldw	[r3]
	inc	r3
	inc	r3
	ldw	[r3]
	sub	r1
	beq	mrrt_896e
	nop
	with	r3
	from	r2
	bne	mrrt_8949
	nop
	dec	r10
	dec	r10
	to	r3
	ldw	[r10]
mrrt_895b
	to	r2
	ldw	[r3]
	inc	r3
	inc	r3
	ldw	[r3]
	sub	r1
	bpl	mrrt_8978
	nop
	with	r3
	from	r2
	bne	mrrt_895b
	nop
	ibt	r1,#$00
	bra	mrrt_8992
	nop
mrrt_896e
	dec	r10
	dec	r10
	ldw	[r10]
	with	r1
	not
	inc	r1
	sub	r0
	bra	mrrt_8989
	nop
mrrt_8978
	sub	#4
	bpl	mrrt_8986
	nop
	add	#4
	with	r1
	add	r0
	with	r1
	not
	inc	r1
	ibt	r0,#-4
mrrt_8986
	add	#4
	stw	[r3]
mrrt_8989
	from	r3
	to	r2
	add	r0
	from	r1
	stw	[r2]
	dec	r2
	dec	r2
	with	r2
	to	r1
mrrt_8992
	dec	r10
	dec	r10
	to	r3
	ldw	[r10]
	dec	r10
	dec	r10
	to	r4
	ldw	[r10]
	with	r1
	from	r1
	beq	mrrt_89f7
	nop
	lm	r0,[m_retailheap0]
	cmp	r3
	bne	mrrt_89a7
	nop
mrrt_89a7
	lm	r0,[m_retailheap1]
	cmp	r3
	bne	mrrt_89af
	nop
mrrt_89af
	iwt	r2,#$0002
	with	r2
	add	r1
	ldw	[r2]
	inc	r2
	inc	r2
	with	r0
	from	r0
	bpl	mrrt_89be
	nop
	not
	inc	r0
mrrt_89be
	sub	#4
	beq	mrrt_89d0
	nop
	bmi	mrrt_89d0
	nop
	with	r0
	to	r12
	sub	r0
	with	pc
	to	r13
	stb	[r2]
	inc	r2
	loop
	nop
mrrt_89d0
	ibt	r0,#$08
	add	r1
	from	r3
	stw	[r0]
	lm	r2,[m_objects]
	ibt	r0,#$04
	add	r1
	from	r2
	stw	[r0]
	sm	[m_objects],r1
	with	r2
	from	r2
	beq	mrrt_89ec
	nop
	ibt	r0,#$06
	add	r2
	from	r1
	stw	[r0]
mrrt_89ec
	ibt	r2,#$1c
	with	r2
	add	r1
	to	r2
	ldw	[r2]
	iwt	r0,#$0004
	or	r2
	sbk
mrrt_89f7
	with	r11
	to	pc
	nop

; US $04:8A08.
; r1 = raw object. Release contacts and owned wheels, unlink the object
; list and return its block to the saved heap. The car/AI list has separate
; scene ownership; this entry retains the native object-release contract.
mretail_releaseobject
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r0,#$18
	add	r1
	ldw	[r0]
	with	r0
	from	r0
	beq	mrrt_8a29
	nop
	from	r8
	stw	[r10]
	inc	r10
	inc	r10
	with	r1
	to	r6
	link	#4
	iwt	pc,#mr5_call_mretail_clearrawcontacts&WM
	nop
	link	#4
	iwt	pc,#mr5_call_mretail_sweeprawcontacts&WM
	nop
	dec	r10
	dec	r10
	to	r8
	ldw	[r10]
mrrt_8a29
	ibt	r0,#$16
	add	r1
	ldw	[r0]
	iwt	r2,#$0002
	and	r2
	beq	mrrt_8a39
	nop
	link	#4
	iwt	pc,#mretail_releasewheels&WM
	nop
mrrt_8a39
	ibt	r2,#$06
	with	r2
	add	r1
	to	r2
	ldw	[r2]
	ibt	r3,#$04
	with	r3
	add	r1
	to	r3
	ldw	[r3]
	with	r2
	from	r2
	beq	mrrt_8a52
	nop
	ibt	r0,#$04
	add	r2
	from	r3
	stw	[r0]
	bra	mrrt_8a56
	nop
mrrt_8a52
	sm	[m_objects],r3
mrrt_8a56
	with	r3
	from	r3
	beq	mrrt_8a60
	nop
	ibt	r0,#$06
	add	r3
	from	r2
	stw	[r0]
mrrt_8a60
	ibt	r3,#$08
	with	r3
	add	r1
	to	r3
	ldw	[r3]
	inc	r1
	inc	r1
	ldw	[r1]
	with	r2
	from	r0
	bpl	mrrt_8a71
	nop
	with	r2
	not
	inc	r2
mrrt_8a71
	lm	r0,[m_retailheap0]
	cmp	r3
	bne	mrrt_8a79
	nop
mrrt_8a79
	lm	r0,[m_retailheap1]
	cmp	r3
	bne	mrrt_8a81
	nop
mrrt_8a81
	dec	r1
	dec	r1
	ibt	r3,#$08
	with	r3
	add	r1
	to	r3
	ldw	[r3]
	with	r1
	to	r2
	inc	r2
	inc	r2
	ldw	[r2]
	with	r0
	from	r0
	bpl	mrrt_8a99
	nop
	not
	inc	r0
	stw	[r2]
	bra	mrrt_8a9d
	nop
mrrt_8a99
	ldw	[r3]
	stw	[r1]
	from	r1
	stw	[r3]
mrrt_8a9d
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:8AA2.
mretail_releasewheels
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	ibt	r4,#$3e
	with	r4
	add	r1
	to	r4
	ldw	[r4]
mrrt_8ab0
	with	r4
	from	r4
	beq	mrrt_8ac7
	nop
	with	r4
	to	r1
	ibt	r4,#$34
	with	r4
	add	r1
	to	r4
	ldw	[r4]
	link	#4
	iwt	pc,#mretail_releaseobject&WM
	nop
	with	r4
	to	r1
	bra	mrrt_8ab0
	nop
mrrt_8ac7
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:8CC6. GSU task: m_dynvar1 supplies a compiled definition pointer.
; Select one of the nine known definitions; retain the native fallback.
; Position uses m_x1/m_y1/m_z1, yaw m_bigy, mode m_dynvar2, tag m_dynvar3,
; and alternate-shape selection the low byte of m_retailspawnflags.
; Result m_dynvar1 is the allocated car or zero. Shape identity/tag and
; descriptor indexes are returned in the shared words; CPU shape binding
; is separate. This task sets its software stack and ends with STOP.
mretail_spawncar
	iwt	r10,#m_stack&WM
	iwt	r0,#rcardefs_begin>>16
	romb
	lm	r14,[m_dynvar1]
	iwt	r0,#rcar81b9&WM
	cmp	r14
	bne	mrrt_8cde
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8cde
	nop
	iwt	r0,#rcar853d&WM
	cmp	r14
	bne	mrrt_8ceb
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8ceb
	nop
	iwt	r0,#rcar82e5&WM
	cmp	r14
	bne	mrrt_8cf8
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8cf8
	nop
	iwt	r0,#rcar8411&WM
	cmp	r14
	bne	mrrt_8d05
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8d05
	nop
	iwt	r0,#rcar8669&WM
	cmp	r14
	bne	mrrt_8d12
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8d12
	nop
	iwt	r0,#rcar876e&WM
	cmp	r14
	bne	mrrt_8d1f
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8d1f
	nop
	iwt	r0,#rcar8aa8&WM
	cmp	r14
	bne	mrrt_8d2c
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8d2c
	nop
	iwt	r0,#rcar8886&WM
	cmp	r14
	bne	mrrt_8d39
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8d39
	nop
	iwt	r0,#rcar8990&WM
	cmp	r14
	bne	mrrt_8d46
	nop
	iwt	pc,#mretail_makecar&WM
	nop
mrrt_8d46
	nop
	sm	[m_retaildefinition],r14
	iwt	r14,#rcar81b9&WM

; US $04:8D4E. Constructor interior: r14 points to the compiled header,
; its ROM bank is already selected and r10 names a valid software stack.
mretail_makecar
	iwt	r4,#$0098
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mretail_allocobject&WM
	nop
	sm	[m_dynvar1],r1
	with	r1
	from	r1
	bne	mrrt_8d66
	nop
	iwt	pc,#mrrt_8e82&WM
	nop
mrrt_8d66
	lm	r2,[m_dynvar3]
	iwt	r0,#$0096
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_x1]
	ibt	r0,#$1e
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_y1]
	ibt	r0,#$20
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_z1]
	ibt	r0,#$22
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_bigy]
	ibt	r0,#$24
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_dynvar2]
	ibt	r0,#$64
	add	r1
	from	r2
	stw	[r0]
	with	r14
	to	r2
	ibt	r0,#$66
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#mretail_updatecar&WM
	ibt	r0,#$0a
	add	r1
	from	r2
	stw	[r0]
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
	sm	[m_dynvar2],r2
	lm	r0,[m_retailspawnflags]
	lob
	beq	mrrt_8dca
	nop
	sm	[m_dynvar2],r3
mrrt_8dca
	getb
	inc	r14
	sm	[m_retailshapetag],r0
	getb
	inc	r14
	getbh
	inc	r14
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$5a
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$5c
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$16
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$40
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$1a
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$0c
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$0e
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$10
	add	r1
	from	r2
	stw	[r0]
	iwt	r0,#(rcardefs_begin-$a4)&WM
	from	r14
	sub	r0
	sm	[m_retailarg4],r0
	with	r14
	add	#10
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$2a
	add	r1
	from	r2
	stw	[r0]
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	ibt	r0,#$14
	add	r1
	from	r2
	stw	[r0]
	lm	r0,[m_avoidcarhead]
	with	r2
	from	r0
	bne	mrrt_8e69
	nop
	sm	[m_avoidcarhead],r1
	bra	mrrt_8e72
	nop
mrrt_8e69
	ibt	r0,#$74
	add	r1
	from	r2
	stw	[r0]
	sm	[m_avoidcarhead],r1
mrrt_8e72
	link	#4
	iwt	pc,#mretail_buildwheels&WM
	nop
	sm	[m_testcar1],r1
	with	r1
	to	r8
	link	#4
	iwt	pc,#mr5_call_mretail_setupwheels&WM
	nop

; US $04:8E82.
mrrt_8e82
	stop
	nop

; US $04:8E84.
mretail_allocwheel
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	from	r1
	stw	[r10]
	inc	r10
	inc	r10
	iwt	r4,#$0052
	lm	r3,[m_retailheap0]
	link	#4
	iwt	pc,#mretail_allocobject&WM
	nop
	with	r1
	to	r2
	dec	r10
	dec	r10
	to	r1
	ldw	[r10]
	with	r2
	from	r2
	bne	mrrt_8ea6
	nop
	iwt	pc,#mrrt_8f43&WM
	nop
mrrt_8ea6
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	ibt	r0,#$12
	add	r2
	from	r3
	stw	[r0]
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	with	r3
	not
	inc	r3
	ibt	r0,#$3c
	add	r2
	from	r3
	stw	[r0]
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	ibt	r0,#$3e
	add	r2
	from	r3
	stw	[r0]
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	ibt	r0,#$40
	add	r2
	from	r3
	stw	[r0]
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	ibt	r0,#$44
	add	r2
	from	r3
	stw	[r0]
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
	ibt	r0,#$50
	add	r2
	from	r3
	stw	[r0]
	to	r3
	getb
	inc	r14
	with	r3
	getbh
	inc	r14
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
	iwt	r3,#$0014
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
	iwt	r0,#$0004
	to	r3
	or	r3
	ibt	r0,#$16
	add	r2
	from	r3
	stw	[r0]
	lm	r3,[m_x1]
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

; US $04:8F43.
mrrt_8f43
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; US $04:8F48.
mretail_buildwheels
	from	r11
	stw	[r10]
	inc	r10
	inc	r10
	sub	r0
	getb
	inc	r14
	to	r2
	getb
	inc	r14
	with	r2
	getbh
	inc	r14
	sm	[m_x1],r2
	with	r12
	from	r0
	beq	mrrt_8f78
	nop
	with	pc
	to	r13
	from	r13
	stw	[r10]
	inc	r10
	inc	r10
	from	r12
	stw	[r10]
	inc	r10
	inc	r10
	link	#4
	iwt	pc,#mretail_allocwheel&WM
	nop
	dec	r10
	dec	r10
	to	r12
	ldw	[r10]
	dec	r10
	dec	r10
	to	r13
	ldw	[r10]
	loop
	nop
mrrt_8f78
	iwt	r0,#(rcardefs_begin-$a4)&WM
	from	r14
	sub	r0
	sm	[m_dynvar3],r0
	sub	r0
	getb
	inc	r14
	ibt	r6,#$05
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
	iwt	r0,#$008c
	add	r1
	from	r2
	stw	[r0]
	lm	r2,[m_retailrouteword]
	iwt	r0,#$008a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0000
	ibt	r0,#$7a
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0002
	iwt	r0,#$0086
	add	r1
	from	r2
	stw	[r0]
	iwt	r2,#$0001
	ibt	r0,#$58
	add	r1
	from	r2
	stw	[r0]
	dec	r10
	dec	r10
	to	pc
	ldw	[r10]
	nop

; Complete 2048-byte native atan read window, including overflow indexes.
; Native signed -32768 can index beyond the mathematical table.
mretail_atanwindow
	dw	$0000,$0020,$0050,$0070,$00a0,$00c0,$00f0,$0110
	dw	$0140,$0160,$0190,$01b0,$01e0,$0210,$0230,$0260
	dw	$0280,$02b0,$02d0,$0300,$0320,$0350,$0370,$03a0
	dw	$03c0,$03f0,$0410,$0440,$0470,$0490,$04c0,$04e0
	dw	$0510,$0530,$0560,$0580,$05b0,$05d0,$0600,$0620
	dw	$0650,$0670,$06a0,$06c0,$06e0,$0710,$0730,$0760
	dw	$0780,$07b0,$07d0,$0800,$0820,$0850,$0870,$0890
	dw	$08c0,$08e0,$0910,$0930,$0960,$0980,$09a0,$09d0
	dw	$09f0,$0a20,$0a40,$0a60,$0a90,$0ab0,$0ad0,$0b00
	dw	$0b20,$0b50,$0b70,$0b90,$0bc0,$0be0,$0c00,$0c30
	dw	$0c50,$0c70,$0ca0,$0cc0,$0ce0,$0d00,$0d30,$0d50
	dw	$0d70,$0da0,$0dc0,$0de0,$0e00,$0e30,$0e50,$0e70
	dw	$0e90,$0ec0,$0ee0,$0f00,$0f20,$0f40,$0f70,$0f90
	dw	$0fb0,$0fd0,$0ff0,$1020,$1040,$1060,$1080,$10a0
	dw	$10c0,$10e0,$1110,$1130,$1150,$1170,$1190,$11b0
	dw	$11d0,$11f0,$1210,$1230,$1260,$1280,$12a0,$12c0
	dw	$12e0,$1300,$1320,$1340,$1360,$1380,$13a0,$13c0
	dw	$13e0,$1400,$1420,$1440,$1460,$1480,$14a0,$14c0
	dw	$14e0,$14f0,$1510,$1530,$1550,$1570,$1590,$15b0
	dw	$15d0,$15f0,$1610,$1620,$1640,$1660,$1680,$16a0
	dw	$16c0,$16d0,$16f0,$1710,$1730,$1750,$1770,$1780
	dw	$17a0,$17c0,$17e0,$17f0,$1810,$1830,$1850,$1860
	dw	$1880,$18a0,$18c0,$18d0,$18f0,$1910,$1920,$1940
	dw	$1960,$1970,$1990,$19b0,$19c0,$19e0,$1a00,$1a10
	dw	$1a30,$1a50,$1a60,$1a80,$1a90,$1ab0,$1ad0,$1ae0
	dw	$1b00,$1b10,$1b30,$1b50,$1b60,$1b80,$1b90,$1bb0
	dw	$1bc0,$1be0,$1bf0,$1c10,$1c20,$1c40,$1c50,$1c70
	dw	$1c80,$1ca0,$1cb0,$1cd0,$1ce0,$1d00,$1d10,$1d30
	dw	$1d40,$1d60,$1d70,$1d80,$1da0,$1db0,$1dd0,$1de0
	dw	$1df0,$1e10,$1e20,$1e40,$1e50,$1e60,$1e80,$1e90
	dw	$1ea0,$1ec0,$1ed0,$1ef0,$1f00,$1f10,$1f30,$1f40
	dw	$1f50,$1f60,$1f80,$1f90,$1fa0,$1fc0,$1fd0,$1fe0
	dw	$0000,$0000,$0000,$0200,$0000,$0088,$0088,$0090
	dw	$00bc,$8f91,$a040,$a040,$a040,$a040,$8000,$060c
	dw	$0080,$0200,$0000,$0020,$0040,$0040,$0048,$8f91
	dw	$a05c,$a05c,$a05c,$a05c,$8000,$060c,$5080,$02fb
	dw	$0000,$0020,$0040,$0040,$0048,$8f91,$a078,$a078
	dw	$a078,$a078,$8000,$060c,$0080,$0200,$0000,$0020
	dw	$0040,$0040,$0048,$8f91,$a094,$a094,$a094,$a094
	dw	$8000,$060c,$0080,$0200,$0000,$0020,$0040,$0040
	dw	$0048,$8f91,$a0b0,$a0b0,$a0b0,$a0b0,$8000,$060c
	dw	$0080,$0200,$0000,$0020,$0040,$0040,$0048,$8f91
	dw	$a0cc,$a0cc,$a0cc,$a0cc,$8000,$060c,$0080,$0300
	dw	$0000,$0040,$0080,$0080,$0090,$8f91,$a0e8,$a0e8
	dw	$a0e8,$a0e8,$8000,$060c,$4080,$041f,$0000,$0080
	dw	$0100,$0100,$0120,$8f91,$a104,$a104,$a104,$a104
	dw	$8000,$060c,$8080,$040c,$0000,$0080,$0100,$0100
	dw	$0120,$8f91,$a120,$a120,$a120,$a120,$8000,$060c
	dw	$0080,$0500,$0000,$0100,$0200,$0200,$0240,$8f91
	dw	$a13c,$a13c,$a13c,$a13c,$8000,$060c,$0080,$0100
	dw	$0000,$0010,$0020,$0020,$0024,$8f91,$a158,$a158
	dw	$a158,$a158,$8000,$060c,$0080,$0000,$0000,$0008
	dw	$0010,$0010,$0012,$8f91,$a174,$a174,$a174,$a174
	dw	$8000,$060c,$6480,$0100,$0000,$0010,$0020,$0020
	dw	$0024,$8f91,$a190,$a190,$a190,$a190,$8000,$060c
	dw	$9c80,$01ff,$0000,$0010,$0020,$0020,$0024,$8f91
	dw	$a1ac,$a1ac,$a1ac,$a1ac,$8000,$060c,$0080,$0100
	dw	$0000,$0010,$0020,$0020,$0024,$8f91,$a1c8,$a1c8
	dw	$a1c8,$a1c8,$8000,$060c,$e880,$0103,$0000,$0010
	dw	$0020,$0020,$0024,$8f91,$a1e4,$a1e4,$a1e4,$a1e4
	dw	$8009,$330c,$0080,$0100,$0000,$0048,$005c,$009e
	dw	$00ac,$8f91,$a200,$a200,$a200,$a200,$8189,$9e0c
	dw	$c881,$0100,$0000,$004a,$0000,$00c8,$00c8,$8f91
	dw	$a21c,$a21c,$a21c,$a21c,$81c5,$d10c,$0081,$0100
	dw	$0000,$0044,$0000,$00a0,$00aa,$8f91,$a238,$a238
	dw	$a238,$a238,$81eb,$fa0c,$0081,$0100,$0000,$0050
	dw	$0000,$0082,$008c,$8f91,$a254,$a254,$a254,$a254
	dw	$8222,$3a0c,$0082,$0100,$0000,$0048,$0000,$009e
	dw	$00a0,$8f91,$a270,$a270,$a270,$a270,$8272,$b00c
	dw	$0082,$0100,$0000,$0044,$0080,$00a0,$00b2,$8f91
	dw	$a28c,$a28c,$a28c,$a28c,$8491,$be0c,$0084,$0100
	dw	$0000,$0050,$006e,$008a,$009c,$8f91,$a2a8,$a2a8
	dw	$a2a8,$a2a8,$8655,$610c,$0086,$0300,$0000,$0000
	dw	$0050,$0190,$0190,$8f91,$a2c4,$a2c4,$a2c4,$a2c4
	dw	$8680,$8f0c,$0086,$0400,$0000,$0320,$0320,$0320
	dw	$0320,$8f91,$a2e0,$a2e0,$a2e0,$a2e0,$86b0,$e50c
	dw	$0086,$0200,$0000,$007c,$00a0,$00f0,$0108,$8f91
	dw	$a2fc,$a2fc,$a2fc,$a2fc,$8909,$180c,$0089,$0100
	dw	$0000,$0028,$0022,$0044,$004a,$8f91,$a318,$a318
	dw	$a318,$a318,$8976,$910c,$0089,$0100,$0000,$001a
	dw	$0028,$0046,$0054,$8f91,$a334,$a334,$a334,$a334
	dw	$89fb,$160c,$008a,$0100,$0000,$001a,$0028,$0046
	dw	$0054,$8f91,$a350,$a350,$a350,$a350,$8a80,$920c
	dw	$008a,$0100,$0000,$0028,$0048,$0046,$005a,$8f91
	dw	$a36c,$a36c,$a36c,$a36c,$8b30,$3f0c,$008b,$0100
	dw	$0000,$0020,$0026,$000a,$0032,$8f91,$a388,$a388
	dw	$a388,$a388,$8b9d,$a60c,$008b,$0100,$0000,$0034
	dw	$0006,$0020,$003e,$8f91,$a3a4,$a3a4,$a3a4,$a3a4
	dw	$8bde,$ed0c,$008b,$0100,$0000,$0044,$0020,$0032
	dw	$005a,$8f91,$a3c0,$a3c0,$a3c0,$a3c0,$8c4b,$5a0c
	dw	$008c,$0100,$0000,$0044,$001e,$002e,$0056,$8f91
	dw	$a3dc,$a3dc,$a3dc,$a3dc,$8cd3,$e20c,$008c,$0100
	dw	$0000,$0044,$0022,$0064,$007e,$8f91,$a3f8,$a3f8
	dw	$a3f8,$a3f8,$8d40,$510c,$008d,$0100,$0000,$001c
	dw	$0020,$0072,$007a,$8f91,$a414,$a414,$a414,$a414
	dw	$8d9f,$b40c,$008d,$0100,$0000,$0044,$0026,$0028
	dw	$0058,$8f91,$a430,$a430,$a430,$a430,$8e3e,$500c
	dw	$008e,$0100,$0000,$0044,$0024,$0012,$004e,$8f91
	dw	$a44c,$a44c,$a44c,$a44c,$8ed6,$e80c,$008e,$0100
	dw	$0000,$0050,$0030,$0036,$005a,$8f91,$a468,$a468
	dw	$a468,$a468,$8f6e,$800c,$008f,$0100,$0000,$0034
	dw	$001a,$004c,$0060,$8f91,$a484,$a484,$a484,$a484
	dw	$8fee,$110c,$0090,$0100,$0000,$002e,$0028,$0050
	dw	$0060,$8f91,$a4a0,$a4a0,$a4a0,$a4a0,$90a7,$ca0c
	dw	$0090,$0100,$0000,$002e,$0028,$0050,$0060,$8f91
	dw	$a4bc,$a4bc,$a4bc,$a4bc,$9160,$720c,$0091,$0100
	dw	$0000,$0050,$002c,$0014,$0050,$8f91,$a4d8,$a4d8
	dw	$a4d8,$a4d8,$91f8,$040c,$0092,$0100,$0000,$0034
	dw	$0014,$0014,$003a,$8f91,$a4f4,$a4f4,$a4f4,$a4f4
	dw	$9240,$5b0c,$0092,$04e7,$0000,$01e0,$01e0,$00a0
	dw	$02c0,$8f91,$a510,$a510,$a510,$a510,$9341,$500c
	dw	$0093,$04e7,$0000,$00c0,$01e0,$00a0,$0220,$8f91
	dw	$a52c,$a52c,$a52c,$a52c,$93ae,$cf0c,$0093,$04e7
	dw	$0000,$01e0,$01e0,$00a0,$02c0,$8f91,$a548,$a548
	dw	$a548,$a548,$94a1,$e00c,$0094,$04e7,$0000,$01e0
	dw	$01e0,$00a0,$02c0,$8f91,$a564,$a564,$a564,$a564
	dw	$95b2,$e70c,$0095,$04e7,$0000,$01e0,$01e0,$00a0
	dw	$02c0,$8f91,$a580,$a580,$a580,$a580,$96ed,$380c
	dw	$0097,$04e7,$0000,$01a0,$01e0,$00a0,$0290,$8f91
	dw	$a59c,$a59c,$a59c,$a59c,$983e,$6d0c,$0098,$04e7
	dw	$0000,$01c0,$01e0,$00a0,$02a0,$8f91,$a5b8,$a5b8
	dw	$a5b8,$a5b8,$9963,$8c0c,$0099,$04e7,$0000,$01e0
	dw	$01e0,$00a0,$02c0,$8f91,$a5d4,$a5d4,$a5d4,$a5d4
	dw	$9a2e,$3f0c,$009a,$0200,$0000,$0008,$0020,$0008
	dw	$0020,$8f91,$a5f0,$a5f0,$a5f0,$a5f0,$9a88,$970c
	dw	$009a,$0200,$0000,$0028,$0018,$001c,$0034,$8f91
	dw	$a60c,$a60c,$a60c,$a60c,$9af0,$050c,$009b,$0200
	dw	$0000,$003c,$0010,$003c,$004c,$8f91,$a628,$a628

mr5_call_mretail_clearrawcontacts
	iwt	r12,#mretail_clearrawcontacts&WM
	iwt	pc,#mr5_far4&WM
	nop

mr5_call_mretail_setupwheels
	iwt	r12,#mretail_setupwheels&WM
	iwt	pc,#mr5_far4&WM
	nop

mr5_call_mretail_sweeprawcontacts
	iwt	r12,#mretail_sweeprawcontacts&WM
	iwt	pc,#mr5_far4&WM
	nop

mr5_far4
	mpush	r11
	iwt	r11,#mretail_heapreturn4&WM
	iwt	r13,#4
	from	r12
	ljmp	r13
	nop

mrhp_farreturn5
	mpop	r11
	move	pc,r11
	nop

mretail_heapreturn5
	iwt	r13,#6
	iwt	r12,#mrrt_farreturn6&WM
	from	r12
	ljmp	r13
	nop

mrheap_end

; US $04:89FA. CPU-submitted release task; the raw pointer is supplied
; in m_dynvar1. Scene ownership of car/AI links remains with the caller.
mrheaptask_begin
mretail_releaseobjecttask
	iwt	r10,#m_stack&WM
	lm	r1,[m_dynvar1]
	link	#4
	iwt	pc,#mretail_releaseobject&WM
	nop
	stop
	nop
mrheaptask_end
