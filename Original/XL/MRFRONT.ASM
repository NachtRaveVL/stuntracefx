; Retail 2D sprite animation, palette scaling and display requests.
; D=0, DB=0, binary arithmetic, A16/I16 for entity operations.
; Entity frame/group IDs are native byte offsets, not CPU pointers.
; Clone destination uses race_spriteheap; initialize the forms first.
; Native clone exhaustion remains a non-returning trap. The register
; queue holds 32 records; full queues retain the retail diagnostic loop.
; Wait/fade entries require a caller-driven display service/acknowledgement;
; the early interrupt vectors are unchanged. Sprite callbacks stay in bank 9.
; Stream upload requires serialized GSU/ROM/SRAM ownership and an even,
; nonzero byte count within the initialized $70:3000 staging buffer.
	incpublics mrfront.ext
	include mrforms.ext
	include mrblank.ext
mrfront_begin
	longa
	longi
rdu_clonesprites
	ldx.w race_entitycurrent
rfu_0be1c8
	lda $14,x
rfu_0be1ca
	tax
rfu_0be1cb
	lda.l retail_spriteanims+2,x
rfu_0be1cf
	tax
rfu_0be1d0
	lda.l race_spritelists,x
rfu_0be1d4
	inc a
rfu_0be1d5
	asl a
rfu_0be1d6
	asl a
rfu_0be1d7
	asl a
rfu_0be1d8
	clc
rfu_0be1d9
	adc #$0002
rfu_0be1dc
	sta.w race_oambits
rfu_0be1df
	stx.w race_oamword
rfu_0be1e2
	ldx.w race_entitycurrent
rfu_0be1e5
	lda.w race_spriteheap
rfu_0be1e8
	sta $12,x
rfu_0be1ea
	sta.w race_spritesleft
rfu_0be1ed
	clc
rfu_0be1ee
	adc.w race_oambits
rfu_0be1f1
	cmp #$2c81
rfu_0be1f4
	bcs rfu_0be21f
rfu_0be1f6
	sta.w race_spriteheap
rfu_0be1f9
	ldx.w race_oamword
rfu_0be1fc
	lda.l race_spritelists,x
rfu_0be200
	ldx.w race_spritesleft
rfu_0be203
	sta.l race_spritelists,x
rfu_0be207
	inc.w race_oamword
rfu_0be20a
	inc.w race_oamword
rfu_0be20d
	inc.w race_spritesleft
rfu_0be210
	inc.w race_spritesleft
rfu_0be213
	dec.w race_oambits
rfu_0be216
	dec.w race_oambits
rfu_0be219
	bne rfu_0be1f9
rfu_0be21b
	ldx.w race_entitycurrent
rfu_0be21e
	rts
rfu_0be21f
	bra rfu_0be21f
	longa
	longi
rdu_stepx
	lda $00,x
rfu_0be223
	clc
rfu_0be224
	adc $1c,x
rfu_0be226
	sta $00,x
rfu_0be228
	lda $02,x
rfu_0be22a
	adc $1e,x
rfu_0be22c
	sta $02,x
rfu_0be22e
	rts
	longa
	longi
rdu_stepy
	lda $04,x
rfu_0be231
	clc
rfu_0be232
	adc $20,x
rfu_0be234
	sta $04,x
rfu_0be236
	lda $06,x
rfu_0be238
	adc $22,x
rfu_0be23a
	sta $06,x
rfu_0be23c
	rts
	longa
	longi
rdu_stepanim
	jsr rdu_tickanim
rfu_0be240
	lda.l race_frontfast
rfu_0be244
	beq rfu_0be24f
rfu_0be246
	jsr rdu_tickanim
rfu_0be249
	jsr rdu_tickanim
rfu_0be24c
	jsr rdu_tickanim
rfu_0be24f
	rts
	longa
	longi
rdu_tickanim
	lda $14,x
rfu_0be252
	bmi rfu_0be28c
rfu_0be254
	dec $18,x
rfu_0be256
	bpl rfu_0be28c
rfu_0be258
	sta.w race_oambits
