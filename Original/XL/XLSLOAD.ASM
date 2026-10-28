; Retail audio reload/selection, US $04:d0db-$04:d462.
; Original bank 4 module. D=0, DB=0, decimal clear; reload/init restore P,
; A/X/Y and x2 scratch. Retail data addresses below are not the early
; sound assets: bind their placement and callers before scheduling.

	incpublics	xlsload.ext

racesound_reload_l
	php
	a8
	lda	racesound_block0
	beq	raceload_mode
	plp
	rtl
raceload_mode
	lda	racesound_block1
	bne	raceload_full
	brl	raceload_scene
raceload_full
	lda	racesound_reloadonce
	beq	raceload_upload
	brl	raceload_done
raceload_upload
	dec	racesound_reloadonce
	ai16
	jsl	racesound_stopwait_l
	php
	ai16
	lda	#$0005
	sta.l	apu_port1
	lda	#$4000
raceload_delay1
	dec	a
	bne	raceload_delay1
	lda	#$0019
	ldy	#$8d4c
	jsl	racesound_boot_l
	a16
	lda	#$4000
raceload_delay2
	dec	a
	bne	raceload_delay2
	plp
	lda	#$4000
raceload_delay3
	dec	a
	bne	raceload_delay3
	lda	#$0005
	sta.l	apu_port1
	a16
	lda	#$4000
raceload_delay4
	dec	a
	bne	raceload_delay4
	ldx	#$0000
raceload_copy
	lda.l	$1e9b2c,x
	sta.l	$706000,x
	inx
	inx
	cpx	#$1518
	bcc	raceload_copy
	ldy	#$6000
	lda	#$0070
	jsl	racesound_boot_l
	a16
	lda	#$4000
raceload_delay5
	dec	a
	bne	raceload_delay5
	php
	ai16
	lda	#$0005
	sta.l	apu_port1
	lda	#$4000
raceload_delay6
	dec	a
	bne	raceload_delay6
	lda	#$001b
	ldy	#$b8a0
	jsl	racesound_boot_l
	a16
	lda	#$4000
raceload_delay7
	dec	a
	bne	raceload_delay7
	plp
	jsl	clear_racesound_l
	a8
	lda	#$04
	sta	apu_port0
raceload_done
	plp
	rtl
raceload_scene
	ai16
	lda	racesound_scene
	asl	a
	clc
	adc	racesound_scene
	and	#$00ff
	tax
	phx
	ai16
	jsl	racesound_stopwait_l
	lda.l	raceload_songtab+2,x
	and	#$00ff
	tay
	lda.l	raceload_songtab,x
	jsl	racesound_unpack_l
	a16
	i16
	jsl	racesound_wait_l
	ai16
	plx
	phx
	ai16
	lda.l	raceload_musictab,x
	cmp	#$ffff
	beq	raceload_musicdone
	tay
	jsl	racesound_stopwait_l
	lda.l	raceload_musictab+2,x
	and	#$00ff
	jsl	racesound_boot_l
raceload_musicdone
	a16
	i16
	jsl	racesound_wait_l
	a16
	lda	racesound_kind0
	jsr	raceload_instruments
	jsl	racesound_wait_l
	ai16
	plx
	ai16
	lda.l	raceload_extratab,x
	cmp	#$ffff
	beq	raceload_extradone
	tay
	jsl	racesound_stopwait_l
	lda.l	raceload_extratab+2,x
	and	#$00ff
	jsl	racesound_boot_l
raceload_extradone
	a16
	i16
	jsl	racesound_wait_l
	a8
	lda	racesound_playmode
	cmp	#$01
	bne	raceload_settle
	lda	racesound_extraoff
	bne	raceload_settle
	php
	ai16
	lda	#$0005
	sta.l	apu_port1
	lda	#$4000
raceload_delay8
	dec	a
	bne	raceload_delay8
	lda	#$f9b8
	ldy	#$001d
	jsl	racesound_unpack_l
	plp
raceload_settle
	a8
