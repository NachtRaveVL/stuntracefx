; Retail visible-cell collection and 30-byte draw-list publication.
; Reconstructed from the relocated bank2 code (WRAM delta $22D9) and
; direct ROM upload entry $02:DA34. A8/I16, D=0, binary arithmetic.
; View/target cells come from setviewrecord_l. Templates are in this ROM
; bank; masked word-read adapters retain native byte behavior and DB.
; A mask yields at most 78 entries plus a zero terminator. Draw output is
; capped at 49 records, retaining stale bytes in fields the native omits.
; Native actor fields are rebound to the existing raw-scene layout;
; al_sector owns the final texture byte for these raw draw strategies.
; Set race_drawplayer to 0/1 and race_effectclock before building. Source
; shape headers must be bound; native $A040 remains a hidden placeholder.
; Collect, build and wake operate on CPU WRAM. Upload requires the GSU
; stopped and publishes m_numshapes/m_drawlist. Use mretail_sortdrawlist
; afterward; no scene, NMI, object-frame or renderer owner is installed.
; The source stack remains at $02FF. New CPU reservations cross $1F00;
; validation callers must not place their stack in that work area.
	incpublics mrdraw.ext
	include mario.ext
	include mrsort.ext
	include game.ext
	include ramstuff.ext
mrdraw_begin
	shorta
	longi
rdp_viewcells
	a8
rdp_02a249
	phb
rdp_02a24a
	lda #$7e
rdp_02a24c
	pha
rdp_02a24d
	plb
rdp_02a24e
	ai16
rdp_02a250
	lda.w viewmapindex
rdp_02a253
	sta.w race_visiblecell
rdp_02a256
	lda.w viewmapcol
rdp_02a259
	sta.w race_visiblecol
rdp_02a25c
	lda.w viewmaprow
rdp_02a25f
	sta.w race_visiblerow
rdp_02a262
	lda.w viewroty
rdp_02a265
	and #$00ff
rdp_02a268
	lsr a
rdp_02a269
	lsr a
rdp_02a26a
	lsr a
rdp_02a26b
	inc a
rdp_02a26c
	and #$00fe
rdp_02a26f
	tax
rdp_02a270
	lda.l retail_cellmaskptrs,x
rdp_02a273
	jsr rdp_decodecellmask
rdp_02a276
	a8
rdp_02a278
	plb
rdp_02a279
	rts
rdp_targetcells
	a8
rdp_02a27c
	phb
rdp_02a27d
	lda #$7e
rdp_02a27f
	pha
rdp_02a280
	plb
rdp_02a281
	a16
rdp_02a283
	lda.w targetmapindex
rdp_02a286
	sta.w race_visiblecell
rdp_02a289
	lda.w targetmapcol
rdp_02a28c
	sta.w race_visiblecol
rdp_02a28f
	lda.w targetmaprow
rdp_02a292
	sta.w race_visiblerow
rdp_02a295
	lda.w racesound_playmode
rdp_02a298
	and #$00ff
rdp_02a29b
	bne rdp_02a2a5
rdp_02a29d
	lda.w race_feedbackmode
rdp_02a2a0
	and #$0080
rdp_02a2a3
	beq rdp_02a2aa
rdp_02a2a5
	lda #retail_cellmaska388&WM
rdp_02a2a8
	bra rdp_02a2ad
rdp_02a2aa
	lda #retail_cellmaska3bd&WM
rdp_02a2ad
	jsr rdp_decodecellmask
rdp_02a2b0
	a8
rdp_02a2b2
	plb
rdp_02a2b3
	rts
	longa
rdp_decodecellmask
	tay
rdp_02a2b5
	ldx #$0000
rdp_02a2b8
	jsr rdp_maskword3
rdp_02a2bb
	and #$00ff
rdp_02a2be
	xba
rdp_02a2bf
	cmp #$8000
rdp_02a2c2
	ror a
rdp_02a2c3
	cmp #$8000
rdp_02a2c6
	ror a
rdp_02a2c7
	sta z1
rdp_02a2c9
	jsr rdp_maskword1
rdp_02a2cc
	and #$00ff
rdp_02a2cf
	sta.w z2
rdp_02a2d2
	jsr rdp_maskword2
rdp_02a2d5
	and #$00ff
rdp_02a2d8
	eor #$ffff
rdp_02a2db
	inc a
rdp_02a2dc
	asl a
rdp_02a2dd
	sta dx
rdp_02a2df
	jsr rdp_maskword0
rdp_02a2e2
	and #$00ff
rdp_02a2e5
	sta.w race_scratch
rdp_02a2e8
	lda dx
rdp_02a2ea
	sta x1
rdp_02a2ec
	lda.w race_scratch
rdp_02a2ef
	sta x2
rdp_02a2f1
	lda x1
rdp_02a2f3
	clc
rdp_02a2f4
	adc.w race_visiblecol
