; Retail SPC effect/voice engine and parameter control. Native RAM PCs.
; Included in the partial XLSPC overlay; external script/helpers and samples
; remain at their native SPC addresses until their source is restored.

spc_0bc1	equ	$0bc1

	spc_block	spc_parameterblock,$112f,$0676
spc_112f
	spc_bbc	6,$2d,spc_remapdone
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$43
	spc_beq	spc_remapdone
	spc_mov_x_i	$05
	spc_jmp	spc_releasechannel
spc_113e
	spc_bbc	5,$2d,spc_116f
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$01
	spc_beq	spc_1170
	spc_cmp_a_i	$04
	spc_beq	spc_1170
	spc_cmp_a_i	$07
	spc_beq	spc_1170
	spc_cmp_a_i	$0a
	spc_beq	spc_1170
	spc_cmp_a_i	$0d
	spc_beq	spc_1170
spc_1158
	spc_mov_a_abs	$0396
	spc_cmp_a_i	$72
	spc_beq	spc_1177
	spc_cmp_a_i	$73
	spc_beq	spc_1177
	spc_cmp_a_i	$74
	spc_beq	spc_1177
	spc_cmp_a_i	$75
	spc_beq	spc_1177
	spc_cmp_a_i	$76
	spc_beq	spc_1177
spc_116f
	spc_ret
spc_1170
	spc_mov_x_i	$07
	spc_call	spc_releasechannel
	spc_bra	spc_1158
spc_1177
	spc_mov_x_i	$06
	spc_jmp	spc_releasechannel
spc_117c
	spc_inc_abs	$0581
	spc_mov_a_abs	$0581
	spc_cmp_a_i	$03
	spc_beq	spc_11ac
	spc_cmp_a_i	$09
	spc_beq	spc_113e
	spc_cmp_a_i	$0c
	spc_beq	spc_11bc
	spc_cmp_a_i	$0f
	spc_beq	spc_11ca
	spc_cmp_a_i	$12
	spc_beq	spc_11e1
	spc_cmp_a_i	$15
	spc_beq	spc_11ea
	spc_sbc_a_i	$16
	spc_bmi	spc_11a3
	spc_mov_a_i	$00
	spc_mov_abs_a	$0581
spc_11a3
	spc_cmp_dp_i	$1c,$01
	spc_beq	spc_11ab
	spc_mov_dp_i	$2a,$00
spc_11ab
	spc_ret
spc_11ac
	spc_bbc	3,$2d,spc_11a3
	spc_mov_a_abs	$0394
	spc_cmp_a_i	$02
	spc_bne	spc_11a3
	spc_mov_dp_i	$20,$08
	spc_jmp	spc_stopchannel4
spc_11bc
	spc_bbs	0,$2a,spc_11c5
	spc_mov_dp_i	$20,$0c
	spc_jmp	spc_stopchannel5_17
spc_11c5
	spc_mov_a_i	$17
	spc_jmp	spc_dispatchsfx
spc_11ca
	spc_bbs	2,$2a,spc_11d3
	spc_mov_dp_i	$20,$0a
	spc_jmp	spc_stopchannel5_25
spc_11d3
	spc_bbs	0,$2a,spc_11a3
	spc_bbs	7,$2a,spc_11a3
	spc_bbs	4,$2a,spc_11a3
	spc_mov_a_i	$25
	spc_jmp	spc_dispatchsfx
spc_11e1
	spc_bbs	4,$2a,spc_11a3
	spc_mov_dp_i	$20,$0b
	spc_jmp	spc_stopchannel5_15
spc_11ea
	spc_bbs	7,$2a,spc_11f3
	spc_mov_dp_i	$20,$0e
	spc_jmp	spc_stopchannel5_21
spc_11f3
	spc_mov_a_i	$21
	spc_jmp	spc_dispatchsfx
spc_11f8
	spc_mov_a_abs	$ee40
	spc_cmp_a_i	$98
	spc_bne	spc_1204
	spc_bbc	4,$2d,spc_1204
	spc_set	7,$2d
spc_1204
	spc_mov_a_abs	$cb10
	spc_cmp_a_i	$14
	spc_beq	spc_1211
	spc_mov_a_i	$04
	spc_clr	4,$2d
	spc_bra	spc_1215
spc_1211
	spc_mov_a_i	$1e
	spc_set	4,$2d
spc_1215
	spc_mov_abs_a	$1c05
	spc_mov_a_abs	$056a
	spc_cmp_a_i	$ff
	spc_beq	spc_1222
	spc_inc_abs	$056a
spc_1222
	spc_mov_a_dp	$1b
	spc_cmp_a_i	$05
	spc_beq	spc_122a
	spc_bra	spc_1232
spc_122a
	spc_mov_a_i	$00
	spc_mov_abs_a	$056a
	spc_mov_abs_a	$056b
spc_1232
	spc_mov_a_abs	$056a
	spc_bmi	spc_1239
	spc_bra	spc_1243
spc_1239
	spc_mov_a_abs	$056b
	spc_cmp_a_i	$ff
	spc_beq	spc_1243
	spc_inc_abs	$056b
spc_1243
	spc_cmp_dp_i	$1d,$35
	spc_bne	spc_124d
	spc_mov_a_i	$ff
	spc_mov_abs_a	$056b
spc_124d
	spc_cmp_dp_i	$1b,$02
	spc_bne	spc_1257
	spc_mov_a_i	$01
	spc_mov_abs_a	$0567
spc_1257
	spc_mov_a_abs	$0567
	spc_beq	spc_126e
	spc_inc_abs	$0567
	spc_mov_a_abs	$0567
	spc_cmp_a_i	$e6
	spc_bne	spc_126e
	spc_mov_a_i	$00
	spc_mov_abs_a	$0567
	spc_mov_dp_i	$1b,$03
spc_126e
	spc_mov_a_dp	$53
	spc_cmp_a_i	$1b
	spc_beq	spc_1288
	spc_cmp_a_i	$1d
	spc_beq	spc_128c
	spc_cmp_a_i	$1e
	spc_beq	spc_1290
	spc_cmp_a_i	$29
	spc_beq	spc_1294
	spc_cmp_a_i	$2a
	spc_beq	spc_1298
	spc_mov_a_i	$8e
	spc_bra	spc_129c
spc_1288
	spc_mov_a_i	$73
	spc_bra	spc_129c
spc_128c
	spc_mov_a_i	$6a
	spc_bra	spc_129c
spc_1290
	spc_mov_a_i	$67
	spc_bra	spc_129c
spc_1294
	spc_mov_a_i	$92
	spc_bra	spc_129c
spc_1298
	spc_mov_a_i	$93
	spc_bra	spc_129c
spc_129c
	spc_mov_abs_a	$0586
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$0d
	spc_beq	spc_1315
	spc_mov_a_abs	$055f
	spc_bne	spc_12b7
	spc_cmp_dp_i	$01,$1d
	spc_bne	spc_1315
	spc_mov_a_i	$01
	spc_mov_abs_a	$055f
	spc_bra	spc_1315
spc_12b7
	spc_mov_a_abs	$0582
	spc_beq	spc_12ca
	spc_dec_abs	$0582
	spc_mov_a_abs	$0582
	spc_cmp_a_i	$04
	spc_beq	spc_12fa
	spc_cmp_a_i	$01
	spc_beq	spc_130b
spc_12ca
	spc_cmp_dp_i	$1d,$30
	spc_bne	spc_1315
	spc_inc_abs	$055f
	spc_mov_a_abs	$055f
	spc_cmp_a_i	$03
	spc_bne	spc_1315
	spc_mov_dp_i	$40,$48
	spc_mov_dp_i	$41,$ee
	spc_set	0,$2c
	spc_mov_a_abs	$0586
	spc_mov_abs_a	$0582
	spc_mov_x_i	$00
	spc_call	spc_1d63
	spc_inc_x
	spc_call	spc_1d63
	spc_mov_a_dp	$59
	spc_mov_abs_a	$0587
	spc_mov_dp_i	$59,$be
	spc_bra	spc_1315
spc_12fa
	spc_mov_a_abs	$0587
	spc_mov_dp_a	$59
	spc_mov_x_i	$00
	spc_call	spc_1e31
	spc_mov_x_i	$01
	spc_call	spc_1e31
	spc_bra	spc_1315
spc_130b
	spc_inc_dp	$50
	spc_mov_dp_i	$40,$48
	spc_mov_dp_i	$41,$ee
	spc_set	0,$2c
spc_1315
	spc_cmp_dp_i	$01,$1d
	spc_bne	spc_1324
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$0d
	spc_bne	spc_1324
	spc_mov_dp_i	$01,$00
spc_1324
	spc_cmp_dp_i	$1b,$01
	spc_bne	spc_133a
	spc_mov_a_abs	$055f
	spc_beq	spc_133a
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$0d
	spc_beq	spc_133a
	spc_mov_a_i	$02
	spc_call	spc_dispatchsfx