rfu_0be25b
	lda $16,x
rfu_0be25d
	clc
rfu_0be25e
	adc #$0004
rfu_0be261
	sta $16,x
rfu_0be263
	clc
rfu_0be264
	adc.w race_oambits
rfu_0be267
	tax
rfu_0be268
	lda.l retail_spriteanims,x
rfu_0be26c
	bpl rfu_0be27a
rfu_0be26e
	ldx.w race_entitycurrent
rfu_0be271
	stz $16,x
rfu_0be273
	ldx.w race_oambits
rfu_0be276
	lda.l retail_spriteanims,x
rfu_0be27a
	dec a
rfu_0be27b
	sta.w race_oambits
rfu_0be27e
	lda.l retail_spriteanims+2,x
rfu_0be282
	ldx.w race_entitycurrent
rfu_0be285
	sta $12,x
rfu_0be287
	lda.w race_oambits
rfu_0be28a
	sta $18,x
rfu_0be28c
	rts
	longa
	longi
rdu_findentity
	sta.w race_oamword
rfu_0be290
	ldy.w race_entitybytes
rfu_0be293
	dey
rfu_0be294
	dey
rfu_0be295
	bmi rfu_0be2a6
rfu_0be297
	ldx.w race_entitylist,y
rfu_0be29a
	lda $1a,x
rfu_0be29c
	cmp.w race_oamword
rfu_0be29f
	bne rfu_0be2a2
rfu_0be2a1
	rts
rfu_0be2a2
	dey
rfu_0be2a3
	dey
rfu_0be2a4
	bpl rfu_0be297
rfu_0be2a6
	rts
	longa
	longi
rdu_offsetentities
	ldy.w race_entitybytes
rfu_0be2aa
	dey
rfu_0be2ab
	dey
rfu_0be2ac
	bmi rfu_0be2c4
rfu_0be2ae
	ldx.w race_entitylist,y
rfu_0be2b1
	lda $1a,x
rfu_0be2b3
	cmp #$0002
rfu_0be2b6
	bne rfu_0be2c0
rfu_0be2b8
	lda $06,x
rfu_0be2ba
	clc
rfu_0be2bb
	adc #$000c
rfu_0be2be
	sta $06,x
rfu_0be2c0
	dey
rfu_0be2c1
	dey
rfu_0be2c2
	bpl rfu_0be2ae
rfu_0be2c4
	rts
	longa
	longi
rdu_fadein
	php
rfu_0be2c6
	a8
rfu_0be2c8
	lda #$0f
rfu_0be2ca
	sta.w race_fronttarget
rfu_0be2cd
	plp
rfu_0be2ce
	rts
	longa
	longi
rdu_fadeout
	php
rfu_0be2d0
	a8
rfu_0be2d2
	stz.w race_fronttarget
rfu_0be2d5
	plp
rfu_0be2d6
	rts
	longa
	longi
rdu_fadehalf
	php
rfu_0be2d8
	a8
rfu_0be2da
	lda #$07
rfu_0be2dc
	sta.w race_fronttarget
rfu_0be2df
	plp
rfu_0be2e0
	rts
	longa
	longi
rdu_waitfade
	php
rfu_0be2e2
	a8
rfu_0be2e4
	jsr rdu_frontwait
rfu_0be2e7
	jsl retail_entityframe_l
rfu_0be2eb
	jsl retail_composeoam_l
rfu_0be2ef
	a8
rfu_0be2f1
	lda.w race_displayrequests
rfu_0be2f4
	ora #$1f
rfu_0be2f6
	sta.w race_displayrequests
rfu_0be2f9
	lda.w race_frontbright
rfu_0be2fc
	cmp.w race_fronttarget
rfu_0be2ff
	bne rfu_0be2e4
rfu_0be301
	plp
rfu_0be302
	rts
	longa
	longi
retail_scalepalette_l
	php
rfu_0be304
	ai16
rfu_0be306
	lda.l race_palfadebase,x
rfu_0be30a
	sta.w race_spritesleft
rfu_0be30d
	and #$001f
rfu_0be310
	a8
