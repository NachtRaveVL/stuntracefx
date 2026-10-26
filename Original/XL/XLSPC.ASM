; Retail SPC700 startup/control fragments, US driver uploaded to $0670/$10b0.
; Partial driver overlay, not a complete boot image: remaining driver code,
; tables, samples and scene streams must be assembled before scheduling.
; The early XLSND0.BIN path is unchanged. No host entry point calls SPC PCs.

	incpublics	xlspc.ext

spc_control	equ	$00f1
spc_dspaddr	equ	$00f2
spc_dspdata	equ	$00f3
spc_port0	equ	$00f4
spc_port1	equ	$00f5
spc_port2	equ	$00f6
spc_port3	equ	$00f7
spc_timer0target	equ	$00fa
spc_timer0counter	equ	$00fd

; Unrestored SPC routines retain their native RAM addresses.
spc_stopmusic	equ	$0a60
spc_musicstep	equ	$0a6f
spc_echodelay	equ	$0d73
spc_pitchstep	equ	$0fd6
spc_112f	equ	$112f
spc_117c	equ	$117c
spc_11f8	equ	$11f8
spc_13fa	equ	$13fa
spc_dispatchsfx	equ	$1424
spc_1436	equ	$1436
spc_1523	equ	$1523
spc_15c4	equ	$15c4
spc_16b1	equ	$16b1
spc_16c1	equ	$16c1
spc_16f1	equ	$16f1
spc_174b	equ	$174b
spc_resetpause	equ	$1798
spc_1b23	equ	$1b23
spc_1b2c	equ	$1b2c
spc_1b7a	equ	$1b7a
spc_1b92	equ	$1b92
spc_1c07	equ	$1c07
spc_restoreeffect	equ	$219c
spc_cac0	equ	$cac0
spc_ffc0	equ	$ffc0

racesound_spcctrl

	spc_block	spc_reloadblock,$0675,$004e

; Driver receiver: preserve working RAM, acknowledge CC and stream into [14].
spc_receive
	spc_mov_a_i	$aa
	spc_mov_abs_a	spc_port0
	spc_mov_a_i	$bb
	spc_mov_abs_a	spc_port1
spc_waitcc
	spc_mov_a_abs	spc_port0
	spc_cmp_a_i	$cc
	spc_bne	spc_waitcc
	spc_bra	spc_readheader
spc_waitzero
	spc_mov_y_abs	spc_port0
	spc_bne	spc_waitzero
spc_receivebyte
	spc_cmp_y_abs	spc_port0
	spc_bne	spc_receiveheader
	spc_mov_a_abs	spc_port1
	spc_mov_abs_y	spc_port0
	spc_mov_dpi_y_a	$14
	spc_inc_y
	spc_bne	spc_receivebyte
spc_receivepage
	spc_inc_dp	$15
	spc_bra	spc_receivebyte
spc_receiveheader
	spc_bpl	spc_receivebyte
	spc_cmp_y_abs	spc_port0
	spc_bpl	spc_receivebyte
spc_readheader
	spc_mov_a_abs	spc_port2
	spc_mov_y_abs	spc_port3
	spc_mov_dp_ya	$14
	spc_mov_y_abs	spc_port0
	spc_mov_a_abs	spc_port1
	spc_mov_abs_y	spc_port0
	spc_bne	spc_waitzero
spc_receivedone
	spc_mov_x_i	$31
	spc_mov_abs_x	spc_control
	spc_jmp	spc_boot
	spc_endblock	$004e

	spc_block	spc_bootblock,$0800,$00f3

; Boot: clear DP/state, initialize DSP and timer 0; enter the polling loop.
spc_boot
	spc_clrp
	spc_mov_x_i	$cf
	spc_mov_sp_x
	spc_mov_a_i	$00
	spc_mov_x_a
