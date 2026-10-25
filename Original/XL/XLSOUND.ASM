;---------------------------------------------------------
;
;	Sound Control Program for XL
;
;				programed by Masato Kimura
;
;				11/05/1993
;---------------------------------------------------------


	
	incpublics	xlsound.ext


engine_sound
	php
	a8
	lda	control_flag
	bne	startinggrid
	ai16
	lda.l	m_testcar1
	tax
	lda.l	$700000+CAR_REVSnd,x
	cmp	#1023
	bcc	.not_over_speed
	lda	#1023
.not_over_speed			
	lsr	a
	lsr	a

	a8
	sta.l	2143h		;sound 03 port!!!

	plp
	rtl

startinggrid
	
	a16i8
	lda.l	cont0d
	bmi	.accelon
	bit	#80h
	bne	.accelon

.acceloff

	lda.l	enginesound
	sec	
	sbc	#3800h
	bcs	.contacceloff
	lda	#0000h
.contacceloff	
	sta.l	enginesound
	a8
	xba
	sta.l	2143h

	plp
	rtl
;
.accelon
	longa
	shorti
	lda.l	enginesound
	clc
	adc	#1400h
	cmp	#0e000h
	bcc	.contaccelon
.overaccel
	lda	#800h	
.contaccelon
	sta.l	enginesound
	a8
	xba
	sta.l	2143h		
	plp
	rtl





accelondata
	dw	 2400h,2500h,2800h,2700h
acceloffdata
	dw	 4800h,4a00h,4d00h,4f00h
accellimmit
	dw	 0c000h,0e000h,08000h,0f000h
minimumaccel
	dw	 0f00h,0d00h,0300h,0400h

	




















;;;;	lda	accel_flag
;;;;	bpl	.lastoff
;;;.laston
;;;;	a16
;;;;;;	lda	cont0l
;;	bmi	continuestatus
;;	bit	#%0000000010000000
;;	bne	continuestatus
;;.nowoff
;;	a8
;;	lda	#00
;;	sta	accel_flag
;;;	se_acceloff
;;	plp
;;	rtl
;;.lastoff
;;	a16
 ;;	lda	cont0l
 ;;;	bmi	.nowon
;;	bit	#%0000000010000000
;;;	beq	continuestatus
;;.nowon	
;;	a8
;;;	lda	#0ffh
;;;	sta	accel_flag
;;	se_accelon
;;	plp
;;	rtl
;;continuestatus
;;	longa
 ;;	lda	trig1
;	bmi	.hitB
;;     	bit	#4000h
;;	bne	.hitY
;;	bit	#0080h
;;	bne	.hitA
;;	bit	#0040h
;;	bne	.hitX
;;	plp
 ;;	rtl
  ;;	

.hitX
;	engine3
	ai16
;;;;;	bump
	plp
	rtl

.hitA
;;;;;	engine4
	plp
	rtl

.hitY
;;;;;	engine2
	plp
	rtl
.hitB
;;;;;	engine1
	plp
	rtl

;--------------------------------------------------------------


apu_initialize
	php
	ai16
	lda	#xlsnd0>>16
	ldy	#(xlsnd0)&WM

	jsl	boot_apu

	a8i16
	ldx	#4000h
.soundwait
	dex
	bne	.soundwait
	plp
	rtl
;--------------------------------------------------------------
;			engine_lebel=16.....nomal
;				     18.....core
;				     17.....tunnel
;
nomal_engine_call
	php
	a8
	lda	#nomalengine
	cmp	engine_lebel
	beq	nomorenomal
	sta	engine_lebel
	jsl	call_sound0
nomorenomal
	plp
	rtl	
core_engine_call
	php
	a8
	lda	#coreengine
	cmp	engine_lebel
	beq	nomorecore
	sta	engine_lebel
	jsl	call_sound0
nomorecore
	plp
	rtl	
tunnel_engine_call
	php
	a8
	lda	#nomalengine
	cmp	engine_lebel
	beq	nomoretunnel
	sta	engine_lebel
	jsl	call_sound0
nomoretunnel
	plp
	rtl	
;--------------------------------------------------------------

call_skid01
	php
	a8
	lda	#skid1 
	cmp	skid_lebel	
	bne	call_skid  
	plp
	rtl	
call_skid02
	php
	a8
	lda	#skid2	
	cmp	skid_lebel
	bne	call_skid
	plp
	rtl
