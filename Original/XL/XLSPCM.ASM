; Retail SPC music sequencer, pitch/volume updates and driver tables.
; Included inside the partial XLSPC overlay; native SPC RAM PCs are retained.
; Scene-specific song/instrument streams and final ROM placement remain.

spc_08f2	equ	$08f2

	spc_block	spc_metablock,$0670,$0005
spc_constants
	db	$94,$04,$26,$08,$53
	spc_endblock	$0005

	spc_block	spc_tablesblock,$06c3,$013d
spc_dpshadows
	db	$61,$63,$4e,$4a,$48,$45,$0e,$49,$4b,$46
spc_pitchscale
	dw	$085f,$08de,$0965,$09f4
	dw	$0a8c,$0b2c,$0bd6,$0c8b
	dw	$0d4a,$0e14,$0eea,$0fcd
	dw	$10be,$1518,$1659,$17ad
	dw	$1916,$1a94,$1c28,$1dd5
	dw	$1f9b
spc_version
	db	$2a,$56,$65,$72,$20,$53,$31,$2e,$32,$30,$2a
spc_effectpointers
	dw	spc_effect_c694,spc_effect_c677,spc_effect_be9c,spc_effect_c68a
	dw	spc_effect_bd73,spc_effect_c151,spc_effect_c680,spc_effect_bda9
	dw	spc_effect_bd14,spc_effect_c69e,spc_effect_bdb2,spc_effect_bd3e
	dw	spc_effect_c6a8,spc_effect_bca0,spc_effect_be7e,spc_effect_beb5
	dw	spc_effect_c463,spc_effect_c46b,spc_effect_c473,spc_effect_c47b
	dw	spc_effect_bfd2,spc_effect_bf21,spc_effect_bffa,spc_effect_c5f0
	dw	spc_effect_c616,spc_effect_c639,spc_effect_c6da,spc_effect_c653
	dw	spc_effect_c5e7,spc_effect_bfee,spc_effect_c589,spc_effect_bf55
	dw	spc_effect_bfe1,spc_effect_c172,spc_effect_c15f,spc_effect_c530
	dw	spc_effect_bfbf,spc_effect_c60d,spc_effect_c6ed,spc_effect_bfaf
	dw	spc_effect_c0f5,spc_effect_c598,spc_effect_c1e0,spc_effect_c454
	dw	spc_effect_be00,spc_effect_bdc1,spc_effect_be8d,spc_effect_bed3
	dw	spc_effect_bf74,spc_effect_c01a,spc_effect_c5a9,spc_effect_c630
	dw	spc_effect_c6ff,spc_effect_c09d,spc_effect_bcb0,spc_effect_bd2c
	dw	spc_effect_c714,spc_effect_c179,spc_effect_c143,spc_effect_c10b
	dw	spc_effect_c43d,spc_effect_c4e7,spc_effect_c17f,spc_effect_c41a
	dw	spc_effect_be23,spc_effect_be5a,spc_effect_be67,spc_effect_bf85
	dw	spc_effect_bf9a,spc_effect_c0b5,spc_effect_c0c8,spc_effect_c0d1
	dw	spc_effect_c0ec,spc_effect_c1fa,spc_effect_c1b1,spc_effect_c34f
	dw	spc_effect_c191,spc_effect_bddf,spc_effect_c3ea,spc_effect_c3f5
	dw	spc_effect_c3fb,spc_effect_c3ff,spc_effect_c483,spc_effect_c499
	dw	spc_effect_c4c0,spc_effect_c514,spc_effect_bce8,spc_effect_c66e
	dw	spc_effect_c726,spc_effect_c5c9,spc_effect_c643,spc_effect_bca0
	dw	spc_effect_c4ad,spc_effect_c56e,spc_effect_bd05,spc_effect_c552
	dw	spc_effect_c138,spc_effect_bf11,spc_effect_bebd,spc_effect_c1f3
	dw	spc_effect_c506,spc_effect_bf42,spc_effect_bcc9,spc_effect_c431
	dw	spc_effect_be41,spc_effect_c03b,spc_effect_c061,spc_effect_c37d
	dw	spc_effect_c395,spc_effect_c1c9,spc_effect_c237,spc_effect_c287
	dw	spc_effect_c2dc,spc_effect_c6c0,spc_effect_c6b9,spc_effect_c6b2
	dw	spc_effect_c6c7,spc_effect_c6ce,spc_effect_c6d5,spc_effect_c6d5
	dw	spc_effect_c6d5
spc_songpointers
	dw	spc_effect_c6d5,$ee40,spc_music_c8e2,spc_music_c735
	dw	$e0c0,spc_music_cb10
	spc_endblock	$013d

	spc_block	spc_noteblock,$08f3,$00ed
spc_noteon
	spc_cmp_y_i	$ca
	spc_bcc	spc_08fc
	spc_call	spc_instrument
	spc_mov_y_i	$a4
