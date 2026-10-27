; Retail split-screen SPC control/effect overlay from upload $1AF091.
; Code and tables retain SPC RAM $10B0-$260E and the native $0800 entry.
; Common low driver code, instruments, scripts and samples are separate uploads.

	incpublics	xlspca.ext

spca_0675	equ	$0675
spca_09e8	equ	$09e8
spca_0a60	equ	$0a60
spca_0bc1	equ	$0bc1
spca_0e97	equ	$0e97
spca_ffc0	equ	$ffc0

racesound_spcalt
	spc_block	spca_codeblock,$10b0,$155f

; Port shadow edge detection and alternate control-stage ordering.
spca_controlstep
	spc_mov_a_abs	$0558
	spc_cmp_a_dp	$04
	spc_beq	spca_samecommand
	spc_mov_a_abs	$0558
	spc_mov_dp_a	$04
	spc_mov_dp_a	$00
	spc_bra	spca_readparameters
spca_samecommand
	spc_mov_dp_i	$00,$00
spca_readparameters
	spc_mov_a_abs	$0559
	spc_mov_dp_a	$05
	spc_mov_dp_a	$01
	spc_mov_a_abs	$055a
	spc_mov_dp_a	$06
	spc_mov_dp_a	$02
	spc_mov_a_abs	$055b
	spc_mov_dp_a	$07
	spc_mov_dp_a	$03
	spc_bbc	1,$29,spca_dispatchcontrols
	spc_clr	0,$29
	spc_clr	1,$29
spca_dispatchcontrols
	spc_call	spca_remapcommand
	spc_call	spca_fadestep
	spc_call	spca_musiccommand
	spc_call	spca_111e
	spc_call	spca_14a6
	spc_call	spca_1a2f
	spc_call	spca_13c6
	spc_call	spca_1163
	spc_call	spca_11ed
	spc_call	spca_14d1
	spc_call	spca_1584
	spc_call	spca_1477
	spc_call	spca_12d2
	spc_call	spca_130c
	spc_call	spca_updatenoise
	spc_call	spca_1467
	spc_call	spca_effectcommand
	spc_jmp	spca_1a7f

; Remap only command $88 to $15.
spca_remapcommand
	spc_cmp_dp_i	$00,$88
	spc_bne	spca_remapdone
	spc_mov_dp_i	$00,$15
spca_remapdone
	spc_ret
spca_111e
	spc_bbc	6,$2d,spca_remapdone
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$43
	spc_beq	spca_remapdone
	spc_mov_x_i	$05
	spc_jmp	spca_186c
spca_112d
	spc_bbc	5,$2d,spca_1156
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$77
	spc_beq	spca_1157
	spc_cmp_a_i	$78
	spc_beq	spca_1157
	spc_cmp_a_i	$79
	spc_beq	spca_1157
	spc_cmp_a_i	$79
	spc_beq	spca_1157
spca_1143
	spc_mov_a_abs	$0396
	spc_cmp_a_i	$77
	spc_beq	spca_115e
	spc_cmp_a_i	$78
	spc_beq	spca_115e
	spc_cmp_a_i	$79
	spc_beq	spca_115e
	spc_cmp_a_i	$7a
	spc_beq	spca_115e
spca_1156
	spc_ret
spca_1157
	spc_mov_x_i	$07
	spc_call	spca_186c
	spc_bra	spca_1143
spca_115e
	spc_mov_x_i	$06
	spc_jmp	spca_186c
spca_1163
	spc_inc_abs	$0581
	spc_mov_a_abs	$0581
	spc_cmp_a_i	$06
	spc_beq	spca_112d
	spc_cmp_a_i	$09
	spc_beq	spca_1197
	spc_cmp_a_i	$0c
	spc_beq	spca_11a5
	spc_cmp_a_i	$0f
	spc_beq	spca_11b3
	spc_cmp_a_i	$12
	spc_beq	spca_11c7
	spc_cmp_a_i	$15
	spc_beq	spca_11db
	spc_cmp_a_i	$18
	spc_beq	spca_11e4
	spc_sbc_a_i	$19
	spc_bmi	spca_118e
	spc_mov_a_i	$00
	spc_mov_abs_a	$0581
spca_118e
	spc_cmp_dp_i	$1c,$01
	spc_beq	spca_1196
	spc_mov_dp_i	$2a,$00
spca_1196
	spc_ret
spca_1197
	spc_bbs	0,$2a,spca_11a0
	spc_mov_dp_i	$20,$0c
	spc_jmp	spca_1833
spca_11a0
	spc_mov_a_i	$17
	spc_jmp	spca_12fa
spca_11a5
	spc_bbs	1,$2a,spca_11ae
	spc_mov_dp_i	$20,$1c
	spc_jmp	spca_1856
spca_11ae
	spc_mov_a_i	$97
	spc_jmp	spca_12fa
spca_11b3
	spc_bbs	2,$2a,spca_11bc
	spc_mov_dp_i	$20,$0a
	spc_jmp	spca_181d
spca_11bc
	spc_bbs	0,$2a,spca_118e
	spc_bbs	4,$2a,spca_118e
	spc_mov_a_i	$25
	spc_jmp	spca_12fa
spca_11c7
	spc_bbs	2,$2a,spca_11d0
	spc_mov_dp_i	$20,$1a
	spc_jmp	spca_1840
spca_11d0
	spc_bbs	1,$2a,spca_118e
	spc_bbs	5,$2a,spca_118e
	spc_mov_a_i	$25
	spc_jmp	spca_12fa
spca_11db
	spc_bbs	4,$2a,spca_118e
	spc_mov_dp_i	$20,$0b
	spc_jmp	spca_1828
spca_11e4
	spc_bbs	5,$2a,spca_118e
	spc_mov_dp_i	$20,$1b
	spc_jmp	spca_184b
spca_11ed
	spc_mov_a_abs	$056a
	spc_cmp_a_i	$ff
	spc_beq	spca_11f7
	spc_inc_abs	$056a
spca_11f7
	spc_mov_a_dp	$1b
	spc_cmp_a_i	$05
	spc_beq	spca_11ff
	spc_bra	spca_1207
spca_11ff
	spc_mov_a_i	$00
	spc_mov_abs_a	$056a
	spc_mov_abs_a	$056b
spca_1207
	spc_mov_a_abs	$056a
	spc_bmi	spca_120e
	spc_bra	spca_1218
spca_120e
	spc_mov_a_abs	$056b
	spc_cmp_a_i	$ff
	spc_beq	spca_1218
	spc_inc_abs	$056b
spca_1218
	spc_cmp_dp_i	$1b,$02
	spc_bne	spca_1222
	spc_mov_a_i	$01
	spc_mov_abs_a	$0567
spca_1222
	spc_mov_a_abs	$0567
	spc_beq	spca_1239
	spc_inc_abs	$0567
	spc_mov_a_abs	$0567
	spc_cmp_a_i	$e6
	spc_bne	spca_1239
	spc_mov_a_i	$00
	spc_mov_abs_a	$0567
	spc_mov_dp_i	$1b,$03
spca_1239
	spc_mov_a_abs	$056a
	spc_bmi	spca_1256
	spc_mov_x_i	$00
spca_1240
	spc_mov_a_abs_x	spca_timerallowlist
	spc_beq	spca_1256
	spc_cmp_a_dp	$1d
	spc_beq	spca_124c
	spc_inc_x
	spc_bra	spca_1240
spca_124c
	spc_mov_dp_i	$1d,$00
	spc_bra	spca_1256
spca_timerallowlist
	db	$11,$12,$13,$14,$00
spca_1256
	spc_cmp_dp_i	$1d,$32
	spc_bne	spca_126f
	spc_mov_dp_i	$2a,$00
	spc_set	5,$2d
	spc_set	6,$2d
	spc_mov_x_i	$02
	spc_call	spca_186c
	spc_dec_x
	spc_call	spca_186c
	spc_dec_x
	spc_call	spca_186c
spca_126f
	spc_cmp_dp_i	$1d,$03
	spc_beq	spca_127b
	spc_cmp_dp_i	$1d,$10
	spc_beq	spca_127b
	spc_bra	spca_128b
spca_127b
	spc_mov_x_i	$05
	spc_call	spca_186c
	spc_dec_x
	spc_call	spca_186c
	spc_mov_dp_i	$2a,$00
	spc_set	6,$2d
	spc_set	5,$2d
spca_128b
	spc_mov_a_abs	$0579
	spc_beq	spca_12a2
	spc_inc_abs	$0579
	spc_mov_a_abs	$0579
	spc_setc
	spc_sbc_a_i	$78
	spc_bmi	spca_12a2
	spc_set	5,$2d
	spc_mov_a_i	$00
	spc_mov_abs_a	$0579
spca_12a2
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$17
	spc_beq	spca_12af
	spc_cmp_a_i	$21
	spc_beq	spca_12af
	spc_bra	spca_12be
spca_12af
	spc_cmp_dp_i	$01,$09
	spc_beq	spca_12bb
	spc_cmp_dp_i	$01,$0d
	spc_beq	spca_12bb
	spc_bra	spca_12be
spca_12bb
	spc_mov_dp_i	$01,$00
spca_12be
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$32
	spc_bne	spca_12d1
	spc_mov_a_abs	$0394
	spc_cmp_a_i	$38
	spc_bne	spca_12d1
	spc_mov_x_i	$04
	spc_call	spca_186c
spca_12d1
	spc_ret
spca_12d2
	spc_cmp_dp_i	$1d,$4c
	spc_bne	spca_12f9
	spc_mov_x_i	$07
	spc_call	spca_stopvoice
	spc_dec_x
	spc_call	spca_stopvoice
	spc_dec_x
	spc_call	spca_186c
	spc_dec_x
	spc_call	spca_186c
	spc_dec_x
	spc_call	spca_186c
	spc_mov_a_i	$01
	spc_mov_abs_a	$0579
	spc_mov_dp_i	$2a,$00
	spc_call	spca_0a60
	spc_set	6,$2d
spca_12f9
	spc_ret
spca_12fa
	spc_push_x
	spc_push_a
	spc_mov_x_i	$00
spca_12fe
	spc_mov_a_abs_x	$0588
	spc_beq	spca_1306
	spc_inc_x
	spc_bra	spca_12fe
spca_1306
	spc_pop_a
	spc_mov_abs_x_a	$0588
	spc_pop_x
spca_130b
	spc_ret
spca_130c
	spc_bbs	0,$29,spca_130b
	spc_cmp_dp_i	$1d,$3e
	spc_bne	spca_1325
	spc_mov_a_i	$01
	spc_mov_abs_a	$0568
	spc_bbc	7,$00,spca_1325
	spc_mov_dp_a	$20
	spc_set	7,$20
	spc_mov_a_dp	$20
	spc_mov_abs_a	$0568
spca_1325
	spc_mov_a_abs	$0568
	spc_beq	spca_132d
	spc_inc_abs	$0568
spca_132d
	spc_mov_a_abs	$0568
	spc_and_a_i	$7f
	spc_cmp_a_i	$2a
	spc_bne	spca_136b
	spc_mov_a_abs	$0568
	spc_asl_a
	spc_bcs	spca_1351
	spc_mov_a_abs	$0397
spca_133f
	spc_cmp_a_i	$77
	spc_beq	spca_135a
	spc_cmp_a_i	$78
	spc_beq	spca_1356
	spc_cmp_a_i	$79
	spc_beq	spca_135a
	spc_cmp_a_i	$7a
	spc_beq	spca_1356
	spc_bra	spca_1366
