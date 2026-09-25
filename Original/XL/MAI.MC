;    AI FOR XLR8
;
;         By 
;    Giles Goddard


	malc	m_aitest1,2

;*******************************************************************
; mdo_carAI - car artificial intelligence
;
; entry:
;	r8 : ptr. to car
;


rcarptr		=	r8
rcarflags	=	r4
rmactmp1	=	r3
rt3		=	r3
rsp		=	r10

mdo_carAI
;	move	pc,r11
;	nop
	mpush	r11

;	mloadw	rcarflags,CAR_FLAGS,rcarptr
;	mclrreg	rcarflags,(CARflag_steerLeft!CARflag_steerRight)

	mloadw	r1,OBJ_WORLDX,rcarptr
	mloadw	r2,OBJ_WORLDY,rcarptr
	mloadw	r3,OBJ_WORLDZ,rcarptr
	iwt	r4,#OBJTYPE_marker
	mcall	mfind_nearobj
	nop


	mtest	r5
	beq	.nnext			.nnear
	nop

	iwt	r4,#0			; stop 
	mloadw	r1,TOBJ_NEXT,r5
	mtest	r1
	beq	.nnext
	nop
	move	r5,r1
	iwt	r4,#200			; max speed
.nnext
	mstorew	r5,CAR_NEARMARKER,rcarptr
	
;	mloadw	r1,TOBJ_FLAGS,r5
;	msetreg	r1,TOBJflag_hitflash
;	mstorew	r1,TOBJ_FLAGS,r5

	mcall	mcar_aimfor
	nop

.nnear

	lm	r1,[m_aitest1]
	mstorew	r1,CAR_TEST1,rcarptr

	
;	mloadw	rcarflags,CAR_FLAGS,rcarptr
;	msetreg	rcarflags,CARflag_Accel
;	mstorew	rcarflags,CAR_FLAGS,rcarptr


	mloadw	r0,CAR_HANDOBJ,rcarptr
	mtest	r0
	beq	.nhanddir
	nop
	mloadw	r0,OBJ_ROTY,rcarptr
	move	rt3,r0
	sub	r1
	div2	
	div2
	with	rt3
	sub	r0
	mstorew	rt3,OBJ_ROTY,rcarptr
.nhanddir


	mpop	pc
	nop

;************************************************************************
; mcar_aimfor	; make car aim for an object.
;
; entry:
;	r8 = ptr. to car
;	r5 = ptr. to object
;	r4 = max speed

rcarptr		=	r8
robjptr		=	r5
rcarflags	=	r9
rmaxspeed	=	r4

mcar_aimfor
	mpush	r11

	mpush	r4


	mcall	mobj2obj_Yangle
	nop


	move	r1,r0
	mloadw	r0,OBJ_ROTY,rcarptr
	with	r1
	sub	r0

	mpop	r4
	mloadw	rcarflags,CAR_FLAGS,rcarptr
	iwt	r0,#CARflag_makestop
	and	rcarflags
	mlbne	.donespeed
	mclrreg	rcarflags,CARflag_Accel!CARflag_Brake!CARflag_dynoff!CARflag_boost

	iwt	r2,#-deg22*256		
	iwt	r3,#deg22*256
	mrange	r1,r2,r3,.brake

	mtest	r4
	bne	.nbrake
	nop
;	msetreg	rcarflags,CARflag_hitflash
;	msetreg	rcarflags,CARflag_dynoff
;	msetreg	rcarflags,CARflag_invisible
;	msetreg	rcarflags,CARflag_makestop
	msetreg	rcarflags,CARflag_Accel
	bra	.end
	nop
.brake
	msetreg	rcarflags,CARflag_Brake
;	msetreg	rcarflags,CARflag_hitflash
	bra	.naccel
	nop
.nbrake
;	mclrreg	rcarflags,CARflag_hitflash
	mcar_jmp_faster	r4,.naccel
	msetreg	rcarflags,CARflag_Accel
