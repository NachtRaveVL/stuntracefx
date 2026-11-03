; Retail frontend animation, frame publication and HUD services.
; D=0, DB=0, binary arithmetic. PHP entries restore P; strategies use
; A16/I16. Frame sampling enters I16 and returns A8/I16, as in retail.
; The caller owns blanking, GSU access, resource loading and frame timing.
; frameblank services bitmap/window/queues and waits for autojoy to finish;
; framesample snapshots scrolls and two caller-produced input words.
; Neither entry installs the active NMI. probeport takes A=0 or1; its
; bit-1 serial signature sets frontdevice without identifying the device.
; Map icons consume the existing terminated race_actorlist, CPU positions
; and the low three visibility bits; x2/y2/dx supply origin and OAM stride.
; Bar routines take A=level, X=packed position, Y=OAM byte offset. The
; 16-pixel bar clamps at63; the 8-pixel bar retains the native byte wrap
; and its12-byte table read into the following code (copied as data).
; Frontsound takes A=raw GSU-car offset (zero allowed). Its filter output
; feeds racesound_nearparam; synchronize the GSU bus before reading it.
; A two-byte output preserves the zero-pointer path's native word store
; without overwriting the early adjacent audio parameter; only its low
; byte is published to the existing sound consumer.
; Menugraphics is a caller-loaded $6800-byte option-card cache. Texturestrip
; uses a separate $2000-byte cache in bank7E and rebinds its queued bank.
; Reset queues before dispatch; menu card tiles enqueue two64-byte strips
; per sprite. Native counts remain unchecked except the queue capacities.
; Menu item IDs retain native offsets $0000-$027E, excluding $0266.
; The remaining scene controller requires reconstruction. Initialize
; forms/entities before construction; the existing 88-byte copy is reused.
	incpublics mrui.ext
; Assembled after MRMENU in INCBINS, sharing its external declarations.
mrui_begin
	longa
	longi
rui_bar16
	php
rui_0b814f
	a8
rui_0b8151
	i16
rui_0b8153
	cmp #$3f
rui_0b8155
	bcc rui_0b8159
rui_0b8157
	lda #$3f
rui_0b8159
	sta x2
rui_0b815b
	a16
rui_0b815d
	stx x1
rui_0b815f
	phy
rui_0b8160
	tya
rui_0b8161
	clc
rui_0b8162
	adc #$0004
rui_0b8165
	tay
rui_0b8166
	a8
rui_0b8168
	lda x2
rui_0b816a
	a16
rui_0b816c
	and #$00ff
rui_0b816f
	pha
rui_0b8170
	jsr rui_bar16body
rui_0b8173
	pla
rui_0b8174
	ply
rui_0b8175
	cmp #$0010
rui_0b8178
	bcc rui_0b818c
rui_0b817a
	clc
rui_0b817b
	adc x1
rui_0b817d
	sec
rui_0b817e
	sbc #$0010
rui_0b8181
	sta.w race_oam+0,y
rui_0b8184
	lda #$3c20
rui_0b8187
	sta.w race_oam+2,y
rui_0b818a
	plp
rui_0b818b
	rtl
rui_0b818c
	a16
rui_0b818e
	clc
rui_0b818f
	adc x1
rui_0b8191
	sta.w race_oam+0,y
rui_0b8194
	lda #$3622
rui_0b8197
	sta.w race_oam+2,y
rui_0b819a
	plp
rui_0b819b
	rtl
rui_bar16body
	php
rui_0b819d
	ai16
rui_0b819f
	lsr a
rui_0b81a0
	and #$00f8
rui_0b81a3
	tax
rui_0b81a4
	lda x1
rui_0b81a6
	pha
rui_0b81a7
	lda #$0003
rui_0b81aa
	sta y1
rui_0b81ac
	lda x1
rui_0b81ae
	sta.w race_oam+0,y
rui_0b81b1
	clc
rui_0b81b2
	adc #$0010
rui_0b81b5
	sta x1
rui_0b81b7
	lda.l retail_bar16forms,x
rui_0b81bb
	sta.w race_oam+2,y
rui_0b81be
	inx
rui_0b81bf
	inx
rui_0b81c0
	iny
rui_0b81c1
	iny
rui_0b81c2
	iny
rui_0b81c3
	iny
rui_0b81c4
	dec y1
rui_0b81c6
	bpl rui_0b81ac
rui_0b81c8
	pla
rui_0b81c9
	sta x1
rui_0b81cb
	plp
rui_0b81cc
	rts
rui_bar8
	php
rui_0b81ee
	a8
rui_0b81f0
	i16
rui_0b81f2
	sta x2
rui_0b81f4
	a16
rui_0b81f6
	stx x1
rui_0b81f8
	phy
rui_0b81f9
	tya
rui_0b81fa
	clc
rui_0b81fb
	adc #$0004
rui_0b81fe
	tay
rui_0b81ff
	a8
rui_0b8201
	lda x2
rui_0b8203
	a16
rui_0b8205
	and #$00ff
rui_0b8208
	pha
rui_0b8209
	jsr rui_bar8body
rui_0b820c
	pla
rui_0b820d
	ply
rui_0b820e
	cmp #$0008
rui_0b8211
	bcc rui_0b8225
rui_0b8213
	clc
rui_0b8214
	adc x1
rui_0b8216
	sec
rui_0b8217
	sbc #$0008
rui_0b821a
	sta.w race_oam+0,y
rui_0b821d
	lda #$3c1f
rui_0b8220
	sta.w race_oam+2,y
rui_0b8223
	plp
rui_0b8224
	rtl
rui_0b8225
	a16
rui_0b8227
	clc
rui_0b8228
	adc x1
rui_0b822a
	sta.w race_oam+0,y
rui_0b822d
	lda #$3c1e
rui_0b8230
	sta.w race_oam+2,y
rui_0b8233
	plp
rui_0b8234
	rtl
rui_bar8body
	php
rui_0b8236
	ai16
rui_0b8238
	and #$0038
rui_0b823b
	asl a
rui_0b823c
	tax
rui_0b823d
	lda x1
rui_0b823f
	pha
rui_0b8240
	lda #$0005
rui_0b8243
	sta y1
rui_0b8245
	lda x1
rui_0b8247
	sta.w race_oam+0,y
rui_0b824a
	clc
rui_0b824b
	adc #$0008
rui_0b824e
	sta x1
rui_0b8250
	lda.l retail_bar8forms,x
rui_0b8254
	sta.w race_oam+2,y
rui_0b8257
	inx
rui_0b8258
	inx
rui_0b8259
	iny
rui_0b825a
	iny
rui_0b825b
	iny
rui_0b825c
	iny
rui_0b825d
	dec y1
rui_0b825f
	bpl rui_0b8245
rui_0b8261
	pla
rui_0b8262
	sta x1
rui_0b8264
	plp
rui_0b8265
	rts
rui_mapicons
	php
rui_0b82d7
	ai16
rui_0b82d9
	ldx #$0000
rui_0b82dc
	lda.l race_actorlist,x
rui_0b82e0
	bne rui_0b82e5
rui_0b82e2
	brl rui_0b8344
rui_0b82e5
	phx
rui_0b82e6
	tax
rui_0b82e7
	lda.l alx_worldx,x
rui_0b82eb
	cmp #$8000
rui_0b82ee
	ror a
rui_0b82ef
	cmp #$8000
rui_0b82f2
	ror a
rui_0b82f3
	cmp #$8000
rui_0b82f6
	ror a
rui_0b82f7
	xba
rui_0b82f8
	clc
rui_0b82f9
	adc x2
rui_0b82fb
	and #$00ff
rui_0b82fe
	sta x1
rui_0b8300
	lda.l alx_worldz,x
rui_0b8304
	eor #$ffff
rui_0b8307
	inc a
rui_0b8308
	cmp #$8000
rui_0b830b
	ror a