spc_08fc
	spc_cmp_y_i	$c8
	spc_bcs	spc_08f2
	spc_mov_a_dp	$1a
	spc_and_a_dp	$47
	spc_bne	spc_08f2
	spc_mov_a_y
	spc_and_a_i	$7f
	spc_clrc
	spc_adc_a_dp	$50
	spc_clrc
	spc_adc_a_abs_x	$02f0
	spc_mov_abs_x_a	$0361
	spc_mov_a_abs_x	$0381
	spc_mov_abs_x_a	$0360
	spc_mov_a_abs_x	$02b1
	spc_lsr_a
	spc_mov_a_i	$00
	spc_ror_a
	spc_mov_abs_x_a	$02a0
	spc_mov_a_i	$00
	spc_mov_dp_x_a	$b0
	spc_mov_abs_x_a	$0100
	spc_mov_abs_x_a	$02d0
	spc_mov_dp_x_a	$c0
	spc_or_dp_dp	$5e,$47
	spc_or_dp_dp	$45,$47
	spc_mov_a_abs_x	$0280
	spc_mov_dp_x_a	$a0
	spc_beq	spc_095a
	spc_mov_a_abs_x	$0281
	spc_mov_dp_x_a	$a1
	spc_mov_a_abs_x	$0290
	spc_bne	spc_0950
	spc_mov_a_abs_x	$0361
	spc_setc
	spc_sbc_a_abs_x	$0291
	spc_mov_abs_x_a	$0361
spc_0950
	spc_mov_a_abs_x	$0291
	spc_clrc
	spc_adc_a_abs_x	$0361
	spc_call	spc_pitchramp
spc_095a
	spc_call	spc_loadpitch
spc_calcpitch
; Correct the end ranges, interpolate the pitch-scale pair, shift by octave,
; then multiply by the instrument's tuning word. Keep byte/word wrap intact.
	spc_mov_y_i	$00
	spc_mov_a_dp	$11
	spc_setc
	spc_sbc_a_i	$34
	spc_bcs	spc_096f
	spc_mov_a_dp	$11
	spc_setc
	spc_sbc_a_i	$13
	spc_bcs	spc_0973
	spc_dec_y
	spc_asl_a
spc_096f
	spc_addw_ya_dp	$10
	spc_mov_dp_ya	$10
spc_0973
	spc_push_x
	spc_mov_a_dp	$11
	spc_asl_a
	spc_mov_y_i	$00
	spc_mov_x_i	$18
	spc_div_ya_x
	spc_mov_x_a
	spc_mov_a_abs_y	$06ce
	spc_mov_dp_a	$15
	spc_mov_a_abs_y	$06cd
	spc_mov_dp_a	$14
	spc_mov_a_abs_y	$06d0
	spc_push_a
	spc_mov_a_abs_y	$06cf
	spc_pop_y
	spc_subw_ya_dp	$14
	spc_mov_y_dp	$10
	spc_mul_ya
	spc_mov_a_y
	spc_mov_y_i	$00
	spc_addw_ya_dp	$14
	spc_mov_dp_y	$15
	spc_asl_a
	spc_rol_dp	$15
	spc_mov_dp_a	$14
	spc_bra	spc_09a6
spc_09a2
	spc_lsr_dp	$15
	spc_ror_a
	spc_inc_x
spc_09a6
	spc_cmp_x_i	$06
	spc_bne	spc_09a2
	spc_mov_dp_a	$14
	spc_pop_x
	spc_mov_a_abs_x	$0220
	spc_mov_y_dp	$15
	spc_mul_ya
	spc_mov_dp_ya	$16
	spc_mov_a_abs_x	$0220
	spc_mov_y_dp	$14
	spc_mul_ya
	spc_push_y
	spc_mov_a_abs_x	$0221
	spc_mov_y_dp	$14
	spc_mul_ya
	spc_addw_ya_dp	$16
	spc_mov_dp_ya	$16
	spc_mov_a_abs_x	$0221
	spc_mov_y_dp	$15
	spc_mul_ya
	spc_mov_y_a
	spc_pop_a
	spc_addw_ya_dp	$16
	spc_mov_dp_ya	$16
	spc_mov_a_xreg
	spc_xcn_a
	spc_lsr_a
	spc_or_a_i	$02
	spc_mov_y_a
	spc_mov_a_dp	$16
	spc_call	spc_writevoice
	spc_inc_y
	spc_mov_a_dp	$17
	spc_endblock	$00ed

	spc_block	spc_sequenceblock,$0a04,$0676
spc_resetmusic
	spc_mov_x_i	$0e
	spc_mov_dp_i	$47,$80
spc_0a09
	spc_mov_a_i	$ff
	spc_mov_abs_x_a	$0301
	spc_mov_a_i	$0a
	spc_call	spc_setpan
	spc_mov_abs_x_a	$0211
	spc_mov_abs_x_a	$0381
	spc_mov_abs_x_a	$02f0
	spc_mov_abs_x_a	$0280
	spc_mov_dp_x_a	$b1
	spc_mov_dp_x_a	$c1
	spc_dec_x
	spc_dec_x
	spc_lsr_dp	$47
	spc_bne	spc_0a09
	spc_mov_dp_a	$5a
	spc_mov_dp_a	$68
	spc_mov_dp_a	$54
	spc_mov_dp_a	$50
	spc_mov_dp_a	$42
	spc_mov_dp_a	$5f
	spc_mov_dp_i	$59,$c0
	spc_mov_dp_i	$53,$20
spc_0a3b
	spc_ret
spc_0a3c
	spc_bra	spc_stopmusic
spc_selectsong
	spc_mov_abs_a	$0584
	spc_mov_a_dp	$1b
	spc_beq	spc_0a81
	spc_mov_dp_a	$1c
	spc_mov_dp_i	$1b,$00
	spc_asl_a
	spc_mov_x_a
	spc_mov_a_abs_x	$07f5
	spc_mov_y_a
	spc_mov_a_abs_x	$07f4
	spc_mov_dp_ya	$40
	spc_mov_dp_i	$0c,$02