spc_133a
	spc_mov_a_abs	$056a
	spc_cmp_a_i	$f0
	spc_bne	spc_1357
	spc_mov_a_abs	$055f
	spc_beq	spc_1357
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$0d
	spc_beq	spc_1357
	spc_cmp_dp_i	$1c,$05
	spc_bne	spc_1357
	spc_mov_a_i	$24
	spc_call	spc_dispatchsfx
spc_1357
	spc_cmp_dp_i	$1d,$39
	spc_bne	spc_1376
	spc_mov_dp_i	$2a,$00
	spc_set	3,$2d
	spc_set	6,$2d
	spc_mov_a_i	$01
	spc_mov_abs_a	$0579
	spc_mov_x_i	$07
	spc_call	spc_stopvoice
	spc_dec_x
	spc_call	spc_stopvoice
	spc_mov_x_i	$08
	spc_call	spc_stopchannel4
spc_1376
	spc_cmp_dp_i	$1d,$32
	spc_bne	spc_139c
	spc_set	5,$2d
	spc_mov_x_i	$04
	spc_call	spc_releasechannel
	spc_mov_a_i	$00
	spc_mov_dp_a	$2a
	spc_mov_dp_a	$1c
	spc_call	spc_stopmusic
	spc_set	3,$2d
	spc_set	6,$2d
	spc_mov_x_i	$02
	spc_call	spc_releasechannel
	spc_dec_x
	spc_call	spc_releasechannel
	spc_dec_x
	spc_call	spc_releasechannel
spc_139c
	spc_cmp_dp_i	$1d,$03
	spc_bne	spc_13b3
	spc_set	5,$2d
	spc_mov_x_i	$05
	spc_call	spc_releasechannel
	spc_dec_x
	spc_call	spc_releasechannel
	spc_set	3,$2d
	spc_mov_dp_i	$2a,$00
	spc_set	6,$2d
spc_13b3
	spc_mov_a_abs	$0579
	spc_beq	spc_13ca
	spc_inc_abs	$0579
	spc_mov_a_abs	$0579
	spc_setc
	spc_sbc_a_i	$78
	spc_bmi	spc_13ca
	spc_set	5,$2d
	spc_mov_a_i	$00
	spc_mov_abs_a	$0579
spc_13ca
	spc_mov_a_abs	$0395
	spc_cmp_a_i	$17
	spc_beq	spc_13d7
	spc_cmp_a_i	$21
	spc_beq	spc_13d7
	spc_bra	spc_13e6
spc_13d7
	spc_cmp_dp_i	$01,$09
	spc_beq	spc_13e3
	spc_cmp_dp_i	$01,$0d
	spc_beq	spc_13e3
	spc_bra	spc_13e6
spc_13e3
	spc_mov_dp_i	$01,$00
spc_13e6
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$32
	spc_bne	spc_13f9
	spc_mov_a_abs	$0394
	spc_cmp_a_i	$38
	spc_bne	spc_13f9
	spc_mov_x_i	$04
	spc_call	spc_releasechannel
spc_13f9
	spc_ret
spc_13fa
	spc_cmp_dp_i	$1d,$4c
	spc_bne	spc_1423
	spc_mov_x_i	$07
	spc_call	spc_stopvoice
	spc_dec_x
	spc_call	spc_stopvoice
	spc_dec_x
	spc_call	spc_releasechannel
	spc_dec_x
	spc_call	spc_releasechannel
	spc_dec_x
	spc_call	spc_releasechannel
	spc_mov_a_i	$01
	spc_mov_abs_a	$0579
	spc_set	3,$2d
	spc_mov_dp_i	$2a,$00
	spc_call	spc_stopmusic
	spc_set	6,$2d
spc_1423
	spc_ret
spc_dispatchsfx
	spc_push_x
	spc_push_a
	spc_mov_x_i	$00
spc_1428
	spc_mov_a_abs_x	$0588
	spc_beq	spc_1430
	spc_inc_x
	spc_bra	spc_1428
spc_1430
	spc_pop_a
	spc_mov_abs_x_a	$0588
	spc_pop_x
spc_1435
	spc_ret
spc_1436
	spc_bbs	0,$29,spc_1435
	spc_cmp_dp_i	$1d,$3e
	spc_bne	spc_1443
	spc_mov_a_i	$01
	spc_mov_abs_a	$0568
spc_1443
	spc_mov_a_abs	$0568
	spc_beq	spc_144b
	spc_inc_abs	$0568
spc_144b
	spc_mov_a_abs	$0568
	spc_cmp_a_i	$2a
	spc_bne	spc_1475
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$01
	spc_beq	spc_146b
	spc_cmp_a_i	$04
	spc_beq	spc_1467
	spc_cmp_a_i	$07
	spc_beq	spc_146b
	spc_cmp_a_i	$0a
	spc_beq	spc_1467
	spc_bra	spc_1470
spc_1467
	spc_mov_a_i	$0f
	spc_bra	spc_146d
spc_146b
	spc_mov_a_i	$2f
spc_146d
	spc_call	spc_dispatchsfx
spc_1470
	spc_mov_a_i	$00
	spc_mov_abs_a	$0568
spc_1475
	spc_cmp_dp_i	$1d,$20
	spc_beq	spc_1481
	spc_cmp_dp_i	$1d,$16
	spc_beq	spc_1485
	spc_bra	spc_14a3
spc_1481
	spc_set	4,$2c
	spc_bra	spc_1487
spc_1485
	spc_set	5,$2c
spc_1487
	spc_mov_a_abs	$0397
	spc_cmp_a_i	$01
	spc_beq	spc_149b
	spc_cmp_a_i	$04
	spc_beq	spc_1496
	spc_cmp_a_i	$07
	spc_beq	spc_149b
spc_1496
	spc_mov_dp_i	$1d,$1b
	spc_bra	spc_149e
spc_149b
	spc_mov_dp_i	$1d,$27
spc_149e
	spc_mov_a_i	$01
	spc_mov_abs_a	$055d
spc_14a3
	spc_mov_a_abs	$055d
	spc_beq	spc_14ab
	spc_inc_abs	$055d
spc_14ab
	spc_mov_a_abs	$055d
	spc_cmp_a_i	$11
	spc_bne	spc_14cf
	spc_mov_a_i	$00
	spc_mov_abs_a	$055d
	spc_bbs	4,$2c,spc_14bf
	spc_bbs	5,$2c,spc_14c8
	spc_bra	spc_14cf
spc_14bf
	spc_clr	4,$2c
	spc_mov_a_i	$20
	spc_call	spc_dispatchsfx
	spc_bra	spc_14cf
spc_14c8
	spc_clr	5,$2c
	spc_mov_a_i	$16
	spc_call	spc_dispatchsfx
spc_14cf
	spc_cmp_dp_i	$1d,$37
	spc_bne	spc_14d7
	spc_inc_abs	$0580
spc_14d7
	spc_cmp_dp_i	$1d,$30
	spc_bne	spc_14ed
	spc_mov_a_abs	$0580
	spc_cmp_a_i	$0a
	spc_bne	spc_14e8
	spc_mov_a_i	$43
	spc_call	spc_dispatchsfx
spc_14e8
	spc_mov_a_i	$00
	spc_mov_abs_a	$0580
spc_14ed
	spc_mov_a_abs	$0560
	spc_bne	spc_150a
	spc_mov_a_dp	$1d
	spc_cmp_a_i	$29
	spc_beq	spc_14fa
	spc_bra	spc_1522
spc_14fa
	spc_mov_a_i	$01
	spc_mov_abs_a	$0560
	spc_mov_a_dp	$18
	spc_and_a_i	$3f
	spc_adc_a_i	$1e
	spc_mov_abs_a	$0561
	spc_bra	spc_1522
spc_150a
	spc_inc_abs	$0560
	spc_cmp_a_abs	$0561
	spc_bne	spc_1522
	spc_mov_a_i	$29
	spc_call	spc_dispatchsfx
	spc_mov_dp_i	$1d,$29
	spc_mov_a_i	$00
	spc_mov_abs_a	$0560
	spc_mov_abs_a	$0561
spc_1522
	spc_ret
spc_1523
	spc_call	spc_15a1
	spc_bbs	2,$2c,spc_152d
	spc_bbs	3,$2c,spc_1538
spc_152c
	spc_ret
spc_152d
	spc_mov_a_abs	$0555
	spc_beq	spc_1554
	spc_cmp_a_i	$fe
	spc_beq	spc_152c
	spc_bra	spc_156c
spc_1538
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
	spc_bra	spc_159e
spc_1554
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
spc_156c
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
spc_159e
	spc_mov_dp_a	$53
	spc_ret
spc_15a1
	spc_mov_a_dp	$1d
	spc_cmp_a_i	$2c
	spc_beq	spc_15b5
	spc_mov_x_abs	$0555
	spc_beq	spc_15be
	spc_cmp_a_i	$30
	spc_beq	spc_15bf
	spc_cmp_a_i	$3c
	spc_beq	spc_15bf
	spc_ret
spc_15b5
	spc_cmp_dp_i	$1c,$01
	spc_bne	spc_15be
	spc_set	2,$2c
	spc_clr	3,$2c
spc_15be
	spc_ret