rdp_02a2f7
	and #$ffc0
rdp_02a2fa
	bne rdp_02a327
rdp_02a2fc
	lda z1
rdp_02a2fe
	clc
rdp_02a2ff
	adc.w race_visiblerow
rdp_02a302
	and #$f800
rdp_02a305
	bne rdp_02a327
rdp_02a307
	jsr rdp_maskword4
rdp_02a30a
	and #$00ff
rdp_02a30d
	cmp #$002e
rdp_02a310
	beq rdp_02a327
rdp_02a312
	sta.w race_visiblecells,x
rdp_02a315
	lda.w race_visiblecell
rdp_02a318
	clc
rdp_02a319
	adc x1
rdp_02a31b
	clc
rdp_02a31c
	adc z1
rdp_02a31e
	sta.w race_visiblecells+2,x
rdp_02a321
	txa
rdp_02a322
	clc
rdp_02a323
	adc #$0004
rdp_02a326
	tax
rdp_02a327
	iny
rdp_02a328
	inc x1
rdp_02a32a
	inc x1
rdp_02a32c
	dec x2
rdp_02a32e
	bne rdp_02a2f1
rdp_02a330
	lda z1
rdp_02a332
	sec
rdp_02a333
	sbc #$0040
rdp_02a336
	sta z1
rdp_02a338
	dec.w z2
rdp_02a33b
	bne rdp_02a2e8
rdp_02a33d
	stz.w race_visiblecells,x
rdp_02a340
	stz.w race_visiblecells+2,x
rdp_02a343
	rts
	shorta
rdp_waitdrawtask
	a8
rdp_02bef4
	inc mariotimer
rdp_02bef6
	bne rdp_02befa
rdp_02bef8
	inc mariotimer+1
rdp_02befa
	lda.w $3030
rdp_02befd
	and #$20
rdp_02beff
	bne rdp_02bef4
rdp_02bf01
	lda.w mario_draw_mode
rdp_02bf04
	sta.w $303a
rdp_02bf07
	rts
rdp_builddrawlist
	php
rdp_02cc78
	phb
rdp_02cc79
	a8
rdp_02cc7b
	lda #$7e
rdp_02cc7d
	pha
rdp_02cc7e
	plb
rdp_02cc7f
	ai16
rdp_02cc81
	stz.w numalx
rdp_02cc84
	stz.w race_scratch
rdp_02cc87
	ldx #race_drawlist&WM
rdp_02cc8a
	stx tpx
rdp_02cc8c
	ldx.w race_scratch
rdp_02cc8f
	lda.w race_visiblecells,x
rdp_02cc92
	bne rdp_02cc97
rdp_02cc94
	brl rdp_02cdf7
rdp_02cc97
	sta.w race_visiblekind
rdp_02cc9a
	lda.w race_visiblecells+2,x
rdp_02cc9d
	inx
rdp_02cc9e
	inx
rdp_02cc9f
	inx
rdp_02cca0
	inx
rdp_02cca1
	stx.w race_scratch
rdp_02cca4
	and #$07fe
rdp_02cca7
	tax
rdp_02cca8
	lda.l race_cellheads,x
rdp_02ccac
	beq rdp_02cc8c
rdp_02ccae
	tay
rdp_02ccaf
	ldx tpx
rdp_02ccb1
	a8
rdp_02ccb3
	sty.w race_protectedactor
rdp_02ccb6
	lda.w al_sflags,y
rdp_02ccb9
	bit #$20
rdp_02ccbb
	bne rdp_02ccd4
rdp_02ccbd
	bit #$40
rdp_02ccbf
	beq rdp_02ccd7
rdp_02ccc1
	lda.w al_whocanseeme,y
rdp_02ccc4
	cmp #$02
rdp_02ccc6
	beq rdp_02cccf
rdp_02ccc8
	lda.w race_drawplayer
rdp_02cccb
	bne rdp_02ccd7
rdp_02cccd
	bra rdp_02ccd4
rdp_02cccf
	lda.w race_drawplayer
rdp_02ccd2
	beq rdp_02ccd7
rdp_02ccd4
	jmp rdp_02cde7
rdp_02ccd7
	a16
rdp_02ccd9
	lda.w numalx
rdp_02ccdc
	cmp #$0031
rdp_02ccdf
	bmi rdp_02cce4
rdp_02cce1
	brl rdp_02cde7
rdp_02cce4
	lda.w al_shape,y
rdp_02cce7
	cmp #$a040
rdp_02ccea
	bne rdp_02ccef
rdp_02ccec
	brl rdp_02cde7
rdp_02ccef
	lda.w al_sflags,y
rdp_02ccf2
	bit #$0080
rdp_02ccf5
	beq rdp_02cd11
rdp_02ccf7
	lda.w al_worldx,y
rdp_02ccfa
	sta.w $0012,x
rdp_02ccfd
	lda.w al_worldy,y