spc_0a58
	spc_mov_a_dp	$1a
	spc_eor_a_i	$ff
	spc_tset1_abs	$46
	spc_ret
spc_stopmusic
	spc_bbs	1,$29,spc_0a3b
	spc_set	1,$29
	spc_mov_dp_i	$1b,$00
	spc_mov_dp_i	$1c,$00
	spc_bra	spc_0a58
spc_0a6d
	spc_bra	spc_resetmusic
spc_musicstep
	spc_bbs	0,$29,spc_0a58
	spc_mov_a_dp	$1b
	spc_beq	spc_0a7b
	spc_cmp_a_abs	$0584
	spc_bne	spc_selectsong
spc_0a7b
	spc_mov_abs_a	$0584
	spc_mov_dp_i	$1b,$00
spc_0a81
	spc_mov_a_dp	$1c
	spc_beq	spc_0a3b
	spc_mov_a_dp	$0c
	spc_beq	spc_ticktracks
	spc_dbnz_dp	$0c,spc_0a6d
spc_songorder
	spc_call	spc_readsongword
	spc_bne	spc_0aa5
	spc_mov_y_a
	spc_beq	spc_0a3c
	spc_dec_dp	$42
	spc_bpl	spc_0a9a
	spc_mov_dp_a	$42
spc_0a9a
	spc_call	spc_readsongword
	spc_mov_x_dp	$42
	spc_beq	spc_songorder
	spc_mov_dp_ya	$40
	spc_bra	spc_songorder
spc_0aa5
	spc_mov_dp_ya	$16
	spc_mov_y_i	$0f
spc_0aa9
	spc_mov_a_dpi_y	$16
	spc_mov_abs_y_a	$30
	spc_dec_y
	spc_bpl	spc_0aa9
	spc_mov_x_i	$00
	spc_mov_dp_i	$47,$01
spc_0ab6
	spc_mov_a_dp_x	$31
	spc_beq	spc_0ac4
	spc_mov_a_abs_x	$0211
	spc_bne	spc_0ac4
	spc_mov_a_i	$00
	spc_call	spc_instrument
spc_0ac4
	spc_mov_a_i	$00
	spc_mov_dp_x_a	$80
	spc_mov_dp_x_a	$90
	spc_mov_dp_x_a	$91
	spc_inc_a
	spc_mov_dp_x_a	$70
	spc_inc_x
	spc_inc_x
	spc_asl_dp	$47
	spc_bne	spc_0ab6
spc_ticktracks
	spc_mov_x_i	$00
	spc_mov_dp_xreg	$5e
	spc_mov_dp_i	$47,$01
spc_0adc
	spc_mov_dp_xreg	$44
	spc_mov_a_dp_x	$31
	spc_beq	spc_0b4f
	spc_dec_dp_x	$70
	spc_bne	spc_0b49
spc_0ae6
	spc_call	spc_readtrack
	spc_bne	spc_0b06
	spc_mov_a_dp_x	$80
	spc_beq	spc_songorder
	spc_call	spc_trackrepeat
	spc_dec_dp_x	$80
	spc_bne	spc_0ae6
	spc_mov_a_abs_x	$0230
	spc_mov_dp_x_a	$30
	spc_mov_a_abs_x	$0231
	spc_mov_dp_x_a	$31
	spc_bra	spc_0ae6
spc_0b02
	spc_clr	0,$2c
	spc_bra	spc_songorder
spc_0b06
	spc_bbs	0,$2c,spc_0b02
	spc_bmi	spc_0b2b
	spc_mov_abs_x_a	$0200
	spc_call	spc_readtrack
	spc_bmi	spc_0b2b
	spc_push_a
	spc_xcn_a
	spc_and_a_i	$07
	spc_mov_y_a
	spc_mov_a_abs_y	$0650
	spc_mov_abs_x_a	$0201
	spc_pop_a
	spc_and_a_i	$0f
	spc_mov_y_a
	spc_mov_a_abs_y	$0658
	spc_mov_abs_x_a	$0210
	spc_call	spc_readtrack
spc_0b2b
	spc_cmp_a_i	$e0
	spc_bcc	spc_0b34
	spc_call	spc_songcommand
	spc_bra	spc_0ae6
spc_0b34
	spc_call	spc_noteon
	spc_mov_a_abs_x	$0200
	spc_mov_dp_x_a	$70
	spc_mov_y_a
	spc_mov_a_abs_x	$0201
	spc_mul_ya
	spc_mov_a_y
	spc_bne	spc_0b45
	spc_inc_a
spc_0b45
	spc_mov_dp_x_a	$71
	spc_bra	spc_0b4c
spc_0b49
	spc_call	spc_noteoff
spc_0b4c
	spc_call	spc_0dbc
spc_0b4f
	spc_inc_x
	spc_inc_x
	spc_asl_dp	$47
	spc_bne	spc_0adc
	spc_mov_a_dp	$54
	spc_beq	spc_0b64
	spc_mov_ya_dp	$56
	spc_addw_ya_dp	$52
	spc_dbnz_dp	$54,spc_0b62
	spc_mov_ya_dp	$54
spc_0b62
	spc_mov_dp_ya	$52
