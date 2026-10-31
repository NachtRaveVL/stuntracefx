; Retail display publication, HDMA recipes and GSU tile unpacking.
; Copied native $7F:0800 code is compiled here with rebound near targets.
; D=0, DB=0 (or a low mirrored bank), binary arithmetic. Queue-graphics
; requires I16 on entry because native PHX precedes REP. Buffers/descriptors
; are caller-owned, counts/capacities are native and unchecked. Queues drain
; newest-first. OAM/CGRAM/DMA publication requires a caller-owned blanking
; interval; these entries do not install or replace the early NMI handler.
; GSU unpack uses runmario_l and the current mario_draw_mode; serialize
; ownership and bind packed ROM addresses before calling. No scene assets
; are implicitly selected. Palette load uses the long pointer tempaddrl.
	incpublics mrblank.ext
	include mrforms.ext
mrblank_begin
	longa
	longi
retail_unpackdisplay_l
	phy
rfu_03eb84
	lda.w $0000,x
rfu_03eb87
	sta.l m_enddata
rfu_03eb8b
	lda #$3000
rfu_03eb8e
	sta.l m_decaddr
rfu_03eb92
	lda #$0000
rfu_03eb95
	sta.l m_decoffset
rfu_03eb99
	a8
rfu_03eb9b
	lda.w $0002,x
rfu_03eb9e
	sta.l m_enddatabnk
rfu_03eba2
	lda #mdecrunch>>16
rfu_03eba4
	ldx #mdecrunch&WM
rfu_03eba7
	jsl runmario_l
rfu_03ebab
	a8
rfu_03ebad
	i16
rfu_03ebaf
	plx
rfu_03ebb0
	lda.w $0000,x
rfu_03ebb3
	sta.w $2115
rfu_03ebb6
	lda.w $0001,x
rfu_03ebb9
	sta.w $2116
rfu_03ebbc
	lda.w $0002,x
rfu_03ebbf
	sta.w $2117
rfu_03ebc2
	lda.w $0003,x
rfu_03ebc5
	sta.w $4300
rfu_03ebc8
	lda.w $0004,x
rfu_03ebcb
	sta.w $4301
rfu_03ebce
	lda #$00
rfu_03ebd0
	sta.w $4302
rfu_03ebd3
	lda #$30
rfu_03ebd5
	sta.w $4303
rfu_03ebd8
	lda #$70
rfu_03ebda
	sta.w $4304
rfu_03ebdd
	lda.w $0005,x
rfu_03ebe0
	sta.w $4305
rfu_03ebe3
	lda.w $0006,x
rfu_03ebe6
	sta.w $4306
rfu_03ebe9
	lda #$01
rfu_03ebeb
	sta.w $420b
rfu_03ebee
	rtl
	longa
	longi
retail_unpackhigh_l
	sta.l m_enddata
rfu_03ebf3
	lda #$c000
rfu_03ebf6
	bra rfu_03ec08
	longa
	longi
retail_unpackmiddle_l
	sta.l m_enddata
rfu_03ebfc
	lda #$4000
rfu_03ebff
	bra rfu_03ec08
	longa
	longi
retail_unpacktiles_l
	sta.l m_enddata
rfu_03ec05
	lda #$3000
rfu_03ec08
	sta.l m_decaddr
rfu_03ec0c
	lda #$0000
rfu_03ec0f
	sta.l m_decoffset
rfu_03ec13
	txa
rfu_03ec14
	sta.l m_enddatabnk
rfu_03ec18
	a8
rfu_03ec1a
	lda #mdecrunch>>16
rfu_03ec1c
	ldx #mdecrunch&WM
rfu_03ec1f
	jsl runmario_l
rfu_03ec23
	rtl
	shorta
	longi
rfb_stagebitmap
	php
rfu_0b8001
	ai16
rfu_0b8003
	ldx.w race_bitmapstage
rfu_0b8006
	jmp (rfb_stages&WM,x)
	longa
	longi
rfu_0b8017
	ai16
rfu_0b8019
	ldx #$0002
