; Retail scene streams, contact effects and raw-car camera extensions.
; A8/I16, D=0, DB=$7E unless a specific entry changes its bank.
; Stream entry: A8=LoROM bank, X16=offset relative to $8000.
; Commands are even offsets; route command 4 terminates the stream.
; Bind a CPU actor pool first. Streams contain compiled strategy addresses;
; shape/header identities require the corresponding caller-bound assets.
; Native reset uses 310 records; the early arena has number_al records.
; Caller must bind an arena that ends before later buffers.
; The early map dispatcher and early camera ABI remain available.
	incpublics	mrviews.ext
mrviews_begin
	shorta
	longi
retail_propframe_l
	a16
rsv_03cbe2
	lda #$0000
rsv_03cbe5
	a8
rsv_03cbe7
	rtl
	longa
	longi
retail_resetboundpool_l
	php
rsv_03d3df
	a8
rsv_03d3e1
	phb
rsv_03d3e2
	lda #$7e
rsv_03d3e4
	pha
rsv_03d3e5
	plb
rsv_03d3e6
	ai16
rsv_03d3e8
	stz.w alxlst
rsv_03d3eb
	stz.w race_actorcurrent
rsv_03d3ee
	lda.w race_poolfirst
rsv_03d3f1
	sta.w alxfreelst
rsv_03d3f4
	ldy.w race_poolcount
rsv_03d3f7
	tax
rsv_03d3f8
	clc
rsv_03d3f9
	adc #alx_size
rsv_03d3fc
	sta.w al_next,x
rsv_03d3ff
	dey
rsv_03d400
	bne rsv_03d3f7
rsv_03d402
	stz.w al_next,x
rsv_03d405
	a8
rsv_03d407
	plb
rsv_03d408
	plp
rsv_03d409
	rtl
	shorta
	longi
retail_scenestream_l
	phb
rsv_08801d
	pha
rsv_08801e
	plb
rsv_nextcommand
	a16
rsv_088021
	lda.w $8000,x
rsv_088024
	and #$00ff
rsv_088027
	txy
rsv_088028
	tax
rsv_088029
	jmp (retail_mapdispatch,x)
rsv_maproute
	iny
rsv_08802d
	a16
rsv_08802f
	tya
rsv_088030
	clc
rsv_088031
	adc #$8000
rsv_088034
	sta.l m_routeptr
rsv_088038
	a8
rsv_08803a
	phb
rsv_08803b
	pla
rsv_08803c
	a16
rsv_08803e
	and #$00ff
rsv_088041
	sta.l m_routebank
rsv_088045
	a8
rsv_088047
	plb
rsv_088048
	rtl
	longa
	longi
rsv_mapactor
	jsr rsv_mapmakeactor
rsv_08804c
	tya
rsv_08804d
	clc
rsv_08804e
	adc #$0016
rsv_088051
	tax
rsv_088052
	jmp rsv_nextcommand
	longa
	longi
rsv_maproot
	jsr rsv_mapmakeactor
rsv_088058
	a8
rsv_08805a
	lda.l alx_flags+1,x
rsv_08805e
	ora #$01
rsv_088060
	sta.l alx_flags+1,x
rsv_088064
	a16
rsv_088066
	tya
rsv_088067
	clc
rsv_088068
	adc #$0016
rsv_08806b
	tax
rsv_08806c
	jmp rsv_nextcommand
	longa
	longi
rsv_mapnamed
	jsr rsv_mapmakeactor
rsv_088072
	a16
rsv_088074
	lda.w $8016,y
rsv_088077
	sta.l alx_sword1,x
rsv_08807b
	lda.w race_mapid
rsv_08807e
	inc a
rsv_08807f
	sta.w race_mapid
rsv_088082
	sta.l alx_sword2,x
rsv_088086
	tya
rsv_088087
	clc
rsv_088088
	adc #$0018
rsv_08808b
	tax
rsv_08808c
	jmp rsv_nextcommand
	longa
	longi
rsv_mapanimated
	jsr rsv_mapmakeactor
rsv_088092
	a8
rsv_088094
	lda.w $8016,y
rsv_088097
	sta.l alx_sbyte1,x
rsv_08809b
	ora #$80
rsv_08809d
	sta.l alx_colframe,x
rsv_0880a1
	lda.w $8017,y
rsv_0880a4
	sta.l alx_sbyte2,x
rsv_0880a8
	lda.w $8018,y
rsv_0880ab
	sta.l alx_sbyte3,x
rsv_0880af
	a16
rsv_0880b1
	tya
rsv_0880b2
	clc
rsv_0880b3
	adc #$0019
rsv_0880b6
	tax
rsv_0880b7
	jmp rsv_nextcommand
	longa
	longi
rsv_mapreset
	phy
rsv_0880bb
	a16
rsv_0880bd
	ldx #$0000
rsv_0880c0
	ldy #$0400
rsv_0880c3
	lda #$0000
rsv_0880c6
	sta.l race_cellheads,x
rsv_0880ca
	inx
rsv_0880cb
	inx
rsv_0880cc
	dey
rsv_0880cd
	bne rsv_0880c6
rsv_0880cf
	a8
rsv_0880d1
	lda #$00
rsv_0880d3
	sta.l race_mapyaw
rsv_0880d7
	a16
rsv_0880d9
	stz.w race_mapid
rsv_0880dc
	lda #$0000
rsv_0880df
	sta.l race_gridbytes
rsv_0880e3
	sta.l race_actorbytes
rsv_0880e7
	sta.l m_retailrouteword
rsv_0880eb
	sta.l race_feedbackmode
rsv_0880ef
	lda.w race_mapmode
rsv_0880f2
	and #$00ff
rsv_0880f5
	sta.l m_mapnumber
rsv_0880f9
	stz.w numalx
rsv_0880fc
	stz.w race_sceneoptions
rsv_0880ff
	a8
rsv_088101
	stz.w race_carphase
rsv_088104
	stz.w race_mapphase
rsv_088107
	a16
rsv_088109
	jsl retail_resetboundpool_l
rsv_08810d
	plx
rsv_08810e
	inx
rsv_08810f
	jmp rsv_nextcommand
	longa
	longi
rsv_mapyaw
	a8
rsv_088114
	lda.w $8001,y
rsv_088117
	sta.l race_mapyaw
rsv_08811b
	a16
rsv_08811d
	tya
rsv_08811e
	clc
rsv_08811f
	adc #$0002
rsv_088122
	tax
rsv_088123
	jmp rsv_nextcommand
	longa
	longi
rsv_mapcar
	lda.w race_scenephase
rsv_088129
	cmp #$0003
rsv_08812c
	bne rsv_088139
rsv_08812e
	lda.w $8018,y
rsv_088131
	and #$001c
rsv_088134
	beq rsv_088139
rsv_088136
	brl rsv_08818b
rsv_088139
	jsr rsv_mapmakeactor
rsv_08813c
	a8
rsv_08813e
	lda.w $8018,y
rsv_088141
	and #$01
rsv_088143
	beq rsv_088148
rsv_088145
	stx.w race_playeractor
rsv_088148
	lda.w $8018,y
rsv_08814b
	and #$02
rsv_08814d
	beq rsv_088152
rsv_08814f
	stx.w race_playeractor2
rsv_088152
	lda #$04
rsv_088154
	sta.l alx_sbyte4,x
rsv_088158
	lda.w $8019,y
rsv_08815b
	sta.l alx_roty,x
rsv_08815f
	a16
rsv_088161
	lda.w $8016,y
rsv_088164
	sta.l alx_sword1,x
rsv_088168
	phx
rsv_088169
	phy
rsv_08816a
	txy
rsv_08816b
	lda.l race_gridbytes
rsv_08816f
	tax
rsv_088170
	cmp #$0008
rsv_088173
	beq rsv_088189
rsv_088175
	inc a
rsv_088176
	inc a
rsv_088177
	sta.l race_gridbytes
rsv_08817b
	tya
rsv_08817c
	sta.l race_gridactors,x
rsv_088180
	inx
rsv_088181
	inx
rsv_088182
	lda #$0000
rsv_088185
	jsl retail_storegridsentinel_l
rsv_088189
	ply
rsv_08818a
	plx
rsv_08818b
	a16
rsv_08818d
	tya
rsv_08818e
	clc
rsv_08818f
	adc #$001a
rsv_088192
	tax
rsv_088193
	jmp rsv_nextcommand
	longa
	longi
rsv_mapgrid
	a16
rsv_088198
	lda.w $8001,y
rsv_08819b
	and #$00ff
rsv_08819e
	dec a
rsv_08819f
	asl a
rsv_0881a0
	asl a
rsv_0881a1
	asl a
rsv_0881a2
	tax
rsv_0881a3
	lda.w $8002,y
rsv_0881a6
	sta.l race_startgrid,x
rsv_0881aa
	lda.w $8004,y
rsv_0881ad
	sta.l race_startgrid+2,x
rsv_0881b1
	lda.w $8006,y
rsv_0881b4
	sta.l race_startgrid+4,x
rsv_0881b8
	a8
rsv_0881ba
	lda.w $8008,y
rsv_0881bd
	sta.l race_startgrid+6,x
rsv_0881c1
	a16
rsv_0881c3
	tya
rsv_0881c4
	clc
rsv_0881c5
	adc #$0009