rdp_02cd00
	sta.w $0010,x
rdp_02cd03
	lda.w al_worldz,y
rdp_02cd06
	sta.w $0014,x
rdp_02cd09
	lda #$f060
rdp_02cd0c
	sta.w $0002,x
rdp_02cd0f
	bra rdp_02cd4d
rdp_02cd11
	lda.w al_worldy,y
rdp_02cd14
	sec
rdp_02cd15
	sbc viewposy
rdp_02cd17
	sta.w $0010,x
rdp_02cd1a
	bpl rdp_02cd20
rdp_02cd1c
	eor #$ffff
rdp_02cd1f
	inc a
rdp_02cd20
	asl a
rdp_02cd21
	sta.w $0002,x
rdp_02cd24
	lda.w al_flags+1,y
rdp_02cd27
	bit #$0001
rdp_02cd2a
	beq rdp_02cd31
rdp_02cd2c
	lda #$1f40
rdp_02cd2f
	bra rdp_02cd34
rdp_02cd31
	lda #$0000
rdp_02cd34
	clc
rdp_02cd35
	adc.w $0002,x
rdp_02cd38
	sta.w $0002,x
rdp_02cd3b
	lda.w al_worldx,y
rdp_02cd3e
	sec
rdp_02cd3f
	sbc viewposx
rdp_02cd41
	sta.w $0012,x
rdp_02cd44
	lda.w al_worldz,y
rdp_02cd47
	sec
rdp_02cd48
	sbc viewposz
rdp_02cd4a
	sta.w $0014,x
rdp_02cd4d
	lda.w al_shape,y
rdp_02cd50
	sta.w $0008,x
rdp_02cd53
	lda.w al_rotx,y
rdp_02cd56
	sta.w $0004,x
rdp_02cd59
	lda.w al_roty,y
rdp_02cd5c
	sta.w $0005,x
rdp_02cd5f
	lda.w al_rotz,y
rdp_02cd62
	sta.w $0006,x
rdp_02cd65
	lda.w al_sflags,y
rdp_02cd68
	bit #$0004
rdp_02cd6b
	beq rdp_02cd89
rdp_02cd6d
	a16
rdp_02cd6f
	tya
rdp_02cd70
	sta.w $000a,x
rdp_02cd73
	a8
rdp_02cd75
	lda.w al_sbyte1,y
rdp_02cd78
	sta.w $000c,x
rdp_02cd7b
	lda.w al_sbyte2,y
rdp_02cd7e
	sta.w $000d,x
rdp_02cd81
	lda.w al_sbyte3,y
rdp_02cd84
	sta.w $000e,x
rdp_02cd87
	bra rdp_02cd90
	longa
rdp_02cd89
	a8
rdp_02cd8b
	lda #$00
rdp_02cd8d
	sta.w $0018,x
rdp_02cd90
	lda.w al_sflags,y
rdp_02cd93
	sta.w $0007,x
rdp_02cd96
	and #$fd
rdp_02cd98
	sta.w al_sflags,y
rdp_02cd9b
	lda.w al_colframe,y
rdp_02cd9e
	bmi rdp_02cda3
rdp_02cda0
	lda.w race_effectclock
rdp_02cda3
	and #$7f
rdp_02cda5
	sta.w $0019,x
rdp_02cda8
	lda.w race_drawplayer
rdp_02cdab
	beq rdp_02cdb7
rdp_02cdad
	lda.w al_sflags4,y
rdp_02cdb0
	bmi rdp_02cdbf
rdp_02cdb2
	lda.w race_effectclock
rdp_02cdb5
	bra rdp_02cdbf
rdp_02cdb7
	lda.w al_sflags3,y
rdp_02cdba
	bmi rdp_02cdbf
rdp_02cdbc
	lda.w race_effectclock
rdp_02cdbf
	and #$7f
rdp_02cdc1
	sta.w $001a,x
rdp_02cdc4
	lda.w al_lapcnt,y
rdp_02cdc7
	sta.w $001b,x
rdp_02cdca
	lda.w al_eyesize,y
rdp_02cdcd
	sta.w $001c,x
rdp_02cdd0
	lda.w al_sector,y
rdp_02cdd3
	sta.w $001d,x
rdp_02cdd6
	a16
rdp_02cdd8
	lda.w al_coltab,y
rdp_02cddb
	sta.w $0016,x
rdp_02cdde
	txa
rdp_02cddf
	clc
rdp_02cde0
	adc #$001e
rdp_02cde3
	tax
rdp_02cde4
	inc.w numalx
rdp_02cde7
	a16
rdp_02cde9
	lda.w al_mapptr,y
rdp_02cdec
	tay
rdp_02cded
	beq rdp_02cdf2
rdp_02cdef
	brl rdp_02ccb1
rdp_02cdf2
	stx tpx
rdp_02cdf4
	jmp rdp_02cc8c