rfu_0b801c
	stx.w race_bitmapstage
rfu_0b801f
	ldx #$2c00
rfu_0b8022
	ldy #$0000
rfu_0b8025
	lda #$0003
rfu_0b8028
	jsr rfb_bitmapchunk
rfu_0b802b
	plp
rfu_0b802c
	rts
	longa
	longi
rfu_0b802d
	ai16
rfu_0b802f
	ldx #$0004
rfu_0b8032
	stx.w race_bitmapstage
rfu_0b8035
	ldx #$3c00
rfu_0b8038
	ldy #$0580
rfu_0b803b
	lda #$0003
rfu_0b803e
	jsr rfb_bitmapchunk
rfu_0b8041
	plp
rfu_0b8042
	rts
	longa
	longi
rfu_0b8043
	ai16
rfu_0b8045
	ldx #$0006
rfu_0b8048
	stx.w race_bitmapstage
rfu_0b804b
	ldx #$4c00
rfu_0b804e
	ldy #$0b00
rfu_0b8051
	lda #$0004
rfu_0b8054
	jsr rfb_bitmapchunk
rfu_0b8057
	a8
rfu_0b8059
	lda #$01
rfu_0b805b
	sta.w race_frontdmaflip
rfu_0b805e
	lda #$60
rfu_0b8060
	sta.w $2107
rfu_0b8063
	lda.w race_displayrequests
rfu_0b8066
	ora #$20
rfu_0b8068
	sta.w race_displayrequests
rfu_0b806b
	plp
rfu_0b806c
	rts
	longa
	longi
rfu_0b806d
	ai16
rfu_0b806f
	plp
rfu_0b8070
	rts
	longa
	longi
rfu_0b8071
	ai16
rfu_0b8073
	ldx #$000a
rfu_0b8076
	stx.w race_bitmapstage
rfu_0b8079
	ldx #$5000
rfu_0b807c
	ldy #$1760
rfu_0b807f
	lda #$0003
rfu_0b8082
	jsr rfb_bitmapchunk
rfu_0b8085
	plp
rfu_0b8086
	rts
	longa
	longi
rfu_0b8087
	ai16
rfu_0b8089
	ldx #$000c
rfu_0b808c
	stx.w race_bitmapstage
rfu_0b808f
	ldx #$4000
rfu_0b8092
	ldy #$11e0
rfu_0b8095
	lda #$0003
rfu_0b8098
	jsr rfb_bitmapchunk
rfu_0b809b
	plp
rfu_0b809c
	rts
	longa
	longi
rfu_0b809d
	ai16
rfu_0b809f
	ldx #$0006
rfu_0b80a2
	stx.w race_bitmapstage
rfu_0b80a5
	ldx #$2c00
rfu_0b80a8
	ldy #$0b00
rfu_0b80ab
	lda #$0004
rfu_0b80ae
	jsr rfb_bitmapchunk
rfu_0b80b1
	a8
rfu_0b80b3
	lda #$01
rfu_0b80b5
	sta.w race_frontdmaflip
rfu_0b80b8
	lda #$64
rfu_0b80ba
	sta.w $2107
rfu_0b80bd
	lda.w race_displayrequests
rfu_0b80c0
	ora #$20
rfu_0b80c2
	sta.w race_displayrequests
rfu_0b80c5
	plp
rfu_0b80c6
	rts
	longa
	longi
rfb_bitmapchunk
	php
rfu_0b80c8
	ai16
rfu_0b80ca
	pha
rfu_0b80cb
	a8
rfu_0b80cd
	lda.w race_oamflags
rfu_0b80d0
	and #$f7
rfu_0b80d2
	sta.w $303a
rfu_0b80d5
	a16
rfu_0b80d7
	stx tempaddrl
rfu_0b80d9
	sty.w $2116
rfu_0b80dc
	i8
rfu_0b80de
	a16
rfu_0b80e0
	ldx #$80
rfu_0b80e2
	stx.w $2115
rfu_0b80e5
	ldx #$18