spc_15bf
	spc_clr	2,$2c
	spc_set	3,$2c
	spc_ret
spc_15c4
	spc_bbs	0,$29,spc_15e3
	spc_mov_a_abs	$0550
	spc_bne	spc_1618
	spc_mov_a_abs	$0551
	spc_cmp_a_i	$01
	spc_beq	spc_15e4
	spc_cmp_a_i	$03
	spc_beq	spc_15fe
	spc_bbs	0,$28,spc_15de
	spc_bbs	1,$28,spc_15de
	spc_ret
spc_15de
	spc_mov_a_i	$01
	spc_mov_abs_a	$0551
spc_15e3
	spc_ret
spc_15e4
	spc_mov_a_dp	$4a
	spc_mov_abs_a	$0570
	spc_mov_a_dp	$4e
	spc_mov_abs_a	$0571
	spc_mov_a_dp	$61
	spc_mov_abs_a	$0572
	spc_mov_a_dp	$63
	spc_mov_abs_a	$0573
	spc_mov_a_i	$01
	spc_mov_abs_a	$0550
	spc_ret
spc_15fe
	spc_mov_a_abs	$0570
	spc_mov_dp_a	$4a
	spc_mov_a_abs	$0571
	spc_mov_dp_a	$4e
	spc_mov_a_abs	$0572
	spc_mov_dp_a	$61
	spc_mov_a_abs	$0573
	spc_mov_dp_a	$63
	spc_mov_a_i	$00
	spc_mov_abs_a	$0551
	spc_ret
spc_1618
	spc_mov_dp_i	$4a,$00
	spc_set	7,$4a
	spc_set	6,$4a
	spc_call	spc_1624
	spc_bra	spc_167c
spc_1624
	spc_mov_a_abs	$0551
	spc_cmp_a_i	$01
	spc_beq	spc_163e
	spc_cmp_a_i	$02
	spc_beq	spc_1656
	spc_dec_abs	$0550
	spc_mov_a_abs	$0550
	spc_cmp_a_i	$3c
	spc_beq	spc_163a
	spc_ret
spc_163a
	spc_bbs	1,$28,spc_1650
	spc_ret
spc_163e
	spc_inc_abs	$0550
	spc_mov_a_abs	$0550
	spc_cmp_a_i	$1e
	spc_beq	spc_164d
	spc_cmp_a_i	$3c
	spc_beq	spc_1650
	spc_ret
spc_164d
	spc_bbs	0,$28,spc_1655
spc_1650
	spc_mov_a_i	$02
	spc_mov_abs_a	$0551
spc_1655
	spc_ret
spc_1656
	spc_bbs	0,$28,spc_1662
	spc_bbs	1,$28,spc_166f
	spc_mov_a_i	$03
	spc_mov_abs_a	$0551
	spc_ret
spc_1662
	spc_mov_a_abs	$0550
	spc_cmp_a_i	$3c
	spc_beq	spc_1655
	spc_mov_a_i	$01
	spc_mov_abs_a	$0551
	spc_ret
spc_166f
	spc_mov_a_abs	$0550
	spc_cmp_a_i	$1e
	spc_beq	spc_1655
	spc_mov_a_i	$03
	spc_mov_abs_a	$0551
	spc_ret
spc_167c
	spc_mov_a_abs	$0550
	spc_mov_y_i	$b0
	spc_mul_ya
	spc_mov_a_y
	spc_eor_a_i	$ff
	spc_mov_abs_a	$0552
	spc_mov_a_i	$64
	spc_setc
	spc_sbc_a_abs	$0571
	spc_mov_y_abs	$0550
	spc_mul_ya
	spc_mov_x_i	$3c
	spc_div_ya_x
	spc_clrc
	spc_adc_a_abs	$0571
	spc_mov_dp_a	$4e
	spc_mov_a_i	$64
	spc_setc
	spc_sbc_a_abs	$0572
	spc_mov_y_abs	$0550
	spc_mul_ya
	spc_mov_x_i	$3c
	spc_div_ya_x
	spc_clrc
	spc_adc_a_abs	$0572
	spc_mov_dp_a	$61
	spc_mov_dp_a	$63
	spc_ret
spc_16b1
	spc_cmp_dp_i	$1c,$01
	spc_beq	spc_16c0
	spc_mov_a_dp	$01
	spc_setc
	spc_sbc_a_i	$07
	spc_bmi	spc_16c0
	spc_mov_dp_i	$01,$00
spc_16c0
	spc_ret
spc_16c1
	spc_cmp_dp_i	$1c,$01
	spc_beq	spc_16d7
	spc_mov_x_i	$00
spc_16c8
	spc_mov_a_abs_x	$16d8
	spc_beq	spc_16d4
	spc_cmp_a_dp	$1d
	spc_beq	spc_16d7
	spc_inc_x
	spc_bra	spc_16c8
spc_16d4
	spc_mov_dp_i	$1d,$00
spc_16d7
	spc_ret

; Effect IDs accepted when music state is not 1; zero terminates the list.
spc_effectallowlist
	db	$03,$58,$32,$35,$2b,$34,$43,$44,$45,$01,$04,$07
	db	$0a,$0d,$23,$3a,$3b,$3f,$06,$22,$41,$40,$1f,$2a
	db	$00
spc_16f1
	spc_bbc	2,$28,spc_16f7
	spc_call	spc_nearrampup
spc_16f7
	spc_bbc	3,$28,spc_16fd
	spc_call	spc_nearrampdown
spc_16fd
	spc_ret

; Nearby transition accumulates $0020 per step, up to twenty steps.
spc_nearrampup
	spc_mov_a_abs	$0547
	spc_cmp_a_i	$14
	spc_beq	spc_171e
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
spc_171e
	spc_ret
spc_nearrampdown
	spc_mov_a_abs	$0547
	spc_cmp_a_i	$00
	spc_beq	spc_173e
	spc_dec_abs	$0547
	spc_mov_a_abs	$054d
	spc_mov_y_abs	$054f
	spc_mov_dp_i	$20,$20
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$054d
	spc_mov_abs_y	$054f
	spc_ret
spc_173e
	spc_clr	2,$28
	spc_clr	3,$28
	spc_mov_a_i	$00
	spc_mov_abs_a	$054d
	spc_mov_abs_a	$054f
	spc_ret
spc_174b
	spc_bbc	2,$29,spc_1751
	spc_call	spc_enginerampup
spc_1751
	spc_bbc	3,$29,spc_1757
	spc_call	spc_enginerampdown
spc_1757
	spc_ret

; Engine transition accumulates $003c per step, up to twenty-five steps.
spc_enginerampup
	spc_mov_a_abs	$0543
	spc_cmp_a_i	$19
	spc_beq	spc_1778
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
spc_1778
	spc_ret
spc_enginerampdown
	spc_mov_a_abs	$0543
	spc_cmp_a_i	$00
	spc_beq	spc_resetpause
	spc_dec_abs	$0543
	spc_mov_a_abs	$0549
	spc_mov_y_abs	$054b
	spc_mov_dp_i	$20,$3c
	spc_mov_dp_i	$21,$00
	spc_subw_ya_dp	$20
	spc_mov_abs_a	$0549
	spc_mov_abs_y	$054b
	spc_ret
spc_resetpause
	spc_clr	2,$29
	spc_clr	3,$29
	spc_mov_a_i	$00
	spc_mov_abs_a	$0549
	spc_mov_abs_a	$054b
	spc_ret
	spc_endblock	$0676

	spc_block	spc_voiceblock,$1b23,$0bd9
spc_1b23
	spc_mov_a_dp	$20
	spc_setc
	spc_sbc_a_i	$2a
	spc_mov_abs_a	$0562
	spc_ret
spc_1b2c
	spc_mov_a_dp	$1d
	spc_beq	spc_1b76
	spc_mov_y_i	$00
spc_1b32
	spc_mov_a_abs_y	$26d6
	spc_beq	spc_1b3e
	spc_cmp_a_dp	$1d
	spc_beq	spc_1b79
	spc_inc_y
	spc_bra	spc_1b32
spc_1b3e
	spc_mov_y_i	$00
spc_1b40
	spc_mov_a_abs_y	$26e4
	spc_beq	spc_1b79
	spc_push_a
	spc_mov_a_dp	$1d
	spc_push_y
	spc_call	spc_readscriptheader
	spc_call	spc_scriptchannel
	spc_pop_y
	spc_pop_a
	spc_cmp_a_abs_x	$0390
	spc_beq	spc_1b59
spc_1b56
	spc_inc_y
	spc_bra	spc_1b40
spc_1b59
	spc_mov_x_i	$00
spc_1b5b
	spc_mov_a_abs_x	$26e4
	spc_beq	spc_1b6f
	spc_cmp_a_dp	$1d
	spc_beq	spc_1b67
	spc_inc_x
	spc_bra	spc_1b5b
spc_1b67
	spc_mov_dp_xreg	$20
	spc_mov_a_y
	spc_setc
	spc_sbc_a_dp	$20
	spc_bpl	spc_1b56