rfu_0be312
	sta.w $4202
rfu_0be315
	lda.w race_oambits
rfu_0be318
	sta.w $4203
rfu_0be31b
	a16
rfu_0be31d
	nop
rfu_0be31e
	nop
rfu_0be31f
	nop
rfu_0be320
	nop
rfu_0be321
	lda.w $4216
rfu_0be324
	asl a
rfu_0be325
	asl a
rfu_0be326
	asl a
rfu_0be327
	xba
rfu_0be328
	and #$001f
rfu_0be32b
	sta.w race_oamword
rfu_0be32e
	lda.w race_spritesleft
rfu_0be331
	and #$03e0
rfu_0be334
	asl a
rfu_0be335
	asl a
rfu_0be336
	asl a
rfu_0be337
	xba
rfu_0be338
	a8
rfu_0be33a
	sta.w $4202
rfu_0be33d
	lda.w race_oambits
rfu_0be340
	sta.w $4203
rfu_0be343
	a16
rfu_0be345
	nop
rfu_0be346
	nop
rfu_0be347
	nop
rfu_0be348
	nop
rfu_0be349
	lda.w $4216
rfu_0be34c
	and #$03e0
rfu_0be34f
	ora.w race_oamword
rfu_0be352
	sta.w race_oamword
rfu_0be355
	lda.w race_spritesleft
rfu_0be358
	and #$7c00
rfu_0be35b
	lsr a
rfu_0be35c
	lsr a
rfu_0be35d
	xba
rfu_0be35e
	and #$001f
rfu_0be361
	a8
rfu_0be363
	sta.w $4202
rfu_0be366
	lda.w race_oambits
rfu_0be369
	sta.w $4203
rfu_0be36c
	a16
rfu_0be36e
	nop
rfu_0be36f
	nop
rfu_0be370
	nop
rfu_0be371
	nop
rfu_0be372
	lda.w $4216
rfu_0be375
	and #$03e0
rfu_0be378
	lsr a
rfu_0be379
	lsr a
rfu_0be37a
	lsr a
rfu_0be37b
	xba
rfu_0be37c
	ora.w race_oamword
rfu_0be37f
	sta.w race_oamword
rfu_0be382
	sta.l race_palshadow,x
rfu_0be386
	inx
rfu_0be387
	inx
rfu_0be388
	dey
rfu_0be389
	bmi rfu_0be38e
rfu_0be38b
	brl rfu_0be306
rfu_0be38e
	plp
rfu_0be38f
	rtl
	longa
	longi
rdu_frontwait
	php
rfu_0be391
	a16
rfu_0be393
	lda.w race_frontwait
rfu_0be396
	ora #$0001
rfu_0be399
	sta.w race_frontwait
rfu_0be39c
	lda.w race_frontwait
rfu_0be39f
	bne rfu_0be39c
rfu_0be3a1
	plp
rfu_0be3a2
	rts
	longa
	longi
rdu_frontrandom
	php
rfu_0be3a4
	a8
rfu_0be3a6
	lda.w race_frontseed
rfu_0be3a9
	xba
rfu_0be3aa
	lda.w race_frontseed+1
rfu_0be3ad
	a16
rfu_0be3af
	lsr a
rfu_0be3b0
	clc
rfu_0be3b1
	adc.w race_frontseed
rfu_0be3b4
	adc.w race_frontseed
rfu_0be3b7
	eor.w race_frontxor
rfu_0be3ba
	sta.w race_frontseed
rfu_0be3bd
	plp
rfu_0be3be
	rts
	longa
	longi
rdu_debugbright
	lda.w race_frontdebug
rfu_0be3c2
	and #$0020
rfu_0be3c5
	beq rfu_0be3d1
rfu_0be3c7
	a8
rfu_0be3c9
	lda #$04
rfu_0be3cb
	sta.l $002100
rfu_0be3cf
	a16
rfu_0be3d1
	rts
	longa
	longi
rdu_streamtiles
	php
rfu_0be3d3
	ai16
rfu_0be3d5
	jsl retail_unpacktiles_l
rfu_0be3d9
	a8
