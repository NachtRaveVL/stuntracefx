; Retail frontend choice, option and audio control services.
; A16/I16, D=0, DB=0 and binary arithmetic. choicecodes/loadchoices retain P.
; Category and vehicle indices are 0..3; three option values are 0..2.
; Resolve the category and three option codes before updating
; labels. Supply menuheld0 from the raw first-player pad snapshot.
; Audio values wrap at 26 and repeat after 13 held-input samples.
; Audio input queues contain at most eight words, consumed newest first;
; initialize forms, entity tags, cloned audio sprites and input state first.
; Saved selections read the caller-loaded 1KiB recordimage. They do not
; publish or persist it. Frontbuffers requires serialized GSU ownership and
; preserves the native alternating strip/palette setup, not frame waiting.
; Option bounds reuse the inherited signed sine table. No active scene,
; interrupt, 3D renderer or main-menu controller is installed here.
	incpublics mrselect.ext
	include sgdata.ext
mrselect_begin
	longa
	longi
rsl_resolvechoices
	jsr rsl_choicecodes
rsl_03b70d
	rtl
rsl_choicecodes
	php
rsl_03b70f
	ai16
rsl_03b711
	lda.l race_menucurrent
rsl_03b715
	asl a
rsl_03b716
	tax
rsl_03b717
	lda.l retail_choiceoffsets,x
rsl_03b71b
	sta.w race_oambits
rsl_03b71e
	lda.l race_menuoptions0
rsl_03b722
	asl a
rsl_03b723
	clc
rsl_03b724
	adc.l race_menuoptions0
rsl_03b728
	sta.w race_oamword
rsl_03b72b
	lda.l race_menuoptions1
rsl_03b72f
	asl a
rsl_03b730
	asl a
rsl_03b731
	asl a
rsl_03b732
	clc
rsl_03b733
	adc.l race_menuoptions1
rsl_03b737
	clc
rsl_03b738
	adc.w race_oamword
rsl_03b73b
	sta.w race_oamword
rsl_03b73e
	lda.l race_menuoptions2
rsl_03b742
	asl a
rsl_03b743
	clc
rsl_03b744
	adc.l race_menuoptions2
rsl_03b748
	sta.w race_spritesleft
rsl_03b74b
	asl a
rsl_03b74c
	asl a
rsl_03b74d
	asl a
rsl_03b74e
	clc
rsl_03b74f
	adc.w race_spritesleft
rsl_03b752
	clc
rsl_03b753
	adc.w race_oamword
rsl_03b756
	clc
rsl_03b757
	adc.w race_oambits
rsl_03b75a
	tax
rsl_03b75b
	lda.l retail_choicecodes,x
rsl_03b75f
	and #$0003
rsl_03b762
	sta.l race_optioncode0
rsl_03b766
	lda.l retail_choicecodes+1,x
rsl_03b76a
	and #$0003
rsl_03b76d
	sta.l race_optioncode1
rsl_03b771
	lda.l retail_choicecodes+2,x
rsl_03b775
	and #$0003
rsl_03b778
	sta.l race_optioncode2
rsl_03b77c
	lda.l race_menucurrent
rsl_03b780
	tax
rsl_03b781
	lda.l retail_categorycodes,x
rsl_03b785
	and #$0003
rsl_03b788
	sta.l race_choicecode
rsl_03b78c
	ldx #$0000
rsl_03b78f
	phx
rsl_03b790
	lda.l race_menucurrent,x
rsl_03b794
	asl a
rsl_03b795
	asl a
rsl_03b796
	clc
rsl_03b797
	adc.l race_choicecode,x
rsl_03b79b
	tax
rsl_03b79c
	lda.l retail_choiceflags,x
rsl_03b7a0
	and #$0003
rsl_03b7a3
	plx
rsl_03b7a4
	sta.l race_menumatch,x
rsl_03b7a8
	inx
rsl_03b7a9
	inx
rsl_03b7aa
	cpx #$0008
rsl_03b7ad
	bne rsl_03b78f
rsl_03b7af
	plp
rsl_03b7b0
	rts
rsl_frontbuffers
	a16
rsl_03b83e
	lda.w race_frontbufferphase
rsl_03b841
	beq rsl_03b872
rsl_03b843
	a16
rsl_03b845
	stz.w race_frontbufferphase
rsl_03b848
	lda #$0008
rsl_03b84b
	sta.w race_bitmapstage
rsl_03b84e
	lda.w race_oamflags
rsl_03b851
	and #$fff7
rsl_03b854
	sta.w $303a