rui_0b830c
	cmp #$8000
rui_0b830f
	ror a
rui_0b8310
	cmp #$8000
rui_0b8313
	ror a
rui_0b8314
	clc
rui_0b8315
	adc y2
rui_0b8317
	and #$ff00
rui_0b831a
	ora x1
rui_0b831c
	sta y1
rui_0b831e
	sta.w race_oam+0,y
rui_0b8321
	a16
rui_0b8323
	lda.l alx_whocanseeme,x
rui_0b8327
	sta y1
rui_0b8329
	and #$0007
rui_0b832c
	asl a
rui_0b832d
	tax
rui_0b832e
	lda.l retail_mapiconforms,x
rui_0b8332
	sta x1
rui_0b8334
	lda x1
rui_0b8336
	sta.w race_oam+2,y
rui_0b8339
	plx
rui_0b833a
	inx
rui_0b833b
	inx
rui_0b833c
	tya
rui_0b833d
	clc
rui_0b833e
	adc dx
rui_0b8340
	tay
rui_0b8341
	jmp rui_0b82dc
rui_0b8344
	plp
rui_0b8345
	rtl
rui_coursetiles
	php
rui_0b8357
	a8
rui_0b8359
	i16
rui_0b835b
	lda.w race_mapmode
rui_0b835e
	a16
rui_0b8360
	and #$00ff
rui_0b8363
	asl a
rui_0b8364
	tax
rui_0b8365
	lda.l retail_courseblocks,x
rui_0b8369
	pha
rui_0b836a
	and #$fffc
rui_0b836d
	xba
rui_0b836e
	asl a
rui_0b836f
	sta x1
rui_0b8371
	pla
rui_0b8372
	and #$0003
rui_0b8375
	xba
rui_0b8376
	lsr a
rui_0b8377
	clc
rui_0b8378
	adc x1
rui_0b837a
	sta x1
rui_0b837c
	lda #$6480
rui_0b837f
	jsr rui_courseblock
rui_0b8382
	lda #$6580
rui_0b8385
	jsr rui_courseblock
rui_0b8388
	lda #$64c0
rui_0b838b
	jsr rui_courseblock
rui_0b838e
	lda #$65c0
rui_0b8391
	jsr rui_courseblock
rui_0b8394
	plp
rui_0b8395
	rtl
rui_courseblock
	php
rui_0b83cf
	ai16
rui_0b83d1
	sta.w $2116
rui_0b83d4
	ldy #$003f
rui_0b83d7
	ldx x1
rui_0b83d9
	lda.l $703000,x
rui_0b83dd
	sta.w $2118
rui_0b83e0
	inx
rui_0b83e1
	inx
rui_0b83e2
	dey
rui_0b83e3
	bpl rui_0b83d9
rui_0b83e5
	lda x1
rui_0b83e7
	clc
rui_0b83e8
	adc #$0200
rui_0b83eb
	sta x1
rui_0b83ed
	plp
rui_0b83ee
	rts
rui_frontsound
	php
rui_0b83f0
	a16
rui_0b83f2
	sta x1
rui_0b83f4
	a8
rui_0b83f6
	lda.w racesound_voiceoff
rui_0b83f9
	beq rui_0b83fe
rui_0b83fb
	brl rui_0b84a5
rui_0b83fe
	ai16
rui_0b8400
	lda x1
rui_0b8402
	phx
rui_0b8403
	cmp #$0000
rui_0b8406
	bne rui_0b840b
rui_0b8408
	brl rui_0b849e
rui_0b840b
	tax
rui_0b840c
	lda.l $70004a,x
rui_0b8410
	bmi rui_0b8418
rui_0b8412
	lsr a
rui_0b8413
	lsr a
rui_0b8414
	sta x1
rui_0b8416
	bra rui_0b841d
rui_0b8418
	lda #$0000
rui_0b841b
	sta x1
rui_0b841d
	lda.l $700044,x
rui_0b8421
	cmp #$0004
rui_0b8424
	bmi rui_0b8436
rui_0b8426
	lda.l $70004a,x
rui_0b842a
	cmp #$8000
rui_0b842d
	ror a
rui_0b842e
	bpl rui_0b8440
rui_0b8430
	eor #$ffff
rui_0b8433
	inc a
rui_0b8434
	bra rui_0b8440
rui_0b8436
	lda.l $700050,x
rui_0b843a
	lsr a
rui_0b843b
	lsr a
rui_0b843c
	lsr a
rui_0b843d
	clc
rui_0b843e
	adc x1
rui_0b8440
	cmp #$00ff
rui_0b8443
	bcc rui_0b8448
rui_0b8445
	lda #$00ff
rui_0b8448
	sta x1
rui_0b844a
	lda.w race_frontsoundramp
rui_0b844d
	bmi rui_0b849a
rui_0b844f
	plx
rui_0b8450
	lda.w race_frontsoundramp
rui_0b8453
	cmp x1
rui_0b8455
	beq rui_0b8485
rui_0b8457
	bcc rui_0b8470
rui_0b8459
	sec
rui_0b845a
	sbc #$0004
rui_0b845d
	sta.w race_frontsoundramp
rui_0b8460
	sec
rui_0b8461
	sbc x1
rui_0b8463
	clc
rui_0b8464
	adc #$0004
rui_0b8467
	bmi rui_0b848f
rui_0b8469
	cmp #$0008
rui_0b846c
	bcs rui_0b848f
rui_0b846e
	bra rui_0b8485
rui_0b8470
	clc
rui_0b8471
	adc #$0004
rui_0b8474
	sta.w race_frontsoundramp
rui_0b8477
	sec
rui_0b8478
	sbc x1
rui_0b847a
	clc
rui_0b847b
	adc #$0004
rui_0b847e
	bmi rui_0b848f
rui_0b8480
	cmp #$0008
rui_0b8483
	bcs rui_0b848f
rui_0b8485
	lda #$ffff
rui_0b8488
	sta.w race_frontsoundramp
rui_0b848b
	lda x1
rui_0b848d
	bra rui_0b8492
rui_0b848f
	lda.w race_frontsoundramp
rui_0b8492
	a8
rui_0b8494
	sta.l race_frontsoundoutput
	php
	a8
	lda.l race_frontsoundoutput
	sta.l racesound_nearparam
	plp
rui_0b8498
	plp
rui_0b8499
	rtl
	longa
rui_0b849a
	lda x1
rui_0b849c
	a8
rui_0b849e
	plx
rui_0b849f
	sta.l race_frontsoundoutput
	php
	a8
	lda.l race_frontsoundoutput
	sta.l racesound_nearparam
	plp
rui_0b84a3
	plp
rui_0b84a4
	rtl
rui_0b84a5
	ai16
rui_0b84a7
	lda.w race_input1
rui_0b84aa
	bit #$8000
rui_0b84ad
	bne rui_0b84c2
rui_0b84af
	lda.w race_frontsoundramp
rui_0b84b2
	beq rui_0b84d4
rui_0b84b4
	sec
rui_0b84b5
	sbc #$0006
rui_0b84b8
	bpl rui_0b84bd
rui_0b84ba
	lda #$0000
rui_0b84bd
	sta.w race_frontsoundramp
rui_0b84c0
	bra rui_0b84d4
rui_0b84c2
	lda.w race_frontsoundramp
rui_0b84c5
	clc
rui_0b84c6
	adc #$0010
rui_0b84c9
	cmp #$007f
rui_0b84cc
	bcc rui_0b84d1
rui_0b84ce
	lda #$007f
rui_0b84d1
	sta.w race_frontsoundramp
rui_0b84d4
	lda.w race_frontsoundramp
rui_0b84d7
	a8
rui_0b84d9
	sta.l race_frontsoundoutput
	php
	a8
	lda.l race_frontsoundoutput
	sta.l racesound_nearparam
	plp
rui_0b84dd
	plp