spc_clearpage0
	spc_mov_xinc_a
	spc_cmp_x_i	$e0
	spc_bne	spc_clearpage0
	spc_inc_a
	spc_call	spc_echodelay
	spc_mov_a_i	$00
	spc_mov_x_a
spc_clearpage2
	spc_mov_abs_x_a	$0200
	spc_inc_x
	spc_bne	spc_clearpage2
spc_clearpage3
	spc_mov_abs_x_a	$0300
	spc_inc_x
	spc_bne	spc_clearpage3
spc_clearpage4
	spc_mov_abs_x_a	$0400
	spc_inc_x
	spc_bne	spc_clearpage4
spc_clearpage5
	spc_mov_abs_x_a	$0500
	spc_inc_x
	spc_cmp_x_i	$90
	spc_bne	spc_clearpage5
	spc_mov_x_a
	spc_inc_a
spc_initpitch
	spc_mov_abs_x_a	$0361
	spc_inc_x
	spc_inc_x
	spc_cmp_x_i	$10
	spc_bne	spc_initpitch
	spc_mov_a_i	$60
	spc_mov_y_i	$0c
	spc_call	spc_writereg
	spc_mov_y_i	$1c
	spc_call	spc_writereg
	spc_mov_a_i	$3f
	spc_mov_y_i	$5d
	spc_call	spc_writereg
	spc_mov_a_i	$30
	spc_mov_abs_a	spc_control
	spc_mov_a_i	$10
	spc_mov_abs_a	spc_timer0target
	spc_mov_dp_a	$53
	spc_mov_a_i	$01
	spc_mov_abs_a	spc_control
	spc_dec_a
	spc_mov_dp_a	$04
	spc_mov_dp_a	$05
	spc_mov_dp_a	$06
	spc_mov_dp_a	$07
	spc_dec_a
	spc_mov_dp_a	$46

; Commit DSP shadows, mix the PRNG, and schedule control/music work by timer carry.
spc_main
	spc_mov_y_i	$0a
spc_writedsp
	spc_cmp_y_i	$05
	spc_beq	spc_checkecho
	spc_bcs	spc_dspvalue
	spc_cmp_dp_dp	$4c,$4d
	spc_bne	spc_nextdsp
spc_checkecho
	spc_bbs	7,$4c,spc_nextdsp
spc_dspvalue
	spc_mov_a_abs_y	$3f9f
	spc_mov_abs_a	spc_dspaddr
	spc_mov_a_abs_y	$06c2
	spc_mov_x_a
	spc_mov_a_x
	spc_mov_abs_a	spc_dspdata
spc_nextdsp
	spc_dbnz_y	spc_writedsp
	spc_mov_dp_y	$45
	spc_mov_dp_y	$46
	spc_mov_a_dp	$18
	spc_eor_a_dp	$19
	spc_lsr_a
	spc_lsr_a
	spc_notc
	spc_ror_dp	$18
	spc_ror_dp	$19
spc_waittimer
	spc_mov_y_abs	spc_timer0counter
	spc_beq	spc_waittimer
	spc_push_y
	spc_mov_a_i	$20
	spc_mul_ya
	spc_clrc
	spc_adc_a_dp	$43
	spc_mov_dp_a	$43
	spc_bcc	spc_musictimer
	spc_call	spc_controlstep
	spc_cmp_dp_dp	$4c,$4d
	spc_beq	spc_musictimer
	spc_inc_dp	$4c
spc_musictimer
	spc_mov_a_dp	$53
	spc_pop_y
	spc_mul_ya
	spc_clrc
	spc_adc_a_dp	$51
	spc_mov_dp_a	$51
	spc_bcc	spc_subtick
	spc_call	spc_musicstep
spc_pollports
	spc_mov_x_i	$03
spc_08c1
	spc_call	spc_readport
	spc_dec_x
	spc_bpl	spc_08c1
	spc_bra	spc_main
spc_subtick
	spc_mov_a_dp	$1c
	spc_beq	spc_main
	spc_mov_x_i	$00
	spc_mov_dp_i	$47,$01
