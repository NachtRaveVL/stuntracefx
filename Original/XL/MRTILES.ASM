; Retail frontend packed-resource stages and cache loading.
; A16/I16, D=0, DB=0 and binary arithmetic; tilemap wrappers save P.
; The caller owns the GSU bus, scratch RAM $70:3000-$97FF, VRAM layout,
; frame blanking and queue publication. Drain each stage before dispatching
; the next: later decompressions/clears overwrite the queued GSU source.
; X is restored from race_entitycurrent; each stage installs the next near
; bank9 callback. Begin at loadobjects and finish when race_menuexit is set.
; loadcaches binds the real 8KiB texture and 26KiB option-card streams to
; the separate caches owned by MRUI. No new RAM or active NMI is installed.
; Assembled after MRMENU/MRUI, sharing their external declarations.
	incpublics mrtiles.ext
mrtiles_begin
	longa
	longi
rtl_loadobjects
	ai16
rtl_0bd1f9
	lda #retail_frontobjectspack_end&WM
rtl_0bd1fc
	ldx #retail_frontobjectspack_end>>16
rtl_0bd1ff
	jsl retail_unpacktiles_l
rtl_0bd203
	ai16
rtl_0bd205
	ai16
rtl_0bd207
	lda #$1000
rtl_0bd20a
	sta.l race_transferbytes
rtl_0bd20e
	lda #$0070
rtl_0bd211
	sta.l race_transferbank
rtl_0bd215
	lda #$3000
rtl_0bd218
	sta.l race_transfersource
rtl_0bd21c
	lda #$3000
rtl_0bd21f
	sta.l race_transferdest
rtl_0bd223
	jsl retail_queuegraphics_l
rtl_0bd227
	a16
rtl_0bd229
	i16
rtl_0bd22b
	ldx.w race_entitycurrent
rtl_0bd22e
	lda #rhk_loadmap&WM
rtl_0bd231
	sta $08,x
rtl_0bd233
	rts
rtl_loadmap
	lda #retail_frontmappack_end&WM
rtl_0bd237
	ldx #retail_frontmappack_end>>16
rtl_0bd23a
	jsl retail_unpacktiles_l
rtl_0bd23e
	ai16
rtl_0bd240
	ai16
rtl_0bd242
	lda #$1000
rtl_0bd245
	sta.l race_transferbytes
rtl_0bd249
	lda #$0070
rtl_0bd24c
	sta.l race_transferbank
rtl_0bd250
	lda #$3000
rtl_0bd253
	sta.l race_transfersource
rtl_0bd257
	lda #$6800
rtl_0bd25a
	sta.l race_transferdest
rtl_0bd25e
	jsl retail_queuegraphics_l
rtl_0bd262
	a16
rtl_0bd264
	i16
rtl_0bd266
	ldx.w race_entitycurrent
rtl_0bd269
	lda #rhk_loadmenumap&WM
rtl_0bd26c
	sta $08,x
rtl_0bd26e
	rts
rtl_loadmenumap
	jsr rtl_menumap0
rtl_0bd272
	ai16
rtl_0bd274
	ai16
rtl_0bd276
	lda #$0800
rtl_0bd279
	sta.l race_transferbytes
rtl_0bd27d
	lda #$0070
rtl_0bd280
	sta.l race_transferbank
rtl_0bd284
	lda #$3000
rtl_0bd287
	sta.l race_transfersource
rtl_0bd28b
	lda #$6000
rtl_0bd28e
	sta.l race_transferdest
rtl_0bd292
	jsl retail_queuegraphics_l
rtl_0bd296
	a16
rtl_0bd298
	i16
rtl_0bd29a
	ai16
rtl_0bd29c
	lda #$0800
rtl_0bd29f
	sta.l race_transferbytes
rtl_0bd2a3
	lda #$0070
rtl_0bd2a6
	sta.l race_transferbank
rtl_0bd2aa
	lda #$3800
rtl_0bd2ad
	sta.l race_transfersource
rtl_0bd2b1
	lda #$6400