spc_1b6f
	spc_mov_dp_dp	$1f,$1d
	spc_mov_dp_i	$1d,$00
	spc_ret
spc_1b76
	spc_mov_dp_i	$1f,$00
spc_1b79
	spc_ret
spc_1b7a
	spc_mov_x_i	$00
spc_1b7c
	spc_mov_a_abs_x	$1b8c
	spc_beq	spc_1b8b
	spc_cmp_a_dp	$1d
	spc_beq	spc_1b88
	spc_inc_x
	spc_bra	spc_1b7c
spc_1b88
	spc_mov_dp_i	$1d,$00
spc_1b8b
	spc_ret
spc_suppressedeffects
	db	$02,$25,$15,$17,$21,$00
spc_1b92
	spc_mov_x_i	$00
spc_1b94
	spc_mov_a_abs_x	$0468
	spc_beq	spc_1b9d
	spc_inc_a
	spc_mov_abs_x_a	$0468
spc_1b9d
	spc_inc_x
	spc_cmp_x_i	$08
	spc_bne	spc_1b94
	spc_mov_a_dp	$1d
	spc_beq	spc_1bd3
	spc_call	spc_effectpointer
	spc_mov_y_i	$00
	spc_mov_a_dpi_y	$24
	spc_and_a_i	$07
	spc_mov_x_a
	spc_mov_dp_dp	$26,$1d
	spc_mov_a_abs_x	$0470
	spc_beq	spc_1bbb
	spc_mov_dp_i	$1d,$00
spc_1bbb
	spc_mov_y_i	$00
spc_1bbd
	spc_mov_a_abs_y	$1c04
	spc_beq	spc_1bd2
	spc_cmp_a_dp	$26
	spc_beq	spc_1bca
	spc_inc_y
	spc_inc_y
	spc_bra	spc_1bbd
spc_1bca
	spc_mov_abs_x_a	$0470
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$0468
spc_1bd2
	spc_ret
spc_1bd3
	spc_mov_y_i	$00
spc_1bd5
	spc_mov_a_abs_y	$0470
	spc_bne	spc_1be0
spc_1bda
	spc_inc_y
	spc_cmp_y_i	$08
	spc_bne	spc_1bd5
	spc_ret
spc_1be0
	spc_mov_dp_a	$26
	spc_mov_x_i	$00
spc_1be4
	spc_mov_a_abs_x	$1c04
	spc_beq	spc_1bda
	spc_cmp_a_dp	$26
	spc_beq	spc_1bf1
	spc_inc_x
	spc_inc_x
	spc_bra	spc_1be4
spc_1bf1
	spc_inc_x
	spc_mov_a_abs_x	$1c04
	spc_cmp_a_abs_y	$0468
	spc_bne	spc_1bda
	spc_mov_a_i	$00
	spc_mov_abs_y_a	$0468
	spc_mov_abs_y_a	$0470
	spc_bra	spc_1bda
spc_effectcooldowns
	db	$1e,$09,$00
spc_1c07
	spc_mov_a_dp	$1d
	spc_call	spc_dispatchsfx
	spc_mov_dp_i	$1d,$00
	spc_cmp_dp_i	$1d,$00
	spc_beq	spc_1c1b
	spc_mov_a_i	$00
	spc_mov_abs_a	$057b
	spc_bra	spc_1c25
spc_1c1b
	spc_mov_a_abs	$057b
	spc_cmp_a_i	$ff
	spc_beq	spc_1c25
	spc_inc_abs	$057b
spc_1c25
	spc_cmp_dp_i	$1d,$00
	spc_bne	spc_1c54
	spc_mov_a_abs	$057b
	spc_beq	spc_1c54
	spc_cmp_a_i	$01
	spc_beq	spc_1c54
	spc_cmp_a_i	$02
	spc_beq	spc_1c54
	spc_mov_a_abs	$0588
	spc_beq	spc_1c54
	spc_push_a
	spc_mov_x_i	$01
spc_1c3f
	spc_mov_a_abs_x	$0588
	spc_dec_x
	spc_mov_abs_x_a	$0588
	spc_inc_x
	spc_inc_x
	spc_cmp_x_i	$08
	spc_bne	spc_1c3f
	spc_pop_a
	spc_mov_x_i	$00
	spc_mov_abs_x	$057b
	spc_bra	spc_1c63
spc_1c54
	spc_mov_a_dp	$1d
	spc_cmp_a_dp	$1e
	spc_bne	spc_1c5d
spc_1c5a
	spc_jmp	spc_tickvoices
spc_1c5d
	spc_mov_dp_a	$1e
	spc_mov_a_dp	$1d
	spc_beq	spc_1c5a
spc_1c63
	spc_mov_dp_a	$23
	spc_call	spc_readscriptheader
	spc_call	spc_scriptchannel
	spc_call	spc_voicegate
	spc_call	spc_activatevoice
	spc_call	spc_1ced
	spc_mov_a_dp	$23
	spc_mov_abs_x_a	$0410
	spc_push_x
	spc_call	spc_tickvoices
	spc_pop_x
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0410
	spc_ret
spc_activatevoice
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$0408
	spc_ret

; Effect ID selects the script pointer; the first byte carries channel flags.
spc_readscriptheader
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

; Retain the complete script header, then select its low-nibble channel.
spc_scriptchannel
	spc_mov_dp_xreg	$26
	spc_mov_a_xreg
	spc_and_a_i	$0f
	spc_mov_x_a
	spc_ret
spc_voicegate
	spc_bbc	7,$26,spc_1cba
	spc_bbc	5,$26,spc_1cb4
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$04f8
	spc_mov_a_i	$02
	spc_bra	spc_1cb6
spc_1cb4
	spc_mov_a_i	$01
spc_1cb6
	spc_mov_abs_x_a	$0480
	spc_ret
spc_1cba
	spc_mov_a_abs_x	$0480
	spc_cmp_a_i	$01
	spc_bne	spc_1ccc
	spc_mov_a_abs_x	$04f8
	spc_bne	spc_1ccc
	spc_mov_a_abs_x	$0390
	spc_mov_abs_x_a	$04f8
spc_1ccc
	spc_ret
spc_tickvoices
	spc_mov_x_i	$00
spc_1ccf
	spc_mov_a_abs_x	$0408
	spc_beq	spc_1cda
	spc_call	spc_1ce2
	spc_call	spc_1cf8
spc_1cda
	spc_inc_x
	spc_cmp_x_i	$08
	spc_beq	spc_1ce1
	spc_bra	spc_1ccf
spc_1ce1
	spc_ret
spc_1ce2
	spc_mov_a_abs_x	$0488
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0490
	spc_mov_dp_a	$21
	spc_ret
spc_1ced
	spc_mov_a_dp	$20
	spc_mov_abs_x_a	$0488
	spc_mov_a_dp	$21
	spc_mov_abs_x_a	$0490
	spc_ret
spc_1cf8
	spc_mov_a_abs_x	$03f8
	spc_beq	spc_1d50
	spc_cmp_a_i	$01
	spc_beq	spc_1d1c
	spc_cmp_a_i	$02
	spc_beq	spc_1d31
	spc_cmp_a_i	$03
	spc_beq	spc_1d36
	spc_mov_a_abs_x	$0410
	spc_bne	spc_1d53
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0390
	spc_mov_abs_x_a	$03f8
	spc_mov_abs_x_a	$0408
	spc_jmp	spc_1e31
spc_1d1c
	spc_mov_a_abs_x	$0410
	spc_bne	spc_1d53
	spc_mov_a_i	$02
	spc_mov_abs_x_a	$03f8
	spc_call	spc_1e89
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e8
spc_1d2e
	spc_jmp	spc_1e9d
spc_1d31
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e8
spc_1d36
	spc_mov_a_abs_x	$0410
	spc_bne	spc_1d53
	spc_mov_a_i	$03
	spc_mov_abs_x_a	$03f8
	spc_mov_a_abs_x	$03e8
	spc_beq	spc_1d6c
	spc_cmp_a_i	$01
	spc_beq	spc_1d1c
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03f0
	spc_bra	spc_1d1c
spc_1d50
	spc_mov_a_abs_x	$0410
spc_1d53
	spc_mov_abs_x_a	$0390
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$03f8
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03f0
	spc_mov_abs_x_a	$03e0
spc_1d63
	spc_call	spc_1e0f
	spc_jmp	spc_1e93
spc_1d69
	spc_jmp	spc_1de8
spc_1d6c
	spc_mov_a_abs_x	$03e0
	spc_beq	spc_1d2e
	spc_cmp_a_i	$01
	spc_beq	spc_1d69
	spc_cmp_a_i	$07
	spc_beq	spc_1dce
	spc_cmp_a_i	$08
	spc_beq	spc_1d94
	spc_cmp_a_i	$0a
	spc_beq	spc_1d9d
	spc_cmp_a_i	$0b
	spc_beq	spc_1da6
	spc_cmp_a_i	$0c
	spc_beq	spc_1daf
	spc_cmp_a_i	$0e
	spc_beq	spc_1db8
spc_1d8d
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e0
	spc_bra	spc_1d2e