rfu_0b80e7
	stx.w $4301
rfu_0b80ea
	ldy #$70
rfu_0b80ec
	sty.w $4304
rfu_0b80ef
	ldy #$01
rfu_0b80f1
	sty.w $4300
rfu_0b80f4
	pla
rfu_0b80f5
	tax
rfu_0b80f6
	lda #$02c0
rfu_0b80f9
	sta.w $4305
rfu_0b80fc
	lda tempaddrl
rfu_0b80fe
	sta.w $4302
rfu_0b8101
	clc
rfu_0b8102
	adc #$0400
rfu_0b8105
	sta tempaddrl
rfu_0b8107
	sty.w $420b
rfu_0b810a
	dex
rfu_0b810b
	bpl rfu_0b80f6
rfu_0b810d
	a8
rfu_0b810f
	lda.w race_oamflags
rfu_0b8112
	ora #$18
rfu_0b8114
	sta.w $303a
rfu_0b8117
	plp
rfu_0b8118
	rts
	longa
	longi
retail_servicedisplay_l
	php
rfu_0b8521
	ai16
rfu_0b8523
	jsr rfb_flushgraphics
rfu_0b8526
	jsr rfb_flushregisters
rfu_0b8529
	plp
rfu_0b852a
	rtl
	longa
	longi
rfb_frontwindow
	ai16
rfu_0b85ae
	lda.l race_frontwindow
rfu_0b85b2
	bne rfu_0b85b7
rfu_0b85b4
	brl rfu_0b866e
rfu_0b85b7
	cmp #$0003
rfu_0b85ba
	bne rfu_0b85bf
rfu_0b85bc
	brl rfu_0b868b
rfu_0b85bf
	cmp #$0002
rfu_0b85c2
	beq rfu_0b861c
rfu_0b85c4
	lda #$002c
rfu_0b85c7
	sec
rfu_0b85c8
	sbc.l race_frontwindowpos
rfu_0b85cc
	a8
rfu_0b85ce
	sta.l race_fronttables+117
rfu_0b85d2
	sta.l race_fronttables+121
rfu_0b85d6
	a16
rfu_0b85d8
	lda.l race_frontwindowpos
rfu_0b85dc
	a8
rfu_0b85de
	asl a
rfu_0b85df
	bne rfu_0b85f9
rfu_0b85e1
	lda #$02
rfu_0b85e3
	sta.l race_fronttables+119
rfu_0b85e7
	lda #$03
rfu_0b85e9
	sta.l race_fronttables+120
rfu_0b85ed
	lda.l race_fronttables+121
rfu_0b85f1
	dec a
rfu_0b85f2
	dec a
rfu_0b85f3
	sta.l race_fronttables+121
rfu_0b85f7
	bra rfu_0b8603
rfu_0b85f9
	sta.l race_fronttables+119
rfu_0b85fd
	lda #$00
rfu_0b85ff
	sta.l race_fronttables+120
rfu_0b8603
	a16
rfu_0b8605
	lda.l race_frontwindowpos
rfu_0b8609
	sec
rfu_0b860a
	sbc #$0004
rfu_0b860d
	sta.l race_frontwindowpos
rfu_0b8611
	bmi rfu_0b8614
rfu_0b8613
	rts
rfu_0b8614
	lda #$0000
rfu_0b8617
	sta.l race_frontwindow
rfu_0b861b
	rts
rfu_0b861c
	lda #$002c
rfu_0b861f
	sec
rfu_0b8620
	sbc.l race_frontwindowpos
rfu_0b8624
	a8
rfu_0b8626
	sta.l race_fronttables+117
rfu_0b862a
	sta.l race_fronttables+121
rfu_0b862e
	a16
rfu_0b8630
	lda.l race_frontwindowpos
rfu_0b8634
	a8
rfu_0b8636
	asl a
rfu_0b8637
	bne rfu_0b8651
rfu_0b8639
	lda #$02
rfu_0b863b
	sta.l race_fronttables+119
rfu_0b863f
	lda #$03
