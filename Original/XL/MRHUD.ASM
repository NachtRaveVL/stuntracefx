; Retail bitmap text, numeric output and diagnostic displays.
; Entry names reconstructed. Early DRAW interfaces remain available.
; printpt/drawmap select caller-owned GSU bitmap storage, not heap objects.
; Font indices 0..63 encode printable ASCII $20..$5F; text folds lowercase.
; DB is preserved by the long output wrappers. Local glyph helpers require
; DB=retail_textfont>>16; caller-owned buffers and valid pointers are required.
; Profiling counters, frame/chip/memory-test diagnostics are caller supplied
; until their retail scheduler and hardware-test producers are restored.
	incpublics	mrhud.ext
mrhud_begin
	shorta
	longi
retail_printtext_l
	phb
rdh_03d466
	php
rdh_03d467
	ai16
rdh_03d469
	pha
rdh_03d46a
	phx
rdh_03d46b
	phy
rdh_03d46c
	stz.w hilite
rdh_03d46f
	a8
rdh_03d471
	i16
rdh_03d473
	lda #retail_textfont>>16
rdh_03d475
	pha
rdh_03d476
	plb
rdh_03d477
	ldy #$0000
rdh_03d47a
	lda [textpt],y
rdh_03d47c
	beq rdh_03d491
rdh_03d47e
	phy
rdh_03d47f
	cmp #$61
rdh_03d481
	bcc rdh_03d486
rdh_03d483
	sec
rdh_03d484
	sbc #$20
rdh_03d486
	sec
rdh_03d487
	sbc #$20
rdh_03d489
	jsr rdh_printchar
rdh_03d48c
	ply
rdh_03d48d
	iny
rdh_03d48e
	jmp rdh_03d47a
rdh_03d491
	ai16
rdh_03d493
	ply
rdh_03d494
	plx
rdh_03d495
	pla
rdh_03d496
	plp
rdh_03d497
	plb
rdh_03d498
	rtl
	longa
	longi
retail_printword_l
	pha
rdh_03d49a
	xba
rdh_03d49b
	jsl retail_printhexbyte_l
rdh_03d49f
	xba
rdh_03d4a0
	jsl retail_printhexbyte_l
rdh_03d4a4
	pla
rdh_03d4a5
	rtl
	shorta
	longi
retail_printdecimalbyte_l
	phb
rdh_03d4a7
	pha
rdh_03d4a8
	phx
rdh_03d4a9
	phy
rdh_03d4aa
	php
rdh_03d4ab
	a8
rdh_03d4ad
	i16
rdh_03d4af
	sta.w printbtemp
rdh_03d4b2
	lda #retail_textfont>>16
rdh_03d4b4
	pha
rdh_03d4b5
	plb
rdh_03d4b6
	lda.w printbtemp
rdh_03d4b9
	jsr rdh_decimalbyte
rdh_03d4bc
	plp
rdh_03d4bd
	ply
rdh_03d4be
	plx
rdh_03d4bf
	pla
rdh_03d4c0
	plb
rdh_03d4c1
	rtl
	shorta
	longi
retail_printsignedbyte_l
	phb
rdh_03d4c3
	pha
rdh_03d4c4
	phx
rdh_03d4c5
	phy
rdh_03d4c6
	php
rdh_03d4c7
	a8
rdh_03d4c9
	i16
rdh_03d4cb
	sta.w printbtemp
rdh_03d4ce
	lda #retail_textfont>>16
rdh_03d4d0
	pha
rdh_03d4d1
	plb
rdh_03d4d2
	lda.w printbtemp
rdh_03d4d5
	jsr rdh_signedbyte
rdh_03d4d8
	plp
rdh_03d4d9
	ply
rdh_03d4da
	plx
rdh_03d4db
	pla
rdh_03d4dc
	plb
rdh_03d4dd
	rtl
	shorta
	longi
retail_printhexbyte_l
	phb
rdh_03d4df
	pha
rdh_03d4e0
	phx
rdh_03d4e1
	phy
rdh_03d4e2
	php
rdh_03d4e3
	a8
rdh_03d4e5
	i16
rdh_03d4e7
	sta.w printbtemp
rdh_03d4ea
	lda #retail_textfont>>16
rdh_03d4ec
	pha
rdh_03d4ed
	plb
rdh_03d4ee
	lda.w printbtemp
rdh_03d4f1
	jsr rdh_hexbyte
rdh_03d4f4
	plp
rdh_03d4f5
	ply
rdh_03d4f6
	plx
rdh_03d4f7
	pla
rdh_03d4f8
	plb
rdh_03d4f9
	rtl
	longa
	longi
retail_printsignedword_l
	php
rdh_03d4fb
	phb
rdh_03d4fc
	ai16
rdh_03d4fe
	phx
rdh_03d4ff
	phy
rdh_03d500
	pha
rdh_03d501
	sta tpz
rdh_03d503
	a8
rdh_03d505
	lda #retail_textfont>>16
rdh_03d507
	pha
rdh_03d508
	plb
rdh_03d509
	a16
rdh_03d50b
	lda tpz
rdh_03d50d
	bpl rdh_03d51e
rdh_03d50f
	eor #$ffff
rdh_03d512
	inc a
rdh_03d513
	sta tpz
rdh_03d515
	a8
rdh_03d517
	i16
rdh_03d519
	lda #$0d
rdh_03d51b
	jsr rdh_printchar
rdh_03d51e
	a16
rdh_03d520
	ldx #$0000
rdh_03d523
	stz tpx
rdh_03d525
	ldy #$0000
rdh_03d528
	lda tpz
rdh_03d52a
	sec
rdh_03d52b
	sbc.l retail_decimalpowers,x
rdh_03d52f
	bpl rdh_03d574
rdh_03d531
	clc
rdh_03d532
	adc.l retail_decimalpowers,x
rdh_03d536
	sta tpz
rdh_03d538
	lda tpx
rdh_03d53a
	cmp #$0000
rdh_03d53d
	bne rdh_03d544
rdh_03d53f
	cpy #$0000
rdh_03d542
	beq rdh_03d555
rdh_03d544
	ldy #$0001
rdh_03d547
	a8
rdh_03d549
	phx
rdh_03d54a
	phy
rdh_03d54b
	lda tpx
rdh_03d54d
	clc
rdh_03d54e
	adc #$10
rdh_03d550
	jsr rdh_printchar
rdh_03d553
	ply
rdh_03d554
	plx
rdh_03d555
	a16
rdh_03d557
	stz tpx
rdh_03d559
	inx
rdh_03d55a
	inx
rdh_03d55b
	cpx #$000a
rdh_03d55e
	bne rdh_03d528
rdh_03d560
	cpy #$0000
rdh_03d563
	bne rdh_03d56e
rdh_03d565
	a8
rdh_03d567
	lda #$10
rdh_03d569
	jsr rdh_printchar
rdh_03d56c
	a16
rdh_03d56e
	pla
rdh_03d56f
	ply
rdh_03d570
	plx
rdh_03d571
	plb
rdh_03d572
	plp
rdh_03d573
	rtl
rdh_03d574
	sta tpz
rdh_03d576
	inc tpx
rdh_03d578
	bra rdh_03d528
	shorta
	longi
rdh_signedbyte
	pha
rdh_03d585
	cmp #$00
rdh_03d587
	bpl rdh_03d595
rdh_03d589
	lda #$24
rdh_03d58b
	jsr rdh_printchar
rdh_03d58e
	pla
rdh_03d58f
	eor #$ff
rdh_03d591
	inc a
rdh_03d592
	jmp rdh_decimalbyte
rdh_03d595
	lda #$29
rdh_03d597
	jsr rdh_printchar
rdh_03d59a
	pla