rsl_03b857
	lda #$2c00
rsl_03b85a
	sta.l messagepallet
rsl_03b85e
	sta drawmap
rsl_03b860
	lda.w race_oamflags
rsl_03b863
	ora #$0018
rsl_03b866
	sta.w $303a
rsl_03b869
	a8
rsl_03b86b
	lda #$0b
rsl_03b86d
	sta.l $003038
rsl_03b871
	rts
	longa
rsl_03b872
	a16
rsl_03b874
	inc.w race_frontbufferphase
rsl_03b877
	lda #$0000
rsl_03b87a
	sta.w race_bitmapstage
rsl_03b87d
	lda.w race_oamflags
rsl_03b880
	and #$fff7
rsl_03b883
	sta.w $303a
rsl_03b886
	lda #$2c00
rsl_03b889
	sta.l messagepallet
rsl_03b88d
	sta drawmap
rsl_03b88f
	lda.w race_oamflags
rsl_03b892
	ora #$0018
rsl_03b895
	sta.w $303a
rsl_03b898
	a8
rsl_03b89a
	lda #$0b
rsl_03b89c
	sta.l $003038
rsl_03b8a0
	rts
	longa
rsl_loadchoices
	php
rsl_0bb9c3
	ai16
rsl_0bb9c5
	cmp #$0000
rsl_0bb9c8
	beq rsl_0bb9fc
rsl_0bb9ca
	cmp #$0001
rsl_0bb9cd
	beq rsl_0bba0f
rsl_0bb9cf
	cmp #$0002
rsl_0bb9d2
	beq rsl_0bba26
rsl_0bb9d4
	lda.l race_recordimage+11
rsl_0bb9d8
	and #$00ff
rsl_0bb9db
	cmp #$0000
rsl_0bb9de
	beq rsl_0bb9f3
rsl_0bb9e0
	lda.l race_recordimage+13
rsl_0bb9e4
	and #$0003
rsl_0bb9e7
	asl a
rsl_0bb9e8
	tax
rsl_0bb9e9
	lda.l retail_savedchoices,x
rsl_0bb9ed
	sta.l race_menucurrent
rsl_0bb9f1
	bra rsl_0bba4c
rsl_0bb9f3
	lda #$0001
rsl_0bb9f6
	sta.l race_menucurrent
rsl_0bb9fa
	bra rsl_0bba4c
rsl_0bb9fc
	lda.l race_recordimage+12
rsl_0bba00
	and #$0003
rsl_0bba03
	asl a
rsl_0bba04
	tax
rsl_0bba05
	lda.l retail_savedchoices,x
rsl_0bba09
	sta.l race_menucurrent
rsl_0bba0d
	bra rsl_0bba4c
rsl_0bba0f
	lda.l race_recordimage+12
rsl_0bba13
	and #$0030
rsl_0bba16
	lsr a
rsl_0bba17
	lsr a
rsl_0bba18
	lsr a
rsl_0bba19
	lsr a
rsl_0bba1a
	asl a
rsl_0bba1b
	tax
rsl_0bba1c
	lda.l retail_savedchoices,x
rsl_0bba20
	sta.l race_menucurrent
rsl_0bba24
	bra rsl_0bba4c
rsl_0bba26
	lda.l race_recordimage+14
rsl_0bba2a
	and #$0003
rsl_0bba2d
	asl a
rsl_0bba2e
	tax
rsl_0bba2f
	lda.l retail_savedchoices,x
rsl_0bba33
	sta.l race_menucurrent
rsl_0bba37
	lda.l race_recordimage+14
rsl_0bba3b
	and #$0030
rsl_0bba3e
	lsr a
rsl_0bba3f
	lsr a
rsl_0bba40
	lsr a
rsl_0bba41
	lsr a
rsl_0bba42
	asl a
rsl_0bba43
	tax
rsl_0bba44
	lda.l retail_savedchoices,x
rsl_0bba48
	sta.l race_menuchoice
rsl_0bba4c
	plp
rsl_0bba4d
	rts
rsl_tuneoptions
	lda.w race_menuedges
rsl_0bc04b
	and #$0200
rsl_0bc04e
	beq rsl_0bc068
rsl_0bc050
	lda.l race_menuoption
rsl_0bc054
	beq rsl_0bc068
rsl_0bc056
	dec a
rsl_0bc057
	sta.l race_menuoption
rsl_0bc05b
	a8
rsl_0bc05d
	lda #$46
rsl_0bc05f
	jsl queue_raceplayer_l
rsl_0bc063
	a16