call_skid03
	php
	a8
	lda	#skid3	
	cmp	skid_lebel
	bne	call_skid
	plp
	rtl
call_skid04
	php
	a8
	lda	#skid4	
	cmp	skid_lebel
	bne	call_skid
	plp
	rtl
call_skidend
	php
	a8
	lda	skid_lebel
	beq	nomoreend
	stz	skid_lebel
	se_cut5
	plp
	rtl

	shorta
call_skid
	sta	skid_lebel
       	jsl	call_sound0
nomoreend
	plp
	rtl
;------------------------------------------------------------
dart_on
	php
	a8
	lda	dart_flag
	bne	continue_dart
	dec	dart_flag
	lda	#dart_sound
	jsl	call_sound0	
continue_dart	
nomore_dart
	plp
	rtl
dart_off
	php
	a8
	lda	dart_flag
	beq	nomore_dart
	stz	dart_flag
	se_cut5			;dart se uses channel no.5
	plp
	rtl
;---------------------------------------------------------
brake_on
	php
	a8
	lda	brake_flag
	bne	continue_brake
	dec	brake_flag
	lda	#brake_sound
	jsl	call_sound0	
continue_brake	
nomore_brake
	plp
	rtl
brake_off
	php
	a8
	lda	brake_flag
	beq	nomore_brake
	stz	brake_flag
	se_cut5			;brake se uses channel no.5
	plp
	rtl
;---------------------------------------------------------
				;a=set data!!!
call_sound0
	phb
	pha
	phy
	phx
	php
	ai8
;;;	ldx	#0ffh
;;;;	stx	soundgate
	ldy	#07eh
	phy
	plb
	ldx	sound_selecter
	bne	.nomore0
	ldy	sound0number
	beq	.firstset0
	cpy	#10h
	bcs	.nomore0
	pha
	tya
	clc
	adc	sound0pointer
	cmp	#10h
	bcc	.notover0
	sbc	#10h
.notover0	
	tay
	pla
	sta	sound0buffer,y
	inc	sound0number
;;;	lda	#0
;;;;	sta.l	soundgate
	plp
	plx
	ply
	pla
	plb
	rtl
.firstset0
	inc	sound0number
	ldy	sound0pointer
	sta	sound0buffer,y
.nomore0
;;;	lda	#0
;;;	sta.l	soundgate											
	plp
	plx
	ply
	pla
	plb
	rtl

;---------------------------------------------------------
				;a=set data!!!
call_sound1
	phb
	pha
	phy
	phx
	php
	ai8
;;;	ldx	#0ffh
;;;;	stx	soundgate
	ldx	#07eh
	phx
	plb
	ldx	sound_selecter
	bne	.nomore1
	ldx	sound1number
	beq	.firstset1
	cpx	#10h
	bcs	.nomore1
	pha
	txa
	clc
	adc	sound1pointer
	cmp	#10h
	bcc	.notover1
	sbc	#10h
.notover1	
	tax
	pla
	sta	sound1buffer,x
	inc	sound1number
;;;   ;	lda	#0
;;;;	sta	soundgate
	plp
	plx
	ply
	pla
	plb
	rtl
.firstset1
	inc	sound1number
	ldx	sound1pointer
	sta	sound1buffer,x
.nomore1
;;;;	lda	#0
;;;;	sta	soundgate
	plp
	plx
	ply
	pla
	plb
	rtl
;---------------------------------------------------------
clear_sound
	php
	ai8
	lda	#00
	sta	sound_selecter
	sta	sound0stock
	sta	sound1stock
	sta	sound0pointer
	sta	sound1pointer
	sta	sound1number
	sta	sound0number
	sta.l	enginesound+00
	sta.l	enginesound+01
	sta.l	2143h
	plp
	rtl

;---------------------------------------------------------

boot_apu
	longi
	a8
	sty	address+0
	sta	address+2
	ldy	#0
;---------------------------------------------------------
	ldx	#0bbaah
boot_initial
	cpx  	apu_port0
	bne	boot_initial
	lda	#0cch
	bra	boot_entry1
;---------------------------------------------------------
boot_repeat
	jsr	get_data
	xba
	lda	#0
	bra	boot_entry2
boot_loop
	xba
	jsr	get_data
	xba
