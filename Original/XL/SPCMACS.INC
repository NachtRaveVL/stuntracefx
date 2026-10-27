; SPC700 encodings for the original SASMX build. Address modes are explicit.
; All instructions affect SPC registers, never the host 65816 assembler mode.

spc_or_a_i	macro
	db	$08
	db	\1
	endm

spc_asl_dp	macro
	db	$0b
	db	\1
	endm

spc_bpl	macro
	db	$10
	db	((\1)-(*+1))&$ff
	endm

spc_asl_a	macro
	db	$1c
	endm

spc_dec_x	macro
	db	$1d
	endm

spc_jmp_abs_x	macro
	db	$1f
	dw	\1
	endm

spc_clrp	macro
	db	$20
	endm

spc_and_a_dp	macro
	db	$24
	db	\1
	endm

spc_and_a_i	macro
	db	$28
	db	\1
	endm

spc_push_a	macro
	db	$2d
	endm

spc_bra	macro
	db	$2f
	db	((\1)-(*+1))&$ff
	endm

spc_bmi	macro
	db	$30
	db	((\1)-(*+1))&$ff
	endm

spc_incw_dp	macro
	db	$3a
	db	\1
	endm

spc_inc_x	macro
	db	$3d
	endm

spc_call	macro
	db	$3f
	dw	\1
	endm

spc_eor_a_dp	macro
	db	$44
	db	\1
	endm

spc_push_x	macro
	db	$4d
	endm

spc_lsr_a	macro
	db	$5c
	endm

spc_mov_x_a	macro
	db	$5d
	endm

spc_cmp_y_abs	macro
	db	$5e
	dw	\1
	endm

spc_jmp	macro
	db	$5f
	dw	\1
	endm

spc_clrc	macro
	db	$60
	endm

spc_cmp_a_dp	macro
	db	$64
	db	\1
	endm

spc_cmp_a_i	macro
	db	$68
	db	\1
	endm

spc_cmp_dp_dp	macro
	db	$69
	db	\2,\1
	endm

spc_ror_dp	macro
	db	$6b
	db	\1
	endm

spc_push_y	macro
	db	$6d
	endm

spc_ret	macro
	db	$6f
	endm

spc_cmp_a_abs_x	macro
	db	$75
	dw	\1
	endm

spc_cmp_dp_i	macro
	db	$78
	db	\2,\1
	endm

spc_addw_ya_dp	macro
	db	$7a
	db	\1
	endm

spc_setc	macro
	db	$80
	endm

spc_adc_a_dp	macro
	db	$84
	db	\1
	endm

spc_mov_y_i	macro
	db	$8d
	db	\1
	endm

spc_mov_dp_i	macro
	db	$8f
	db	\2,\1
	endm

spc_bcc	macro
	db	$90
	db	((\1)-(*+1))&$ff
	endm

spc_subw_ya_dp	macro
	db	$9a
	db	\1
	endm

spc_dec_a	macro
	db	$9c
	endm

spc_sbc_a_i	macro
	db	$a8
	db	\1
	endm

spc_inc_dp	macro
	db	$ab
	db	\1
	endm

spc_cmp_y_i	macro
	db	$ad
	db	\1
	endm

spc_pop_a	macro
	db	$ae
	endm

spc_mov_xinc_a	macro
	db	$af
	endm

spc_bcs	macro
	db	$b0
	db	((\1)-(*+1))&$ff
	endm

spc_inc_a	macro
	db	$bc
	endm

spc_mov_sp_x	macro
	db	$bd
	endm

spc_mov_dp_a	macro
	db	$c4
	db	\1
	endm

spc_mov_abs_a	macro
	db	$c5
	dw	\1
	endm

spc_cmp_x_i	macro
	db	$c8
	db	\1
	endm

spc_mov_abs_x	macro
	db	$c9
	dw	\1
	endm

spc_mov_dp_y	macro
	db	$cb
	db	\1
	endm