rsl_0bc065
	jsr rsl_optioncursor
rsl_0bc068
	lda.w race_menuedges
rsl_0bc06b
	and #$0100
rsl_0bc06e
	beq rsl_0bc08b
rsl_0bc070
	lda.l race_menuoption
rsl_0bc074
	cmp #$0002
rsl_0bc077
	beq rsl_0bc08b
rsl_0bc079
	inc a
rsl_0bc07a
	sta.l race_menuoption
rsl_0bc07e
	a8
rsl_0bc080
	lda #$46
rsl_0bc082
	jsl queue_raceplayer_l
rsl_0bc086
	a16
rsl_0bc088
	jsr rsl_optioncursor
rsl_0bc08b
	lda.w race_menuedges
rsl_0bc08e
	and #$0800
rsl_0bc091
	beq rsl_0bc0b4
rsl_0bc093
	a8
rsl_0bc095
	lda #$45
rsl_0bc097
	jsl queue_raceplayer_l
rsl_0bc09b
	a16
rsl_0bc09d
	lda.l race_menuoption
rsl_0bc0a1
	asl a
rsl_0bc0a2
	tax
rsl_0bc0a3
	lda.l race_menuoptions0,x
rsl_0bc0a7
	dec a
rsl_0bc0a8
	cmp #$ffff
rsl_0bc0ab
	bne rsl_0bc0b0
rsl_0bc0ad
	lda #$0002
rsl_0bc0b0
	sta.l race_menuoptions0,x
rsl_0bc0b4
	lda.w race_menuedges
rsl_0bc0b7
	and #$0400
rsl_0bc0ba
	beq rsl_0bc0dd
rsl_0bc0bc
	a8
rsl_0bc0be
	lda #$45
rsl_0bc0c0
	jsl queue_raceplayer_l
rsl_0bc0c4
	a16
rsl_0bc0c6
	lda.l race_menuoption
rsl_0bc0ca
	asl a
rsl_0bc0cb
	tax
rsl_0bc0cc
	lda.l race_menuoptions0,x
rsl_0bc0d0
	inc a
rsl_0bc0d1
	cmp #$0003
rsl_0bc0d4
	bne rsl_0bc0d9
rsl_0bc0d6
	lda #$0000
rsl_0bc0d9
	sta.l race_menuoptions0,x
rsl_0bc0dd
	ldx.w race_entitycurrent
rsl_0bc0e0
	jsr rsl_optionlabel
rsl_0bc0e3
	jsr rsl_optionlabels
rsl_0bc0e6
	rts
rsl_optionlabel
	jsl rsl_resolvechoices
rsl_0bc0eb
	jsr rsl_optionlabels
rsl_0bc0ee
	lda.l race_menuoption
rsl_0bc0f2
	asl a
rsl_0bc0f3
	tax
rsl_0bc0f4
	lda.l race_menuoptions0,x
rsl_0bc0f8
	sta.w race_oambits
rsl_0bc0fb
	lda.l retail_optiontags,x
rsl_0bc0ff
	sta.w race_spritesleft
rsl_0bc102
	lda.w race_oambits
rsl_0bc105
	cmp #$0000
rsl_0bc108
	bne rsl_0bc122
rsl_0bc10a
	lda #$0003
rsl_0bc10d
	jsl retail_findentity_l
rsl_0bc110
	lda $14,x
rsl_0bc112
	cmp #$0036
rsl_0bc115
	beq rsl_0bc120
rsl_0bc117
	lda #$0036
rsl_0bc11a
	sta $14,x
rsl_0bc11c
	stz $16,x
rsl_0bc11e
	stz $18,x
rsl_0bc120
	bra rsl_0bc15a
rsl_0bc122
	cmp #$0001
rsl_0bc125
	bne rsl_0bc13f
rsl_0bc127
	lda #$0003
rsl_0bc12a
	jsl retail_findentity_l
rsl_0bc12d
	lda $14,x
rsl_0bc12f
	cmp #$003c
rsl_0bc132
	beq rsl_0bc13d
rsl_0bc134
	lda #$003c
rsl_0bc137
	sta $14,x
rsl_0bc139
	stz $16,x
rsl_0bc13b
	stz $18,x
rsl_0bc13d
	bra rsl_0bc15a
rsl_0bc13f
	cmp #$0002
rsl_0bc142
	bne rsl_0bc15a
rsl_0bc144
	lda #$0003
rsl_0bc147
	jsl retail_findentity_l
rsl_0bc14a
	lda $14,x
rsl_0bc14c
	cmp #$0030