rui_0b84de
	rtl
	longa
rui_texturestrip
	php
rui_0b84e0
	ai16
rui_0b84e2
	lda.l race_menuunknown5
rui_0b84e6
	clc
rui_0b84e7
	adc #$0400
rui_0b84ea
	and #$1fff
rui_0b84ed
	sta.l race_menuunknown5
rui_0b84f1
	clc
rui_0b84f2
	adc #race_fronttexture&WM
rui_0b84f5
	ai16
rui_0b84f7
	sta.w race_transfersource
rui_0b84fa
	lda #$0400
rui_0b84fd
	sta.w race_transferbytes
rui_0b8500
	lda #race_fronttexture>>16
rui_0b8503
	sta.w race_transferbank
rui_0b8506
	lda #$2000
rui_0b8509
	sta.w race_transferdest
rui_0b850c
	jsl retail_queuegraphics_l
rui_0b8510
	a16
rui_0b8512
	i16
rui_0b8514
	a8
rui_0b8516
	lda.w race_displayrequests
rui_0b8519
	ora #$02
rui_0b851b
	sta.w race_displayrequests
rui_0b851e
	plp
rui_0b851f
	rtl
	longa
rui_frameblank
	php
rui_0b852c
	ai16
rui_0b852e
	stz.w race_frontwait
rui_0b8531
	jsl retail_stagebitmap_l
rui_0b8534
	jsl retail_frontwindow_l
rui_0b8537
	a8
rui_0b8539
	lda.w race_displayrequests
rui_0b853c
	and #$20
rui_0b853e
	bne rui_0b8549
rui_0b8540
	jsl retail_publishpalette_l
rui_0b8543
	jsl retail_flushgraphics_l
rui_0b8546
	jsl retail_publishoam_l
rui_0b8549
	jsl retail_flushregisters_l
rui_0b854c
	a16
rui_0b854e
	lda.l race_menuactive
rui_0b8552
	beq rui_0b8590
rui_0b8554
	lda.l race_menuunknown7
rui_0b8558
	inc a
rui_0b8559
	sta.l race_menuunknown7
rui_0b855d
	cmp #$0005
rui_0b8560
	bne rui_0b8575
rui_0b8562
	lda #$0000
rui_0b8565
	sta.l race_menuunknown7
rui_0b8569
	lda.l race_menuunknown6
rui_0b856d
	inc a
rui_0b856e
	and #$0001
rui_0b8571
	sta.l race_menuunknown6
rui_0b8575
	lda.l race_menuunknown6
rui_0b8579
	asl a
rui_0b857a
	tax
rui_0b857b
	a8
rui_0b857d
	lda #$d9
rui_0b857f
	sta.w $2121
rui_0b8582
	lda.l retail_frontflash,x
rui_0b8586
	sta.w $2122
rui_0b8589
	lda.l retail_frontflash+1,x
rui_0b858d
	sta.w $2122
	longa
rui_0b8590
	a16
rui_0b8592
	jsl retail_stepbrightness_l
rui_0b8595
	a8
rui_0b8597
	lda.w race_displayrequests
rui_0b859a
	and #$df
rui_0b859c
	sta.w race_displayrequests
rui_0b859f
	lda.w $4212
rui_0b85a2
	and #$01
rui_0b85a4
	bne rui_0b859f
rui_0b85a6
	plp
rui_0b85a7
	rtl
	longa
rui_framesample
	a16
rui_0b8874
	lda.l race_frontscroll2
rui_0b8878
	sta.l race_frontscroll0
rui_0b887c
	lda.l race_frontscroll3
rui_0b8880
	sta.l race_frontscroll1
rui_0b8884
	lda.w race_frontinput0
rui_0b8887
	jsl retail_pushinput0_l
rui_0b888a
	lda.w race_frontinput1
rui_0b888d
	jsl retail_pushinput1_l
rui_0b8890
	a8
rui_0b8892
	inc.w framecounter
rui_0b8895
	inc.w framec
rui_0b8898
	inc framecnt
rui_0b889a
	lda.w race_frontbright
rui_0b889d
	sta.w $2100
rui_0b88a0
	rtl
	longa
rui_probeport
	php
rui_0b88ce
	ai8
rui_0b88d0
	tax
rui_0b88d1
	lda #$01
rui_0b88d3
	sta.w $4016
rui_0b88d6
	stz.w race_frontprobe
rui_0b88d9
	ldy #$07
rui_0b88db
	lda.w $4016,x
rui_0b88de
	and #$02
rui_0b88e0
	beq rui_0b88e8
rui_0b88e2
	sec
rui_0b88e3
	rol race_frontprobe
rui_0b88e6
	bra rui_0b88ec
rui_0b88e8
	clc
rui_0b88e9
	rol race_frontprobe
rui_0b88ec
	dey
rui_0b88ed
	bpl rui_0b88db
rui_0b88ef
	lda.w race_frontprobe
rui_0b88f2
	cmp #$ff
rui_0b88f4
	bne rui_0b8924
rui_0b88f6
	lda #$00
rui_0b88f8
	sta.w $4016
rui_0b88fb
	stz.w race_frontprobe
rui_0b88fe
	ldy #$07
rui_0b8900
	lda.w $4016,x
rui_0b8903
	and #$02
rui_0b8905
	beq rui_0b890d
rui_0b8907
	sec
rui_0b8908
	rol race_frontprobe
rui_0b890b
	bra rui_0b8911
rui_0b890d
	clc
rui_0b890e
	rol race_frontprobe
rui_0b8911
	dey
rui_0b8912
	bpl rui_0b8900
rui_0b8914
	lda.w race_frontprobe
rui_0b8917
	cmp #$ff
rui_0b8919
	beq rui_0b8924
rui_0b891b
	a16
rui_0b891d
	lda #$0001
rui_0b8920
	sta.l race_frontdevice
	shorta
rui_0b8924
	a8
rui_0b8926
	lda #$00
rui_0b8928
	sta.w $4016
rui_0b892b
	a16
rui_0b892d
	plp
rui_0b892e
	rts
	longi
rui_audiolabels
	jsl retail_clonespritelist_l
rui_0bc470
	jsr rui_audiofields
rui_0bc473
	ldx.w race_entitycurrent
rui_0bc476
	lda #rhk_0bc47b&WM
rui_0bc479
	sta $08,x
rui_0bc47b
	rts
rui_audiofields
	jsr rui_audioselect
rui_0bc4ac
	sta.w race_menuwork1
rui_0bc4af
	jsr rui_audioblink
rui_0bc4b2
	lda.w race_menuwork1
rui_0bc4b5
	clc
rui_0bc4b6
	adc #$0008
rui_0bc4b9
	sta.w race_menuwork1
rui_0bc4bc
	jsr rui_audioblink
rui_0bc4bf
	lda #$0009
rui_0bc4c2
	jsl retail_findentity_l
rui_0bc4c5
	ldy #$002a
rui_0bc4c8
	lda.l race_menuaudio0
rui_0bc4cc
	jsr rui_audiodigits
rui_0bc4cf
	ldy #$001a
rui_0bc4d2
	lda.l race_menuaudio1
rui_0bc4d6
	jsr rui_audiodigits
rui_0bc4d9
	ldy #$000a
rui_0bc4dc
	lda.l race_menuaudio2
rui_0bc4e0
	jsr rui_audiodigits
rui_0bc4e3
	rts
rui_audiodigits
	phx
rui_0bc4e5
	pha
rui_0bc4e6
	tya
rui_0bc4e7
	clc
rui_0bc4e8
	adc $12,x
rui_0bc4ea
	sta.w race_menuwork1
rui_0bc4ed
	pla
rui_0bc4ee
	asl a
rui_0bc4ef
	tax
rui_0bc4f0
	lda.l retail_audioglyphs,x
rui_0bc4f4
	sta.w race_oambits
rui_0bc4f7
	ldx.w race_menuwork1