rtl_0bd2b4
	sta.l race_transferdest
rtl_0bd2b8
	jsl retail_queuegraphics_l
rtl_0bd2bc
	a16
rtl_0bd2be
	i16
rtl_0bd2c0
	ldx.w race_entitycurrent
rtl_0bd2c3
	lda #rhk_loadback&WM
rtl_0bd2c6
	sta $08,x
rtl_0bd2c8
	rts
rtl_loadback
	lda #retail_frontbackpack_end&WM
rtl_0bd2cc
	ldx #retail_frontbackpack_end>>16
rtl_0bd2cf
	jsl retail_unpacktiles_l
rtl_0bd2d3
	ai16
rtl_0bd2d5
	ai16
rtl_0bd2d7
	lda #$1000
rtl_0bd2da
	sta.l race_transferbytes
rtl_0bd2de
	lda #$0070
rtl_0bd2e1
	sta.l race_transferbank
rtl_0bd2e5
	lda #$3000
rtl_0bd2e8
	sta.l race_transfersource
rtl_0bd2ec
	lda #$4000
rtl_0bd2ef
	sta.l race_transferdest
rtl_0bd2f3
	jsl retail_queuegraphics_l
rtl_0bd2f7
	a16
rtl_0bd2f9
	i16
rtl_0bd2fb
	ldx.w race_entitycurrent
rtl_0bd2fe
	lda #rhk_loadback1&WM
rtl_0bd301
	sta $08,x
rtl_0bd303
	rts
rtl_loadback1
	ai16
rtl_0bd306
	lda #$1000
rtl_0bd309
	sta.l race_transferbytes
rtl_0bd30d
	lda #$0070
rtl_0bd310
	sta.l race_transferbank
rtl_0bd314
	lda #$4000
rtl_0bd317
	sta.l race_transfersource
rtl_0bd31b
	lda #$4800
rtl_0bd31e
	sta.l race_transferdest
rtl_0bd322
	jsl retail_queuegraphics_l
rtl_0bd326
	a16
rtl_0bd328
	i16
rtl_0bd32a
	ldx.w race_entitycurrent
rtl_0bd32d
	lda #rhk_loadback2&WM
rtl_0bd330
	sta $08,x
rtl_0bd332
	rts
rtl_loadback2
	ai16
rtl_0bd335
	lda #$1000
rtl_0bd338
	sta.l race_transferbytes
rtl_0bd33c
	lda #$0070
rtl_0bd33f
	sta.l race_transferbank
rtl_0bd343
	lda #$5000
rtl_0bd346
	sta.l race_transfersource
rtl_0bd34a
	lda #$5000
rtl_0bd34d
	sta.l race_transferdest
rtl_0bd351
	jsl retail_queuegraphics_l
rtl_0bd355
	a16
rtl_0bd357
	i16
rtl_0bd359
	ldx.w race_entitycurrent
rtl_0bd35c
	lda #rhk_loadback3&WM
rtl_0bd35f
	sta $08,x
rtl_0bd361
	rts
rtl_loadback3
	ai16
rtl_0bd364
	lda #$1000
rtl_0bd367
	sta.l race_transferbytes
rtl_0bd36b
	lda #$0070
rtl_0bd36e
	sta.l race_transferbank
rtl_0bd372
	lda #$6000
rtl_0bd375
	sta.l race_transfersource
rtl_0bd379
	lda #$5800
rtl_0bd37c
	sta.l race_transferdest
rtl_0bd380
	jsl retail_queuegraphics_l
rtl_0bd384
	a16
rtl_0bd386
	i16
rtl_0bd388
	ldx.w race_entitycurrent
rtl_0bd38b
	lda #rhk_loadcaches&WM
rtl_0bd38e
	sta $08,x
rtl_0bd390
	rts
rtl_loadcaches
	ai16
rtl_0bd393
	lda #retail_fronttexturepack_end&WM
rtl_0bd396
	ldx #retail_fronttexturepack_end>>16
rtl_0bd399
	jsl retail_unpacktiles_l