spca_1351
	spc_mov_a_abs	$0396
	spc_bra	spca_133f
spca_1356
	spc_mov_a_i	$0f
	spc_bra	spca_135c
spca_135a
	spc_mov_a_i	$2f
spca_135c
	spc_asl_abs	$0568
	spc_bcc	spca_1363
	spc_or_a_i	$80
spca_1363
	spc_call	spca_12fa
spca_1366
	spc_mov_a_i	$00
	spc_mov_abs_a	$0568
spca_136b
	spc_cmp_dp_i	$1d,$20
	spc_beq	spca_1377
	spc_cmp_dp_i	$1d,$16
	spc_beq	spca_137b
	spc_bra	spca_1399
spca_1377
	spc_set	4,$2c
	spc_bra	spca_137d
spca_137b
	spc_set	5,$2c
spca_137d
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$01
	spc_beq	spca_1391
	spc_cmp_a_i	$04
	spc_beq	spca_138c
	spc_cmp_a_i	$07
	spc_beq	spca_1391
spca_138c
	spc_mov_dp_i	$1d,$1b
	spc_bra	spca_1394
spca_1391
	spc_mov_dp_i	$1d,$27
spca_1394
	spc_mov_a_i	$01
	spc_mov_abs_a	$055d
spca_1399
	spc_mov_a_abs	$055d
	spc_beq	spca_13a1
	spc_inc_abs	$055d
spca_13a1
	spc_mov_a_abs	$055d
	spc_cmp_a_i	$11
	spc_bne	spca_13c5
	spc_mov_a_i	$00
	spc_mov_abs_a	$055d
	spc_bbs	4,$2c,spca_13b5
	spc_bbs	5,$2c,spca_13be
	spc_bra	spca_13c5
spca_13b5
	spc_clr	4,$2c
	spc_mov_a_i	$20
	spc_call	spca_12fa
	spc_bra	spca_13c5
spca_13be
	spc_clr	5,$2c
	spc_mov_a_i	$16
	spc_call	spca_12fa
spca_13c5
	spc_ret
spca_13c6
	spc_call	spca_1444
	spc_bbs	2,$2c,spca_13d0
	spc_bbs	3,$2c,spca_13db
spca_13cf
	spc_ret
spca_13d0
	spc_mov_a_abs	$0555
	spc_beq	spca_13f7
	spc_cmp_a_i	$fe
	spc_beq	spca_13cf
	spc_bra	spca_140f
spca_13db
	spc_clr	2,$2c
	spc_clr	3,$2c
	spc_mov_a_i	$00
	spc_mov_abs_a	$0555
	spc_mov_abs_a	$0553
	spc_mov_abs_a	$0554
	spc_mov_abs_a	$0569
	spc_mov_a_abs	$0578
	spc_mov_dp_a	$50
	spc_mov_a_abs	$0566
	spc_bra	spca_1441
spca_13f7
	spc_mov_a_i	$04
	spc_mov_abs_a	$0554
	spc_mov_a_dp	$53
	spc_mov_abs_a	$0566
	spc_mov_a_dp	$50
	spc_mov_abs_a	$0578
	spc_mov_y_i	$7f
	spc_mul_ya
	spc_mov_x_i	$fe
	spc_div_ya_x
	spc_mov_abs_a	$0569
spca_140f
	spc_inc_abs	$0555
	spc_mov_a_abs	$0555
	spc_mov_y_i	$00
	spc_mov_x_i	$15
	spc_div_ya_x
	spc_mov_dp_a	$20
	spc_setc
	spc_mov_a_abs	$0578
	spc_sbc_a_dp	$20
	spc_mov_dp_a	$50
	spc_mov_a_abs	$0569
	spc_mov_dp_a	$20
	spc_mov_dp_i	$21,$00
	spc_mov_a_abs	$0553
	spc_mov_y_abs	$0554
	spc_addw_ya_dp	$20
	spc_mov_abs_a	$0553
	spc_mov_abs_y	$0554
	spc_mov_a_abs	$0566
	spc_setc
	spc_sbc_a_abs	$0554
spca_1441
	spc_mov_dp_a	$53
	spc_ret
spca_1444
	spc_mov_a_dp	$1d
	spc_cmp_a_i	$2c
	spc_beq	spca_1458
	spc_mov_x_abs	$0555
	spc_beq	spca_1461
	spc_cmp_a_i	$30
	spc_beq	spca_1462
	spc_cmp_a_i	$3c
	spc_beq	spca_1462
	spc_ret
spca_1458
	spc_cmp_dp_i	$1c,$01
	spc_bne	spca_1461
	spc_set	2,$2c
	spc_clr	3,$2c
spca_1461
	spc_ret
spca_1462
	spc_clr	2,$2c
	spc_set	3,$2c
	spc_ret
spca_1467
	spc_cmp_dp_i	$1c,$01
	spc_beq	spca_1476
	spc_mov_a_dp	$01
	spc_setc
	spc_sbc_a_i	$07
	spc_bmi	spca_1476
	spc_mov_dp_i	$01,$00
spca_1476
	spc_ret
spca_1477
	spc_mov_a_dp	$1c
	spc_cmp_a_i	$01
	spc_beq	spca_148e
	spc_mov_x_i	$00
spca_147f
	spc_mov_a_abs_x	spca_effectallowlist
	spc_beq	spca_148b
	spc_cmp_a_dp	$1d
	spc_beq	spca_148e
	spc_inc_x
	spc_bra	spca_147f
spca_148b
	spc_mov_dp_i	$1d,$00
spca_148e
	spc_ret
spca_effectallowlist
	db	$03,$10,$32,$2b,$34,$43,$44,$45,$77,$78,$79,$7a
	db	$23,$3a,$3b,$3f,$06,$22,$41,$40,$1f,$2a,$00
spca_14a6
	spc_mov_x_i	$00
spca_14a8
	spc_mov_a_abs_x	spca_musicallowlist
	spc_beq	spca_14b7
	spc_cmp_a_dp	$1d
	spc_beq	spca_14b4
	spc_inc_x
	spc_bra	spca_14a8
spca_14b4
	spc_mov_dp_i	$1d,$00
spca_14b7
	spc_ret
spca_musicallowlist
	db	$02,$01,$04,$07,$0a,$0d,$25,$15,$17,$1e,$21,$18
	db	$19,$1a,$09,$0c,$0b,$2e,$4e,$2d,$29,$4d,$33,$5a
	db	$00
spca_14d1
	spc_bbc	2,$28,spca_14d7
	spc_call	spca_14ea
spca_14d7
	spc_bbc	3,$28,spca_14dd
	spc_call	spca_152c
spca_14dd
	spc_bbc	4,$28,spca_14e3
	spc_call	spca_150b
spca_14e3
	spc_bbc	5,$28,spca_14e9
	spc_call	spca_1558
spca_14e9
	spc_ret
spca_14ea
	spc_mov_a_abs	$0547
	spc_cmp_a_i	$14
	spc_beq	spca_150a
	spc_inc_abs	$0547
	spc_mov_a_abs	$054d
	spc_mov_dp_a	$20
	spc_mov_a_abs	$054f
	spc_mov_dp_a	$21
	spc_mov_a_i	$20
	spc_mov_y_i	$00
	spc_addw_ya_dp	$20
	spc_mov_abs_a	$054d
	spc_mov_abs_y	$054f
spca_150a
	spc_ret
spca_150b
	spc_mov_a_abs	$0546
	spc_cmp_a_i	$14
	spc_beq	spca_152b
	spc_inc_abs	$0546
	spc_mov_a_abs	$054c
	spc_mov_dp_a	$20
	spc_mov_a_abs	$054e
	spc_mov_dp_a	$21
	spc_mov_a_i	$20
	spc_mov_y_i	$00
	spc_addw_ya_dp	$20
	spc_mov_abs_a	$054c
	spc_mov_abs_y	$054e
spca_152b
	spc_ret
spca_152c
	spc_mov_a_abs	$0547
	spc_cmp_a_i	$00
	spc_beq	spca_154b
	spc_dec_abs	$0547
	spc_mov_a_abs	$054d
	spc_mov_y_abs	$054f
	spc_mov_dp_i	$20,$20
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$054d
	spc_mov_abs_y	$054f
	spc_ret
spca_154b
	spc_clr	2,$28
	spc_clr	3,$28
	spc_mov_a_i	$00
	spc_mov_abs_a	$054d
	spc_mov_abs_a	$054f
	spc_ret
spca_1558
	spc_mov_a_abs	$0546
	spc_cmp_a_i	$00
	spc_beq	spca_1577
	spc_dec_abs	$0546
	spc_mov_a_abs	$054c
	spc_mov_y_abs	$054e
	spc_mov_dp_i	$20,$20
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$054c
	spc_mov_abs_y	$054e
	spc_ret
spca_1577
	spc_clr	4,$28
	spc_clr	5,$28
	spc_mov_a_i	$00
	spc_mov_abs_a	$054c
	spc_mov_abs_a	$054e
	spc_ret
spca_1584
	spc_bbc	2,$29,spca_158a
	spc_call	spca_159d
spca_158a
	spc_bbc	3,$29,spca_1590
	spc_call	spca_15be
spca_1590
	spc_bbc	4,$29,spca_1596
	spc_call	spca_15ea
spca_1596
	spc_bbc	5,$29,spca_159c
	spc_call	spca_160b
spca_159c
	spc_ret
spca_159d
	spc_mov_a_abs	$0543
	spc_cmp_a_i	$19
	spc_beq	spca_15bd
	spc_inc_abs	$0543
	spc_mov_a_abs	$0549
	spc_mov_dp_a	$20
	spc_mov_a_abs	$054b
	spc_mov_dp_a	$21
	spc_mov_a_i	$3c
	spc_mov_y_i	$00
	spc_addw_ya_dp	$20
	spc_mov_abs_a	$0549
	spc_mov_abs_y	$054b
spca_15bd
	spc_ret
spca_15be
	spc_mov_a_abs	$0543
	spc_cmp_a_i	$00
	spc_beq	spca_15dd
	spc_dec_abs	$0543
	spc_mov_a_abs	$0549
	spc_mov_y_abs	$054b
	spc_mov_dp_i	$20,$3c
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$0549
	spc_mov_abs_y	$054b
	spc_ret
spca_15dd
	spc_clr	2,$29
	spc_clr	3,$29
	spc_mov_a_i	$00
	spc_mov_abs_a	$0549
	spc_mov_abs_a	$054b
	spc_ret
spca_15ea
	spc_mov_a_abs	$0542
	spc_cmp_a_i	$19
	spc_beq	spca_160a
	spc_inc_abs	$0542
	spc_mov_a_abs	$0548
	spc_mov_dp_a	$20
	spc_mov_a_abs	$054a
	spc_mov_dp_a	$21
	spc_mov_a_i	$3c
	spc_mov_y_i	$00
	spc_addw_ya_dp	$20
	spc_mov_abs_a	$0548
	spc_mov_abs_y	$054a
spca_160a
	spc_ret
spca_160b
	spc_mov_a_abs	$0542
	spc_cmp_a_i	$00
	spc_beq	spca_162a
	spc_dec_abs	$0542
	spc_mov_a_abs	$0548
	spc_mov_y_abs	$054a
	spc_mov_dp_i	$20,$3c
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$0548
	spc_mov_abs_y	$054a
	spc_ret