spc_0b64
	spc_mov_a_dp	$68
	spc_beq	spc_0b7d
	spc_mov_ya_dp	$64
	spc_addw_ya_dp	$60
	spc_mov_dp_ya	$60
	spc_mov_ya_dp	$66
	spc_addw_ya_dp	$62
	spc_dbnz_dp	$68,spc_0b7b
	spc_mov_ya_dp	$68
	spc_mov_dp_ya	$60
	spc_mov_y_dp	$6a
spc_0b7b
	spc_mov_dp_ya	$62
spc_0b7d
	spc_mov_a_dp	$5a
	spc_beq	spc_0b8f
	spc_mov_ya_dp	$5c
	spc_addw_ya_dp	$58
	spc_dbnz_dp	$5a,spc_0b8a
	spc_mov_ya_dp	$5a
spc_0b8a
	spc_mov_dp_ya	$58
	spc_mov_dp_i	$5e,$ff
spc_0b8f
	spc_mov_x_i	$00
	spc_mov_dp_i	$47,$01
spc_0b94
	spc_mov_a_dp_x	$31
	spc_beq	spc_0b9b
	spc_call	spc_tickvolume
spc_0b9b
	spc_inc_x
	spc_inc_x
	spc_asl_dp	$47
	spc_bne	spc_0b94
	spc_ret
spc_songcommand
; E0-FA: push the handler PC for RET dispatch, then read the first argument
; only when its length entry is nonzero. Later arguments use spc_readtrack.
	spc_asl_a
	spc_mov_y_a
	spc_mov_a_abs_y	$3f0b
	spc_push_a
	spc_mov_a_abs_y	$3f0a
	spc_push_a
	spc_mov_a_y
	spc_lsr_a
	spc_mov_y_a
	spc_mov_a_abs_y	$102f
	spc_beq	spc_0bbc
spc_readtrack
; Read [30+X], advance its little-endian cursor and leave the byte in A/Y.
	spc_mov_a_dpi_x	$30
spc_0bb6
	spc_inc_dp_x	$30
	spc_bne	spc_0bbc
	spc_inc_dp_x	$31
spc_0bbc
	spc_mov_y_a
	spc_ret
spc_instrument
	spc_mov_abs_x_a	$0211
	spc_mov_y_a
	spc_bpl	spc_0bca
	spc_setc
	spc_sbc_a_i	$ca
	spc_clrc
	spc_adc_a_dp	$5f
spc_0bca
	spc_mov_y_i	$06
	spc_mul_ya
	spc_mov_dp_ya	$14
	spc_clrc
	spc_adc_dp_i	$14,$90
	spc_adc_dp_i	$15,$05
	spc_mov_a_dp	$1a
	spc_and_a_dp	$47
	spc_bne	spc_0c16
	spc_push_x
	spc_mov_a_xreg
	spc_xcn_a
	spc_lsr_a
	spc_or_a_i	$04
	spc_mov_x_a
	spc_mov_y_i	$00
	spc_mov_a_dpi_y	$14
	spc_bpl	spc_0bf7
	spc_and_a_i	$1f
	spc_and_dp_i	$48,$20
	spc_tset1_abs	$48
	spc_or_dp_dp	$49,$47
	spc_mov_a_y
	spc_bra	spc_0bfe
spc_0bf7
	spc_mov_a_dp	$47
	spc_tclr1_abs	$49
spc_0bfc
	spc_mov_a_dpi_y	$14
spc_0bfe
	spc_mov_abs_x	$f2
	spc_mov_abs_a	$f3
	spc_inc_x
	spc_inc_y
	spc_cmp_y_i	$04
	spc_bne	spc_0bfc
	spc_pop_x
	spc_mov_a_dpi_y	$14
	spc_mov_abs_x_a	$0221
	spc_inc_y
	spc_mov_a_dpi_y	$14
	spc_mov_abs_x_a	$0220
spc_0c16
	spc_ret
spc_setpan
	spc_mov_abs_x_a	$0351
	spc_and_a_i	$1f
	spc_mov_abs_x_a	$0331
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0330
	spc_ret
spc_panramp
	spc_mov_dp_x_a	$91
	spc_push_a
	spc_call	spc_readtrack
	spc_mov_abs_x_a	$0350
	spc_setc
	spc_sbc_a_abs_x	$0331
	spc_pop_x
	spc_call	spc_divideslope
	spc_mov_abs_x_a	$0340
	spc_mov_a_y
	spc_mov_abs_x_a	$0341
	spc_ret
spc_0c3e
	spc_mov_abs_x_a	$02b0
	spc_call	spc_readtrack
	spc_mov_abs_x_a	$02a1
	spc_call	spc_readtrack
spc_0c4a
	spc_mov_dp_x_a	$b1
	spc_mov_abs_x_a	$02c1
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$02b1
	spc_ret
spc_0c55
	spc_mov_abs_x_a	$02b1
	spc_push_a
	spc_mov_y_i	$00
	spc_mov_a_dp_x	$b1
	spc_pop_x
	spc_div_ya_x
	spc_mov_x_dp	$44
	spc_mov_abs_x_a	$02c0
	spc_ret
spc_0c65
	spc_mov_a_i	$00
	spc_mov_dp_ya	$58
	spc_ret