rdh_03d59b
	jmp rdh_decimalbyte
	shorta
	longi
rdh_decimalbyte
	cmp #$c8
rdh_03d5a0
	bcc rdh_03d5aa
rdh_03d5a2
	sec
rdh_03d5a3
	sbc #$c8
rdh_03d5a5
	pha
rdh_03d5a6
	lda #$02
rdh_03d5a8
	bra rdh_03d5b9
rdh_03d5aa
	cmp #$64
rdh_03d5ac
	bcc rdh_03d5b6
rdh_03d5ae
	sec
rdh_03d5af
	sbc #$64
rdh_03d5b1
	pha
rdh_03d5b2
	lda #$01
rdh_03d5b4
	bra rdh_03d5b9
rdh_03d5b6
	pha
rdh_03d5b7
	lda #$ff
rdh_03d5b9
	pha
rdh_03d5ba
	cmp #$ff
rdh_03d5bc
	beq rdh_03d5c1
rdh_03d5be
	jsr rdh_printchar
rdh_03d5c1
	pla
rdh_03d5c2
	a16
rdh_03d5c4
	and #$00ff
rdh_03d5c7
	tay
rdh_03d5c8
	a8
rdh_03d5ca
	pla
rdh_03d5cb
	a16
rdh_03d5cd
	and #$00ff
rdh_03d5d0
	tax
rdh_03d5d1
	a8
rdh_03d5d3
	lda.l retail_packeddecimal,x
rdh_03d5d7
	pha
rdh_03d5d8
	lsr a
rdh_03d5d9
	lsr a
rdh_03d5da
	lsr a
rdh_03d5db
	lsr a
rdh_03d5dc
	bne rdh_03d5e3
rdh_03d5de
	cpy #$00ff
rdh_03d5e1
	beq rdh_03d5e6
rdh_03d5e3
	jsr rdh_printchar
rdh_03d5e6
	pla
rdh_03d5e7
	and #$0f
rdh_03d5e9
	jsr rdh_printchar
rdh_03d5ec
	rts
	shorta
	longi
rdh_printchar
	php
rdh_03d652
	ai16
rdh_03d654
	pha
rdh_03d655
	lda printpt
rdh_03d657
	clc
rdh_03d658
	adc drawmap
rdh_03d65a
	tax
rdh_03d65b
	pla
rdh_03d65c
	and #$00ff
rdh_03d65f
	asl a
rdh_03d660
	sta tpy
rdh_03d662
	asl a
rdh_03d663
	clc
rdh_03d664
	adc tpy
rdh_03d666
	tay
rdh_03d667
	lda #$0006
rdh_03d66a
	sta tpy
rdh_03d66c
	phx
rdh_03d66d
	a8
rdh_03d66f
	lda.w hilite
rdh_03d672
	and #$04
rdh_03d674
	beq rdh_03d695
rdh_03d676
	lda.w retail_textfont&WM,y
rdh_03d679
	sta.w race_scratch
rdh_03d67c
	lsr a
rdh_03d67d
	lsr a
rdh_03d67e
	lsr a
rdh_03d67f
	lsr a
rdh_03d680
	sta.w hilite+1
rdh_03d683
	lda.w race_scratch
rdh_03d686
	and #$0f
rdh_03d688
	sta.w race_scratch
rdh_03d68b
	ora.w hilite+1
rdh_03d68e
	eor #$ff
rdh_03d690
	sta.w race_scratch+1
rdh_03d693
	bra rdh_03d6b2
rdh_03d695
	lda.w retail_textfont&WM,y
rdh_03d698
	sta.w race_scratch
rdh_03d69b
	and #$f0
rdh_03d69d
	sta.w hilite+1
rdh_03d6a0
	lda.w race_scratch
rdh_03d6a3
	asl a
rdh_03d6a4
	asl a
rdh_03d6a5
	asl a
rdh_03d6a6
	asl a
rdh_03d6a7
	sta.w race_scratch
rdh_03d6aa
	ora.w hilite+1
rdh_03d6ad
	eor #$ff
rdh_03d6af
	sta.w race_scratch+1
rdh_03d6b2
	lda.w hilite
rdh_03d6b5
	and #$04
rdh_03d6b7
	bne rdh_03d6dd
rdh_03d6b9
	lda #$ff
rdh_03d6bb
	sta.l $700000,x
rdh_03d6bf
	sta.l $700001,x
rdh_03d6c3
	sta.l $700010,x
rdh_03d6c7
	sta.l $700011,x
rdh_03d6cb
	sta.l $700020,x
rdh_03d6cf
	lda #$00
rdh_03d6d1
	sta.l $700021,x
rdh_03d6d5
	sta.l $700030,x
rdh_03d6d9
	sta.l $700031,x
rdh_03d6dd
	lda.l $700000,x
rdh_03d6e1
	and.w race_scratch+1
rdh_03d6e4
	ora.w race_scratch
rdh_03d6e7
	sta.l $700000,x
rdh_03d6eb
	lda.l $700001,x
rdh_03d6ef
	and.w race_scratch+1
rdh_03d6f2
	ora.w race_scratch
rdh_03d6f5
	ora.w hilite+1
rdh_03d6f8
	sta.l $700001,x
rdh_03d6fc
	lda.l $700010,x
rdh_03d700
	and.w race_scratch+1
rdh_03d703
	ora.w race_scratch
rdh_03d706
	ora.w hilite+1
rdh_03d709
	sta.l $700010,x
rdh_03d70d
	lda.l $700011,x
rdh_03d711
	and.w race_scratch+1
rdh_03d714
	ora.w race_scratch
rdh_03d717
	ora.w hilite+1
rdh_03d71a
	sta.l $700011,x
rdh_03d71e
	lda.l $700020,x
rdh_03d722
	and.w race_scratch+1
rdh_03d725
	ora.w race_scratch
rdh_03d728
	ora.w hilite+1
rdh_03d72b
	sta.l $700020,x
rdh_03d72f
	lda.l $700021,x
rdh_03d733
	and.w race_scratch+1
rdh_03d736
	sta.l $700021,x
rdh_03d73a
	lda.l $700030,x
rdh_03d73e
	and.w race_scratch+1
rdh_03d741
	sta.l $700030,x
rdh_03d745
	lda.l $700031,x
rdh_03d749
	and.w race_scratch+1
rdh_03d74c
	sta.l $700031,x
rdh_03d750
	a16
rdh_03d752
	inx
rdh_03d753
	inx
rdh_03d754
	iny
rdh_03d755
	dec tpy
rdh_03d757
	beq rdh_03d75c
rdh_03d759
	brl rdh_03d66d
rdh_03d75c
	pla
rdh_03d75d
	sec
rdh_03d75e
	sbc drawmap
rdh_03d760
	pha
rdh_03d761
	lda.w hilite
rdh_03d764
	eor #$0004
rdh_03d767
	sta.w hilite
rdh_03d76a
	bne rdh_03d77d
rdh_03d76c
	pla
rdh_03d76d
	clc
rdh_03d76e
	adc #$0400
rdh_03d771
	tax
rdh_03d772
	cmp #$6800
rdh_03d775
	bcc rdh_03d77e
rdh_03d777
	sec
rdh_03d778
	sbc #$67c0
rdh_03d77b
	bra rdh_03d77e
rdh_03d77d
	pla
rdh_03d77e
	sta printpt
rdh_03d780
	plp
rdh_03d781
	rts
	shorta
	longi
rdh_hexbyte
	php
rdh_03d783
	ai16
rdh_03d785
	pha
rdh_03d786
	and #$00f0
rdh_03d789
	lsr a
rdh_03d78a
	lsr a
rdh_03d78b
	lsr a
rdh_03d78c
	lsr a