rsv_0881c8
	tax
rsv_0881c9
	jmp rsv_nextcommand
	longa
	longi
rsv_mapflags
	a16
rsv_0881ce
	lda.l race_feedbackmode
rsv_0881d2
	ora.w $8001,y
rsv_0881d5
	sta.l m_retailrouteword
rsv_0881d9
	sta.l race_feedbackmode
rsv_0881dd
	tya
rsv_0881de
	clc
rsv_0881df
	adc #$0003
rsv_0881e2
	tax
rsv_0881e3
	jmp rsv_nextcommand
	longa
	longi
rsv_mapoptions
	a16
rsv_0881e8
	lda.w $8001,y
rsv_0881eb
	sta.l race_sceneoptions
rsv_0881ef
	tya
rsv_0881f0
	clc
rsv_0881f1
	adc #$0003
rsv_0881f4
	tax
rsv_0881f5
	jmp rsv_nextcommand
	longa
	longi
rsv_mapcamera1
	phy
rsv_0881f9
	a8
rsv_0881fb
	jsl retail_allocactor_l
rsv_0881ff
	bcs rsv_088204
rsv_088201
	brl rsv_mapfatal
rsv_088204
	txy
rsv_088205
	jsl retail_clearactor_l
rsv_088209
	ply
rsv_08820a
	stx.w race_cameraactor0
rsv_08820d
	lda #$03
rsv_08820f
	sta.l alx_sbyte4,x
rsv_088213
	a16
rsv_088215
	lda #viewcamera1
rsv_088218
	sta.l alx_viewpt,x
rsv_08821c
	lda.w $8001,y
rsv_08821f
	sta.l alx_stratptr,x
rsv_088223
	lda.w $8002,y
rsv_088226
	sta.l alx_stratptr+1,x
rsv_08822a
	tya
rsv_08822b
	clc
rsv_08822c
	adc #$0004
rsv_08822f
	tax
rsv_088230
	jmp rsv_nextcommand
	longa
	longi
rsv_mapcamera2
	phy
rsv_088234
	a8
rsv_088236
	jsl retail_allocactor_l
rsv_08823a
	bcs rsv_08823f
rsv_08823c
	brl rsv_mapfatal
rsv_08823f
	txy
rsv_088240
	jsl retail_clearactor_l
rsv_088244
	ply
rsv_088245
	stx.w race_cameraactor1
rsv_088248
	lda #$03
rsv_08824a
	sta.l alx_sbyte4,x
rsv_08824e
	a16
rsv_088250
	lda #viewcamera2
rsv_088253
	sta.l alx_viewpt,x
rsv_088257
	lda.w $8001,y
rsv_08825a
	sta.l alx_stratptr,x
rsv_08825e
	lda.w $8002,y
rsv_088261
	sta.l alx_stratptr+1,x
rsv_088265
	tya
rsv_088266
	clc
rsv_088267
	adc #$0004
rsv_08826a
	tax
rsv_08826b
	jmp rsv_nextcommand
	longa
	longi
rsv_mapmakeactor
	phy
rsv_08826f
	a8
rsv_088271
	jsl retail_allocactor_l
rsv_088275
	bcs rsv_08827a
rsv_088277
	brl rsv_mapfatal
rsv_08827a
	txy
rsv_08827b
	jsl retail_clearactor_l
rsv_08827f
	ply
rsv_088280
	a8
rsv_088282
	lda.l race_mapyaw
rsv_088286
	sta.l alx_roty,x
rsv_08828a
	a16
rsv_08828c
	lda.w $8007,y
rsv_08828f
	sta.l alx_shape,x
rsv_088293
	lda.w $8009,y
rsv_088296
	sta.l alx_expshape,x
rsv_08829a
	lda.w $8001,y
rsv_08829d
	sta.l alx_worldx,x
rsv_0882a1
	lda.w $8003,y
rsv_0882a4
	sta.l alx_worldy,x
rsv_0882a8
	lda.w $8005,y
rsv_0882ab
	sta.l alx_worldz,x
rsv_0882af
	lda.w $800b,y
rsv_0882b2
	sta.l alx_stratptr,x
rsv_0882b6
	lda.w $800c,y
rsv_0882b9
	sta.l alx_stratptr+1,x
rsv_0882bd
	lda.w $8014,y
rsv_0882c0
	sta.l alx_ptr,x
rsv_0882c4
	and #$0200
rsv_0882c7
	beq rsv_0882ef
rsv_0882c9
	phy
rsv_0882ca
	phb
rsv_0882cb
	a8
rsv_0882cd
	lda #$00
rsv_0882cf
	pha
rsv_0882d0
	plb
rsv_0882d1
	a16
rsv_0882d3
	lda.l alx_expshape,x
rsv_0882d7
	tay
rsv_0882d8
	lda.w $000a,y
rsv_0882db
	sta.l alx_expposx,x
rsv_0882df
	lda.w $000c,y
rsv_0882e2
	sta.l alx_expposy,x
rsv_0882e6
	lda.w $000e,y
rsv_0882e9
	sta.l alx_expposz,x
rsv_0882ed
	plb
rsv_0882ee
	ply
rsv_0882ef
	lda.w $800e,y
rsv_0882f2
	clc
rsv_0882f3
	adc.l alx_expposx,x
rsv_0882f7
	sta.l alx_expposx,x
rsv_0882fb
	lda.w $8010,y
rsv_0882fe
	clc
rsv_0882ff
	adc.l alx_expposy,x
rsv_088303
	sta.l alx_expposy,x
rsv_088307
	lda.w $8012,y
rsv_08830a
	clc
rsv_08830b
	adc.l alx_expposz,x
rsv_08830f
	sta.l alx_expposz,x
rsv_088313
	lda.l race_mapyaw
rsv_088317
	and #$00ff
rsv_08831a
	beq rsv_088333
rsv_08831c
	cmp #$0080
rsv_08831f
	beq rsv_088333
rsv_088321
	lda.l alx_expposx,x
rsv_088325
	pha
rsv_088326
	lda.l alx_expposz,x
rsv_08832a
	sta.l alx_expposx,x
rsv_08832e
	pla
rsv_08832f
	sta.l alx_expposz,x
rsv_088333
	jsl retail_updateactorcell_l
rsv_088337
	a8
rsv_088339
	phb
rsv_08833a
	lda.l alx_stratptr+2,x
rsv_08833e
	pha
rsv_08833f
	plb
rsv_088340
	phx
rsv_088341
	a16
rsv_088343
	lda.l alx_stratptr,x
rsv_088347
	sec
rsv_088348
	sbc #$8000
rsv_08834b
	tax
rsv_08834c
	a8
rsv_08834e
	lda.w $8000,x
rsv_088351
	plx
rsv_088352
	cmp #$ea
rsv_088354
	bne rsv_08835c
rsv_088356
	lda #$03
rsv_088358
	sta.l alx_sbyte4,x
rsv_08835c
	plb
rsv_08835d
	a16
rsv_08835f
	rts
	shorta
	longi
rsv_mapfatal
	jsl retail_fatal4_l
	shorta
	longi
retail_quietshake_l
	a16
rsv_08843e
	lda #retail_quietshake_step&WM
rsv_088441
	sta.w al_stratptr,x
rsv_088444
	a8
rsv_088446
	lda #retail_quietshake_step>>16
rsv_088448
	sta.w al_stratptr+2,x
rsv_08844b
	jml rsv_shakebody
retail_quietshake_step
	a16
rsv_088451
	lda #$0000
rsv_088454
	sta.w race_callback
rsv_088457
	a8
rsv_088459
	a16
rsv_08845b
	lda #$0000
rsv_08845e
	sta.w race_visualoffset
rsv_088461
	a8
rsv_088463
	a16
rsv_088465
	lda #$0000
rsv_088468
	sta.w race_visualowner
rsv_08846b
	a8
rsv_08846d
	jsl retail_viewcontact_l
rsv_088471
	rtl
retail_contactshake_l
	a16
rsv_088474
	lda #retail_contactshake_step&WM
rsv_088477
	sta.w al_stratptr,x
rsv_08847a
	a8
rsv_08847c
	lda #retail_contactshake_step>>16
rsv_08847e
	sta.w al_stratptr+2,x
rsv_088481
	jml rsv_shakebody
retail_contactshake_step
	a16
rsv_088487
	lda #$0000
rsv_08848a
	sta.w race_callback
rsv_08848d
	a8
rsv_08848f
	a16
rsv_088491
	lda #$0000
rsv_088494
	sta.w race_visualoffset
rsv_088497
	a8
rsv_088499
	a16
rsv_08849b
	lda #$0000
rsv_08849e
	sta.w race_visualowner
rsv_0884a1
	a8
rsv_0884a3
	jsl retail_viewcontact_l
rsv_0884a7
	rtl
rsv_shakebody
	a16
rsv_0884aa
	lda #rsv_shakebody_step&WM
rsv_0884ad
	sta.w al_tempstratptr,x
rsv_0884b0
	a8
rsv_0884b2
	lda #rsv_shakebody_step>>16
rsv_0884b4
	sta.w al_tempstratptr+2,x
rsv_shakebody_step
	jsl retail_makeheldbody_l
rsv_0884bb
	jsl retail_makecollidable_l
rsv_0884bf
	a16
