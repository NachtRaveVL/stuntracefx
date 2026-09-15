
	incpublics	game.ext

getview_l
	a8
	phb
	lda	#$7e
	pha
	plb

	a8

	ifeq	1
	lda	viewtype
	and	#viewtype_fpos
	rlbne	.fpos


	a16i8
	lda	viewshakeX
	sexa
	clc
	adc	pviewposx
	sta	viewposx

	lda	viewshakeY
	sexa
	clc
	adc	pviewposY
	sta	viewposY

	lda	viewshakeZ
	sexa
	clc
	adc	pviewposZ
	clc
	adc	pviewposZoff
	sta	viewposZ

	lda	outvx
	sta	viewrotxw

	lda	outvy
	clc
	adc	outvyoff
	sta	viewrotyw

	lda	outvz
	sta	viewrotzw

	a8


;***************************************************************
;* I'M SORRY BUT THESE ARE 2 VERY BIG HACKS, BECAUSE I DON'T WANT
;* TO FUCK WITH PETE'S CODE. (Giles) 



;* JUST X ROTATE VIEW POS.
	a16
	lda	viewrotxw
	nega
	sta matxw
	stz matyw
	stz matzw
	a8
	jsl crotmat16_l

	a16
	copymat16 mat,wmat

	stz	x1
	stz	y1
	lda	outdist
	nega
	sta	z1
	a8
	jsl	wmatrotp16_l

;***************************************************************


;* NOW JUST Y ROTATE VIEW POS.
	a16
	stz matxw
	lda	viewrotyw
	nega
	sta matyw
	stz matzw
	a8
	jsl crotmat16_l

	a16
	copymat16 mat,wmat

	lda	bigx
	sta	x1
	lda	bigy
	sta	y1
	lda	bigz
	sta	z1
	a8
	jsl	wmatrotp16_l
	add bigx,viewposx,viewposx
	add bigy,viewposy,viewposy
	add bigz,viewposz,viewposz


;***************************************************************

.fpos
	endc

	ai16
	ldx viewpt
	lda al_worldx,x
	sta viewposx
	lda al_worldy,x
	sta viewposy
	lda al_worldz,x
	sta viewposz

	a8

	lda	viewtype
	and	#viewtype_toobj
	rlbeq	.ntpl

	lda	al_rotx,x
	sta	outvx+1
	stz	outvx

	ldy	viewtoobj
	lda.w	al_worldzh,y
	sta	viewmapz


	lda.w	al_rotx,y
	sta matx
	lda.w	al_roty,y
	sta maty
;	lda.w	al_rotz,y
	stz matz
	jsl crotmat16_l

	a16
	copymat16 mat,wmat

	lda	viewtopos_offX
	sta	x1
	stz	y1
	lda	viewtopos_offZ
	sta	z1
	a8
	jsl	wmatrotp16_l

	ai16
	ldx viewpt
	ldy	viewtoobj

	lda	bigx
	sta	x2
	lda	bigz
	sta	z2
	jsl	Yanglexy_off_l
	lda	#0
	sec
	sbc	viewrotYw
	adiv2
	clc
	adc	viewrotYw
	sta 	viewrotYw		
	sta 	outvy

	lda	bigx
	sta	x2
	lda	bigy
	nega
	sta	y2
	lda	bigz
	sta	z2
	jsl	Xanglexy_off_l
	nega
	sec
	sbc.l	alx_viewrotX,x
	sec
	sbc	outvx
	adiv2
	adiv2
	adiv2
	clc
	adc.l	alx_viewrotX,x
	sta	viewrotXw		


	lda	viewtype
	and	#viewtype_nolimits		
	bne	.nlim

	lda	viewrotYw
	range	-deg11*256,deg11*256
	sta	viewrotYw

	lda	viewrotXw
	range	-deg22*256,deg22*256
	sta	viewrotXw
.nlim
	lda	viewrotXw
	sta.l	alx_viewrotX,x


	a8
	lbra		.dviewrot
.ntpl