rfu_0be3db
	i16
rfu_0be3dd
	lda #$80
rfu_0be3df
	sta.w $2115
rfu_0be3e2
	a16
rfu_0be3e4
	ldx #$0000
rfu_0be3e7
	lda.l $703000,x
rfu_0be3eb
	sta.w $2118
rfu_0be3ee
	inx
rfu_0be3ef
	inx
rfu_0be3f0
	cpx.w race_streambytes
rfu_0be3f3
	bne rfu_0be3e7
rfu_0be3f5
	plp
rfu_0be3f6
	rts
	longa
	longi
retail_queueregister_l
	php
rfu_0be3f8
	ai16
rfu_0be3fa
	pha
rfu_0be3fb
	phx
rfu_0be3fc
	and #$00ff
rfu_0be3ff
	pha
rfu_0be400
	ldx.w race_regbytes
rfu_0be403
	cpx #$0080
rfu_0be406
	beq rfu_0be41d
rfu_0be408
	pla
rfu_0be409
	sta.l race_regqueue+2,x
rfu_0be40d
	pla
rfu_0be40e
	sta.l race_regqueue,x
rfu_0be412
	txa
rfu_0be413
	clc
rfu_0be414
	adc #$0004
rfu_0be417
	sta.w race_regbytes
rfu_0be41a
	pla
rfu_0be41b
	plp
rfu_0be41c
	rtl
	longa
	longi
rfu_0be41d
	a8
rfu_0be41f
	lda #$0f
rfu_0be421
	sta.l $002100
rfu_0be425
	lda #$00
rfu_0be427
	sta.l $00420c
rfu_0be42b
	sta.l $004200
rfu_0be42f
	sta.l $00212c
rfu_0be433
	ldx #$0000
rfu_0be436
	txy
rfu_0be437
	txa
rfu_0be438
	sta.l $002121
rfu_0be43c
	sta.l $002121
rfu_0be440
	tya
rfu_0be441
	sta.l $002122
rfu_0be445
	sta.l $002122
rfu_0be449
	iny
rfu_0be44a
	nop
rfu_0be44b
	nop
rfu_0be44c
	nop
rfu_0be44d
	nop
rfu_0be44e
	nop
rfu_0be44f
	nop
rfu_0be450
	nop
rfu_0be451
	nop
rfu_0be452
	nop
rfu_0be453
	jmp rfu_0be437
retail_clonespritelist_l
	jsr rdu_clonesprites
	rtl
retail_stepentityx_l
	jsr rdu_stepx
	rtl
retail_stepentityy_l
	jsr rdu_stepy
	rtl
retail_stepentityanim_l
	jsr rdu_stepanim
	rtl
retail_tickentityanim_l
	jsr rdu_tickanim
	rtl
retail_findentity_l
	jsr rdu_findentity
	rtl
retail_offsetentities_l
	jsr rdu_offsetentities
	rtl
retail_fadein_l
	jsr rdu_fadein
	rtl
retail_fadeout_l
	jsr rdu_fadeout
	rtl
retail_fadehalf_l
	jsr rdu_fadehalf
	rtl
retail_waitfade_l
	jsr rdu_waitfade
	rtl
retail_frontwait_l
	jsr rdu_frontwait
	rtl
retail_frontrandom_l
	jsr rdu_frontrandom
	rtl
retail_debugbright_l
	jsr rdu_debugbright
	rtl
retail_streamtiles_l
	jsr rdu_streamtiles
	rtl
; Source binding for the retail copied sprite/HDMA data window.
; Initialize while no active entity owns a clone and display DMA is idle.
retail_initfrontforms_l
 php
 a8
 i16
 ldx #0
.copytables
 lda.l retail_fronttables,x
 sta.l race_fronttables,x
 inx
 cpx #129
 bcc .copytables
 a16
 ldx #0
.copyforms
 lda.l retail_spriteforms,x
 sta.l race_spritelists,x
 inx
 inx
 cpx #8202
 bcc .copyforms
 lda #$2881
 sta.w race_spriteheap
 plp
 rtl

mrfront_end