spca_162a
	spc_clr	4,$29
	spc_clr	5,$29
	spc_mov_a_i	$00
	spc_mov_abs_a	$0548
	spc_mov_abs_a	$054a
	spc_ret

; Port 0: five music identities, then effect identity minus five.
spca_musiccommand
	spc_mov_dp_i	$1d,$00
	spc_mov_a_dp	$00
	spc_and_a_i	$7f
	spc_beq	spca_nomusiccommand
	spc_setc
	spc_sbc_a_i	$06
	spc_bmi	spca_changemusic
	spc_inc_a
	spc_mov_dp_a	$1d
	spc_ret
spca_nomusiccommand
	spc_mov_dp_a	$1d
	spc_ret
spca_changemusic
	spc_bbs	0,$29,spca_commanddone
	spc_mov_a_dp	$00
	spc_mov_dp_a	$1b
	spc_cmp_a_i	$02
	spc_bne	spca_1657
spca_1657
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
spca_commanddone
	spc_ret

; Suppress repeated port-1 commands; retain the 61-entry dispatch aliases.
spca_effectcommand
	spc_mov_a_dp	$01
	spc_cmp_a_dp	$09
	spc_bne	spca_167c
	spc_mov_dp_i	$20,$00
	spc_bra	spca_167f
spca_167c
	spc_mov_dp_dp	$20,$01
spca_167f
	spc_mov_dp_dp	$09,$01
	spc_mov_a_dp	$20
	spc_setc
	spc_sbc_a_i	$3e
	spc_bmi	spca_168c
	spc_mov_dp_i	$20,$00
spca_168c
	spc_mov_a_dp	$20
	spc_beq	spca_commanddone
	spc_dec_a
	spc_asl_a
	spc_mov_x_a
	spc_jmp_abs_x	spca_commandtable

; Commands $01-$3D, including duplicate and unused entries.
spca_commandtable
	dw	spca_17ae,spca_17ae,spca_17ae,spca_17ae,spca_requestreload,spca_requestipl
	dw	spca_17ae,spca_17ae,spca_1710,spca_181d,spca_1828,spca_1833
	dw	spca_171b,spca_17ae,spca_17ae,spca_17ae,spca_17ae,spca_1726
	dw	spca_17ae,spca_1731,spca_1917,spca_18a6,spca_17ae,spca_173c
	dw	spca_1747,spca_1840,spca_184b,spca_1856,spca_17ae,spca_17ae
	dw	spca_17ae,spca_17ae,spca_17ae,spca_1871,spca_changeengine1,spca_restoreengine1
	dw	spca_changeengine0,spca_restoreengine0,spca_17ae,spca_17ae,spca_17ae,spca_17ae
	dw	spca_17ae,spca_17ae,spca_17ae,spca_17ae,spca_17ae,spca_17ae
	dw	spca_17ae,spca_180b,spca_180b,spca_180b,spca_180b,spca_1814
	dw	spca_1814,spca_1814,spca_1814,spca_changenear1,spca_restorenear1,spca_changenear0
	dw	spca_restorenear0
spca_1710
	spc_bbs	6,$2d,spca_171a
	spc_set	2,$2a
	spc_mov_a_i	$25
	spc_call	spca_12fa
spca_171a
	spc_ret
spca_171b
	spc_bbs	6,$2d,spca_1725
	spc_set	4,$2a
	spc_mov_a_i	$15
	spc_call	spca_12fa
spca_1725
	spc_ret
spca_1726
	spc_bbs	6,$2d,spca_1730
	spc_set	0,$2a
	spc_mov_a_i	$17
	spc_call	spca_12fa
spca_1730
	spc_ret
spca_1731
	spc_bbs	6,$2d,spca_173b
	spc_set	3,$2a
	spc_mov_a_i	$a5
	spc_call	spca_12fa
spca_173b
	spc_ret
spca_173c
	spc_bbs	6,$2d,spca_1746
	spc_set	5,$2a
	spc_mov_a_i	$95
	spc_call	spca_12fa
spca_1746
	spc_ret
spca_1747
	spc_bbs	6,$2d,spca_1751
	spc_set	1,$2a
	spc_mov_a_i	$97
	spc_call	spca_12fa
spca_1751
	spc_ret

; Paired transition channels: index 0 reads port 2, index 1 reads port 3.
spca_changeengine1
	spc_bbs	2,$29,spca_17ae
	spc_set	2,$29
	spc_clr	3,$29
	spc_mov_a_i	$00
	spc_mov_y_i	$02
	spc_mov_abs_a	$0549
	spc_mov_abs_y	$054b
	spc_ret
spca_restoreengine1
	spc_bbc	2,$29,spca_17ae
	spc_clr	2,$29
	spc_set	3,$29
	spc_mov_a_abs	$0549
	spc_mov_y_abs	$054b
	spc_mov_dp_i	$20,$00
	spc_mov_dp_i	$21,$02
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$0549
	spc_mov_abs_y	$054b
	spc_ret
spca_changeengine0
	spc_bbs	4,$29,spca_17ae
	spc_set	4,$29
	spc_clr	5,$29
	spc_mov_a_i	$00
	spc_mov_y_i	$02
	spc_mov_abs_a	$0548
	spc_mov_abs_y	$054a
	spc_ret
spca_restoreengine0
	spc_bbc	4,$29,spca_17ae
	spc_clr	4,$29
	spc_set	5,$29
	spc_mov_a_abs	$0548
	spc_mov_y_abs	$054a
	spc_mov_dp_i	$20,$00
	spc_mov_dp_i	$21,$02
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$0548
	spc_mov_abs_y	$054a
	spc_ret
spca_17ae
	spc_ret
spca_changenear1
	spc_bbs	2,$28,spca_17ae
	spc_set	2,$28
	spc_clr	3,$28
	spc_mov_a_i	$40
	spc_mov_y_i	$00
	spc_mov_abs_a	$054d
	spc_mov_abs_y	$054f
	spc_ret
spca_changenear0
	spc_bbs	4,$28,spca_17ae
	spc_set	4,$28
	spc_clr	5,$28
	spc_mov_a_i	$40
	spc_mov_y_i	$00
	spc_mov_abs_a	$054c
	spc_mov_abs_y	$054e
	spc_ret
spca_restorenear1
	spc_bbc	2,$28,spca_17ae
	spc_clr	2,$28
	spc_set	3,$28
	spc_mov_a_abs	$054d
	spc_mov_y_abs	$054f
	spc_mov_dp_i	$20,$40
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$054d
	spc_mov_abs_y	$054f
	spc_ret
spca_restorenear0
	spc_bbc	4,$28,spca_17ae
	spc_clr	4,$28
	spc_set	5,$28
	spc_mov_a_abs	$054c
	spc_mov_y_abs	$054e
	spc_mov_dp_i	$20,$40
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$054c
	spc_mov_abs_y	$054e
	spc_ret
spca_180b
	spc_mov_a_dp	$20
	spc_setc
	spc_sbc_a_i	$32
	spc_mov_abs_a	$0530
	spc_ret
spca_1814
	spc_mov_a_dp	$20
	spc_setc
	spc_sbc_a_i	$36
	spc_mov_abs_a	$0531
	spc_ret
spca_181d
	spc_clr	2,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$25
	spc_bne	spca_186b
	spc_bra	spca_183c
spca_1828
	spc_clr	4,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$15
	spc_bne	spca_186b
	spc_bra	spca_183c
spca_1833
	spc_clr	0,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$17
	spc_bne	spca_186b
spca_183c
	spc_mov_x_i	$05
	spc_bra	spca_1861
spca_1840
	spc_clr	3,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$25
	spc_bne	spca_186b
	spc_bra	spca_185f
spca_184b
	spc_clr	5,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$15
	spc_bne	spca_186b
	spc_bra	spca_185f
spca_1856
	spc_clr	1,$2a
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$17
	spc_bne	spca_186b
spca_185f
	spc_mov_x_i	$05
spca_1861
	spc_mov_a_abs_x	$0408
	spc_beq	spca_186b
	spc_mov_a_dp	$20
	spc_mov_abs_x_a	$03e0
spca_186b
	spc_ret
spca_186c
	spc_mov_dp_i	$20,$01
	spc_bra	spca_1861
spca_1871
	spc_bbc	0,$29,spca_186b
	spc_mov_a_i	$4c
	spc_call	spca_12fa
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
	spc_clr	2,$29
	spc_clr	3,$29
	spc_clr	4,$29
	spc_clr	5,$29
	spc_call	spca_0a60
	spc_call	spca_15dd
	spc_jmp	spca_162a
spca_18a6
	spc_bbc	0,$29,spca_186b
	spc_mov_dp_dp	$2a,$2b
	spc_mov_a_i	$4b
	spc_call	spca_12fa
	spc_clr	0,$29
	spc_clr	6,$2d
	spc_mov_x_i	$07
	spc_call	spca_18d3
	spc_mov_x_i	$06
	spc_call	spca_18d3
	spc_mov_x_i	$05
	spc_call	spca_18d3
	spc_mov_x_i	$04
	spc_call	spca_18d3
	spc_mov_x_i	$01
	spc_call	spca_186c
	spc_mov_x_i	$00
	spc_jmp	spca_186c
spca_18d3
	spc_mov_a_abs_x	$0450
	spc_cmp_a_i	$01
	spc_beq	spca_18df
	spc_cmp_a_i	$02
	spc_beq	spca_18e3
	spc_ret
spca_18df
	spc_clr	7,$00
	spc_bra	spca_18e5
spca_18e3
	spc_set	7,$00
spca_18e5
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0450
	spc_mov_a_abs_x	$0460
	spc_mov_abs_x_a	$03c8
	spc_mov_a_abs_x	$0458
	spc_beq	spca_1914
	spc_push_a
	spc_call	spca_1905
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0458
	spc_pop_a
	spc_push_x
	spc_call	spca_2087
	spc_pop_x
	spc_ret
spca_1905
	spc_dec_a
	spc_asl_a
	spc_mov_y_a
	spc_mov_a_abs_y	$0702
	spc_mov_dp_a	$24
	spc_inc_y
	spc_mov_a_abs_y	$0702
	spc_mov_dp_a	$25
	spc_ret
spca_1914
	spc_jmp	spca_186c
spca_1917
	spc_bbs	0,$29,spca_1956
	spc_mov_dp_dp	$2b,$2a
	spc_mov_dp_i	$2a,$00
	spc_set	0,$29
	spc_set	6,$2d
	spc_mov_a_i	$4a
	spc_call	spca_12fa
	spc_mov_x_i	$07
	spc_call	spca_1951
	spc_mov_x_i	$06
	spc_call	spca_1951
	spc_mov_x_i	$05
	spc_call	spca_1951
	spc_mov_x_i	$04
	spc_call	spca_1951
	spc_mov_x_i	$07
	spc_call	spca_186c
	spc_mov_x_i	$06
	spc_call	spca_186c
	spc_mov_x_i	$05
	spc_call	spca_186c
	spc_mov_x_i	$04
	spc_jmp	spca_186c
spca_1951
	spc_mov_a_abs_x	$04f8
	spc_beq	spca_196e