spc_pitchloop
	spc_mov_a_dp_x	$31
	spc_beq	spc_nextpitch
	spc_call	spc_pitchstep
spc_nextpitch
	spc_inc_x
	spc_inc_x
	spc_asl_dp	$47
	spc_bne	spc_pitchloop
	spc_jmp	spc_main

; Echo the previous value; sample an input port twice until stable.
spc_readport
	spc_mov_a_dp_x	$04
	spc_mov_abs_x_a	spc_port0
spc_stableport
	spc_mov_a_abs_x	spc_port0
	spc_cmp_a_abs_x	spc_port0
	spc_bne	spc_stableport
	spc_mov_abs_x_a	$0558
	spc_ret
	spc_endblock	$00f3

	spc_block	spc_dspblock,$09e0,$0024

; Per-voice write gate, raw DSP access, and advancing song-word reader.
spc_writevoice
	spc_push_a
	spc_mov_a_dp	$47
	spc_and_a_dp	$1a
	spc_pop_a
	spc_bne	spc_writedone
spc_writereg
	spc_mov_abs_y	spc_dspaddr
	spc_mov_abs_a	spc_dspdata
spc_writedone
	spc_ret
spc_readreg
	spc_mov_abs_y	spc_dspaddr
	spc_mov_a_abs	spc_dspdata
	spc_ret
spc_readsongword
	spc_mov_y_i	$00
	spc_mov_a_dpi_y	$40
	spc_incw_dp	$40
	spc_push_a
	spc_mov_a_dpi_y	$40
	spc_incw_dp	$40
	spc_mov_y_a
	spc_pop_a
	spc_ret
	spc_endblock	$0024

	spc_block	spc_inputblock,$10b0,$007f

; Edge-detect port 0; ports 1-3 remain level values. Dispatch control stages.
spc_controlstep
	spc_mov_a_abs	$0558
	spc_cmp_a_dp	$04
	spc_beq	spc_samecommand
	spc_mov_a_abs	$0558
	spc_mov_dp_a	$04
	spc_mov_dp_a	$00
	spc_bra	spc_readparameters
spc_samecommand
	spc_mov_dp_i	$00,$00
spc_readparameters
	spc_mov_a_abs	$0559
	spc_mov_dp_a	$05
	spc_mov_dp_a	$01
	spc_mov_a_abs	$055a
	spc_mov_dp_a	$06
	spc_mov_dp_a	$02
	spc_mov_a_abs	$055b
	spc_mov_dp_a	$07
	spc_mov_dp_a	$03
	spc_bbc	1,$29,spc_dispatchcontrols
	spc_clr	0,$29
	spc_clr	1,$29
spc_dispatchcontrols
	spc_call	spc_remapcommand
	spc_call	spc_15c4
	spc_call	spc_fadestep
	spc_call	spc_musiccommand
	spc_call	spc_112f
	spc_call	spc_1b7a
	spc_call	spc_1b2c
	spc_call	spc_1523
	spc_call	spc_117c
	spc_call	spc_11f8
	spc_call	spc_1b92
	spc_call	spc_16f1
	spc_call	spc_174b
	spc_call	spc_16c1
	spc_call	spc_13fa
	spc_call	spc_1436
	spc_call	spc_cac0
	spc_call	spc_16b1
	spc_call	spc_effectcommand
	spc_jmp	spc_1c07
spc_remapcommand
	spc_bbc	7,$2d,spc_remapdone
	spc_cmp_dp_i	$01,$09
	spc_bne	spc_1126
	spc_mov_dp_i	$01,$12
spc_1126
	spc_cmp_dp_i	$01,$0a
	spc_bne	spc_remapdone
	spc_mov_dp_i	$01,$0c
spc_remapdone
	spc_ret
	spc_endblock	$007f

	spc_block	spc_commandblock,$17a5,$037e