;------------------------------------------------------------------
	a8
	lda	viewtype
	and	#viewtype_mia
	rlbeq	.nmia

	ldy	viewtoobj
	lda.w	al_worldzh,y
	sta	viewmapz

;calculate X angle
	a16
	lda	al_rotx,x
	xba
	and	#$ff00
	pha

	jsl	xanglexy_l

	sta	x1
	pla
	clc
	adc	x1	

	nega
	sec
	sbc	viewrotXw
	asra
	asra
	clc
	adc	viewrotXw
	range	-(deg90-deg5)*256,(deg90-deg5)*256
	sta	viewrotXw

;calculate Y angle
;	jsl	yanglexy_l
;	sta	viewrotYw


	ifeq	0
	lda	al_roty,x
	xba
	sta	x1

	lda.w	al_roty,y
	xba
	nega
;	asra
	adiv2
	clc
	adc	x1

	sec
	sbc	viewrotYw
	and	#$ff00
	beq	.st
	bpl	.left
	lda	viewrotYw
	sec
	sbc	#64
	sta	viewrotYw
	bra	.st
.left
	lda	viewrotYw
	clc
	adc	#64
	sta	viewrotYw
.st
	endc


	lda	viewrotYw
	range	-(deg22+deg22)*256,(deg22+deg22)*256
	sta	viewrotYw

;	lda	viewrotYw
;	range	-deg90*256,deg90*256
;	sta	viewrotYw

	

	a8
	bra	.dviewrot

.nmia


	ldx viewpt
	lda al_rotx,x
	nega
	sta viewrotx
	sta 	outvx+1
	lda al_roty,x
	nega
	sta 	outvy+1	
	sta viewroty
	lda al_rotz,x
	nega
	sta 	outvz+1	
	sta viewrotz

.dviewrot

	jsl	getviewmat_l


	ifeq	1
;*****************************************************************
; cross hair calculation.


	php
	ai16
	ldx	playpt

	stz	y1
	lda	#crosshairdist
	sta	z1
	a8
	lda	al_rotx,x
	jsl	rotate_16yz_l

	a16
	lda	x2
	sta	x1
	lda	y2
	sta	y1
	lda	z2
	sta	z1

	a8
	lda	al_roty,x
	jsl	rotate_16xz_l

	a16
	lda	x2
	clc
	adc	al_worldx,x
	sec
	sbc	viewposx
	sta.l	m_x1

	lda	y2
	clc
	adc	al_worldy,x
	sec
	sbc	viewposy
	sta.l	m_y1

	lda	z2
	clc
	adc	al_worldz,x
	sec
	sbc	viewposz
	sta.l	m_z1


	a8
	s_jmp_varNE	B,splayerflymode,#spfm_inside,.nin
	a16
	lda.l	m_y1
	clc
	adc	#inviewLaserYoff
	sta.l	m_y1	
	a8
.nin



	lda	#mwmatrotp16>>16
	ldx	#mwmatrotp16&$ffff
	jsl	runmario_l
	a16
	lda.l	m_bigx
	sta	x1
	lda.l	m_bigy
	sta.l	y1
	lda.l	m_bigz
	sta	z1

	ai8
	jsl	projectlog_l
	plp


	a16
	lda	xs
	sec
	sbc	#mvanishx
	sta	arsebandX

	lda	ys
	sec
	sbc	#mvanishy
	sta	arsebandY

	a8
	
;*****************************************************************
	endc


	plb
	rtl