rui_0bc4fa
	lda.l race_spritelists+4,x
rui_0bc4fe
	and #$fe00
rui_0bc501
	ora.w race_oambits
rui_0bc504
	sta.l race_spritelists+4,x
rui_0bc508
	lda.w race_oambits
rui_0bc50b
	clc
rui_0bc50c
	adc #$0010
rui_0bc50f
	sta.w race_oambits
rui_0bc512
	txa
rui_0bc513
	sec
rui_0bc514
	sbc #$0008
rui_0bc517
	tax
rui_0bc518
	lda.l race_spritelists+4,x
rui_0bc51c
	and #$fe00
rui_0bc51f
	ora.w race_oambits
rui_0bc522
	sta.l race_spritelists+4,x
rui_0bc526
	plx
rui_0bc527
	rts
rui_audioblink
	lda.w race_frontxor
rui_0bc579
	and #$0003
rui_0bc57c
	bne rui_0bc58c
rui_0bc57e
	ldx.w race_menuwork1
rui_0bc581
	lda.l race_spritelists+4,x
rui_0bc585
	eor #$0800
rui_0bc588
	sta.l race_spritelists+4,x
rui_0bc58c
	rts
rui_audioselect
	lda #$0002
rui_0bc590
	sec
rui_0bc591
	sbc.l race_menuunknown3
rui_0bc595
	asl a
rui_0bc596
	asl a
rui_0bc597
	asl a
rui_0bc598
	asl a
rui_0bc599
	clc
rui_0bc59a
	adc $12,x
rui_0bc59c
	inc a
rui_0bc59d
	inc a
rui_0bc59e
	rts
rui_logofadeout
	lda $0a,x
rui_0bc898
	beq rui_0bc8a2
rui_0bc89a
	dec a
rui_0bc89b
	dec a
rui_0bc89c
	sta $0a,x
rui_0bc89e
	jsr rui_logopalette
rui_0bc8a1
	rts
rui_0bc8a2
	lda #$0002
rui_0bc8a5
	ldy #$ffff
rui_0bc8a8
	jsl retail_entityvisibility_l
rui_0bc8ab
	lda #$0003
rui_0bc8ae
	ldy #$0000
rui_0bc8b1
	jsl retail_entityvisibility_l
rui_0bc8b4
	lda #rhk_logowait&WM
rui_0bc8b7
	sta $08,x
rui_0bc8b9
	lda #$001e
rui_0bc8bc
	sta $1e,x
rui_0bc8be
	rts
rui_logowait
	lda.l race_frontscroll3
rui_0bc8c3
	cmp #$0100
rui_0bc8c6
	bne rui_0bc90e
rui_0bc8c8
	lda #$0004
rui_0bc8cb
	ldy #$0000
rui_0bc8ce
	jsl retail_entityvisibility_l
rui_0bc8d1
	lda #$0005
rui_0bc8d4
	ldy #$0000
rui_0bc8d7
	jsl retail_entityvisibility_l
rui_0bc8da
	phx
rui_0bc8db
	lda #$0006
rui_0bc8de
	jsl retail_findentity_l
rui_0bc8e1
	lda $14,x
rui_0bc8e3
	cmp #$00ae
rui_0bc8e6
	beq rui_0bc8f1
rui_0bc8e8
	lda #$00ae
rui_0bc8eb
	sta $14,x
rui_0bc8ed
	stz $16,x
rui_0bc8ef
	stz $18,x
rui_0bc8f1
	lda #$0007
rui_0bc8f4
	jsl retail_findentity_l
rui_0bc8f7
	lda $14,x
rui_0bc8f9
	cmp #$00b8
rui_0bc8fc
	beq rui_0bc907
rui_0bc8fe
	lda #$00b8
rui_0bc901
	sta $14,x
rui_0bc903
	stz $16,x
rui_0bc905
	stz $18,x
rui_0bc907
	plx
rui_0bc908
	ldy.w race_entityindex
rui_0bc90b
	jsl retail_freeentity_l
rui_0bc90e
	rts
rui_logofadein
	jsl retail_brightcolor_l
rui_0bc962
	lda.l race_frontscroll3
rui_0bc966
	cmp #$00a8
rui_0bc969
	bne rui_0bc984
rui_0bc96b
	lda #$0003
rui_0bc96e
	ldy #$ffff
rui_0bc971
	jsl retail_entityvisibility_l
rui_0bc974
	lda #rhk_logofinish&WM
rui_0bc977
	sta $08,x
rui_0bc979
	stz $0a,x
rui_0bc97b
	lda #$0002
rui_0bc97e
	ldy #$0000
rui_0bc981
	jsl retail_entityvisibility_l
rui_0bc984
	rts
rui_logofinish
	jsl retail_brightcolor_l
rui_0bc9c7
	lda $0a,x
rui_0bc9c9
	cmp #$0020
rui_0bc9cc
	beq rui_0bc9d6
rui_0bc9ce
	inc a
rui_0bc9cf
	inc a
rui_0bc9d0
	sta $0a,x
rui_0bc9d2
	jsr rui_logopalette
rui_0bc9d5
	rts
rui_0bc9d6
	ldy.w race_entityindex
rui_0bc9d9
	jsl retail_freeentity_l
rui_0bc9dc
	rts
rui_logopalette
	sta.w race_oambits
rui_0bc9e0
	pha
rui_0bc9e1
	ldy #$0007
rui_0bc9e4
	ldx #$01a0
rui_0bc9e7
	jsl retail_scalepalette_l
rui_0bc9eb
	pla
rui_0bc9ec
	sta.w race_oambits
rui_0bc9ef
	ldy #$0007
rui_0bc9f2
	ldx #$0120
rui_0bc9f5
	jsl retail_scalepalette_l
rui_0bc9f9
	ldx.w race_entitycurrent
rui_0bc9fc
	rts
rui_optionstate
	lda.l race_menupending
rui_0bca6b
	cmp $20,x
rui_0bca6d
	bne rui_0bca7a
rui_0bca6f
	cmp.l race_menuunknown0
rui_0bca73
	beq rui_0bca7a
rui_0bca75
	lda #$0200
rui_0bca78
	sta $24,x
rui_0bca7a
	lda.l race_menuunknown0
rui_0bca7e
	cmp $20,x
rui_0bca80
	bne rui_0bca9f
rui_0bca82
	cmp.l race_menupending
rui_0bca86
	beq rui_0bca9f
rui_0bca88
	lda #$0a00
rui_0bca8b
	sta $24,x
rui_0bca8d
	lda $10,x
rui_0bca8f
	bmi rui_0bca9f
rui_0bca91
	lda #$0001
rui_0bca94
	sta $22,x
rui_0bca96
	stz $0a,x
rui_0bca98
	lda #$00ff
rui_0bca9b
	sta.l race_menuunknown4
rui_0bca9f
	lda.l race_menuunknown4
rui_0bcaa3
	bne rui_0bcab8
rui_0bcaa5
	lda.l race_menuunknown0
rui_0bcaa9
	cmp $20,x
rui_0bcaab
	bne rui_0bcab8
rui_0bcaad
	lda $10,x
rui_0bcaaf
	bmi rui_0bcab8
rui_0bcab1
	lda #$0001
rui_0bcab4
	sta $22,x
rui_0bcab6
	stz $0a,x
rui_0bcab8
	rts
rui_optionpalette
	lda $24,x
rui_0bcabb
	beq rui_0bcae5
rui_0bcabd
	sta.w race_oambits
rui_0bcac0
	phx
rui_0bcac1
	lda $12,x
rui_0bcac3
	tax
rui_0bcac4
	lda.l race_spritelists,x
rui_0bcac8
	tay
rui_0bcac9
	inx
rui_0bcaca
	inx
rui_0bcacb
	lda.l race_spritelists+4,x
rui_0bcacf
	and #$f1ff