spca_1956
	spc_mov_a_abs_x	$04f8
	spc_mov_abs_x_a	$0458
	spc_mov_a_abs_x	$0528
	spc_mov_abs_x_a	$0450
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$04f8
	spc_mov_abs_x_a	$0480
	spc_mov_abs_x_a	$0528
	spc_ret
spca_196e
	spc_mov_a_abs_x	$0480
	spc_beq	spca_198e
	spc_cmp_a_i	$02
	spc_beq	spca_1956
	spc_mov_a_abs_x	$04b8
	spc_mov_abs_x_a	$0450
	spc_mov_a_abs_x	$03c8
	spc_mov_abs_x_a	$0460
	spc_mov_a_abs_x	$0390
	spc_mov_abs_x_a	$0458
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0480
spca_198e
	spc_ret
spca_198f
	spc_mov_dp_i	$2a,$00
	spc_call	spca_beginramp
	spc_mov_x_i	$07
spca_1997
	spc_call	spca_stopvoice
	spc_dec_x
	spc_bpl	spca_1997
	spc_ret
spca_stopvoice
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$04f8
	spc_mov_abs_x_a	$0480
	spc_mov_dp_a	$2a
	spc_mov_a_abs_x	$0408
	spc_beq	spca_19b5
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$04c0
	spc_mov_abs_x_a	$04c8
spca_19b5
	spc_ret
spca_beginramp
	spc_bbs	0,$29,spca_19bb
	spc_set	6,$29
spca_19bb
	spc_ret

; Fixed-point fade followed by music stop, custom receiver or hardware IPL.
spca_fadestep
	spc_bbc	6,$29,spca_fadeidle
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
	spc_beq	spca_fadedone
	spc_cmp_y_i	$01
	spc_beq	spca_fadedone
	spc_cmp_y_i	$02
	spc_beq	spca_fadedone
	spc_cmp_y_i	$03
	spc_beq	spca_fadedone
	spc_ret
spca_fadedone
	spc_mov_a_i	$00
	spc_mov_dp_a	$2e
	spc_mov_dp_a	$2f
	spc_clr	6,$29
	spc_bbs	7,$2c,spca_receiverrestart
	spc_bbs	0,$2d,spca_iplrestart
	spc_jmp	spca_0a60
spca_receiverrestart
	spc_call	spca_keyoffall
	spc_jmp	spca_0675
spca_keyoffall
	spc_mov_a_i	$ff
	spc_mov_y_i	$5c
	spc_jmp	spca_09e8
spca_fadeidle
	spc_mov_a_dp	$59
	spc_mov_abs_a	$0564
	spc_mov_abs_a	$0565
	spc_ret
spca_requestreload
	spc_call	spca_198f
	spc_mov_a_dp	$59
	spc_beq	spca_receiverrestart
	spc_set	7,$2c
	spc_ret
spca_requestipl
	spc_set	0,$2d
	spc_call	spca_198f
	spc_mov_a_dp	$59
	spc_beq	spca_iplrestart
	spc_set	0,$2d
	spc_ret
spca_iplrestart
	spc_call	spca_keyoffall
	spc_mov_a_abs	$00f1
	spc_or_a_i	$80
	spc_mov_abs_a	$00f1
	spc_jmp	spca_ffc0
spca_1a2f
	spc_mov_a_dp	$1d
	spc_beq	spca_1a79
	spc_mov_y_i	$00
spca_1a35
	spc_mov_a_abs_y	spca_effectclass0
	spc_beq	spca_1a41
	spc_cmp_a_dp	$1d
	spc_beq	spca_1a7c
	spc_inc_y
	spc_bra	spca_1a35
spca_1a41
	spc_mov_y_i	$00
spca_1a43
	spc_mov_a_abs_y	spca_effectclass1
	spc_beq	spca_1a7c
	spc_push_a
	spc_mov_a_dp	$1d
	spc_push_y
	spc_call	spca_readscriptheader
	spc_call	spca_scriptchannel
	spc_pop_y
	spc_pop_a
	spc_cmp_a_abs_x	$0390
	spc_beq	spca_1a5c
spca_1a59
	spc_inc_y
	spc_bra	spca_1a43
spca_1a5c
	spc_mov_x_i	$00
spca_1a5e
	spc_mov_a_abs_x	spca_effectclass1
	spc_beq	spca_1a72
	spc_cmp_a_dp	$1d
	spc_beq	spca_1a6a
	spc_inc_x
	spc_bra	spca_1a5e
spca_1a6a
	spc_mov_dp_xreg	$20
	spc_mov_a_y
	spc_setc
	spc_sbc_a_dp	$20
	spc_bpl	spca_1a59
spca_1a72
	spc_mov_dp_dp	$1f,$1d
	spc_mov_dp_i	$1d,$00
	spc_ret
spca_1a79
	spc_mov_dp_i	$1f,$00
spca_1a7c
	spc_ret
	db	$15,$1e
spca_1a7f
	spc_cmp_dp_i	$1d,$00
	spc_beq	spca_1a8b
	spc_mov_a_i	$00
	spc_mov_abs_a	$057b
	spc_bra	spca_1a95
spca_1a8b
	spc_mov_a_abs	$057b
	spc_cmp_a_i	$ff
	spc_beq	spca_1a95
	spc_inc_abs	$057b
spca_1a95
	spc_cmp_dp_i	$1d,$00
	spc_bne	spca_1aca
	spc_mov_a_abs	$057b
	spc_beq	spca_1aca
	spc_cmp_a_i	$01
	spc_beq	spca_1aca
	spc_cmp_a_i	$02
	spc_beq	spca_1aca
	spc_mov_a_abs	$0588
	spc_beq	spca_1aca
	spc_push_a
	spc_mov_x_i	$01
spca_1aaf
	spc_mov_a_abs_x	$0588
	spc_dec_x
	spc_mov_abs_x_a	$0588
	spc_inc_x
	spc_inc_x
	spc_cmp_x_i	$08
	spc_bne	spca_1aaf
	spc_pop_a
	spc_asl_a
	spc_bcc	spca_1ac2
	spc_set	7,$00
spca_1ac2
	spc_lsr_a
	spc_mov_x_i	$00
	spc_mov_abs_x	$057b
	spc_bra	spca_1ad9
spca_1aca
	spc_mov_a_dp	$1d
	spc_cmp_a_dp	$1e
	spc_bne	spca_1ad3
spca_1ad0
	spc_jmp	spca_1b7e
spca_1ad3
	spc_mov_dp_a	$1e
	spc_mov_a_dp	$1d
	spc_beq	spca_1ad0
spca_1ad9
	spc_mov_dp_a	$23
	spc_call	spca_readscriptheader
	spc_call	spca_scriptchannel
	spc_call	spca_1b48
	spc_call	spca_1b71
	spc_call	spca_1afd
	spc_call	spca_1b9e
	spc_mov_a_dp	$23
	spc_mov_abs_x_a	$0410
	spc_push_x
	spc_call	spca_1b7e
	spc_pop_x
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0410
	spc_ret
spca_1afd
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$0408
	spc_ret
spca_readscriptheader
	spc_dec_a
	spc_asl_a
	spc_mov_y_a
	spc_mov_a_abs_y	$0702
	spc_mov_dp_a	$20
	spc_inc_y
	spc_mov_a_abs_y	$0702
	spc_mov_dp_a	$21
	spc_mov_y_i	$00
	spc_mov_a_dpi_y	$20
	spc_mov_x_a
	spc_ret

; Header bit 6 and a command high bit decrement the channel with byte wrap.
spca_scriptchannel
	spc_mov_dp_xreg	$26
	spc_mov_a_xreg
	spc_and_a_i	$0f
	spc_mov_x_a
	spc_bbc	6,$26,spca_1b24
	spc_bbc	7,$00,spca_1b24
	spc_dec_x
spca_1b24
	spc_cmp_dp_i	$23,$79
	spc_beq	spca_1b39
	spc_cmp_dp_i	$23,$78
	spc_beq	spca_1b39
	spc_cmp_dp_i	$23,$77
	spc_beq	spca_1b39
	spc_cmp_dp_i	$23,$7a
	spc_beq	spca_1b39
	spc_ret
spca_1b39
	spc_bbs	7,$00,spca_1b42
	spc_mov_a_i	$1c
	spc_mov_abs_x_a	$03c8
	spc_ret
spca_1b42
	spc_mov_a_i	$20
	spc_mov_abs_x_a	$03c8
	spc_ret
spca_1b48
	spc_bbc	7,$26,spca_1b58
	spc_bbc	5,$26,spca_1b52
	spc_mov_a_i	$02
	spc_bra	spca_1b54
spca_1b52
	spc_mov_a_i	$01
spca_1b54
	spc_mov_abs_x_a	$0480
	spc_ret
spca_1b58
	spc_mov_a_abs_x	$0480
	spc_cmp_a_i	$01
	spc_bne	spca_1b70
	spc_mov_a_abs_x	$04f8
	spc_bne	spca_1b70
	spc_mov_a_abs_x	$0390
	spc_mov_abs_x_a	$04f8
	spc_mov_a_abs_x	$04b8
	spc_mov_abs_x_a	$0528
spca_1b70
	spc_ret
spca_1b71
	spc_bbs	7,$00,spca_1b78
	spc_mov_a_i	$01
	spc_bra	spca_1b7a
spca_1b78
	spc_mov_a_i	$02
spca_1b7a
	spc_mov_abs_x_a	$04b8
	spc_ret
spca_1b7e
	spc_mov_x_i	$00
spca_1b80
	spc_mov_a_abs_x	$0408
	spc_beq	spca_1b8b
	spc_call	spca_1b93
	spc_call	spca_1ba9
spca_1b8b
	spc_inc_x
	spc_cmp_x_i	$08
	spc_beq	spca_1b92
	spc_bra	spca_1b80
spca_1b92
	spc_ret
spca_1b93
	spc_mov_a_abs_x	$0488
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0490
	spc_mov_dp_a	$21
	spc_ret
spca_1b9e
	spc_mov_a_dp	$20
	spc_mov_abs_x_a	$0488
	spc_mov_a_dp	$21
	spc_mov_abs_x_a	$0490
	spc_ret
spca_1ba9
	spc_mov_a_abs_x	$03f8
	spc_beq	spca_1c01
	spc_cmp_a_i	$01
	spc_beq	spca_1bcd
	spc_cmp_a_i	$02
	spc_beq	spca_1be2
	spc_cmp_a_i	$03
	spc_beq	spca_1be7
	spc_mov_a_abs_x	$0410
	spc_bne	spca_1c04
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0390
	spc_mov_abs_x_a	$03f8
	spc_mov_abs_x_a	$0408
	spc_jmp	spca_1cee
spca_1bcd
	spc_mov_a_abs_x	$0410
	spc_bne	spca_1c04
	spc_mov_a_i	$02
	spc_mov_abs_x_a	$03f8
	spc_call	spca_1d46
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e8
spca_1bdf
	spc_jmp	spca_1d5a
spca_1be2
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e8
spca_1be7
	spc_mov_a_abs_x	$0410
	spc_bne	spca_1c04
	spc_mov_a_i	$03
	spc_mov_abs_x_a	$03f8
	spc_mov_a_abs_x	$03e8
	spc_beq	spca_1c1d
	spc_cmp_a_i	$01
	spc_beq	spca_1bcd
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03f0
	spc_bra	spca_1bcd
spca_1c01
	spc_mov_a_abs_x	$0410