; Publish a prepared camera record to the retail display state.
; US $02:dad6-$02:db58. X = low-WRAM vc_ record, D = 0, DB = $7e.
; Returns A16/I16, X/Y preserved.
; A, x1/z1 and arithmetic flags are scratch. Position and angles must
; already be current; this entry does not advance the camera or matrix.
; The two map references normally describe camera and target separately;
; vcf_cameramap makes both use the camera cell. The early renderer still
; has its own viewmapz range byte, which is not a retail map reference.
setviewrecord_l
	ai16
	lda	vc_worldx,x
	sta	viewposx
	lda	vc_worldy,x
	sta	viewposy
	lda	vc_worldz,x
	sta	viewposz
	lda	vc_rotx,x
	sta	viewrotxw
	lda	vc_roty,x
	sta	viewrotyw
	lda	vc_rotz,x
	sta	viewrotzw
	phx
	lda	vc_target,x
	tax
	lda.l	alx_collobjptr,x
	sta.l	m_testcar1
	plx
	phx
	lda	viewposx
	sta	x1
	lda	viewposz
	sta	z1
	jsl	getmapindex_l
	sta	viewmapindex
	lda	x1
	sta	viewmapcol
	lda	z1
	sta	viewmaprow
	plx
	lda	vc_flags,x
	and	#vcf_cameramap
	beq	.target
	lda	viewmapindex
	sta	targetmapindex
	lda	viewmapcol
	sta	targetmapcol
	lda	viewmaprow
	sta	targetmaprow
	bra	.done
.target
	phx
	lda	vc_target,x
	tax
	lda.l	alx_worldx,x
	sta	x1
	lda.l	alx_worldz,x
	sta	z1
	jsl	getmapindex_l
	sta	targetmapindex
	lda	x1
	sta	targetmapcol
	lda	z1
	sta	targetmaprow
	plx
.done
	rtl


; Retail camera position update, US $02:db71-$02:de44.
; X = vc_ record, I16, D = 0, DB = $7e; returns A16/I16, X preserved.
; Uses the selected car in m_testcar1 for steering/velocity alignment.
; With world-offset plus position-lag flags, the retail path leaves Y to
; the caller: it must already identify the target object in that case.
; Matrix and angle temporaries, A/Y and the viewpos* work words are scratch.
; This consumes a prepared retail record; the early alien camera is separate.
getviewpos_l
	phx
	ai16
	phx
	lda	vc_target,x
	tax
	stx	viewpostarget
	plx
	lda	vc_flags,x
	sta	viewposflags
	lda	viewposflags
	and	#vcf_fixedpos
	beq	.speedcheck
	brl	.done
.speedcheck
	a16
	lda	viewposflags
	and	#vcf_speedoff
	bne	.speed
	brl	.nospeed
.speed
	phx
	ldx	viewpostarget
	lda.l	alx_collobjptr,x
	tax
	lda.l	mrambank+car_gndspeed,x
	bpl	.speedabs
	nega
.speedabs
	plx
	asra
	bpl	.speedhalf
	adc	#$0000
.speedhalf
	sta	z1
	asra
	asra
	bpl	.speedquarter
	adc	#$0000
.speedquarter
	sta	y1
	stz	x1
	lda	x1
	nega
	sta	vc_speedx,x
	lda	y1
	nega
	sta	vc_speedy,x
	lda	z1
	nega
	sta	vc_speedz,x
	bra	.offset
.nospeed
	stz	vc_speedx,x
	stz	vc_speedy,x
	stz	vc_speedz,x
.offset
	lda	vc_offx,x
	sta	x1
	lda	vc_offy,x
	sta	y1
	lda	vc_offz,x
	sta	z1
	lda	viewposflags
	bit	#vcf_worldoff
	beq	.orbit
	stz	matxw
	stz	matyw
	stz	matzw
	jmp	.rotate
.orbit
	bit	#vcf_yawlagmask
	bne	.lag
	ldy	viewpostarget
	lda.w	al_roty,y
	xba
	and	#$ff00
	nega
	sta	vc_orbity,x
	sta	matyw
	lda.w	al_rotx,y
	xba
	and	#$ff00
	asra
	asra
	sta	vc_orbitx,x
	sta	matxw
	stz	matzw
	jmp	.rotate
.lag
	ldy	viewpostarget
	phx
	lda.l	m_testcar1
	tax
	lda.l	mrambank+car_flags,x
	plx
	and	#$000c
	beq	.yawdelta
	lda	viewposflags
	and	#vcf_nosteerlag
	bne	.yawdelta
	lda.w	al_roty,y
	xba
	and	#$ff00
	nega
	sec
	sbc	vc_orbity,x
	asra
	clc
	adc	vc_orbity,x
	sta	vc_orbity,x
	sta	matyw
	jmp	.pitch