;	msetreg	rcarflags,CARflag_boost
.naccel
	

	mcar_jmp_faster	#50,.ndead
	msetreg	rcarflags,CARflag_Accel
	mclrreg	rcarflags,CARflag_Brake
;	mclrreg	rcarflags,CARflag_hitflash
.ndead

	mstorew	r1,CAR_ENGINEROTY,rcarptr
.end


	mstorew	rcarflags,CAR_FLAGS,rcarptr


.donespeed
	mpop	pc
	nop



;************************************************************************
; mget_best_line	- get best angle for wheels to be in
;
; entry:
;	r8 = ptr. to car
;	r1 = maximum angle
; exit:
;	r1 = wheel angle
; uses:
;	probably all
;


rcarptr		=	r8
robjptr		=	r5

mget_best_line
	mpush	r11
	
	mpush	r1

	mloadw	r1,OBJ_WORLDX,rcarptr
	mloadw	r2,OBJ_WORLDY,rcarptr
	mloadw	r3,OBJ_WORLDZ,rcarptr
;	iwt	r4,#OBJTYPE_road
	iwt	r4,#OBJTYPE_marker
	mcall	mfind_nearobj
	nop


	mtest	r5
	beq	.nnear
	nop
	mloadw	r1,TOBJ_NEXT,r5
	mtest	r1
	beq	.nnext
	nop
	move	r5,r1
.nnext
	mstorew	r5,CAR_NEARMARKER,rcarptr


	mcall	mobj2obj_Yangle
	nop

	move	r1,r0
	mloadw	r0,OBJ_ROTY,rcarptr
	with	r1
	sub	r0

	mpop	r3
	move	r2,r3
	mneg	r2
	mrange	r1,r2,r3

	mpop	pc
	nop


.nnear
	mpop	r0
	iwt	r1,#0
	mpop	pc
	nop
	



;************************************************************************
; mobj2obj_Yangle - calculate Y angle between 2 objects.
;
; entry:
;	r8 = object 1
;	r5 = object 2
; exit:
;	r8 = object 1
;	r0 = Y angle
;
; uses: r3-r6,r12,r13
;

robj1ptr		=	r8
robj2ptr		=	r5

mobj2obj_Yangle
	mpush	r11

	mloadw	r1,OBJ_WORLDX,robjptr
	mloadw	r2,OBJ_WORLDZ,robjptr
	
	mloadw	r0,OBJ_WORLDX,robj1ptr
	with	r1
	sub	r0

	mloadw	r0,OBJ_WORLDZ,robj1ptr
	with	r2
	sub	r0

	mcall	marctan16
	nop
	mneg	r0
	mpop	pc
	nop




;************************************************************************
; mfind_nearobj	- find nearest object to world position in r1-r3.
;
; entry:
;	r1-r3  	= obj1 position
;	r4	= type ON mask (only check objects with this type flag set)
; exit:
;	r5	= ptr. to nearest object.	
;	r6	= estimated distance to nearest object.	
;
; trashes: r1-r7,r9
;

robjposx	=	r1
robjposy	=	r2
robjposz	=	r3
robjptr		=	r7
rclosestobj	=	r5
rclosestdist	=	r6
rt1		=	r9
rflagsonmask	=	r4

mfind_nearobj

	ibt	rclosestobj,#0
	iwt	rclosestdist,#32767

	sub	r0
	sm	[m_aitest1],r0

	lm	r0,[m_objects]
.loop
	moves	robjptr,r0
	beq	.noobjs
	nop

; check flags ON mask.
	mloadw	rt1,OBJ_TYPE,robjptr
	from	rt1
	and	rflagsonmask
	beq	.nextobj
	nop


	lm	r0,[m_aitest1]
	inc	r0
	sm	[m_aitest1],r0

	mloadw	r0,OBJ_WORLDX,robjptr
	sub	robjposx
	bpl	.nnegx
	nop
	mneg	r0