spca_1c04
	spc_mov_abs_x_a	$0390
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$03f8
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03f0
	spc_mov_abs_x_a	$03e0
	spc_call	spca_1ccc
	spc_jmp	spca_1d50
spca_1c1a
	spc_jmp	spca_1c87
spca_1c1d
	spc_mov_a_abs_x	$03e0
	spc_beq	spca_1bdf
	spc_cmp_a_i	$01
	spc_beq	spca_1c1a
	spc_cmp_a_i	$0a
	spc_beq	spca_1c45
	spc_cmp_a_i	$1a
	spc_beq	spca_1c45
	spc_cmp_a_i	$0b
	spc_beq	spca_1c4e
	spc_cmp_a_i	$1b
	spc_beq	spca_1c4e
	spc_cmp_a_i	$0c
	spc_beq	spca_1c57
	spc_cmp_a_i	$1c
	spc_beq	spca_1c57
spca_1c3e
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e0
	spc_bra	spca_1bdf
spca_1c45
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$25
	spc_beq	spca_1c6d
	spc_bra	spca_1c3e
spca_1c4e
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$15
	spc_beq	spca_1c6d
	spc_bra	spca_1c3e
spca_1c57
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$17
	spc_beq	spca_1c6d
	spc_bra	spca_1c3e
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$05
	spc_beq	spca_1c87
	spc_cmp_a_i	$08
	spc_beq	spca_1c87
	spc_bra	spca_1c3e
spca_1c6d
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e0
	spc_mov_a_abs_x	$04f8
	spc_beq	spca_1c7f
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$04f8
	spc_jmp	spca_1bdf
spca_1c7f
	spc_mov_a_abs_x	$0480
	spc_bne	spca_1cac
	spc_jmp	spca_1bdf
spca_1c87
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e0
	spc_mov_a_abs_x	$04f8
	spc_beq	spca_1cac
	spc_push_a
	spc_mov_a_abs_x	$0528
	spc_cmp_a_i	$01
	spc_beq	spca_1ca0
	spc_cmp_a_i	$02
	spc_beq	spca_1ca5
	spc_pop_a
	spc_bra	spca_1cac
spca_1ca0
	spc_pop_a
	spc_asl_a
	spc_setc
	spc_bra	spca_1ca8
spca_1ca5
	spc_pop_a
	spc_asl_a
	spc_clrc
spca_1ca8
	spc_ror_a
	spc_call	spca_12fa
spca_1cac
	spc_mov_a_i	$04
	spc_mov_abs_x_a	$03f8
	spc_call	spca_1d50
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0480
	spc_mov_abs_x_a	$04f8
	spc_mov_abs_x_a	$03f0
	spc_mov_abs_x_a	$03c8
	spc_mov_abs_x_a	$04b8
	spc_mov_abs_x_a	$0528
	spc_mov_abs_x_a	$04f0
	spc_ret
spca_1ccc
	spc_call	spca_1cd6
	spc_mov_a_dp	$1a
	spc_or_a_dp	$22
	spc_mov_dp_a	$1a
	spc_ret
spca_1cd6
	spc_mov_dp_xreg	$22
	spc_inc_dp	$22
	spc_mov_a_i	$00
	spc_setc
spca_1cdd
	spc_rol_a
	spc_dec_dp	$22
	spc_bne	spca_1cdd
	spc_mov_dp_a	$22
	spc_ret
spca_1ce5
	spc_mov_dp_xreg	$22
	spc_inc_dp	$22
	spc_mov_a_i	$ff
	spc_clrc
	spc_bra	spca_1cdd
spca_1cee
	spc_call	spca_1ce5
	spc_mov_a_dp	$1a
	spc_and_a_dp	$22
	spc_mov_dp_a	$1a
	spc_push_x
	spc_clrc
	spc_mov_a_xreg
	spc_asl_a
	spc_mov_x_a
	spc_mov_a_abs_x	$0211
	spc_call	spca_0bc1
	spc_pop_x
	spc_mov_dp_xreg	$20
	spc_inc_dp	$20
	spc_mov_a_dp	$4f
spca_1d09
	spc_lsr_a
	spc_dec_dp	$20
	spc_bne	spca_1d09
	spc_bcc	spca_1d1b
	spc_call	spca_1cd6
	spc_mov_a_dp	$4a
	spc_or_a_dp	$22
	spc_mov_dp_a	$4a
	spc_bra	spca_1d24
spca_1d1b
	spc_call	spca_1ce5
	spc_mov_a_dp	$4a
	spc_and_a_dp	$22
	spc_mov_dp_a	$4a
spca_1d24
	spc_call	spca_1ce5
	spc_mov_a_dp	$1a
	spc_and_a_dp	$22
	spc_mov_dp_a	$1a
	spc_call	spca_1cd6
	spc_mov_a_dp	$47
	spc_or_a_dp	$22
	spc_mov_dp_a	$47
	spc_mov_a_dp	$5e
	spc_or_a_dp	$20
	spc_mov_dp_a	$5e
	spc_push_x
	spc_clrc
	spc_mov_a_xreg
	spc_asl_a
	spc_mov_x_a
	spc_call	spca_0e97
	spc_pop_x
	spc_ret
spca_1d46
	spc_call	spca_1cd6
	spc_mov_a_dp	$45
	spc_or_a_dp	$22
	spc_mov_dp_a	$45
	spc_ret
spca_1d50
	spc_call	spca_1cd6
	spc_mov_a_dp	$46
	spc_or_a_dp	$22
	spc_mov_dp_a	$46
	spc_ret
spca_1d5a
	spc_call	spca_1d63
	spc_call	spca_variantlookup
	spc_jmp	spca_21c8
spca_1d63
	spc_mov_a_abs_x	$0390
	spc_beq	spca_1d86
	spc_mov_a_abs_x	$0448
	spc_beq	spca_1d79
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$03f0
	spc_cmp_a_dp	$20
	spc_bne	spca_1d79
	spc_call	spca_186c
spca_1d79
	spc_mov_a_abs_x	$03f0
	spc_cmp_a_i	$ff
	spc_beq	spca_1d84
	spc_inc_a
	spc_mov_abs_x_a	$03f0
spca_1d84
	spc_bra	spca_1d8c
spca_1d86
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03f0
	spc_ret
spca_1d8c
	spc_call	spca_1b93
	spc_mov_a_abs_x	$03f0
	spc_beq	spca_1d9a
	spc_cmp_a_i	$01
	spc_beq	spca_1d9b
	spc_bra	spca_1ded
spca_1d9a
	spc_ret
spca_1d9b
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0400
	spc_mov_abs_x_a	$0438
	spc_mov_abs_x_a	$0520
	spc_mov_abs_x_a	$0478
	spc_mov_abs_x_a	$0448
	spc_mov_abs_x_a	$0440
	spc_mov_abs_x_a	$03a8
	spc_mov_abs_x_a	$03b0
	spc_mov_abs_x_a	$03b8
	spc_mov_abs_x_a	$0498
	spc_mov_abs_x_a	$03c0
	spc_mov_abs_x_a	$04a0
	spc_mov_abs_x_a	$04c0
	spc_mov_abs_x_a	$04c8
	spc_mov_abs_x_a	$04f0
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$04a8
	spc_mov_abs_x_a	$03a0
	spc_mov_abs_x_a	$04b0
	spc_mov_a_i	$8f
	spc_mov_abs_x_a	$03d0
	spc_mov_a_i	$e0
	spc_mov_abs_x_a	$03d8
	spc_call	spca_1ce5
	spc_mov_a_dp	$4a
	spc_and_a_dp	$22
	spc_mov_dp_a	$4a
	spc_mov_y_i	$01
	spc_bra	spca_1e05
spca_1ded
	spc_mov_a_abs_x	$0418
	spc_dec_a
	spc_mov_abs_x_a	$0418
	spc_beq	spca_1e00
	spc_cmp_a_i	$ff
	spc_beq	spca_1e00
	spc_jmp	spca_213f
	spc_jmp	spca_217b
spca_1e00
	spc_mov_a_abs_x	$0400
	spc_mov_y_a
spca_1e04
	spc_inc_y
spca_1e05
	spc_mov_a_dpi_y	$20
	spc_beq	spca_1e04
	spc_bpl	spca_1e56
	spc_setc
	spc_sbc_a_i	$e0
	spc_bmi	spca_1e87
	spc_asl_a
	spc_push_x
	spc_mov_x_a
	spc_jmp_abs_x	spca_voicecommands

; E0-FF effect-script commands; aliases and unused entries retained.
spca_voicecommands
	dw	spca_20b6,spca_1f0e,spca_1f12,spca_1f1b,spca_1f6a,spca_1fd4
	dw	spca_1fe3,spca_1ffe,spca_2012,spca_2027,spca_203c,spca_2048
	dw	spca_2055,spca_20c0,spca_20e1,spca_20b6,spca_20b6,spca_20eb
	dw	spca_20f4,spca_20fd,spca_20b6,spca_20b6,spca_20b6,spca_20b6
	dw	spca_210f,spca_20b6,spca_20b6,spca_2119,spca_2125,spca_212f
	dw	spca_1f68,spca_20b6
spca_1e56
	spc_push_a
	spc_mov_a_abs_x	$0478
	spc_beq	spca_1e62
	spc_cmp_a_i	$01
	spc_beq	spca_1e65
	spc_bra	spca_1e6a
spca_1e62
	spc_call	spca_1d50
spca_1e65
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$03e8
spca_1e6a
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0478
	spc_pop_a
	spc_mov_abs_x_a	$0418
	spc_cmp_a_i	$7f
	spc_bne	spca_1e7b
	spc_mov_a_i	$01
	spc_bra	spca_1e7d
spca_1e7b
	spc_mov_a_i	$00
spca_1e7d
	spc_mov_abs_x_a	$0420
	spc_mov_a_y
	spc_mov_abs_x_a	$0400
	spc_jmp	spca_1b9e
spca_1e87
	spc_push_y
	spc_push_x
	spc_clrc
	spc_adc_a_i	$60
	spc_mov_y_i	$00
	spc_mov_x_i	$0c
	spc_div_ya_x
	spc_push_a
	spc_mov_a_y
	spc_asl_a
	spc_mov_x_a
	spc_mov_a_abs_x	spca_effectpitches
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	spca_effectpitches+1
	spc_mov_dp_a	$23
	spc_pop_a
	spc_setc
	spc_sbc_a_i	$07
	spc_mov_dp_a	$24
	spc_beq	spca_1eb9
spca_1ea7
	spc_mov_y_i	$00
	spc_mov_a_dp	$23
	spc_mov_x_i	$02
	spc_div_ya_x
	spc_mov_dp_a	$23
	spc_mov_a_dp	$22
	spc_div_ya_x
	spc_mov_dp_a	$22
	spc_inc_dp	$24
	spc_bne	spca_1ea7
spca_1eb9
	spc_pop_x
	spc_mov_a_dp	$22
	spc_mov_abs_x_a	$03b8
	spc_mov_abs_x_a	$0498
	spc_mov_a_dp	$23
	spc_mov_abs_x_a	$03c0
	spc_mov_abs_x_a	$04a0
	spc_mov_a_abs_x	$0440
	spc_beq	spca_1f0a
	spc_push_x
	spc_mov_dp_a	$24
	spc_mov_a_dp	$23
	spc_setc
	spc_sbc_a_i	$10
	spc_bmi	spca_1eeb
	spc_mov_a_dp	$22
	spc_mov_y_dp	$23
	spc_mov_x_i	$43
	spc_div_ya_x
	spc_mov_y_i	$04
	spc_mul_ya
	spc_mov_x_i	$fc
	spc_div_ya_x
	spc_mov_y_dp	$24
	spc_mul_ya
	spc_bra	spca_1f00