rui_0bcad2
	ora.w race_oambits
rui_0bcad5
	sta.l race_spritelists+4,x
rui_0bcad9
	txa
rui_0bcada
	clc
rui_0bcadb
	adc #$0008
rui_0bcade
	tax
rui_0bcadf
	dey
rui_0bcae0
	bpl rui_0bcacb
rui_0bcae2
	plx
rui_0bcae3
	stz $24,x
rui_0bcae5
	rts
rui_option0
	jsl retail_clonespritelist_l
rui_0bcae9
	lda #rhk_0bcaee&WM
rui_0bcaec
	sta $08,x
rui_0bcaee
	jsr rui_optionstate
rui_0bcaf1
	stz.w race_spritesleft
rui_0bcaf4
	jsr rui_optionstep
rui_0bcaf7
	rts
rui_option1
	jsl retail_clonespritelist_l
rui_0bcafb
	lda #rhk_0bcb01&WM
rui_0bcafe
	sta $08,x
rui_0bcb00
	rts
rui_0bcb01
	lda #rhk_0bcb06&WM
rui_0bcb04
	sta $08,x
rui_0bcb06
	jsr rui_optionstate
rui_0bcb09
	lda #$0012
rui_0bcb0c
	sta.w race_spritesleft
rui_0bcb0f
	jsr rui_optionstep
rui_0bcb12
	rts
rui_option2
	jsl retail_clonespritelist_l
rui_0bcb16
	lda #rhk_0bcb1b&WM
rui_0bcb19
	sta $08,x
rui_0bcb1b
	jsr rui_optionstate
rui_0bcb1e
	lda #$0024
rui_0bcb21
	sta.w race_spritesleft
rui_0bcb24
	jsr rui_optionstep
rui_0bcb27
	rts
rui_option3
	lda.l race_menurecords+11
rui_0bcb2c
	and #$00ff
rui_0bcb2f
	cmp #$0000
rui_0bcb32
	beq rui_0bcb4f
rui_0bcb34
	jsl retail_clonespritelist_l
rui_0bcb37
	lda #rhk_0bcb3d&WM
rui_0bcb3a
	sta $08,x
rui_0bcb3c
	rts
rui_0bcb3d
	lda #rhk_0bcb42&WM
rui_0bcb40
	sta $08,x
rui_0bcb42
	jsr rui_optionstate
rui_0bcb45
	lda #$0038
rui_0bcb48
	sta.w race_spritesleft
rui_0bcb4b
	jsr rui_optionstep
rui_0bcb4e
	rts
rui_0bcb4f
	lda $14,x
rui_0bcb51
	cmp #$00fa
rui_0bcb54
	beq rui_0bcb5f
rui_0bcb56
	lda #$00fa
rui_0bcb59
	sta $14,x
rui_0bcb5b
	stz $16,x
rui_0bcb5d
	stz $18,x
rui_0bcb5f
	jsl retail_clonespritelist_l
rui_0bcb62
	lda #$0048
rui_0bcb65
	sta.w race_spritesleft
rui_0bcb68
	lda #$0000
rui_0bcb6b
	jsr rui_optiontiles
rui_0bcb6e
	lda #rhk_0bcb74&WM
rui_0bcb71
	sta $08,x
rui_0bcb73
	rts
rui_0bcb74
	jsr rui_optionstate
rui_0bcb77
	lda #$0048
rui_0bcb7a
	sta.w race_spritesleft
rui_0bcb7d
	jsr rui_optionstep
rui_0bcb80
	rts
rui_optionstep
	dec $1e,x
rui_0bcb83
	bmi rui_0bcb88
rui_0bcb85
	brl rui_0bcbba
rui_0bcb88
	lda $1c,x
rui_0bcb8a
	sta $1e,x
rui_0bcb8c
	jsr rui_optionpalette
rui_0bcb8f
	lda $22,x
rui_0bcb91
	bne rui_0bcb96
rui_0bcb93
	brl rui_0bcbba
rui_0bcb96
	lda $10,x
rui_0bcb98
	bpl rui_0bcb9f
rui_0bcb9a
	lda #$0002
rui_0bcb9d
	sta $0a,x
rui_0bcb9f
	lda $0a,x
rui_0bcba1
	dec a
rui_0bcba2
	and #$001f
rui_0bcba5
	sta $0a,x
rui_0bcba7
	bne rui_0bcbac
rui_0bcba9
	brl rui_0bcbbb
rui_0bcbac
	jsr rui_optiontiles
rui_0bcbaf
	lda $10,x
rui_0bcbb1
	bpl rui_0bcbba
rui_0bcbb3
	lda $0a,x
rui_0bcbb5
	cmp #$0001
rui_0bcbb8
	beq rui_0bcbbb
rui_0bcbba
	rts
rui_0bcbbb
	ldx.w race_entitycurrent
rui_0bcbbe
	stz $22,x
rui_0bcbc0
	stz $0a,x
rui_0bcbc2
	rts
rui_optiontiles
	asl a
rui_0bcbc4
	sta.w race_oambits
rui_0bcbc7
	lda $12,x
rui_0bcbc9
	tax
rui_0bcbca
	lda.l race_spritelists,x
rui_0bcbce
	inx
rui_0bcbcf
	inx
rui_0bcbd0
	stx.w race_menutemp
rui_0bcbd3
	tay
rui_0bcbd4
	ldx.w race_spritesleft
rui_0bcbd7
	lda.l retail_optiondest,x
rui_0bcbdb
	sta.w race_oamword
rui_0bcbde
	lda.l retail_optionsource,x
rui_0bcbe2
	sta.w race_menuwork2
rui_0bcbe5
	ldx.w race_oambits
rui_0bcbe8
	lda.l retail_optionframes,x
rui_0bcbec
	pha
rui_0bcbed
	and #$8000
rui_0bcbf0
	sta.w race_menuwork1
rui_0bcbf3
	ldx.w race_menutemp
rui_0bcbf6
	lda.l race_spritelists+4,x
rui_0bcbfa
	and #$7fff
rui_0bcbfd
	ora.w race_menuwork1
rui_0bcc00
	sta.l race_spritelists+4,x
rui_0bcc04
	pla
rui_0bcc05
	and #$7fff
rui_0bcc08
	clc
rui_0bcc09
	adc.w race_menuwork2
rui_0bcc0c
	pha
rui_0bcc0d
	ldx.w race_oamword
rui_0bcc10
	ai16
rui_0bcc12
	stx.w race_transferdest
rui_0bcc15
	sta.w race_transfersource
rui_0bcc18
	lda #$0040
rui_0bcc1b
	sta.w race_transferbytes
rui_0bcc1e
	lda #$007f
rui_0bcc21
	sta.w race_transferbank
rui_0bcc24
	jsl retail_queuegraphics_l
rui_0bcc28
	a16
rui_0bcc2a
	i16
rui_0bcc2c
	a8
rui_0bcc2e
	inc.w race_oamword+1
rui_0bcc31
	a16
rui_0bcc33
	ldx.w race_oamword
rui_0bcc36
	pla
rui_0bcc37
	clc
rui_0bcc38
	adc #$0200
rui_0bcc3b
	ai16
rui_0bcc3d
	stx.w race_transferdest
rui_0bcc40
	sta.w race_transfersource
rui_0bcc43
	lda #$0040
rui_0bcc46
	sta.w race_transferbytes
rui_0bcc49
	lda #$007f
rui_0bcc4c
	sta.w race_transferbank
rui_0bcc4f
	jsl retail_queuegraphics_l
rui_0bcc53
	a16
rui_0bcc55
	i16
rui_0bcc57
	inc.w race_spritesleft
rui_0bcc5a
	inc.w race_spritesleft
rui_0bcc5d
	lda.w race_oambits
rui_0bcc60
	inc a
rui_0bcc61
	inc a
rui_0bcc62
	and #$003f