rtl_0bd39d
	ai16
rtl_0bd39f
	ldx #$0000
rtl_0bd3a2
	lda.l $703000,x
rtl_0bd3a6
	sta.l race_fronttexture,x
rtl_0bd3aa
	inx
rtl_0bd3ab
	inx
rtl_0bd3ac
	cpx #$2000
rtl_0bd3af
	bne rtl_0bd3a2
rtl_0bd3b1
	lda #retail_optioncardspack_end&WM
rtl_0bd3b4
	ldx #retail_optioncardspack_end>>16
rtl_0bd3b7
	jsl retail_unpacktiles_l
rtl_0bd3bb
	ai16
rtl_0bd3bd
	ldx #$0000
rtl_0bd3c0
	lda.l $703000,x
rtl_0bd3c4
	sta.l race_menugraphics,x
rtl_0bd3c8
	inx
rtl_0bd3c9
	inx
rtl_0bd3ca
	cpx #$6800
rtl_0bd3cd
	bne rtl_0bd3c0
rtl_0bd3cf
	ldx.w race_entitycurrent
rtl_0bd3d2
	lda #rhk_clearfront&WM
rtl_0bd3d5
	sta $08,x
rtl_0bd3d7
	rts
rtl_clearfront
	ldx #$0000
rtl_0bd3db
	lda #$0000
rtl_0bd3de
	sta.l $703000,x
rtl_0bd3e2
	inx
rtl_0bd3e3
	inx
rtl_0bd3e4
	cpx #$3400
rtl_0bd3e7
	bne rtl_0bd3de
rtl_0bd3e9
	ai16
rtl_0bd3eb
	lda #$1000
rtl_0bd3ee
	sta.l race_transferbytes
rtl_0bd3f2
	lda #$0070
rtl_0bd3f5
	sta.l race_transferbank
rtl_0bd3f9
	lda #$3000
rtl_0bd3fc
	sta.l race_transfersource
rtl_0bd400
	lda #$0000
rtl_0bd403
	sta.l race_transferdest
rtl_0bd407
	jsl retail_queuegraphics_l
rtl_0bd40b
	a16
rtl_0bd40d
	i16
rtl_0bd40f
	ldx.w race_entitycurrent
rtl_0bd412
	lda #rhk_clearfront1&WM
rtl_0bd415
	sta $08,x
rtl_0bd417
	rts
rtl_clearfront1
	ai16
rtl_0bd41a
	lda #$1000
rtl_0bd41d
	sta.l race_transferbytes
rtl_0bd421
	lda #$0070
rtl_0bd424
	sta.l race_transferbank
rtl_0bd428
	lda #$3000
rtl_0bd42b
	sta.l race_transfersource
rtl_0bd42f
	lda #$0800
rtl_0bd432
	sta.l race_transferdest
rtl_0bd436
	jsl retail_queuegraphics_l
rtl_0bd43a
	a16
rtl_0bd43c
	i16
rtl_0bd43e
	ldx.w race_entitycurrent
rtl_0bd441
	lda #rhk_clearfront2&WM
rtl_0bd444
	sta $08,x
rtl_0bd446
	rts
rtl_clearfront2
	ai16
rtl_0bd449
	lda #$1000
rtl_0bd44c
	sta.l race_transferbytes
rtl_0bd450
	lda #$0070
rtl_0bd453
	sta.l race_transferbank
rtl_0bd457
	lda #$3000
rtl_0bd45a
	sta.l race_transfersource
rtl_0bd45e
	lda #$1000
rtl_0bd461
	sta.l race_transferdest
rtl_0bd465
	jsl retail_queuegraphics_l
rtl_0bd469
	a16
rtl_0bd46b
	i16
rtl_0bd46d
	ldx.w race_entitycurrent
rtl_0bd470
	lda #rhk_clearfront3&WM
rtl_0bd473
	sta $08,x
rtl_0bd475
	rts
rtl_clearfront3
	ai16
rtl_0bd478
	lda #$0400