; Port 0 low seven bits: music commands 1-5, effect identity from 6 upward.
spc_musiccommand
	spc_mov_dp_i	$1d,$00
	spc_mov_a_dp	$00
	spc_and_a_i	$7f
	spc_beq	spc_nomusiccommand
	spc_setc
	spc_sbc_a_i	$06
	spc_bmi	spc_changemusic
	spc_inc_a
	spc_mov_dp_a	$1d
	spc_ret
spc_nomusiccommand
	spc_mov_dp_a	$1d
	spc_ret
spc_changemusic
	spc_bbs	0,$29,spc_commanddone
	spc_mov_a_dp	$00
	spc_mov_dp_a	$1b
	spc_cmp_a_i	$02
	spc_bne	spc_17c5
spc_17c5
	spc_mov_a_i	$00
	spc_mov_dp_a	$2e
	spc_mov_dp_a	$2f
	spc_mov_abs_a	$0553
	spc_mov_abs_a	$0554
	spc_mov_abs_a	$0555
	spc_clr	0,$29
	spc_clr	1,$29
	spc_clr	6,$29
	spc_clr	2,$2c
	spc_clr	3,$2c
spc_commanddone
	spc_ret

; Port 1 repeated commands are suppressed; dispatch the 61-entry command table.
spc_effectcommand
	spc_mov_a_dp	$01
	spc_cmp_a_dp	$09
	spc_bne	spc_newcommand
	spc_mov_dp_i	$20,$00
	spc_bra	spc_cachecommand
spc_newcommand
	spc_mov_dp_dp	$20,$01
spc_cachecommand
	spc_mov_dp_dp	$09,$01
	spc_mov_a_dp	$20
	spc_setc
	spc_sbc_a_i	$3e
	spc_bmi	spc_decodecommand
	spc_mov_dp_i	$20,$00
spc_decodecommand
	spc_mov_a_dp	$20
	spc_beq	spc_commanddone
	spc_dec_a
	spc_asl_a
	spc_mov_x_a
	spc_jmp_abs_x	spc_commandtable

; Command bytes $01-$3d; retain aliases and unused RET entries.
spc_commandtable
	dw	spc_unusedcommand,spc_unusedcommand,spc_unusedcommand,spc_unusedcommand
	dw	spc_requestreload,spc_requestipl,spc_unusedcommand,spc_stopchannel4
	dw	spc_startchannel5_25,spc_stopchannel5_25,spc_stopchannel5_15,spc_stopchannel5_17
	dw	spc_startchannel5_15,spc_stopchannel5_21,spc_setmode0,spc_clearmodes
	dw	spc_setmode1,spc_startchannel5_17,spc_startchannel5_21,spc_unusedcommand
	dw	spc_beginpause,spc_resumepause,spc_unusedcommand,spc_unusedcommand
	dw	spc_unusedcommand,spc_unusedcommand,spc_unusedcommand,spc_unusedcommand
	dw	spc_startchannel4,spc_unusedcommand,spc_unusedcommand,spc_unusedcommand
	dw	spc_unusedcommand,spc_endpause,spc_changeengine,spc_restoreengine
	dw	spc_unusedcommand,spc_unusedcommand,spc_unusedcommand,spc_unusedcommand
	dw	spc_unusedcommand,spc_1b23,spc_1b23,spc_1b23
	dw	spc_1b23,spc_1b23,spc_1b23,spc_1b23
	dw	spc_1b23,spc_seteffectvariant,spc_seteffectvariant,spc_seteffectvariant
	dw	spc_seteffectvariant,spc_unusedcommand,spc_unusedcommand,spc_unusedcommand
	dw	spc_unusedcommand,spc_changenear,spc_restorenear,spc_unusedcommand
	dw	spc_unusedcommand
spc_startchannel4
	spc_bbs	3,$2d,spc_unusedcommand
	spc_set	6,$2a
	spc_mov_a_i	$02
	spc_bra	spc_starteffect