.nnegx	
	move	rt1,r0

	mloadw	r0,OBJ_WORLDZ,robjptr
	sub	robjposz
	bpl	.nnegz
	nop
	mneg	r0
.nnegz	
	from	rt1
	add	r0

	cmp	rclosestdist
	bpl	.nextobj
	nop
	move	rclosestdist,r0
	move	rclosestobj,robjptr

.nextobj
	mloadw	r0,OBJ_NEXT,robjptr
	bra	.loop
	nop
.noobjs

	move	pc,r11
	nop












;******************************************************************************







	ifeq	1
	mloadw	r0,OBJ_WORLDX,rcarptr
	iwt	r1,#0				-20<<track_scale
	iwt	r2,#-5<<track_scale
	iwt	r3,#5<<track_scale

	with	r2
	add	r1
	with	r3
	add	r1


	cmp	r2
	bmi	.steer
	nop
	cmp	r3
	bpl	.steer
	nop

	ibt	r1,#0
	mstorew	r1,OBJ_ROTY,rcarptr
	mstorew	r1,CAR_TORQUEY,rcarptr


.steer
	cmp	r1
	bmi	.left
     	nop
.right
	msetreg	rcarflags,CARflag_steerLeft
	bra	.donest
	nop

.left
	msetreg	rcarflags,CARflag_steerRight

.donest

	mclrreg	rcarflags,CARflag_Accel

	mloadw	r0,CAR_GNDSPEED,rcarptr
	iwt	r1,#200
	cmp	r1
	bpl	.naccel
	nop

	msetreg	rcarflags,CARflag_Accel
.naccel
	endc

;*******************************************************************
; Packed-route access, reconstructed from US $04:cc06 and $04:cd56.
; These use the terminal maproute table, not early linked marker objects.
; r10 = GSU stack, r11 = return address; RAM bank 0 on entry.
; ROM bank is left at m_routebank. Names reconstructed.
;
; CAR_ROUTEINDEX stores the retail point index separately from the early
; CAR_NEARMARKER object pointer. The early AI still uses linked markers.
; TODO: Restore the route-mode producers, steering and dispatch paths.

; US $04:c3b5-$04:c3d4. r8 = car, returns mfind_nearroute's result.
; Preserve r8/r10; r11 and the search scratch registers are destroyed.
mfind_carroute
	mpush	r11
	mloadw	r1,OBJ_WORLDX,r8
	mloadw	r2,OBJ_WORLDY,r8
	mloadw	r3,OBJ_WORLDZ,r8
	mcall	mfind_nearroute
	nop
	mpop	pc
	nop

; Bearing from a car to a route point, US $04:cbe8-$04:cc05.
; r8 = car, r1/r3 = target world X/Z; input r2 (Y) is ignored.
; r0 = negated marctan16(X delta / Z delta), modulo 65536.
; Differences wrap as signed words; retain the original zero-vector
; result ($c000) and the existing arctangent's integer rounding.
; r1 = X delta, r2/r3 = Z delta on return. r4-r6/r11-r13 scratch;
; r7-r10/r14 preserved, RAM bank 0. The arctangent selects ROM bank 0
; when reading its table; axis/equal-magnitude shortcuts retain the bank.
; The early marctan16, divider and arctangent table match retail.
; FIXME: A delta of -32768 can make the original marctan16 read
; beyond its 256-word table. Those results depend on surrounding ROM
; data and do not match retail until that data/layout is restored.
; TODO: Restore the steering consumer at $04:c7d5 and its mode fields.
mcar2point_Yangle
	mpush	r11
	mloadw	r0,OBJ_WORLDX,r8
	with	r1
	sub	r0
	mloadw	r0,OBJ_WORLDZ,r8
	with	r3
	sub	r0
	move	r2,r3
	mcall	marctan16
	nop
	mneg	r0
	mpop	pc
	nop