spc_mov_abs_y	macro
	db	$cc
	dw	\1
	endm

spc_mov_x_i	macro
	db	$cd
	db	\1
	endm

spc_pop_x	macro
	db	$ce
	endm

spc_mul_ya	macro
	db	$cf
	endm

spc_bne	macro
	db	$d0
	db	((\1)-(*+1))&$ff
	endm

spc_mov_abs_x_a	macro
	db	$d5
	dw	\1
	endm

spc_mov_dpi_y_a	macro
	db	$d7
	db	\1
	endm

spc_mov_dp_ya	macro
	db	$da
	db	\1
	endm

spc_mov_a_dp	macro
	db	$e4
	db	\1
	endm

spc_mov_a_abs	macro
	db	$e5
	dw	\1
	endm

spc_mov_a_x	macro
	db	$e6
	endm

spc_mov_a_i	macro
	db	$e8
	db	\1
	endm

spc_mov_y_abs	macro
	db	$ec
	dw	\1
	endm

spc_notc	macro
	db	$ed
	endm

spc_pop_y	macro
	db	$ee
	endm

spc_beq	macro
	db	$f0
	db	((\1)-(*+1))&$ff
	endm

spc_mov_a_dp_x	macro
	db	$f4
	db	\1
	endm

spc_mov_a_abs_x	macro
	db	$f5
	dw	\1
	endm

spc_mov_a_abs_y	macro
	db	$f6
	dw	\1
	endm

spc_mov_a_dpi_y	macro
	db	$f7
	db	\1
	endm

spc_mov_dp_dp	macro
	db	$fa
	db	\2,\1
	endm

spc_inc_y	macro
	db	$fc
	endm

spc_mov_y_a	macro
	db	$fd
	endm

spc_dbnz_y	macro
	db	$fe
	db	((\1)-(*+1))&$ff
	endm

spc_set	macro
	db	$02+((\1)*$20),\2
	endm

spc_clr	macro
	db	$12+((\1)*$20),\2
	endm

spc_bbs	macro
	db	$03+((\1)*$20),\2
	db	((\3)-(*+1))&$ff
	endm

spc_bbc	macro
	db	$13+((\1)*$20),\2
	db	((\3)-(*+1))&$ff
	endm

; Emit an IPL block while assembling its code at the SPC RAM address.
; The enclosing bank determines physical placement; return to its ROM PC.
spc_block	macro
\1
	dw	\3,\2
spc_rompc	=	*
spc_objpc	=	$8000*banknum+(spc_rompc&$7fff)
spc_rampc	=	\2
	org	spc_rampc,spc_objpc
	endm

spc_endblock	macro
	ifne	*-spc_rampc-\1
	fail
	endc
spc_blocklen	=	*-spc_rampc
	org	spc_rompc+spc_blocklen,spc_objpc+spc_blocklen
	endm

; Music-sequencer instruction forms.
spc_or_dp_dp	macro
	db	$09
	db	\2,\1
	endm

spc_tset1_abs	macro
	db	$0e
	dw	\1
	endm

spc_rol_dp	macro
	db	$2b
	db	\1
	endm

spc_and_dp_i	macro
	db	$38
	db	\2,\1
	endm

spc_setp	macro
	db	$40
	endm

spc_eor_a_i	macro
	db	$48
	db	\1
	endm

spc_lsr_dp	macro
	db	$4b
	db	\1
	endm

spc_tclr1_abs	macro
	db	$4e
	dw	\1
	endm

spc_cmp_a_abs	macro
	db	$65
	dw	\1
	endm

spc_dbnz_dp	macro
	db	$6e
	db	\1
	db	((\2)-(*+1))&$ff
	endm

spc_ror_a	macro
	db	$7c
	endm

spc_mov_a_xreg	macro
	db	$7d
	endm

spc_adc_a_i	macro
	db	$88
	db	\1
	endm

spc_dec_dp	macro
	db	$8b
	db	\1
	endm