raceload_ports
	lda	apu_port0
	bne	raceload_ports
	lda	apu_port1
	bne	raceload_ports
	lda	apu_port2
	bne	raceload_ports
	lda	apu_port3
	bne	raceload_ports
	plp
	rtl
	longa
raceload_instruments
	and	#$000f
	sta	x2
	asl	a
	clc
	adc	x2
	tax
	phx
	jsl	racesound_stopwait_l
	ai16
	lda.l	raceload_inst0tab,x
	cmp	#$ffff
	beq	raceload_inst0done
	tay
	jsl	racesound_stopwait_l
	lda.l	raceload_inst0tab+2,x
	and	#$00ff
	jsl	racesound_boot_l
raceload_inst0done
	a16
	i16
	jsl	racesound_wait_l
	ai16
	plx
	lda	racesound_playmode
	and	#$00ff
	cmp	#$0002
	beq	raceload_split
raceload_inst1
	ai16
	lda.l	raceload_inst1tab,x
	cmp	#$ffff
	beq	raceload_inst1done
	tay
	jsl	racesound_stopwait_l
	lda.l	raceload_inst1tab+2,x
	and	#$00ff
	jsl	racesound_boot_l
raceload_inst1done
	a16
	i16
	jsl	racesound_wait_l
	rts
raceload_split
	jsl	racesound_stopwait_l
	lda	racesound_kind1
	and	#$000f
	sta	x2
	asl	a
	clc
	adc	x2
	tax
	lda.l	raceload_inst0tab,x
	tax
	ldy	#$3000
	a8
	phb
	a16
	lda	#$0fff
	db	$54,$70,$19	; MVN #$19,#$70; SASMX block-move encoding
	a8
	plb
	a16
	lda.l	$703002
	clc
	adc	#$0010
	sta.l	$703002
	lda.l	$703004
	clc
	adc	#$0d30
	sta.l	$703004
	lda.l	$703006
	clc
	adc	#$0d30
	sta.l	$703006
	lda.l	$703016
	clc
	adc	#$0d30
	sta.l	$703016
	ldy	#$3000
	lda	#$0070
	jsl	racesound_boot_l
	jsl	racesound_wait_l
	rts

; Native five-byte kind map and three 28-entry scene catalogues.
; Zero entries are retained literally; the code tests $ffff, not zero.
raceload_kindmap
	db	$06,$0c,$09,$0f,$12
raceload_songtab
	dw	$8000
	db	$1e
	dw	$cffd
	db	$1e
	dw	$deb4
	db	$1d
	dw	$afc6
	db	$1e
	dw	$f018
	db	$1d
	dw	$cffd
	db	$1e
	dw	$f8ad
	db	$1e
	dw	$afc6
	db	$1e
	dw	$91bc
	db	$1e
	dw	$deb4
	db	$1d
	dw	$d7a9
	db	$1e
	dw	$afc6
	db	$1e
	dw	$f018
	db	$1d
	dw	$ec10
	db	$1d
	dw	$d7a9
	db	$1e
	dw	$e90d
	db	$1e
	dw	$8000
	db	$1e
	dw	$deb4
	db	$1d
	dw	$91bc
	db	$1e
	dw	$afc6
	db	$1e
	dw	$f370
	db	$1d
	dw	$f370
	db	$1d
	dw	$f370
	db	$1d
	dw	$f6b4
	db	$1d
	dw	$f6b4
	db	$1d
	dw	$f6b4
	db	$1d
	dw	$f6b4
	db	$1d
	dw	$f370
	db	$1d
