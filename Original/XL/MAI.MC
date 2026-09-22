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
; TODO: Restore the retail mode flags, steering and automatic route motion.

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

; US $04:cd56-$04:cd82. r5 = point ROM address, r0 preserved.
; r1/r2/r3 = XYZ, r4 = opaque fourth word; r5/r6-r13 preserved.
; r14 ends eight bytes past the point (word wrap). No bounds checks.
; TODO: Identify the fourth word's meaning in retail steering consumers.
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