rdp_02cdf7
	plb
rdp_02cdf8
	plp
rdp_02cdf9
	rts
	shorta
rdp_wakevisible
	php
rdp_02ce09
	phb
rdp_02ce0a
	a8
rdp_02ce0c
	lda #$7e
rdp_02ce0e
	pha
rdp_02ce0f
	plb
rdp_02ce10
	ai16
rdp_02ce12
	stz.w race_scratch
rdp_02ce15
	ldx.w race_scratch
rdp_02ce18
	lda.w race_visiblecells,x
rdp_02ce1b
	bne rdp_02ce20
rdp_02ce1d
	brl rdp_02ce65
rdp_02ce20
	sta.w race_visiblekind
rdp_02ce23
	lda.w race_visiblecells+2,x
rdp_02ce26
	inx
rdp_02ce27
	inx
rdp_02ce28
	inx
rdp_02ce29
	inx
rdp_02ce2a
	stx.w race_scratch
rdp_02ce2d
	and #$07fe
rdp_02ce30
	tax
rdp_02ce31
	lda.l race_cellheads,x
rdp_02ce35
	beq rdp_02ce15
rdp_02ce37
	tay
rdp_02ce38
	ldx tpx
rdp_02ce3a
	a8
rdp_02ce3c
	lda.w race_visiblekind
rdp_02ce3f
	cmp #$23
rdp_02ce41
	bne rdp_02ce4e
rdp_02ce43
	lda.w al_sflags,y
rdp_02ce46
	and #$10
rdp_02ce48
	beq rdp_02ce4e
rdp_02ce4a
	jml rdp_02ce58
rdp_02ce4e
	lda.w al_sbyte4,y
rdp_02ce51
	bmi rdp_02ce58
rdp_02ce53
	lda #$03
rdp_02ce55
	sta.w al_sbyte4,y
rdp_02ce58
	a16
rdp_02ce5a
	lda.w al_mapptr,y
rdp_02ce5d
	tay
rdp_02ce5e
	bne rdp_02ce3a
rdp_02ce60
	stx tpx
rdp_02ce62
	jmp rdp_02ce15
rdp_02ce65
	plb
rdp_02ce66
	plp
rdp_02ce67
	rts
	shorta
rdp_uploaddrawlist
	a8
rdp_02da36
	phb
rdp_02da37
	lda #$70
rdp_02da39
	pha
rdp_02da3a
	plb
rdp_02da3b
	ai16
rdp_02da3d
	lda.l numalx
rdp_02da41
	sta.l m_numshapes
rdp_02da45
	bne rdp_02da4a
rdp_02da47
	brl rdp_02dad4
rdp_02da4a
	ldx #race_drawlist&WM
rdp_02da4d
	ldy #m_drawlist&WM
rdp_02da50
	sta.l race_scratch
rdp_02da54
	lda.l $7e0000,x
rdp_02da58
	sta.w $0000,y
rdp_02da5b
	lda.l $7e0002,x
rdp_02da5f
	sta.w $0002,y
rdp_02da62
	lda.l $7e0004,x
rdp_02da66
	sta.w $0004,y
rdp_02da69
	lda.l $7e0006,x
rdp_02da6d
	sta.w $0006,y
rdp_02da70
	lda.l $7e0008,x
rdp_02da74
	sta.w $0008,y
rdp_02da77
	lda.l $7e000a,x
rdp_02da7b
	sta.w $000a,y
rdp_02da7e
	lda.l $7e000c,x
rdp_02da82
	sta.w $000c,y
rdp_02da85
	lda.l $7e000e,x
rdp_02da89
	sta.w $000e,y
rdp_02da8c
	lda.l $7e0010,x
rdp_02da90
	sta.w $0010,y
rdp_02da93
	lda.l $7e0012,x
rdp_02da97
	sta.w $0012,y
rdp_02da9a
	lda.l $7e0014,x
rdp_02da9e
	sta.w $0014,y
rdp_02daa1
	lda.l $7e0016,x
rdp_02daa5
	sta.w $0016,y
rdp_02daa8
	lda.l $7e0018,x
rdp_02daac
	sta.w $0018,y
rdp_02daaf
	lda.l $7e001a,x
rdp_02dab3
	sta.w $001a,y
rdp_02dab6
	lda.l $7e001c,x
rdp_02daba
	sta.w $001c,y
rdp_02dabd
	tya
rdp_02dabe
	clc
rdp_02dabf
	adc #$001e
rdp_02dac2
	tay
rdp_02dac3
	txa
rdp_02dac4
	clc
rdp_02dac5
	adc #$001e
rdp_02dac8
	tax
rdp_02dac9
	lda.l race_scratch
rdp_02dacd
	dec a
rdp_02dace
	sta.l race_scratch
rdp_02dad2
	bne rdp_02da54
rdp_02dad4
	plb