; Heading and signed scale to planar vector, US $04:cd98-$04:cdc9.
; r0 = angle (high byte selects table entry), r4 = signed scale.
; r1/r3 = X/Z components, r2 = 0. The retail path reads the full
; 256-byte range following each of the original sine/cosine labels;
; both ranges match the US ROM. Integer fmult/shift/negation retained.
; r0/r3/r6/r14 and flags scratch; r4/r7-r13 preserved, RAM untouched.
; Selects ROM bank 0; r14 ends at costab + angle-high-byte.
; No sign/range guard for the scale, just the retail 16-bit arithmetic.
; Its velocity consumer is restored below as mcarheadingvelocity.
mheadingvector
	hib
	move	r3,r0
	ibt	r0,#0
	romb
	move	r6,r4
	move	r0,r3
	lob
	miwt	r14,sintab
	to	r14
	add	r14
	getb
	swap
	fmult
	mneg	r0
	add	r0
	add	r0
	add	r0
	add	r0
	move	r1,r0
	move	r0,r3
	lob
	miwt	r14,costab
	to	r14
	add	r14
	getb
	swap
	fmult
	add	r0
	add	r0
	add	r0
	add	r0
	move	r3,r0
	ibt	r2,#0
	move	pc,r11
	nop


; Car velocity from heading and supplied scale, US $04:c764-$04:c780.
; The caller at $04:c74a calculates r4 from the route's speed and a
; retail table; this entry expects that scale already in r4.
; r8 = car. Read its yaw and replace X/Y/Z velocity with the vector
; returned by mheadingvector. The early fields map retail car $24
; to OBJ_ROTY and car $2e/$30/$32 to OBJ_VELX/Y/Z.
; r0-r3/r6/r11/r14 scratch; r4/r7-r10/r12/r13 preserved, RAM bank 0.
; The original tail pops its caller's return frame. This callable
; extraction provides that frame locally while preserving the body.
; The route-speed scale and complete indexed route path are restored
; below; their enclosing AI mode condition remains to be identified.
mcarheadingvelocity
	mpush	r11
	mloadw	r0,OBJ_ROTY,r8
	mcall	mheadingvector
	nop
	mstorew	r1,OBJ_VELX,r8
	mstorew	r2,OBJ_VELY,r8
	mstorew	r3,OBJ_VELZ,r8
	mpop	pc
	nop


; Map-specific route-speed multipliers, US $04:c781-$04:c7d4.
; One signed 1.15 value per retail map number (0-41). The CPU scene
; loader copies map_number to m_mapnumber when binding the route.
mroute_speedscales
	dw	$4ca4,$4ca4,$4ca4,$4ca4
	dw	$72f6,$72f6,$72f6,$72f6
	dw	$7d2e,$7d2e,$7d2e,$7d2e
	rept	30
	dw	$4ca4
	endr

; Scale a route point's desired speed, US $04:c74a-$04:c763.
; r4 = desired speed; returns r4 = high word of
; (2 * desired speed) * signed 1.15 map multiplier.
; m_mapnumber supplies the original low-byte table index. No range
; guard is added: values above 41 retain retail's unchecked ROM read.
; r0/r6/r14 and flags scratch; r1-r3/r5/r7-r13 preserved, RAM bank 0.
; Selects ROM bank 4 in retail and this routine's linked bank here.
; r14 ends at the selected multiplier's high byte.
mroute_speedscale
	ibt	r0,#mroute_speedscales>>16
	romb
	lm	r0,[m_mapnumber]
	lob
	add	r0
	miwt	r14,mroute_speedscales
	with	r14
	add	r0
	mgetw	r6
	from	r4
	add	r4
	fmult
	move	r4,r0
	move	pc,r11
	nop