.yawdelta
	lda.w	al_roty,y
	xba
	and	#$ff00
	nega
	sec
	sbc	vc_orbity,x
	sta	viewposdelta
	lda	viewposflags
	and	#vcf_yawlagmask
	cmp	#$0000
	beq	.directyaw
	cmp	#vcf_yawlagauto
	beq	.autolag
	cmp	#vcf_yawlag4
	beq	.quarter
	cmp	#vcf_yawlag12
	beq	.lag12
	cmp	#vcf_yawlag25
	beq	.lag25
.directyaw
	lda	viewposdelta
	bra	.addyaw
.autolag
	phx
	lda.l	m_testcar1
	tax
	lda.l	mrambank+car_velalign,x
	bpl	.alignabs
	nega
.alignabs
	plx
	cmp	#$7ef4
	bpl	.half
	lda	viewposdelta
	asra
	asra
	bpl	.autoquarter
	adc	#$0000
.autoquarter
	bra	.addyaw
.half
	lda	viewposdelta
	asra
	bpl	.halfdone
	adc	#$0000
.halfdone
	bra	.addyaw
.quarter
	lda	viewposdelta
	asra
	asra
	bpl	.quarterdone
	adc	#$0000
.quarterdone
	bra	.addyaw
.lag12
	lda	viewposdelta
	jsl	perc15a_l
	asra
	bpl	.lag12done
	adc	#$0000
.lag12done
	bra	.addyaw
.lag25
	lda	viewposdelta
	jsl	perc15a_l
	asra
	asra
	bpl	.addyaw
	adc	#$0000
.addyaw
	clc
	adc	vc_orbity,x
	sta	vc_orbity,x
	sta	matyw
.pitch
	lda.w	al_rotx,y
	xba
	and	#$ff00
	asra
	asra
	bpl	.pitchdone
	adc	#$0000
.pitchdone
	sta	vc_orbitx,x
	sta	matxw
	stz	matzw
.rotate
	phx
	lda	matxw
	clc
	adc	vc_biasx,x
	nega
	sta	matxw
	lda	matyw
	clc
	adc	vc_biasy,x
	sta	matyw
	lda	matzw
	clc
	adc	vc_biasz,x
	sta	matzw
	a8
	jsl	crotmat16_l
	a16
	copymat16	mat,wmat
	a8
	jsl	wmatrotp16t_l
	ai16
	plx
	lda	viewposflags
	bit	#vcf_poslag
	beq	.heightcheck
	brl	.poslag
.heightcheck
	bit	#vcf_heightlag
	bne	.heightlag
	ldy	viewpostarget
	lda.w	al_worldx,y
	clc
	adc	bigx
	sta	vc_worldx,x
	lda.w	al_worldy,y
	clc
	adc	bigy
	sta	vc_worldy,x
	lda.w	al_worldz,y
	clc
	adc	bigz
	sta	vc_worldz,x
	bra	.done
.heightlag
	ldy	viewpostarget
	lda.w	al_worldx,y
	clc
	adc	bigx
	sta	vc_worldx,x
	lda.w	al_worldy,y
	clc
	adc	bigy
	sec
	sbc	vc_worldy,x
	bmi	.heightstep
	asra
.heightstep
	asra
	clc
	adc	vc_worldy,x
	sta	vc_worldy,x
	lda.w	al_worldz,y
	clc
	adc	bigz
	sta	vc_worldz,x
	bra	.done
.poslag
	lda.w	al_worldx,y
	clc
	adc	bigx
	sec
	sbc	vc_worldx,x
	asra
	asra
	clc
	adc	vc_worldx,x
	sta	vc_worldx,x
	lda.w	al_worldy,y
	clc
	adc	bigy
	sec
	sbc	vc_worldy,x
	asra
	asra
	asra
	clc
	adc	vc_worldy,x
	sta	vc_worldy,x
	lda.w	al_worldz,y
	clc
	adc	bigz
	sec
	sbc	vc_worldz,x
	asra
	asra
	clc
	adc	vc_worldz,x
	sta	vc_worldz,x
	bra	.done
