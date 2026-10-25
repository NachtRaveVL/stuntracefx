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

; Retail controller sound edges/holds, US $04:d040-$04:d0da.
; D=0, DB=0, decimal clear. P restored; A/X/Y scratch. Mode 6 only.
; Y selects contiguous player state; callers supply accumulated triggers
; and kind 0..4. Nonzero player selector routes the edge command.
racesound_buttons1_l
	php
	ai8
	lda	racesound_mute
	bne	racebuttons1_done
	lda	racesound_mode1
	cmp	#$06
	bne	racebuttons1_done
	a16
	lda	racesound_trigger1
	jsr	racesound_pressed
	a16
	lda	cont1l
	jsr	racesound_held
racebuttons1_done
	plp
	rtl
racesound_buttons0_l
	php
	ai8
	lda	racesound_mute
	bne	racebuttons0_done
	lda	racesound_mode0
	cmp	#$06
	bne	racebuttons0_done
	a16
	lda	racesound_trigger0
	jsr	racesound_pressed
	a16
	lda	cont0l
	jsr	racesound_held
racebuttons0_done
	plp
	rtl
	longa
racesound_held
	bit	#$8000
	bne	raceheld_on
	bit	#$4000
	beq	raceheld_off
raceheld_on
	a8
	lda	racesound_held0,y
	bne	raceheld_done
	dec	a
	sta	racesound_held0,y
	cpy	#$00
	bne	raceheld_on1
	lda	#$3a
	bra	raceheld_queue
raceheld_on1
	lda	#$3c
	bra	raceheld_queue
raceheld_off
	a8
	lda	racesound_held0,y
	beq	raceheld_done
	lda	#$00
	sta	racesound_held0,y
	cpy	#$00
	bne	raceheld_off1
	lda	#$3b
	bra	raceheld_queue
raceheld_off1
	lda	#$3d
raceheld_queue
	jsl	queue_racesound1_l
raceheld_done
	rts
	longa
racesound_pressed
	pha
	bit	#$0040
	beq	racepressed_done
	ai8
	lda	racesound_kind0,y
	tax
	lda.l	racesound_buttoncodes,x
	jsl	queue_raceplayer_l
racepressed_done
	a16
	pla
	rts
racesound_buttoncodes
	db	$22,$39,$2b,$60,$21

; Retail player-specific effects, US $04:d463-$04:d532 and d5b3-d648.
; D=0, DB=0, decimal clear. P restored; scratch registers follow queues.
; Effect cache updates persist even when a full/gated queue drops commands.
racesound_effect1_l
	php
	a8
	lda	racesound_player
	bne	raceeffect1_player1
	lda	#$32
	cmp.l	racesound_effect0
	bne	racesound_effect0_put
	plp
	rtl
raceeffect1_player1
	lda	#$36
	cmp.l	racesound_effect1
	bne	racesound_effect1_put
	plp
	rtl
racesound_effect2_l
	php
	a8
	lda	racesound_player
	bne	raceeffect2_player1
	lda	#$33
	cmp.l	racesound_effect0
	bne	racesound_effect0_put
	plp
	rtl
raceeffect2_player1
	lda	#$37
	cmp.l	racesound_effect1
	bne	racesound_effect1_put
	plp
	rtl
racesound_effectend_l
	php
	a8
	lda	racesound_player
	bne	raceeffectend_player1
	lda.l	racesound_effect0
	beq	raceeffect_done
	lda	#$00
	sta.l	racesound_effect0
	lda	#$0a
	jsl	queue_racesound1_l
	plp
	rtl
raceeffectend_player1
	lda.l	racesound_effect1
	beq	raceeffect_done
	lda	#$00
	sta.l	racesound_effect1
	lda	#$1a
	jsl	queue_racesound1_l
	plp
	rtl
racesound_effect0_put
	pha
	lda.l	racesound_effect0
	bne	raceeffect0_queue
	lda	#$09
	jsl	queue_racesound1_l
raceeffect0_queue
	pla
	sta.l	racesound_effect0
	jsl	queue_racesound1_l
raceeffect_done
	plp
	rtl