spc_1d94
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$02
	spc_beq	spc_1dce
	spc_bra	spc_1d8d
spc_1d9d
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$25
	spc_beq	spc_1dce
	spc_bra	spc_1d8d
spc_1da6
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$15
	spc_beq	spc_1dce
	spc_bra	spc_1d8d
spc_1daf
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$17
	spc_beq	spc_1dce
	spc_bra	spc_1d8d
spc_1db8
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$21
	spc_beq	spc_1dce
	spc_bra	spc_1d8d
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$05
	spc_beq	spc_1de8
	spc_cmp_a_i	$08
	spc_beq	spc_1de8
	spc_bra	spc_1d8d
spc_1dce
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e0
	spc_mov_a_abs_x	$04f8
	spc_beq	spc_1de0
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$04f8
	spc_jmp	spc_1d2e
spc_1de0
	spc_mov_a_abs_x	$0480
	spc_bne	spc_1df5
	spc_jmp	spc_1d2e
spc_1de8
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03e0
	spc_mov_a_abs_x	$04f8
	spc_beq	spc_1df5
	spc_call	spc_dispatchsfx
spc_1df5
	spc_mov_a_i	$04
	spc_mov_abs_x_a	$03f8
	spc_call	spc_1e93
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0480
	spc_mov_abs_x_a	$04f8
	spc_mov_abs_x_a	$03f0
	spc_mov_abs_x_a	$03c8
	spc_mov_abs_x_a	$04f0
	spc_ret
spc_1e0f
	spc_call	spc_1e19
	spc_mov_a_dp	$1a
	spc_or_a_dp	$22
	spc_mov_dp_a	$1a
	spc_ret
spc_1e19
	spc_mov_dp_xreg	$22
	spc_inc_dp	$22
	spc_mov_a_i	$00
	spc_setc
spc_1e20
	spc_rol_a
	spc_dec_dp	$22
	spc_bne	spc_1e20
	spc_mov_dp_a	$22
	spc_ret
spc_1e28
	spc_mov_dp_xreg	$22
	spc_inc_dp	$22
	spc_mov_a_i	$ff
	spc_clrc
	spc_bra	spc_1e20
spc_1e31
	spc_call	spc_1e28
	spc_mov_a_dp	$1a
	spc_and_a_dp	$22
	spc_mov_dp_a	$1a
	spc_push_x
	spc_clrc
	spc_mov_a_xreg
	spc_asl_a
	spc_mov_x_a
	spc_mov_a_abs_x	$0211
	spc_call	spc_0bc1
	spc_pop_x
	spc_mov_dp_xreg	$20
	spc_inc_dp	$20
	spc_mov_a_dp	$4f
spc_1e4c
	spc_lsr_a
	spc_dec_dp	$20
	spc_bne	spc_1e4c
	spc_bcc	spc_1e5e
	spc_call	spc_1e19
	spc_mov_a_dp	$4a
	spc_or_a_dp	$22
	spc_mov_dp_a	$4a
	spc_bra	spc_1e67
spc_1e5e
	spc_call	spc_1e28
	spc_mov_a_dp	$4a
	spc_and_a_dp	$22
	spc_mov_dp_a	$4a
spc_1e67
	spc_call	spc_1e28
	spc_mov_a_dp	$1a
	spc_and_a_dp	$22
	spc_mov_dp_a	$1a
	spc_call	spc_1e19
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
	spc_call	spc_0e97
	spc_pop_x
	spc_ret
spc_1e89
	spc_call	spc_1e19
	spc_mov_a_dp	$45
	spc_or_a_dp	$22
	spc_mov_dp_a	$45
	spc_ret
spc_1e93
	spc_call	spc_1e19
	spc_mov_a_dp	$46
	spc_or_a_dp	$22
	spc_mov_dp_a	$46
	spc_ret
spc_1e9d
	spc_call	spc_1ea6
	spc_call	spc_variantlookup
	spc_jmp	spc_22d3
spc_1ea6
	spc_mov_a_abs_x	$0390
	spc_beq	spc_1ec9
	spc_mov_a_abs_x	$0448
	spc_beq	spc_1ebc
	spc_mov_a_abs_x	$03f0
	spc_setc
	spc_sbc_a_abs_x	$0448
	spc_bmi	spc_1ebc
	spc_call	spc_releasechannel
spc_1ebc
	spc_mov_a_abs_x	$03f0
	spc_cmp_a_i	$ff
	spc_beq	spc_1ec7
	spc_inc_a
	spc_mov_abs_x_a	$03f0
spc_1ec7
	spc_bra	spc_1ecf
spc_1ec9
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03f0
	spc_ret
spc_1ecf
	spc_call	spc_1ce2
	spc_mov_a_abs_x	$03f0
	spc_beq	spc_1edd
	spc_cmp_a_i	$01
	spc_beq	spc_1ede
	spc_bra	spc_1f30
spc_1edd
	spc_ret
spc_1ede
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0400
	spc_mov_abs_x_a	$0438
	spc_mov_abs_x_a	$0520
	spc_mov_abs_x_a	$0478
	spc_mov_abs_x_a	$0448
	spc_mov_abs_x_a	$0440
	spc_mov_abs_x_a	$03a8
	spc_mov_abs_x_a	$03b0
	spc_mov_abs_x_a	$04c0
	spc_mov_abs_x_a	$04c8
	spc_mov_abs_x_a	$04f0
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$04a8
	spc_mov_abs_x_a	$03a0
	spc_mov_abs_x_a	$04b0
	spc_mov_abs_x_a	$03b8
	spc_mov_abs_x_a	$0498
	spc_mov_abs_x_a	$03c0
	spc_mov_abs_x_a	$04a0
	spc_mov_a_i	$8f
	spc_mov_abs_x_a	$03d0
	spc_mov_a_i	$e0
	spc_mov_abs_x_a	$03d8
	spc_call	spc_1e28
	spc_mov_a_dp	$4a
	spc_and_a_dp	$22
	spc_mov_dp_a	$4a
	spc_mov_y_i	$01
	spc_bra	spc_1f48
spc_1f30
	spc_mov_a_abs_x	$0418
	spc_dec_a
	spc_mov_abs_x_a	$0418
	spc_beq	spc_scriptnext
	spc_cmp_a_i	$ff
	spc_beq	spc_scriptnext
	spc_call	spc_224a
	spc_jmp	spc_2286

; Skip zero script bytes; E0-FF dispatch through the word table.
spc_scriptnext
	spc_mov_a_abs_x	$0400
	spc_mov_y_a
spc_1f47
	spc_inc_y
spc_1f48
	spc_mov_a_dpi_y	$20
	spc_beq	spc_1f47
	spc_bpl	spc_1f9b
	spc_setc
	spc_sbc_a_i	$e0
	spc_bmi	spc_1fcc
	spc_asl_a
	spc_push_x
	spc_mov_x_a
	spc_jmp_abs_x	spc_voicecommands

; Thirty-two script-command handler PCs. Aliases and unused entries retained.
spc_voicecommands
	dw	spc_21c8,spc_2053,spc_2057,spc_205f,spc_20a0,spc_20eb
	dw	spc_20fa,spc_2114,spc_2128,spc_213c,spc_2150,spc_215f
	dw	spc_216b,spc_21d2,spc_21f3,spc_unusedvoicecommand,spc_unusedvoicecommand,spc_21fc
	dw	spc_2204,spc_220c,spc_unusedvoicecommand,spc_unusedvoicecommand,spc_unusedvoicecommand,spc_unusedvoicecommand
	dw	spc_221e,spc_unusedvoicecommand,spc_unusedvoicecommand,spc_2227,spc_2232,spc_223b
	dw	spc_209e,spc_unusedvoicecommand
spc_unusedvoicecommand
	spc_pop_x
	spc_ret
spc_1f9b
	spc_push_a
	spc_mov_a_abs_x	$0478
	spc_beq	spc_1fa7
	spc_cmp_a_i	$01
	spc_beq	spc_1faa
	spc_bra	spc_1faf
spc_1fa7
	spc_call	spc_1e93
spc_1faa
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$03e8
spc_1faf
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0478
	spc_pop_a
	spc_mov_abs_x_a	$0418
	spc_cmp_a_i	$7f
	spc_bne	spc_1fc0
	spc_mov_a_i	$01
	spc_bra	spc_1fc2
spc_1fc0
	spc_mov_a_i	$00
spc_1fc2
	spc_mov_abs_x_a	$0420
	spc_mov_a_y
	spc_mov_abs_x_a	$0400
	spc_jmp	spc_1ced
spc_1fcc
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
	spc_mov_a_abs_x	spc_effectpitches
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	spc_effectpitches+1
	spc_mov_dp_a	$23
	spc_pop_a
	spc_setc
	spc_sbc_a_i	$07
	spc_mov_dp_a	$24
	spc_beq	spc_1ffe
spc_1fec
	spc_mov_y_i	$00
	spc_mov_a_dp	$23
	spc_mov_x_i	$02
	spc_div_ya_x
	spc_mov_dp_a	$23
	spc_mov_a_dp	$22
	spc_div_ya_x
	spc_mov_dp_a	$22
	spc_inc_dp	$24
	spc_bne	spc_1fec