rsv_0884c1
	lda #$0780
rsv_0884c4
	sta x1
rsv_0884c6
	a8
rsv_0884c8
	a16
rsv_0884ca
	lda #$0780
rsv_0884cd
	sta y1
rsv_0884cf
	a8
rsv_0884d1
	a16
rsv_0884d3
	lda #$0780
rsv_0884d6
	sta z1
rsv_0884d8
	a8
rsv_0884da
	jsl retail_setrawbounds_l
rsv_0884de
	rtl
retail_viewcontact_l
	jsl retail_publishbody_l
rsv_0884e3
	and #$01
rsv_0884e5
	beq rsv_088524
rsv_0884e7
	jsl retail_nextcontact_l
rsv_0884eb
	bcc rsv_088524
rsv_0884ed
	bit #$04
rsv_0884ef
	beq rsv_0884e7
rsv_0884f1
	phx
rsv_0884f2
	bit #$01
rsv_0884f4
	beq rsv_0884fb
rsv_0884f6
	ldx.w race_playeractor
rsv_0884f9
	bra rsv_088502
rsv_0884fb
	bit #$02
rsv_0884fd
	beq rsv_088521
rsv_0884ff
	ldx.w race_playeractor2
rsv_088502
	ldy.w al_viewpt,x
rsv_088505
	beq rsv_088521
rsv_088507
	tyx
rsv_088508
	ldy.w al_viewpt,x
rsv_08850b
	a16
rsv_08850d
	lda.w race_callback
rsv_088510
	sta.w $002c,y
rsv_088513
	lda.w race_visualoffset
rsv_088516
	sta.w $002e,y
rsv_088519
	lda.w race_visualowner
rsv_08851c
	sta.w $0030,y
rsv_08851f
	a8
rsv_088521
	plx
rsv_088522
	bra rsv_0884e7
rsv_088524
	rtl
	shorta
	longi
retail_nearestcamera_l
	a16
rsv_088a5b
	lda #retail_nearestcamera_step&WM
rsv_088a5e
	sta.w al_stratptr,x
rsv_088a61
	a8
rsv_088a63
	lda #retail_nearestcamera_step>>16
rsv_088a65
	sta.w al_stratptr+2,x
rsv_088a68
	ldy.w al_viewpt,x
rsv_088a6b
	a16
rsv_088a6d
	lda #$0002
rsv_088a70
	sta.w $0000,y
rsv_088a73
	a8
retail_nearestcamera_step
	ldy.w al_viewpt,x
rsv_088a78
	lda #$00
rsv_088a7a
	sta.w $0004,y
rsv_088a7d
	a16
rsv_088a7f
	lda #$07d0
rsv_088a82
	sta.w $0006,y
rsv_088a85
	a8
rsv_088a87
	jml retail_cameratick_l
retail_pickviewtarget_l
	ldy #viewcamera1
rsv_088a8d
	lda.w $0004,y
rsv_088a90
	bne rsv_088aa4
rsv_088a92
	lda #$01
rsv_088a94
	sta.w $0004,y
rsv_088a97
	a16
rsv_088a99
	lda.w $0000,y
rsv_088a9c
	and #$fffe
rsv_088a9f
	sta.w $0000,y
rsv_088aa2
	a8
rsv_088aa4
	a16
rsv_088aa6
	phx
rsv_088aa7
	lda.w al_worldx,x
rsv_088aaa
	sta.w race_callback
rsv_088aad
	lda.w al_worldy,x
rsv_088ab0
	sta.w race_visualoffset
rsv_088ab3
	lda.w al_worldz,x
rsv_088ab6
	sta.w race_visualowner
rsv_088ab9
	stz.w race_visualsize
rsv_088abc
	lda.w $0006,y
rsv_088abf
	sta.w race_griddef
rsv_088ac2
	ldx #$0000
rsv_088ac5
	lda.l race_gridactors,x
rsv_088ac9
	beq rsv_088b26
rsv_088acb
	tay
rsv_088acc
	lda.w al_worldx,y
rsv_088acf
	sec
rsv_088ad0
	sbc.w race_callback
rsv_088ad3
	bpl rsv_088ad9
rsv_088ad5
	eor #$ffff
rsv_088ad8
	inc a
rsv_088ad9
	cmp #$8000
rsv_088adc
	ror a
rsv_088add
	cmp #$8000
rsv_088ae0
	ror a
rsv_088ae1
	sta.w race_scratch
rsv_088ae4
	lda.w al_worldy,y
rsv_088ae7
	sec
rsv_088ae8
	sbc.w race_visualoffset
rsv_088aeb
	bpl rsv_088af1
rsv_088aed
	eor #$ffff
rsv_088af0
	inc a
rsv_088af1
	cmp #$8000
rsv_088af4
	ror a
rsv_088af5
	cmp #$8000
rsv_088af8
	ror a
rsv_088af9
	clc
rsv_088afa
	adc.w race_scratch
rsv_088afd
	sta.w race_scratch
rsv_088b00
	lda.w al_worldz,y
rsv_088b03
	sec
rsv_088b04
	sbc.w race_visualowner
rsv_088b07
	bpl rsv_088b0d
rsv_088b09
	eor #$ffff
rsv_088b0c
	inc a
rsv_088b0d
	cmp #$8000
rsv_088b10
	ror a
rsv_088b11
	cmp #$8000
rsv_088b14
	ror a
rsv_088b15
	clc
rsv_088b16
	adc.w race_scratch
rsv_088b19
	cmp.w race_griddef
rsv_088b1c
	bpl rsv_088b24
rsv_088b1e
	sta.w race_griddef
rsv_088b21
	sty.w race_visualsize
rsv_088b24
	inx
rsv_088b25
	inx
rsv_088b26
	plx
rsv_088b27
	ldy #viewcamera1
rsv_088b2a
	lda.w race_griddef
rsv_088b2d
	sta.w $0006,y
rsv_088b30
	lda.w race_visualsize
rsv_088b33
	beq rsv_088b55
rsv_088b35
	sta.w $0002,y
rsv_088b38
	lda.w al_worldx,x
rsv_088b3b
	sta.w $0008,y
rsv_088b3e
	lda.w al_worldy,x
rsv_088b41
	sta.w $000a,y
rsv_088b44
	lda.w al_worldz,x
rsv_088b47
	sta.w $000c,y
rsv_088b4a
	lda.w $0000,y
rsv_088b4d
	ora #$0001
rsv_088b50
	sta.w $0000,y
rsv_088b53
	a8
rsv_088b55
	lda #$03
rsv_088b57
	sta.w al_sbyte4,x
rsv_088b5a
	rtl
retail_routeclosecamera_l
	a16
rsv_088b5d
	lda #retail_roadcamera_step&WM
rsv_088b60
	sta.w al_stratptr,x
rsv_088b63
	a8
rsv_088b65
	lda #retail_roadcamera_step>>16
rsv_088b67
	sta.w al_stratptr+2,x
rsv_088b6a
	ldy.w al_viewpt,x
rsv_088b6d
	a16
rsv_088b6f
	lda #$0003
rsv_088b72
	sta.w $0000,y
rsv_088b75
	a8
rsv_088b77
	phx
rsv_088b78
	ldy.w al_ptr,x
rsv_088b7b
	a16
rsv_088b7d
	lda.w al_collobjptr,y
rsv_088b80
	tax
rsv_088b81
	lda.l $700058,x
rsv_088b85
	plx
rsv_088b86
	jsl retail_nextroute_l
rsv_088b8a
	sta.w race_scratch
rsv_088b8d
	jsl retail_routeposition_l
rsv_088b91
	ldy.w al_viewpt,x
rsv_088b94
	lda.w race_callback
rsv_088b97
	sta.w $0008,y
rsv_088b9a
	lda.w race_visualoffset
rsv_088b9d
	clc
rsv_088b9e
	adc #$ff38
rsv_088ba1
	sta.w $000a,y
rsv_088ba4
	lda.w race_visualowner
rsv_088ba7
	sta.w $000c,y
rsv_088baa
	a8
rsv_088bac
	a16
rsv_088bae
	lda #$0000
rsv_088bb1
	sta.w al_sword1,x
rsv_088bb4
	a8
rsv_088bb6
	a16
rsv_088bb8
	lda #$0000
rsv_088bbb
	sta.w al_vx,x
rsv_088bbe
	a8
rsv_088bc0
	a16
rsv_088bc2
	lda #$0000
rsv_088bc5
	sta.w al_vy,x
rsv_088bc8
	a8
rsv_088bca
	a16
rsv_088bcc
	lda #$0000
rsv_088bcf
	sta.w al_vz,x
rsv_088bd2
	a8
rsv_088bd4
	jml retail_roadcamera_step
retail_fixedroadcamera_l
	a16
rsv_088bd9
	lda #retail_fixedroadcamera_l&WM
rsv_088bdc
	sta.w al_stratptr,x
rsv_088bdf
	a8
rsv_088be1
	lda #retail_fixedroadcamera_l>>16
rsv_088be3
	sta.w al_stratptr+2,x
rsv_088be6
	ldy.w al_viewpt,x
rsv_088be9
	a16
rsv_088beb
	lda #$0003
rsv_088bee
	sta.w $0000,y
rsv_088bf1
	a8
rsv_088bf3
	jsl retail_updatecamera_l