racesound_effect1_put
	pha
	lda.l	racesound_effect1
	bne	raceeffect1_queue
	lda	#$14
	jsl	queue_racesound1_l
raceeffect1_queue
	pla
	sta.l	racesound_effect1
	jsl	queue_racesound1_l
	plp
	rtl
racesound_effect3_l
	php
	a8
	lda	racesound_player
	bne	raceeffect3_player1
	lda	#$34
	cmp.l	racesound_effect0
	bne	racesound_effect0_put
	plp
	rtl
raceeffect3_player1
	lda	#$38
	cmp.l	racesound_effect1
	bne	racesound_effect1_put
	plp
	rtl
racesound_effect4_l
	php
	a8
	lda	racesound_player
	bne	raceeffect4_player1
	lda	#$35
	cmp.l	racesound_effect0
	bne	racesound_effect0_put
	plp
	rtl
raceeffect4_player1
	lda	#$39
	cmp.l	racesound_effect1
	bne	racesound_effect1_put
	plp
	rtl
racesound_cmd23_l
	php
	a8
	lda.l	racesound_player
	bne	racecmd23_player1
	lda	#$23
	jsl	queue_racesound1_l
	plp
	rtl
racecmd23_player1
	lda	#$25
	jsl	queue_racesound1_l
	plp
	rtl
racesound_cmd24_l
	php
	a8
	lda.l	racesound_player
	bne	racecmd24_player1
	lda	#$24
	jsl	queue_racesound1_l
	plp
	rtl
racecmd24_player1
	lda	#$26
	jsl	queue_racesound1_l
	plp
	rtl
racesound_cmd0d_l
	php
	a8
	lda.l	racesound_player
	bne	racecmd0d_player1
	lda	#$0d
	jsl	queue_racesound1_l
	plp
	rtl
racecmd0d_player1
	lda	#$18
	jsl	queue_racesound1_l
	plp
	rtl
racesound_cmd0b_l
	php
	a8
	lda.l	racesound_player
	bne	racecmd0b_player1
	lda	#$0b
	jsl	queue_racesound1_l
	plp
	rtl
racecmd0b_player1
	lda	#$1b
	jsl	queue_racesound1_l
	plp
	rtl
racesound_cmd12_l
	php
	a8
	lda.l	racesound_player
	bne	racecmd12_player1
	lda	#$12
	jsl	queue_racesound1_l
	plp
	rtl
racecmd12_player1
	lda	#$19
	jsl	queue_racesound1_l
	plp
	rtl
racesound_cmd0c_l
	php
	a8
	lda.l	racesound_player
	bne	racecmd0c_player1
	lda	#$0c
	jsl	queue_racesound1_l
	plp
	rtl
racecmd0c_player1
	lda	#$1c
	jsl	queue_racesound1_l
	plp
	rtl

; Retail engine parameter, copied WRAM $7f:112f-$7f:126f,
; ROM US $0b:892f-$0b:8a6f. A=GSU car or zero; D=0, DB=0.
; P restored; A/X/Y and x1 scratch. Reads held controller-0 B button.
; Engine owner selects a CPU alien; alx_retaildef is its bank-9 identity,
; not the early shape or general-purpose words. Retail producer pending.
; The native asymmetric speed/filter arithmetic and $ff00 sentinel remain.
racesound_engine_l
	php
	ai16
	sta	x1
	a8
	lda.l	racesound_voiceoff
	beq	raceengine_live
	lda.l	racesound_mode0
	cmp	#$06
	bcs	raceengine_special
	jsr	racesound_gridengine
	bra	raceengine_store
raceengine_live
	jsr	racesound_carspeed
	a8
	lda.l	racesound_mode0
	cmp	#$06
	bcs	raceengine_store
	ai16
	lda	racesound_revs
	bmi	raceengine_store
	jsr	racesound_enginefilter
raceengine_store
	a8
	lda	x1
	sta.l	racesound_engineparam
	plp
	rtl
raceengine_special
	jsr	racesound_carspeed
	a8
	lda	x1
	sta.l	racesound_engineparam
	plp
	rtl