spc_volumeramp
	spc_mov_dp_a	$5a
	spc_call	spc_readtrack
	spc_mov_dp_a	$5b
	spc_setc
	spc_sbc_a_dp	$59
	spc_mov_x_dp	$5a
	spc_call	spc_divideslope
	spc_mov_dp_ya	$5c
	spc_ret
spc_0c7c
	spc_mov_a_i	$00
	spc_mov_dp_ya	$52
	spc_ret
spc_temporamp
	spc_mov_dp_a	$54
	spc_call	spc_readtrack
	spc_mov_dp_a	$55
	spc_setc
	spc_sbc_a_dp	$53
	spc_mov_x_dp	$54
	spc_call	spc_divideslope
	spc_mov_dp_ya	$56
	spc_ret
spc_0c93
	spc_mov_dp_a	$50
	spc_ret
spc_0c96
	spc_mov_abs_x_a	$02f0
	spc_ret
spc_0c9a
	spc_mov_abs_x_a	$02e0
	spc_call	spc_readtrack
	spc_mov_abs_x_a	$02d1
	spc_call	spc_readtrack
spc_0ca6
	spc_mov_dp_x_a	$c1
	spc_ret
spc_0ca9
	spc_mov_a_i	$01
	spc_bra	spc_0caf
spc_0cad
	spc_mov_a_i	$00
spc_0caf
	spc_mov_abs_x_a	$0290
	spc_mov_a_y
	spc_mov_abs_x_a	$0281
	spc_call	spc_readtrack
	spc_mov_abs_x_a	$0280
	spc_call	spc_readtrack
	spc_mov_abs_x_a	$0291
	spc_ret
spc_0cc3
	spc_mov_abs_x_a	$0280
	spc_ret
spc_0cc7
	spc_mov_abs_x_a	$0301
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0300
	spc_ret
spc_0cd0
	spc_mov_dp_x_a	$90
	spc_push_a
	spc_call	spc_readtrack
	spc_mov_abs_x_a	$0320
	spc_setc
	spc_sbc_a_abs_x	$0301
	spc_pop_x
	spc_call	spc_divideslope
	spc_mov_abs_x_a	$0310
	spc_mov_a_y
	spc_mov_abs_x_a	$0311
	spc_ret
spc_0ce9
	spc_mov_abs_x_a	$0381
	spc_ret
spc_trackcall
	spc_mov_abs_x_a	$0240
	spc_call	spc_readtrack
	spc_mov_abs_x_a	$0241
	spc_call	spc_readtrack
	spc_mov_dp_x_a	$80
	spc_mov_a_dp_x	$30
	spc_mov_abs_x_a	$0230
	spc_mov_a_dp_x	$31
	spc_mov_abs_x_a	$0231
spc_trackrepeat
	spc_mov_a_abs_x	$0240
	spc_mov_dp_x_a	$30
	spc_mov_a_abs_x	$0241
	spc_mov_dp_x_a	$31
	spc_ret
spc_0d10
	spc_mov_dp_a	$4f
	spc_and_a_dp	$1a
	spc_eor_a_dp	$4f
	spc_mov_dp_a	$4a
	spc_call	spc_readtrack
	spc_mov_a_i	$00
	spc_mov_dp_ya	$60
	spc_call	spc_readtrack
	spc_mov_a_i	$00
	spc_mov_dp_ya	$62
	spc_clr	5,$48
	spc_ret
spc_0d29
	spc_mov_dp_a	$68
	spc_call	spc_readtrack
	spc_mov_dp_a	$69
	spc_setc
	spc_sbc_a_dp	$61
	spc_mov_x_dp	$68
	spc_call	spc_divideslope
	spc_mov_dp_ya	$64
	spc_call	spc_readtrack
	spc_mov_dp_a	$6a
	spc_setc
	spc_sbc_a_dp	$63
	spc_mov_x_dp	$68
	spc_call	spc_divideslope
	spc_mov_dp_ya	$66
	spc_ret
spc_0d4a
	spc_mov_dp_ya	$60
	spc_mov_dp_ya	$62
	spc_set	5,$48
	spc_ret
spc_setecho
	spc_call	spc_echodelay
	spc_call	spc_readtrack
	spc_mov_dp_a	$4e
	spc_call	spc_readtrack
	spc_mov_y_i	$08
	spc_mul_ya
	spc_mov_x_a
	spc_mov_y_i	$0f
spc_0d62
	spc_mov_a_abs_x	$3faa
	spc_call	spc_writereg
	spc_inc_x
	spc_mov_a_y
	spc_clrc
	spc_adc_a_i	$10
	spc_mov_y_a
	spc_bpl	spc_0d62
	spc_mov_x_dp	$44
	spc_ret
spc_echodelay
	spc_mov_dp_a	$4d
	spc_mov_y_i	$7d
	spc_mov_abs_y	$f2
	spc_mov_a_abs	$f3
	spc_cmp_a_dp	$4d
	spc_beq	spc_0dac
	spc_and_a_i	$0f
	spc_eor_a_i	$ff
	spc_bbc	7,$4c,spc_0d8b
	spc_clrc
	spc_adc_a_dp	$4c
spc_0d8b
	spc_mov_dp_a	$4c
	spc_mov_y_i	$04
spc_0d8f
	spc_mov_a_abs_y	$3f9f
	spc_mov_abs_a	$f2
	spc_mov_a_i	$00
	spc_mov_abs_a	$f3
	spc_dbnz_y	spc_0d8f
	spc_mov_a_dp	$48
	spc_or_a_i	$20
	spc_mov_y_i	$6c
	spc_call	spc_writereg
	spc_mov_a_dp	$4d
	spc_mov_y_i	$7d
	spc_call	spc_writereg