rui_0bcc65
	sta.w race_oambits
rui_0bcc68
	lda.w race_menutemp
rui_0bcc6b
	clc
rui_0bcc6c
	adc #$0008
rui_0bcc6f
	sta.w race_menutemp
rui_0bcc72
	dey
rui_0bcc73
	bmi rui_0bcc78
rui_0bcc75
	brl rui_0bcbd4
rui_0bcc78
	ldx.w race_entitycurrent
rui_0bcc7b
	rts
rui_logodelay
	ai16
rui_0bcd6e
	jsl retail_stepentityanim_l
rui_0bcd71
	dec $0a,x
rui_0bcd73
	bpl rui_0bcd7b
rui_0bcd75
	lda #$0001
rui_0bcd78
	sta.w race_menuexit
rui_0bcd7b
	rts
rui_logostart
	dec $0a,x
rui_0bcd7e
	bmi rui_0bcd83
rui_0bcd80
	brl rui_0bce18
rui_0bcd83
	lda #rhk_logobounce&WM
rui_0bcd86
	sta $08,x
rui_0bcd88
	lda #$0001
rui_0bcd8b
	sta $22,x
rui_0bcd8d
	lda #$0000
rui_0bcd90
	sec
rui_0bcd91
	sbc $20,x
rui_0bcd93
	a8
rui_0bcd95
	xba
rui_0bcd96
	a8
rui_0bcd98
	i16
rui_0bcd9a
	phx
rui_0bcd9b
	ldx #$210e
rui_0bcd9e
	jsl retail_queueregister_l
rui_0bcda2
	plx
rui_0bcda3
	xba
rui_0bcda4
	a8
rui_0bcda6
	i16
rui_0bcda8
	phx
rui_0bcda9
	ldx #$210e
rui_0bcdac
	jsl retail_queueregister_l
rui_0bcdb0
	plx
rui_0bcdb1
	lda #$10
rui_0bcdb3
	a8
rui_0bcdb5
	i16
rui_0bcdb7
	phx
rui_0bcdb8
	ldx #$420c
rui_0bcdbb
	jsl retail_queueregister_l
rui_0bcdbf
	plx
rui_0bcdc0
	lda #$00
rui_0bcdc2
	a8
rui_0bcdc4
	i16
rui_0bcdc6
	phx
rui_0bcdc7
	ldx #$212f
rui_0bcdca
	jsl retail_queueregister_l
rui_0bcdce
	plx
rui_0bcdcf
	a8
rui_0bcdd1
	i16
rui_0bcdd3
	phx
rui_0bcdd4
	ldx #$2130
rui_0bcdd7
	jsl retail_queueregister_l
rui_0bcddb
	plx
rui_0bcddc
	a8
rui_0bcdde
	i16
rui_0bcde0
	phx
rui_0bcde1
	ldx #$2131
rui_0bcde4
	jsl retail_queueregister_l
rui_0bcde8
	plx
rui_0bcde9
	lda #$69
rui_0bcdeb
	a8
rui_0bcded
	i16
rui_0bcdef
	phx
rui_0bcdf0
	ldx #$2107
rui_0bcdf3
	jsl retail_queueregister_l
rui_0bcdf7
	plx
rui_0bcdf8
	lda #$61
rui_0bcdfa
	a8
rui_0bcdfc
	i16
rui_0bcdfe
	phx
rui_0bcdff
	ldx #$2108
rui_0bce02
	jsl retail_queueregister_l
rui_0bce06
	plx
rui_0bce07
	lda #$04
rui_0bce09
	a8
rui_0bce0b
	i16
rui_0bce0d
	phx
rui_0bce0e
	ldx #$210b
rui_0bce11
	jsl retail_queueregister_l
rui_0bce15
	plx
rui_0bce16
	a16
rui_0bce18
	rts
rui_logobounce
	jsl retail_stepentityanim_l
rui_0bce1c
	lda $0a,x
rui_0bce1e
	inc a
rui_0bce1f
	and #$0001
rui_0bce22
	sta $0a,x
rui_0bce24
	bne rui_0bce2e
rui_0bce26
	lda $22,x
rui_0bce28
	clc
rui_0bce29
	adc #$0001
rui_0bce2c
	sta $22,x
rui_0bce2e
	lda $20,x
rui_0bce30
	clc
rui_0bce31
	adc $22,x
rui_0bce33
	sta $20,x
rui_0bce35
	lda $20,x
rui_0bce37
	bmi rui_0bce51
rui_0bce39
	lda $22,x
rui_0bce3b
	dec a
rui_0bce3c
	dec a
rui_0bce3d
	bmi rui_0bce80
rui_0bce3f
	eor #$ffff
rui_0bce42
	inc a
rui_0bce43
	sta $22,x
rui_0bce45
	stz $20,x
rui_0bce47
	a8
rui_0bce49
	lda #$19
rui_0bce4b
	jsl queue_raceplayer_l
rui_0bce4f
	a16
rui_0bce51
	lda #$0000
rui_0bce54
	sec
rui_0bce55
	sbc $20,x
rui_0bce57
	a8
rui_0bce59
	xba
rui_0bce5a
	a8
rui_0bce5c
	i16
rui_0bce5e
	phx
rui_0bce5f
	ldx #$210e
rui_0bce62
	jsl retail_queueregister_l
rui_0bce66
	plx
rui_0bce67
	xba
rui_0bce68
	a8
rui_0bce6a
	i16
rui_0bce6c
	phx
rui_0bce6d
	ldx #$210e
rui_0bce70
	jsl retail_queueregister_l
rui_0bce74
	plx
rui_0bce75
	a16
rui_0bce77
	lda $20,x
rui_0bce79
	clc
rui_0bce7a
	adc #$004d
rui_0bce7d
	sta $06,x
rui_0bce7f
	rts
rui_0bce80
	ldx.w race_entitycurrent
rui_0bce83
	lda #rhk_logoidle&WM
rui_0bce86
	sta $08,x
rui_0bce88
	rts
rui_logoidle
	rts
rui_palettedelay
	dec $0a,x
rui_0bcf9e
	bpl rui_0bcfaa
rui_0bcfa0
	lda #rhk_palettecrossfade&WM
rui_0bcfa3
	sta $08,x
rui_0bcfa5
	lda #$0000
rui_0bcfa8
	sta $0a,x
rui_0bcfaa
	rts
rui_palettecrossfade
	lda $0a,x
rui_0bcfad
	inc a
rui_0bcfae
	cmp #$0040
rui_0bcfb1
	beq rui_0bcfdf
rui_0bcfb3
	sta $0a,x
rui_0bcfb5
	lsr a
rui_0bcfb6
	asl a
rui_0bcfb7
	tax
rui_0bcfb8
	lda.l retail_crossfadelevels,x
rui_0bcfbc
	sta.w race_oambits
rui_0bcfbf
	ldy #$003f
rui_0bcfc2
	ldx #$0080
rui_0bcfc5
	jsl retail_scalepalette_l
rui_0bcfc9
	lda.w race_oambits
rui_0bcfcc
	dec a
rui_0bcfcd
	eor #$001f
rui_0bcfd0
	inc a
rui_0bcfd1
	sta.w race_oambits
rui_0bcfd4
	ldy #$0003
rui_0bcfd7
	ldx #$0018
rui_0bcfda
	jsl retail_scalepalette_l
rui_0bcfde
	rts
rui_0bcfdf
	lda #rhk_logoidle&WM
rui_0bcfe2
	sta $08,x
rui_0bcfe4
	rts
rui_newmenuitem
	a16
rui_0be4b5
	txy
rui_0be4b6
	jsl retail_newentity_l
rui_0be4b9
	cpx #$ffff
rui_0be4bc
	bne rui_0be4c1
rui_0be4be
	brl rui_0be4e3
rui_0be4c1
	stx.w race_newentity
rui_0be4c4
	tyx