rdp_02dad5
	rtl
	shorta
rdp_projectdrawlist
	jsl getviewmat_l
rdp_02db5d
	a8
rdp_02db5f
	i16
rdp_02db61
	a8
rdp_02db63
	lda #mretail_sortdrawlist>>16
rdp_02db65
	ldx #mretail_sortdrawlist&WM
rdp_02db68
	jsl runmario_l
rdp_02db6c
	a8
rdp_02db6e
	i16
rdp_02db70
	rtl
retail_viewcells_l
	jsr rdp_viewcells
	rtl
retail_targetcells_l
	jsr rdp_targetcells
	rtl
retail_decodecellmask_l
	jsr rdp_decodecellmask
	rtl
retail_waitdrawtask_l
	jsr rdp_waitdrawtask
	rtl
retail_builddrawlist_l
	jsr rdp_builddrawlist
	rtl
retail_wakevisible_l
	jsr rdp_wakevisible
	rtl
retail_uploaddrawlist_l equ rdp_uploaddrawlist
retail_projectdrawlist_l equ rdp_projectdrawlist
	longa
	longi
rdp_maskword0
	phb
	phk
	plb
	lda.w $0000,y
	plb
	rts
rdp_maskword1
	phb
	phk
	plb
	lda.w $0001,y
	plb
	rts
rdp_maskword2
	phb
	phk
	plb
	lda.w $0002,y
	plb
	rts
rdp_maskword3
	phb
	phk
	plb
	lda.w $0003,y
	plb
	rts
rdp_maskword4
	phb
	phk
	plb
	lda.w $0004,y
	plb
	rts
retail_cellmaskptrs
	dw retail_cellmaska447&WM
	dw retail_cellmaska491&WM
	dw retail_cellmaska4ef&WM
	dw retail_cellmaska557&WM
	dw retail_cellmaska5b5&WM
	dw retail_cellmaska5ff&WM
	dw retail_cellmaska65d&WM
	dw retail_cellmaska6c5&WM
	dw retail_cellmaska723&WM
	dw retail_cellmaska76d&WM
	dw retail_cellmaska7cb&WM
	dw retail_cellmaska833&WM
	dw retail_cellmaska891&WM
	dw retail_cellmaska8db&WM
	dw retail_cellmaska939&WM
	dw retail_cellmaska9a1&WM
	dw retail_cellmaska447&WM
retail_cellmaskptrs_end
retail_cellmaska388
	db $07,$07,$03,$03,$2e,$23,$23,$23,$23,$23,$2e,$23
	db $23,$23,$23,$23,$23,$23,$23,$23,$3d,$3d,$3d,$23
	db $23,$23,$23,$3d,$2a,$3d,$23,$23,$23,$23,$3d,$3d
	db $3d,$23,$23,$23,$23,$23,$23,$23,$23,$23,$2e,$23
	db $23,$23,$23,$23,$2e
retail_cellmaska388_end
retail_cellmaska3bd
	db $09,$09,$04,$04,$2e,$2e,$23,$23,$23,$23,$23,$2e
	db $2e,$2e,$23,$23,$23,$23,$23,$23,$23,$2e,$23,$23
	db $23,$3d,$3d,$3d,$23,$23,$23,$23,$23,$3d,$3d,$3d
	db $3d,$3d,$23,$23,$23,$23,$3d,$3d,$2a,$3d,$3d,$23
	db $23,$23,$23,$3d,$3d,$3d,$3d,$3d,$23,$23,$23,$23
	db $23,$3d,$3d,$3d,$23,$23,$23,$2e,$23,$23,$23,$23
	db $23,$23,$23,$2e,$2e,$2e,$23,$23,$23,$23,$23,$2e
	db $2e
retail_cellmaska3bd_end
retail_cellmaska447
	db $07,$0a,$03,$07,$2e,$6f,$6f,$6f,$6f,$6f,$2e,$6f
	db $6f,$6f,$6f,$6f,$6f,$6f,$6f,$6f,$23,$23,$23,$6f
	db $6f,$6f,$23,$23,$23,$23,$23,$6f,$6f,$3d,$3d,$3d
	db $3d,$3d,$6f,$6f,$3d,$3d,$3d,$3d,$3d,$6f,$6f,$3d
	db $3d,$3d,$3d,$3d,$6f,$6f,$3d,$3d,$2a,$3d,$3d,$6f
	db $2d,$6f,$3d,$3d,$3d,$6f,$2d,$2d,$2d,$6f,$6f,$6f
	db $2d,$2d