spc_0dac
	spc_asl_a
	spc_asl_a
	spc_asl_a
	spc_eor_a_i	$ff
	spc_setc
	spc_adc_a_i	$3f
	spc_mov_y_i	$6d
	spc_jmp	spc_writereg
spc_0db9
	spc_mov_dp_a	$5f
	spc_ret
spc_0dbc
	spc_mov_a_dp_x	$a0
	spc_bne	spc_0df3
	spc_mov_a_dpi_x	$30
	spc_cmp_a_i	$f9
	spc_bne	spc_0df3
	spc_call	spc_0bb6
	spc_call	spc_readtrack
spc_0dcc
	spc_mov_dp_x_a	$a1
	spc_call	spc_readtrack
	spc_mov_dp_x_a	$a0
	spc_call	spc_readtrack
	spc_clrc
	spc_adc_a_dp	$50
	spc_adc_a_abs_x	$02f0
spc_pitchramp
	spc_and_a_i	$7f
	spc_mov_abs_x_a	$0380
	spc_setc
	spc_sbc_a_abs_x	$0361
	spc_mov_y_dp_x	$a0
	spc_push_y
	spc_pop_x
	spc_call	spc_divideslope
	spc_mov_abs_x_a	$0370
	spc_mov_a_y
	spc_mov_abs_x_a	$0371
spc_0df3
	spc_ret
spc_loadpitch
	spc_mov_a_abs_x	$0361
	spc_mov_dp_a	$11
	spc_mov_a_abs_x	$0360
	spc_mov_dp_a	$10
	spc_ret
spc_divideslope
; A is the byte difference, X the duration, C indicates no borrow.
; Return the signed fractional slope in YA; duration zero keeps SPC DIV behavior.
; The negative path subtracts from DP 0E, which boot clears, rather than a literal.
	spc_notc
	spc_ror_dp	$12
	spc_bpl	spc_0e07
	spc_eor_a_i	$ff
	spc_inc_a
spc_0e07
	spc_mov_y_i	$00
	spc_div_ya_x
	spc_push_a
	spc_mov_a_i	$00
	spc_div_ya_x
	spc_pop_y
	spc_mov_x_dp	$44
spc_signslope
	spc_bbc	7,$12,spc_0e1a
	spc_mov_dp_ya	$14
	spc_mov_ya_dp	$0e
	spc_subw_ya_dp	$14
spc_0e1a
	spc_ret
spc_tickvolume
	spc_mov_a_dp_x	$90
	spc_beq	spc_0e43
	spc_or_dp_dp	$5e,$47
	spc_dec_dp_x	$90
	spc_bne	spc_0e30
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0300
	spc_mov_a_abs_x	$0320
	spc_bra	spc_0e40
spc_0e30
	spc_clrc
	spc_mov_a_abs_x	$0300
	spc_adc_a_abs_x	$0310
	spc_mov_abs_x_a	$0300
	spc_mov_a_abs_x	$0301
	spc_adc_a_abs_x	$0311
spc_0e40
	spc_mov_abs_x_a	$0301
spc_0e43
	spc_mov_y_dp_x	$c1
	spc_beq	spc_0e6a
	spc_mov_a_abs_x	$02e0
	spc_cbne_dp_x	$c0,spc_0e68
	spc_or_dp_dp	$5e,$47
	spc_mov_a_abs_x	$02d0
	spc_bpl	spc_0e5c
	spc_inc_y
	spc_bne	spc_0e5c
	spc_mov_a_i	$80
	spc_bra	spc_0e60
spc_0e5c
	spc_clrc
	spc_adc_a_abs_x	$02d1
spc_0e60
	spc_mov_abs_x_a	$02d0
	spc_call	spc_105c
	spc_bra	spc_0e6f
spc_0e68
	spc_inc_dp_x	$c0
spc_0e6a
	spc_mov_a_i	$ff
	spc_call	spc_1067
spc_0e6f
	spc_mov_a_dp_x	$91
	spc_beq	spc_0e97
	spc_or_dp_dp	$5e,$47
	spc_dec_dp_x	$91
	spc_bne	spc_0e84
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0330
	spc_mov_a_abs_x	$0350
	spc_bra	spc_0e94
spc_0e84
	spc_clrc
	spc_mov_a_abs_x	$0330
	spc_adc_a_abs_x	$0340
	spc_mov_abs_x_a	$0330
	spc_mov_a_abs_x	$0331
	spc_adc_a_abs_x	$0341
spc_0e94
	spc_mov_abs_x_a	$0331
spc_0e97
	spc_mov_a_dp	$47
	spc_and_a_dp	$5e
	spc_beq	spc_0ee3
	spc_mov_a_abs_x	$0331
	spc_mov_y_a
	spc_mov_a_abs_x	$0330
	spc_mov_dp_ya	$10
spc_writevolumes
	spc_mov_a_xreg
	spc_xcn_a
	spc_lsr_a
	spc_mov_dp_a	$12