; Drive a car directly from its current packed-route point,
; reconstructed from US $04:c72f-$04:c780.
; r8 = car, CAR_ROUTEINDEX = one-based point index. Index zero returns
; zero without reading the route or changing velocity. A nonzero index
; reads XYZ and desired speed, applies the map multiplier, converts the
; car yaw to a planar vector, then replaces OBJ_VELX/Y/Z.
; Success returns r0 = r8+OBJ_VELZ, r1/r2/r3 = new velocity,
; r4 = scaled speed, r5 = point ROM address, r6 = scaled speed and
; r14 = costab plus the yaw high byte. r7-r10/r12/r13 are preserved;
; r11 is call scratch, RAM bank 0 and ROM bank 0 on successful return.
; Point and table arithmetic retains retail's unchecked 16-bit wrap.
; TODO: Connect this path when the enclosing retail route-mode field
; and its dispatcher at $04:c65a-$04:c72e have been reconstructed.
mroute_carvelocity
	mpush	r11
	mloadw	r0,CAR_ROUTEINDEX,r8
	mtest	r0
	bne	.route
	nop
	miwt	pc,.done&$ffff
	nop
.route
	mcall	mroutepointptr
	nop
	mcall	mreadroutepoint
	nop
	mcall	mroute_speedscale
	nop
	mcall	mcarheadingvelocity
	nop
.done
	mpop	pc
	nop


; Route steering prelude, reconstructed from US $04:c7d5-$04:c819.
; r8 = car, r1/r3 = target point X/Z and r4 = desired route speed.
; CAR_ROUTEMODE bit $20 reduces the desired speed to three quarters.
; Returns r1 = target bearing minus car yaw and r4 = adjusted speed.
; When CARflag_boost is set, OBJ_ROTZ is replaced by the retail damped
; value. r0/r2/r3/r5/r6/r11-r14 and flags scratch; r7-r10 preserved.
; RAM bank 0. mcar2point_Yangle may select ROM bank 0 for its table.
; FIXME: Extracted with a callable return; retail continues directly
; into the control-word selection at $04:c81a.
; TODO: Restore its $04:c933 common consumer.
mroute_steerprep
	mpush	r11
	mloadw	r0,CAR_ROUTEMODE,r8
	iwt	r5,#CARroutemode_slowspeed
	and	r5
	beq	.speed
	nop
	with	r4
	div2
	from	r4
	div2
	with	r4
	add	r0
.speed
	mpush	r4
	mcall	mcar2point_Yangle
	nop
	move	r1,r0
	mloadw	r0,OBJ_ROTY,r8
	with	r1
	sub	r0
	mloadw	r0,CAR_FLAGS,r8
	iwt	r2,#CARflag_boost
	and	r2
	beq	.done
	nop
	mloadw	r0,OBJ_ROTZ,r8
	with	r0
	to	r2
	div2
	div2
	with	r2
	sub	r0
	from	r2
	sbk
.done
	mpop	r4
	mpop	pc
	nop


; Route control selection, reconstructed from US $04:c81a-$04:c932.
; r8 = car, r1 = target bearing minus car yaw and r4 = desired speed.
; Produces CAR_CONTROL acceleration, brake and steering flags. The two
; route-AI counters inhibit acceleration and reverse a persistently stuck
; car. r4-r8 and r11 are preserved; r0-r3/r9 and flags scratch.
; RAM bank 0. CAR_AIDELAY/CAR_AISTUCK original source names are unknown.
; FIXME: Extracted as a callable routine; retail enters this directly from
; mroute_steerprep and returns to the still-missing $04:c933 consumer.
; TODO: Restore that common route-control consumer.
mroute_controls
	mpush	r11
	ibt	r9,#0
	mloadw	r0,CAR_GNDSPEED,r8
	move	r3,r4
	cmp	r3
	bpl	.speedok
	nop
	iwt	r2,#$227
	from	r4
	cmp	r2
	bmi	.accel
	nop
	iwt	r0,#CARflag_dynoff
	to	r9
	or	r9
	bra	.steer
	nop
.accel
	iwt	r0,#CARflag_Accel
	to	r9
	or	r9
	bra	.steer
	nop
.speedok
	iwt	r0,#CARflag_Brake
	to	r9
	or	r9