rsv_088bf7
	jml retail_cameratick_l
retail_routeahead3_l
	phx
rsv_088bfc
	ldy.w al_ptr,x
rsv_088bff
	a16
rsv_088c01
	lda.w al_collobjptr,y
rsv_088c04
	tax
rsv_088c05
	lda.l $700058,x
rsv_088c09
	plx
rsv_088c0a
	jsl retail_nextroute_l
rsv_088c0e
	jsl retail_nextroute_l
rsv_088c12
	jsl retail_nextroute_l
rsv_088c16
	sta.w race_scratch
rsv_088c19
	jsl retail_routeposition_l
rsv_088c1d
	ldy.w al_viewpt,x
rsv_088c20
	lda.w race_callback
rsv_088c23
	clc
rsv_088c24
	adc #$03e8
rsv_088c27
	sta.w $0008,y
rsv_088c2a
	lda.w race_visualoffset
rsv_088c2d
	clc
rsv_088c2e
	adc #$fe0c
rsv_088c31
	sta.w $000a,y
rsv_088c34
	lda.w race_visualowner
rsv_088c37
	clc
rsv_088c38
	adc #$03e8
rsv_088c3b
	sta.w $000c,y
rsv_088c3e
	a8
rsv_088c40
	jml rlf_088cda
retail_routeahead5_l
	phx
rsv_088c44
	ldy.w al_ptr,x
rsv_088c47
	a16
rsv_088c49
	lda.w al_collobjptr,y
rsv_088c4c
	tax
rsv_088c4d
	lda.l $700058,x
rsv_088c51
	plx
rsv_088c52
	jsl retail_nextroute_l
rsv_088c56
	jsl retail_nextroute_l
rsv_088c5a
	jsl retail_nextroute_l
rsv_088c5e
	jsl retail_nextroute_l
rsv_088c62
	jsl retail_nextroute_l
rsv_088c66
	sta.w race_scratch
rsv_088c69
	jsl retail_routeposition_l
rsv_088c6d
	ldy.w al_viewpt,x
rsv_088c70
	lda.w race_scratch
rsv_088c73
	sta.w $0004,y
rsv_088c76
	lda.w race_callback
rsv_088c79
	clc
rsv_088c7a
	adc #$03e8
rsv_088c7d
	sta.w $0008,y
rsv_088c80
	lda.w race_visualoffset
rsv_088c83
	clc
rsv_088c84
	adc #$fe0c
rsv_088c87
	sta.w $000a,y
rsv_088c8a
	lda.w race_visualowner
rsv_088c8d
	clc
rsv_088c8e
	adc #$03e8
rsv_088c91
	sta.w $000c,y
rsv_088c94
	a8
rsv_088c96
	jmp retail_fixedroadcamera_l
	shorta
	longi
retail_lowchasecamera_l
	ldy.w al_viewpt,x
rsv_088f91
	a16
rsv_088f93
	lda.w $0002,y
rsv_088f96
	tay
rsv_088f97
	lda.w al_worldx,y
rsv_088f9a
	sta.w race_callback
rsv_088f9d
	sta.w al_worldx,x
rsv_088fa0
	lda #$fc18
rsv_088fa3
	sta.w race_visualoffset
rsv_088fa6
	sta.w al_worldy,x
rsv_088fa9
	lda.w al_worldz,y
rsv_088fac
	clc
rsv_088fad
	adc #$fed4
rsv_088fb0
	sta.w race_visualowner
rsv_088fb3
	sta.w al_worldz,x
rsv_088fb6
	a8
rsv_088fb8
	ldy.w al_viewpt,x
rsv_088fbb
	a16
rsv_088fbd
	lda.w race_callback
rsv_088fc0
	sta.w $0008,y
rsv_088fc3
	a8
rsv_088fc5
	a16
rsv_088fc7
	lda.w race_visualoffset
rsv_088fca
	sta.w $000a,y
rsv_088fcd
	a8
rsv_088fcf
	a16
rsv_088fd1
	lda.w race_visualowner
rsv_088fd4
	sta.w $000c,y
rsv_088fd7
	a8
rsv_088fd9
	ldy.w al_viewpt,x
rsv_088fdc
	a16
rsv_088fde
	lda #$0003
rsv_088fe1
	sta.w $0000,y
rsv_088fe4
	a8
rsv_088fe6
	jsl retail_updatecamera_l
rsv_088fea
	a16
rsv_088fec
	lda #retail_lowchasecamera_step&WM
rsv_088fef
	sta.w al_stratptr,x
rsv_088ff2
	a8
rsv_088ff4
	lda #retail_lowchasecamera_step>>16
rsv_088ff6
	sta.w al_stratptr+2,x
rsv_088ff9
	lda #$0a
rsv_088ffb
	sta.w al_sbyte1,x
retail_lowchasecamera_step
	lda.w al_sbyte1,x
rsv_089001
	bne rsv_089007
rsv_089003
	jml rsv_089024
rsv_089007
	dec.w al_sbyte1,x
rsv_08900a
	a16
rsv_08900c
	phx
rsv_08900d
	ldy.w al_ptr,x
rsv_089010
	lda.w al_collobjptr,y
rsv_089013
	tax
rsv_089014
	lda.l $700042,x
rsv_089018
	ora #$1010
rsv_08901b
	sta.l $700042,x
rsv_08901f
	a8
rsv_089021
	plx
rsv_089022
	bra rsv_08903c
rsv_089024
	a16
rsv_089026
	phx
rsv_089027
	ldy.w al_ptr,x
rsv_08902a
	lda.w al_collobjptr,y
rsv_08902d
	tax
rsv_08902e
	lda.l $700042,x
rsv_089032
	and #$efff
rsv_089035
	sta.l $700042,x
rsv_089039
	a8
rsv_08903b
	plx
rsv_08903c
	ldy.w al_viewpt,x
rsv_08903f
	lda.w al_sflags2,x
rsv_089042
	and #$01
rsv_089044
	bne rsv_08904a
rsv_089046
	jml rsv_089083
rsv_08904a
	lda.w al_sflags2,x
rsv_08904d
	and #$fe
rsv_08904f
	sta.w al_sflags2,x
rsv_089052
	lda.w $0034,y
rsv_089055
	inc a
rsv_089056
	cmp #$02
rsv_089058
	bmi rsv_08905c
rsv_08905a
	lda #$00
rsv_08905c
	sta.w $0034,y
rsv_08905f
	beq rsv_089073
rsv_089061
	lda #$24
rsv_089063
	jsl queue_raceplayer_l
rsv_089067
	a16
rsv_089069
	lda #$f830
rsv_08906c
	sta.w al_worldy,x
rsv_08906f
	a8
rsv_089071
	bra rsv_089083
rsv_089073
	lda #$2f
rsv_089075
	jsl queue_raceplayer_l
rsv_089079
	a16
rsv_08907b
	lda #$fc18
rsv_08907e
	sta.w al_worldy,x
rsv_089081
	a8
rsv_089083
	a16
rsv_089085
	lda.w al_worldy,x
rsv_089088
	sec
rsv_089089
	sbc.w $000a,y
rsv_08908c
	cmp #$8000
rsv_08908f
	ror a
rsv_089090
	bpl rsv_089095
rsv_089092
	adc #$0000
rsv_089095
	clc
rsv_089096
	adc.w $000a,y
rsv_089099
	sta.w $000a,y
rsv_08909c
	lda.w al_worldx,x
rsv_08909f
	sta.w race_callback
rsv_0890a2
	lda.w al_worldz,x
rsv_0890a5
	sta.w race_visualowner
rsv_0890a8
	phx
rsv_0890a9
	ldy.w al_viewpt,x
rsv_0890ac
	lda.w $0002,y
rsv_0890af
	tyx
rsv_0890b0
	tay
rsv_0890b1
	lda.w al_worldx,y
rsv_0890b4
	sec
rsv_0890b5
	sbc.w race_callback
rsv_0890b8
	jsl retail_scaleactorvelocity_l
rsv_0890bc
	clc
rsv_0890bd
	adc.w race_callback
rsv_0890c0
	sta y1,x
rsv_0890c2
	lda.w al_worldz,y
rsv_0890c5
	sec
rsv_0890c6
	sbc.w race_visualowner
rsv_0890c9
	jsl retail_scaleactorvelocity_l
rsv_0890cd
	clc
rsv_0890ce
	adc.w race_visualowner
rsv_0890d1
	sta $0c,x
rsv_0890d3
	a8
rsv_0890d5
	plx
rsv_0890d6
	jml retail_cameratick_l
	shorta
	longi
retail_cameraanim15_l
	a16
rsv_0891a1
	lda #rsv_0891d0&WM
rsv_0891a4
	sta.w al_stratptr,x
rsv_0891a7
	a8
rsv_0891a9
	lda #rsv_0891d0>>16
rsv_0891ab
	sta.w al_stratptr+2,x
rsv_0891ae
	ldy.w al_viewpt,x
rsv_0891b1
	a16
rsv_0891b3
	lda #$0001
rsv_0891b6
	sta.w $0000,y
rsv_0891b9
	a8
rsv_0891bb
	ldy #viewanim15&WM
rsv_0891be
	lda.w race_scenephase
rsv_0891c1
	cmp #$03
rsv_0891c3
	bne rsv_0891c8