rdh_03d78d
	tax
rdh_03d78e
	lda.l retail_hexdigits,x
rdh_03d792
	and #$00ff
rdh_03d795
	sec
rdh_03d796
	sbc #$0020
rdh_03d799
	jsr rdh_printchar
rdh_03d79c
	pla
rdh_03d79d
	and #$000f
rdh_03d7a0
	tax
rdh_03d7a1
	lda.l retail_hexdigits,x
rdh_03d7a5
	and #$00ff
rdh_03d7a8
	sec
rdh_03d7a9
	sbc #$0020
rdh_03d7ac
	jsr rdh_printchar
rdh_03d7af
	plp
rdh_03d7b0
	rts
	shorta
	longi
retail_printbinary_l
	php
	phb
rdh_03d7c2
	ai8
rdh_03d7c4
	sta tpy
	lda #retail_textfont>>16
	pha
	plb
rdh_03d7c6
	lda #$00
rdh_03d7c8
	lsr tpy
rdh_03d7ca
	php
rdh_03d7cb
	lsr tpy
rdh_03d7cd
	rol a
rdh_03d7ce
	asl a
rdh_03d7cf
	asl a
rdh_03d7d0
	asl a
rdh_03d7d1
	plp
rdh_03d7d2
	rol a
rdh_03d7d3
	pha
rdh_03d7d4
	lda #$00
rdh_03d7d6
	lsr tpy
rdh_03d7d8
	php
rdh_03d7d9
	lsr tpy
rdh_03d7db
	rol a
rdh_03d7dc
	asl a
rdh_03d7dd
	asl a
rdh_03d7de
	asl a
rdh_03d7df
	plp
rdh_03d7e0
	rol a
rdh_03d7e1
	pha
rdh_03d7e2
	lda #$00
rdh_03d7e4
	lsr tpy
rdh_03d7e6
	php
rdh_03d7e7
	lsr tpy
rdh_03d7e9
	rol a
rdh_03d7ea
	asl a
rdh_03d7eb
	asl a
rdh_03d7ec
	asl a
rdh_03d7ed
	plp
rdh_03d7ee
	rol a
rdh_03d7ef
	pha
rdh_03d7f0
	lda #$00
rdh_03d7f2
	lsr tpy
rdh_03d7f4
	php
rdh_03d7f5
	lsr tpy
rdh_03d7f7
	rol a
rdh_03d7f8
	asl a
rdh_03d7f9
	asl a
rdh_03d7fa
	asl a
rdh_03d7fb
	plp
rdh_03d7fc
	rol a
rdh_03d7fd
	pha
rdh_03d7fe
	pla
rdh_03d7ff
	jsr rdh_hexbyte
rdh_03d802
	pla
rdh_03d803
	jsr rdh_hexbyte
rdh_03d806
	pla
rdh_03d807
	jsr rdh_hexbyte
rdh_03d80a
	pla
rdh_03d80b
	jsr rdh_hexbyte
rdh_03d80e
	plb
	plp
rdh_03d80f
	rtl
	shorta
	longi
retail_printtimings_l
	a8
rdh_08f10f
	i16
rdh_08f111
	lda #$00
rdh_08f113
	sta printpt
rdh_08f115
	lda #$00
rdh_08f117
	sta printpt+1
rdh_08f119
	lda #$00
rdh_08f11b
	sta.w hilite
rdh_08f11e
	a8
rdh_08f120
	lda #retail_timinglabels>>16
rdh_08f122
	sta textpt+2
rdh_08f124
	ldx #$0000
rdh_08f127
	a8
rdh_08f129
	lda.l retail_timinglabels,x
rdh_08f12d
	beq rdh_08f170
rdh_08f12f
	a16
rdh_08f131
	lda printpt
rdh_08f133
	pha
rdh_08f134
	stx textpt
rdh_08f136
	lda #retail_timinglabels&WM
rdh_08f139
	clc
rdh_08f13a
	adc textpt
rdh_08f13c
	sta textpt
rdh_08f13e
	jsl retail_printtext_l
rdh_08f142
	txa
rdh_08f143
	clc
rdh_08f144
	adc #$0009
rdh_08f147
	tax
rdh_08f148
	phx
rdh_08f149
	phb
rdh_08f14a
	a8
rdh_08f14c
	lda.l retail_timinglabels,x
rdh_08f150
	pha
rdh_08f151
	plb
rdh_08f152
	a16
rdh_08f154
	lda.l retail_timinglabels+1,x
rdh_08f158
	tax
rdh_08f159
	lda.w $0000,x
rdh_08f15c
	plb
rdh_08f15d
	jsl retail_printsignedword_l
rdh_08f161
	pla
rdh_08f162
	clc
rdh_08f163
	adc #$0003
rdh_08f166
	tax
rdh_08f167
	pla
rdh_08f168
	clc
rdh_08f169
	adc #$0040
rdh_08f16c
	sta printpt
rdh_08f16e
	bra rdh_08f127
rdh_08f170
	rtl
	longa
	longi
retail_printplayerspeed_l
	ai16
rdh_08f173
	lda.l m_playercar
rdh_08f177
	tax
rdh_08f178
	lda.l $70004a,x
rdh_08f17c
	pha
rdh_08f17d
	lda #$2840
rdh_08f180
	sta printpt
rdh_08f182
	lda #$0000
rdh_08f185
	sta.w hilite
rdh_08f188
	pla
rdh_08f189
	jsl retail_printsignedword_l
rdh_08f18d
	rtl
	longa
	longi
retail_printcarpower_l
	lda.l m_testcar1
rdh_08f192
	tax
rdh_08f193
	lda.l $70006a,x
rdh_08f197
	pha
rdh_08f198
	lda #$0440
rdh_08f19b
	sta printpt
rdh_08f19d
	lda #$0000
rdh_08f1a0
	sta.w hilite
rdh_08f1a3
	pla
rdh_08f1a4
	jsl retail_printsignedword_l
rdh_08f1a8
	rtl
	longa
	longi
retail_printempty_l
	rtl
	longa
	longi
retail_printcarlist_l
	lda.w race_diagword1
rdh_08f1ad
	pha
rdh_08f1ae
	lda #$5040
rdh_08f1b1
	sta printpt
rdh_08f1b3
	lda #$0000
rdh_08f1b6
	sta.w hilite
rdh_08f1b9
	pla
rdh_08f1ba
	jsl retail_printsignedword_l
rdh_08f1be
	lda.w race_diagword2
rdh_08f1c1
	pha
rdh_08f1c2
	lda #$5080
rdh_08f1c5
	sta printpt
rdh_08f1c7
	lda #$0000
rdh_08f1ca
	sta.w hilite
rdh_08f1cd
	pla
rdh_08f1ce
	jsl retail_printsignedword_l
rdh_08f1d2
	lda.l m_avoidcarhead
rdh_08f1d6
	tax
rdh_08f1d7
	lda.l $700088,x
rdh_08f1db
	pha
rdh_08f1dc
	lda #$0440
rdh_08f1df
	sta printpt
rdh_08f1e1
	lda #$0000
rdh_08f1e4
	sta.w hilite
rdh_08f1e7
	pla
rdh_08f1e8
	jsl retail_printsignedword_l
rdh_08f1ec
	lda.l $70007a,x
rdh_08f1f0
	pha
rdh_08f1f1
	lda #$1440
rdh_08f1f4
	sta printpt
rdh_08f1f6
	lda #$0000
rdh_08f1f9
	sta.w hilite
rdh_08f1fc
	pla
rdh_08f1fd
	jsl retail_printsignedword_l
rdh_08f201
	lda.l $700086,x
rdh_08f205
	pha
rdh_08f206
	lda #$2840
rdh_08f209
	sta printpt