rsl_0bc14f
	beq rsl_0bc15a
rsl_0bc151
	lda #$0030
rsl_0bc154
	sta $14,x
rsl_0bc156
	stz $16,x
rsl_0bc158
	stz $18,x
rsl_0bc15a
	ldx.w race_entitycurrent
rsl_0bc15d
	rts
rsl_optionlabels
	ldx #$0000
rsl_0bc167
	phx
rsl_0bc168
	stx.w race_spritesleft
rsl_0bc16b
	stz.w race_menutemp
rsl_0bc16e
	lda.l race_menuoptions0,x
rsl_0bc172
	asl a
rsl_0bc173
	asl a
rsl_0bc174
	asl a
rsl_0bc175
	clc
rsl_0bc176
	adc.w race_menutemp
rsl_0bc179
	sta.w race_menutemp
rsl_0bc17c
	lda.l race_optioncode0,x
rsl_0bc180
	asl a
rsl_0bc181
	clc
rsl_0bc182
	adc.w race_menutemp
rsl_0bc185
	tax
rsl_0bc186
	lda.l retail_optionanims,x
rsl_0bc18a
	sta.w race_menutemp
rsl_0bc18d
	ldx.w race_spritesleft
rsl_0bc190
	lda.l retail_optiontags,x
rsl_0bc194
	jsl retail_findentity_l
rsl_0bc197
	lda.w race_menutemp
rsl_0bc19a
	cmp $14,x
rsl_0bc19c
	beq rsl_0bc1a4
rsl_0bc19e
	sta $14,x
rsl_0bc1a0
	stz $16,x
rsl_0bc1a2
	stz $18,x
rsl_0bc1a4
	plx
rsl_0bc1a5
	inx
rsl_0bc1a6
	inx
rsl_0bc1a7
	cpx #$0006
rsl_0bc1aa
	bne rsl_0bc167
rsl_0bc1ac
	ldx.w race_entitycurrent
rsl_0bc1af
	rts
rsl_optioncursor
	lda #$000d
rsl_0bc1cb
	jsl retail_findentity_l
rsl_0bc1ce
	lda.l race_menuoption
rsl_0bc1d2
	bne rsl_0bc1e6
rsl_0bc1d4
	lda $14,x
rsl_0bc1d6
	cmp #$0064
rsl_0bc1d9
	beq rsl_0bc1e4
rsl_0bc1db
	lda #$0064
rsl_0bc1de
	sta $14,x
rsl_0bc1e0
	stz $16,x
rsl_0bc1e2
	stz $18,x
rsl_0bc1e4
	bra rsl_0bc212
rsl_0bc1e6
	cmp #$0001
rsl_0bc1e9
	bne rsl_0bc1fd
rsl_0bc1eb
	lda $14,x
rsl_0bc1ed
	cmp #$005a
rsl_0bc1f0
	beq rsl_0bc1fb
rsl_0bc1f2
	lda #$005a
rsl_0bc1f5
	sta $14,x
rsl_0bc1f7
	stz $16,x
rsl_0bc1f9
	stz $18,x
rsl_0bc1fb
	bra rsl_0bc212
rsl_0bc1fd
	cmp #$0002
rsl_0bc200
	bne rsl_0bc212
rsl_0bc202
	lda $14,x
rsl_0bc204
	cmp #$006e
rsl_0bc207
	beq rsl_0bc212
rsl_0bc209
	lda #$006e
rsl_0bc20c
	sta $14,x
rsl_0bc20e
	stz $16,x
rsl_0bc210
	stz $18,x
rsl_0bc212
	lda.l race_menuoption
rsl_0bc216
	asl a
rsl_0bc217
	asl a
rsl_0bc218
	asl a
rsl_0bc219
	asl a
rsl_0bc21a
	asl a
rsl_0bc21b
	clc
rsl_0bc21c
	adc #$0034
rsl_0bc21f
	sta $02,x
rsl_0bc221
	ldx.w race_entitycurrent
rsl_0bc224
	rts
rsl_audioinputs
	stz.w race_menuedges
rsl_0bc352
	lda.l race_menuinputbytes0
rsl_0bc356
	dec a
rsl_0bc357
	dec a
rsl_0bc358
	bmi rsl_0bc378
rsl_0bc35a
	tax
rsl_0bc35b
	lda.l race_menuinputqueue0,x
rsl_0bc35f
	sta.w race_frontdebug
rsl_0bc362
	ora.w race_menuedges
rsl_0bc365
	sta.w race_menuedges
rsl_0bc368
	phx