rfu_0b8641
	sta.l race_fronttables+120
rfu_0b8645
	lda.l race_fronttables+121
rfu_0b8649
	dec a
rfu_0b864a
	dec a
rfu_0b864b
	sta.l race_fronttables+121
rfu_0b864f
	bra rfu_0b865b
rfu_0b8651
	sta.l race_fronttables+119
rfu_0b8655
	lda #$00
rfu_0b8657
	sta.l race_fronttables+120
rfu_0b865b
	a16
rfu_0b865d
	lda.l race_frontwindowpos
rfu_0b8661
	clc
rfu_0b8662
	adc #$0004
rfu_0b8665
	sta.l race_frontwindowpos
rfu_0b8669
	cmp #$002c
rfu_0b866c
	beq rfu_0b866f
rfu_0b866e
	rts
rfu_0b866f
	lda #$0000
rfu_0b8672
	sta.l race_frontwindow
rfu_0b8676
	lda #$0000
rfu_0b8679
	sta.l race_palshadow
rfu_0b867d
	a8
rfu_0b867f
	stz.w $2121
rfu_0b8682
	stz.w $2122
rfu_0b8685
	stz.w $2122
rfu_0b8688
	a16
rfu_0b868a
	rts
rfu_0b868b
	a8
rfu_0b868d
	lda.l race_frontanimy
rfu_0b8691
	inc a
rfu_0b8692
	sta.l race_fronttables+6
rfu_0b8696
	sta.l race_fronttables+19
rfu_0b869a
	sta.l race_fronttables+33
rfu_0b869e
	sta.l race_fronttables+44
rfu_0b86a2
	a16
rfu_0b86a4
	lda #$0016
rfu_0b86a7
	sec
rfu_0b86a8
	sbc.l race_frontanimy
rfu_0b86ac
	clc
rfu_0b86ad
	adc.l race_frontbasey0
rfu_0b86b1
	sta.l race_frontwindowy0
rfu_0b86b5
	lda #$0045
rfu_0b86b8
	sec
rfu_0b86b9
	sbc.l race_frontanimy
rfu_0b86bd
	clc
rfu_0b86be
	adc.l race_frontbasey1
rfu_0b86c2
	sta.l race_frontwindowy1
rfu_0b86c6
	a8
rfu_0b86c8
	rts
	longa
	longi
rfb_publishoam
	php
rfu_0b86ca
	a8
rfu_0b86cc
	i16
rfu_0b86ce
	lda.w race_displayrequests
rfu_0b86d1
	and #$04
rfu_0b86d3
	beq rfu_0b8701
rfu_0b86d5
	stz.w $4300
rfu_0b86d8
	lda #$04
rfu_0b86da
	sta.w $4301
rfu_0b86dd
	ldx #race_oam
rfu_0b86e0
	stx.w $4302
rfu_0b86e3
	lda #$00
rfu_0b86e5
	sta.w $4304
rfu_0b86e8
	ldx #$0220
rfu_0b86eb
	stx.w $4305
rfu_0b86ee
	ldx #$0000
rfu_0b86f1
	stx.w $2102
rfu_0b86f4
	lda #$01
rfu_0b86f6
	sta.w $420b
rfu_0b86f9
	lda.w race_displayrequests
rfu_0b86fc
	and #$fb
rfu_0b86fe
	sta.w race_displayrequests
rfu_0b8701
	plp
rfu_0b8702
	rts
	longa
	longi
rfb_publishpalette
	php
rfu_0b8704
	a8
rfu_0b8706
	i16
rfu_0b8708
	lda.w race_displayrequests
rfu_0b870b
	and #$08
rfu_0b870d
	beq rfu_0b8738
rfu_0b870f
	stz.w $4300
rfu_0b8712
	lda #$22
rfu_0b8714
	sta.w $4301
rfu_0b8717
	ldy #race_palshadow&WM
rfu_0b871a
	sty.w $4302
rfu_0b871d
	lda #race_palshadow>>16
rfu_0b871f
	sta.w $4304