rdh_08f20b
	lda #$0000
rdh_08f20e
	sta.w hilite
rdh_08f211
	pla
rdh_08f212
	jsl retail_printsignedword_l
rdh_08f216
	lda.l $700084,x
rdh_08f21a
	pha
rdh_08f21b
	lda #$3c40
rdh_08f21e
	sta printpt
rdh_08f220
	lda #$0000
rdh_08f223
	sta.w hilite
rdh_08f226
	pla
rdh_08f227
	jsl retail_printsignedword_l
rdh_08f22b
	lda.l $700074,x
rdh_08f22f
	tax
rdh_08f230
	lda.l $700088,x
rdh_08f234
	pha
rdh_08f235
	lda #$0480
rdh_08f238
	sta printpt
rdh_08f23a
	lda #$0000
rdh_08f23d
	sta.w hilite
rdh_08f240
	pla
rdh_08f241
	jsl retail_printsignedword_l
rdh_08f245
	lda.l $70007a,x
rdh_08f249
	pha
rdh_08f24a
	lda #$1480
rdh_08f24d
	sta printpt
rdh_08f24f
	lda #$0000
rdh_08f252
	sta.w hilite
rdh_08f255
	pla
rdh_08f256
	jsl retail_printsignedword_l
rdh_08f25a
	lda.l $700086,x
rdh_08f25e
	pha
rdh_08f25f
	lda #$2880
rdh_08f262
	sta printpt
rdh_08f264
	lda #$0000
rdh_08f267
	sta.w hilite
rdh_08f26a
	pla
rdh_08f26b
	jsl retail_printsignedword_l
rdh_08f26f
	lda.l $700084,x
rdh_08f273
	pha
rdh_08f274
	lda #$3c80
rdh_08f277
	sta printpt
rdh_08f279
	lda #$0000
rdh_08f27c
	sta.w hilite
rdh_08f27f
	pla
rdh_08f280
	jsl retail_printsignedword_l
rdh_08f284
	lda.l $700074,x
rdh_08f288
	tax
rdh_08f289
	lda.l $700088,x
rdh_08f28d
	pha
rdh_08f28e
	lda #$04c0
rdh_08f291
	sta printpt
rdh_08f293
	lda #$0000
rdh_08f296
	sta.w hilite
rdh_08f299
	pla
rdh_08f29a
	jsl retail_printsignedword_l
rdh_08f29e
	lda.l $70007a,x
rdh_08f2a2
	pha
rdh_08f2a3
	lda #$14c0
rdh_08f2a6
	sta printpt
rdh_08f2a8
	lda #$0000
rdh_08f2ab
	sta.w hilite
rdh_08f2ae
	pla
rdh_08f2af
	jsl retail_printsignedword_l
rdh_08f2b3
	lda.l $700086,x
rdh_08f2b7
	pha
rdh_08f2b8
	lda #$28c0
rdh_08f2bb
	sta printpt
rdh_08f2bd
	lda #$0000
rdh_08f2c0
	sta.w hilite
rdh_08f2c3
	pla
rdh_08f2c4
	jsl retail_printsignedword_l
rdh_08f2c8
	lda.l $700084,x
rdh_08f2cc
	pha
rdh_08f2cd
	lda #$3cc0
rdh_08f2d0
	sta printpt
rdh_08f2d2
	lda #$0000
rdh_08f2d5
	sta.w hilite
rdh_08f2d8
	pla
rdh_08f2d9
	jsl retail_printsignedword_l
rdh_08f2dd
	lda.l $700074,x
rdh_08f2e1
	tax
rdh_08f2e2
	lda.l $700088,x
rdh_08f2e6
	pha
rdh_08f2e7
	lda #$0500
rdh_08f2ea
	sta printpt
rdh_08f2ec
	lda #$0000
rdh_08f2ef
	sta.w hilite
rdh_08f2f2
	pla
rdh_08f2f3
	jsl retail_printsignedword_l
rdh_08f2f7
	lda.l $70007a,x
rdh_08f2fb
	pha
rdh_08f2fc
	lda #$1500
rdh_08f2ff
	sta printpt
rdh_08f301
	lda #$0000
rdh_08f304
	sta.w hilite
rdh_08f307
	pla
rdh_08f308
	jsl retail_printsignedword_l
rdh_08f30c
	lda.l $700086,x
rdh_08f310
	pha
rdh_08f311
	lda #$2900
rdh_08f314
	sta printpt
rdh_08f316
	lda #$0000
rdh_08f319
	sta.w hilite
rdh_08f31c
	pla
rdh_08f31d
	jsl retail_printsignedword_l
rdh_08f321
	lda.l $700084,x
rdh_08f325
	pha
rdh_08f326
	lda #$3d00
rdh_08f329
	sta printpt
rdh_08f32b
	lda #$0000
rdh_08f32e
	sta.w hilite
rdh_08f331
	pla
rdh_08f332
	jsl retail_printsignedword_l
rdh_08f336
	rtl
	longa
	longi
retail_printdynamics_l
	lda.l m_test1
rdh_08f33b
	pha
rdh_08f33c
	lda #$3980
rdh_08f33f
	sta printpt
rdh_08f341
	lda #$0000
rdh_08f344
	sta.w hilite
rdh_08f347
	pla
rdh_08f348
	jsl retail_printsignedword_l
rdh_08f34c
	lda.l m_test2
rdh_08f350
	pha
rdh_08f351
	lda #$39c0
rdh_08f354
	sta printpt
rdh_08f356
	lda #$0000
rdh_08f359
	sta.w hilite
rdh_08f35c
	pla
rdh_08f35d
	jsl retail_printsignedword_l
rdh_08f361
	rtl
	longa
	longi
retail_printwheelcontacts_l
	lda.l m_testcar1
rdh_08f366
	tax
rdh_08f367
	lda.l $70003e,x
rdh_08f36b
	tax
rdh_08f36c
	pha
rdh_08f36d
	lda #$0840
rdh_08f370
	sta printpt
rdh_08f372
	lda #$0000
rdh_08f375
	sta.w hilite
rdh_08f378
	stz textpt+1
rdh_08f37a
	pla
rdh_08f37b
	phx
rdh_08f37c
	lda.l $700018,x
rdh_08f380
	beq rdh_08f3a8
rdh_08f382
	tax
rdh_08f383
	phx
rdh_08f384
	lda.l $70000c,x
rdh_08f388
	tax
rdh_08f389
	lda.l $700014,x
rdh_08f38d
	clc
rdh_08f38e
	adc #$001c
rdh_08f391
	sta textpt
rdh_08f393
	lda printpt
rdh_08f395
	pha
rdh_08f396
	jsl retail_printtext_l
rdh_08f39a
	pla
rdh_08f39b
	clc
rdh_08f39c
	adc #$0040
rdh_08f39f
	sta printpt
rdh_08f3a1
	plx
rdh_08f3a2
	lda.l $70000e,x
rdh_08f3a6
	bne rdh_08f382
rdh_08f3a8
	plx
rdh_08f3a9
	lda.l $700034,x
rdh_08f3ad
	tax
rdh_08f3ae
	bne rdh_08f37b
rdh_08f3b0
	rtl
	longa
	longi
retail_printwheelflags_l
	a16
rdh_08f3b3
	lda.l m_testcar1
rdh_08f3b7
	tax
rdh_08f3b8
	lda.l $70003e,x
rdh_08f3bc
	tax
rdh_08f3bd
	lda.l $700042,x
rdh_08f3c1
	pha
rdh_08f3c2
	lda #$08c0
rdh_08f3c5
	sta printpt
rdh_08f3c7
	lda #$0000
rdh_08f3ca
	sta.w hilite
rdh_08f3cd
	pla