spc_0eab
	spc_mov_y_dp	$11
	spc_mov_a_abs_y	$107b
	spc_setc
	spc_sbc_a_abs_y	$107a
	spc_mov_y_dp	$10
	spc_mul_ya
	spc_mov_a_y
	spc_mov_y_dp	$11
	spc_clrc
	spc_adc_a_abs_y	$107a
	spc_mov_y_a
	spc_mov_a_abs_x	$0321
	spc_mul_ya
	spc_mov_a_abs_x	$0351
	spc_asl_a
	spc_bbc	0,$12,spc_0ecb
	spc_asl_a
spc_0ecb
	spc_mov_a_y
	spc_bcc	spc_0ed1
	spc_eor_a_i	$ff
	spc_inc_a
spc_0ed1
	spc_mov_y_dp	$12
	spc_call	spc_writevoice
	spc_mov_y_i	$14
	spc_mov_a_i	$00
	spc_subw_ya_dp	$10
	spc_mov_dp_ya	$10
	spc_inc_dp	$12
	spc_bbc	1,$12,spc_0eab
spc_0ee3
	spc_ret
spc_noteoff
	spc_mov_a_dp_x	$71
	spc_beq	spc_0f4d
	spc_dec_dp_x	$71
	spc_beq	spc_0ef1
	spc_mov_a_i	$02
	spc_cbne_dp_x	$70,spc_0f4d
spc_0ef1
	spc_mov_a_dp_x	$80
	spc_mov_dp_a	$17
	spc_mov_a_dp_x	$30
	spc_mov_y_dp_x	$31
spc_0ef9
	spc_mov_dp_ya	$14
	spc_mov_y_i	$00
spc_0efd
	spc_mov_a_dpi_y	$14
	spc_beq	spc_0f1f
	spc_bmi	spc_0f0a
spc_0f03
	spc_inc_y
	spc_bmi	spc_0f46
	spc_mov_a_dpi_y	$14
	spc_bpl	spc_0f03
spc_0f0a
	spc_cmp_a_i	$c8
	spc_beq	spc_0f4d
	spc_cmp_a_i	$ef
	spc_beq	spc_0f3b
	spc_cmp_a_i	$e0
	spc_bcc	spc_0f46
	spc_push_y
	spc_mov_y_a
	spc_pop_a
	spc_adc_a_abs_y	$0faf
	spc_mov_y_a
	spc_bra	spc_0efd
spc_0f1f
	spc_mov_a_dp	$17
	spc_beq	spc_0f46
	spc_dec_dp	$17
	spc_bne	spc_0f31
	spc_mov_a_abs_x	$0231
	spc_push_a
	spc_mov_a_abs_x	$0230
	spc_pop_y
	spc_bra	spc_0ef9
spc_0f31
	spc_mov_a_abs_x	$0241
	spc_push_a
	spc_mov_a_abs_x	$0240
	spc_pop_y
	spc_bra	spc_0ef9
spc_0f3b
	spc_inc_y
	spc_mov_a_dpi_y	$14
	spc_push_a
	spc_inc_y
	spc_mov_a_dpi_y	$14
	spc_mov_y_a
	spc_pop_a
	spc_bra	spc_0ef9
spc_0f46
	spc_mov_a_dp	$47
	spc_mov_y_i	$5c
	spc_call	spc_writevoice
spc_0f4d
	spc_clr	7,$13
	spc_mov_a_dp_x	$a0
	spc_beq	spc_0f7f
	spc_mov_a_dp_x	$a1
	spc_beq	spc_0f5b
	spc_dec_dp_x	$a1
	spc_bra	spc_0f7f
spc_0f5b
	spc_set	7,$13
	spc_dec_dp_x	$a0
	spc_bne	spc_0f6c
	spc_mov_a_abs_x	$0381
	spc_mov_abs_x_a	$0360
	spc_mov_a_abs_x	$0380
	spc_bra	spc_0f7c
spc_0f6c
	spc_clrc
	spc_mov_a_abs_x	$0360
	spc_adc_a_abs_x	$0370
	spc_mov_abs_x_a	$0360
	spc_mov_a_abs_x	$0361
	spc_adc_a_abs_x	$0371
spc_0f7c
	spc_mov_abs_x_a	$0361
spc_0f7f
	spc_call	spc_loadpitch
	spc_mov_a_dp_x	$b1
	spc_beq	spc_0fd2
	spc_mov_a_abs_x	$02b0
	spc_cbne_dp_x	$b0,spc_0fd0
	spc_mov_a_abs_x	$0100
	spc_cmp_a_abs_x	$02b1
	spc_bne	spc_0f99
	spc_mov_a_abs_x	$02c1
	spc_bra	spc_0fa6
spc_0f99
	spc_setp
	spc_inc_dp_x	$00
	spc_clrp
	spc_mov_y_a
	spc_beq	spc_0fa2
	spc_mov_a_dp_x	$b1
spc_0fa2
	spc_clrc
	spc_adc_a_abs_x	$02c0
spc_0fa6
	spc_mov_dp_x_a	$b1
	spc_mov_a_abs_x	$02a0
	spc_clrc
	spc_adc_a_abs_x	$02a1
	spc_mov_abs_x_a	$02a0
spc_0fb2
	spc_mov_dp_a	$12
	spc_asl_a
	spc_asl_a
	spc_bcc	spc_0fba
	spc_eor_a_i	$ff
spc_0fba
	spc_mov_y_a
	spc_mov_a_dp_x	$b1
	spc_cmp_a_i	$f1
	spc_bcc	spc_0fc6
	spc_and_a_i	$0f
	spc_mul_ya
	spc_bra	spc_0fca