rsv_0891c5
	ldy #viewanimtab&WM
rsv_0891c8
	jsl retail_setcameraanim_l
rsv_0891cc
	jsl retail_updatecamera_l
rsv_0891d0
	jsl retail_cameraanim_l
rsv_0891d4
	bcs rsv_0891d9
rsv_0891d6
	jml retail_cameratick_l
rsv_0891d9
	a16
rsv_0891db
	lda.l m_viewroadflags
rsv_0891df
	ora #$0001
rsv_0891e2
	sta.l m_viewroadflags
rsv_0891e6
	a8
rsv_0891e8
	jml retail_drivecamera_l
	shorta
	longi
retail_freecamera_l
	lda #$05
rsv_0895a2
	sta.w viewposflags
rsv_0895a5
	a16
rsv_0895a7
	lda #retail_freecamera_step&WM
rsv_0895aa
	sta.w al_stratptr,x
rsv_0895ad
	a8
rsv_0895af
	lda #retail_freecamera_step>>16
rsv_0895b1
	sta.w al_stratptr+2,x
rsv_0895b4
	jsl retail_makecontactbody_l
rsv_0895b8
	phx
rsv_0895b9
	phb
rsv_0895ba
	jsl getviewpos_l
rsv_0895be
	a8
rsv_0895c0
	plb
rsv_0895c1
	plx
rsv_0895c2
	jsl retail_pinbody_l
rsv_0895c6
	rtl
retail_freecamera_step
	ldy.w al_ptr,x
rsv_0895ca
	stz.w race_groundheight
rsv_0895cd
	a16
rsv_0895cf
	lda viewposx
rsv_0895d1
	sta.w race_savedview
rsv_0895d4
	a8
rsv_0895d6
	a16
rsv_0895d8
	lda viewposy
rsv_0895da
	sta.w race_savedview+2
rsv_0895dd
	a8
rsv_0895df
	a16
rsv_0895e1
	lda viewposz
rsv_0895e3
	sta.w race_savedview+4
rsv_0895e6
	a8
rsv_0895e8
	phx
rsv_0895e9
	phb
rsv_0895ea
	jsl getviewpos_l
rsv_0895ee
	a8
rsv_0895f0
	plb
rsv_0895f1
	plx
rsv_0895f2
	a16
rsv_0895f4
	txy
rsv_0895f5
	lda.w al_collobjptr,x
rsv_0895f8
	tax
rsv_0895f9
	lda.l $70001e,x
rsv_0895fd
	sta.w race_callback
rsv_089600
	lda.l $700020,x
rsv_089604
	sta.w race_visualoffset
rsv_089607
	lda.l $700022,x
rsv_08960b
	sta.w race_visualowner
rsv_08960e
	lda bigx
rsv_089610
	cmp #$8000
rsv_089613
	ror a
rsv_089614
	cmp #$8000
rsv_089617
	ror a
rsv_089618
	clc
rsv_089619
	adc.w al_worldx,y
rsv_08961c
	sta.l $70001e,x
rsv_089620
	lda #$00c8
rsv_089623
	clc
rsv_089624
	adc.w al_worldy,y
rsv_089627
	sta.l $700020,x
rsv_08962b
	lda bigz
rsv_08962d
	cmp #$8000
rsv_089630
	ror a
rsv_089631
	cmp #$8000
rsv_089634
	ror a
rsv_089635
	clc
rsv_089636
	adc.w al_worldz,y
rsv_089639
	sta.l $700022,x
rsv_08963d
	tyx
rsv_08963e
	a8
rsv_089640
	lda #$ff
rsv_089642
	sta.w race_groundheight
rsv_089645
	jsl retail_bodycontacthead_l
rsv_089649
	and #$01
rsv_08964b
	beq rsv_08967e
rsv_08964d
	jsl retail_objectcontacts_l
rsv_089651
	and #$18
rsv_089653
	beq rsv_089699
rsv_089655
	a16
rsv_089657
	lda.w race_callback
rsv_08965a
	sta viewposx
rsv_08965c
	a8
rsv_08965e
	a16
rsv_089660
	lda.w race_visualoffset
rsv_089663
	sta viewposy
rsv_089665
	a8
rsv_089667
	a16
rsv_089669
	lda viewposy
rsv_08966b
	clc
rsv_08966c
	adc #$ff38
rsv_08966f
	sta viewposy
rsv_089671
	a8
rsv_089673
	a16
rsv_089675
	lda.w race_visualowner
rsv_089678
	sta viewposz
rsv_08967a
	a8
rsv_08967c
	bra rsv_089699
rsv_08967e
	a16
rsv_089680
	lda.w race_savedview
rsv_089683
	sta viewposx
rsv_089685
	a8
rsv_089687
	a16
rsv_089689
	lda.w race_savedview+2
rsv_08968c
	sta viewposy
rsv_08968e
	a8
rsv_089690
	a16
rsv_089692
	lda.w race_savedview+4
rsv_089695
	sta viewposz
rsv_089697
	a8
rsv_089699
	jsl getviewangles_l
rsv_08969d
	lda #$03
rsv_08969f
	sta.w al_sbyte4,x
rsv_0896a2
	rtl
	shorta
	longi
retail_carresetcamera_l
	lda #$03
rsv_0896a5
	sta.w viewposflags
rsv_0896a8
	ldy.w al_ptr,x
rsv_0896ab
	a16
rsv_0896ad
	lda.w al_sword2,y
rsv_0896b0
	sta.w al_sword2,x
rsv_0896b3
	a8
rsv_0896b5
	a16
rsv_0896b7
	lda #retail_carresetcamera_step&WM
rsv_0896ba
	sta.w al_stratptr,x
rsv_0896bd
	a8
rsv_0896bf
	lda #retail_carresetcamera_step>>16
rsv_0896c1
	sta.w al_stratptr+2,x
rsv_0896c4
	lda #$96
rsv_0896c6
	sta.w al_sbyte1,x
rsv_0896c9
	lda.w al_sflags2,x
rsv_0896cc
	and #$fe
rsv_0896ce
	sta.w al_sflags2,x
retail_carresetcamera_step
	lda.w al_sbyte1,x
rsv_0896d4
	bne rsv_0896da
rsv_0896d6
	jml rsv_resetrelease
rsv_0896da
	dec.w al_sbyte1,x
rsv_0896dd
	a16
rsv_0896df
	lda.w al_worldy,x
rsv_0896e2
	clc
rsv_0896e3
	adc #$ffce
rsv_0896e6
	sta.w al_worldy,x
rsv_0896e9
	a8
rsv_0896eb
	ldy.w al_ptr,x
rsv_0896ee
	a16
rsv_0896f0
	lda.w al_worldy,y
rsv_0896f3
	cmp #$fc18
rsv_0896f6
	a8
rsv_0896f8
	bmi rsv_0896fe
rsv_0896fa
	jml rsv_resetposition
rsv_0896fe
	jml retail_cameratick_l
rsv_resetposition
	a16
rsv_089704
	lda #rsv_resetposition_step&WM
rsv_089707
	sta.w al_stratptr,x
rsv_08970a
	a8
rsv_08970c
	lda #rsv_resetposition_step>>16
rsv_08970e
	sta.w al_stratptr+2,x
rsv_resetposition_step
	ldy.w al_ptr,x
rsv_089714
	a16
rsv_089716
	lda.w al_worldx,y
rsv_089719
	sta.w al_worldx,x
rsv_08971c
	a8
rsv_08971e
	a16
rsv_089720
	lda.w al_worldz,y
rsv_089723
	sta.w al_worldz,x
rsv_089726
	a8
rsv_089728
	a16
rsv_08972a
	lda #$ff38
rsv_08972d
	sta.w al_worldy,x
rsv_089730
	a8
rsv_089732
	a16
rsv_089734
	lda.w al_worldx,x
rsv_089737
	clc
rsv_089738
	adc #$0258
rsv_08973b
	sta.w al_worldx,x
rsv_08973e
	a8
rsv_089740
	a16
rsv_089742
	lda.w al_worldz,x
rsv_089745
	clc
rsv_089746
	adc #$0258
rsv_089749
	sta.w al_worldz,x
rsv_08974c
	a8
rsv_08974e
	a16
rsv_089750
	lda #rsv_resethold&WM
rsv_089753
	sta.w al_stratptr,x
rsv_089756
	a8
rsv_089758
	lda #rsv_resethold>>16
rsv_08975a
	sta.w al_stratptr+2,x
rsv_08975d
	phx
rsv_08975e
	a16
rsv_089760
	lda.w al_collobjptr,y
rsv_089763
	tax
rsv_089764
	lda #$0000
rsv_089767
	sta.l $70002e,x
rsv_08976b
	sta.l $700030,x
rsv_08976f
	sta.l $700032,x
rsv_089773
	sta.l $700036,x
rsv_089777
	sta.l $700034,x
rsv_08977b
	sta.l $700038,x
rsv_08977f
	a8
rsv_089781
	plx
rsv_089782
	lda #$3c
rsv_089784
	sta.w al_sbyte1,x
rsv_resethold
	lda.w al_sbyte1,x
rsv_08978a
	bne rsv_089790
rsv_08978c
	jml rsv_resetreturn
rsv_089790
	dec.w al_sbyte1,x
rsv_089793
	jml retail_cameratick_l