raceload_musictab
	dw	$a68a
	db	$1b
	dw	$9b9a
	db	$1b
	dw	$85f8
	db	$1b
	dw	$85f8
	db	$1b
	dw	$a68a
	db	$1b
	dw	$9b9a
	db	$1b
	dw	$b8a0
	db	$1b
	dw	$85f8
	db	$1b
	dw	$a68a
	db	$1b
	dw	$85f8
	db	$1b
	dw	$a68a
	db	$1b
	dw	$85f8
	db	$1b
	dw	$a68a
	db	$1b
	dw	$a68a
	db	$1b
	dw	$a68a
	db	$1b
	dw	$a68a
	db	$1b
	dw	$a68a
	db	$1b
	dw	$85f8
	db	$1b
	dw	$a68a
	db	$1b
	dw	$85f8
	db	$1b
	dw	$a68a
	db	$1b
	dw	$a68a
	db	$1b
	dw	$a68a
	db	$1b
	dw	$b8a0
	db	$1b
	dw	$b8a0
	db	$1b
	dw	$b8a0
	db	$1b
	dw	$b8a0
	db	$1b
	dw	$a68a
	db	$1b
raceload_extratab
	dw	$de54
	db	$1b
	dw	$d5fc
	db	$1b
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$d5fc
	db	$1b
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$cf30
	db	$1b
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$d5fc
	db	$1b
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$d5fc
	db	$1b
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$0000
	db	$00
	dw	$de54
	db	$1b
	dw	$de54
	db	$1b
	dw	$de54
	db	$1b
	dw	$e210
	db	$1b
	dw	$e210
	db	$1b
	dw	$e210
	db	$1b
	dw	$e210
	db	$1b
	dw	$0000
	db	$00
raceload_inst0tab
	dw	$9a98
	db	$19
	dw	$8000
	db	$19
	dw	$8d4c
	db	$19
	dw	$a7e4
	db	$19
	dw	$b530
	db	$19
raceload_inst1tab
	dw	$db39
	db	$1a
	dw	$db39
	db	$1a
	dw	$db39
	db	$1a
	dw	$db39
	db	$1a
	dw	$e885
	db	$1a

; Stop/wait and initial upload, US $04:d43c-$04:d462.
racesound_stopwait_l
	a8
	lda	#$05
	sta	apu_port1
racesound_wait_l
	a16
	lda	#$4000
raceload_delay
	dec	a
	bne	raceload_delay
	rtl
racesound_init_l
	php
	ai16
	lda	#$0019
	ldy	#$c27c
	jsl	racesound_boot_l
	a16
	lda	#$4000
raceload_initdelay
	dec	a
	bne	raceload_initdelay
	plp
	rtl

; Unpack/upload wrapper, US $03:f05e-$03:f0df. A16/I16.
; A=end pointer, Y=bank. Three native raw-copy identities bypass GSU
; decrunch; all other inputs use the surviving verified mdecrunch.
; Scratch $70:6000 and decoder arguments; no early gameplay hook.
racesound_unpack_l
	cmp	#$8000
	bne	raceunpack_try1
	ldx	#$0000
raceunpack_copy0
	lda.l	$1e8000,x
	sta.l	$706000,x
	inx
	inx
	cpx	#$11f8
	bcc	raceunpack_copy0
	bra	raceunpack_upload
raceunpack_try1
	cmp	#$91bc
	bne	raceunpack_try2
	ldx	#$0000
raceunpack_copy1
	lda.l	$1e91bc,x
	sta.l	$706000,x
	inx
	inx
	cpx	#$11f8
	bcc	raceunpack_copy1
	bra	raceunpack_upload
raceunpack_try2
	cmp	#$afc6
	bne	raceunpack_unpack
	ldx	#$0000
raceunpack_copy2
	lda.l	$1eafc6,x
	sta.l	$706000,x
	inx
	inx
	cpx	#$0dac
	bcc	raceunpack_copy2
	bra	raceunpack_upload
raceunpack_unpack
	sta.l	m_enddata
	lda	#$6000
	sta.l	m_decaddr
	lda	#$0000
	sta.l	m_decoffset
	tya
	sta.l	m_enddatabnk
	a8
	lda	#mdecrunch>>16
	ldx	#mdecrunch&WM
	jsl	runmario_l
	ai16
raceunpack_upload
	ldy	#$6000
	lda	#$0070
	jsl	racesound_boot_l
	a16
	lda	#$4000
raceunpack_wait
	dec	a
	bne	raceunpack_wait
	rtl