rui_0be4c5
	lda.l retail_menuitems,x
rui_0be4c9
	bmi rui_0be4df
rui_0be4cb
	clc
rui_0be4cc
	adc.w race_newentity
rui_0be4cf
	tay
rui_0be4d0
	lda.l retail_menuitems+2,x
rui_0be4d4
	sta.w $0000,y
rui_0be4d7
	txa
rui_0be4d8
	clc
rui_0be4d9
	adc #$0004
rui_0be4dc
	tax
rui_0be4dd
	bra rui_0be4c5
rui_0be4df
	ldx.w race_newentity
rui_0be4e2
	rts
rui_0be4e3
	ldx #$ffff
rui_0be4e6
	rts
retail_bar16_l equ rui_bar16
retail_bar16body_l
	jsr rui_bar16body
	rtl
retail_bar8_l equ rui_bar8
retail_bar8body_l
	jsr rui_bar8body
	rtl
retail_mapicons_l equ rui_mapicons
retail_coursetiles_l equ rui_coursetiles
retail_courseblock_l
	jsr rui_courseblock
	rtl
retail_frontsound_l equ rui_frontsound
retail_texturestrip_l equ rui_texturestrip
retail_frameblank_l equ rui_frameblank
retail_framesample_l equ rui_framesample
retail_probeport_l
	jsr rui_probeport
	rtl
retail_audiolabels_l
	jsr rui_audiolabels
	rtl
retail_audiofields_l
	jsr rui_audiofields
	rtl
retail_audiodigits_l
	jsr rui_audiodigits
	rtl
retail_audioblink_l
	jsr rui_audioblink
	rtl
retail_audioselect_l
	jsr rui_audioselect
	rtl
retail_logofadeout_l
	jsr rui_logofadeout
	rtl
retail_logowait_l
	jsr rui_logowait
	rtl
retail_logofadein_l
	jsr rui_logofadein
	rtl
retail_logofinish_l
	jsr rui_logofinish
	rtl
retail_logopalette_l
	jsr rui_logopalette
	rtl
retail_optionstate_l
	jsr rui_optionstate
	rtl
retail_optionpalette_l
	jsr rui_optionpalette
	rtl
retail_option0_l
	jsr rui_option0
	rtl
retail_option1_l
	jsr rui_option1
	rtl
retail_option2_l
	jsr rui_option2
	rtl
retail_option3_l
	jsr rui_option3
	rtl
retail_optionstep_l
	jsr rui_optionstep
	rtl
retail_optiontiles_l
	jsr rui_optiontiles
	rtl
retail_logodelay_l
	jsr rui_logodelay
	rtl
retail_logostart_l
	jsr rui_logostart
	rtl
retail_logobounce_l
	jsr rui_logobounce
	rtl
retail_logoidle_l
	jsr rui_logoidle
	rtl
retail_palettedelay_l
	jsr rui_palettedelay
	rtl
retail_palettecrossfade_l
	jsr rui_palettecrossfade
	rtl
retail_newmenuitem_l
	jsr rui_newmenuitem
	rtl
ruc_audiolabels
	jsr rui_audiolabels
	rtl
ruc_0bc47b
	jsr rui_0bc47b
	rtl
ruc_logofadeout
	jsr rui_logofadeout
	rtl
ruc_logowait
	jsr rui_logowait
	rtl
ruc_logofadein
	jsr rui_logofadein
	rtl
ruc_logofinish
	jsr rui_logofinish
	rtl
ruc_option0
	jsr rui_option0
	rtl
ruc_0bcaee
	jsr rui_0bcaee
	rtl
ruc_option1
	jsr rui_option1
	rtl
ruc_0bcb01
	jsr rui_0bcb01
	rtl
ruc_0bcb06
	jsr rui_0bcb06
	rtl
ruc_option2
	jsr rui_option2
	rtl
ruc_0bcb1b
	jsr rui_0bcb1b
	rtl
ruc_option3
	jsr rui_option3
	rtl
ruc_0bcb3d
	jsr rui_0bcb3d
	rtl
ruc_0bcb42
	jsr rui_0bcb42
	rtl
ruc_0bcb74
	jsr rui_0bcb74
	rtl
ruc_logodelay
	jsr rui_logodelay
	rtl
ruc_logostart
	jsr rui_logostart
	rtl
ruc_logobounce
	jsr rui_logobounce
	rtl
ruc_logoidle
	jsr rui_logoidle
	rtl
ruc_palettedelay
	jsr rui_palettedelay
	rtl
ruc_palettecrossfade
	jsr rui_palettecrossfade
	rtl
retail_bar16forms
	dw $3c20
	dw $3622
	dw $3622
	dw $3622
	dw $3c20
	dw $3622
	dw $3622
	dw $3622
	dw $3c20
	dw $3c20
	dw $3622
	dw $3622
	dw $3c20
	dw $3c20
	dw $3c20
	dw $3622
retail_bar16forms_end
retail_bar8forms
	dw $3c1f
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $0000
	dw $0000
	dw $3c1f
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $0000
	dw $0000
	dw $3c1f
	dw $3c1f
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $0000
	dw $0000
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1e
	dw $3c1e
	dw $3c1e
	dw $0000
	dw $0000
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1e
	dw $3c1e
	dw $0000
	dw $0000
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1e
	dw $0000
	dw $0000
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $3c1f
	dw $0000
	dw $0000
	dw $c208
	dw $a230
	dw $0000
	dw $bdbf
	dw $7eff
	dw $03d0
retail_bar8forms_end
retail_mapiconforms
	dw $0000
	dw $362e
	dw $362f
	dw $362f
	dw $363e
	dw $363f
	dw $362e
	dw $363f
retail_mapiconforms_end
retail_courseblocks
	dw $0000
	dw $0001
	dw $0002
	dw $0003
	dw $0004
	dw $0005
	dw $0006
	dw $0007
	dw $0008
	dw $0009
	dw $000a
	dw $000b
	dw $000c
	dw $000d
	dw $000e
	dw $000f
	dw $0010
	dw $0011
	dw $0012
	dw $0013
	dw $0014
	dw $0015
	dw $0016
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0017
retail_courseblocks_end
retail_frontflash
	dw $033f
	dw $77ff
retail_frontflash_end
retail_audioglyphs
	dw $000a
	dw $000b
	dw $000c
	dw $000d
	dw $000e
	dw $000f
	dw $0020
	dw $0021
	dw $0022
	dw $0023
	dw $0024
	dw $0025
	dw $0026
	dw $0027
	dw $0028
	dw $0029
	dw $002a
	dw $002b
	dw $002c
	dw $002d
	dw $002e
	dw $002f
	dw $0040
	dw $0041
	dw $0042
	dw $0043
	dw $0044
	dw $0045
	dw $0046
	dw $0000
	dw $0001
	dw $0002
	dw $0003
	dw $0004
	dw $0005
	dw $0006
	dw $0007
	dw $0008
	dw $0009
retail_audioglyphs_end
retail_optionframes
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0140
	dw $0100
	dw $00c0
	dw $0080
	dw $0040
	dw $8000
	dw $8040
	dw $8080
	dw $80c0
	dw $8100
	dw $8140
	dw $8180
	dw $81c0
	dw $8400
	dw $8440
	dw $0480
	dw $0440
	dw $0400
	dw $01c0
	dw $0180
retail_optionframes_end
retail_optiondest
	dw $5000
	dw $5020
	dw $5040
	dw $5060
	dw $5080
	dw $50a0
	dw $50c0
	dw $50e0
	dw $5200
	dw $5220
	dw $5240
	dw $5260
	dw $5280
	dw $52a0
	dw $52c0
	dw $52e0
	dw $5400
	dw $5420
	dw $5440
	dw $5460
	dw $5480
	dw $54a0
	dw $54c0
	dw $54e0
	dw $5600
	dw $5620
	dw $5640
	dw $5660
	dw $5680
	dw $56a0
	dw $56c0
	dw $56e0
	dw $5800
	dw $5820
	dw $5840
	dw $5860
	dw $5680
	dw $56a0
	dw $56c0
	dw $56e0
	dw $5800
	dw $5820
	dw $5840
	dw $5860