spc_startchannel5_25
	spc_bbs	6,$2d,spc_unusedcommand
	spc_set	2,$2a
	spc_mov_a_i	$25
	spc_bra	spc_starteffect
spc_startchannel5_15
	spc_bbs	6,$2d,spc_unusedcommand
	spc_set	4,$2a
	spc_mov_a_i	$15
	spc_bra	spc_starteffect
spc_startchannel5_17
	spc_bbs	6,$2d,spc_unusedcommand
	spc_set	0,$2a
	spc_mov_a_i	$17
	spc_bra	spc_starteffect
spc_startchannel5_21
	spc_bbs	6,$2d,spc_unusedcommand
	spc_set	7,$2a
	spc_mov_a_i	$21
spc_starteffect
	spc_jmp	spc_dispatchsfx

; Engine parameter transition, flags 29 bits 2/3; header delta is $0200.
spc_changeengine
	spc_bbs	2,$29,spc_unusedcommand
	spc_set	2,$29
	spc_clr	3,$29
	spc_mov_a_i	$00
	spc_mov_y_i	$02
	spc_bra	spc_18ce
spc_restoreengine
	spc_bbc	2,$29,spc_unusedcommand
	spc_clr	2,$29
	spc_set	3,$29
	spc_mov_a_abs	$0549
	spc_mov_y_abs	$054b
	spc_mov_dp_i	$20,$00
	spc_mov_dp_i	$21,$02
	spc_subw_ya_dp	$20
spc_18ce
	spc_mov_abs_a	$0549
	spc_mov_abs_y	$054b
	spc_ret
spc_unusedcommand
	spc_ret

; Nearby parameter transition, flags 28 bits 2/3; header delta is $0040.
spc_changenear
	spc_bbs	2,$28,spc_unusedcommand
	spc_set	2,$28
	spc_clr	3,$28
	spc_mov_a_i	$40
	spc_mov_y_i	$00
	spc_bra	spc_18f8
spc_restorenear
	spc_bbc	2,$28,spc_unusedcommand
	spc_clr	2,$28
	spc_set	3,$28
	spc_mov_a_abs	$054d
	spc_mov_y_abs	$054f
	spc_mov_dp_i	$20,$40
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
spc_18f8
	spc_mov_abs_a	$054d
	spc_mov_abs_y	$054f
	spc_ret
spc_seteffectvariant
	spc_mov_a_dp	$20
	spc_setc
	spc_sbc_a_i	$32
	spc_mov_abs_a	$0530
	spc_ret

; Release only the matching effect/channel; preserve unrelated active voices.
spc_stopchannel4
	spc_clr	6,$2a
	spc_mov_a_abs	$0394
	spc_cmp_a_i	$02
	spc_bne	spc_194b
	spc_mov_x_i	$04
	spc_bra	spc_releasesfx
spc_stopchannel5_25
	spc_clr	2,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$25
	spc_bne	spc_194b
	spc_bra	spc_channel5
spc_stopchannel5_15
	spc_clr	4,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$15
	spc_bne	spc_194b
	spc_bra	spc_channel5
spc_stopchannel5_17
	spc_clr	0,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$17
	spc_bne	spc_194b
	spc_bra	spc_channel5
spc_stopchannel5_21
	spc_clr	7,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$21
	spc_bne	spc_194b
spc_channel5
	spc_mov_x_i	$05
spc_releasesfx
	spc_mov_a_abs_x	$0408
	spc_beq	spc_194b
	spc_mov_a_dp	$20
	spc_mov_abs_x_a	$03e0
spc_194b
	spc_ret
spc_releasechannel
	spc_mov_dp_i	$20,$01
	spc_bra	spc_releasesfx

; Mode flags and pause save/restore retain original command aliases.
spc_setmode0
	spc_clr	1,$28
	spc_set	0,$28
	spc_ret
spc_clearmodes
	spc_clr	0,$28
	spc_clr	1,$28
	spc_ret