spca_1eeb
	spc_mov_a_dp	$22
	spc_mov_y_dp	$23
	spc_mov_x_i	$11
	spc_div_ya_x
	spc_mov_x_a
	spc_mov_a_i	$ff
	spc_mov_y_i	$00
	spc_div_ya_x
	spc_mov_x_a
	spc_mov_y_i	$00
	spc_mov_a_dp	$24
	spc_div_ya_x
	spc_mov_y_i	$00
spca_1f00
	spc_addw_ya_dp	$22
	spc_pop_x
	spc_mov_abs_x_a	$03b8
	spc_mov_a_y
	spc_mov_abs_x_a	$03c0
spca_1f0a
	spc_pop_y
	spc_jmp	spca_1e04
spca_1f0e
	spc_mov_a_i	$01
	spc_bra	spca_1f14
spca_1f12
	spc_mov_a_i	$02
spca_1f14
	spc_pop_x
	spc_mov_abs_x_a	$0478
	spc_jmp	spca_1e04
spca_1f1b
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$03c8
	spc_jmp	spca_1e04
spca_1f25
	spc_push_x
	spc_push_y
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$04f0
	spc_cmp_a_i	$04
	spc_bne	spca_1f64
	spc_mov_a_abs_x	$04b8
	spc_cmp_a_i	$02
	spc_beq	spca_1f3b
	spc_mov_a_dp	$03
	spc_bra	spca_1f3d
spca_1f3b
	spc_mov_a_dp	$02
spca_1f3d
	spc_cmp_a_i	$00
	spc_bne	spca_1f42
	spc_inc_a
spca_1f42
	spc_mov_y_i	$03
	spc_mul_ya
	spc_mov_x_i	$02
	spc_call	spca_22e5
	spc_mov_dp_a	$24
	spc_mov_dp_y	$25
	spc_mov_a_i	$80
	spc_mov_y_i	$00
	spc_addw_ya_dp	$24
	spc_push_y
	spc_pop_x
	spc_mov_y_a
	spc_mov_a_dp	$22
	spc_call	spca_22d1
	spc_mov_a_y
	spc_bpl	spca_1f61
	spc_mov_a_i	$7f
spca_1f61
	spc_pop_y
	spc_pop_x
	spc_ret
spca_1f64
	spc_mov_a_dp	$22
	spc_bra	spca_1f61
spca_1f68
	spc_set	6,$2c
spca_1f6a
	spc_pop_x
	spc_inc_y
	spc_mov_a_abs_x	$04f0
	spc_cmp_a_i	$01
	spc_bne	spca_1f90
	spc_mov_a_dpi_y	$20
	spc_call	spca_1f25
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$04a8
	spc_bbs	6,$2c,spca_1f82
	spc_inc_y
spca_1f82
	spc_mov_a_dpi_y	$20
	spc_call	spca_1f25
	spc_mov_abs_x_a	$03a0
	spc_mov_abs_x_a	$04b0
	spc_jmp	spca_1fc7
spca_1f90
	spc_mov_a_abs_x	$04b8
	spc_cmp_a_i	$02
	spc_beq	spca_1fb0
	spc_mov_a_dpi_y	$20
	spc_call	spca_1f25
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$04a8
	spc_bbs	6,$2c,spca_1fa6
	spc_inc_y
spca_1fa6
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03a0
	spc_mov_abs_x_a	$04b0
	spc_bra	spca_1fc7
spca_1fb0
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$04a8
	spc_bbs	6,$2c,spca_1fbc
	spc_inc_y
spca_1fbc
	spc_mov_a_dpi_y	$20
	spc_call	spca_1f25
	spc_mov_abs_x_a	$03a0
	spc_mov_abs_x_a	$04b0
spca_1fc7
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03a8
	spc_mov_abs_x_a	$03b0
	spc_clr	6,$2c
	spc_jmp	spca_1e04
spca_1fd4
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$0f
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$03d0
	spc_and_a_i	$f0
	spc_bra	spca_1ff4
spca_1fe3
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$07
	spc_asl_a
	spc_asl_a
	spc_asl_a
	spc_asl_a
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$03d0
	spc_and_a_i	$8f
spca_1ff4
	spc_or_a_dp	$22
	spc_or_a_i	$80
	spc_mov_abs_x_a	$03d0
	spc_jmp	spca_1e04
spca_1ffe
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$07
	spc_asl_a
	spc_asl_a
	spc_asl_a
	spc_asl_a
	spc_asl_a
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$03d8
	spc_and_a_i	$1f
	spc_bra	spca_201f
spca_2012
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$1f
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$03d8
	spc_and_a_i	$e0
spca_201f
	spc_or_a_dp	$22
	spc_mov_abs_x_a	$03d8
	spc_jmp	spca_1e04
spca_2027
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0428
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0430
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$0438
	spc_jmp	spca_1e04
spca_203c
	spc_pop_x
	spc_call	spca_1cd6
	spc_mov_a_dp	$4a
	spc_or_a_dp	$22
	spc_mov_dp_a	$4a
	spc_bra	spca_2052
spca_2048
	spc_pop_x
	spc_call	spca_1ce5
	spc_mov_a_dp	$4a
	spc_and_a_dp	$22
	spc_mov_dp_a	$4a
spca_2052
	spc_jmp	spca_1e04
spca_2055
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_dp_a	$24
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_dp_a	$25
	spc_push_y
	spc_mov_x_i	$bc
spca_2062
	spc_mov_a_abs_x	$0702
	spc_cmp_a_dp	$24
	spc_beq	spca_206d
	spc_inc_x
	spc_inc_x
	spc_bra	spca_2062
spca_206d
	spc_inc_x
	spc_mov_a_abs_x	$0702
	spc_cmp_a_dp	$25
	spc_beq	spca_207c
	spc_inc_x
	spc_cmp_x_i	$00
	spc_beq	spca_2082
	spc_bra	spca_2062
spca_207c
	spc_mov_a_xreg
	spc_lsr_a
	spc_inc_a
	spc_call	spca_2087
spca_2082
	spc_pop_y
	spc_pop_x
	spc_jmp	spca_1e04
spca_2087
	spc_mov_dp_a	$23
	spc_push_a
	spc_mov_y_i	$00
	spc_mov_a_dpi_y	$24
	spc_mov_x_a
	spc_mov_a_abs_x	$04f0
	spc_cmp_a_i	$02
	spc_beq	spca_20b4
	spc_cmp_a_i	$03
	spc_beq	spca_20b4
	spc_call	spca_scriptchannel
	spc_call	spca_1b48
	spc_call	spca_1b71
	spc_mov_a_dp	$24
	spc_mov_abs_x_a	$0488
	spc_mov_a_dp	$25
	spc_mov_abs_x_a	$0490
	spc_call	spca_1afd
	spc_pop_a
	spc_jmp	spca_1c04
spca_20b4
	spc_pop_a
	spc_ret
spca_20b6
	spc_pop_x
	spc_mov_a_abs_x	$0420
	spc_bne	spca_20bf
	spc_call	spca_186c
spca_20bf
	spc_ret
spca_20c0
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0500
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0508
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0510
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0518
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$0520
	spc_jmp	spca_1e04
spca_20e1
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0440
	spc_jmp	spca_1e04
spca_20eb
	spc_pop_x
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0438
	spc_jmp	spca_1e04
spca_20f4
	spc_pop_x
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0520
	spc_jmp	spca_1e04
spca_20fd
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_push_a
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_dp_a	$21
	spc_pop_a
	spc_mov_dp_a	$20
	spc_mov_y_i	$00
	spc_jmp	spca_1e05
spca_210f
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0448
	spc_jmp	spca_1e04
spca_2119
	spc_pop_x
	spc_call	spca_1d50
	spc_mov_a_i	$02
	spc_mov_abs_x_a	$0478
	spc_jmp	spca_1e04
spca_2125
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$04f0
	spc_jmp	spca_1e04
spca_212f
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$fe
	spc_push_y
	spc_push_x
	spc_call	spca_initnoise
	spc_pop_x
	spc_pop_y
	spc_jmp	spca_1e04
spca_213f
	spc_mov_a_abs_x	$0438
	spc_beq	spca_216f
	spc_mov_a_abs_x	$0428
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0430
	spc_mov_dp_a	$21
	spc_mov_a_abs_x	$04a0
	spc_mov_y_a
	spc_mov_a_abs_x	$0498
	spc_addw_ya_dp	$20
	spc_mov_abs_x_a	$0498
	spc_mov_a_y
	spc_mov_abs_x_a	$04a0
	spc_bmi	spca_2170
	spc_setc
	spc_sbc_a_i	$40
	spc_bpl	spca_2175
	spc_mov_a_abs_x	$0498
spca_2168
	spc_mov_abs_x_a	$03b8
	spc_mov_a_y
	spc_mov_abs_x_a	$03c0
spca_216f
	spc_ret
spca_2170
	spc_mov_a_i	$00
	spc_mov_y_a
	spc_bra	spca_2168
spca_2175
	spc_mov_a_i	$ff
	spc_mov_y_i	$3f
	spc_bra	spca_2168
spca_217b
	spc_mov_a_abs_x	$0520
	spc_beq	spca_21a4
	spc_mov_a_abs_x	$0500
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0508
	spc_mov_dp_a	$21
	spc_call	spca_21a5
	spc_mov_a_abs_x	$0510
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0518
	spc_mov_dp_a	$21
	spc_mov_a_xreg
	spc_clrc
	spc_adc_a_i	$08
	spc_mov_x_a
	spc_call	spca_21a5
	spc_mov_a_xreg
	spc_setc
	spc_sbc_a_i	$08
	spc_mov_x_a
spca_21a4
	spc_ret
spca_21a5
	spc_mov_a_abs_x	$04a8
	spc_mov_y_a
	spc_mov_a_abs_x	$03a8
	spc_addw_ya_dp	$20
	spc_mov_abs_x_a	$03a8
	spc_mov_a_y
	spc_mov_abs_x_a	$04a8
	spc_bmi	spca_21b9
	spc_bra	spca_21c4
spca_21b9
	spc_setc
	spc_sbc_a_i	$c0
	spc_bmi	spca_21c2
	spc_mov_a_i	$00
	spc_bra	spca_21c4
spca_21c2
	spc_mov_a_i	$7f
spca_21c4
	spc_mov_abs_x_a	$0398
	spc_ret
spca_21c8
	spc_mov_a_xreg
	spc_mov_y_i	$10
	spc_mul_ya
	spc_mov_y_a
	spc_push_y
	spc_mov_a_abs_x	$0408
	spc_beq	spca_21dd
	spc_mov_a_abs_x	$04c0
	spc_beq	spca_21dd
	spc_call	spca_2243
	spc_bra	spca_21e0
spca_21dd
	spc_mov_a_abs_x	$0398
spca_21e0
	spc_call	spca_22f2
	spc_pop_y
	spc_call	spca_09e8
	spc_inc_y
	spc_push_y
	spc_mov_a_abs_x	$0408
	spc_beq	spca_21fe
	spc_mov_a_abs_x	$04c8
	spc_beq	spca_21fe
	spc_call	spca_22bf
	spc_call	spca_2243
	spc_call	spca_22c8
	spc_bra	spca_2201