boot_wait1
	cmp	apu_port0
	bne	boot_wait1
	inc	a
;---------------------------------------------------------
boot_entry2
	a16
	sta	apu_port0
	a8
	dex
	bne	boot_loop
boot_wait2
	cmp	apu_port0
	bne	boot_wait2
boot_zero
	adc	#3
	beq	boot_zero
;---------------------------------------------------------
boot_entry1
	pha
	jsr	get_data
	xba
	jsr	get_data
	xba
	tax
	jsr	get_data
	sta	apu_port2
	jsr	get_data
	sta	apu_port3
;---------------------------------------------------------
	cpx	#1
	lda	#0
	rol	a
	sta	apu_port1
	adc	#07fh
	pla
	sta	apu_port0
boot_wait3
	cmp	apu_port0
	bne	boot_wait3
	bvs	boot_repeat
	rtl

get_data	
	lda	[address],y
	iny
	cpy	#08000h
	bne	get_exit
	inc	address+2
	ldy	#0
get_exit
	rts


; Retail nearby-car audio consumer, US $07:edc1-$07:ee10.
; A8, D=0, DB=0; P restored, A/X/Y and x1 scratch. Uses the retail
; queues below. TODO: Bind gameplay callers with the retail SPC driver.
; The cached level is retained on stop, including the native same-level
; re-entry behavior; muted updates leave all state untouched.
update_nearsound_l
	php
	lda	racesound_mute
	bne	.done
	ai16
	lda.l	m_nearcarapproach
	bmi	.off
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	sta	x1
	lda.l	m_nearcarpan
	asl	a
	asl	a
	asl	a
	asl	a
	ora	x1
	a8
	sta.l	racesound_nearparam
	a16
	lda	#$31
	sec
	sbc.l	m_nearcarband
	cmp	racesound_nearlevel
	beq	.ret
	sta	racesound_nearlevel
	jsl	queue_racesound1_l
	stz	racesound_nearoff
	jsl	start_nearsound_l
.ret
	plp
	rtl
.off
	a8
	lda	#1
	sta	racesound_nearoff
	jsl	stop_nearsound_l
.done
	plp
	rtl


; Retail nearby-car start/voice check, US $04:d533-$04:d5a1.
; A8, D=0, DB=0; P restored, A/X/Y scratch (native I8 truncation).
; Nonnegative GSU approach and valid bound player/selected car required.
; CAR_RETAILDEF remains unbound for early-format definitions.
start_nearsound_l
	php
	ai8
	lda	racesound_nearactive
	bne	.done
	dec	racesound_nearactive
	lda	#$1d
	jsl	queue_racesound1_l
	a8
	lda.l	racesound_voiceoff
	bne	.done
	ai16
	phx
	lda.l	m_playercar
	tax
	lda.l	mrambank+CAR_ROUTESLOT,x
	sta.l	racesound_rank
	lda.l	m_nearcar
	tax
	lda.l	mrambank+CAR_ROUTESLOT,x
	cmp.l	racesound_rank
	bcc	.skipvoice
	lda.l	mrambank+CAR_RETAILDEF,x
	plx
	cmp	#CARsounddef_1
	beq	.voice1
	cmp	#CARsounddef_2
	beq	.voice2
	cmp	#CARsounddef_3
	beq	.voice3
	bra	.done
.voice1
	a8
	lda	#$1d
	jsl	queue_raceplayer_l
	bra	.done
.voice2
	a8
	lda	#$1f
	jsl	queue_raceplayer_l
	bra	.done
.voice3
	a8
	lda	#$1e
	jsl	queue_raceplayer_l
.done
	plp
	rtl
.skipvoice
	plx
	plp
	rtl


; Retail nearby-car stop, US $04:d5a2-$04:d5b2.
; A8, D=0, DB=0; P restored, A scratch. Queue rejection still clears
; the active byte, as in the native start/stop bookkeeping.
stop_nearsound_l
	php
	lda	racesound_nearactive
	beq	.done
	stz	racesound_nearactive
	lda	#8
	jsl	queue_racesound1_l
.done
	plp
	rtl


; Retail command queues, US $04:d649-$04:d6e0. D=0; A/X/Y/DB and
; entry widths restored; final N/Z follow PLB. Full queues drop commands.
; The player-routed entry ORs $80 for a nonzero player selector.
; Indices/counts are bytes with native one-subtraction wrap behavior.
queue_racesound0_l
	phb
	pha
	phy
	phx
	php
	ai8
	ldy	#0
	phy
	plb
	bra	racesound0_put