spc_adc_a_abs_x	macro
	db	$95
	dw	\1
	endm

spc_adc_a_abs_y	macro
	db	$96
	dw	\1
	endm

spc_adc_dp_i	macro
	db	$98
	db	\2,\1
	endm

spc_dec_dp_x	macro
	db	$9b
	db	\1
	endm

spc_div_ya_x	macro
	db	$9e
	endm

spc_xcn_a	macro
	db	$9f
	endm

spc_sbc_a_dp	macro
	db	$a4
	db	\1
	endm

spc_sbc_a_abs_x	macro
	db	$b5
	dw	\1
	endm

spc_sbc_a_abs_y	macro
	db	$b6
	dw	\1
	endm

spc_mov_ya_dp	macro
	db	$ba
	db	\1
	endm

spc_inc_dp_x	macro
	db	$bb
	db	\1
	endm

spc_mov_dp_x_a	macro
	db	$d4
	db	\1
	endm

spc_mov_abs_y_a	macro
	db	$d6
	dw	\1
	endm

spc_mov_dp_xreg	macro
	db	$d8
	db	\1
	endm

spc_dec_y	macro
	db	$dc
	endm

spc_mov_a_y	macro
	db	$dd
	endm

spc_cbne_dp_x	macro
	db	$de
	db	\1
	db	((\2)-(*+1))&$ff
	endm

spc_mov_a_dpi_x	macro
	db	$e7
	db	\1
	endm

spc_mov_y_dp	macro
	db	$eb
	db	\1
	endm

spc_mov_x_dp	macro
	db	$f8
	db	\1
	endm

spc_mov_y_dp_x	macro
	db	$fb
	db	\1
	endm

; Effect/voice instruction forms.
spc_or_a_dp	macro
	db	$04
	db	\1
	endm

spc_rol_a	macro
	db	$3c
	endm

spc_bvs	macro
	db	$70
	db	((\1)-(*+1))&$ff
	endm

spc_cmp_a_abs_y	macro
	db	$76
	dw	\1
	endm

spc_adc_a_abs	macro
	db	$85
	dw	\1
	endm

spc_dec_abs	macro
	db	$8c
	dw	\1
	endm

spc_sbc_a_abs	macro
	db	$a5
	dw	\1
	endm

spc_inc_abs	macro
	db	$ac
	dw	\1
	endm

spc_sbc_dp_i	macro
	db	$b8
	db	\2,\1
	endm

spc_mov_x_abs	macro
	db	$e9
	dw	\1
	endm

; Native helper and script/data encodings.
spc_eor1_c	macro
	db	$8a
	dw	((\1)&$1fff)+((\2)*$2000)
	endm

spc_mov1_c	macro
	db	$aa
	dw	((\1)&$1fff)+((\2)*$2000)
	endm

spc_instrumentdef	macro
	db	\1,\2,\3,\4
	db	((\5)>>8)&$ff,(\5)&$ff
	endm

spc_sampledef	macro
	dw	\1,\2
	endm

; Effect E5/E6 select ADSR1 attack/decay; E7/E8 select ADSR2 level/rate.
; E1 skips key-off at the next wait, E2 ties it, FB requests key-off.
; EA/EB toggle the voice's DSP echo-enable bit.
spc_fxheader	macro
	db	\1
	endm

spc_fxwait	macro
	db	\1
	endm

spc_fxnote	macro
	db	\1
	endm

spc_fxskip	macro
	db	0
	endm

spc_fxend	macro
	db	$e0
	endm

spc_fxskipkeyoff	macro
	db	$e1
	endm

spc_fxtie	macro
	db	$e2
	endm

spc_fxsample	macro
	db	$e3
	db	\1
	endm

spc_fxvolume	macro
	db	$e4
	db	\1,\2
	endm

spc_fxattack	macro
	db	$e5
	db	\1
	endm

spc_fxdecay	macro
	db	$e6
	db	\1
	endm

spc_fxsustainlevel	macro
	db	$e7
	db	\1
	endm