rsl_0bc369
	jsr rsl_audioinput
rsl_0bc36c
	pla
rsl_0bc36d
	dec a
rsl_0bc36e
	dec a
rsl_0bc36f
	bpl rsl_0bc35a
rsl_0bc371
	lda #$0000
rsl_0bc374
	sta.l race_menuinputbytes0
rsl_0bc378
	lda #$0009
rsl_0bc37b
	jsl retail_findentity_l
rsl_0bc37e
	jsl retail_audiofields_l
rsl_0bc381
	ldx.w race_entitycurrent
rsl_0bc384
	rts
rsl_audioinput
	lda.w race_frontdebug
rsl_0bc388
	and #$0200
rsl_0bc38b
	beq rsl_0bc3a9
rsl_0bc38d
	lda.l race_menuunknown3
rsl_0bc391
	beq rsl_0bc3a9
rsl_0bc393
	a8
rsl_0bc395
	lda #$46
rsl_0bc397
	jsl queue_raceplayer_l
rsl_0bc39b
	a16
rsl_0bc39d
	jsr rsl_unmarkaudio
rsl_0bc3a0
	lda.l race_menuunknown3
rsl_0bc3a4
	dec a
rsl_0bc3a5
	sta.l race_menuunknown3
rsl_0bc3a9
	lda.w race_frontdebug
rsl_0bc3ac
	and #$0100
rsl_0bc3af
	beq rsl_0bc3d0
rsl_0bc3b1
	lda.l race_menuunknown3
rsl_0bc3b5
	cmp #$0002
rsl_0bc3b8
	beq rsl_0bc3d0
rsl_0bc3ba
	a8
rsl_0bc3bc
	lda #$46
rsl_0bc3be
	jsl queue_raceplayer_l
rsl_0bc3c2
	a16
rsl_0bc3c4
	jsr rsl_unmarkaudio
rsl_0bc3c7
	lda.l race_menuunknown3
rsl_0bc3cb
	inc a
rsl_0bc3cc
	sta.l race_menuunknown3
rsl_0bc3d0
	lda.l race_menuunknown3
rsl_0bc3d4
	asl a
rsl_0bc3d5
	tax
rsl_0bc3d6
	lda.l race_menuheld0
rsl_0bc3da
	and #$0800
rsl_0bc3dd
	beq rsl_0bc3ef
rsl_0bc3df
	lda.l race_audioupcount
rsl_0bc3e3
	inc a
rsl_0bc3e4
	cmp #$000d
rsl_0bc3e7
	bcs rsl_0bc3fe
rsl_0bc3e9
	sta.l race_audioupcount
rsl_0bc3ed
	bra rsl_0bc3f6
rsl_0bc3ef
	lda #$0000
rsl_0bc3f2
	sta.l race_audioupcount
rsl_0bc3f6
	lda.w race_frontdebug
rsl_0bc3f9
	and #$0800
rsl_0bc3fc
	beq rsl_0bc422
rsl_0bc3fe
	lda #$0000
rsl_0bc401
	sta.l race_audioupcount
rsl_0bc405
	a8
rsl_0bc407
	lda #$45
rsl_0bc409
	jsl queue_raceplayer_l
rsl_0bc40d
	a16
rsl_0bc40f
	lda.l race_menuaudio0,x
rsl_0bc413
	inc a
rsl_0bc414
	cmp #$001a
rsl_0bc417
	bne rsl_0bc41c
rsl_0bc419
	lda #$0000
rsl_0bc41c
	sta.l race_menuaudio0,x
rsl_0bc420
	bra rsl_0bc46c
rsl_0bc422
	lda.l race_menuheld0
rsl_0bc426
	and #$0400
rsl_0bc429
	beq rsl_0bc43b
rsl_0bc42b
	lda.l race_audiodowncount
rsl_0bc42f
	inc a
rsl_0bc430
	cmp #$000d
rsl_0bc433
	bcs rsl_0bc44a
rsl_0bc435
	sta.l race_audiodowncount
rsl_0bc439
	bra rsl_0bc442
rsl_0bc43b
	lda #$0000
rsl_0bc43e
	sta.l race_audiodowncount
rsl_0bc442
	lda.w race_frontdebug
rsl_0bc445
	and #$0400
rsl_0bc448
	beq rsl_0bc46c
rsl_0bc44a
	lda #$0000
rsl_0bc44d
	sta.l race_audiodowncount
rsl_0bc451
	a8
rsl_0bc453
	lda #$45
rsl_0bc455
	jsl queue_raceplayer_l