rfu_0b8722
	ldy #$0200
rfu_0b8725
	sty.w $4305
rfu_0b8728
	stz.w $2121
rfu_0b872b
	lda #$01
rfu_0b872d
	sta.w $420b
rfu_0b8730
	lda.w race_displayrequests
rfu_0b8733
	and #$f7
rfu_0b8735
	sta.w race_displayrequests
rfu_0b8738
	plp
rfu_0b8739
	rts
	longa
	longi
rfb_flushregisters
	php
rfu_0b873b
	a8
rfu_0b873d
	i16
rfu_0b873f
	lda.w race_displayrequests
rfu_0b8742
	and #$01
rfu_0b8744
	beq rfu_0b8775
rfu_0b8746
	a16
rfu_0b8748
	lda.w race_regbytes
rfu_0b874b
	sec
rfu_0b874c
	sbc #$0004
rfu_0b874f
	bmi rfu_0b8768
rfu_0b8751
	tax
rfu_0b8752
	lda.l race_regqueue,x
rfu_0b8756
	tay
rfu_0b8757
	lda.l race_regqueue+2,x
rfu_0b875b
	a8
rfu_0b875d
	sta.w $0000,y
rfu_0b8760
	a16
rfu_0b8762
	dex
rfu_0b8763
	dex
rfu_0b8764
	dex
rfu_0b8765
	dex
rfu_0b8766
	bpl rfu_0b8752
rfu_0b8768
	stz.w race_regbytes
rfu_0b876b
	a8
rfu_0b876d
	lda.w race_displayrequests
rfu_0b8770
	and #$fe
rfu_0b8772
	sta.w race_displayrequests
rfu_0b8775
	plp
rfu_0b8776
	rts
	longa
	longi
rfb_flushgraphics
	php
rfu_0b8778
	a8
rfu_0b877a
	i16
rfu_0b877c
	lda.w race_displayrequests
rfu_0b877f
	and #$02
rfu_0b8781
	beq rfu_0b87da
rfu_0b8783
	lda #$80
rfu_0b8785
	sta.w $2115
rfu_0b8788
	lda #$18
rfu_0b878a
	sta.w $4301
rfu_0b878d
	a16
rfu_0b878f
	lda.w race_transferused
rfu_0b8792
	sec
rfu_0b8793
	sbc #$0008
rfu_0b8796
	bmi rfu_0b87cb
rfu_0b8798
	tax
rfu_0b8799
	a16
rfu_0b879b
	lda.l race_transferqueue,x
rfu_0b879f
	sta.w $4302
rfu_0b87a2
	lda.l race_transferqueue+3,x
rfu_0b87a6
	sta.w $2116
rfu_0b87a9
	lda.l race_transferqueue+5,x
rfu_0b87ad
	sta.w $4305
rfu_0b87b0
	a8
rfu_0b87b2
	lda.l race_transferqueue+2,x
rfu_0b87b6
	sta.w $4304
rfu_0b87b9
	lda #$01
rfu_0b87bb
	sta.w $4300
rfu_0b87be
	sta.w $420b
rfu_0b87c1
	a16
rfu_0b87c3
	txa
rfu_0b87c4
	sec
rfu_0b87c5
	sbc #$0008
rfu_0b87c8
	tax
rfu_0b87c9
	bpl rfu_0b8799
rfu_0b87cb
	a16
rfu_0b87cd
	stz.w race_transferused
rfu_0b87d0
	a8
rfu_0b87d2
	lda.w race_displayrequests
rfu_0b87d5
	and #$fd
rfu_0b87d7
	sta.w race_displayrequests
rfu_0b87da
	plp
rfu_0b87db
	rts
	longa
	longi
rfb_stepbrightness
	php
rfu_0b87dd
	a8
rfu_0b87df
	lda.w race_fronttoggle
rfu_0b87e2
	inc a
rfu_0b87e3
	and #$01
rfu_0b87e5
	sta.w race_fronttoggle
rfu_0b87e8
	bne rfu_0b8805