.steer
	mloadw	r2,CAR_ENGINEROTY,r8
	move	r0,r1
	sub	r2
	bpl	.right
	nop
	iwt	r1,#-910
	cmp	r1
	bpl	.steerdone
	nop
	iwt	r1,#-4004
	cmp	r1
	bpl	.steerright
	nop
	iwt	r0,#~CARflag_Accel
	to	r9
	and	r9
.steerright
	iwt	r0,#CARflag_steerRight
	to	r9
	or	r9
	mloadw	r0,CAR_FLAGS,r8
	iwt	r1,#CARflag_computer
	and	r1
	beq	.steerdone
	nop
	iwt	r0,#CARflag_steerHardRight
	to	r9
	or	r9
	bra	.steerdone
	nop
.right
	iwt	r1,#910
	cmp	r1
	bmi	.steerdone
	nop
	iwt	r1,#4004
	cmp	r1
	bmi	.steerleft
	nop
	iwt	r0,#~CARflag_Accel
	to	r9
	and	r9
.steerleft
	iwt	r0,#CARflag_steerLeft
	to	r9
	or	r9
	mloadw	r0,CAR_FLAGS,r8
	iwt	r1,#CARflag_computer
	and	r1
	beq	.steerdone
	nop
	iwt	r0,#CARflag_steerHardLeft
	to	r9
	or	r9
	bra	.steerdone
	nop
.steerdone
	mloadw	r0,CAR_GNDSPEED,r8
	iwt	r3,#200
	cmp	r3
	bpl	.fast
	nop
	iwt	r0,#CARflag_Accel
	to	r9
	or	r9
.fast
	iwt	r0,#CAR_AIDELAY
	add	r8
	ldw	[r0]
	with	r1
	from	r0
	beq	.delaydone
	dec	r0
	sbk
	iwt	r0,#~(CARflag_Accel!CARflag_dynoff)
	to	r9
	and	r9
.delaydone
	iwt	r0,#CAR_AISTUCK
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	bmi	.stucknegative
	nop
	iwt	r1,#20
	cmp	r1
	bmi	.stuckcount
	nop
	iwt	r0,#-40
.stucknegative
	inc	r0
	sbk
	iwt	r1,#-20
	cmp	r1
	bpl	.stuckdone
	nop
	iwt	r0,#~(CARflag_Accel!CARflag_Brake!CARflag_dynoff)
	to	r9
	and	r9
	iwt	r0,#CARflag_Deccel
	to	r9
	or	r9
	iwt	r0,#CARflag_steerLeft!CARflag_steerRight
	to	r9
	xor	r9
	bra	.stuckdone
	nop
.stuckcount
	mloadw	r0,CAR_GNDSPEED,r8
	iwt	r1,#10
	cmp	r1
	bpl	.stuckdecrement
	nop
	iwt	r0,#CAR_AISTUCK
	add	r8
	ldw	[r0]
	inc	r0
	sbk
	bra	.stuckdone
	nop
.stuckdecrement
	iwt	r0,#CAR_AISTUCK
	add	r8
	ldw	[r0]
	with	r0
	from	r0
	beq	.stuckdone
	dec	r0
	sbk
.stuckdone
	mloadw	r0,CAR_OFFGND,r8
	with	r0
	from	r0
	beq	.store
	nop
	iwt	r0,#~(CARflag_Accel!CARflag_dynoff)
	to	r9
	and	r9
.store
	mstorew	r9,CAR_CONTROL,r8
	mpop	pc
	nop


; US $04:cc06-$04:cca3. r1/r2/r3 = query XYZ words.
; r0 = one-based nearest point index, zero if no point was selected.
; On success: r1/r2/r3 = point XYZ, r5 = its ROM address, r6 = distance.
; r4/r7/r9/r12/r13/r14 and flags are scratch; r8/r10/r11 preserved.
; Metric is |dx| + 4*|dy| + |dz|, with the retail 16-bit arithmetic and
; overflow skips retained. Strictly smaller distance wins (first tie).
; Only r0 is meaningful on failure: the no-candidate scan still reads
; XYZ through the retail wrapped $fffa address. Do not fabricate a point.
mfind_nearroute
	lm	r0,[m_routebank]
	romb
	lm	r0,[m_routeptr]
	moves	r14,r0
	bne	.table
	nop
	miwt	pc,.none&$ffff
	nop