retail_optiondest_end
retail_optionsource
	dw (race_menugraphics&WM)
	dw (race_menugraphics&WM)+2048
	dw (race_menugraphics&WM)+4096
	dw (race_menugraphics&WM)+4096
	dw (race_menugraphics&WM)+6144
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+10240
	dw (race_menugraphics&WM)+12288
	dw (race_menugraphics&WM)+14336
	dw (race_menugraphics&WM)
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+16384
	dw (race_menugraphics&WM)+18432
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+10240
	dw (race_menugraphics&WM)+12288
	dw (race_menugraphics&WM)+14336
	dw (race_menugraphics&WM)+20480
	dw (race_menugraphics&WM)+12288
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+22528
	dw (race_menugraphics&WM)+4096
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+10240
	dw (race_menugraphics&WM)+12288
	dw (race_menugraphics&WM)+14336
	dw (race_menugraphics&WM)+24576
	dw (race_menugraphics&WM)+10240
	dw (race_menugraphics&WM)+4096
	dw (race_menugraphics&WM)+4096
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+10240
	dw (race_menugraphics&WM)+12288
	dw (race_menugraphics&WM)+14336
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+4096
	dw (race_menugraphics&WM)
	dw (race_menugraphics&WM)+8192
	dw (race_menugraphics&WM)+10240
	dw (race_menugraphics&WM)+16384
	dw (race_menugraphics&WM)+18432
	dw (race_menugraphics&WM)+18432
retail_optionsource_end
retail_crossfadelevels
	dw $0001
	dw $0002
	dw $0003
	dw $0004
	dw $0005
	dw $0006
	dw $0007
	dw $0008
	dw $0009
	dw $000a
	dw $000b
	dw $000c
	dw $000d
	dw $000e
	dw $000f
	dw $0010
	dw $0011
	dw $0012
	dw $0013
	dw $0014
	dw $0015
	dw $0016
	dw $0017
	dw $0018
	dw $0019
	dw $001a
	dw $001b
	dw $001c
	dw $001d
	dw $001e
	dw $001f
	dw $0020
retail_crossfadelevels_end
retail_menuitems
retail_menuitem0000
	dw 2,$0080
	dw 6,$0070
	dw 8,rhk_logodelay&WM
	dw 10,$0078
	dw 26,$000f
	dw 20,$0012
	dw -1
retail_menuitem001a
	dw 2,$0080
	dw 6,$0090
	dw 8,rhk_delayanim&WM
	dw 26,$0010
	dw 20,$0024
	dw 16,$ffff
	dw -1
retail_menuitem0034
	dw 2,$0080
	dw 6,$0088
	dw 30,$00f2
	dw 20,$0002
	dw 8,rhk_titleinput&WM
	dw 26,$0012
	dw -1
retail_menuitem004e
	dw 2,$0080
	dw 6,$00ce
	dw 20,$000c
	dw 8,rhk_delayanim&WM
	dw 26,$0011
	dw -1
retail_menuitem0064
	dw 16,$ffff
	dw 10,$0040
	dw 8,rhk_palettedelay&WM
	dw -1
retail_menuitem0072
	dw 2,$0080
	dw 32,$ff80
	dw 10,$0080
	dw 20,$ffff
	dw 8,rhk_logostart&WM
	dw 26,$0013
	dw -1
retail_menuitem008c
	dw 2,$0008
	dw 6,$0047
	dw 8,rhk_delayanim&WM
	dw 20,$002a
	dw 26,$0001
	dw -1
retail_menuitem00a2
	dw 2,$0080
	dw 6,$006a
	dw 8,rhk_option0&WM
	dw 20,$00e2
	dw 26,$0002
	dw 10,$0003
	dw 28,$0003
	dw 30,$0001
	dw 32,$0000
	dw -1
retail_menuitem00c8
	dw 2,$0080
	dw 6,$0080
	dw 8,rhk_option1&WM
	dw 20,$00e8
	dw 26,$0002
	dw 10,$0009
	dw 28,$0003
	dw 30,$0001
	dw 32,$0001
	dw -1
retail_menuitem00ee
	dw 2,$0080
	dw 6,$0096
	dw 8,rhk_option2&WM
	dw 20,$00ee
	dw 26,$0002
	dw 10,$0012
	dw 28,$0003
	dw 30,$0003
	dw 32,$0002
	dw -1
retail_menuitem0114
	dw 2,$0080
	dw 6,$00ac
	dw 8,rhk_option3&WM
	dw 20,$00f4
	dw 26,$0002
	dw 10,$0018
	dw 28,$0003
	dw 30,$0003
	dw 32,$0003
	dw -1
retail_menuitem013a
	dw 2,$00d0
	dw 6,$0092
	dw 8,rhk_trackleft&WM
	dw 20,$0030
	dw 26,$0003
	dw -1
retail_menuitem0150
	dw 2,$0054
	dw 6,$0054
	dw 8,rhk_delayanim&WM
	dw 20,$008a
	dw 16,$ffff
	dw 26,$0004
	dw -1
retail_menuitem016a
	dw 2,$0054
	dw 6,$00c4
	dw 8,rhk_delayanim&WM
	dw 20,$0096
	dw 16,$ffff
	dw 26,$0005
	dw -1
retail_menuitem0184
	dw 2,$0015
	dw 6,$0088
	dw 8,rhk_delayanim&WM
	dw 20,$00c2
	dw 26,$0006
	dw -1
retail_menuitem019a
	dw 2,$00ec
	dw 6,$0088
	dw 8,rhk_trackright&WM
	dw 20,$00c8
	dw 26,$0007
	dw -1
retail_menuitem01b0
	dw 2,$0054
	dw 6,$00a2
	dw 8,rhk_delayanim&WM
	dw 20,$0048
	dw 16,$ffff
	dw 26,$0008
	dw -1
retail_menuitem01ca
	dw 2,$0071
	dw 6,$00a7
	dw 8,rhk_audiolabels&WM
	dw 20,$004e
	dw 16,$ffff
	dw 26,$0009
	dw -1
retail_menuitem01e4
	dw 2,$0034
	dw 6,$0088
	dw 8,rhk_delayanim&WM
	dw 20,$0112
	dw 16,$ffff
	dw 26,$000a
	dw -1
retail_menuitem01fe
	dw 2,$0054
	dw 6,$0088
	dw 8,rhk_delayanim&WM
	dw 20,$012a
	dw 16,$ffff
	dw 26,$000b
	dw -1
retail_menuitem0218
	dw 2,$0074
	dw 6,$0088
	dw 8,rhk_delayanim&WM
	dw 20,$0142
	dw 16,$ffff
	dw 26,$000c
	dw -1
retail_menuitem0232
	dw 2,$0054
	dw 6,$0088
	dw 8,rhk_delayanim&WM
	dw 20,$005a
	dw 16,$ffff
	dw 26,$000d
	dw -1
retail_menuitem024c
	dw 2,$0054
	dw 6,$00c4
	dw 8,rhk_delayanim&WM
	dw 20,$0054
	dw 16,$ffff
	dw 26,$000e
	dw -1
retail_menuitem0266
; Scene-owning controllers are not available in this catalogue.
	dw -1
	dw -1
	dw -1
	dw -1
	dw -1
retail_menuitem0270
	dw 8,rhk_logofadeout&WM
	dw 10,$0020
	dw 16,$ffff
	dw -1
retail_menuitem027e
	dw 8,rhk_logofadein&WM
	dw 10,$0000
	dw 30,$0000
	dw 16,$ffff
	dw -1
retail_menuitems_end
mrui_end