rfu_0b87ea
	lda.w race_frontbright
rfu_0b87ed
	cmp.w race_fronttarget
rfu_0b87f0
	beq rfu_0b8805
rfu_0b87f2
	bcs rfu_0b87fe
rfu_0b87f4
	lda.w race_frontbright
rfu_0b87f7
	inc a
rfu_0b87f8
	sta.w race_frontbright
rfu_0b87fb
	jmp rfu_0b8805
rfu_0b87fe
	lda.w race_frontbright
rfu_0b8801
	dec a
rfu_0b8802
	sta.w race_frontbright
rfu_0b8805
	plp
rfu_0b8806
	rts
	longa
	longi
retail_queuegraphics_l
	php
rfu_0b8808
	phx
rfu_0b8809
	ai16
rfu_0b880b
	ldx.w race_transferused
rfu_0b880e
	cpx #$0200
rfu_0b8811
	beq rfu_0b883b
rfu_0b8813
	lda.w race_transfersource
rfu_0b8816
	sta.l race_transferqueue,x
rfu_0b881a
	a8
rfu_0b881c
	lda.w race_transferbank
rfu_0b881f
	sta.l race_transferqueue+2,x
rfu_0b8823
	a16
rfu_0b8825
	lda.w race_transferdest
rfu_0b8828
	sta.l race_transferqueue+3,x
rfu_0b882c
	lda.w race_transferbytes
rfu_0b882f
	sta.l race_transferqueue+5,x
rfu_0b8833
	txa
rfu_0b8834
	clc
rfu_0b8835
	adc #$0008
rfu_0b8838
	sta.w race_transferused
rfu_0b883b
	plx
rfu_0b883c
	plp
rfu_0b883d
	rtl
	longa
	longi
rfb_resetscroll
	php
rfu_0bf4b3
	ai8
rfu_0bf4b5
	stz.w $210d
rfu_0bf4b8
	stz.w $210d
rfu_0bf4bb
	stz.w $210f
rfu_0bf4be
	stz.w $210f
rfu_0bf4c1
	stz.w $2111
rfu_0bf4c4
	stz.w $2111
rfu_0bf4c7
	stz.w $210e
rfu_0bf4ca
	stz.w $210e
rfu_0bf4cd
	stz.w $2110
rfu_0bf4d0
	stz.w $2110
rfu_0bf4d3
	stz.w $2112
rfu_0bf4d6
	stz.w $2112
rfu_0bf4d9
	plp
rfu_0bf4da
	rts
	longa
	longi
rfb_loadpalette
	php
rfu_0bf4dc
	ai16
rfu_0bf4de
	ldx #$0000
rfu_0bf4e1
	ldy #$0000
rfu_0bf4e4
	lda [tempaddrl],y
rfu_0bf4e6
	sta.l race_palshadow,x
rfu_0bf4ea
	iny
rfu_0bf4eb
	iny
rfu_0bf4ec
	inx
rfu_0bf4ed
	inx
rfu_0bf4ee
	cpx #$0200
rfu_0bf4f1
	bne rfu_0bf4e4
rfu_0bf4f3
	plp
rfu_0bf4f4
	rts
	longa
	longi
rfb_savepalette
	php
rfu_0bf4f6
	ai16
rfu_0bf4f8
	ldx #$0000
rfu_0bf4fb
	lda.l race_palshadow,x
rfu_0bf4ff
	sta.l race_palfadebase,x
rfu_0bf503
	inx
rfu_0bf504
	inx
rfu_0bf505
	cpx #$0200
rfu_0bf508
	bne rfu_0bf4fb
rfu_0bf50a
	plp
rfu_0bf50b
	rts
	longa
	longi
rfb_frontbounds0
	php
rfu_0bf50d
	a8
rfu_0bf50f
	i16
rfu_0bf511
	lda #$00
rfu_0bf513
	sta.w $4370
rfu_0bf516
	lda #$2c
rfu_0bf518
	sta.w $4371
rfu_0bf51b
	ldx #(race_fronttables+64)&WM