rdh_08f3ce
	jsl retail_printsignedword_l
rdh_08f3d2
	lda.l $700034,x
rdh_08f3d6
	tax
rdh_08f3d7
	lda.l $700042,x
rdh_08f3db
	pha
rdh_08f3dc
	lda #$0900
rdh_08f3df
	sta printpt
rdh_08f3e1
	lda #$0000
rdh_08f3e4
	sta.w hilite
rdh_08f3e7
	pla
rdh_08f3e8
	jsl retail_printsignedword_l
rdh_08f3ec
	lda.l $700034,x
rdh_08f3f0
	tax
rdh_08f3f1
	lda.l $700042,x
rdh_08f3f5
	pha
rdh_08f3f6
	lda #$0940
rdh_08f3f9
	sta printpt
rdh_08f3fb
	lda #$0000
rdh_08f3fe
	sta.w hilite
rdh_08f401
	pla
rdh_08f402
	jsl retail_printsignedword_l
rdh_08f406
	lda.l $700034,x
rdh_08f40a
	tax
rdh_08f40b
	lda.l $700042,x
rdh_08f40f
	pha
rdh_08f410
	lda #$0980
rdh_08f413
	sta printpt
rdh_08f415
	lda #$0000
rdh_08f418
	sta.w hilite
rdh_08f41b
	pla
rdh_08f41c
	jsl retail_printsignedword_l
rdh_08f420
	lda.l $700034,x
rdh_08f424
	ldx.w race_playeractor
rdh_08f427
	lda.l alx_collobjptr,x
rdh_08f42b
	tax
rdh_08f42c
	lda.l $700080,x
rdh_08f430
	rtl
	longa
	longi
retail_printcarstate_l
	lda.l m_testcar1
rdh_08f435
	tax
rdh_08f436
	lda.l $70004e,x
rdh_08f43a
	pha
rdh_08f43b
	lda #$4900
rdh_08f43e
	sta printpt
rdh_08f440
	lda #$0000
rdh_08f443
	sta.w hilite
rdh_08f446
	pla
rdh_08f447
	jsl retail_printsignedword_l
rdh_08f44b
	lda.l $70004a,x
rdh_08f44f
	pha
rdh_08f450
	lda #$4940
rdh_08f453
	sta printpt
rdh_08f455
	lda #$0000
rdh_08f458
	sta.w hilite
rdh_08f45b
	pla
rdh_08f45c
	jsl retail_printsignedword_l
rdh_08f460
	lda.l $70002e,x
rdh_08f464
	pha
rdh_08f465
	lda #$4980
rdh_08f468
	sta printpt
rdh_08f46a
	lda #$0000
rdh_08f46d
	sta.w hilite
rdh_08f470
	pla
rdh_08f471
	jsl retail_printsignedword_l
rdh_08f475
	lda.l $700030,x
rdh_08f479
	pha
rdh_08f47a
	lda #$49c0
rdh_08f47d
	sta printpt
rdh_08f47f
	lda #$0000
rdh_08f482
	sta.w hilite
rdh_08f485
	pla
rdh_08f486
	jsl retail_printsignedword_l
rdh_08f48a
	lda.l $700032,x
rdh_08f48e
	pha
rdh_08f48f
	lda #$4a00
rdh_08f492
	sta printpt
rdh_08f494
	lda #$0000
rdh_08f497
	sta.w hilite
rdh_08f49a
	pla
rdh_08f49b
	jsl retail_printsignedword_l
rdh_08f49f
	lda.l m_retailruntime1
rdh_08f4a3
	pha
rdh_08f4a4
	lda #$1c40
rdh_08f4a7
	sta printpt
rdh_08f4a9
	lda #$0000
rdh_08f4ac
	sta.w hilite
rdh_08f4af
	pla
rdh_08f4b0
	jsl retail_printsignedword_l
rdh_08f4b4
	lda.l m_retailruntime2
rdh_08f4b8
	pha
rdh_08f4b9
	lda #$1c80
rdh_08f4bc
	sta printpt
rdh_08f4be
	lda #$0000
rdh_08f4c1
	sta.w hilite
rdh_08f4c4
	pla
rdh_08f4c5
	jsl retail_printsignedword_l
rdh_08f4c9
	a8
rdh_08f4cb
	lda.w race_groundheight
rdh_08f4ce
	rtl
	shorta
	longi
retail_printcontactwords_l
	lda.l m_test1
rdh_08f4d3
	pha
rdh_08f4d4
	lda #$40
rdh_08f4d6
	sta printpt
rdh_08f4d8
	lda #$09
rdh_08f4da
	sta printpt+1
rdh_08f4dc
	lda #$00
rdh_08f4de
	sta.w hilite
rdh_08f4e1
	pla
rdh_08f4e2
	jsl retail_printword_l
rdh_08f4e6
	lda.l m_test2
rdh_08f4ea
	pha
rdh_08f4eb
	lda #$80
rdh_08f4ed
	sta printpt
rdh_08f4ef
	lda #$09
rdh_08f4f1
	sta printpt+1
rdh_08f4f3
	lda #$00
rdh_08f4f5
	sta.w hilite
rdh_08f4f8
	pla
rdh_08f4f9
	jsl retail_printword_l
rdh_08f4fd
	lda.l m_retailruntime1
rdh_08f501
	pha
rdh_08f502
	lda #$40
rdh_08f504
	sta printpt
rdh_08f506
	lda #$1d
rdh_08f508
	sta printpt+1
rdh_08f50a
	lda #$00
rdh_08f50c
	sta.w hilite
rdh_08f50f
	pla
rdh_08f510
	jsl retail_printword_l
rdh_08f514
	lda.l m_retailruntime2
rdh_08f518
	pha
rdh_08f519
	lda #$80
rdh_08f51b
	sta printpt
rdh_08f51d
	lda #$1d
rdh_08f51f
	sta printpt+1
rdh_08f521
	lda #$00
rdh_08f523
	sta.w hilite
rdh_08f526
	pla
rdh_08f527
	jsl retail_printword_l
rdh_08f52b
	ldx.w race_playeractor
rdh_08f52e
	lda.l alx_collobjptr,x
rdh_08f532
	tax
rdh_08f533
	lda.l $700046,x
rdh_08f537
	pha
rdh_08f538
	lda #$40
rdh_08f53a
	sta printpt
rdh_08f53c
	lda #$31
rdh_08f53e
	sta printpt+1
rdh_08f540
	lda #$00
rdh_08f542
	sta.w hilite
rdh_08f545
	pla
rdh_08f546
	jsl retail_printword_l
rdh_08f54a
	rtl
	shorta
	longi
retail_printcontactbytes_l
	lda.w race_groundheight
rdh_08f54e
	pha
rdh_08f54f
	lda #$40
rdh_08f551
	sta printpt
rdh_08f553
	lda #$49
rdh_08f555
	sta printpt+1
rdh_08f557
	lda #$00
rdh_08f559
	sta.w hilite
rdh_08f55c
	pla
rdh_08f55d
	jsl retail_printword_l
rdh_08f561
	lda.l m_test2
rdh_08f565
	eor #$ff
rdh_08f567
	inc a
rdh_08f568
	cmp #$80
rdh_08f56a
	ror a
rdh_08f56b
	cmp #$80
rdh_08f56d
	ror a
rdh_08f56e
	cmp #$80
rdh_08f570
	ror a
rdh_08f571
	cmp #$80
rdh_08f573
	ror a
rdh_08f574
	cmp #$80
rdh_08f576
	ror a
rdh_08f577
	pha
rdh_08f578
	lda #$80
rdh_08f57a
	sta printpt
rdh_08f57c
	lda #$49
rdh_08f57e
	sta printpt+1