spca_21fe
	spc_mov_a_abs_x	$03a0
spca_2201
	spc_call	spca_22f2
	spc_pop_y
	spc_call	spca_09e8
	spc_inc_y
	spc_mov_a_abs_x	$03b8
	spc_call	spca_09e8
	spc_inc_y
	spc_mov_a_abs_x	$03c0
	spc_call	spca_09e8
	spc_inc_y
	spc_mov_a_abs_x	$03c8
	spc_call	spca_09e8
	spc_inc_y
	spc_mov_a_abs_x	$03d0
	spc_call	spca_09e8
	spc_inc_y
	spc_mov_a_abs_x	$03d8
	spc_jmp	spca_09e8

; Twelve fixed-point pitch words.
spca_effectpitches
	dw	$217c,$237a,$2596,$27d2,$2a30,$2cb2
	dw	$2f5a,$322c,$3528,$3850,$3baa,$3f36
spca_2243
	spc_cmp_a_i	$01
	spc_beq	spca_2255
	spc_cmp_a_i	$3c
	spc_beq	spca_2292
	spc_cmp_a_i	$ff
	spc_beq	spca_22ba
	spc_inc_a
	spc_mov_abs_x_a	$04c0
	spc_bra	spca_226e
spca_2255
	spc_inc_a
	spc_mov_abs_x_a	$04c0
	spc_mov_a_abs_x	$0398
	spc_mov_y_a
	spc_mov_a_abs_x	$03a8
	spc_push_x
	spc_mov_x_i	$3c
	spc_call	spca_22e5
	spc_pop_x
	spc_mov_abs_x_a	$04d0
	spc_mov_a_y
	spc_mov_abs_x_a	$04e0
spca_226e
	spc_mov_a_abs_x	$04c0
	spc_dec_a
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$04d0
	spc_mov_y_a
	spc_mov_a_abs_x	$04e0
	spc_push_x
	spc_mov_x_a
	spc_mov_a_dp	$22
	spc_call	spca_22d1
	spc_pop_x
	spc_mov_dp_a	$22
	spc_mov_dp_y	$23
	spc_mov_a_abs_x	$0398
	spc_mov_y_a
	spc_mov_a_abs_x	$03a8
	spc_subw_ya_dp	$22
	spc_mov_a_y
	spc_ret
spca_2292
	spc_bbs	7,$2c,spca_229a
	spc_bbs	0,$2d,spca_229d
	spc_bra	spca_22a0
spca_229a
	spc_jmp	spca_receiverrestart
spca_229d
	spc_jmp	spca_iplrestart
spca_22a0
	spc_mov_dp_xreg	$22
	spc_bbs	3,$22,spca_22af
	spc_call	spca_186c
spca_22a8
	spc_mov_a_i	$ff
	spc_mov_abs_x_a	$04c0
	spc_inc_a
	spc_ret
spca_22af
	spc_call	spca_22c8
	spc_call	spca_186c
	spc_call	spca_22bf
	spc_bra	spca_22a8
spca_22ba
	spc_inc_a
	spc_mov_abs_x_a	$04c0
	spc_ret
spca_22bf
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_ret
spca_22c8
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_ret
spca_22d1
	spc_push_a
	spc_mul_ya
	spc_mov_dp_a	$26
	spc_mov_dp_y	$27
	spc_mov_a_xreg
	spc_mov_y_a
	spc_pop_a
	spc_mul_ya
	spc_push_a
	spc_mov_a_y
	spc_mov_x_a
	spc_pop_a
	spc_mov_y_a
	spc_mov_a_i	$00
	spc_addw_ya_dp	$26
	spc_ret
spca_22e5
	spc_push_a
	spc_push_y
	spc_mov_y_i	$00
	spc_pop_a
	spc_div_ya_x
	spc_mov_dp_a	$27
	spc_pop_a
	spc_div_ya_x
	spc_mov_y_dp	$27
	spc_ret
spca_22f2
	spc_push_y
	spc_mov_dp_a	$22
	spc_cmp_a_i	$00
	spc_beq	spca_2318
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$25
	spc_bne	spca_231a
	spc_cmp_x_i	$05
	spc_beq	spca_230a
	spc_cmp_x_i	$04
	spc_beq	spca_230f
	spc_bra	spca_2318
spca_230a
	spc_mov_a_abs	$0530
	spc_bra	spca_2312
spca_230f
	spc_mov_a_abs	$0531
spca_2312
	spc_mov_y_i	$04
	spc_mul_ya
	spc_clrc
	spc_adc_a_dp	$22
spca_2318
	spc_pop_y
	spc_ret
spca_231a
	spc_mov_a_dp	$22
	spc_bra	spca_2318
spca_variantlookup
	spc_mov_a_abs_x	$0390
	spc_mov_dp_a	$20
	spc_push_x
	spc_mov_x_i	$00
spca_2326
	spc_mov_a_abs_x	spca_variantids
	spc_beq	spca_2332
	spc_cmp_a_dp	$20
	spc_beq	spca_2334
	spc_inc_x
	spc_bra	spca_2326
spca_2332
	spc_pop_x
	spc_ret
spca_2334
	spc_mov_a_xreg
	spc_asl_a
	spc_mov_x_a
	spc_jmp_abs_x	spca_variantdispatch

; Six effect variants, a zero terminator, their dispatch PCs and parameters.
spca_variantids
	db	$79,$78,$77,$7a,$17,$25,$00
spca_variantdispatch
	dw	spca_enginevariant,spca_enginevariant,spca_enginevariant,spca_enginevariant,spca_ratevariant2,spca_ratevariant1

; Four divisors, volume bases, pitch bases and pitch steps.
spca_variantparams
	db	$0c,$13,$55,$7f
spca_variantvolumes
	db	$23,$1a,$17,$17
spca_variantpitchbases
	db	$0c,$0b,$0e,$07
spca_variantpitchsteps
	db	$1b,$1e,$1f,$12
spca_enginevariant
	spc_lsr_a
	spc_mov_x_a
	spc_mov_a_abs_x	spca_variantparams
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	spca_variantvolumes
	spc_mov_dp_a	$23
	spc_mov_a_abs_x	spca_variantpitchbases
	spc_mov_dp_a	$24
	spc_mov_a_abs_x	spca_variantpitchsteps
	spc_mov_dp_a	$25
	spc_pop_x
	spc_cmp_x_i	$07
	spc_beq	spca_237d
	spc_cmp_x_i	$06
	spc_beq	spca_2381
	spc_ret
spca_237d
	spc_mov_y_i	$01
	spc_bra	spca_updateengineparams
spca_2381
	spc_mov_y_i	$00

; Control/cache delta sets direction and SPC DIV slope.
spca_updateengineparams
	spc_call	spca_enginevolume
	spc_push_x
	spc_mov_a_y
	spc_mov_x_a
	spc_mov_a_abs_x	$0002
	spc_cmp_a_abs_x	$000a
	spc_beq	spca_23df
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0538
	spc_mov_a_abs_x	$0002
	spc_mov_abs_x_a	$053a
	spc_setc
	spc_sbc_a_abs_x	$000a
	spc_bmi	spca_23d4
	spc_push_a
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$053c

; Division overflow is retained as the separate high slope byte.
spca_23a8
	spc_pop_a
	spc_mov_y_a
	spc_mov_a_abs_x	$0532
	spc_push_x
	spc_mov_x_a
	spc_bne	spca_23b3
	spc_mov_x_i	$01
spca_23b3
	spc_mov_a_i	$00
	spc_div_ya_x
	spc_bvs	spca_23c3
	spc_pop_x
	spc_mov_abs_x_a	$0534
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0536
	spc_bra	spca_23cc
spca_23c3
	spc_pop_x
	spc_mov_abs_x_a	$0534
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$0536
spca_23cc
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0532
	spc_jmp	spca_248b
spca_23d4
	spc_eor_a_i	$ff
	spc_inc_a
	spc_push_a
	spc_mov_a_i	$02
	spc_mov_abs_x_a	$053c
	spc_bra	spca_23a8
spca_23df
	spc_mov_a_abs_x	$0002
	spc_bne	spca_23ee
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0534
	spc_mov_abs_x_a	$0536
	spc_bra	spca_2414
spca_23ee
	spc_mov_a_abs_x	$0002
	spc_bpl	spca_2414
	spc_setc
	spc_sbc_a_i	$f0
	spc_bmi	spca_2414
	spc_mov_a_abs_x	$056c
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$056e
	spc_mov_dp_a	$23
	spc_incw_dp	$22
	spc_incw_dp	$22
	spc_incw_dp	$22
	spc_mov_a_dp	$22
	spc_mov_abs_x_a	$056c
	spc_mov_a_dp	$23
	spc_mov_abs_x_a	$056e
	spc_bra	spca_241c
spca_2414
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$056c
	spc_mov_abs_x_a	$056e
spca_241c
	spc_mov_a_abs_x	$0532
	spc_setc
	spc_sbc_a_i	$0a
	spc_bmi	spca_2440
	spc_mov_dp_i	$22,$01
	spc_mov_dp_i	$23,$00
	spc_mov_a_abs_x	$0536
	spc_mov_y_a
	spc_mov_a_abs_x	$0534
	spc_subw_ya_dp	$22
	spc_bpl	spca_2439
	spc_mov_a_i	$00
	spc_mov_y_i	$00
spca_2439
	spc_mov_abs_x_a	$0534
	spc_mov_a_y
	spc_mov_abs_x_a	$0536
spca_2440
	spc_mov_a_abs_x	$0532
	spc_cmp_a_i	$ff
	spc_beq	spca_244e
	spc_mov_a_abs_x	$0532
	spc_inc_a
	spc_mov_abs_x_a	$0532
spca_244e
	spc_mov_a_abs_x	$0532
	spc_cmp_a_i	$01
	spc_beq	spca_2483
	spc_mov_a_abs_x	$053a
	spc_mov_y_a
	spc_mov_a_abs_x	$0538
spca_245c
	spc_push_a
	spc_mov_a_abs_x	$0534
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0536
	spc_mov_dp_a	$21
	spc_mov_a_abs_x	$053c
	spc_cmp_a_i	$02
	spc_beq	spca_247c
	spc_pop_a
	spc_addw_ya_dp	$20
	spc_bcs	spca_248b
spca_2473
	spc_mov_abs_x_a	$0538
	spc_mov_a_y
	spc_mov_abs_x_a	$053a
	spc_bra	spca_248b
spca_247c
	spc_pop_a
	spc_subw_ya_dp	$20
	spc_bcc	spca_248b
	spc_bra	spca_2473
spca_2483
	spc_mov_a_abs_x	$0002
	spc_mov_y_a
	spc_mov_a_i	$00
	spc_bra	spca_245c
spca_248b
	spc_mov_dp_i	$20,$00
	spc_mov_dp_dp	$21,$24
	spc_mov_y_dp	$25
	spc_mov_a_abs_x	$053a
	spc_mul_ya
	spc_mov_dp_i	$20,$00
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21
	spc_mov_a_abs_x	$054a
	spc_mov_y_a
	spc_mov_a_abs_x	$0548
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21
	spc_mov_a_abs_x	$054e
	spc_mov_y_a
	spc_mov_a_abs_x	$054c
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21
	spc_mov_a_abs_x	$056e
	spc_mov_y_a
	spc_mov_a_abs_x	$056c
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21