spc_fxsustainrate	macro
	db	$e8
	db	\1
	endm

spc_fxpitchramp	macro
	db	$e9
	db	\1,\2
	endm

spc_fxechoon	macro
	db	$ea
	endm

spc_fxechooff	macro
	db	$eb
	endm

spc_fxspawn	macro
	db	$ec
	dw	\1
	endm

spc_fxvolumeramp	macro
	db	$ed
	db	\1,\2,\3,\4
	endm

spc_fxdetune	macro
	db	$ee
	db	\1
	endm

spc_fxpitchrampoff	macro
	db	$f1
	endm

spc_fxvolumerampoff	macro
	db	$f2
	endm

spc_fxjump	macro
	db	$f3
	dw	\1
	endm

spc_fxtimeout	macro
	db	$f8
	db	\1
	endm

spc_fxkeyoff	macro
	db	$fb
	endm

spc_fxmode	macro
	db	$fc
	db	\1
	endm

spc_fxnoise	macro
	db	$fd
	db	\1
	endm

spc_fxmono	macro
	db	$fe
	db	\1
	endm

spc_musicpattern	macro
	dw	\1
	endm

spc_musicloop	macro
	dw	\1,\2
	endm

spc_musicend	macro
	dw	0
	endm

spc_trackend	macro
	db	0
	endm

spc_tracktime	macro
	db	\1
	endm

; Duration followed by the packed gate/velocity nibbles.
spc_trackgate	macro
	db	\1,\2
	endm

spc_tracknote	macro
	db	\1
	endm

spc_musicinstrument	macro
	db	$e0
	db	\1
	endm

spc_musicpan	macro
	db	$e1
	db	\1
	endm

spc_musicvolume	macro
	db	$e5
	db	\1
	endm

spc_musictempo	macro
	db	$e7
	db	\1
	endm

spc_musictrackvolume	macro
	db	$ed
	db	\1
	endm

spc_musictrackvolumeramp	macro
	db	$ee
	db	\1,\2
	endm

spc_musiccall	macro
	db	$ef
	dw	\1
	db	\2
	endm

spc_musicfinetuning	macro
	db	$f4
	db	\1
	endm

spc_musicecho	macro
	db	$f5
	db	\1,\2,\3
	endm

spc_musicechoconfig	macro
	db	$f7
	db	\1,\2,\3
	endm

spc_musicpitchslide	macro
	db	$f9
	db	\1,\2,\3
	endm

spc_musicpercussionbase	macro
	db	$fa
	db	\1
	endm

; BRR: sixteen signed four-bit residuals in four big-endian packed words.
spc_brrend	equ	1
spc_brrloop	equ	2
spc_brrblock	macro
	iflt	\1
	fail
	endc
	ifgt	(\1)-15
	fail
	endc
	iflt	\2
	fail
	endc
	ifgt	(\2)-3
	fail
	endc
	iflt	\3
	fail
	endc
	ifgt	(\3)-3
	fail
	endc
	db	((\1)*16)+((\2)*4)+(\3)
	db	((\4)>>8)&$ff,(\4)&$ff
	db	((\5)>>8)&$ff,(\5)&$ff
	db	((\6)>>8)&$ff,(\6)&$ff
	db	((\7)>>8)&$ff,(\7)&$ff
	endm

; Additional commands used by the retail song streams.
spc_musicpanramp	macro
	db	$e2
	db	\1,\2
	endm

spc_musicvibrato	macro
	db	$e3
	db	\1,\2,\3
	endm

spc_musicvibratooff	macro
	db	$e4
	endm

spc_musicvibratofade	macro
	db	$f0
	db	\1
	endm

spc_musicpitchbenddown	macro
	db	$f2
	db	\1,\2,\3
	endm

spc_musicpitchbendoff	macro
	db	$f3
	endm

; Alternate control-stage absolute shift.
spc_asl_abs	macro
	db	$0c
	dw	\1
	endm