rdh_08f580
	lda #$00
rdh_08f582
	sta.w hilite
rdh_08f585
	pla
rdh_08f586
	jsl retail_printword_l
rdh_08f58a
	lda.w race_groundindex
rdh_08f58d
	pha
rdh_08f58e
	lda #$c0
rdh_08f590
	sta printpt
rdh_08f592
	lda #$49
rdh_08f594
	sta printpt+1
rdh_08f596
	lda #$00
rdh_08f598
	sta.w hilite
rdh_08f59b
	pla
rdh_08f59c
	jsl retail_printword_l
rdh_08f5a0
	lda.w race_groundheight
rdh_08f5a3
	pha
rdh_08f5a4
	lda #$40
rdh_08f5a6
	sta printpt
rdh_08f5a8
	lda #$09
rdh_08f5aa
	sta printpt+1
rdh_08f5ac
	lda #$00
rdh_08f5ae
	sta.w hilite
rdh_08f5b1
	pla
rdh_08f5b2
	jsl retail_printword_l
rdh_08f5b6
	lda.w race_groundindex
rdh_08f5b9
	pha
rdh_08f5ba
	lda #$80
rdh_08f5bc
	sta printpt
rdh_08f5be
	lda #$09
rdh_08f5c0
	sta printpt+1
rdh_08f5c2
	lda #$00
rdh_08f5c4
	sta.w hilite
rdh_08f5c7
	pla
rdh_08f5c8
	jsl retail_printword_l
rdh_08f5cc
	rtl
	shorta
	longi
retail_printbodybounds_l
	ldx.w race_playeractor
rdh_08f5d0
	lda.l alx_collobjptr,x
rdh_08f5d4
	tax
rdh_08f5d5
	lda.l $700010,x
rdh_08f5d9
	pha
rdh_08f5da
	lda #$c0
rdh_08f5dc
	sta printpt
rdh_08f5de
	lda #$49
rdh_08f5e0
	sta printpt+1
rdh_08f5e2
	lda #$00
rdh_08f5e4
	sta.w hilite
rdh_08f5e7
	pla
rdh_08f5e8
	jsl retail_printword_l
rdh_08f5ec
	lda.l $700058,x
rdh_08f5f0
	pha
rdh_08f5f1
	lda #$80
rdh_08f5f3
	sta printpt
rdh_08f5f5
	lda #$08
rdh_08f5f7
	sta printpt+1
rdh_08f5f9
	lda #$00
rdh_08f5fb
	sta.w hilite
rdh_08f5fe
	pla
rdh_08f5ff
	jsl retail_printword_l
rdh_08f603
	lda.l m_retailruntime1
rdh_08f607
	pha
rdh_08f608
	lda #$00
rdh_08f60a
	sta printpt
rdh_08f60c
	lda #$09
rdh_08f60e
	sta printpt+1
rdh_08f610
	lda #$00
rdh_08f612
	sta.w hilite
rdh_08f615
	pla
rdh_08f616
	jsl retail_printword_l
rdh_08f61a
	rtl
	shorta
	longi
retail_printroadstate_l
	ldx.w race_playeractor
rdh_08f61e
	lda.l alx_collobjptr,x
rdh_08f622
	tax
rdh_08f623
	lda.l $70004a,x
rdh_08f627
	pha
rdh_08f628
	lda #$00
rdh_08f62a
	sta printpt
rdh_08f62c
	lda #$4b
rdh_08f62e
	sta printpt+1
rdh_08f630
	lda #$00
rdh_08f632
	sta.w hilite
rdh_08f635
	pla
rdh_08f636
	jsl retail_printword_l
rdh_08f63a
	lda.l m_retailobjectcount
rdh_08f63e
	pha
rdh_08f63f
	lda #$40
rdh_08f641
	sta printpt
rdh_08f643
	lda #$44
rdh_08f645
	sta printpt+1
rdh_08f647
	lda #$00
rdh_08f649
	sta.w hilite
rdh_08f64c
	pla
rdh_08f64d
	jsl retail_printword_l
rdh_08f651
	lda.w race_savedview
rdh_08f654
	pha
rdh_08f655
	lda #$c0
rdh_08f657
	sta printpt
rdh_08f659
	lda #$44
rdh_08f65b
	sta printpt+1
rdh_08f65d
	lda #$00
rdh_08f65f
	sta.w hilite
rdh_08f662
	pla
rdh_08f663
	jsl retail_printword_l
rdh_08f667
	rtl
	shorta
	longi
retail_printactorcells_l
	a16
rdh_08f66a
	lda.w race_diagturn
rdh_08f66d
	and #$00ff
rdh_08f670
	lsr a
rdh_08f671
	lsr a
rdh_08f672
	lsr a
rdh_08f673
	lsr a
rdh_08f674
	inc a
rdh_08f675
	and #$00fe
rdh_08f678
	pha
rdh_08f679
	lda #$1c40
rdh_08f67c
	sta printpt
rdh_08f67e
	lda #$0000
rdh_08f681
	sta.w hilite
rdh_08f684
	pla
rdh_08f685
	jsl retail_printword_l
rdh_08f689
	lda.l m_retailcontactyaw
rdh_08f68d
	pha
rdh_08f68e
	lda #$3040
rdh_08f691
	sta printpt
rdh_08f693
	lda #$0000
rdh_08f696
	sta.w hilite
rdh_08f699
	pla
rdh_08f69a
	jsl retail_printword_l
rdh_08f69e
	i16
rdh_08f6a0
	ldx.w race_playeractor
rdh_08f6a3
	lda.l alx_mapobjid,x
rdh_08f6a7
	pha
rdh_08f6a8
	lda #$1e80
rdh_08f6ab
	sta printpt
rdh_08f6ad
	lda #$0000
rdh_08f6b0
	sta.w hilite
rdh_08f6b3
	pla
rdh_08f6b4
	jsl retail_printword_l
rdh_08f6b8
	lda.w race_diagcell
rdh_08f6bb
	pha
rdh_08f6bc
	lda #$1ec0
rdh_08f6bf
	sta printpt
rdh_08f6c1
	lda #$0000
rdh_08f6c4
	sta.w hilite
rdh_08f6c7
	pla
rdh_08f6c8
	jsl retail_printword_l
rdh_08f6cc
	ai16
rdh_08f6ce
	ldx.w race_playeractor
rdh_08f6d1
	lda.l alx_mapobjid,x
rdh_08f6d5
	tax
rdh_08f6d6
	lda.l race_cellheads,x
rdh_08f6da
	pha
rdh_08f6db
	lda #$0900
rdh_08f6de
	sta printpt
rdh_08f6e0
	lda #$0000
rdh_08f6e3
	sta.w hilite
rdh_08f6e6
	pla
rdh_08f6e7
	jsl retail_printword_l
rdh_08f6eb
	tax
rdh_08f6ec
	beq rdh_08f74b
rdh_08f6ee
	lda.l alx_mapptr,x
rdh_08f6f2
	pha
rdh_08f6f3
	lda #$1d00
rdh_08f6f6
	sta printpt
rdh_08f6f8
	lda #$0000
rdh_08f6fb
	sta.w hilite
rdh_08f6fe
	pla
rdh_08f6ff
	jsl retail_printword_l
rdh_08f703
	tax
rdh_08f704
	beq rdh_08f74b
rdh_08f706
	lda.l alx_mapptr,x
rdh_08f70a
	pha
rdh_08f70b
	lda #$3100
rdh_08f70e
	sta printpt
rdh_08f710
	lda #$0000
rdh_08f713
	sta.w hilite
rdh_08f716
	pla
rdh_08f717
	jsl retail_printword_l
rdh_08f71b
	tax
rdh_08f71c
	beq rdh_08f74b