racesound_enginefilter
	php
	ai16
	lda	racesound_revs
	cmp	x1
	beq	racefilter_release
	bcc	racefilter_rise
	sec
	sbc	#$0008
	sta	racesound_revs
	sec
	sbc	x1
	bpl	racefilter_adjusted
	bra	racefilter_release
racefilter_rise
	clc
	adc	#$0004
	sta	racesound_revs
	sec
	sbc	x1
	bpl	racefilter_adjusted
racefilter_release
	lda	#$ff00
	sta	racesound_revs
	bra	racefilter_done
racefilter_adjusted
	lda	racesound_revs
	sta	x1
racefilter_done
	plp
	rts
racesound_gridengine
	php
	ai16
	lda.l	cont0l
	and	#$8000
	bne	racegrid_accelerate
	lda.l	racesound_revs
	beq	racegrid_result
	sec
	sbc	#$000c
	bpl	racegrid_save
	lda	#$0000
racegrid_save
	sta.l	racesound_revs
	bra	racegrid_result
racegrid_accelerate
	lda.l	racesound_revs
	clc
	adc	#$0028
	cmp	#$00ff
	bcc	racegrid_saveaccel
	lda	#$00ff
racegrid_saveaccel
	sta.l	racesound_revs
racegrid_result
	lda.l	racesound_revs
	sta	x1
	plp
	rts
racesound_carspeed
	php
	ai16
	lda	x1
	cmp	#$0000
	bne	raceengine_car
	brl	raceengine_result
raceengine_car
	tax
	lda.l	mrambank+CAR_GNDSPEED,x
	bpl	raceengine_limit
	eor	#$ffff
	inc	a
	lsr	a
raceengine_limit
	cmp	#$0257
	bcc	raceengine_scale
	lda	#$0257
raceengine_scale
	lsr	a
	lsr	a
	bra	raceengine_lookup
	lda	#$0000
raceengine_lookup
	tax
	jsr	racesound_curveoffset
	a8
	lda.l	racesound_curves,x
raceengine_result
	a16
	and	#$00ff
	sta	x1
	plp
	rts
racesound_curveoffset
	php
	ai16
	txa
	sta.l	racesound_rank
	ldx	racesound_engineowner
	lda.l	alx_retaildef,x
	cmp	#$81b9
	beq	racecurve0
	cmp	#$853d
	beq	racecurve1
	cmp	#$8411
	beq	racecurve2
	cmp	#$82e5
	beq	racecurve3
	cmp	#$8669
	beq	racecurve4
	lda	#$0000
	bra	racecurve_index
racecurve0
	lda	#$0000
	bra	racecurve_index
racecurve1
	lda	#$0098
	bra	racecurve_index
racecurve2
	lda	#$0130
	bra	racecurve_index
racecurve3
	lda	#$01c8
	bra	racecurve_index
racecurve4
	lda	#$0260
racecurve_index
	clc
	adc.l	racesound_rank
	tax
	plp
	rts

; Five 152-byte engine curves, US $0b:b158-$0b:b44f.
; Identity/curve order is retained; vehicle names are not inferred.
racesound_curves
; curve 0
	db	$00,$08,$10,$18,$20,$28,$2c,$34,$3c,$44,$4c,$50,$58,$60,$68,$70
	db	$78,$7c,$84,$8c,$94,$9c,$a4,$a8,$b0,$b8,$c0,$c8,$cc,$d4,$dc,$e4
	db	$ec,$f4,$f8,$90,$94,$98,$9c,$a0,$a4,$a8,$ac,$ac,$b0,$b4,$b8,$bc
	db	$c0,$c4,$c8,$cc,$d0,$d4,$d8,$dc,$e0,$e0,$e4,$e8,$ec,$f0,$f4,$f8
	db	$fc,$a0,$a4,$a8,$a8,$ac,$b0,$b4,$b8,$b8,$bc,$c0,$c4,$c8,$c8,$cc
	db	$d0,$d4,$d4,$d8,$dc,$e0,$e4,$e4,$e8,$ec,$f0,$f4,$f4,$f8,$fc,$ac
	db	$b0,$b4,$b4,$b8,$bc,$c0,$c4,$c8,$c8,$cc,$d0,$d4,$d8,$dc,$dc,$e0
	db	$e4,$e8,$ec,$f0,$f0,$f4,$f8,$fc,$b8,$bc,$c0,$c4,$c4,$c8,$cc,$d0
	db	$d4,$d8,$d8,$dc,$e0,$e4,$e4,$e8,$ec,$ec,$f0,$f0,$f4,$f4,$f8,$f8
	db	$f8,$f8,$fc,$fc,$fc,$fc,$ff,$ff