spc_1ffe
	spc_pop_x
	spc_mov_a_dp	$22
	spc_mov_abs_x_a	$03b8
	spc_mov_abs_x_a	$0498
	spc_mov_a_dp	$23
	spc_mov_abs_x_a	$03c0
	spc_mov_abs_x_a	$04a0
	spc_mov_a_abs_x	$0440
	spc_beq	spc_204f
	spc_push_x
	spc_mov_dp_a	$24
	spc_mov_a_dp	$23
	spc_setc
	spc_sbc_a_i	$10
	spc_bmi	spc_2030
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
	spc_bra	spc_2045
spc_2030
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
spc_2045
	spc_addw_ya_dp	$22
	spc_pop_x
	spc_mov_abs_x_a	$03b8
	spc_mov_a_y
	spc_mov_abs_x_a	$03c0
spc_204f
	spc_pop_y
spc_2050
	spc_jmp	spc_1f47
spc_2053
	spc_mov_a_i	$01
	spc_bra	spc_2059
spc_2057
	spc_mov_a_i	$02
spc_2059
	spc_pop_x
	spc_mov_abs_x_a	$0478
spc_205d
	spc_bra	spc_2050
spc_205f
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$03c8
	spc_bra	spc_205d
spc_2068
	spc_push_x
	spc_push_y
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$04f0
	spc_cmp_a_i	$04
	spc_bne	spc_209a
	spc_mov_a_dp	$03
	spc_bne	spc_2078
	spc_inc_a
spc_2078
	spc_mov_y_i	$03
	spc_mul_ya
	spc_mov_x_i	$02
	spc_call	spc_ca89
	spc_mov_dp_a	$24
	spc_mov_dp_y	$25
	spc_mov_a_i	$80
	spc_mov_y_i	$00
	spc_addw_ya_dp	$24
	spc_push_y
	spc_pop_x
	spc_mov_y_a
	spc_mov_a_dp	$22
	spc_call	spc_ca75
	spc_mov_a_y
	spc_bpl	spc_2097
	spc_mov_a_i	$7f
spc_2097
	spc_pop_y
	spc_pop_x
	spc_ret
spc_209a
	spc_mov_a_dp	$22
	spc_bra	spc_2097
spc_209e
	spc_set	6,$2c
spc_20a0
	spc_pop_x
	spc_inc_y
	spc_mov_a_abs_x	$04f0
	spc_cmp_a_i	$01
	spc_beq	spc_20ad
	spc_cmp_a_i	$02
	spc_beq	spc_20ca
spc_20ad
	spc_mov_a_dpi_y	$20
	spc_call	spc_2068
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$04a8
	spc_bbs	6,$2c,spc_20bc
	spc_inc_y
spc_20bc
	spc_mov_a_dpi_y	$20
	spc_call	spc_2068
	spc_mov_abs_x_a	$03a0
	spc_mov_abs_x_a	$04b0
	spc_jmp	spc_20de
spc_20ca
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$04a8
	spc_bbs	6,$2c,spc_20d6
	spc_inc_y
spc_20d6
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$03a0
	spc_mov_abs_x_a	$04b0
spc_20de
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$03a8
	spc_mov_abs_x_a	$03b0
	spc_clr	6,$2c
spc_20e8
	spc_jmp	spc_1f47
spc_20eb
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$0f
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$03d0
	spc_and_a_i	$f0
	spc_bra	spc_210b
spc_20fa
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
spc_210b
	spc_or_a_dp	$22
	spc_or_a_i	$80
	spc_mov_abs_x_a	$03d0
spc_2112
	spc_bra	spc_20e8
spc_2114
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
	spc_bra	spc_2135
spc_2128
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$1f
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$03d8
	spc_and_a_i	$e0
spc_2135
	spc_or_a_dp	$22
	spc_mov_abs_x_a	$03d8
spc_213a
	spc_bra	spc_2112
spc_213c
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0428
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0430
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$0438
spc_214e
	spc_bra	spc_213a
spc_2150
	spc_pop_x
	spc_bbs	0,$28,spc_2169
	spc_call	spc_1e19
	spc_mov_a_dp	$4a
	spc_or_a_dp	$22
	spc_mov_dp_a	$4a
	spc_bra	spc_2169
spc_215f
	spc_pop_x
	spc_call	spc_1e28
	spc_mov_a_dp	$4a
	spc_and_a_dp	$22
	spc_mov_dp_a	$4a
spc_2169
	spc_bra	spc_214e
spc_216b
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_dp_a	$24
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_dp_a	$25
	spc_push_y
	spc_mov_x_i	$bc
spc_2178
	spc_mov_a_abs_x	$0702
	spc_cmp_a_dp	$24
	spc_beq	spc_2183
	spc_inc_x
	spc_inc_x
	spc_bra	spc_2178
spc_2183
	spc_inc_x
	spc_mov_a_abs_x	$0702
	spc_cmp_a_dp	$25
	spc_beq	spc_2192
	spc_inc_x
	spc_cmp_x_i	$00
	spc_beq	spc_2198
	spc_bra	spc_2178
spc_2192
	spc_mov_a_xreg
	spc_lsr_a
	spc_inc_a
	spc_call	spc_restoreeffect
spc_2198
	spc_pop_y
	spc_pop_x
	spc_bra	spc_2169
spc_restoreeffect
	spc_mov_dp_a	$23
	spc_push_a
	spc_mov_y_i	$00
	spc_mov_a_dpi_y	$24
	spc_mov_x_a
	spc_mov_a_abs_x	$04f0
	spc_cmp_a_i	$02
	spc_beq	spc_21c6
	spc_cmp_a_i	$03
	spc_beq	spc_21c6
	spc_call	spc_scriptchannel
	spc_call	spc_voicegate
	spc_mov_a_dp	$24
	spc_mov_abs_x_a	$0488
	spc_mov_a_dp	$25
	spc_mov_abs_x_a	$0490
	spc_call	spc_activatevoice
	spc_pop_a
	spc_jmp	spc_1d53
spc_21c6
	spc_pop_a
	spc_ret
spc_21c8
	spc_pop_x
	spc_mov_a_abs_x	$0420
	spc_bne	spc_21d1
	spc_call	spc_releasechannel
spc_21d1
	spc_ret
spc_21d2
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
spc_21f0
	spc_jmp	spc_1f47
spc_21f3
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0440
spc_21fa
	spc_bra	spc_21f0
spc_21fc
	spc_pop_x
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0438
spc_2202
	spc_bra	spc_21fa
spc_2204
	spc_pop_x
	spc_mov_a_i	$00
	spc_mov_abs_x_a	$0520
spc_220a
	spc_bra	spc_2202
spc_220c
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
	spc_jmp	spc_1f48
spc_221e
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$0448
spc_2225
	spc_bra	spc_220a
spc_2227
	spc_pop_x
	spc_call	spc_1e93
	spc_mov_a_i	$02
	spc_mov_abs_x_a	$0478
spc_2230
	spc_bra	spc_2225
spc_2232
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_mov_abs_x_a	$04f0
spc_2239
	spc_bra	spc_2230
spc_223b
	spc_pop_x
	spc_inc_y
	spc_mov_a_dpi_y	$20
	spc_and_a_i	$fe
	spc_push_y
	spc_push_x
	spc_call	spc_edf0
	spc_pop_x
	spc_pop_y
	spc_bra	spc_2239
spc_224a
	spc_mov_a_abs_x	$0438
	spc_beq	spc_227a
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
	spc_bmi	spc_227b
	spc_setc
	spc_sbc_a_i	$40
	spc_bpl	spc_2280
	spc_mov_a_abs_x	$0498
spc_2273
	spc_mov_abs_x_a	$03b8
	spc_mov_a_y
	spc_mov_abs_x_a	$03c0
spc_227a
	spc_ret
spc_227b
	spc_mov_a_i	$00
	spc_mov_y_a
	spc_bra	spc_2273
spc_2280
	spc_mov_a_i	$ff
	spc_mov_y_i	$3f
	spc_bra	spc_2273
spc_2286
	spc_mov_a_abs_x	$0520
	spc_beq	spc_22af
	spc_mov_a_abs_x	$0500
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0508
	spc_mov_dp_a	$21
	spc_call	spc_22b0
	spc_mov_a_abs_x	$0510
	spc_mov_dp_a	$20
	spc_mov_a_abs_x	$0518
	spc_mov_dp_a	$21
	spc_mov_a_xreg
	spc_clrc
	spc_adc_a_i	$08
	spc_mov_x_a
	spc_call	spc_22b0
	spc_mov_a_xreg
	spc_setc
	spc_sbc_a_i	$08
	spc_mov_x_a
spc_22af
	spc_ret
spc_22b0
	spc_mov_a_abs_x	$04a8
	spc_mov_y_a
	spc_mov_a_abs_x	$03a8
	spc_addw_ya_dp	$20
	spc_mov_abs_x_a	$03a8
	spc_mov_a_y
	spc_mov_abs_x_a	$04a8
	spc_bmi	spc_22c4
	spc_bra	spc_22cf