rtl_0bd47b
	sta.l race_transferbytes
rtl_0bd47f
	lda #$0070
rtl_0bd482
	sta.l race_transferbank
rtl_0bd486
	lda #$3000
rtl_0bd489
	sta.l race_transfersource
rtl_0bd48d
	lda #$1800
rtl_0bd490
	sta.l race_transferdest
rtl_0bd494
	jsl retail_queuegraphics_l
rtl_0bd498
	a16
rtl_0bd49a
	i16
rtl_0bd49c
	ldx.w race_entitycurrent
rtl_0bd49f
	lda #rhk_loadfinished&WM
rtl_0bd4a2
	sta $08,x
rtl_0bd4a4
	rts
rtl_loadfinished
	a16
rtl_0bd4a7
	lda #$0001
rtl_0bd4aa
	sta.w race_menuexit
rtl_0bd4ad
	rts
rtl_menumap0
	php
rtl_0bf6b7
	ai16
rtl_0bf6b9
	lda #retail_menumappack_end&WM
rtl_0bf6bc
	ldx #retail_menumappack_end>>16
rtl_0bf6bf
	jsl retail_unpacktiles_l
rtl_0bf6c3
	ai16
rtl_0bf6c5
	lda #$0000
rtl_0bf6c8
	sta.w race_oamword
rtl_0bf6cb
	jsl retail_menutilemap_l
rtl_0bf6ce
	plp
rtl_0bf6cf
	rts
rtl_menumap1
	php
rtl_0bf6d1
	ai16
rtl_0bf6d3
	lda #retail_menumappack_end&WM
rtl_0bf6d6
	ldx #retail_menumappack_end>>16
rtl_0bf6d9
	jsl retail_unpacktiles_l
rtl_0bf6dd
	ai16
rtl_0bf6df
	lda #$0058
rtl_0bf6e2
	sta.w race_oamword
rtl_0bf6e5
	jsl retail_menutilemap_l
rtl_0bf6e8
	plp
rtl_0bf6e9
	rts
retail_loadobjects_l
	jsr rtl_loadobjects
	rtl
retail_loadmap_l
	jsr rtl_loadmap
	rtl
retail_loadmenumap_l
	jsr rtl_loadmenumap
	rtl
retail_loadback_l
	jsr rtl_loadback
	rtl
retail_loadback1_l
	jsr rtl_loadback1
	rtl
retail_loadback2_l
	jsr rtl_loadback2
	rtl
retail_loadback3_l
	jsr rtl_loadback3
	rtl
retail_loadcaches_l
	jsr rtl_loadcaches
	rtl
retail_clearfront_l
	jsr rtl_clearfront
	rtl
retail_clearfront1_l
	jsr rtl_clearfront1
	rtl
retail_clearfront2_l
	jsr rtl_clearfront2
	rtl
retail_clearfront3_l
	jsr rtl_clearfront3
	rtl
retail_loadfinished_l
	jsr rtl_loadfinished
	rtl
retail_menumap0_l
	jsr rtl_menumap0
	rtl
retail_menumap1_l
	jsr rtl_menumap1
	rtl
rtc_loadobjects
	jsr rtl_loadobjects
	rtl
rtc_loadmap
	jsr rtl_loadmap
	rtl
rtc_loadmenumap
	jsr rtl_loadmenumap
	rtl
rtc_loadback
	jsr rtl_loadback
	rtl
rtc_loadback1
	jsr rtl_loadback1
	rtl
rtc_loadback2
	jsr rtl_loadback2
	rtl
rtc_loadback3
	jsr rtl_loadback3
	rtl
rtc_loadcaches
	jsr rtl_loadcaches
	rtl
rtc_clearfront
	jsr rtl_clearfront
	rtl
rtc_clearfront1
	jsr rtl_clearfront1
	rtl
rtc_clearfront2
	jsr rtl_clearfront2
	rtl
rtc_clearfront3
	jsr rtl_clearfront3
	rtl
rtc_loadfinished
	jsr rtl_loadfinished
	rtl
mrtiles_end