rsv_resetreturn
	lda #$02
rsv_089799
	sta.w viewposflags
rsv_08979c
	a16
rsv_08979e
	lda #rsv_resetreturn_step&WM
rsv_0897a1
	sta.w al_stratptr,x
rsv_0897a4
	a8
rsv_0897a6
	lda #rsv_resetreturn_step>>16
rsv_0897a8
	sta.w al_stratptr+2,x
rsv_0897ab
	a16
rsv_0897ad
	lda.w al_sword2,x
rsv_0897b0
	jsl retail_nextroute_l
rsv_0897b4
	jsl retail_routeposition_l
rsv_0897b8
	lda.w race_callback
rsv_0897bb
	sta x2
rsv_0897bd
	lda.w race_visualoffset
rsv_0897c0
	sta y2
rsv_0897c2
	lda.w race_visualowner
rsv_0897c5
	sta.w z2
rsv_0897c8
	lda.w al_sword2,x
rsv_0897cb
	jsl retail_routeposition_l
rsv_0897cf
	lda.w race_visualoffset
rsv_0897d2
	clc
rsv_0897d3
	adc #$fe0c
rsv_0897d6
	sta.w race_visualoffset
rsv_0897d9
	lda x2
rsv_0897db
	sec
rsv_0897dc
	sbc.w race_callback
rsv_0897df
	cmp #$8000
rsv_0897e2
	ror a
rsv_0897e3
	clc
rsv_0897e4
	adc.w race_callback
rsv_0897e7
	sta.w al_worldx,x
rsv_0897ea
	lda y2
rsv_0897ec
	clc
rsv_0897ed
	adc #$fe0c
rsv_0897f0
	sec
rsv_0897f1
	sbc.w race_visualoffset
rsv_0897f4
	cmp #$8000
rsv_0897f7
	ror a
rsv_0897f8
	clc
rsv_0897f9
	adc.w race_visualoffset
rsv_0897fc
	sta.w al_worldy,x
rsv_0897ff
	lda.w z2
rsv_089802
	sec
rsv_089803
	sbc.w race_visualowner
rsv_089806
	cmp #$8000
rsv_089809
	ror a
rsv_08980a
	clc
rsv_08980b
	adc.w race_visualowner
rsv_08980e
	sta.w al_worldz,x
rsv_089811
	jsl Yanglexabs16_l
rsv_089815
	jsl Xanglexabs16_l
rsv_089819
	eor #$ffff
rsv_08981c
	inc a
rsv_08981d
	a8
rsv_08981f
	ldy.w al_ptr,x
rsv_089822
	phx
rsv_089823
	tyx
rsv_089824
	plx
rsv_resetreturn_step
	lda.w al_sflags2,x
rsv_089828
	and #$01
rsv_08982a
	beq rsv_089830
rsv_08982c
	jml rsv_resetrelease
rsv_089830
	jml retail_cameratick_l
	shorta
	longi
rsv_resetrelease
	a16
rsv_089835
	lda #rsv_resetrelease_step&WM
rsv_089838
	sta.w al_stratptr,x
rsv_08983b
	a8
rsv_08983d
	lda #rsv_resetrelease_step>>16
rsv_08983f
	sta.w al_stratptr+2,x
rsv_089842
	lda #$0f
rsv_089844
	sta.w al_sbyte1,x
rsv_resetrelease_step
	lda #$09
rsv_089849
	sta.w viewposflags
rsv_08984c
	dec.w al_sbyte1,x
rsv_08984f
	beq rsv_089855
rsv_089851
	jml retail_drivecamera_step
rsv_089855
	ldy.w al_ptr,x
rsv_089858
	lda #$00
rsv_08985a
	sta.w al_sbyte1,y
rsv_08985d
	jml retail_drivecamera_l
	shorta
	longi
retail_breakgate0_l
	nop
rsv_089bda
	lda #$00
rsv_089bdc
	sta.w al_roty,x
rsv_089bdf
	a16
rsv_089be1
	lda #$0000
rsv_089be4
	sta.w al_vx,x
rsv_089be7
	lda #$0000
rsv_089bea
	sta.w al_vy,x
rsv_089bed
	lda #$fda8
rsv_089bf0
	sta.w al_vz,x
rsv_089bf3
	a8
rsv_089bf5
	bra rsv_breakgate
	shorta
	longi
retail_breakgate1_l
	nop
rsv_089bf8
	lda #$c0
rsv_089bfa
	sta.w al_roty,x
rsv_089bfd
	a16
rsv_089bff
	lda #$fda8
rsv_089c02
	sta.w al_vx,x
rsv_089c05
	lda #$0000
rsv_089c08
	sta.w al_vy,x
rsv_089c0b
	lda #$0000
rsv_089c0e
	sta.w al_vz,x
rsv_089c11
	a8
rsv_089c13
	bra rsv_breakgate
	shorta
	longi
retail_breakgate2_l
	nop
rsv_089c16
	lda #$80
rsv_089c18
	sta.w al_roty,x
rsv_089c1b
	a16
rsv_089c1d
	lda #$0000
rsv_089c20
	sta.w al_vx,x
rsv_089c23
	lda #$0000
rsv_089c26
	sta.w al_vy,x
rsv_089c29
	lda #$0258
rsv_089c2c
	sta.w al_vz,x
rsv_089c2f
	a8
rsv_089c31
	bra rsv_breakgate
	shorta
	longi
retail_breakgate3_l
	nop
rsv_089c34
	lda #$40
rsv_089c36
	sta.w al_roty,x
rsv_089c39
	a16
rsv_089c3b
	lda #$0258
rsv_089c3e
	sta.w al_vx,x
rsv_089c41
	lda #$0000
rsv_089c44
	sta.w al_vy,x
rsv_089c47
	lda #$0000
rsv_089c4a
	sta.w al_vz,x
rsv_089c4d
	a8
rsv_breakgate
	lda.w race_playerphase
rsv_089c52
	cmp #$08
rsv_089c54
	beq rsv_089c59
rsv_089c56
	brl rsv_089da8
rsv_089c59
	a16
rsv_089c5b
	lda.l m_playercar
rsv_089c5f
	bne rsv_089c64
rsv_089c61
	brl rsv_089da8
rsv_089c64
	phx
rsv_089c65
	tax
rsv_089c66
	lda.l $700020,x
rsv_089c6a
	sta.w race_visualoffset
rsv_089c6d
	clc
rsv_089c6e
	adc #$e4a8
rsv_089c71
	sta.w race_callback
rsv_089c74
	a8
rsv_089c76
	plx
rsv_089c77
	a16
rsv_089c79
	lda.w race_callback
rsv_089c7c
	sta.w al_worldy,x
rsv_089c7f
	a8
rsv_089c81
	a16
rsv_089c83
	lda.w race_visualoffset
rsv_089c86
	clc
rsv_089c87
	adc #$fe0c
rsv_089c8a
	sta.w race_visualoffset
rsv_089c8d
	a8
rsv_089c8f
	a16
rsv_089c91
	lda.w race_visualoffset
rsv_089c94
	sta.w al_sword1,x
rsv_089c97
	a8
rsv_089c99
	stz.w race_animcount
rsv_089c9c
	a16
rsv_089c9e
	lda #$a660
rsv_089ca1
	sta.w race_scratch
rsv_089ca4
	a8
rsv_089ca6
	jsl retail_makeactor_l
rsv_089caa
	bcs rsv_089cb0
rsv_089cac
	jml rsv_089cd6
rsv_089cb0
	a16
rsv_089cb2
	lda #retail_gatepiece_l&WM
rsv_089cb5
	sta.w al_stratptr,y
rsv_089cb8
	a8
rsv_089cba
	lda #retail_gatepiece_l>>16
rsv_089cbc
	sta.w al_stratptr+2,y
rsv_089cbf
	a16
rsv_089cc1
	lda #$ff90
rsv_089cc4
	sta.w al_vx,y
rsv_089cc7
	a8
rsv_089cc9
	pha
rsv_089cca
	a16
rsv_089ccc
	txa
rsv_089ccd
	sta.w al_ptr,y
rsv_089cd0
	a8
rsv_089cd2
	pla
rsv_089cd3
	inc.w race_animcount
rsv_089cd6
	a16
rsv_089cd8
	lda #$a6d0
rsv_089cdb
	sta.w race_scratch
rsv_089cde
	a8
rsv_089ce0
	jsl retail_makeactor_l
rsv_089ce4
	bcs rsv_089cea
rsv_089ce6
	jml rsv_089d10
rsv_089cea
	a16
rsv_089cec
	lda #retail_gatepiece_l&WM
rsv_089cef
	sta.w al_stratptr,y
rsv_089cf2
	a8
rsv_089cf4
	lda #retail_gatepiece_l>>16
rsv_089cf6
	sta.w al_stratptr+2,y
rsv_089cf9
	a16
rsv_089cfb
	lda #$ffdb
rsv_089cfe
	sta.w al_vx,y
rsv_089d01
	a8
rsv_089d03
	pha
rsv_089d04
	a16
rsv_089d06
	txa
rsv_089d07
	sta.w al_ptr,y
rsv_089d0a
	a8
rsv_089d0c
	pla
rsv_089d0d
	inc.w race_animcount
rsv_089d10
	a16
rsv_089d12
	lda #$a67c