.done
	plx
	rtl

; Build the world-view matrix from the 16 bit view angles.
; US retail $02:df24. Shared with the early getview_l camera path.
; D = 0, DB = $7e. Returns A8/I8; matrix-helper temporaries scratch.

getviewmat_l
	a16
	lda viewrotxw
	sta matxw
	lda viewrotyw
	sta matyw
	lda viewrotzw
	sta matzw


	ai8
	jsl crotmat16_l

	a16
	copymat16 mat,wmat
	a8
	rtl


; Update the angles of a retail camera record, US retail $02:de45.
; Entry name and field names reconstructed.
; X = camera record in low Work RAM, D = 0, DB = $7e.
; X and P are preserved; A,Y and angle-helper temporaries are scratch.
; Position/record setup belongs to the retail camera caller, not getview_l.

getviewangles_l
	php
	ai16
	lda	vc_flags,x
	and	#vcf_lookat
	bne	.lookat
	brl	.follow
.lookat
	ai16
	txy
	lda	vc_target,x
	tax
	lda.w	vc_worldx,y
	sta	x2
	lda.w	vc_worldy,y
	sta	y2
	lda.w	vc_worldz,y
	sta	z2
	jsl	Yanglexabs16_l
	clc
	adc	#$8000
	sta.w	vc_roty,y
	lda.w	vc_flags,y
	and	#vcf_pitchlag
	bne	.pitchlag
	jsl	Xanglexabs16_l
	bra	.pitchdone
.pitchlag
	jsl	Xanglexabs16_l
	sec
	sbc.w	vc_rotx,y
	asra
	asra
	clc
	adc.w	vc_rotx,y
.pitchdone
	sta.w	vc_rotx,y
	lda	al_rotz,x
	and	#$ff
	xba
	nega
	asra
	asra
	sec
	sbc.w	vc_rotz,y
	asra
	clc
	adc.w	vc_rotz,y
	sta.w	vc_rotz,y
	tyx
	bra	.rollcheck
.follow
	a16
	lda	vc_flags,x
	and	#vcf_followrot
	beq	.rollcheck
	txy
	lda	vc_target,x
	tax
	lda	al_rotx,x
	and	#$ff
	xba
	nega
	sec
	sbc.w	vc_rotx,y
	asra
	clc
	adc.w	vc_rotx,y
	sta.w	vc_rotx,y
	lda	al_roty,x
	and	#$ff
	xba
	nega
	sec
	sbc.w	vc_roty,y
	asra
	clc
	adc.w	vc_roty,y
	sta.w	vc_roty,y
	lda	al_rotz,x
	and	#$ff
	xba
	nega
	sec
	sbc.w	vc_rotz,y
	asra
	clc
	adc.w	vc_rotz,y
	sta.w	vc_rotz,y
	tyx
.rollcheck
	lda	vc_flags,x
	and	#vcf_roll
	bne	.done
	stz	vc_rotz,x
.done
	plp
	rtl


	IFEQ	1

irotcentre
	ldx viewrotx
	lda sintab,x
	sta sinvx
	lda costab,x
	sta cosvx

	ldx viewroty
	lda sintab,x
	sta sinvy
	lda costab,x
	sta cosvy

	ldx viewrotz
	lda sintab,x
	sta sinvz
	lda costab,x
	sta cosvz


; z

;	lda viewrotz
;	lbeq irotcen3

	mulslog168 x1,cosvz
	lda m4
	sta bigx
	lda m5
	sta bigx+1
	mulslog168 y1,sinvz
	lda m4
	clc
	adc bigx
	sta bigx
	lda m5
	adc bigx+1
	sta bigx+1

	mulslog168 x1,sinvz
	lda m4
	sta bigy
	lda m5
	sta bigy+1
	mulslog168 y1,cosvz
	lda m4
	sec
	sbc bigy
	sta bigy
	lda m5
	sbc bigy+1
	sta bigy+1

	mov bigx,x1
	mov bigy,y1