spc_setmode1
	spc_clr	0,$28
	spc_set	1,$28
spc_195f
	spc_ret
spc_endpause
	spc_bbc	0,$29,spc_195f
	spc_mov_a_i	$4c
	spc_call	spc_dispatchsfx
	spc_clr	0,$29
	spc_mov_a_i	$00
	spc_mov_abs_a	$045f
	spc_mov_abs_a	$045e
	spc_mov_abs_a	$045d
	spc_mov_abs_a	$045c
	spc_mov_abs_a	$04ff
	spc_mov_abs_a	$04fe
	spc_mov_abs_a	$04fd
	spc_mov_abs_a	$04fc
	spc_call	spc_stopmusic
	spc_jmp	spc_resetpause
spc_resumepause
	spc_bbc	0,$29,spc_195f
	spc_mov_dp_dp	$2a,$2b
	spc_bbc	7,$29,spc_19a9
	spc_clr	7,$29
	spc_mov_a_abs	$0574
	spc_mov_dp_a	$4a
	spc_mov_a_abs	$0575
	spc_mov_dp_a	$4e
	spc_mov_a_abs	$0576
	spc_mov_dp_a	$61
	spc_mov_a_abs	$0577
	spc_mov_dp_a	$63
spc_19a9
	spc_mov_a_i	$4b
	spc_call	spc_dispatchsfx
	spc_clr	0,$29
	spc_clr	6,$2d
	spc_mov_x_i	$07
	spc_call	spc_restorevoice
	spc_dec_x
	spc_call	spc_restorevoice
	spc_dec_x
	spc_call	spc_restorevoice
	spc_dec_x
	spc_call	spc_restorevoice
	spc_mov_x_i	$01
	spc_call	spc_releasechannel
	spc_dec_x
	spc_jmp	spc_releasechannel
spc_restorevoice
	spc_mov_a_abs_x	$0460
	spc_mov_abs_x_a	$03c8
	spc_mov_a_abs_x	$0458
	spc_beq	spc_19e7
	spc_push_a
	spc_call	spc_effectpointer
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0458
	spc_pop_a
	spc_push_x
	spc_call	spc_restoreeffect
	spc_pop_x
	spc_ret
spc_19e7
	spc_jmp	spc_releasechannel
spc_effectpointer
	spc_dec_a
	spc_asl_a
	spc_mov_y_a
	spc_mov_a_abs_y	$0702
	spc_mov_dp_a	$24
	spc_inc_y
	spc_mov_a_abs_y	$0702
	spc_mov_dp_a	$25
	spc_ret
spc_beginpause
	spc_bbs	0,$29,spc_1a67
	spc_mov_dp_dp	$2b,$2a
	spc_mov_dp_i	$2a,$00
	spc_mov_a_abs	$0551
	spc_beq	spc_1a2b
	spc_set	7,$29
	spc_set	6,$2d
	spc_mov_a_dp	$4a
	spc_mov_abs_a	$0574
	spc_mov_a_dp	$4e
	spc_mov_abs_a	$0575
	spc_mov_a_dp	$61
	spc_mov_abs_a	$0576
	spc_mov_a_dp	$63
	spc_mov_abs_a	$0577
	spc_mov_a_i	$50
	spc_mov_dp_a	$4e
	spc_mov_a_i	$11
	spc_mov_dp_a	$61
	spc_mov_a_i	$11
	spc_mov_dp_a	$63
spc_1a2b
	spc_set	0,$29
	spc_mov_a_i	$4a
	spc_call	spc_dispatchsfx
	spc_mov_x_i	$07
	spc_call	spc_savevoice
	spc_dec_x
	spc_call	spc_savevoice
	spc_dec_x
	spc_call	spc_savevoice
	spc_dec_x
	spc_call	spc_savevoice
	spc_mov_x_i	$07
	spc_call	spc_releasechannel
	spc_dec_x
	spc_call	spc_releasechannel
	spc_dec_x
	spc_call	spc_releasechannel
	spc_dec_x
	spc_jmp	spc_releasechannel