rsv_089d15
	sta.w race_scratch
rsv_089d18
	a8
rsv_089d1a
	jsl retail_makeactor_l
rsv_089d1e
	bcs rsv_089d24
rsv_089d20
	jml rsv_089d4a
rsv_089d24
	a16
rsv_089d26
	lda #retail_gatepiece_l&WM
rsv_089d29
	sta.w al_stratptr,y
rsv_089d2c
	a8
rsv_089d2e
	lda #retail_gatepiece_l>>16
rsv_089d30
	sta.w al_stratptr+2,y
rsv_089d33
	a16
rsv_089d35
	lda #$0025
rsv_089d38
	sta.w al_vx,y
rsv_089d3b
	a8
rsv_089d3d
	pha
rsv_089d3e
	a16
rsv_089d40
	txa
rsv_089d41
	sta.w al_ptr,y
rsv_089d44
	a8
rsv_089d46
	pla
rsv_089d47
	inc.w race_animcount
rsv_089d4a
	a16
rsv_089d4c
	lda #$a5d4
rsv_089d4f
	sta.w race_scratch
rsv_089d52
	a8
rsv_089d54
	jsl retail_makeactor_l
rsv_089d58
	bcs rsv_089d5e
rsv_089d5a
	jml rsv_089d84
rsv_089d5e
	a16
rsv_089d60
	lda #retail_gatepiece_l&WM
rsv_089d63
	sta.w al_stratptr,y
rsv_089d66
	a8
rsv_089d68
	lda #retail_gatepiece_l>>16
rsv_089d6a
	sta.w al_stratptr+2,y
rsv_089d6d
	a16
rsv_089d6f
	lda #$0070
rsv_089d72
	sta.w al_vx,y
rsv_089d75
	a8
rsv_089d77
	pha
rsv_089d78
	a16
rsv_089d7a
	txa
rsv_089d7b
	sta.w al_ptr,y
rsv_089d7e
	a8
rsv_089d80
	pla
rsv_089d81
	inc.w race_animcount
rsv_089d84
	lda.w race_animcount
rsv_089d87
	cmp #$04
rsv_089d89
	bne rsv_089dae
rsv_089d8b
	lda #$40
rsv_089d8d
	sta.w al_rotz,x
rsv_089d90
	lda.w al_roty,x
rsv_089d93
	clc
rsv_089d94
	adc #$20
rsv_089d96
	sta.w al_roty,x
rsv_089d99
	a16
rsv_089d9b
	lda #retail_breakgate_step&WM
rsv_089d9e
	sta.w al_stratptr,x
rsv_089da1
	a8
rsv_089da3
	lda #retail_breakgate_step>>16
rsv_089da5
	sta.w al_stratptr+2,x
rsv_089da8
	lda #$03
rsv_089daa
	sta.w al_sbyte4,x
rsv_089dad
	rtl
rsv_089dae
	a16
rsv_089db0
	lda #rsv_089dae&WM
rsv_089db3
	sta.w al_stratptr,x
rsv_089db6
	a8
rsv_089db8
	lda #rsv_089dae>>16
rsv_089dba
	sta.w al_stratptr+2,x
rsv_089dbd
	rtl
retail_breakgate_step
	jsl retail_moveactor_l
rsv_089dc2
	a16
rsv_089dc4
	lda.w al_worldy,x
rsv_089dc7
	sta tpx
rsv_089dc9
	lda.w al_sword1,x
rsv_089dcc
	jsl retail_easeactor_l
rsv_089dd0
	sta.w al_worldy,x
rsv_089dd3
	a8
rsv_089dd5
	lda.w al_rotz,x
rsv_089dd8
	clc
rsv_089dd9
	adc #$fa
rsv_089ddb
	sta.w al_rotz,x
rsv_089dde
	lda.w al_roty,x
rsv_089de1
	clc
rsv_089de2
	adc #$ff
rsv_089de4
	sta.w al_roty,x
rsv_089de7
	jsl retail_updateactorcell_l
rsv_089deb
	lda #$03
rsv_089ded
	sta.w al_sbyte4,x
rsv_089df0
	rtl
	shorta
	longi
retail_gatepiece_l
	lda #$28
rsv_089df3
	sta.w al_sbyte1,x
rsv_089df6
	a16
rsv_089df8
	lda #retail_gatepiece_step&WM
rsv_089dfb
	sta.w al_stratptr,x
rsv_089dfe
	a8
rsv_089e00
	lda #retail_gatepiece_step>>16
rsv_089e02
	sta.w al_stratptr+2,x
retail_gatepiece_step
	ldy.w al_ptr,x
rsv_089e08
	lda.w al_vx,x
rsv_089e0b
	sta.w race_animcount
rsv_089e0e
	lda.w al_vy,x
rsv_089e11
	sta.w race_animcount+1
rsv_089e14
	lda.w al_vz,x
rsv_089e17
	sta.w race_visualangle
rsv_089e1a
	lda.w race_animcount
rsv_089e1d
	sta x1
rsv_089e1f
	sta x2
rsv_089e21
	bit #$80
rsv_089e23
	beq rsv_089e2b
rsv_089e25
	lda #$ff
rsv_089e27
	sta x2+1
rsv_089e29
	bra rsv_089e2d
rsv_089e2b
	stz x2+1
rsv_089e2d
	lda.w race_animcount+1
rsv_089e30
	sta y1
rsv_089e32
	sta y2
rsv_089e34
	bit #$80
rsv_089e36
	beq rsv_089e3e
rsv_089e38
	lda #$ff
rsv_089e3a
	sta y2+1
rsv_089e3c
	bra rsv_089e40
rsv_089e3e
	stz y2+1
rsv_089e40
	lda.w race_visualangle
rsv_089e43
	sta z1
rsv_089e45
	sta.w z2
rsv_089e48
	bit #$80
rsv_089e4a
	beq rsv_089e53
rsv_089e4c
	lda #$ff
rsv_089e4e
	sta.w z2+1
rsv_089e51
	bra rsv_089e56
rsv_089e53
	stz.w z2+1
rsv_089e56
	lda.w al_rotz,y
rsv_089e59
	jsl retail_actorrotz_l
rsv_089e5d
	lda x2
rsv_089e5f
	sta x1
rsv_089e61
	lda y2
rsv_089e63
	sta y1
rsv_089e65
	lda.w z2
rsv_089e68
	sta z1
rsv_089e6a
	lda.w al_roty,y
rsv_089e6d
	jsl retail_actorroty_l
rsv_089e71
	a16
rsv_089e73
	lda x2
rsv_089e75
	asl a
rsv_089e76
	asl a
rsv_089e77
	asl a
rsv_089e78
	asl a
rsv_089e79
	sta x2
rsv_089e7b
	lda y2
rsv_089e7d
	asl a
rsv_089e7e
	asl a
rsv_089e7f
	asl a
rsv_089e80
	asl a
rsv_089e81
	sta y2
rsv_089e83
	lda.w z2
rsv_089e86
	asl a
rsv_089e87
	asl a
rsv_089e88
	asl a
rsv_089e89
	asl a
rsv_089e8a
	sta.w z2
rsv_089e8d
	lda.w al_worldx,y
rsv_089e90
	clc
rsv_089e91
	adc x2
rsv_089e93
	sta.w al_worldx,x
rsv_089e96
	lda.w al_worldz,y
rsv_089e99
	clc
rsv_089e9a
	adc.w z2
rsv_089e9d
	sta.w al_worldz,x
rsv_089ea0
	lda.w al_worldy,y
rsv_089ea3
	clc
rsv_089ea4
	adc y2
rsv_089ea6
	sta.w al_worldy,x
rsv_089ea9
	a8
rsv_089eab
	lda.w al_rotz,y
rsv_089eae
	sta.w al_rotz,x
rsv_089eb1
	lda.w al_roty,y
rsv_089eb4
	sta.w al_roty,x
rsv_089eb7
	jsl retail_updateactorcell_l
rsv_089ebb
	lda #$03
rsv_089ebd
	sta.w al_sbyte4,x
rsv_089ec0
	lda.w al_sbyte1,x
rsv_089ec3
	bne rsv_089ec9
rsv_089ec5
	jml retail_endactor_l
rsv_089ec9
	dec.w al_sbyte1,x
rsv_089ecc
	rtl
rsv_089ecd
	rtl
retail_previewselector_l
	lda #$7e
rsv_089ed0
	pha
rsv_089ed1
	plb
rsv_089ed2
	a16
rsv_089ed4
	lda #retail_previewselector_step&WM
rsv_089ed7
	sta.w al_stratptr,x
rsv_089eda
	a8
rsv_089edc
	lda #retail_previewselector_step>>16
rsv_089ede
	sta.w al_stratptr+2,x
rsv_089ee1
	lda.w al_sflags,x
rsv_089ee4
	ora #$08
rsv_089ee6
	sta.w al_sflags,x
rsv_089ee9
	lda #$00
rsv_089eeb
	sta.w al_lapcnt,x
rsv_089eee
	lda #$64
rsv_089ef0
	sta.w al_eyesize,x
rsv_089ef3
	a16
rsv_089ef5
	lda #$a158
rsv_089ef8
	sta.w al_shape,x
rsv_089efb
	a8
retail_previewselector_step
	a16