; curve 1
	db	$00,$04,$0c,$10,$14,$18,$20,$24,$28,$2c,$34,$38,$3c,$44,$48,$4c
	db	$50,$58,$5c,$60,$64,$6c,$70,$74,$78,$80,$84,$88,$8c,$94,$98,$9c
	db	$a0,$a8,$ac,$b0,$b4,$bc,$c0,$c4,$cc,$d0,$d4,$d8,$e0,$e4,$e8,$ec
	db	$f4,$f8,$fc,$a0,$a4,$a8,$ac,$b0,$b4,$b8,$bc,$c0,$c4,$c8,$d0,$d4
	db	$d8,$dc,$e0,$e4,$e8,$ec,$f0,$f4,$f8,$fc,$b4,$b8,$bc,$bc,$c0,$c4
	db	$c4,$c8,$cc,$d0,$d4,$d4,$d8,$dc,$e0,$e4,$e4,$e8,$ec,$f0,$f0,$f4
	db	$f8,$fc,$c4,$c8,$c8,$cc,$d0,$d0,$d4,$d4,$d8,$dc,$dc,$e0,$e0,$e4
	db	$e4,$e8,$e8,$ec,$ec,$ec,$f0,$f0,$f0,$f0,$f4,$f4,$f4,$f4,$f4,$f4
	db	$f4,$f8,$f8,$f8,$f8,$f8,$f8,$f8,$f8,$f8,$f8,$fc,$fc,$fc,$fc,$fc
	db	$fc,$fc,$fc,$fc,$fc,$fc,$ff,$ff
; curve 2
	db	$00,$04,$08,$0c,$10,$14,$18,$1c,$20,$24,$28,$2c,$34,$38,$3c,$40
	db	$44,$48,$4c,$50,$54,$58,$5c,$60,$64,$68,$6c,$70,$74,$78,$7c,$80
	db	$84,$88,$8c,$90,$94,$9c,$a0,$a4,$a8,$ac,$b0,$b4,$b8,$bc,$c0,$c4
	db	$c8,$cc,$88,$8c,$90,$94,$98,$9c,$a0,$a4,$ac,$b0,$b4,$b8,$bc,$c0
	db	$c4,$c8,$cc,$d0,$8c,$90,$94,$98,$a0,$a4,$a8,$ac,$b0,$b4,$b8,$c0
	db	$c4,$c8,$cc,$d0,$d4,$90,$94,$98,$9c,$a0,$a0,$a4,$a8,$ac,$b0,$b4
	db	$b8,$bc,$c0,$c4,$c4,$c8,$cc,$d0,$d4,$d8,$dc,$e0,$e4,$e8,$e8,$ec
	db	$f0,$f4,$f8,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc
	db	$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc
	db	$fc,$fc,$fc,$fc,$fc,$fc,$ff,$ff
; curve 3
	db	$00,$04,$04,$08,$0c,$0c,$10,$10,$14,$18,$18,$1c,$20,$20,$24,$28
	db	$28,$2c,$2c,$30,$34,$34,$38,$3c,$3c,$40,$44,$44,$48,$48,$4c,$50
	db	$50,$54,$58,$58,$5c,$60,$60,$64,$64,$68,$6c,$6c,$70,$74,$74,$78
	db	$78,$7c,$80,$80,$84,$88,$88,$8c,$90,$94,$94,$98,$9c,$9c,$a0,$a4
	db	$a4,$a8,$ac,$ac,$b0,$b4,$b4,$b8,$b8,$bc,$c0,$c0,$c4,$c4,$c8,$cc
	db	$cc,$d0,$d0,$d4,$d4,$d8,$d8,$d8,$d8,$dc,$dc,$e0,$e0,$e0,$e4,$e4
	db	$e4,$e8,$e8,$e8,$e8,$ec,$ec,$ec,$ec,$ec,$f0,$f0,$f0,$f0,$f0,$f0
	db	$f0,$f4,$f4,$f4,$f4,$f4,$f4,$f4,$f4,$f4,$f4,$f8,$f8,$f8,$f8,$f8
	db	$f8,$f8,$f8,$f8,$f8,$f8,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc
	db	$fc,$fc,$fc,$fc,$fc,$fc,$ff,$ff