retail_cellmaska447_end
retail_cellmaska491
	db $09,$0a,$02,$07,$2e,$2e,$6f,$6f,$6f,$6f,$6f,$2e
	db $2e,$2e,$6f,$6f,$6f,$6f,$6f,$6f,$6f,$6f,$2d,$6f
	db $23,$23,$23,$6f,$6f,$6f,$6f,$2d,$6f,$23,$23,$23
	db $23,$23,$6f,$2e,$6f,$6f,$3d,$3d,$23,$23,$23,$6f
	db $2e,$6f,$3d,$3d,$3d,$3d,$3d,$6f,$2e,$2e,$6f,$3d
	db $3d,$3d,$3d,$3d,$6f,$2e,$2e,$6f,$3d,$2a,$3d,$3d
	db $6f,$2d,$2d,$2e,$6f,$3d,$3d,$3d,$6f,$2d,$2d,$2d
	db $2e,$2d,$6f,$6f,$6f,$2d,$2d,$2d,$2d,$2e
retail_cellmaska491_end
retail_cellmaska4ef
	db $0a,$0a,$02,$07,$2e,$2e,$2e,$2e,$2e,$6f,$6f,$2e
	db $2e,$2e,$2e,$2e,$2e,$2e,$6f,$23,$6f,$6f,$2e,$2e
	db $2d,$2d,$2e,$6f,$23,$23,$23,$6f,$6f,$2e,$2d,$2d
	db $6f,$3d,$3d,$23,$23,$23,$6f,$6f,$2d,$6f,$3d,$3d
	db $3d,$3d,$23,$23,$23,$6f,$6f,$3d,$3d,$3d,$3d,$3d
	db $3d,$23,$6f,$2e,$6f,$3d,$3d,$3d,$3d,$3d,$3d,$6f
	db $2e,$2e,$6f,$3d,$2a,$3d,$3d,$3d,$6f,$2d,$2d,$2e
	db $6f,$6f,$3d,$3d,$3d,$6f,$2d,$2d,$2d,$2e,$6f,$6f
	db $6f,$6f,$6f,$2d,$2d,$2d,$2d,$2e
retail_cellmaska4ef_end
retail_cellmaska557
	db $0a,$09,$02,$06,$2e,$2e,$2e,$2e,$2e,$2e,$2e,$6f
	db $6f,$2e,$2e,$2e,$2e,$2e,$2e,$6f,$6f,$6f,$6f,$2e
	db $2d,$2d,$2d,$6f,$6f,$23,$23,$6f,$6f,$6f,$2d,$2d
	db $6f,$3d,$3d,$23,$23,$6f,$6f,$6f,$2d,$6f,$3d,$3d
	db $3d,$23,$23,$23,$6f,$6f,$6f,$3d,$3d,$3d,$3d,$3d
	db $23,$23,$6f,$6f,$6f,$3d,$2a,$3d,$3d,$3d,$23,$23
	db $6f,$6f,$6f,$3d,$3d,$3d,$3d,$6f,$6f,$6f,$6f,$2e
	db $2d,$6f,$6f,$6f,$6f,$6f,$2d,$2d,$2e,$2e
retail_cellmaska557_end
retail_cellmaska5b5
	db $0a,$07,$02,$03,$2d,$2d,$6f,$6f,$6f,$6f,$6f,$6f
	db $6f,$2e,$2d,$6f,$3d,$3d,$3d,$23,$23,$6f,$6f,$6f
	db $6f,$3d,$3d,$3d,$3d,$3d,$23,$23,$6f,$6f,$6f,$3d
	db $2a,$3d,$3d,$3d,$23,$23,$6f,$6f,$6f,$3d,$3d,$3d
	db $3d,$3d,$23,$23,$6f,$6f,$2d,$6f,$3d,$3d,$3d,$23
	db $23,$6f,$6f,$6f,$2d,$2d,$6f,$6f,$6f,$6f,$6f,$6f
	db $6f,$2e
retail_cellmaska5b5_end
retail_cellmaska5ff
	db $0a,$09,$02,$02,$2d,$6f,$6f,$6f,$6f,$6f,$2d,$2d
	db $2e,$2e,$6f,$3d,$3d,$3d,$3d,$6f,$6f,$6f,$6f,$2e
	db $6f,$3d,$2a,$3d,$3d,$3d,$23,$23,$6f,$6f,$6f,$3d
	db $3d,$3d,$3d,$3d,$23,$23,$6f,$6f,$2d,$6f,$3d,$3d
	db $3d,$23,$23,$23,$6f,$6f,$2d,$2d,$6f,$3d,$3d,$23
	db $23,$6f,$6f,$6f,$2e,$2e,$2e,$6f,$6f,$23,$23,$6f
	db $6f,$6f,$2e,$2e,$2e,$2e,$2e,$6f,$6f,$6f,$6f,$2e
	db $2e,$2e,$2e,$2e,$2e,$2e,$2e,$6f,$6f,$2e