.table
	mgetwi	r0
	moves	r12,r0
	bne	.scan
	nop
	miwt	pc,.none&$ffff
	nop
.scan
	ibt	r5,#0
	iwt	r6,#$7fff
	ibt	r4,#0
	ibt	r7,#0
	cache
	move	r13,pc
.loop
	inc	r4
	mgetwi	r0
	sub	r1
	bvs	.skipyz
	nop
	bpl	.xpos
	nop
	not
	inc	r0
.xpos
	move	r9,r0
	mgetwi	r0
	sub	r2
	bpl	.ypos
	nop
	not
	inc	r0
.ypos
	add	r0
	add	r0
	with	r9
	add	r0
	bvs	.skipz
	nop
	mgetwi	r0
	sub	r3
	bvs	.next
	nop
	bpl	.zpos
	nop
	not
	inc	r0
.zpos
	add	r9
	bvs	.next
	nop
	cmp	r6
	bcs	.next
	nop
	move	r6,r0
	move	r5,r14
	move	r7,r4
	bra	.next
	nop
.skipz
	inc	r14
	bra	.next
	inc	r14
.skipyz
	with	r14
	add	#4
.next
	inc	r14
	loop
	inc	r14
	move	r0,r7
	from	r5
	to	r5
	sub	#6
	move	r14,r5
	mgetwi	r1
	mgetwi	r2
	mgetwi	r3
	move	pc,r11
	nop
.none
	sub	r0
	move	pc,r11
	nop

; Forward/reverse packed-route readers, US $04:ccbf-$04:cd55.
; r0 = current one-based index, r5 = current point ROM address.
; Output r0/r6 = adjacent index, r5 = adjacent point address,
; r1/r2/r3 = XYZ, r4 = desired speed. r14 ends at r5+8.
; RAM bank 0 on entry; ROM bank is selected from m_routebank.
; r7-r13 preserved; no stack use or car/index writes. Names reconstructed.
; Forward wraps only when the INPUT index equals the table count.
; Reverse wraps only when decrementing the input index produces zero.
; Other indices use r5 +/- 8, not a pointer recalculated from the index.
; All arithmetic wraps at 16 bits; no null/count/range guards in retail.
; The retail car-$70 direction selector is restored as mselect_routepoint.
; CAR_ROUTEMODE is appended to the early car, not aliased to CAR_FLAGS.
; TODO: Restore its producer and the steering/automatic-motion callers.
mselect_routepoint
	move	r6,r0
	lm	r0,[m_routebank]
	romb
	mloadw	r1,CAR_ROUTEMODE,r8
	iwt	r0,#CARroutemode_reverse
	and	r1
	move	r0,r6
	beq	.forward
	nop
	miwt	pc,mprev_routepoint&$ffff
	nop
.forward
mnext_routepoint
; FIXME: Reuse retail's bank-selection prologue without its unmapped
; car-mode read. mselect_routepoint supplies that read; direct callers
; still need this wrapper. The following body is the retail $04:ccbf entry.
	move	r6,r0
	lm	r0,[m_routebank]
	romb
	move	r0,r6
	move	r6,r0
	inc	r6
	lm	r14,[m_routeptr]
	to	r1
	getb
	inc	r14
	with	r1
	getbh
	cmp	r1
	bne	.next
	nop
	lm	r0,[m_routeptr]
	add	#2
	move	r14,r0
	ibt	r6,#1
	bra	.read
	nop
.next
	from	r5
	to	r14
	add	#8
.read
	move	r5,r14
	mgetwi	r1
	mgetwi	r2
	mgetwi	r3
	mgetwi	r4
	move	r0,r6
	with	r11
	to	pc
	nop