rfu_0bf51e
	stx.w $4372
rfu_0bf521
	lda #$7f
rfu_0bf523
	sta.w $4374
rfu_0bf526
	lda #$01
rfu_0bf528
	sta.w $4360
rfu_0bf52b
	lda #$26
rfu_0bf52d
	sta.w $4361
rfu_0bf530
	ldx #(race_fronttables+79)&WM
rfu_0bf533
	stx.w $4362
rfu_0bf536
	lda #$7f
rfu_0bf538
	sta.w $4364
rfu_0bf53b
	lda #$00
rfu_0bf53d
	sta.w $4350
rfu_0bf540
	lda #$2c
rfu_0bf542
	sta.w $4351
rfu_0bf545
	ldx #(race_fronttables+69)&WM
rfu_0bf548
	stx.w $4352
rfu_0bf54b
	lda #$7f
rfu_0bf54d
	sta.w $4354
rfu_0bf550
	lda #$00
rfu_0bf552
	sta.w $4340
rfu_0bf555
	lda #$2c
rfu_0bf557
	sta.w $4341
rfu_0bf55a
	ldx #(race_fronttables+74)&WM
rfu_0bf55d
	stx.w $4342
rfu_0bf560
	lda #$7f
rfu_0bf562
	sta.w $4344
rfu_0bf565
	plp
rfu_0bf566
	rts
	longa
	longi
rfb_frontbounds1
	php
rfu_0bf568
	a8
rfu_0bf56a
	i16
rfu_0bf56c
	lda #$02
rfu_0bf56e
	sta.w $4370
rfu_0bf571
	lda #$0f
rfu_0bf573
	sta.w $4371
rfu_0bf576
	ldx #(race_fronttables+0)&WM
rfu_0bf579
	stx.w $4372
rfu_0bf57c
	lda #$7f
rfu_0bf57e
	sta.w $4374
rfu_0bf581
	lda #$42
rfu_0bf583
	sta.w $4360
rfu_0bf586
	lda #$10
rfu_0bf588
	sta.w $4361
rfu_0bf58b
	ldx #(race_fronttables+13)&WM
rfu_0bf58e
	stx.w $4362
rfu_0bf591
	lda #$7f
rfu_0bf593
	sta.w $4364
rfu_0bf596
	lda #$00
rfu_0bf598
	sta.w $4367
rfu_0bf59b
	lda #$00
rfu_0bf59d
	sta.w $4350
rfu_0bf5a0
	lda #$2c
rfu_0bf5a2
	sta.w $4351
rfu_0bf5a5
	ldx #(race_fronttables+29)&WM
rfu_0bf5a8
	stx.w $4352
rfu_0bf5ab
	lda #$7f
rfu_0bf5ad
	sta.w $4354
rfu_0bf5b0
	lda #$00
rfu_0bf5b2
	sta.w $4340
rfu_0bf5b5
	lda #$27
rfu_0bf5b7
	sta.w $4341
rfu_0bf5ba
	ldx #(race_fronttables+40)&WM
rfu_0bf5bd
	stx.w $4342
rfu_0bf5c0
	lda #$7f
rfu_0bf5c2
	sta.w $4344
rfu_0bf5c5
	lda #$00
rfu_0bf5c7
	sta.w $4330
rfu_0bf5ca
	lda #$27
rfu_0bf5cc
	sta.w $4331
rfu_0bf5cf
	ldx #(race_fronttables+51)&WM
rfu_0bf5d2
	stx.w $4332
rfu_0bf5d5
	lda #$7f
rfu_0bf5d7
	sta.w $4334
rfu_0bf5da
	lda #$00
rfu_0bf5dc
	sta.l race_fronttables+56
rfu_0bf5e0
	sta.l race_fronttables+58
rfu_0bf5e4
	plp
rfu_0bf5e5
	rts
	longa
	longi
rfb_frontbounds2
	php
rfu_0bf5e7
	a8
rfu_0bf5e9
	i16
rfu_0bf5eb
	lda #$42