rsl_0bc459
	a16
rsl_0bc45b
	lda.l race_menuaudio0,x
rsl_0bc45f
	dec a
rsl_0bc460
	cmp #$ffff
rsl_0bc463
	bne rsl_0bc468
rsl_0bc465
	lda #$0019
rsl_0bc468
	sta.l race_menuaudio0,x
rsl_0bc46c
	rts
rsl_unmarkaudio
	lda #$0009
rsl_0bc47f
	jsl retail_findentity_l
rsl_0bc482
	jsl retail_audioselect_l
rsl_0bc485
	tax
rsl_0bc486
	lda.l race_spritelists+4,x
rsl_0bc48a
	and #$f1ff
rsl_0bc48d
	ora #$0a00
rsl_0bc490
	sta.l race_spritelists+4,x
rsl_0bc494
	txa
rsl_0bc495
	clc
rsl_0bc496
	adc #$0008
rsl_0bc499
	tax
rsl_0bc49a
	lda.l race_spritelists+4,x
rsl_0bc49e
	and #$f1ff
rsl_0bc4a1
	ora #$0a00
rsl_0bc4a4
	sta.l race_spritelists+4,x
rsl_0bc4a8
	rts
rsl_selectcategory
	lda.l race_menuunknown0
rsl_0bc5a3
	sta.l race_menupending
rsl_0bc5a7
	ldy.w race_menuedges
rsl_0bc5aa
	tya
rsl_0bc5ab
	and #$0800
rsl_0bc5ae
	beq rsl_0bc5c6
rsl_0bc5b0
	a8
rsl_0bc5b2
	lda #$45
rsl_0bc5b4
	jsl queue_raceplayer_l
rsl_0bc5b8
	a16
rsl_0bc5ba
	lda.l race_menuunknown0
rsl_0bc5be
	dec a
rsl_0bc5bf
	and #$0003
rsl_0bc5c2
	sta.l race_menuunknown0
rsl_0bc5c6
	tya
rsl_0bc5c7
	and #$0400
rsl_0bc5ca
	beq rsl_0bc5e2
rsl_0bc5cc
	a8
rsl_0bc5ce
	lda #$45
rsl_0bc5d0
	jsl queue_raceplayer_l
rsl_0bc5d4
	a16
rsl_0bc5d6
	lda.l race_menuunknown0
rsl_0bc5da
	inc a
rsl_0bc5db
	and #$0003
rsl_0bc5de
	sta.l race_menuunknown0
rsl_0bc5e2
	lda.l race_menuunknown4
rsl_0bc5e6
	dec a
rsl_0bc5e7
	and #$00ff
rsl_0bc5ea
	sta.l race_menuunknown4
rsl_0bc5ee
	rts
rsl_vehicleinputs
	stz.w race_menuedges
rsl_0bc64f
	lda.l race_menuinputbytes0
rsl_0bc653
	dec a
rsl_0bc654
	dec a
rsl_0bc655
	bmi rsl_0bc675
rsl_0bc657
	tax
rsl_0bc658
	lda.l race_menuinputqueue0,x
rsl_0bc65c
	sta.w race_frontdebug
rsl_0bc65f
	ora.w race_menuedges
rsl_0bc662
	sta.w race_menuedges
rsl_0bc665
	phx
rsl_0bc666
	jsr rsl_vehicleinput
rsl_0bc669
	pla
rsl_0bc66a
	dec a
rsl_0bc66b
	dec a
rsl_0bc66c
	bpl rsl_0bc657
rsl_0bc66e
	lda #$0000
rsl_0bc671
	sta.l race_menuinputbytes0
rsl_0bc675
	rts
rsl_vehicleinput
	lda.w race_frontdebug
rsl_0bc679
	and #$0200
rsl_0bc67c
	beq rsl_0bc6cc
rsl_0bc67e
	a8
rsl_0bc680
	lda #$45
rsl_0bc682
	jsl queue_raceplayer_l
rsl_0bc686
	a16
rsl_0bc688
	lda.l race_menucurrent
rsl_0bc68c
	asl a
rsl_0bc68d
	phx
rsl_0bc68e
	tax
rsl_0bc68f
	lda.l retail_menuleft,x
rsl_0bc693
	plx
rsl_0bc694
	sta.l race_menucurrent
rsl_0bc698
	lda.l race_recordimage+11
rsl_0bc69c
	and #$00ff
rsl_0bc69f
	cmp #$0000
rsl_0bc6a2
	beq rsl_0bc6b2
rsl_0bc6a4
	and #$0004