retail_cellmaska5ff_end
retail_cellmaska65d
	db $0a,$0a,$02,$02,$6f,$6f,$6f,$6f,$6f,$2d,$2d,$2e
	db $2e,$2e,$6f,$6f,$3d,$3d,$3d,$6f,$2d,$2e,$2e,$2e
	db $6f,$3d,$2a,$3d,$3d,$3d,$6f,$2e,$2e,$2e,$6f,$3d
	db $3d,$3d,$3d,$3d,$3d,$6f,$2e,$2e,$6f,$3d,$3d,$3d
	db $3d,$3d,$3d,$23,$6f,$2e,$2d,$6f,$3d,$3d,$3d,$3d
	db $23,$23,$23,$6f,$2d,$2d,$6f,$3d,$3d,$23,$23,$23
	db $6f,$6f,$2e,$2e,$2e,$6f,$23,$23,$23,$6f,$6f,$2e
	db $2e,$2e,$2e,$2e,$6f,$23,$6f,$6f,$2e,$2e,$2e,$2e
	db $2e,$2e,$2e,$6f,$6f,$2e,$2e,$2e
retail_cellmaska65d_end
retail_cellmaska6c5
	db $09,$0a,$02,$02,$2d,$6f,$6f,$6f,$2d,$2d,$2e,$2e
	db $2e,$6f,$3d,$3d,$3d,$6f,$2d,$2e,$2e,$2e,$6f,$3d
	db $2a,$3d,$3d,$6f,$2d,$2e,$2e,$6f,$3d,$3d,$3d,$3d
	db $3d,$6f,$2e,$2e,$6f,$3d,$3d,$3d,$3d,$3d,$6f,$2e
	db $2e,$6f,$6f,$3d,$3d,$23,$23,$23,$6f,$2e,$2d,$6f
	db $23,$23,$23,$23,$23,$6f,$2e,$2e,$6f,$23,$23,$23
	db $6f,$6f,$6f,$6f,$2e,$6f,$6f,$6f,$6f,$6f,$6f,$6f
	db $6f,$2e,$2e,$6f,$6f,$6f,$6f,$6f,$2e,$2e
retail_cellmaska6c5_end
retail_cellmaska723
	db $07,$0a,$03,$02,$2d,$2d,$6f,$6f,$6f,$2d,$2d,$2d
	db $6f,$3d,$3d,$3d,$6f,$2d,$6f,$3d,$3d,$2a,$3d,$3d
	db $6f,$6f,$3d,$3d,$3d,$3d,$3d,$6f,$6f,$3d,$3d,$3d
	db $3d,$3d,$6f,$6f,$3d,$3d,$3d,$3d,$3d,$6f,$6f,$23
	db $23,$23,$23,$23,$6f,$6f,$6f,$23,$23,$23,$6f,$6f
	db $6f,$6f,$6f,$6f,$6f,$6f,$6f,$2e,$6f,$6f,$6f,$6f
	db $6f,$2e
retail_cellmaska723_end
retail_cellmaska76d
	db $09,$0a,$06,$02,$2e,$2e,$2d,$2d,$2d,$6f,$6f,$6f
	db $2d,$2e,$2e,$2d,$2d,$6f,$3d,$3d,$3d,$6f,$2e,$2e
	db $2d,$6f,$3d,$3d,$2a,$3d,$6f,$2e,$2e,$6f,$3d,$3d
	db $3d,$3d,$3d,$6f,$2e,$2e,$6f,$3d,$3d,$3d,$3d,$3d
	db $6f,$2e,$6f,$23,$23,$23,$3d,$3d,$6f,$6f,$2e,$6f
	db $23,$23,$23,$23,$23,$6f,$2d,$6f,$6f,$6f,$6f,$23
	db $23,$23,$6f,$2e,$6f,$6f,$6f,$6f,$6f,$6f,$6f,$6f
	db $2e,$2e,$2e,$6f,$6f,$6f,$6f,$6f,$2e,$2e
retail_cellmaska76d_end
retail_cellmaska7cb
	db $0a,$0a,$07,$02,$2e,$2e,$2d,$2d,$2d,$6f,$6f,$6f
	db $6f,$6f,$2e,$2e,$2d,$2d,$6f,$3d,$3d,$3d,$6f,$6f
	db $2e,$2e,$2e,$6f,$3d,$3d,$3d,$2a,$3d,$6f,$2e,$2e
	db $6f,$3d,$3d,$3d,$3d,$3d,$3d,$6f,$2e,$6f,$23,$3d
	db $3d,$3d,$3d,$3d,$3d,$6f,$6f,$23,$23,$23,$3d,$3d
	db $3d,$3d,$6f,$2d,$6f,$6f,$23,$23,$23,$3d,$3d,$6f
	db $2d,$2d,$2e,$6f,$6f,$23,$23,$23,$6f,$2e,$2e,$2e
	db $2e,$2e,$6f,$6f,$23,$6f,$2e,$2e,$2e,$2e,$2e,$2e
	db $2e,$6f,$6f,$2e,$2e,$2e,$2e,$2e