queue_raceplayer_l
	phb
	pha
	phy
	phx
	php
	ai8
	ldy	#0
	phy
	plb
	ldx	racesound_player
	beq	racesound0_put
	ora	#$80
racesound0_put
	ldx	racesound_gate
	bne	.done
	ldy	racesound0number
	beq	.first
	cpy	#$10
	bcs	.done
	pha
	tya
	clc
	adc	racesound0pointer
	cmp	#$10
	bcc	.wrap
	sbc	#$10
.wrap
	tay
	pla
	sta	racesound0buffer,y
	inc	racesound0number
	plp
	plx
	ply
	pla
	plb
	rtl
.first
	inc	racesound0number
	ldy	racesound0pointer
	sta	racesound0buffer,y
.done
	plp
	plx
	ply
	pla
	plb
	rtl
queue_racesound1_l
	phb
	pha
	phy
	phx
	php
	ai8
	ldx	#0
	phx
	plb
	ldx	racesound_gate
	bne	.done
	ldx	racesound1number
	beq	.first
	cpx	#$10
	bcs	.done
	pha
	txa
	clc
	adc	racesound1pointer
	cmp	#$10
	bcc	.wrap
	sbc	#$10
.wrap
	tax
	pla
	sta	racesound1buffer,x
	inc	racesound1number
	plp
	plx
	ply
	pla
	plb
	rtl
.first
	inc	racesound1number
	ldx	racesound1pointer
	sta	racesound1buffer,x
.done
	plp
	plx
	ply
	pla
	plb
	rtl


; Retail queue/port reset, US $04:d6e1-$04:d713.
; P restored; A/X/Y scratch. Does not reset the near-level/active cache.
clear_racesound_l
	php
	ai8
	lda	#0
	sta.l	racesound_gate
	sta.l	racesound0stock
	sta.l	racesound1stock
	sta.l	racesound0pointer
	sta.l	racesound1pointer
	sta.l	racesound1number
	sta.l	racesound0number
	sta.l	racesound_dart
	sta.l	racesound_brake
	sta.l	apu_port3
	sta.l	apu_port2
	plp
	rtl


; Retail port service, US $02:8e39-$02:8ed4. D=0, DB=0.
; P restored; A/X/Y scratch. Pending direct writes precede blocking/frame
; gates. Queued commands advance only on a zero SPC input port.
; FIXME: RTL replaces the native local RTS at each exit.
; TODO: Bind NMI service with retail driver data and engine parameter.
racesound_ports_l
	php
	ai8
	lda	racesound_pending0
	beq	.pending1
	sta	apu_port0
	stz	racesound_pending0
	plp
	rtl
.pending1
	lda	racesound_pending1
	beq	.gates
	sta	apu_port1
	stz	racesound_pending1
	plp
	rtl
.gates
	lda	racesound_block0
	bne	.done
	lda	racesound_block1
	bne	.done
	lda	framecounter
	bit	#1
	bne	.port0
.done
	plp
	rtl
.port0
	lda	apu_port0
	bne	.busy0
	lda	racesound0number
	beq	.port1
	ldx	racesound0pointer
	lda	racesound0buffer,x
	dec	racesound0number
	beq	.write0
	inx
	cpx	#$10
	bcc	.pointer0
	ldx	#0
.pointer0
	stx	racesound0pointer
.write0
	bra	.send0
.busy0
	lda	#0
.send0
	sta	apu_port0
.port1
	lda	apu_port1
	bne	.busy1
	lda	racesound1number
	beq	.parameters
	ldx	racesound1pointer
	lda	racesound1buffer,x
	dec	racesound1number
	beq	.write1
	inx
	cpx	#$10
	bcc	.pointer1
	ldx	#0
.pointer1
	stx	racesound1pointer
.write1
	bra	.send1
.busy1
	lda	#0
.send1
	sta	apu_port1
	sta	racesound1stock
.parameters
	lda	racesound_mute
	bne	.muted
	lda	racesound_nearparam
	sta	apu_port2
	lda	racesound_engineparam
	sta	apu_port3
	plp
	rtl
.muted
	lda	#0
	sta	apu_port2
	sta	apu_port3
	plp
	rtl