; US $04:cd05. Unlike the interior forward entry, this already selects
; the bound ROM bank. Input index 1 wraps to the table's count word.
mprev_routepoint
	move	r6,r0
	lm	r0,[m_routebank]
	romb
	dec	r6
	bne	.previous
	nop
	lm	r14,[m_routeptr]
	getb
	inc	r14
	getbh
	move	r1,r0
	dec	r0
	iwt	r6,#8
	lmult
	lm	r0,[m_routeptr]
	add	#2
	from	r4
	to	r14
	add	r0
	move	r6,r1
	bra	.read
	nop
.previous
	from	r5
	to	r14
	sub	#8
.read
	move	r5,r14
	mgetwi	r1
	mgetwi	r2
	mgetwi	r3
	mgetwi	r4
	move	r0,r6
	with	r11
	to	pc
	nop


; US $04:cd56-$04:cd82. r5 = point ROM address, r0 preserved.
; r1/r2/r3 = XYZ, r4 = desired speed; r5/r6-r13 preserved.
; r14 ends eight bytes past the point (word wrap). No bounds checks.
; Retail $04:c7d5 scales this speed for CAR_ROUTEMODE bit $20, then
; compares it with car speed at $04:c81c for acceleration/braking.
mreadroutepoint
	mpush	r0
	lm	r0,[m_routebank]
	romb
	move	r14,r5
	mgetwi	r1
	mgetwi	r2
	mgetwi	r3
	mgetwi	r4
	mpop	r0
	move	pc,r11
	nop

; US $04:cd83-$04:cd97. r0 = one-based index, preserved on return.
; r5 = m_routeptr + 2 + (index-1)*8, all arithmetic modulo 65536.
; r1/r4/r6 and flags scratch; does not select a ROM bank or read data.
; Pass the result to mreadroutepoint. No range/zero checks in retail.
mroutepointptr
	move	r1,r0
	dec	r0
	iwt	r6,#8
	lmult
	lm	r0,[m_routeptr]
	add	#2
	to	r5
	add	r4
	move	r0,r1
	move	pc,r11
	nop


; Normal-mode nearest-index block, US $04:c478-$04:c4a0.
; r8 = car; r10 = stack; r11 = return address; RAM bank 0.
; A successful search replaces CAR_ROUTEINDEX. Failure preserves the
; old index, including zero if no successful search has occurred yet.
; r0 returns the new search result (zero on failure), NOT the stored
; index on failure. r8/r10 preserved; search scratch and r11 destroyed.
; FIXME: Extracted as a callable block with its own push/return. Retail
; continues to next-point/steering on success and $04:c933 on both paths.
; TODO: Restore those consumers and the enclosing retail mode dispatcher.
mtrack_carroute
	mpush	r11
	mloadw	r1,OBJ_WORLDX,r8
	mloadw	r2,OBJ_WORLDY,r8
	mloadw	r3,OBJ_WORLDZ,r8
	mcall	mfind_nearroute
	nop
	mtest	r0
	bne	.found
	nop
	miwt	pc,.done&$ffff
	nop
.found
	move	r7,r0
	mstorew	r7,CAR_ROUTEINDEX,r8
	move	r0,r7
.done
	mpop	pc
	nop


; Query-only route update, US $04:c4be-$04:c4d0. Retail reaches this
; branch when car $70 bit 2 (mask $0004) selects index-only tracking.
; r8 = car; r10 = stack; r11 = return address; RAM bank 0.
; Store the search result even when zero, replacing a stale index.
; r0 returns one as in retail; this is NOT a valid-index indicator.
; r8/r10 preserved; search scratch registers and r11 destroyed.
; The added entry push supplies the enclosing retail routine's stack frame.
mupdate_carroute
	mpush	r11
	mcall	mfind_carroute
	nop
	move	r7,r0
	mstorew	r7,CAR_ROUTEINDEX,r8
	ibt	r0,#1
	mpop	pc
	nop