; curve 4
	db	$00,$04,$08,$0c,$10,$14,$14,$18,$1c,$20,$24,$28,$2c,$30,$34,$38
	db	$38,$3c,$40,$44,$48,$4c,$50,$54,$58,$5c,$5c,$60,$64,$68,$6c,$70
	db	$74,$78,$7c,$80,$80,$84,$88,$8c,$90,$50,$54,$58,$5c,$60,$64,$68
	db	$6c,$70,$74,$78,$7c,$80,$84,$88,$8c,$90,$94,$98,$9c,$a0,$a4,$a8
	db	$74,$78,$7c,$80,$84,$88,$8c,$90,$94,$98,$9c,$9c,$a0,$a4,$a8,$ac
	db	$ac,$b4,$b8,$bc,$c0,$c4,$c8,$90,$94,$98,$9c,$9c,$a0,$a4,$a8,$ac
	db	$b0,$b4,$b8,$b8,$bc,$c0,$c4,$c8,$cc,$d0,$d4,$d4,$d8,$dc,$e0,$e4
	db	$a8,$ac,$b0,$b4,$b8,$b8,$bc,$c0,$c4,$c8,$cc,$d0,$d4,$d4,$d8,$dc
	db	$e0,$e4,$e8,$e8,$ec,$f0,$f0,$f0,$f4,$f4,$f4,$f8,$f8,$f8,$f8,$f8
	db	$fc,$fc,$fc,$fc,$fc,$fc,$ff,$ff

; Retail SPC transfer, US $04:d720-$04:d7a1. A8/I16, D=0, DB=0.
; A low=stream bank, Y=address. Scratch A/X/Y/P and address..address+3.
; Blocking IPL handshake; caller must provide the corresponding SPC side.
; Handles LoROM crossing at base+Y carry, then base=0, Y=$8000.
; A later Y wrap with base=0 does not advance the bank, as in retail.
; Native A16 INC also touches the byte following the three-byte pointer.
; This API is not substituted for the early boot_apu or wired to NMI.
	longi
racesound_boot_l
	a8
	sty	address
	sta	address+2
	ldy	#$0000
	ldx	#$bbaa
raceboot_ready
	cpx	apu_port0
	bne	raceboot_ready
	lda	#$cc
	bra	raceboot_header
raceboot_block
	jsr	racesound_getbyte
	xba
	lda	#$00
	bra	raceboot_sendbyte
raceboot_byte
	xba
	jsr	racesound_getbyte
	xba
raceboot_ackbyte
	cmp	apu_port0
	bne	raceboot_ackbyte
	inc	a
raceboot_sendbyte
	a16
	sta	apu_port0
	a8
	dex
	bne	raceboot_byte
raceboot_ackblock
	cmp	apu_port0
	bne	raceboot_ackblock
raceboot_counter
	adc	#$03
	beq	raceboot_counter
raceboot_header
	pha
	jsr	racesound_getbyte
	xba
	jsr	racesound_getbyte
	xba
	tax
	jsr	racesound_getbyte
	sta	apu_port2
	jsr	racesound_getbyte
	sta	apu_port3
	cpx	#$0001
	lda	#$00
	rol	a
	sta	apu_port1
	adc	#$7f
	pla
	sta	apu_port0
raceboot_ackheader
	cmp	apu_port0
	bne	raceboot_ackheader
	bvs	raceboot_block
	rtl
racesound_getbyte
	lda	[address],y
	iny
	a16
	pha
	tya
	clc
	adc	address
	bcc	raceboot_getdone
	lda	#$0000
	sta	address
	ldy	#$8000
	inc	address+2
raceboot_getdone
	pla
	a8
	rts