spc_savevoice
	spc_mov_a_abs_x	$04f8
	spc_beq	spc_1a68
spc_1a59
	spc_mov_a_abs_x	$04f8
	spc_mov_abs_x_a	$0458
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$04f8
	spc_mov_abs_x_a	$0480
spc_1a67
	spc_ret
spc_1a68
	spc_mov_a_abs_x	$0480
	spc_beq	spc_1a67
	spc_cmp_a_i	$02
	spc_beq	spc_1a59
	spc_mov_a_abs_x	$03c8
	spc_mov_abs_x_a	$0460
	spc_mov_a_abs_x	$0390
	spc_mov_abs_x_a	$0458
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0480
	spc_ret

; Stop all eight voices; ramp state decides deferred versus immediate reload.
spc_stopvoices
	spc_mov_dp_i	$2a,$00
	spc_call	spc_beginramp
	spc_mov_x_i	$07
spc_1a8b
	spc_call	spc_stopvoice
	spc_dec_x
	spc_bpl	spc_1a8b
	spc_ret
spc_stopvoice
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$04f8
	spc_mov_abs_x_a	$0480
	spc_mov_dp_a	$2a
	spc_mov_a_abs_x	$0408
	spc_beq	spc_1aa9
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$04c0
	spc_mov_abs_x_a	$04c8
spc_1aa9
	spc_ret
spc_beginramp
	spc_bbs	0,$29,spc_1aaf
	spc_set	6,$29
spc_1aaf
	spc_ret

; Advance the $02f0 fixed-point ramp; retain the native high-byte acceptance test.
spc_fadestep
	spc_bbc	6,$29,spc_fadeidle
	spc_mov_a_i	$f0
	spc_mov_y_i	$02
	spc_addw_ya_dp	$2e
	spc_mov_dp_a	$2e
	spc_mov_dp_y	$2f
	spc_mov_a_i	$00
	spc_mov_y_abs	$0564
	spc_subw_ya_dp	$2e
	spc_mov_abs_y	$0565
	spc_cmp_y_i	$00
	spc_beq	spc_fadedone
	spc_cmp_y_i	$01
	spc_beq	spc_fadedone
	spc_cmp_y_i	$02
	spc_beq	spc_fadedone
	spc_cmp_y_i	$03
	spc_beq	spc_fadedone
	spc_ret
spc_fadedone
	spc_mov_a_i	$00
	spc_mov_dp_a	$2e
	spc_mov_dp_a	$2f
	spc_clr	6,$29
	spc_bbs	7,$2c,spc_receiverrestart
	spc_bbs	0,$2d,spc_iplrestart
	spc_jmp	spc_stopmusic
spc_receiverrestart
	spc_call	spc_keyoffall
	spc_jmp	spc_receive
spc_keyoffall
	spc_mov_a_i	$ff
	spc_mov_y_i	$5c
	spc_jmp	spc_writereg
spc_fadeidle
	spc_mov_a_dp	$59
	spc_mov_abs_a	$0564
	spc_mov_abs_a	$0565
	spc_ret

; Command 5: custom receiver. Command 6: re-enable and enter the hardware IPL.
spc_requestreload
	spc_call	spc_stopvoices
	spc_mov_a_dp	$59
	spc_beq	spc_receiverrestart
	spc_set	7,$2c
	spc_ret
spc_requestipl
	spc_set	0,$2d
	spc_call	spc_stopvoices
	spc_mov_a_dp	$59
	spc_beq	spc_iplrestart
	spc_set	0,$2d
	spc_ret
spc_iplrestart
	spc_call	spc_keyoffall
	spc_mov_a_abs	spc_control
	spc_or_a_i	$80
	spc_mov_abs_a	spc_control
	spc_jmp	spc_ffc0
	spc_endblock	$037e

	dw	0,spc_boot
racesound_spcctrlend