rdh_08f71e
	lda.l alx_mapptr,x
rdh_08f722
	pha
rdh_08f723
	lda #$4500
rdh_08f726
	sta printpt
rdh_08f728
	lda #$0000
rdh_08f72b
	sta.w hilite
rdh_08f72e
	pla
rdh_08f72f
	jsl retail_printword_l
rdh_08f733
	tax
rdh_08f734
	beq rdh_08f74b
rdh_08f736
	lda.l alx_mapptr,x
rdh_08f73a
	pha
rdh_08f73b
	lda #$5900
rdh_08f73e
	sta printpt
rdh_08f740
	lda #$0000
rdh_08f743
	sta.w hilite
rdh_08f746
	pla
rdh_08f747
	jsl retail_printword_l
rdh_08f74b
	lda.w race_diagcell
rdh_08f74e
	tax
rdh_08f74f
	lda.l race_cellheads,x
rdh_08f753
	pha
rdh_08f754
	lda #$0940
rdh_08f757
	sta printpt
rdh_08f759
	lda #$0000
rdh_08f75c
	sta.w hilite
rdh_08f75f
	pla
rdh_08f760
	jsl retail_printword_l
rdh_08f764
	tax
rdh_08f765
	beq rdh_08f7c4
rdh_08f767
	lda.l alx_mapptr,x
rdh_08f76b
	pha
rdh_08f76c
	lda #$1d40
rdh_08f76f
	sta printpt
rdh_08f771
	lda #$0000
rdh_08f774
	sta.w hilite
rdh_08f777
	pla
rdh_08f778
	jsl retail_printword_l
rdh_08f77c
	tax
rdh_08f77d
	beq rdh_08f7c4
rdh_08f77f
	lda.l alx_mapptr,x
rdh_08f783
	pha
rdh_08f784
	lda #$3140
rdh_08f787
	sta printpt
rdh_08f789
	lda #$0000
rdh_08f78c
	sta.w hilite
rdh_08f78f
	pla
rdh_08f790
	jsl retail_printword_l
rdh_08f794
	tax
rdh_08f795
	beq rdh_08f7c4
rdh_08f797
	lda.l alx_mapptr,x
rdh_08f79b
	pha
rdh_08f79c
	lda #$4540
rdh_08f79f
	sta printpt
rdh_08f7a1
	lda #$0000
rdh_08f7a4
	sta.w hilite
rdh_08f7a7
	pla
rdh_08f7a8
	jsl retail_printword_l
rdh_08f7ac
	tax
rdh_08f7ad
	beq rdh_08f7c4
rdh_08f7af
	lda.l alx_mapptr,x
rdh_08f7b3
	pha
rdh_08f7b4
	lda #$5940
rdh_08f7b7
	sta printpt
rdh_08f7b9
	lda #$0000
rdh_08f7bc
	sta.w hilite
rdh_08f7bf
	pla
rdh_08f7c0
	jsl retail_printword_l
rdh_08f7c4
	rtl
	longa
	longi
retail_printcarflags_l
	lda.l m_test1
rdh_08f7c9
	pha
rdh_08f7ca
	lda #$4940
rdh_08f7cd
	sta printpt
rdh_08f7cf
	lda #$0000
rdh_08f7d2
	sta.w hilite
rdh_08f7d5
	pla
rdh_08f7d6
	jsl retail_printword_l
rdh_08f7da
	lda.l m_testcar1
rdh_08f7de
	tax
rdh_08f7df
	lda.l $700080,x
rdh_08f7e3
	pha
rdh_08f7e4
	lda #$4a00
rdh_08f7e7
	sta printpt
rdh_08f7e9
	lda #$0000
rdh_08f7ec
	sta.w hilite
rdh_08f7ef
	pla
rdh_08f7f0
	jsl retail_printword_l
rdh_08f7f4
	rtl
	shorta
	longi
retail_printracevalues_l
	a8
rdh_08f7f7
	lda.l race_diagframe
rdh_08f7fb
	pha
rdh_08f7fc
	lda #$40
rdh_08f7fe
	sta printpt
rdh_08f800
	lda #$04
rdh_08f802
	sta printpt+1
rdh_08f804
	lda #$00
rdh_08f806
	sta.w hilite
rdh_08f809
	pla
rdh_08f80a
	jsl retail_printdecimalbyte_l
rdh_08f80e
	a16
rdh_08f810
	lda.w race_diagword1
rdh_08f813
	pha
rdh_08f814
	lda #$0480
rdh_08f817
	sta printpt
rdh_08f819
	lda #$0000
rdh_08f81c
	sta.w hilite
rdh_08f81f
	pla
rdh_08f820
	jsl retail_printword_l
rdh_08f824
	lda.w race_diagword2
rdh_08f827
	pha
rdh_08f828
	lda #$04c0
rdh_08f82b
	sta printpt
rdh_08f82d
	lda #$0000
rdh_08f830
	sta.w hilite
rdh_08f833
	pla
rdh_08f834
	jsl retail_printword_l
rdh_08f838
	i16
rdh_08f83a
	ldx.w race_playeractor
rdh_08f83d
	a8
rdh_08f83f
	lda.l alx_count1,x
rdh_08f843
	pha
rdh_08f844
	lda #$00
rdh_08f846
	sta printpt
rdh_08f848
	lda #$05
rdh_08f84a
	sta printpt+1
rdh_08f84c
	lda #$00
rdh_08f84e
	sta.w hilite
rdh_08f851
	pla
rdh_08f852
	jsl retail_printdecimalbyte_l
rdh_08f856
	lda.l alx_AP,x
rdh_08f85a
	pha
rdh_08f85b
	lda #$40
rdh_08f85d
	sta printpt
rdh_08f85f
	lda #$05
rdh_08f861
	sta printpt+1
rdh_08f863
	lda #$00
rdh_08f865
	sta.w hilite
rdh_08f868
	pla
rdh_08f869
	jsl retail_printdecimalbyte_l
rdh_08f86d
	a16
rdh_08f86f
	lda.l m_testcar1
rdh_08f873
	tax
rdh_08f874
	lda.l $700050,x
rdh_08f878
	pha
rdh_08f879
	lda #$0600
rdh_08f87c
	sta printpt
rdh_08f87e
	lda #$0000
rdh_08f881
	sta.w hilite
rdh_08f884
	pla
rdh_08f885
	jsl retail_printword_l
rdh_08f889
	lda.l $70004e,x
rdh_08f88d
	pha
rdh_08f88e
	lda #$0640
rdh_08f891
	sta printpt
rdh_08f893
	lda #$0000
rdh_08f896
	sta.w hilite
rdh_08f899
	pla
rdh_08f89a
	jsl retail_printword_l
rdh_08f89e
	lda.l $70004a,x
rdh_08f8a2
	pha
rdh_08f8a3
	lda #$0680
rdh_08f8a6
	sta printpt
rdh_08f8a8
	lda #$0000
rdh_08f8ab
	sta.w hilite
rdh_08f8ae
	pla
rdh_08f8af
	jsl retail_printword_l
rdh_08f8b3
	lda.l $70003c,x
rdh_08f8b7
	pha
rdh_08f8b8
	lda #$06c0
rdh_08f8bb
	sta printpt
rdh_08f8bd
	lda #$0000
rdh_08f8c0
	sta.w hilite
rdh_08f8c3
	pla
rdh_08f8c4
	jsl retail_printword_l
rdh_08f8c8
	lda.l $700056,x
rdh_08f8cc
	pha
rdh_08f8cd
	lda #$0700
rdh_08f8d0
	sta printpt
rdh_08f8d2
	lda #$0000
rdh_08f8d5
	sta.w hilite
rdh_08f8d8
	pla