irotcen3


; x

;	lda viewrotx
;	lbeq irotcen2

	mulslog168 z1,sinvx
	lda m4
	sta bigy
	lda m5
	sta bigy+1
	mulslog168 y1,cosvx
	lda m4
	clc
	adc bigy
	sta bigy
	lda m5
	adc bigy+1
	sta bigy+1

	mulslog168 y1,sinvx
	lda m4
	sta bigz
	lda m5
	sta bigz+1
	mulslog168 z1,cosvx
	lda m4
	sec
	sbc bigz
	sta bigz
	lda m5
	sbc bigz+1
	sta bigz+1


	mov bigz,z1
	mov bigy,y1

irotcen2

; y

	mulslog168 x1,sinvy
	lda m4
	sta bigz
	lda m5
	sta bigz+1
	mulslog168 z1,cosvy
	lda m4
	clc
	adc bigz
	sta bigz
	lda m5
	adc bigz+1
	sta bigz+1

	mulslog168 z1,sinvy
	lda m4
	sta bigx
	lda m5
	sta bigx+1
	mulslog168 x1,cosvy
	lda m4
	sec
	sbc bigx
	sta bigx
	lda m5
	sbc bigx+1
	sta bigx+1

;	mov y1,bigy
;	mov bigx,x1
;	mov bigz,z1

	rts



	ENDC

;
; 6502 MATHS LIBRARY
;
; by P. R. Warnes, Copyright 1990
;
random_l
	jsr	random
	rtl
random

;	lda	rand
;	rol	a
;	eor	rand+1
;	sta	rand+1
;	adc	#4
;	sta	rand
	
	lda rand
	clc
	sbc rand+1
	sta rand+1
	sbc rand+2
	sta rand+2
	sbc rand+3
	sta rand+3
	sbc rand
	sta rand
	rts


	IFEQ	1
muls8log_l
	jsr	muls8log
	rtl
muls8log 
	ldx m1
	beq muls8log1
	ldy m2
	beq muls8log2
	lda logtab8s,x
	clc
	adc logtab8s,y
	tay
	txa
	ldx alogtab8s,y
	eor m2
	bpl muls8log1
	ldx nalogtab8s,y
muls8log1 
	stx m3
	rts
muls8log2
	ldx #0
	stx m3
	rts


muls816log0y 
	ldx #0
muls816log0 
	stx m3
	stx m4
	rts
	
muls816log_l
	jsr	muls816log
	rtl
muls816log 
	ldx m1
	beq muls816log0
	ldy m2
	beq muls816log0y
	lda logtab8s,x
	clc
	adc logtab8s,y
	tay
	txa
	ldx alogtab8s,y
	eor m2
	bpl muls816log1
	ldx nalogtab8s,y
muls816log1 
	stx m3
	ldx alogtab8sl,y
	cmp #0
	bpl muls816log2
	ldx nalogtab8sl,y
muls816log2 
	stx m4
	rts


	ENDC
muls816log16_l
	jsr	muls816log16
	rtl
muls816log16
	stz	m6
	stz	m7
	mla16mac	m1,m3,m4,m6
	rts


arctan16_l
	jsr	arctan16	
	a16
	rtl


; 16 bit arctan (x1/y1)
; a = arctan(x1/y1)
;
; 0 to 359 degrees is $0000 to $ffff
; x1 and y1 are signed
;
; tmpx,x1,x2,x3,y1,y2,px,pz,pr


arctan16
sarctan
	phx
	php

	a16
	lda	x1
	sta.l	m_x1
	lda	y1
	sta.l	m_y1

	a8i16
	lda	#mcallarctan16>>16
	ldx	#mcallarctan16&$ffff
	jsl	runmario_l
	
	a16
	lda.l	m_cnt

	plp
	plx
	rts