spc_22c4
	spc_setc
	spc_sbc_a_i	$c0
	spc_bmi	spc_22cd
	spc_mov_a_i	$00
	spc_bra	spc_22cf
spc_22cd
	spc_mov_a_i	$7f
spc_22cf
	spc_mov_abs_x_a	$0398
	spc_ret
spc_22d3
	spc_mov_a_xreg
	spc_mov_y_i	$10
	spc_mul_ya
	spc_mov_y_a
	spc_push_y
	spc_mov_a_abs_x	$0408
	spc_beq	spc_22e8
	spc_mov_a_abs_x	$04c0
	spc_beq	spc_22e8
	spc_call	spc_2336
	spc_bra	spc_22eb
spc_22e8
	spc_mov_a_abs_x	$0398
spc_22eb
	spc_call	spc_variantvolume
	spc_pop_y
	spc_call	spc_writereg
	spc_inc_y
	spc_push_y
	spc_mov_a_abs_x	$0408
	spc_beq	spc_2309
	spc_mov_a_abs_x	$04c8
	spc_beq	spc_2309
	spc_call	spc_ca96
	spc_call	spc_2336
	spc_call	spc_ca9f
	spc_bra	spc_230c
spc_2309
	spc_mov_a_abs_x	$03a0
spc_230c
	spc_call	spc_variantvolume
	spc_pop_y
	spc_call	spc_writereg
	spc_inc_y
	spc_mov_a_abs_x	$03b8
	spc_call	spc_writereg
	spc_inc_y
	spc_mov_a_abs_x	$03c0
	spc_call	spc_writereg
	spc_inc_y
	spc_mov_a_abs_x	$03c8
	spc_call	spc_writereg
	spc_inc_y
	spc_mov_a_abs_x	$03d0
	spc_call	spc_writereg
	spc_inc_y
	spc_mov_a_abs_x	$03d8
	spc_jmp	spc_writereg
spc_2336
	spc_cmp_a_i	$01
	spc_beq	spc_2348
	spc_cmp_a_i	$3c
	spc_beq	spc_2385
	spc_cmp_a_i	$ff
	spc_beq	spc_23ad
	spc_inc_a
	spc_mov_abs_x_a	$04c0
	spc_bra	spc_2361
spc_2348
	spc_inc_a
	spc_mov_abs_x_a	$04c0
	spc_mov_a_abs_x	$0398
	spc_mov_y_a
	spc_mov_a_abs_x	$03a8
	spc_push_x
	spc_mov_x_i	$3c
	spc_call	spc_ca89
	spc_pop_x
	spc_mov_abs_x_a	$04d0
	spc_mov_a_y
	spc_mov_abs_x_a	$04e0
spc_2361
	spc_mov_a_abs_x	$04c0
	spc_dec_a
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$04d0
	spc_mov_y_a
	spc_mov_a_abs_x	$04e0
	spc_push_x
	spc_mov_x_a
	spc_mov_a_dp	$22
	spc_call	spc_ca75
	spc_pop_x
	spc_mov_dp_a	$22
	spc_mov_dp_y	$23
	spc_mov_a_abs_x	$0398
	spc_mov_y_a
	spc_mov_a_abs_x	$03a8
	spc_subw_ya_dp	$22
	spc_mov_a_y
	spc_ret
spc_2385
	spc_bbs	7,$2c,spc_238d
	spc_bbs	0,$2d,spc_2390
	spc_bra	spc_2393
spc_238d
	spc_jmp	spc_receiverrestart
spc_2390
	spc_jmp	spc_iplrestart
spc_2393
	spc_mov_dp_xreg	$22
	spc_bbs	3,$22,spc_23a2
	spc_call	spc_releasechannel
spc_239b
	spc_mov_a_i	$ff
	spc_mov_abs_x_a	$04c0
	spc_inc_a
	spc_ret
spc_23a2
	spc_call	spc_ca9f
	spc_call	spc_releasechannel
	spc_call	spc_ca96
	spc_bra	spc_239b
spc_23ad
	spc_inc_a
	spc_mov_abs_x_a	$04c0
	spc_ret
spc_variantvolume
	spc_push_y
	spc_mov_dp_a	$22
	spc_cmp_a_i	$00
	spc_beq	spc_23c9
	spc_mov_a_abs_x	$0390
	spc_cmp_a_i	$25
	spc_bne	spc_23cb
	spc_mov_a_abs	$0530
	spc_mov_y_i	$04
	spc_mul_ya
	spc_clrc
	spc_adc_a_dp	$22
spc_23c9
	spc_pop_y
	spc_ret
spc_23cb
	spc_mov_a_dp	$22
	spc_bra	spc_23c9

; Match the active effect against a zero-terminated ID list, then dispatch.
spc_variantlookup
	spc_mov_a_abs_x	$0390
	spc_mov_dp_a	$20
	spc_push_x
	spc_mov_x_i	$00
spc_23d7
	spc_mov_a_abs_x	$23eb
	spc_beq	spc_23e3
	spc_cmp_a_dp	$20
	spc_beq	spc_23e5
	spc_inc_x
	spc_bra	spc_23d7
spc_23e3
	spc_pop_x
	spc_ret
spc_23e5
	spc_mov_a_xreg
	spc_asl_a
	spc_mov_x_a
	spc_jmp_abs_x	spc_variantdispatch
spc_variantids
	db	$07,$04,$01,$0a,$0d,$74,$73,$72,$75,$76,$17,$25
	db	$21,$02,$58,$00
spc_variantdispatch
	dw	spc_2441,spc_2441,spc_2441,spc_2441,spc_2441,spc_2441
	dw	spc_2441,spc_2441,spc_2441,spc_2441,spc_262a,spc_261f
	dw	spc_25e2,spc_265c,spc_265c

; Parameter tables indexed by the selected effect variant.
spc_variantparams
	db	$0c,$13,$55,$7f,$00,$00,$00,$00,$00,$00,$23,$1a
	db	$17,$17,$16,$0d,$11,$11,$14,$20,$0c,$0b,$0e,$07
	db	$06,$0c,$0b,$0e,$07,$06,$1b,$1e,$1f,$12,$0f,$1b
	db	$1e,$1f,$12,$0f
spc_2441
	spc_lsr_a
	spc_mov_x_a
	spc_mov_a_abs_x	$2419
	spc_mov_dp_a	$22
	spc_mov_a_abs_x	$2423
	spc_mov_dp_a	$23
	spc_mov_a_abs_x	$242d
	spc_mov_dp_a	$24
	spc_mov_a_abs_x	$2437
	spc_mov_dp_a	$25
	spc_pop_x
	spc_call	spc_25a0
	spc_push_x
	spc_cmp_dp_dp	$0b,$03
	spc_beq	spc_24a9
	spc_mov_a_i	$00
	spc_mov_abs_a	$0539
	spc_mov_a_dp	$03
	spc_mov_abs_a	$053b
	spc_setc
	spc_sbc_a_dp	$0b
	spc_bmi	spc_249e
	spc_push_a
	spc_mov_a_i	$01
	spc_mov_abs_a	$053d
spc_2476
	spc_pop_a
	spc_mov_y_a
	spc_mov_x_abs	$0533
	spc_bne	spc_247f
	spc_mov_x_i	$01
spc_247f
	spc_mov_a_i	$00
	spc_div_ya_x
	spc_bvs	spc_248e
	spc_mov_abs_a	$0535
	spc_mov_a_i	$00
	spc_mov_abs_a	$0537
	spc_bra	spc_2496
spc_248e
	spc_mov_abs_a	$0535
	spc_mov_a_i	$01
	spc_mov_abs_a	$0537
spc_2496
	spc_mov_a_i	$00
	spc_mov_abs_a	$0533
	spc_jmp	spc_254f
spc_249e
	spc_eor_a_i	$ff
	spc_inc_a
	spc_push_a
	spc_mov_a_i	$02
	spc_mov_abs_a	$053d
	spc_bra	spc_2476
spc_24a9
	spc_mov_a_dp	$03
	spc_bne	spc_24b7
	spc_mov_a_i	$00
	spc_mov_abs_a	$0535
	spc_mov_abs_a	$0536
	spc_bra	spc_24dc
spc_24b7
	spc_mov_a_dp	$03
	spc_bpl	spc_24dc
	spc_setc
	spc_sbc_a_i	$f0
	spc_bmi	spc_24dc
	spc_mov_a_abs	$056d
	spc_mov_dp_a	$22
	spc_mov_a_abs	$056f
	spc_mov_dp_a	$23
	spc_incw_dp	$22
	spc_incw_dp	$22
	spc_incw_dp	$22
	spc_mov_a_dp	$22
	spc_mov_abs_a	$056d
	spc_mov_a_dp	$23
	spc_mov_abs_a	$056f
	spc_bra	spc_24e4
spc_24dc
	spc_mov_a_i	$00
	spc_mov_abs_a	$056d
	spc_mov_abs_a	$056f