rsl_0bc6a7
	bne rsl_0bc6c2
rsl_0bc6a9
	lda.l race_menuunknown0
rsl_0bc6ad
	cmp #$0003
rsl_0bc6b0
	beq rsl_0bc6c2
rsl_0bc6b2
	lda.l race_menucurrent
rsl_0bc6b6
	cmp #$0003
rsl_0bc6b9
	bne rsl_0bc6c2
rsl_0bc6bb
	lda #$0002
rsl_0bc6be
	sta.l race_menucurrent
rsl_0bc6c2
	lda.l race_menucurrent
rsl_0bc6c6
	jsl retail_menucursor_l
rsl_0bc6c9
	jsl retail_menulabels_l
rsl_0bc6cc
	lda.w race_frontdebug
rsl_0bc6cf
	and #$0100
rsl_0bc6d2
	beq rsl_0bc722
rsl_0bc6d4
	a8
rsl_0bc6d6
	lda #$45
rsl_0bc6d8
	jsl queue_raceplayer_l
rsl_0bc6dc
	a16
rsl_0bc6de
	lda.l race_menucurrent
rsl_0bc6e2
	asl a
rsl_0bc6e3
	phx
rsl_0bc6e4
	tax
rsl_0bc6e5
	lda.l retail_menuright,x
rsl_0bc6e9
	plx
rsl_0bc6ea
	sta.l race_menucurrent
rsl_0bc6ee
	lda.l race_recordimage+11
rsl_0bc6f2
	and #$00ff
rsl_0bc6f5
	cmp #$0000
rsl_0bc6f8
	beq rsl_0bc708
rsl_0bc6fa
	and #$0004
rsl_0bc6fd
	bne rsl_0bc718
rsl_0bc6ff
	lda.l race_menuunknown0
rsl_0bc703
	cmp #$0003
rsl_0bc706
	beq rsl_0bc718
rsl_0bc708
	lda.l race_menucurrent
rsl_0bc70c
	cmp #$0003
rsl_0bc70f
	bne rsl_0bc718
rsl_0bc711
	lda #$0001
rsl_0bc714
	sta.l race_menucurrent
rsl_0bc718
	lda.l race_menucurrent
rsl_0bc71c
	jsl retail_menucursor_l
rsl_0bc71f
	jsl retail_menulabels_l
rsl_0bc722
	rts
rsl_optionbounds
	lda $0a,x
rsl_0bc9ff
	sec
rsl_0bca00
	sbc #$0040
rsl_0bca03
	and #$00ff
rsl_0bca06
	tax
rsl_0bca07
	lda.l sintab,x
rsl_0bca0b
	and #$00ff
rsl_0bca0e
	cmp #$0080
rsl_0bca11
	bcc rsl_0bca16
rsl_0bca13
	ora #$ff00
rsl_0bca16
	clc
rsl_0bca17
	adc #$0080
rsl_0bca1a
	and #$00ff
rsl_0bca1d
	inc a
rsl_0bca1e
	sta.l race_frontscroll2
rsl_0bca22
	cmp #$00a8
rsl_0bca25
	bcs rsl_0bca2a
rsl_0bca27
	lda #$00a8
rsl_0bca2a
	sta.l race_frontscroll3
rsl_0bca2e
	ldx.w race_entitycurrent
rsl_0bca31
	rts
rsl_optionboundsout
	lda $0a,x
rsl_0bca34
	sec
rsl_0bca35
	sbc #$0040
rsl_0bca38
	and #$00ff
rsl_0bca3b
	tax
rsl_0bca3c
	lda.l sintab,x
rsl_0bca40
	and #$00ff
rsl_0bca43
	cmp #$0080
rsl_0bca46
	bcc rsl_0bca4b
rsl_0bca48
	ora #$ff00
rsl_0bca4b
	clc
rsl_0bca4c
	adc #$0080
rsl_0bca4f
	and #$00ff
rsl_0bca52
	dec a
rsl_0bca53
	sta.l race_frontscroll2
rsl_0bca57
	cmp #$00a8
rsl_0bca5a
	bcs rsl_0bca5f
rsl_0bca5c
	lda #$00a8
rsl_0bca5f
	sta.l race_frontscroll3
rsl_0bca63
	ldx.w race_entitycurrent
rsl_0bca66
	rts
retail_resolvechoices_l equ rsl_resolvechoices
retail_choicecodes_l
	jsr rsl_choicecodes
	rtl
retail_frontbuffers_l
	jsr rsl_frontbuffers
	rtl