retail_cellmaska7cb_end
retail_cellmaska833
	db $0a,$09,$07,$02,$2e,$2e,$2d,$2d,$6f,$6f,$6f,$6f
	db $6f,$2d,$2e,$6f,$6f,$6f,$6f,$3d,$3d,$3d,$3d,$6f
	db $6f,$6f,$23,$23,$3d,$3d,$3d,$2a,$3d,$6f,$6f,$6f
	db $23,$23,$3d,$3d,$3d,$3d,$3d,$6f,$6f,$6f,$23,$23
	db $23,$3d,$3d,$3d,$6f,$2d,$6f,$6f,$6f,$23,$23,$3d
	db $3d,$6f,$2d,$2d,$6f,$6f,$6f,$23,$23,$6f,$6f,$2e
	db $2e,$2e,$2e,$6f,$6f,$6f,$6f,$2e,$2e,$2e,$2e,$2e
	db $2e,$6f,$6f,$2e,$2e,$2e,$2e,$2e,$2e,$2e
retail_cellmaska833_end
retail_cellmaska891
	db $09,$07,$06,$03,$2e,$6f,$6f,$6f,$6f,$6f,$6f,$6f
	db $2d,$2d,$6f,$6f,$6f,$23,$23,$3d,$3d,$3d,$6f,$2d
	db $6f,$6f,$23,$23,$3d,$3d,$3d,$3d,$3d,$6f,$6f,$6f
	db $23,$23,$3d,$3d,$3d,$2a,$3d,$6f,$6f,$6f,$23,$23
	db $3d,$3d,$3d,$3d,$3d,$6f,$6f,$6f,$6f,$23,$23,$3d
	db $3d,$3d,$6f,$2d,$2e,$6f,$6f
retail_cellmaska891_end
retail_cellmaska8db
	db $0a,$09,$07,$06,$2e,$6f,$6f,$2e,$2e,$2e,$2e,$2e
	db $2e,$2e,$2e,$6f,$6f,$6f,$6f,$2e,$2e,$2e,$2e,$2e
	db $6f,$6f,$6f,$23,$23,$6f,$6f,$2e,$2e,$2e,$6f,$6f
	db $6f,$23,$23,$3d,$3d,$6f,$2e,$2e,$6f,$6f,$23,$23
	db $23,$3d,$3d,$3d,$6f,$2d,$6f,$6f,$23,$23,$3d,$3d
	db $3d,$3d,$3d,$6f,$6f,$6f,$23,$23,$3d,$3d,$3d,$2a
	db $3d,$6f,$2e,$6f,$6f,$6f,$6f,$3d,$3d,$3d,$3d,$6f
	db $2e,$2e,$2e,$2d,$6f,$6f,$6f,$6f,$6f,$2d
retail_cellmaska8db_end
retail_cellmaska939
	db $0a,$0a,$07,$07,$2e,$2e,$2e,$6f,$6f,$2e,$2e,$2e
	db $2e,$2e,$2e,$2e,$6f,$6f,$23,$6f,$2e,$2e,$2e,$2e
	db $2e,$6f,$6f,$23,$23,$23,$6f,$2e,$2e,$2e,$6f,$6f
	db $23,$23,$23,$3d,$3d,$6f,$2d,$2d,$6f,$23,$23,$23
	db $3d,$3d,$3d,$3d,$6f,$2d,$2e,$6f,$23,$3d,$3d,$3d
	db $3d,$3d,$3d,$6f,$2e,$2e,$6f,$3d,$3d,$3d,$3d,$3d
	db $3d,$6f,$2e,$2e,$2e,$6f,$3d,$3d,$3d,$2a,$3d,$6f
	db $2e,$2e,$2e,$2d,$6f,$3d,$3d,$3d,$6f,$6f,$2e,$2e
	db $2e,$2d,$2d,$6f,$6f,$6f,$6f,$6f
retail_cellmaska939_end
retail_cellmaska9a1
	db $09,$0a,$06,$07,$2e,$2e,$6f,$6f,$6f,$6f,$6f,$2e
	db $2e,$6f,$6f,$6f,$6f,$6f,$6f,$6f,$6f,$2e,$6f,$6f
	db $6f,$6f,$23,$23,$23,$6f,$2e,$2e,$6f,$23,$23,$23
	db $23,$23,$6f,$2d,$2e,$6f,$23,$23,$23,$3d,$3d,$6f
	db $6f,$2e,$2e,$6f,$3d,$3d,$3d,$3d,$3d,$6f,$2e,$2e
	db $6f,$3d,$3d,$3d,$3d,$3d,$6f,$2e,$2e,$2e,$6f,$3d
	db $3d,$2a,$3d,$6f,$2e,$2e,$2e,$2d,$6f,$3d,$3d,$3d
	db $6f,$2e,$2e,$2e,$2d,$2d,$6f,$6f,$6f,$2d
retail_cellmaska9a1_end
mrdraw_end