; Retain the destructive high-byte SBC and its signed-result cap.
	spc_setc
	spc_sbc_dp_i	$21,$3f
	spc_bmi	spca_24d0
	spc_mov_dp_i	$21,$3f
spca_24d0
	spc_mov_a_abs_x	$0002
	spc_mov_abs_x_a	$000a
	spc_pop_x
	spc_mov_a_dp	$20
	spc_mov_abs_x_a	$03b8
	spc_mov_a_dp	$21
	spc_mov_abs_x_a	$03c0
	spc_ret

; Quotient volume, engine boost, optional near attenuation and fade scale.
spca_enginevolume
	spc_mov_a_abs_y	$0002
	spc_eor_a_i	$ff
	spc_push_y
	spc_mov_y_i	$00
	spc_push_x
	spc_mov_x_dp	$22
	spc_div_ya_x
	spc_mov_dp_a	$20
	spc_pop_x
	spc_pop_y
	spc_mov_a_dp	$23
	spc_clrc
	spc_adc_a_dp	$20
	spc_cmp_y_i	$00
	spc_beq	spca_2513
	spc_bbc	2,$29,spca_2500

; CPY #0 left carry set: this ADC adds four.
	spc_adc_a_i	$03
spca_2500
	spc_call	spca_2530
	spc_push_y
	spc_mov_y_abs	$056b
	spc_mul_ya
	spc_mov_a_y
	spc_pop_y
	spc_mov_abs_x_a	$0398
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03a0
	spc_ret
spca_2513
	spc_bbc	4,$29,spca_2518
	spc_adc_a_i	$03
spca_2518
	spc_call	spca_252b
	spc_push_y
	spc_mov_y_abs	$056b
	spc_mul_ya
	spc_mov_a_y
	spc_pop_y
	spc_mov_abs_x_a	$03a0
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0398
	spc_ret
spca_252b
	spc_bbs	4,$28,spca_2539
	spc_bra	spca_2533
spca_2530
	spc_bbs	2,$28,spca_2539
spca_2533
	spc_push_y
	spc_mov_y_i	$d0
	spc_mul_ya
	spc_mov_a_y
	spc_pop_y
spca_2539
	spc_ret

; Periodic script waits use complement/control division and an 8-bit counter.
spca_ratevariant1
	spc_mov_dp_i	$22,$1e
	spc_mov_dp_i	$23,$03
	spc_mov_dp_i	$24,$01
	spc_bra	spca_254e
spca_ratevariant2
	spc_mov_dp_i	$22,$14
	spc_mov_dp_i	$23,$0a
	spc_mov_dp_i	$24,$02
spca_254e
	spc_pop_x
	spc_cmp_x_i	$05
	spc_beq	spca_2558
	spc_cmp_x_i	$04
	spc_beq	spca_255c
	spc_ret
spca_2558
	spc_mov_y_i	$01
	spc_bra	spca_pulseperiod
spca_255c
	spc_mov_y_i	$00
spca_pulseperiod
	spc_mov_a_abs_y	$0002
	spc_eor_a_i	$ff
	spc_push_y
	spc_mov_y_i	$00
	spc_push_x
	spc_mov_x_dp	$22
	spc_div_ya_x
	spc_pop_x
	spc_pop_y
	spc_clrc
	spc_adc_a_dp	$23
	spc_push_a
	spc_mov_a_abs_y	$0544
	spc_inc_a
	spc_mov_abs_y_a	$0544
	spc_pop_a
	spc_setc
	spc_sbc_a_abs_y	$0544
	spc_bpl	spca_2587
	spc_mov_a_dp	$24
	spc_mov_abs_x_a	$03e8
	spc_dec_a
	spc_mov_abs_y_a	$0544
spca_2587
	spc_ret

; Generated-noise frame headers, directory slot $23 and nonzero PRNG seed.
spca_initnoise
	spc_mov_y_i	$00
	spc_mov_x_i	$1b
spca_258c
	spc_mov_abs_y_a	$ff00
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_dec_x
	spc_bne	spca_258c
	spc_inc_a
	spc_mov_abs_y_a	$ff00
	spc_mov_y_i	$ff
	spc_mov_a_i	$00
	spc_mov_abs_a	$3f8c
	spc_mov_abs_y	$3f8d
	spc_mov_abs_a	$3f8e
	spc_mov_abs_y	$3f8f
	spc_mov_a_dp	$18
	spc_or_a_dp	$19
	spc_bne	spca_25b7
	spc_inc_dp	$18
spca_25b7
	spc_ret

; Scan voices 0-6 for SRCN $23; voice 7 is excluded in this variant.
spca_updatenoise
	spc_mov_x_i	$00
spca_25ba
	spc_mov_a_abs_x	$03c8
	spc_cmp_a_i	$23
	spc_beq	spca_25c8
	spc_inc_x
	spc_cmp_x_i	$07
	spc_beq	spca_25b7
	spc_bra	spca_25ba
spca_25c8
	spc_dec_abs	$0563
	spc_mov_a_abs	$0563
	spc_and_a_i	$03
	spc_mov_y_i	$3f
	spc_mul_ya
	spc_mov_y_a
	spc_mov_dp_i	$20,$07
spca_25d7
	spc_inc_y
	spc_mov_x_i	$04
spca_25da
	spc_mov1_c	$0019,6
	spc_eor1_c	$0019,5
	spc_rol_dp	$18
	spc_rol_dp	$19
	spc_mov_a_dp	$19
	spc_and_a_i	$d0
	spc_or_a_i	$11
	spc_mov_abs_y_a	$ff00
	spc_inc_y
	spc_mov_a_dp	$18
	spc_and_a_i	$ff
	spc_or_a_i	$11
	spc_mov_abs_y_a	$ff00
	spc_inc_y
	spc_dec_x
	spc_bne	spca_25da
	spc_dbnz_dp	$20,spca_25d7
	spc_ret

; Two zero-terminated effect classification lists.
spca_effectclass0
	db	$03,$10,$32,$30,$3c,$16,$20,$56,$00
spca_effectclass1
	db	$30,$3c,$38,$16,$20,$56,$00
	spc_endblock	$155f
	dw	0,$0800
racesound_spcaltend

; Additional directory/BRR upload at $1BDCD8. One looping sample.
racesound_spcr1bdcd8
	spc_block	spca_extradir,$3f90,$0010
	spc_sampledef	spca_ccd0,spca_cceb
	spc_sampledef	$ffff,$ffff
	spc_sampledef	$ffff,$ffff
	spc_sampledef	$ffff,$ffff
	spc_endblock	$0010
	spc_block	spca_extrabrr,$ccd0,$0160
spca_ccd0
	spc_brrblock	0,0,spc_brrloop,$0000,$0000,$0000,$0000
	spc_brrblock	12,0,spc_brrloop,$2100,$ff00,$32fd,$f3ff
	spc_brrblock	13,0,spc_brrloop,$1fee,$03fd,$0010,$e230
spca_cceb
	spc_brrblock	12,1,spc_brrloop,$30d3,$fc32,$e00f,$1e24
	spc_brrblock	12,1,spc_brrloop,$ae43,$0a12,$d013,$ee42
	spc_brrblock	12,0,spc_brrloop,$2dc0,$32f0,$2de1,$eee0
	spc_brrblock	11,0,spc_brrloop,$51fe,$e43b,$e0e2,$2fde
	spc_brrblock	11,0,spc_brrloop,$131c,$e31f,$df32,$2201
	spc_brrblock	11,1,spc_brrloop,$32db,$f53d,$10c0,$41bd
	spc_brrblock	10,0,spc_brrloop,$f621,$3f02,$21cd,$31ed
	spc_brrblock	10,0,spc_brrloop,$f44f,$e001,$fdeb,$b2fa
	spc_brrblock	10,0,spc_brrloop,$d121,$0010,$01ef,$fef2
	spc_brrblock	9,0,spc_brrloop,$fae5,$4f17,$7ef6,$3e12
	spc_brrblock	10,1,spc_brrloop,$11f1,$f00f,$30df,$31df
	spc_brrblock	10,1,spc_brrloop,$120f,$010f,$11dd,$231c
	spc_brrblock	10,1,spc_brrloop,$e51e,$ff2f,$f1fb,$060e
	spc_brrblock	10,0,spc_brrloop,$cc10,$0201,$0032,$0ce3
	spc_brrblock	11,1,spc_brrloop,$f100,$0c22,$d2ff,$3cf0
	spc_brrblock	10,1,spc_brrloop,$5393,$de40,$6ec1,$15bd
	spc_brrblock	9,0,spc_brrloop,$232b,$f621,$ff4d,$c5fe
	spc_brrblock	10,0,spc_brrloop,$2231,$e122,$1f16,$2d42
	spc_brrblock	10,1,spc_brrloop,$d006,$e14b,$b14f,$e3e1
	spc_brrblock	10,0,spc_brrloop,$3d1f,$b21e,$1113,$2cc1
	spc_brrblock	10,0,spc_brrloop,$10cb,$dcfe,$11bd,$00fe
	spc_brrblock	10,1,spc_brrloop,$e21e,$42c1,$41dc,$f32e
	spc_brrblock	10,0,spc_brrloop,$23e0,$2d33,$e330,$1ff7
	spc_brrblock	10,0,spc_brrloop,$400e,$6304,$045f,$34cf
	spc_brrblock	10,1,spc_brrloop,$2a21,$f2de,$6fa3,$0e4e
	spc_brrblock	10,1,spc_brrloop,$01b2,$400c,$13e2,$df2e
	spc_brrblock	10,1,spc_brrloop,$1212,$0dc0,$2410,$2c03
	spc_brrblock	10,0,spc_brrloop,$2ee4,$1def,$1e03,$bc03
	spc_brrblock	10,0,spc_brrloop,$6ee3,$eccf,$1eff,$cb23
	spc_brrblock	10,0,spc_brrloop,$eff2,$111d,$0033,$e22f
	spc_brrblock	10,1,spc_brrloop,$0e42,$c0f2,$ef40,$de13
	spc_brrblock	10,0,spc_brrloop,$211f,$bf53,$fdf1,$2422
	spc_brrblock	10,1,spc_brrloop,$fce3,$3f14,$eb13,$ff54
	spc_brrblock	12,0,spc_brrloop,$2100,$ff00,$32fd,$f3ff
	spc_brrblock	13,0,spc_brrend+spc_brrloop,$1fee,$03fd,$0010,$e230
; Ten native padding bytes after the looping BRR end frame.
	db	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	spc_endblock	$0160
	dw	0,$0800
racesound_spcr1bdcd8end

; Split-screen driver switch, US $03:D95F-$03:D981.
; The retail initializer selects this block only for play mode 2.
; Callable form adds RTL and uses the assembled overlay's ROM address.
racesound_splitdriver_l
	php
	ai16
	lda	#$0005
	sta.l	apu_port1
	lda	#$4000
racealt_stopdelay
	dec	a
	bne	racealt_stopdelay
	lda	#racesound_spcalt>>16
	ldy	#racesound_spcalt&WM
	jsl	racesound_boot_l
	a16
	lda	#$4000
racealt_initdelay
	dec	a
	bne	racealt_initdelay
	plp
	rtl
racesound_splitdriver_end