retail_loadchoices_l
	jsr rsl_loadchoices
	rtl
retail_tuneoptions_l
	jsr rsl_tuneoptions
	rtl
retail_optionlabel_l
	jsr rsl_optionlabel
	rtl
retail_optionlabels_l
	jsr rsl_optionlabels
	rtl
retail_optioncursor_l
	jsr rsl_optioncursor
	rtl
retail_audioinputs_l
	jsr rsl_audioinputs
	rtl
retail_audioinput_l
	jsr rsl_audioinput
	rtl
retail_unmarkaudio_l
	jsr rsl_unmarkaudio
	rtl
retail_selectcategory_l
	jsr rsl_selectcategory
	rtl
retail_vehicleinputs_l
	jsr rsl_vehicleinputs
	rtl
retail_vehicleinput_l
	jsr rsl_vehicleinput
	rtl
retail_optionbounds_l
	jsr rsl_optionbounds
	rtl
retail_optionboundsout_l
	jsr rsl_optionboundsout
	rtl
retail_choiceoffsets
	dw $0000
	dw $0051
	dw $00a2
	dw $00f3
retail_choiceoffsets_end
retail_choicecodes
	db $02,$00,$01,$01,$02,$00,$00,$02,$01,$02,$01,$00
	db $01,$00,$02,$00,$01,$02,$02,$00,$01,$01,$00,$02
	db $00,$01,$02,$02,$00,$01,$01,$02,$00,$00,$02,$01
	db $02,$01,$00,$01,$00,$02,$00,$01,$02,$02,$00,$01
	db $01,$00,$02,$00,$02,$01,$02,$01,$00,$01,$02,$00
	db $00,$02,$01,$02,$01,$00,$01,$02,$00,$00,$01,$02
	db $02,$00,$01,$01,$00,$02,$00,$02,$01,$03,$02,$00
	db $02,$03,$00,$00,$03,$02,$03,$02,$00,$02,$00,$03
	db $00,$02,$03,$03,$00,$02,$02,$00,$03,$00,$02,$03
	db $03,$00,$02,$02,$03,$00,$00,$03,$02,$03,$02,$00
	db $02,$00,$03,$00,$02,$03,$03,$00,$02,$02,$00,$03
	db $00,$03,$02,$03,$02,$00,$02,$03,$00,$00,$03,$02
	db $03,$02,$00,$02,$03,$00,$00,$02,$03,$03,$00,$02
	db $02,$00,$03,$00,$02,$03,$03,$02,$01,$01,$03,$02
	db $02,$03,$01,$03,$01,$02,$01,$02,$03,$02,$01,$03
	db $03,$02,$01,$01,$02,$03,$02,$01,$03,$03,$02,$01
	db $01,$03,$02,$02,$03,$01,$03,$01,$02,$01,$02,$03
	db $02,$01,$03,$03,$02,$01,$01,$02,$03,$02,$03,$01
	db $03,$01,$02,$01,$03,$02,$02,$03,$01,$03,$01,$02
	db $01,$03,$02,$02,$01,$03,$03,$02,$01,$01,$02,$03
	db $02,$03,$01,$03,$00,$01,$01,$03,$00,$00,$03,$01
	db $03,$01,$00,$01,$00,$03,$00,$01,$03,$03,$00,$01
	db $01,$00,$03,$00,$01,$03,$03,$00,$01,$01,$03,$00
	db $00,$03,$01,$03,$01,$00,$01,$00,$03,$00,$01,$03
	db $03,$00,$01,$01,$00,$03,$00,$03,$01,$03,$01,$00
	db $01,$03,$00,$00,$03,$01,$03,$01,$00,$01,$03,$00
	db $00,$01,$03,$03,$00,$01,$01,$00,$03,$00,$03,$01
retail_choicecodes_end
retail_categorycodes
	db $03,$01,$00,$02
retail_categorycodes_end
retail_choiceflags
	db $01,$02,$03,$00,$03,$00,$01,$02,$00,$01,$02,$03
	db $02,$03,$00,$01
retail_choiceflags_end
retail_savedchoices
	dw $0001
	dw $0000
	dw $0002
	dw $0003
retail_savedchoices_end
retail_optiontags
	dw $000a
	dw $000b
	dw $000c
retail_optiontags_end
retail_optionanims
	dw $0118
	dw $0124
	dw $012a
	dw $011e
	dw $0130
	dw $013c
	dw $0142
	dw $0136
	dw $0100
	dw $010c
	dw $0112
	dw $0106
retail_optionanims_end
mrselect_end