spc_24e4
	spc_mov_a_abs	$0533
	spc_setc
	spc_sbc_a_i	$0a
	spc_bmi	spc_2506
	spc_mov_dp_i	$22,$01
	spc_mov_dp_i	$23,$00
	spc_mov_y_abs	$0537
	spc_mov_a_abs	$0535
	spc_subw_ya_dp	$22
	spc_bpl	spc_2500
	spc_mov_a_i	$00
	spc_mov_y_i	$00
spc_2500
	spc_mov_abs_a	$0535
	spc_mov_abs_y	$0537
spc_2506
	spc_mov_a_abs	$0533
	spc_cmp_a_i	$ff
	spc_beq	spc_2514
	spc_mov_a_abs	$0533
	spc_inc_a
	spc_mov_abs_a	$0533
spc_2514
	spc_mov_a_abs	$0533
	spc_cmp_a_i	$01
	spc_beq	spc_2548
	spc_mov_y_abs	$053b
	spc_mov_a_abs	$0539
spc_2521
	spc_push_a
	spc_mov_a_abs	$0535
	spc_mov_dp_a	$20
	spc_mov_a_abs	$0537
	spc_mov_dp_a	$21
	spc_mov_a_abs	$053d
	spc_cmp_a_i	$02
	spc_beq	spc_2541
	spc_pop_a
	spc_addw_ya_dp	$20
	spc_bcs	spc_254f
spc_2538
	spc_mov_abs_a	$0539
	spc_mov_a_y
	spc_mov_abs_a	$053b
	spc_bra	spc_254f
spc_2541
	spc_pop_a
	spc_subw_ya_dp	$20
	spc_bcc	spc_254f
	spc_bra	spc_2538
spc_2548
	spc_mov_a_dp	$03
	spc_mov_y_a
	spc_mov_a_i	$00
	spc_bra	spc_2521
spc_254f
	spc_mov_dp_i	$20,$00
	spc_mov_dp_dp	$21,$24
	spc_mov_y_dp	$25
	spc_mov_a_abs	$053b
	spc_mul_ya
	spc_mov_dp_i	$20,$00
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21
	spc_mov_a_abs	$0549
	spc_mov_y_abs	$054b
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21
	spc_mov_a_abs	$054d
	spc_mov_y_abs	$054f
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21
	spc_mov_a_abs	$056d
	spc_mov_y_abs	$056f
	spc_addw_ya_dp	$20
	spc_mov_dp_a	$20
	spc_mov_dp_y	$21
	spc_setc
	spc_sbc_dp_i	$21,$3f
	spc_bmi	spc_2591
	spc_mov_dp_i	$21,$3f
spc_2591
	spc_mov_dp_dp	$0b,$03
	spc_pop_x
	spc_mov_a_dp	$20
	spc_mov_abs_x_a	$03b8
	spc_mov_a_dp	$21
	spc_mov_abs_x_a	$03c0
	spc_ret
spc_25a0
	spc_mov_a_dp	$03
	spc_eor_a_i	$ff
	spc_mov_y_i	$00
	spc_push_x
	spc_mov_x_dp	$22
	spc_div_ya_x
	spc_mov_dp_a	$20
	spc_pop_x
	spc_mov_a_dp	$23
	spc_clrc
	spc_adc_a_dp	$20
	spc_bbc	0,$28,spc_25bb
	spc_mov_y_abs	$0552
	spc_dec_y
	spc_mul_ya
	spc_mov_a_y
spc_25bb
	spc_bbc	2,$29,spc_25c0
	spc_adc_a_i	$03
spc_25c0
	spc_call	spc_25d8
	spc_mov_y_abs	$056b
	spc_mul_ya
	spc_mov_a_y
	spc_bbc	4,$2d,spc_25d1
	spc_push_x
	spc_mov_y_i	$c0
	spc_mul_ya
	spc_mov_a_y
	spc_pop_x
spc_25d1
	spc_mov_abs_x_a	$0398
	spc_mov_abs_x_a	$03a0
	spc_ret
spc_25d8
	spc_bbs	2,$28,spc_25e1
	spc_push_y
	spc_mov_y_i	$d0
	spc_mul_ya
	spc_mov_a_y
	spc_pop_y
spc_25e1
	spc_ret
spc_25e2
	spc_pop_x
	spc_mov_dp_i	$22,$28
	spc_mov_dp_i	$23,$03
	spc_mov_dp_i	$24,$02
	spc_call	spc_2634
	spc_mov_a_abs_x	$03e8
	spc_cmp_a_i	$02
	spc_beq	spc_25fb
spc_25f6
	spc_bbs	6,$28,spc_2614
	spc_bra	spc_2609
spc_25fb
	spc_call	spc_2600
	spc_bra	spc_25f6
spc_2600
	spc_bbs	6,$28,spc_2606
	spc_set	6,$28
	spc_ret
spc_2606
	spc_clr	6,$28
	spc_ret
spc_2609
	spc_mov_a_i	$80
	spc_mov_abs_x_a	$03b8
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$03c0
	spc_ret
spc_2614
	spc_mov_a_i	$10
	spc_mov_abs_x_a	$03b8
	spc_mov_a_i	$01
	spc_mov_abs_x_a	$03c0
	spc_ret
spc_261f
	spc_mov_dp_i	$22,$1e
	spc_mov_dp_i	$23,$03
	spc_mov_dp_i	$24,$01
	spc_bra	spc_2633
spc_262a
	spc_mov_dp_i	$22,$14
	spc_mov_dp_i	$23,$0a
	spc_mov_dp_i	$24,$02
spc_2633
	spc_pop_x
spc_2634
	spc_mov_a_dp	$03
	spc_eor_a_i	$ff
	spc_mov_y_i	$00
	spc_push_x
	spc_mov_x_dp	$22
	spc_div_ya_x
	spc_pop_x
	spc_clrc
	spc_adc_a_dp	$23
	spc_push_a
	spc_mov_a_abs	$0545
	spc_inc_a
	spc_mov_abs_a	$0545
	spc_pop_a
	spc_setc
	spc_sbc_a_abs	$0545
	spc_bpl	spc_265b
	spc_mov_a_dp	$24
	spc_mov_abs_x_a	$03e8
	spc_mov_a_i	$01
	spc_mov_abs_a	$0545
spc_265b
	spc_ret
spc_265c
	spc_pop_x
	spc_mov_a_dp	$02
	spc_and_a_i	$07
	spc_bbs	3,$02,spc_2666
	spc_eor_a_i	$07
spc_2666
	spc_asl_a
	spc_mov_y_a
	spc_mov_a_abs_y	spc_nearpitches
	spc_mov_dp_a	$20
	spc_inc_y
	spc_mov_a_abs_y	spc_nearpitches
	spc_mov_dp_a	$21
	spc_mov_a_abs_x	$04a0
	spc_mov_y_a
	spc_mov_a_abs_x	$0498
	spc_bbs	3,$02,spc_2681
	spc_subw_ya_dp	$20
	spc_bra	spc_2683
spc_2681
	spc_addw_ya_dp	$20
spc_2683
	spc_mov_abs_x_a	$03b8
	spc_mov_a_y
	spc_mov_abs_x_a	$03c0
	spc_mov_a_dp	$02
	spc_and_a_i	$f0
	spc_xcn_a
	spc_bbs	7,$02,spc_26a8
	spc_asl_a
	spc_mov_y_a
	spc_mov_a_abs_y	spc_nearvolumes
	spc_call	spc_scaleparameter
	spc_mov_abs_x_a	$0398
	spc_inc_y
	spc_mov_a_abs_y	spc_nearvolumes
	spc_call	spc_scaleparameter
	spc_mov_abs_x_a	$03a0
	spc_ret
spc_26a8
	spc_eor_a_i	$0f
	spc_asl_a
	spc_mov_y_a
	spc_mov_a_abs_y	spc_nearvolumes
	spc_call	spc_scaleparameter
	spc_mov_abs_x_a	$03a0
	spc_inc_y
	spc_mov_a_abs_y	spc_nearvolumes
	spc_call	spc_scaleparameter
	spc_mov_abs_x_a	$0398
	spc_ret

; Scale by (variant+1)/21 with SPC DIV behavior, then subtract port-2 low nibble.
spc_scaleparameter
	spc_push_y
	spc_push_x
	spc_mov_y_abs	$0562
	spc_inc_y
	spc_mul_ya
	spc_mov_x_i	$15
	spc_div_ya_x
	spc_pop_x
	spc_pop_y
	spc_mov_dp_dp	$22,$02
	spc_and_dp_i	$22,$0f
	spc_setc
	spc_sbc_a_dp	$22
	spc_ret
spc_effectclass0
	db	$03,$32,$37,$30,$3c,$16,$20,$54,$31,$57,$3d,$35
	db	$39,$00
spc_effectclass1
	db	$5a,$4d,$4e,$2d,$2e,$0b,$0c,$29,$33,$43,$30,$3c
	db	$38,$3e,$56,$31,$2c,$57,$3d,$16,$20,$35,$39,$00
	spc_endblock	$0bd9