rsv_089eff
	lda.w race_previewchoice
rsv_089f02
	and #$0003
rsv_089f05
	asl a
rsv_089f06
	tay
rsv_089f07
	lda.w race_previewactors,y
rsv_089f0a
	tay
rsv_089f0b
	lda.w al_sword1,y
rsv_089f0e
	sty.w race_selectedactor
rsv_089f11
	sta.w race_previewdef
rsv_089f14
	a8
rsv_089f16
	jsl retail_followactor_l
rsv_089f1a
	a16
rsv_089f1c
	lda.w al_worldy,x
rsv_089f1f
	clc
rsv_089f20
	adc #$fed4
rsv_089f23
	sta.w al_worldy,x
rsv_089f26
	a8
rsv_089f28
	jsl retail_updateactorcell_l
rsv_089f2c
	lda #$03
rsv_089f2e
	sta.w al_sbyte4,x
rsv_089f31
	lda.w race_previewcount
rsv_089f34
	beq rsv_089f3a
rsv_089f36
	jsl retail_retireactor_l
rsv_089f3a
	rtl
retail_previewcar_l
	a16
rsv_089f3d
	lda #$0004
rsv_089f40
	jsl retail_spawncarid_l
rsv_089f44
	a16
rsv_089f46
	lda.w al_collobjptr,x
rsv_089f49
	beq retail_previewcarcamera_l
rsv_089f4b
	phx
rsv_089f4c
	tax
rsv_089f4d
	lda.l $700070,x
rsv_089f51
	ora #$0008
rsv_089f54
	sta.l $700070,x
rsv_089f58
	lda.l $700016,x
rsv_089f5c
	ora #$0080
rsv_089f5f
	sta.l $700016,x
rsv_089f63
	plx
retail_previewcarcamera_l
	ai16
rsv_089f66
	ldy #viewcamera1
rsv_089f69
	txa
rsv_089f6a
	sta.w $0002,y
rsv_089f6d
	lda #$0000
rsv_089f70
	sta.w $001a,y
rsv_089f73
	lda #$ff38
rsv_089f76
	sta.w $001c,y
rsv_089f79
	lda #$0258
rsv_089f7c
	sta.w $001e,y
rsv_089f7f
	a8
rsv_089f81
	lda #$01
rsv_089f83
	sta.w $0000,y
retail_registerpreview_l
	a8
rsv_089f88
	a16
rsv_089f8a
	lda #retail_previewcar_step&WM
rsv_089f8d
	sta.w al_stratptr,x
rsv_089f90
	a8
rsv_089f92
	lda #retail_previewcar_step>>16
rsv_089f94
	sta.w al_stratptr+2,x
rsv_089f97
	lda.w race_previewcount
rsv_089f9a
	asl a
rsv_089f9b
	a16
rsv_089f9d
	and #$00ff
rsv_089fa0
	phx
rsv_089fa1
	tax
rsv_089fa2
	pla
rsv_089fa3
	sta.l race_previewactors,x
rsv_089fa7
	tax
rsv_089fa8
	a8
rsv_089faa
	inc.w race_previewcount
rsv_089fad
	lda #$04
rsv_089faf
	sta.w al_sbyte1,x
retail_previewcar_step
	lda.l race_gridkind
rsv_089fb6
	jsl retail_carview_l
rsv_089fb9
	lda.w al_sbyte1,x
rsv_089fbc
	bne rsv_089fc2
rsv_089fbe
	jml rsv_089fc7
rsv_089fc2
	dec.w al_sbyte1,x
rsv_089fc5
	bra rsv_089fdc
rsv_089fc7
	phx
rsv_089fc8
	a16
rsv_089fca
	lda.w al_collobjptr,x
rsv_089fcd
	tax
rsv_089fce
	lda.l $70001c,x
rsv_089fd2
	ora #$0010
rsv_089fd5
	sta.l $70001c,x
rsv_089fd9
	a8
rsv_089fdb
	plx
rsv_089fdc
	jsl retail_updateactorcell_l
rsv_089fe0
	jsl retail_publishcar_l
rsv_089fe4
	lda #$03
rsv_089fe6
	sta.w al_sbyte4,x
rsv_089fe9
	jml retail_bodyframe_l
	shorta
	longi
retail_previewcamera_l
	ai16
rsv_089fee
	ldy #viewcamera1
rsv_089ff1
	txa
rsv_089ff2
	sta.w $0002,y
rsv_089ff5
	lda #$0000
rsv_089ff8
	sta.w $001a,y
rsv_089ffb
	lda #$fe0c
rsv_089ffe
	sta.w $001c,y
rsv_08a001
	lda #$0258
rsv_08a004
	sta.w $001e,y
rsv_08a007
	a8
rsv_08a009
	lda #$01
rsv_08a00b
	sta.w $0000,y
rsv_08a00e
	rtl
	shorta
	longi
retail_selectedcamera_l
	ai16
rsv_08a011
	ldx #viewcamera1
rsv_08a014
	ldy.w race_selectedactor
rsv_08a017
	sty x1,x
rsv_08a019
	lda #$0000
rsv_08a01c
	sta $1a,x
rsv_08a01e
	lda #$ff38
rsv_08a021
	sta $1c,x
rsv_08a023
	lda #$02bc
rsv_08a026
	sta $1e,x
rsv_08a028
	a8
rsv_08a02a
	lda #$01
rsv_08a02c
	sta $00,x
rsv_08a02e
	rtl
	shorta
	longi
rsv_bankreturn
	lda #$7e
rsv_08a031
	pha
rsv_08a032
	plb
rsv_return
	rtl
	shorta
	longi
retail_rotatingprop_l
	a16
rsv_08cd86
	lda #retail_rotatingprop_step&WM
rsv_08cd89
	sta.w al_stratptr,x
rsv_08cd8c
	a8
rsv_08cd8e
	lda #retail_rotatingprop_step>>16
rsv_08cd90
	sta.w al_stratptr+2,x
rsv_08cd93
	jsl retail_propframe_l
rsv_08cd97
	jsl retail_makefragment_l
rsv_08cd9b
	lda.w al_flags+1,x
rsv_08cd9e
	ora #$01
rsv_08cda0
	sta.w al_flags+1,x
rsv_08cda3
	rtl
retail_rotatingprop_step
	jsl retail_updateactorcell_l
rsv_08cda8
	jsl retail_keeprawobject_l
rsv_08cdac
	rtl
retail_animateprop_l
	jsl retail_offsetbody_l
rsv_08cdb1
	rtl
	shorta
	longi
retail_spinningprop_l
	a16
rsv_08cdb4
	lda #retail_spinningprop_make&WM
rsv_08cdb7
	sta.w al_tempstratptr,x
rsv_08cdba
	a8
rsv_08cdbc
	lda #retail_spinningprop_make>>16
rsv_08cdbe
	sta.w al_tempstratptr+2,x
rsv_08cdc1
	a16
rsv_08cdc3
	lda #retail_spinningprop_step&WM
rsv_08cdc6
	sta.w al_stratptr,x
rsv_08cdc9
	a8
rsv_08cdcb
	lda #retail_spinningprop_step>>16
rsv_08cdcd
	sta.w al_stratptr+2,x
retail_spinningprop_make
	jsl retail_makedragbody_l
rsv_08cdd4
	jsl retail_setcollisionmask_l
rsv_08cdd8
	lda #$20
rsv_08cdda
	jsl retail_setrawmass_l
retail_spinningprop_step
	lda.w al_roty,x
rsv_08cde1
	clc
rsv_08cde2
	adc #$01
rsv_08cde4
	sta.w al_roty,x
rsv_08cde7
	txy
rsv_08cde8
	a16
rsv_08cdea
	lda.w al_collobjptr,y
rsv_08cded
	beq rsv_08cdfb
rsv_08cdef
	tax
rsv_08cdf0
	lda.w al_roty,y
rsv_08cdf3
	and #$00ff
rsv_08cdf6
	sta.l $700024,x
rsv_08cdfa
	tyx
rsv_08cdfb
	a8
rsv_08cdfd
	jsl retail_publishbody_l
rsv_08ce01
	rtl

; Bind the existing early CPU arena; retain its allocated capacity.
; A8/I16 in, A16/I16 out. The reset command uses this binding.
 longa
 longi
retail_storegridsentinel_l
; The existing four grid words have no adjacent spare word. Keep the
; native fifth terminator separate rather than overwrite race_gridbytes.
	php
	cpx #8
	bne .inline
	plp
	sta.l race_gridsentinel
	rtl
.inline
	plp
	sta.l race_gridactors,x
	rtl

retail_bindearlypool_l
	ai16
 lda #alxblks
 sta.l race_poolfirst
 lda #number_al
 sta.l race_poolcount
 rtl

retail_mapdispatch
 dw rsv_nextcommand&WM
 dw rsv_mapactor&WM
 dw rsv_maproute&WM
 dw rsv_mapreset&WM
 dw rsv_mapyaw&WM
 dw rsv_mapanimated&WM
 dw rsv_maproot&WM
 dw rsv_mapcar&WM
 dw rsv_mapnamed&WM
 dw rsv_mapgrid&WM
 dw rsv_mapflags&WM
 dw rsv_mapcamera1&WM
 dw rsv_mapcamera2&WM
 dw rsv_mapoptions&WM
mrviews_end