rfu_0bf5ed
	sta.w $4370
rfu_0bf5f0
	lda #$0f
rfu_0bf5f2
	sta.w $4371
rfu_0bf5f5
	ldx #(race_fronttables+101)&WM
rfu_0bf5f8
	stx.w $4372
rfu_0bf5fb
	lda #$7f
rfu_0bf5fd
	sta.w $4374
rfu_0bf600
	lda #$00
rfu_0bf602
	sta.w $4377
rfu_0bf605
	lda #$00
rfu_0bf607
	sta.w $4360
rfu_0bf60a
	lda #$30
rfu_0bf60c
	sta.w $4361
rfu_0bf60f
	ldx #(race_fronttables+108)&WM
rfu_0bf612
	stx.w $4362
rfu_0bf615
	lda #$7f
rfu_0bf617
	sta.w $4364
rfu_0bf61a
	lda #$00
rfu_0bf61c
	sta.w $4350
rfu_0bf61f
	lda #$2e
rfu_0bf621
	sta.w $4351
rfu_0bf624
	ldx #(race_fronttables+115)&WM
rfu_0bf627
	stx.w $4352
rfu_0bf62a
	lda #$7f
rfu_0bf62c
	sta.w $4354
rfu_0bf62f
	lda #$00
rfu_0bf631
	sta.w $4340
rfu_0bf634
	lda #$26
rfu_0bf636
	sta.w $4341
rfu_0bf639
	ldx #(race_fronttables+126)&WM
rfu_0bf63c
	stx.w $4342
rfu_0bf63f
	lda #$7f
rfu_0bf641
	sta.w $4344
rfu_0bf644
	lda #$ff
rfu_0bf646
	sta.l race_fronttables+127
rfu_0bf64a
	a16
rfu_0bf64c
	lda #$0000
rfu_0bf64f
	sta.l race_frontscroll0
rfu_0bf653
	sta.l race_frontscroll2
rfu_0bf657
	lda #$00a8
rfu_0bf65a
	sta.l race_frontscroll1
rfu_0bf65e
	sta.l race_frontscroll3
rfu_0bf662
	plp
rfu_0bf663
	rts
	longa
	longi
rfb_clearvram
	ai16
rfu_0bf666
	ldx #$0000
rfu_0bf669
	ldy #$0000
rfu_0bf66c
	sty.w $2116
rfu_0bf66f
	sty.w $2118
rfu_0bf672
	dex
rfu_0bf673
	dex
rfu_0bf674
	bne rfu_0bf66f
rfu_0bf676
	rts
retail_stagebitmap_l
	jsr rfb_stagebitmap
	rtl
retail_bitmapchunk_l
	jsr rfb_bitmapchunk
	rtl
retail_frontwindow_l
	jsr rfb_frontwindow
	rtl
retail_publishoam_l
	jsr rfb_publishoam
	rtl
retail_publishpalette_l
	jsr rfb_publishpalette
	rtl
retail_flushregisters_l
	jsr rfb_flushregisters
	rtl
retail_flushgraphics_l
	jsr rfb_flushgraphics
	rtl
retail_stepbrightness_l
	jsr rfb_stepbrightness
	rtl
retail_resetfrontscroll_l
	jsr rfb_resetscroll
	rtl
retail_loadfrontpalette_l
	jsr rfb_loadpalette
	rtl
retail_savefrontpalette_l
	jsr rfb_savepalette
	rtl
retail_frontbounds0_l
	jsr rfb_frontbounds0
	rtl
retail_frontbounds1_l
	jsr rfb_frontbounds1
	rtl
retail_frontbounds2_l
	jsr rfb_frontbounds2
	rtl
retail_clearfrontvram_l
	jsr rfb_clearvram
	rtl
rfb_stages
	dw rfu_0b8017&WM
	dw rfu_0b802d&WM
	dw rfu_0b8043&WM
	dw rfu_0b806d&WM
	dw rfu_0b8071&WM
	dw rfu_0b8087&WM
	dw rfu_0b809d&WM
mrblank_end