spc_0fc6
	spc_mul_ya
	spc_mov_a_y
	spc_mov_y_i	$00
spc_0fca
	spc_call	spc_1047
spc_0fcd
	spc_jmp	spc_calcpitch
spc_0fd0
	spc_inc_dp_x	$b0
spc_0fd2
	spc_bbs	7,$13,spc_0fcd
	spc_ret
spc_pitchstep
	spc_clr	7,$13
	spc_mov_a_dp_x	$c1
	spc_beq	spc_0fe5
	spc_mov_a_abs_x	$02e0
	spc_cbne_dp_x	$c0,spc_0fe5
	spc_call	spc_volumeproduct
spc_0fe5
	spc_mov_a_abs_x	$0331
	spc_mov_y_a
	spc_mov_a_abs_x	$0330
	spc_mov_dp_ya	$10
	spc_mov_a_dp_x	$91
	spc_beq	spc_0ffc
	spc_mov_a_abs_x	$0341
	spc_mov_y_a
	spc_mov_a_abs_x	$0340
	spc_call	spc_interpolate
spc_0ffc
	spc_bbc	7,$13,spc_1002
	spc_call	spc_writevolumes
spc_1002
	spc_clr	7,$13
	spc_call	spc_loadpitch
	spc_mov_a_dp_x	$a0
	spc_beq	spc_1019
	spc_mov_a_dp_x	$a1
	spc_bne	spc_1019
	spc_mov_a_abs_x	$0371
	spc_mov_y_a
	spc_mov_a_abs_x	$0370
	spc_call	spc_interpolate
spc_1019
	spc_mov_a_dp_x	$b1
	spc_beq	spc_0fd2
	spc_mov_a_abs_x	$02b0
	spc_cbne_dp_x	$b0,spc_0fd2
	spc_mov_y_dp	$51
	spc_mov_a_abs_x	$02a1
	spc_mul_ya
	spc_mov_a_y
	spc_clrc
	spc_adc_a_abs_x	$02a0
	spc_jmp	spc_0fb2
spc_interpolate
	spc_set	7,$13
	spc_mov_dp_y	$12
	spc_call	spc_signslope
	spc_push_y
	spc_mov_y_dp	$51
	spc_mul_ya
	spc_mov_dp_y	$14
	spc_mov_dp_i	$15,$00
	spc_mov_y_dp	$51
	spc_pop_a
	spc_mul_ya
	spc_addw_ya_dp	$14
spc_1047
	spc_call	spc_signslope
	spc_addw_ya_dp	$10
	spc_mov_dp_ya	$10
	spc_ret
spc_volumeproduct
	spc_set	7,$13
	spc_mov_y_dp	$51
	spc_mov_a_abs_x	$02d1
	spc_mul_ya
	spc_mov_a_y
	spc_clrc
	spc_adc_a_abs_x	$02d0
spc_105c
	spc_asl_a
	spc_bcc	spc_1061
	spc_eor_a_i	$ff
spc_1061
	spc_mov_y_dp_x	$c1
	spc_mul_ya
	spc_mov_a_y
	spc_eor_a_i	$ff
spc_1067
	spc_mov_y_abs	$0565
	spc_mul_ya
	spc_mov_a_abs_x	$0210
	spc_mul_ya
	spc_mov_a_abs_x	$0301
	spc_mul_ya
	spc_mov_a_y
	spc_mul_ya
	spc_mov_a_y
	spc_mov_abs_x_a	$0321
	spc_ret
	spc_endblock	$0676

	spc_block	spc_curveblock,$107a,$0030
spc_panlaw
; Twenty-one pan gains, followed by argument counts for commands E0-FA.
	db	$00,$01,$03,$07,$0d,$15,$1e,$29,$34,$42,$51,$5e,$67,$6e,$73,$77
	db	$7a,$7c,$7d,$7e,$7f
spc_argumentlengths
	db	$01,$01,$02,$03,$00,$01,$02,$01,$02,$01,$01,$03,$00,$01,$02,$03
	db	$01,$03,$03,$00,$01,$03,$00,$03,$03,$03,$01
	spc_endblock	$0030

	spc_block	spc_dspdatablock,$3fa0,$0060
spc_dspregisters
	db	$2c,$3c,$0d,$4d,$6c,$4c,$5c,$3d,$2d,$5c
spc_fircoefficients
; Four sets of eight signed DSP FIR coefficients.
	db	$7f,$00,$00,$00,$00,$00,$00,$00,$58,$bf,$db,$f0,$fe,$07,$0c,$0c
	db	$0c,$21,$2b,$2b,$13,$fe,$f3,$f9,$34,$33,$00,$d9,$e5,$01,$fc,$eb
spc_songcommands
	dw	spc_instrument,spc_setpan,spc_panramp,spc_0c3e
	dw	spc_0c4a,spc_0c65,spc_volumeramp,spc_0c7c
	dw	spc_temporamp,spc_0c93,spc_0c96,spc_0c9a
	dw	spc_0ca6,spc_0cc7,spc_0cd0,spc_trackcall
	dw	spc_0c55,spc_0ca9,spc_0cad,spc_0cc3
	dw	spc_0ce9,spc_0d10,spc_0d4a,spc_setecho
	dw	spc_0d29,spc_0dcc,spc_0db9
	spc_endblock	$0060