rdh_08f8d9
	jsl retail_printword_l
rdh_08f8dd
	lda.l m_test1
rdh_08f8e1
	pha
rdh_08f8e2
	lda #$0740
rdh_08f8e5
	sta printpt
rdh_08f8e7
	lda #$0000
rdh_08f8ea
	sta.w hilite
rdh_08f8ed
	pla
rdh_08f8ee
	jsl retail_printword_l
rdh_08f8f2
	rtl
	shorta
	longi
retail_printunused_l
	a8
rdh_08f8f5
	rtl
	longa
	longi
retail_printtestword_l
	ai16
rdh_08f8f8
	lda.w race_diagword0
rdh_08f8fb
	lda.l m_test1
rdh_08f8ff
	pha
rdh_08f900
	lda #$5040
rdh_08f903
	sta printpt
rdh_08f905
	lda #$0000
rdh_08f908
	sta.w hilite
rdh_08f90b
	pla
rdh_08f90c
	jsl retail_printword_l
rdh_08f910
	rtl
	longa
	longi
retail_printerrors_l
	a16
rdh_08feb6
	lda.l race_diagoldchip
rdh_08feba
	beq rdh_08fed8
rdh_08febc
	lda #$2240
rdh_08febf
	sta printpt
rdh_08fec1
	lda #$0000
rdh_08fec4
	sta.w hilite
rdh_08fec7
	a8
rdh_08fec9
	lda #retail_errorstring0>>16
rdh_08fecb
	sta textpt+2
rdh_08fecd
	a16
rdh_08fecf
	lda #retail_errorstring0&WM
rdh_08fed2
	sta textpt
rdh_08fed4
	jsl retail_printtext_l
rdh_08fed8
	lda.l race_diagchecksum
rdh_08fedc
	beq rdh_08fefa
rdh_08fede
	lda #$2280
rdh_08fee1
	sta printpt
rdh_08fee3
	lda #$0000
rdh_08fee6
	sta.w hilite
rdh_08fee9
	a8
rdh_08feeb
	lda #retail_errorstring0>>16
rdh_08feed
	sta textpt+2
rdh_08feef
	a16
rdh_08fef1
	lda #retail_errorstring1&WM
rdh_08fef4
	sta textpt
rdh_08fef6
	jsl retail_printtext_l
rdh_08fefa
	lda.l m_retaildefinition
rdh_08fefe
	beq rdh_08ff1c
rdh_08ff00
	lda #$1ac0
rdh_08ff03
	sta printpt
rdh_08ff05
	lda #$0000
rdh_08ff08
	sta.w hilite
rdh_08ff0b
	a8
rdh_08ff0d
	lda #retail_errorstring0>>16
rdh_08ff0f
	sta textpt+2
rdh_08ff11
	a16
rdh_08ff13
	lda #retail_errorstring2&WM
rdh_08ff16
	sta textpt
rdh_08ff18
	jsl retail_printtext_l
rdh_08ff1c
	rtl
retail_decimalpowers
	dw	10000,1000,100,10,1
retail_packeddecimal
	db	$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$10,$11,$12,$13,$14,$15
	db	$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31
	db	$32,$33,$34,$35,$36,$37,$38,$39,$40,$41,$42,$43,$44,$45,$46,$47
	db	$48,$49,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$60,$61,$62,$63
	db	$64,$65,$66,$67,$68,$69,$70,$71,$72,$73,$74,$75,$76,$77,$78,$79
	db	$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$90,$91,$92,$93,$94,$95
	db	$96,$97,$98,$99
retail_hexdigits
	db	"0123456789ABCDEF"
retail_textfont
	db	$00,$00,$00,$00,$00,$00,$40,$42,$42,$02,$40,$02,$a0,$a5,$05,$00
	db	$00,$00,$00,$00,$40,$02,$00,$00,$00,$00,$40,$02,$00,$00,$a0,$25
	db	$41,$82,$a4,$05,$00,$00,$40,$02,$00,$00,$40,$42,$02,$00,$00,$00
	db	$40,$82,$84,$84,$40,$02,$40,$20,$21,$21,$41,$02,$00,$a0,$41,$a0
	db	$05,$00,$00,$40,$e0,$43,$02,$00,$00,$00,$00,$40,$82,$04,$00,$00
	db	$e0,$07,$00,$00,$00,$00,$00,$00,$40,$02,$20,$21,$41,$82,$84,$04
	db	$40,$a0,$a5,$a5,$41,$02,$40,$c2,$42,$42,$e0,$07,$c0,$24,$41,$82
	db	$e0,$07,$c0,$24,$41,$20,$c1,$06,$80,$84,$a4,$e1,$25,$01,$e0,$87
	db	$40,$20,$c1,$06,$80,$81,$e0,$a5,$e1,$02,$e0,$25,$21,$21,$21,$01
	db	$e0,$a0,$e1,$a0,$e1,$02,$e0,$a0,$e1,$21,$21,$01,$00,$40,$02,$40
	db	$02,$00,$00,$40,$02,$40,$82,$04,$20,$41,$82,$40,$20,$01,$00,$e0
	db	$07,$e0,$07,$00,$80,$40,$20,$41,$82,$04,$40,$a0,$25,$41,$02,$40
	db	$00,$40,$a0,$41,$02,$00,$40,$a0,$e1,$a5,$a5,$05,$c0,$a4,$c1,$a4
	db	$c1,$06,$60,$83,$84,$84,$60,$03,$c0,$a4,$a5,$a5,$c1,$06,$e0,$87
	db	$c0,$86,$e0,$07,$e0,$87,$c0,$86,$84,$04,$60,$83,$84,$a4,$61,$03
	db	$a0,$a5,$e1,$a5,$a5,$05,$e0,$43,$42,$42,$e0,$07,$e0,$25,$21,$21
	db	$c1,$06,$a0,$a5,$c1,$a4,$a5,$05,$80,$84,$84,$84,$e0,$07,$a0,$e1
	db	$a5,$a5,$a5,$05,$a0,$e1,$e1,$e1,$a5,$05,$e0,$a5,$a5,$a5,$e1,$07
	db	$c0,$a4,$c1,$86,$84,$04,$40,$a0,$a5,$a5,$61,$12,$c0,$a4,$c1,$a4
	db	$a5,$05,$60,$83,$40,$20,$c1,$06,$e0,$43,$42,$42,$42,$02,$a0,$a5
	db	$a5,$a5,$41,$02,$a0,$a5,$a5,$41,$42,$02,$a0,$a5,$a5,$e1,$a5,$05
	db	$a0,$a5,$41,$a0,$a5,$05,$a0,$a5,$41,$42,$42,$02,$e0,$25,$41,$82
	db	$e0,$07,$60,$43,$42,$42,$60,$03,$80,$84,$40,$20,$21,$01,$c0,$42
	db	$42,$42,$c2,$06,$40,$a0,$05,$00,$00,$00,$00,$00,$00,$00,$f0,$07
retail_timinglabels
	db	"GAME_TM:",0,0
	dw	race_diagtimes+0
	db	"DISP_TM:",0,0
	dw	race_diagtimes+4
	db	"DYN__TM:",0,0
	dw	race_diagtimes+8
	db	"STRA_TM:",0,0
	dw	race_diagtimes+12
	db	"TMP1_TM:",0,0
	dw	race_diagtimes+16
	db	"TMP2_TM:",0,0
	dw	race_diagtimes+20
	db	"TMP3_TM:",0,0
	dw	race_diagtimes+24
	db	0,0
retail_errorstring0
	db	"!!! Old mario chip !!!",0
retail_errorstring1
	db	"! Dynamics checksum fail !",0
retail_errorstring2
	db	"Tried to make car with bad type!",0
mrhud_end
