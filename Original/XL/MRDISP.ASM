; Retail PPU, tilemap, palette and 2D entity/OAM services.
; Names reconstructed; early display and NMI dispatch remain available.
; D=0, binary arithmetic. Local display calls require DB=mrdisp_begin>>16
; (PPU/low WRAM mirrors); palette0/1 require DB=their input palette bank,
; copytilerow requires DB=$7F. Each raw entity is 44 bytes, independent
; of the 3D actor arena. Callbacks at +8 are near routines in this bank;
; they must preserve the frame walk's DB=0 and A16/I16 contract.
; Alloc/free require A16/I16, DB=0, valid owned slots/list indices.
; Composer preserves P/DB, consumes caller-owned descriptors and writes
; a separate 544-byte OAM image. The caller owns NMI/GSU serialization,
; blanking, VRAM layout and publication of this image to the PPU.
	incpublics	mrdisp.ext
	include	mrpals.ext
mrdisp_begin
	longa
	longi
rds_tiletransfer
	asl a
rds_03dcc1
	asl a
rds_03dcc2
	asl a
rds_03dcc3
	asl a
rds_03dcc4
	asl a
rds_03dcc5
	clc
rds_03dcc6
	adc.w x2
rds_03dcc9
	sta.w $4302
rds_03dccc
	stx.w $2116
rds_03dccf
	lda #$1801
rds_03dcd2
	sta.w $4300
rds_03dcd5
	lda #$0020
rds_03dcd8
	sta.w $4305
rds_03dcdb
	a8
rds_03dcdd
	lda #$80
rds_03dcdf
	sta.w $2115
rds_03dce2
	lda #$70
rds_03dce4
	sta.w $4304
rds_03dce7
	lda #$01
rds_03dce9
	sta.w $420b
rds_03dcec
	a16
rds_03dcee
	rts
	shorta
	longi
rds_spritelayout
	lda.w retail_oamlayout&WM,y
rds_03ea01
	cmp #$ff
rds_03ea03
	beq rds_03ea2d
rds_03ea05
	cmp #$fe
rds_03ea07
	bne rds_03ea0e
rds_03ea09
	sta.w race_oam+1,x
rds_03ea0c
	bra rds_03ea26
rds_03ea0e
	sta.w race_oam+0,x
rds_03ea11
	lda.w retail_oamlayout&WM+1,y
rds_03ea14
	sta.w race_oam+1,x
rds_03ea17
	lda.w retail_oamlayout&WM+2,y
rds_03ea1a
	sta.w race_oam+2,x
rds_03ea1d
	lda.w retail_oamlayout&WM+3,y
rds_03ea20
	sta.w race_oam+3,x
rds_03ea23
	iny
rds_03ea24
	iny
rds_03ea25
	iny
rds_03ea26
	iny
rds_03ea27
	inx
rds_03ea28
	inx
rds_03ea29
	inx
rds_03ea2a
	inx
rds_03ea2b
	bra rds_spritelayout
rds_03ea2d
	rts
	shorta
	longi
rds_tilemaps
	php
rds_03ea2f
	i8
rds_03ea31
	a16
rds_03ea33
	lda #$7800
rds_03ea36
	sta.w $2116
rds_03ea39
	ldx #$80
rds_03ea3b
	stx.w $2115
rds_03ea3e
	jsr rds_topborder
rds_03ea41
	i8
rds_03ea43
	a16
rds_03ea45
	lda #$2000
rds_03ea48
	jsr rds_tilegrid
rds_03ea4b
	a16
rds_03ea4d
	lda #$7a40
rds_03ea50
	sta.w $2116
rds_03ea53
	jsr rds_toprows
rds_03ea56
	lda #$7c00
rds_03ea59
	sta.w $2116
rds_03ea5c
	jsr rds_lowerborder
rds_03ea5f
	lda #$2010
rds_03ea62
	i8
rds_03ea64
	a16
rds_03ea66
	jsr rds_tilegrid
rds_03ea69
	a16
rds_03ea6b
	lda #$7e40
rds_03ea6e
	sta.w $2116
rds_03ea71
	jsr rds_lowerrows
rds_03ea74
	plp
rds_03ea75
	rts
	longa
	shorti
rds_topborder
	pha
rds_03ea77
	ai16
rds_03ea79
	lda #$02b0
rds_03ea7c
	bra rds_03ea9c
	longa
	longi
rds_lowerborder
	pha
rds_03ea7f
	ai16
rds_03ea81
	lda #$01b0
rds_03ea84
	bra rds_03ea9c
	longa
	longi
rds_toprows
	pha
rds_03ea87
	ai16
rds_03ea89
	ldx #$0000
rds_03ea8c
	lda #$02b0
rds_03ea8f
	bra rds_03eadb
	longa
	longi
rds_lowerrows
	pha
rds_03ea92
	ai16
rds_03ea94
	ldx #$0000
rds_03ea97
	lda #$01b0
rds_03ea9a
	bra rds_03eadb
rds_03ea9c
	sta y2
rds_03ea9e
	ldx #$0020
rds_03eaa1
	lda #$2001
rds_03eaa4
	clc
rds_03eaa5
	adc y2
rds_03eaa7
	sta.w $2118
rds_03eaaa
	dex
rds_03eaab
	bne rds_03eaa1
rds_03eaad
	ldx #$0023
rds_03eab0
	lda.w race_scenephase
rds_03eab3
	and #$00ff
rds_03eab6
	cmp #$0001
rds_03eab9
	beq rds_03eac5
rds_03eabb
	cmp #$0003
rds_03eabe
	beq rds_03eac5
rds_03eac0
	lda #$2002
rds_03eac3
	bra rds_03ead0
rds_03eac5
	lda.w race_displaybrief
rds_03eac8
	and #$00ff
rds_03eacb
	bne rds_03eac0
rds_03eacd
	lda #$2010
rds_03ead0
	clc
rds_03ead1
	adc y2
rds_03ead3
	sta.w $2118
rds_03ead6
	dex
rds_03ead7
	bne rds_03eab0
rds_03ead9
	pla
rds_03eada
	rts
rds_03eadb
	sta y2
rds_03eadd
	ldx #$0000
rds_03eae0
	lda.l $703000,x
rds_03eae4
	clc
rds_03eae5
	adc y2
rds_03eae7
	sta.w $2118
rds_03eaea
	inx
rds_03eaeb
	inx
rds_03eaec
	cpx #$0180
rds_03eaef
	bcc rds_03eae0
rds_03eaf1
	pla
rds_03eaf2
	rts
	longa
	shorti
rds_tilegrid
	sta x2
rds_03eaf5
	lda #$0010
rds_03eaf8
	sta y2
rds_03eafa
	tay
rds_03eafb
	ldx #$20
rds_03eafd
	lda x2
rds_03eaff
	sta.w $2118
rds_03eb02
	clc
rds_03eb03
	adc y2
rds_03eb05
	dex
rds_03eb06
	bne rds_03eaff
rds_03eb08
	inc x2
rds_03eb0a
	dey
rds_03eb0b
	bne rds_03eafb
rds_03eb0d
	rts
	shorta
	longi
retail_displayppu_l
	php
rds_03eb0f
	a8
rds_03eb11
	i16
rds_03eb13
	lda #$03
rds_03eb15
	sta.w $2105
rds_03eb18
	stz.w $2106
rds_03eb1b
	lda #$03
rds_03eb1d
	sta.w $2101
rds_03eb20
	lda #$7a
rds_03eb22
	sta.w $2107
rds_03eb25
	lda #$5a
rds_03eb27
	sta.w $2108
rds_03eb2a
	lda #$60
rds_03eb2c
	sta.w $210b
rds_03eb2f
	stz.w $2121
rds_03eb32
	stz.w $2122
rds_03eb35
	stz.w $2122
rds_03eb38
	stz.w $212d
rds_03eb3b
	stz.w $212e
rds_03eb3e
	stz.w $212f
rds_03eb41
	stz.w $2123
rds_03eb44
	stz.w $2124
rds_03eb47
	stz.w $2125
rds_03eb4a
	stz.w $212a
rds_03eb4d
	stz.w $212b
rds_03eb50
	stz.w $2130
rds_03eb53
	stz.w $2131
rds_03eb56
	stx.w $2132
rds_03eb59
	stz.w $2133
rds_03eb5c
	stz.w $4207
rds_03eb5f
	stz.w $4208
rds_03eb62
	stz.w $4209
rds_03eb65
	stz.w $420a
rds_03eb68
	stz.w $4200
rds_03eb6b
	stz.w $420b
rds_03eb6e
	stz.w $420c
rds_03eb71
	lda #$0b
rds_03eb73
	sta.w $3038
rds_03eb76
	a16
rds_03eb78
	lda #$2c00
rds_03eb7b
	sta.l messagepallet
rds_03eb7f
	sta drawmap
rds_03eb81
	plp
rds_03eb82
	rtl
	longa
	longi
retail_displayclear_l
	php
rds_03ec6e
	ai8
rds_03ec70
	sei
rds_03ec71
	stz.w $4200
rds_03ec74
	stz trans_flag
rds_03ec76
	lda.w race_displayack
rds_03ec79
	a16
rds_03ec7b
	lda.l $003030
rds_03ec7f
	lda #$0003
rds_03ec82
	sta.w race_oamflags
rds_03ec85
	ldx #$80
rds_03ec87
	stx.w $2115
rds_03ec8a
	lda #$0000
rds_03ec8d
	sta.w $2116
rds_03ec90
	lda #retail_displaycleardma&WM
rds_03ec93
	jsr rds_dma
rds_03ec96
	lda #$7c00
rds_03ec99
	sta.w $2116
rds_03ec9c
	lda #(retail_displaycleardma+7)&WM
rds_03ec9f
	jsr rds_dma
rds_03eca2
	plp
rds_03eca3
	rtl
	longa
	longi
retail_displaydma_l
	jsr rds_dma
rds_03eca7
	rtl
rds_dma
	php
rds_03eca9
	sta tempaddrl
rds_03ecab
	ai8
rds_03ecad
	ldy #$06
rds_03ecaf
	lda (tempaddrl),y
rds_03ecb1
	sta.w $4300,y
rds_03ecb4
	dey
rds_03ecb5
	bpl rds_03ecaf
rds_03ecb7
	lda #$01
rds_03ecb9
	sta.w $420b
rds_03ecbc
	plp
rds_03ecbd
	rts
	longa
	longi
rds_clearvram
	ldy #$0080
rds_03ecc1
	sty.w $2115
rds_03ecc4
	sta.w $2116
rds_03ecc7
	lda #$0000
rds_03ecca
	sta.w $2118
rds_03eccd
	dex
rds_03ecce
	bne rds_03ecca
rds_03ecd0
	rts
	shorta
	longi
retail_clearoam_l
	php
rds_03ecd2
	ai16
rds_03ecd4
	lda #$f0f0
rds_03ecd7
	ldx #$01fc
rds_03ecda
	sta.l race_oam+0,x
rds_03ecde
	dex
rds_03ecdf
	dex
rds_03ece0
	dex
rds_03ece1
	dex
rds_03ece2
	bpl rds_03ecda
rds_03ece4
	lda #$0000
rds_03ece7
	ldx #$001e
rds_03ecea
	sta.l race_oam+512,x
rds_03ecee
	dex
rds_03ecef
	dex
rds_03ecf0
	bpl rds_03ecea
rds_03ecf2
	plp
rds_03ecf3
	rtl
	shorta
	longi
rds_ramppalette_swap
	xba
rds_ramppalettes
	a8
rds_03ecf7
	lda.l retail_displayramp0+2,x
rds_03ecfb
	phb
rds_03ecfc
	pha
rds_03ecfd
	plb
rds_03ecfe
	ai16
rds_03ed00
	lda.l retail_displayramp0,x
rds_03ed04
	tay
rds_03ed05
	phx
rds_03ed06
	lda #$0000
rds_03ed09
	sta y2
rds_03ed0b
	jsr rds_ramp0
rds_03ed0e
	plx
rds_03ed0f
	a16
rds_03ed11
	lda.l retail_displayramp1,x
rds_03ed15
	beq rds_03ed20
rds_03ed17
	tay
rds_03ed18
	lda #$0400
rds_03ed1b
	sta y2
rds_03ed1d
	jsr rds_ramp1
rds_03ed20
	a16
rds_03ed22
	ldx #$00fe
rds_03ed25
	lda #$0000
rds_03ed28
	sta.l race_palramps+2048,x
rds_03ed2c
	dex
rds_03ed2d
	dex
rds_03ed2e
	bpl rds_03ed28
rds_03ed30
	a8
rds_03ed32
	plb
rds_03ed33
	rts
	longa
	longi
rds_ramp0
	a16
rds_03ed36
	lda.w race_mapmode
rds_03ed39
	and #$00ff
rds_03ed3c
	cmp #$000a
rds_03ed3f
	bne rds_03ed58
rds_03ed41
	ldx #$0028
rds_03ed44
	bra rds_03ed5b
	longa
	longi
rds_ramp1
	a16
rds_03ed48
	lda.w race_mapmode
rds_03ed4b
	and #$00ff
rds_03ed4e
	cmp #$0001
rds_03ed51
	bne rds_03ed58
rds_03ed53
	ldx #$0050
rds_03ed56
	bra rds_03ed5b
rds_03ed58
	ldx #$0000
rds_03ed5b
	lda.l retail_palramplengths,x
rds_03ed5f
	and #$00ff
rds_03ed62
	beq rds_03ed7e
rds_03ed64
	sta x2
rds_03ed66
	lda.w $0020,y
rds_03ed69
	phx
rds_03ed6a
	ldx y2
rds_03ed6c
	sta.l race_palramps,x
rds_03ed70
	inx
rds_03ed71
	inx
rds_03ed72
	dec x2
rds_03ed74
	bne rds_03ed6c
rds_03ed76
	stx y2
rds_03ed78
	plx
rds_03ed79
	inx
rds_03ed7a
	iny
rds_03ed7b
	iny
rds_03ed7c
	bra rds_03ed5b
rds_03ed7e
	rts
	longa
	longi
rds_fillpalette
	sta.l race_palfill,x
rds_03ed83
	inx
rds_03ed84
	inx
rds_03ed85
	dey
rds_03ed86
	bne rds_fillpalette
rds_03ed88
	rts
	longa
	longi
rds_copytilerow
	clc
rds_03ed8a
	adc x2
rds_03ed8c
	tax
rds_03ed8d
	lda #$0020
rds_03ed90
	sta y2
rds_03ed92
	lda.l $703000,x
rds_03ed96
	ora #$2000
rds_03ed99
	sta.w race_tilecopy&WM,y
rds_03ed9c
	inx
rds_03ed9d
	inx
rds_03ed9e
	iny
rds_03ed9f
	iny
rds_03eda0
	dec y2
rds_03eda2
	bne rds_03ed92
rds_03eda4
	rts
	longa
	longi
rds_palette0
	tay
rds_03eda6
	ldx #$0000
rds_03eda9
	lda #$0010
rds_03edac
	sta x2
rds_03edae
	lda.w $0000,y
rds_03edb1
	sta.l race_palbase,x
rds_03edb5
	sta.l race_palsource,x
rds_03edb9
	sta.l race_palshadow,x
rds_03edbd
	inx
rds_03edbe
	inx
rds_03edbf
	iny
rds_03edc0
	iny
rds_03edc1
	dec x2
rds_03edc3
	bne rds_03edae
rds_03edc5
	rts
	longa
	longi
rds_palette1
	tay
rds_03edc7
	ldx #$0000
rds_03edca
	lda #$0010
rds_03edcd
	sta x2
rds_03edcf
	lda.w $0000,y
rds_03edd2
	sta.l race_paltarget,x
rds_03edd6
	inx
rds_03edd7
	inx
rds_03edd8
	iny
rds_03edd9
	iny
rds_03edda
	dec x2
rds_03eddc
	bne rds_03edcf
rds_03edde
	rts
	longa
	longi
rds_scenepalettes
	ai16
rds_03edf6
	lda.w race_mapmode
rds_03edf9
	asl a
rds_03edfa
	clc
rds_03edfb
	adc.w race_mapmode
rds_03edfe
	and #$00ff
rds_03ee01
	tax
rds_03ee02
	phx
rds_03ee03
	a8
rds_03ee05
	lda.l retail_displaypal0+2,x
rds_03ee09
	phb
rds_03ee0a
	pha
rds_03ee0b
	a16
rds_03ee0d
	lda.l retail_displaypal0,x
rds_03ee11
	plb
rds_03ee12
	tay
rds_03ee13
	ldx #$0020
rds_03ee16
	lda.w $0020,y
rds_03ee19
	sta.l race_palbase,x
rds_03ee1d
	sta.l race_palsource,x
rds_03ee21
	sta.l race_palshadow,x
rds_03ee25
	inx
rds_03ee26
	inx
rds_03ee27
	iny
rds_03ee28
	iny
rds_03ee29
	cpx #$0200
rds_03ee2c
	bcc rds_03ee16
rds_03ee2e
	a8
rds_03ee30
	plb
rds_03ee31
	plx
rds_03ee32
	phx
rds_03ee33
	lda.l retail_displaypal1+2,x
rds_03ee37
	phb
rds_03ee38
	pha
rds_03ee39
	plb
rds_03ee3a
	a16
rds_03ee3c
	lda.l retail_displaypal1,x
rds_03ee40
	tay
rds_03ee41
	ldx #$0020
rds_03ee44
	lda.w $0020,y
rds_03ee47
	sta.l race_paltarget,x
rds_03ee4b
	inx
rds_03ee4c
	inx
rds_03ee4d
	iny
rds_03ee4e
	iny
rds_03ee4f
	cpx #$0200
rds_03ee52
	bcc rds_03ee44
rds_03ee54
	a8
rds_03ee56
	plb
rds_03ee57
	a8
rds_03ee59
	plx
rds_03ee5a
	phx
rds_03ee5b
	lda.l retail_displayramp0+2,x
rds_03ee5f
	phb
rds_03ee60
	pha
rds_03ee61
	plb
rds_03ee62
	a16
rds_03ee64
	lda.l retail_displayramp0,x
rds_03ee68
	jsr rds_palette0
rds_03ee6b
	a8
rds_03ee6d
	plb
rds_03ee6e
	plx
rds_03ee6f
	lda.l retail_displayramp1+2,x
rds_03ee73
	phb
rds_03ee74
	pha
rds_03ee75
	plb
rds_03ee76
	a16
rds_03ee78
	lda.l retail_displayramp1,x
rds_03ee7c
	jsr rds_palette1
rds_03ee7f
	plb
rds_03ee80
	a16
rds_03ee82
	ldx #$01fe
rds_03ee85
	txa
rds_03ee86
	lsr a
rds_03ee87
	lsr a
rds_03ee88
	lsr a
rds_03ee89
	lsr a
rds_03ee8a
	and #$001e
rds_03ee8d
	tay
rds_03ee8e
	txa
rds_03ee8f
	lsr a
rds_03ee90
	and #$000f
rds_03ee93
	sta x2
rds_03ee95
	cmp #$0000
rds_03ee98
	bne rds_03ee9f
rds_03ee9a
	lda.w retail_palchangedmask&WM,y
rds_03ee9d
	bra rds_03eea7
rds_03ee9f
	lda.w retail_palchangedmask&WM,y
rds_03eea2
	lsr a
rds_03eea3
	dec x2
rds_03eea5
	bne rds_03eea2
rds_03eea7
	bit #$0001
rds_03eeaa
	bne rds_03eec4
rds_03eeac
	lda.l race_palsource,x
rds_03eeb0
	cmp.l race_paltarget,x
rds_03eeb4
	bne rds_03eed2
rds_03eeb6
	pha
rds_03eeb7
	and #$001f
rds_03eeba
	beq rds_03eec0
rds_03eebc
	pla
rds_03eebd
	dec a
rds_03eebe
	bra rds_03eece
rds_03eec0
	pla
rds_03eec1
	inc a
rds_03eec2
	bra rds_03eece
rds_03eec4
	lda.l race_palsource,x
rds_03eec8
	cmp.l race_paltarget,x
rds_03eecc
	beq rds_03eed2
rds_03eece
	sta.l race_paltarget,x
rds_03eed2
	dex
rds_03eed3
	dex
rds_03eed4
	bpl rds_03ee85
rds_03eed6
	lda #$45cc
rds_03eed9
	sta.w race_displaycolors
rds_03eedc
	lda #$2528
rds_03eedf
	sta.w race_displaycolors+2
rds_03eee2
	lda #$1ce5
rds_03eee5
	sta.w race_displaycolors+4
rds_03eee8
	lda #$739a
rds_03eeeb
	sta.w race_displaycolors+6
rds_03eeee
	lda #$1ce5
rds_03eef1
	sta.w race_displaycolors+8
rds_03eef4
	lda #$2528
rds_03eef7
	sta.w race_displaycolors+10
rds_03eefa
	lda.w race_paletteblocks
rds_03eefd
	beq rds_03ef1e
rds_03eeff
	a8
rds_03ef01
	i16
rds_03ef03
	lda #$00
rds_03ef05
	ldx #$0000
rds_03ef08
	sta.l race_palshadow+352,x
rds_03ef0c
	sta.l race_palsource+352,x
rds_03ef10
	sta.l race_paltarget+352,x
rds_03ef14
	sta.l race_palbase+352,x
rds_03ef18
	inx
rds_03ef19
	cpx #$0020
rds_03ef1c
	bne rds_03ef08
rds_03ef1e
	rts
	shorta
	longi
rds_displaycost
	ai8
rds_03ef41
	lda #$99
rds_03ef43
	sta.w race_displaytimers
rds_03ef46
	sta.w race_displaytimers+1
rds_03ef49
	sta.w race_displaytimers+2
rds_03ef4c
	sta.w race_displaytimers+3
rds_03ef4f
	lda.w race_scenephase
rds_03ef52
	beq rds_03ef70
rds_03ef54
	cmp #$02
rds_03ef56
	bcs rds_03ef8a
rds_03ef58
	lda.w race_displayrace
rds_03ef5b
	bne rds_03ef8a
rds_03ef5d
	lda.w race_mapmode
rds_03ef60
	sec
rds_03ef61
	sbc #$0c
rds_03ef63
	asl a
rds_03ef64
	asl a
rds_03ef65
	clc
rds_03ef66
	adc.w racesound_kind0
rds_03ef69
	tax
rds_03ef6a
	lda.l retail_displayprices+147,x
rds_03ef6e
	bra rds_03ef8c
rds_03ef70
	lda.w race_displayoverride
rds_03ef73
	bne rds_03ef81
rds_03ef75
	lda.w racesound_kind0
rds_03ef78
	jsr rds_costindex
rds_03ef7b
	lda.l retail_displayprices+3,x
rds_03ef7f
	bra rds_03ef8c
rds_03ef81
	ldx.w race_displaychoice
rds_03ef84
	lda.l retail_displayprices,x
rds_03ef88
	bra rds_03ef8c
rds_03ef8a
	lda #$00
rds_03ef8c
	sta.w race_displaycost
rds_03ef8f
	stz.w race_displaycost+1
rds_03ef92
	rts
	shorta
	shorti
retail_displaycost0_l
	lda.w racesound_kind0
rds_03ef96
	jsr rds_costindex
rds_03ef99
	lda.l retail_displayprices+4,x
rds_03ef9d
	bra rds_03efa9
	shorta
	shorti
retail_displaycost1_l
	lda.w racesound_kind0
rds_03efa2
	jsr rds_costindex
rds_03efa5
	lda.l retail_displayprices+5,x
rds_03efa9
	a16
rds_03efab
	sed
rds_03efac
	and #$00ff
rds_03efaf
	clc
rds_03efb0
	adc.w race_displaycost
rds_03efb3
	sta.w race_displaycost
rds_03efb6
	cld
rds_03efb7
	a8
rds_03efb9
	rtl
	shorta
	longi
rds_03efba
	rts
	shorta
	shorti
rds_costindex
	sta x2
rds_03efbd
	asl a
rds_03efbe
	clc
rds_03efbf
	adc x2
rds_03efc1
	sta x2
rds_03efc3
	lda.w race_mapmode
rds_03efc6
	asl a
rds_03efc7
	clc
rds_03efc8
	adc.w race_mapmode
rds_03efcb
	asl a
rds_03efcc
	asl a
rds_03efcd
	clc
rds_03efce
	adc x2
rds_03efd0
	tax
rds_03efd1
	rts
	shorta
	longi
retail_entityframe_l
	php
rds_0bb451
	phb
rds_0bb452
	a8
rds_0bb454
	i16
rds_0bb456
	lda #$00
rds_0bb458
	pha
rds_0bb459
	plb
rds_0bb45a
	a16
rds_0bb45c
	ldy.w race_entitybytes
rds_0bb45f
	dey
rds_0bb460
	dey
rds_0bb461
	bmi rds_0bb476
rds_0bb463
	sty.w race_entityindex
rds_0bb466
	ldx.w race_entitylist,y
rds_0bb469
	stx.w race_entitycurrent
rds_0bb46c
	jsr ($0008,x)
rds_0bb46f
	ldy.w race_entityindex
rds_0bb472
	dey
rds_0bb473
	dey
rds_0bb474
	bpl rds_0bb463
rds_0bb476
	plb
rds_0bb477
	plp
rds_0bb478
	rtl
	shorta
	longi
retail_initentities_l
	php
rds_0bb47a
	ai16
rds_0bb47c
	ldy #$0000
rds_0bb47f
	ldx #race_entities
rds_0bb482
	txa
rds_0bb483
	sta.w race_entityfree,y
rds_0bb486
	lda #retail_entityidle&WM
rds_0bb489
	sta $08,x
rds_0bb48b
	lda #$ffff
rds_0bb48e
	sta $10,x
rds_0bb490
	iny
rds_0bb491
	iny
rds_0bb492
	txa
rds_0bb493
	clc
rds_0bb494
	adc #$002c
rds_0bb497
	tax
rds_0bb498
	cmp #race_entities+968
rds_0bb49b
	bne rds_0bb482
rds_0bb49d
	lda #$0000
rds_0bb4a0
	sta.w race_entityfreebytes
rds_0bb4a3
	sta.w race_entitybytes
rds_0bb4a6
	lda #$0200
rds_0bb4a9
	sta.w race_oamoldbytes
rds_0bb4ac
	lda #$0020
rds_0bb4af
	sta.w race_oamoldhigh
rds_0bb4b2
	lda #$2881
rds_0bb4b5
	sta.w race_entityflags
rds_0bb4b8
	a8
rds_0bb4ba
	lda #$02
rds_0bb4bc
	sta.w $2101
rds_0bb4bf
	a16
rds_0bb4c1
	plp
rds_0bb4c2
	rtl
	longa
	longi
rds_allocentity
	ldx.w race_entityfreebytes
rds_0bb4c6
	cpx #$002c
rds_0bb4c9
	beq rds_0bb4e1
rds_0bb4cb
	lda.w race_entityfree,x
rds_0bb4ce
	inx
rds_0bb4cf
	inx
rds_0bb4d0
	stx.w race_entityfreebytes
rds_0bb4d3
	ldx.w race_entitybytes
rds_0bb4d6
	sta.w race_entitylist,x
rds_0bb4d9
	inc.w race_entitybytes
rds_0bb4dc
	inc.w race_entitybytes
rds_0bb4df
	tax
rds_0bb4e0
	rts
rds_0bb4e1
	ldx #$ffff
rds_0bb4e4
	rts
	longa
	longi
rds_freeentity
	txa
rds_0bb4e6
	ldx.w race_entityfreebytes
rds_0bb4e9
	dex
rds_0bb4ea
	dex
rds_0bb4eb
	stx.w race_entityfreebytes
rds_0bb4ee
	sta.w race_entityfree,x
rds_0bb4f1
	ldx.w race_entitybytes
rds_0bb4f4
	dex
rds_0bb4f5
	dex
rds_0bb4f6
	stx.w race_entitybytes
rds_0bb4f9
	lda.w race_entitylist,x
rds_0bb4fc
	sta.w race_entitylist,y
rds_0bb4ff
	ldx #$ffff
rds_0bb502
	stx.w race_entitycurrent
rds_0bb505
	rts
	shorta
	longi
retail_composeoam_l
	php
rds_0bb64b
	a8
rds_0bb64d
	phb
rds_0bb64e
	lda #$00
rds_0bb650
	pha
rds_0bb651
	plb
rds_0bb652
	ai16
rds_0bb654
	stz.w race_oambytes
rds_0bb657
	stz.w race_oamhigh
rds_0bb65a
	lda #$0007
rds_0bb65d
	sta.w race_oambits
rds_0bb660
	stz.w race_oamword
rds_0bb663
	ldy.w race_entitybytes
rds_0bb666
	dey
rds_0bb667
	dey
rds_0bb668
	bpl rds_0bb66d
rds_0bb66a
	brl rds_0bb7bf
rds_0bb66d
	sty.w race_entityindex
rds_0bb670
	ldx.w race_entitylist,y
rds_0bb673
	lda $10,x
rds_0bb675
	inc a
rds_0bb676
	bne rds_0bb67b
rds_0bb678
	brl rds_0bb7b5
rds_0bb67b
	lda $12,x
rds_0bb67d
	beq rds_0bb68a
rds_0bb67f
	cmp #$ffff
rds_0bb682
	bne rds_0bb687
rds_0bb684
	brl rds_0bb7b5
rds_0bb687
	jmp rds_0bb70e
rds_0bb68a
	stz.w race_spritexbit
rds_0bb68d
	lda $0c,x
rds_0bb68f
	sta.w race_spritesize
rds_0bb692
	ldy.w race_oambytes
rds_0bb695
	cpy #$0200
rds_0bb698
	bne rds_0bb69d
rds_0bb69a
	brl rds_0bb7b5
rds_0bb69d
	lda $02,x
rds_0bb69f
	sec
rds_0bb6a0
	sbc.w race_entityscrollx
rds_0bb6a3
	bpl rds_0bb6b2
rds_0bb6a5
	cmp #$fff0
rds_0bb6a8
	bcs rds_0bb6ad
rds_0bb6aa
	brl rds_0bb7b5
rds_0bb6ad
	inc.w race_spritexbit
rds_0bb6b0
	bra rds_0bb6ba
rds_0bb6b2
	cmp #$0100
rds_0bb6b5
	bcc rds_0bb6ba
rds_0bb6b7
	brl rds_0bb7b5
rds_0bb6ba
	sta.w race_oam+0,y
rds_0bb6bd
	lda $06,x
rds_0bb6bf
	sec
rds_0bb6c0
	sbc.w race_entityscrolly
rds_0bb6c3
	bpl rds_0bb6cd
rds_0bb6c5
	cmp #$fff0
rds_0bb6c8
	bcs rds_0bb6d5
rds_0bb6ca
	jmp rds_0bb7b5
rds_0bb6cd
	cmp #$00e0
rds_0bb6d0
	bcc rds_0bb6d5
rds_0bb6d2
	brl rds_0bb7b5
rds_0bb6d5
	sta.w race_oam+1,y
rds_0bb6d8
	lda $0e,x
rds_0bb6da
	ora $10,x
rds_0bb6dc
	sta.w race_oam+2,y
rds_0bb6df
	iny
rds_0bb6e0
	iny
rds_0bb6e1
	iny
rds_0bb6e2
	iny
rds_0bb6e3
	sty.w race_oambytes
rds_0bb6e6
	ror.w race_spritexbit
rds_0bb6e9
	ror.w race_oamword
rds_0bb6ec
	ror.w race_spritesize
rds_0bb6ef
	ror.w race_oamword
rds_0bb6f2
	dec.w race_oambits
rds_0bb6f5
	bpl rds_0bb70b
rds_0bb6f7
	lda #$0007
rds_0bb6fa
	sta.w race_oambits
rds_0bb6fd
	ldy.w race_oamhigh
rds_0bb700
	lda.w race_oamword
rds_0bb703
	sta.w race_oam+512,y
rds_0bb706
	iny
rds_0bb707
	iny
rds_0bb708
	sty.w race_oamhigh
rds_0bb70b
	jmp rds_0bb7b5
rds_0bb70e
	sta.w race_spritesleft
rds_0bb711
	lda $02,x
rds_0bb713
	sec
rds_0bb714
	sbc.w race_entityscrollx
rds_0bb717
	sta.w race_entityx
rds_0bb71a
	lda $06,x
rds_0bb71c
	sec
rds_0bb71d
	sbc.w race_entityscrolly
rds_0bb720
	sta.w race_entityy
rds_0bb723
	ldx.w race_spritesleft
rds_0bb726
	lda.l race_spritelists,x
rds_0bb72a
	sta.w race_spritesleft
rds_0bb72d
	inx
rds_0bb72e
	inx
rds_0bb72f
	stz.w race_spritexbit
rds_0bb732
	ldy.w race_oambytes
rds_0bb735
	cpy #$0200
rds_0bb738
	bne rds_0bb73d
rds_0bb73a
	brl rds_0bb7b5
rds_0bb73d
	lda.l race_spritelists,x
rds_0bb741
	clc
rds_0bb742
	adc.w race_entityx
rds_0bb745
	bpl rds_0bb751
rds_0bb747
	cmp #$fff0
rds_0bb74a
	bcc rds_0bb7a7
rds_0bb74c
	inc.w race_spritexbit
rds_0bb74f
	bra rds_0bb756
rds_0bb751
	cmp #$0100
rds_0bb754
	bcs rds_0bb7a7
rds_0bb756
	sta.w race_oam+0,y
rds_0bb759
	lda.l race_spritelists+2,x
rds_0bb75d
	clc
rds_0bb75e
	adc.w race_entityy
rds_0bb761
	bpl rds_0bb76a
rds_0bb763
	cmp #$fff0
rds_0bb766
	bcs rds_0bb76f
rds_0bb768
	bra rds_0bb7a7
rds_0bb76a
	cmp #$00e0
rds_0bb76d
	bcs rds_0bb7a7
rds_0bb76f
	sta.w race_oam+1,y
rds_0bb772
	iny
rds_0bb773
	iny
rds_0bb774
	lda.l race_spritelists+4,x
rds_0bb778
	sta.w race_oam+0,y
rds_0bb77b
	iny
rds_0bb77c
	iny
rds_0bb77d
	sty.w race_oambytes
rds_0bb780
	lsr.w race_spritexbit
rds_0bb783
	ror.w race_oamword
rds_0bb786
	lda.l race_spritelists+6,x
rds_0bb78a
	lsr a
rds_0bb78b
	ror.w race_oamword
rds_0bb78e
	dec.w race_oambits
rds_0bb791
	bpl rds_0bb7a7
rds_0bb793
	ldy.w race_oamhigh
rds_0bb796
	lda.w race_oamword
rds_0bb799
	sta.w race_oam+512,y
rds_0bb79c
	iny
rds_0bb79d
	iny
rds_0bb79e
	sty.w race_oamhigh
rds_0bb7a1
	lda #$0007
rds_0bb7a4
	sta.w race_oambits
rds_0bb7a7
	txa
rds_0bb7a8
	clc
rds_0bb7a9
	adc #$0008
rds_0bb7ac
	tax
rds_0bb7ad
	dec.w race_spritesleft
rds_0bb7b0
	bmi rds_0bb7b5
rds_0bb7b2
	brl rds_0bb72f
rds_0bb7b5
	ldy.w race_entityindex
rds_0bb7b8
	dey
rds_0bb7b9
	dey
rds_0bb7ba
	bmi rds_0bb7bf
rds_0bb7bc
	brl rds_0bb66d
rds_0bb7bf
	ldy.w race_oambits
rds_0bb7c2
	cpy #$0007
rds_0bb7c5
	beq rds_0bb7db
rds_0bb7c7
	lda.w race_oamword
rds_0bb7ca
	sec
rds_0bb7cb
	ror a
rds_0bb7cc
	lsr a
rds_0bb7cd
	dey
rds_0bb7ce
	bpl rds_0bb7ca
rds_0bb7d0
	ldy.w race_oamhigh
rds_0bb7d3
	sta.w race_oam+512,y
rds_0bb7d6
	iny
rds_0bb7d7
	iny
rds_0bb7d8
	sty.w race_oamhigh
rds_0bb7db
	ldy.w race_oambytes
rds_0bb7de
	cpy.w race_oamoldbytes
rds_0bb7e1
	bcs rds_0bb7f0
rds_0bb7e3
	lda #$efef
rds_0bb7e6
	sta.w race_oam+0,y
rds_0bb7e9
	iny
rds_0bb7ea
	iny
rds_0bb7eb
	cpy.w race_oamoldbytes
rds_0bb7ee
	bcc rds_0bb7e6
rds_0bb7f0
	lda.w race_oambytes
rds_0bb7f3
	sta.w race_oamoldbytes
rds_0bb7f6
	ldy.w race_oamhigh
rds_0bb7f9
	cpy.w race_oamoldhigh
rds_0bb7fc
	bcs rds_0bb80b
rds_0bb7fe
	lda #$5555
rds_0bb801
	sta.w race_oam+512,y
rds_0bb804
	iny
rds_0bb805
	iny
rds_0bb806
	cpy.w race_oamoldhigh
rds_0bb809
	bcc rds_0bb801
rds_0bb80b
	lda.w race_oamhigh
rds_0bb80e
	sta.w race_oamoldhigh
rds_0bb811
	plb
rds_0bb812
	plp
rds_0bb813
	rtl
	longa
	longi
retail_entityidle
	rts
retail_tiletransfer_l
	jsr rds_tiletransfer
	rtl
retail_spritelayout_l
	jsr rds_spritelayout
	rtl
retail_tilemaps_l
	jsr rds_tilemaps
	rtl
retail_clearvram_l
	jsr rds_clearvram
	rtl
retail_ramppalettes_l
	jsr rds_ramppalettes
	rtl
retail_scenepalettes_l
	jsr rds_scenepalettes
	rtl
retail_palramp0_l
	jsr rds_ramp0
	rtl
retail_palramp1_l
	jsr rds_ramp1
	rtl
retail_fillpalette_l
	jsr rds_fillpalette
	rtl
retail_copytilerow_l
	jsr rds_copytilerow
	rtl
retail_palette0_l
	jsr rds_palette0
	rtl
retail_palette1_l
	jsr rds_palette1
	rtl
retail_displaycost_l
	jsr rds_displaycost
	rtl
retail_allocentity_l
	jsr rds_allocentity
	rtl
retail_freeentity_l
	jsr rds_freeentity
	rtl
retail_displayprices
	db $50,$50,$50,$40,$30,$30,$40,$30,$30,$50,$30,$30,$40,$30,$30,$40
	db $30,$30,$40,$30,$30,$50,$30,$30,$40,$30,$20,$40,$30,$30,$40,$30
	db $30,$50,$30,$30,$40,$30,$30,$50,$40,$40,$50,$40,$40,$60,$40,$40
	db $50,$40,$40,$50,$30,$30,$50,$30,$30,$60,$30,$30,$50,$30,$30,$40
	db $20,$20,$40,$20,$20,$30,$30,$30,$40,$20,$20,$40,$30,$30,$40,$30
	db $30,$40,$30,$30,$40,$30,$30,$40,$30,$30,$40,$30,$30,$50,$30,$30
	db $40,$30,$30,$40,$30,$30,$40,$30,$30,$40,$35,$35,$40,$30,$30,$60
	db $40,$40,$60,$40,$40,$60,$40,$40,$60,$40,$40,$50,$40,$40,$50,$40
	db $40,$50,$50,$50,$50,$40,$40,$50,$40,$40,$50,$40,$40,$50,$40,$40
	db $50,$40,$40,$40,$40,$40,$40,$60,$60,$50,$60,$60,$60,$50,$60,$60
	db $60,$50,$60
retail_palchangedmask
	dw $0000,$000e,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$ffff,$0000,$0000,$800f,$0000
retail_displaypal0
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal9e00&WM
	db retail_pal9e00>>16
	dw retail_pal8c00&WM
	db retail_pal8c00>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal9c00&WM
	db retail_pal9c00>>16
	dw retail_pal9200&WM
	db retail_pal9200>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal9600&WM
	db retail_pal9600>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8a00&WM
	db retail_pal8a00>>16
	dw retail_pala000&WM
	db retail_pala000>>16
	dw retail_pala600&WM
	db retail_pala600>>16
	dw retail_pala400&WM
	db retail_pala400>>16
	dw retail_pala200&WM
	db retail_pala200>>16
	dw retail_pala800&WM
	db retail_pala800>>16
	dw retail_pala800&WM
	db retail_pala800>>16
	dw retail_pala800&WM
	db retail_pala800>>16
	dw retail_pala800&WM
	db retail_pala800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pala200&WM
	db retail_pala200>>16
	dw retail_pala000&WM
	db retail_pala000>>16
	dw retail_pala400&WM
	db retail_pala400>>16
	dw retail_pala600&WM
	db retail_pala600>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
retail_displaypal1
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal9000&WM
	db retail_pal9000>>16
	dw retail_pal8e00&WM
	db retail_pal8e00>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal9c00&WM
	db retail_pal9c00>>16
	dw retail_pal8c00&WM
	db retail_pal8c00>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal9800&WM
	db retail_pal9800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal9400&WM
	db retail_pal9400>>16
	dw retail_pala000&WM
	db retail_pala000>>16
	dw retail_pala600&WM
	db retail_pala600>>16
	dw retail_pala400&WM
	db retail_pala400>>16
	dw retail_pala200&WM
	db retail_pala200>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
	dw retail_pala200&WM
	db retail_pala200>>16
	dw retail_pala000&WM
	db retail_pala000>>16
	dw retail_pala400&WM
	db retail_pala400>>16
	dw retail_pala600&WM
	db retail_pala600>>16
	dw retail_pal8800&WM
	db retail_pal8800>>16
retail_displayramp0
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palabb8&WM
	db retail_palabb8>>16
	dw retail_palab4a&WM
	db retail_palab4a>>16
	dw retail_palaf96&WM
	db retail_palaf96>>16
	dw retail_paladde&WM
	db retail_paladde>>16
	dw retail_palabb8&WM
	db retail_palabb8>>16
	dw retail_palac26&WM
	db retail_palac26>>16
	dw retail_palb004&WM
	db retail_palb004>>16
	dw retail_palaf28&WM
	db retail_palaf28>>16
	dw retail_palb14e&WM
	db retail_palb14e>>16
	dw retail_palaeba&WM
	db retail_palaeba>>16
	dw retail_palad02&WM
	db retail_palad02>>16
	dw retail_palb22a&WM
	db retail_palb22a>>16
	dw retail_palb374&WM
	db retail_palb374>>16
	dw retail_palb306&WM
	db retail_palb306>>16
	dw retail_palb298&WM
	db retail_palb298>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palab4a&WM
	db retail_palab4a>>16
	dw retail_palabb8&WM
	db retail_palabb8>>16
	dw retail_palad02&WM
	db retail_palad02>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palb298&WM
	db retail_palb298>>16
	dw retail_palb22a&WM
	db retail_palb22a>>16
	dw retail_palb306&WM
	db retail_palb306>>16
	dw retail_palb374&WM
	db retail_palb374>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
retail_displayramp1
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palb0e0&WM
	db retail_palb0e0>>16
	dw retail_palaadc&WM
	db retail_palaadc>>16
	dw retail_palaf96&WM
	db retail_palaf96>>16
	dw retail_palae4c&WM
	db retail_palae4c>>16
	dw retail_palabb8&WM
	db retail_palabb8>>16
	dw retail_palac94&WM
	db retail_palac94>>16
	dw retail_palb072&WM
	db retail_palb072>>16
	dw retail_palaf28&WM
	db retail_palaf28>>16
	dw retail_palb1bc&WM
	db retail_palb1bc>>16
	dw retail_palaeba&WM
	db retail_palaeba>>16
	dw retail_palad70&WM
	db retail_palad70>>16
	dw retail_palb22a&WM
	db retail_palb22a>>16
	dw retail_palb374&WM
	db retail_palb374>>16
	dw retail_palb306&WM
	db retail_palb306>>16
	dw retail_palb298&WM
	db retail_palb298>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
	dw retail_palb298&WM
	db retail_palb298>>16
	dw retail_palb22a&WM
	db retail_palb22a>>16
	dw retail_palb306&WM
	db retail_palb306>>16
	dw retail_palb374&WM
	db retail_palb374>>16
	dw retail_palaa00&WM
	db retail_palaa00>>16
retail_displaycleardma
	db $09,$18
	dw (retail_displaycleardma+14)&WM
	db retail_displaycleardma>>16
	dw $c000
	db $09,$18
	dw (retail_displaycleardma+14)&WM
	db retail_displaycleardma>>16
	dw $0800
	db 0,0
retail_oamlayout
	db $00,$18,$40,$36,$00,$28,$44,$36,$00,$38,$44,$36,$00,$48,$44,$36
	db $00,$58,$44,$36,$00,$68,$44,$36,$00,$78,$44,$36,$00,$88,$44,$36
	db $00,$98,$40,$b6,$10,$18,$42,$36,$10,$28,$46,$36,$10,$38,$46,$36
	db $10,$48,$46,$36,$10,$58,$46,$36,$10,$68,$46,$36,$10,$78,$46,$36
	db $10,$88,$46,$36,$10,$98,$42,$b6,$e0,$18,$42,$76,$e0,$28,$46,$76
	db $e0,$38,$46,$76,$e0,$48,$46,$76,$e0,$58,$46,$76,$e0,$68,$46,$76
	db $e0,$78,$46,$76,$e0,$88,$46,$76,$e0,$98,$42,$f6,$f0,$18,$40,$76
	db $f0,$28,$44,$76,$f0,$38,$44,$76,$f0,$48,$44,$76,$f0,$58,$44,$76
	db $f0,$68,$44,$76,$f0,$78,$44,$76,$f0,$88,$44,$76,$f0,$98,$40,$f6
	db $00,$00,$a0,$36,$00,$00,$a0,$36,$00,$00,$a0,$36,$00,$20,$a4,$36
	db $00,$20,$a5,$36,$00,$20,$a5,$36,$00,$20,$a6,$36,$00,$30,$a8,$36
	db $00,$30,$a9,$36,$00,$30,$a9,$36,$00,$30,$aa,$36,$fe,$67,$32,$24
	db $06,$77,$32,$27,$06,$84,$32,$24,$06,$8c,$32,$25,$06,$87,$7c,$19
	db $0c,$a1,$7c,$19,$4c,$58,$78,$29,$06,$60,$78,$2a,$06,$90,$78,$2c
	db $0c,$28,$bf,$16,$36,$30,$bf,$17,$36,$38,$bf,$18,$36,$fe,$fe,$fe
	db $fe,$50,$b8,$22,$36,$50,$b8,$22,$36,$60,$b8,$22,$36,$68,$b8,$22
	db $36,$68,$b8,$22,$36,$10,$b8,$00,$36,$10,$c0,$01,$36,$18,$b8,$00
	db $36,$18,$c0,$01,$36,$20,$b8,$00,$36,$20,$c0,$01,$36,$00,$93,$1f
	db $3c,$00,$93,$1f,$3c,$00,$93,$1f,$3c,$00,$93,$1f,$3c,$00,$93,$1f
	db $3c,$00,$93,$1f,$3c,$00,$93,$1f,$3c,$00,$93,$1d,$3c,$00,$93,$1d
	db $7c,$00,$93,$1a,$3c,$00,$93,$1b,$3c,$00,$93,$1c,$3c,$fe,$fe,$fe
	db $fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe,$fe
	db $fe,$fe,$fe,$fe,$fe,$fe,$00,$70,$48,$36,$00,$70,$4a,$36,$00,$80
	db $4c,$36,$00,$80,$4e,$36,$00,$8c,$14,$36,$00,$8c,$15,$36,$00,$8c
	db $00,$36,$00,$94,$01,$36,$00,$8c,$00,$36,$00,$94,$01,$36,$00,$8c
	db $00,$36,$00,$94,$01,$36,$00,$8c,$00,$36,$00,$94,$01,$36,$00,$8c
	db $00,$36,$00,$94,$01,$36,$ff
	db $ff,$ff,$ff ; retain secondary layout offset $01AA
retail_oamhighlayout
	db $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$a0,$02,$00
	db $aa,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$aa,$00,$00,$00
	db $ff
retail_palramplengths
	db $48,$21,$18,$12,$0e,$0c,$0a,$09,$08,$07,$06,$06,$05,$05,$04,$04
	db $04,$03,$03,$03,$02,$02,$01,$01,$03,$04,$05,$06,$07,$09,$0b,$0d
	db $0f,$11,$13,$16,$19,$1c,$48,$00,$78,$21,$18,$12,$0e,$0c,$0a,$09
	db $08,$07,$06,$06,$05,$05,$04,$04,$04,$03,$03,$03,$02,$02,$01,$01
	db $03,$04,$05,$06,$07,$09,$0b,$0d,$0f,$11,$13,$16,$19,$1c,$18,$00
	db $50,$21,$18,$12,$0e,$0c,$0a,$09,$08,$07,$06,$06,$05,$05,$04,$04
	db $04,$03,$03,$03,$02,$02,$01,$01,$01,$01,$02,$02,$03,$04,$06,$08
	db $0a,$0c,$0e,$10,$12,$a7,$00
	db 0 ; masked high byte of final terminator read
retail_pala000
	dw $71c8,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $02a0,$0084,$0004,$2000,$0816,$2c1f,$021f,$5420
	dw $7d60,$0277,$037f,$5ad5,$318a,$03ec,$7fff,$0821
	dw $6b79,$6336,$52b2,$464f,$35cb,$7ffd,$7bdc,$77bb
	dw $6f79,$6b58,$5ad4,$4a50,$39cc,$2948,$1ce5,$0c61
	dw $464f,$39ec,$31a9,$2547,$52b0,$464d,$39ea,$2d87
	dw $29d2,$25b1,$2190,$1d6f,$194e,$152d,$110c,$0ceb
	dw $41bb,$3998,$3174,$2d51,$62d9,$5a97,$5255,$4a13
	dw $351f,$249f,$0c1b,$0017,$0014,$0012,$0010,$000d
	dw $7f31,$7ece,$726c,$61ea,$7f55,$7b13,$72d1,$6a8f
	dw $7f6b,$7ee7,$7e63,$7621,$6de0,$6180,$5520,$48c0
	dw $53bc,$337b,$2ad9,$2675,$5f79,$5737,$4ef5,$46b3
	dw $5fff,$37ff,$17bf,$033f,$02df,$027c,$0238,$01f4
	dw $43b1,$3f2c,$3a88,$3206,$5f73,$5751,$570f,$4acc
	dw $17f2,$0fcb,$0f47,$0ee4,$0e60,$0e00,$0da0,$0d40
	dw $3a9a,$35f9,$2d33,$02df,$01ff,$015f,$00ba,$0013
	dw $6bbc,$5759,$46d5,$7bff,$6bff,$577b,$46f7,$3a94
	dw $4237,$39d3,$294e,$01b8,$0153,$00ee,$00aa,$0087
	dw $535c,$42d7,$3232,$535f,$42dc,$3657,$2df3,$216e
	dw $7f95,$7b51,$5e6a,$7ff5,$7fee,$7366,$5aa4,$4602
	dw $5ef7,$4e73,$3def,$56d7,$4653,$39f0,$2d8d,$212a
	dw $44d9,$298c,$3e31,$56f7,$6b9c,$0286,$593f,$205a
	dw $7fe0,$7ee0,$5d60,$03b2,$025f,$037f,$7fff,$0821
	dw $53b8,$3396,$26d1,$57fc,$33fa,$0ff6,$0351,$02ac
	dw $624e,$51ca,$4168,$6189,$5107,$4063,$2c00,$2000
	dw $36d0,$262c,$1dc9,$02d3,$0291,$024f,$020d,$01cb
	dw $32b5,$2e31,$25cd,$01f2,$018e,$012a,$00e7,$00a5
	dw $01c0,$4c7f,$2415,$7ea0,$45cc,$2528,$1ce5,$0620
	dw $22eb,$0000,$1082,$5ad5,$318a,$309f,$7fff,$0821
	dw $6e9c,$661b,$5177,$7ebf,$761f,$717f,$60dd,$4c79
	dw $4b5b,$3ef8,$2e73,$3f7e,$331b,$26b8,$1a55,$0df2
retail_pala200
	dw $71c8,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $02a0,$0084,$0004,$2000,$0816,$2c1f,$021f,$5420
	dw $7d60,$0277,$037f,$5ad5,$318a,$03ec,$7fff,$0821
	dw $6b79,$6336,$52b2,$464f,$35cb,$7ffd,$7bdc,$77bb
	dw $6f79,$6b58,$5ad4,$4a50,$39cc,$2948,$1ce5,$0c61
	dw $464f,$39ec,$31a9,$2547,$52b0,$464d,$39ea,$2d87
	dw $4671,$4250,$3e2f,$3a0e,$35ed,$31cc,$2dab,$298a
	dw $41bb,$3998,$3174,$2d51,$62d9,$5a97,$5255,$4a13
	dw $351f,$249f,$0c1b,$0017,$0014,$0012,$0010,$000d
	dw $7f31,$7ece,$726c,$61ea,$7f55,$7b13,$72d1,$6a8f
	dw $7f6b,$7ee7,$7e63,$7621,$6de0,$6180,$5520,$48c0
	dw $53bc,$337b,$2ad9,$2675,$5f79,$5737,$4ef5,$46b3
	dw $5fff,$37ff,$17bf,$033f,$02df,$027c,$0238,$01f4
	dw $43b1,$3f2c,$3a88,$3206,$5f73,$5751,$570f,$4acc
	dw $17f2,$0fcb,$0f47,$0ee4,$0e60,$0e00,$0da0,$0d40
	dw $3a9a,$35f9,$2d33,$02df,$01ff,$015f,$00ba,$0013
	dw $6bbc,$5759,$46d5,$7bff,$6bff,$577b,$46f7,$3a94
	dw $4237,$39d3,$294e,$01b8,$0153,$00ee,$00aa,$0087
	dw $535c,$42d7,$3232,$535f,$42dc,$3657,$2df3,$216e
	dw $7f95,$7b51,$5e6a,$7ff5,$7fee,$7366,$5aa4,$4602
	dw $5ef7,$4e73,$3def,$56d7,$4653,$39f0,$2d8d,$212a
	dw $44d9,$298c,$3e31,$56f7,$6b9c,$0286,$593f,$205a
	dw $7fe0,$7ee0,$5d60,$03b2,$025f,$037f,$7fff,$0821
	dw $53b8,$3396,$26d1,$57fc,$33fa,$0ff6,$0351,$02ac
	dw $624e,$51ca,$4168,$6189,$5107,$4063,$2c00,$2000
	dw $36d0,$262c,$1dc9,$4a56,$4214,$39d2,$3190,$294e
	dw $32b5,$2e31,$25cd,$01f2,$018e,$012a,$00e7,$00a5
	dw $01c0,$4c7f,$2415,$7ea0,$45cc,$2528,$1ce5,$0620
	dw $22eb,$0000,$1082,$5ad5,$318a,$309f,$7fff,$0821
	dw $6e9c,$661b,$5177,$7ebf,$761f,$717f,$60dd,$4c79
	dw $4b5b,$3ef8,$2e73,$3f7e,$331b,$26b8,$1a55,$0df2
retail_pala400
	dw $71c8,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $02a0,$0084,$0004,$2000,$0816,$2c1f,$021f,$5420
	dw $7d60,$0277,$037f,$5ad5,$318a,$03ec,$7fff,$0821
	dw $6b79,$6336,$52b2,$464f,$35cb,$7ffd,$7bdc,$77bb
	dw $6f79,$6b58,$5ad4,$4a50,$39cc,$2948,$1ce5,$0c61
	dw $464f,$39ec,$31a9,$2547,$52b0,$464d,$39ea,$2d87
	dw $7f75,$7b54,$7733,$7312,$6ef1,$6ad0,$66af,$628e
	dw $41bb,$3998,$3174,$2d51,$62d9,$5a97,$5255,$4a13
	dw $351f,$249f,$0c1b,$0017,$0014,$0012,$0010,$000d
	dw $7f31,$7ece,$726c,$61ea,$7f55,$7b13,$72d1,$6a8f
	dw $7f6b,$7ee7,$7e63,$7621,$6de0,$6180,$5520,$48c0
	dw $53bc,$337b,$2ad9,$2675,$5f79,$5737,$4ef5,$46b3
	dw $5fff,$37ff,$17bf,$033f,$02df,$027c,$0238,$01f4
	dw $43b1,$3f2c,$3a88,$3206,$5f73,$5751,$570f,$4acc
	dw $17f2,$0fcb,$0f47,$0ee4,$0e60,$0e00,$0da0,$0d40
	dw $3a9a,$35f9,$2d33,$02df,$01ff,$015f,$00ba,$0013
	dw $6bbc,$5759,$46d5,$7bff,$6bff,$577b,$46f7,$3a94
	dw $4237,$39d3,$294e,$01b8,$0153,$00ee,$00aa,$0087
	dw $535c,$42d7,$3232,$535f,$42dc,$3657,$2df3,$216e
	dw $7f95,$7b51,$5e6a,$7ff5,$7fee,$7366,$5aa4,$4602
	dw $5ef7,$4e73,$3def,$56d7,$4653,$39f0,$2d8d,$212a
	dw $44d9,$298c,$3e31,$56f7,$6b9c,$0286,$593f,$205a
	dw $7fe0,$7ee0,$5d60,$03b2,$025f,$037f,$7fff,$0821
	dw $53b8,$3396,$26d1,$57fc,$33fa,$0ff6,$0351,$02ac
	dw $624e,$51ca,$4168,$6189,$5107,$4063,$2c00,$2000
	dw $36d0,$262c,$1dc9,$7230,$69ee,$61ac,$596a,$5128
	dw $32b5,$2e31,$25cd,$01f2,$018e,$012a,$00e7,$00a5
	dw $01c0,$4c7f,$2415,$7ea0,$45cc,$2528,$1ce5,$0620
	dw $22eb,$0000,$1082,$5ad5,$318a,$309f,$7fff,$0821
	dw $6e9c,$661b,$5177,$7ebf,$761f,$717f,$60dd,$4c79
	dw $4b5b,$3ef8,$2e73,$3f7e,$331b,$26b8,$1a55,$0df2
retail_pala600
	dw $71c8,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $02a0,$0084,$0004,$2000,$0816,$2c1f,$021f,$5420
	dw $7d60,$0277,$037f,$5ad5,$318a,$03ec,$7fff,$0821
	dw $6b79,$6336,$52b2,$464f,$35cb,$7ffd,$7bdc,$77bb
	dw $6f79,$6b58,$5ad4,$4a50,$39cc,$2948,$1ce5,$0c61
	dw $464f,$39ec,$31a9,$2547,$52b0,$464d,$39ea,$2d87
	dw $42ed,$3ecc,$3aab,$368a,$3269,$2e48,$2a27,$2606
	dw $41bb,$3998,$3174,$2d51,$62d9,$5a97,$5255,$4a13
	dw $351f,$249f,$0c1b,$0017,$0014,$0012,$0010,$000d
	dw $7f31,$7ece,$726c,$61ea,$7f55,$7b13,$72d1,$6a8f
	dw $7f6b,$7ee7,$7e63,$7621,$6de0,$6180,$5520,$48c0
	dw $53bc,$337b,$2ad9,$2675,$5f79,$5737,$4ef5,$46b3
	dw $5fff,$37ff,$17bf,$033f,$02df,$027c,$0238,$01f4
	dw $43b1,$3f2c,$3a88,$3206,$5f73,$5751,$570f,$4acc
	dw $17f2,$0fcb,$0f47,$0ee4,$0e60,$0e00,$0da0,$0d40
	dw $3a9a,$35f9,$2d33,$02df,$01ff,$015f,$00ba,$0013
	dw $6bbc,$5759,$46d5,$7bff,$6bff,$577b,$46f7,$3a94
	dw $4237,$39d3,$294e,$01b8,$0153,$00ee,$00aa,$0087
	dw $535c,$42d7,$3232,$535f,$42dc,$3657,$2df3,$216e
	dw $7f95,$7b51,$5e6a,$7ff5,$7fee,$7366,$5aa4,$4602
	dw $5ef7,$4e73,$3def,$56d7,$4653,$39f0,$2d8d,$212a
	dw $44d9,$298c,$3e31,$56f7,$6b9c,$0286,$593f,$205a
	dw $7fe0,$7ee0,$5d60,$03b2,$025f,$037f,$7fff,$0821
	dw $53b8,$3396,$26d1,$57fc,$33fa,$0ff6,$0351,$02ac
	dw $624e,$51ca,$4168,$6189,$5107,$4063,$2c00,$2000
	dw $36d0,$262c,$1dc9,$31f6,$29b4,$2172,$1930,$10ee
	dw $32b5,$2e31,$25cd,$01f2,$018e,$012a,$00e7,$00a5
	dw $01c0,$4c7f,$2415,$7ea0,$45cc,$2528,$1ce5,$0620
	dw $22eb,$0000,$1082,$5ad5,$318a,$309f,$7fff,$0821
	dw $6e9c,$661b,$5177,$7ebf,$761f,$717f,$60dd,$4c79
	dw $4b5b,$3ef8,$2e73,$3f7e,$331b,$26b8,$1a55,$0df2
retail_pala800
	dw $1cc4,$0000,$24e6,$20c5,$18a5,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $44d9,$298c,$3e31,$56f7,$6b9c,$0286,$593f,$205a
	dw $7fe0,$7ee0,$5d60,$03b2,$025f,$037f,$7fff,$0821
	dw $02a0,$1d27,$298a,$0fcb,$0816,$2c1f,$46f7,$5420
	dw $7d60,$0277,$17bf,$2dab,$2569,$0ee4,$7fff,$0821
	dw $1cc4,$0000,$24e6,$20c5,$18a5,$0000,$0000,$0000
	dw $0000,$0000,$0000,$7fff,$7ea8,$7e00,$0000,$0000
	dw $1cc4,$0000,$24e6,$20c5,$18a5,$0000,$0000,$0000
	dw $0000,$0000,$0000,$03bf,$0320,$0280,$0000,$0000
	dw $1cc4,$0000,$24e6,$20c5,$18a5,$0000,$0000,$0000
	dw $0000,$0000,$0000,$3def,$28df,$18d8,$0000,$0000
	dw $1cc4,$0000,$24e6,$20c5,$18a5,$0000,$0000,$0000
	dw $0000,$0000,$0000,$1e7f,$033f,$025f,$0000,$0000
	dw $1cc4,$0000,$24e6,$20c5,$18a5,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$660e,$596b,$0000,$0000
	dw $3607,$0000,$7fff,$7fd3,$56b5,$241c,$7e8c,$035f
	dw $1b86,$1ce7,$02ff,$3d7f,$4e73,$35ad,$18d8,$11df
	dw $3607,$0000,$7fff,$7fd3,$56b5,$0307,$035f,$1cff
	dw $253e,$1ce7,$7da0,$7ec0,$4e73,$35ad,$7120,$0858
	dw $3607,$0821,$0821,$0821,$0821,$0821,$0821,$0821
	dw $0821,$0821,$0821,$0821,$0821,$0821,$0821,$0821
	dw $44d9,$298c,$3e31,$56f7,$6b9c,$0286,$593f,$205a
	dw $7fe0,$7ee0,$5d60,$03b2,$025f,$037f,$7fff,$0821
	dw $3607,$0821,$0821,$0821,$0821,$0821,$0821,$0821
	dw $0821,$0821,$0821,$7fff,$0821,$0821,$0821,$0821
	dw $3607,$0821,$0821,$0821,$0821,$0000,$0000,$0000
	dw $0000,$0821,$0000,$235f,$0000,$0821,$0821,$0821
	dw $01c0,$4c7f,$2415,$7ea0,$45cc,$2528,$1ce5,$0620
	dw $22eb,$0000,$1082,$5ad5,$318a,$309f,$7fff,$0821
	dw $3607,$0000,$0821,$0821,$0821,$0821,$0000,$0821
	dw $0821,$0821,$0821,$0821,$0821,$0821,$0821,$0821
retail_palaa00
	dw $7fff,$5c00,$2e67,$3288,$36a9,$3aca,$3234,$3e97
	dw $4afa,$3e69,$428a,$46ab,$7f50,$7fb6,$77fa,$0db7
	dw $7d20,$7d40,$7d60,$7d80,$7da0,$7dc0,$7de0,$7e20
	dw $7e40,$7e40,$7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c
	dw $7f2e,$7f50,$7f72,$7f94,$7fb6,$7bd8,$77fa,$73fc
	dw $4e6b,$4a8a,$46a9,$42c8,$3ee7,$3b06,$3725,$3344
	dw $2f63,$2b82,$27a1,$23c0,$1fe0,$1be0,$17e0
retail_palaadc
	dw $7bff,$1158,$0004,$0006,$0008,$000f,$0012,$1954
	dw $1556,$0009,$000b,$000d,$1158,$0d5a,$095c,$47df
	dw $3547,$3148,$2d4a,$294c,$254e,$2150,$1d52,$1954
	dw $1556,$1158,$0d5a,$095c,$017e,$11bf,$15ff,$1e3f
	dw $225f,$269f,$2adf,$2f1f,$3f9f,$3f9f,$269f,$0cd2
	dw $0005,$0006,$0027,$0048,$0069,$008a,$00ab,$00cc
	dw $00ed,$010e,$012f,$0150,$0171,$0192,$01b3
retail_palab4a
	dw $7fff,$7e62,$14ab,$18ec,$1d2d,$216e,$25af,$7e20
	dw $7e40,$14ab,$18cc,$1ced,$7e60,$7e80,$7ea0,$7f2f
	dw $7d60,$7d80,$7da0,$7dc0,$7de0,$7e00,$7e20,$7e40
	dw $7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c,$7f2e,$7f50
	dw $7f72,$7f94,$7fb6,$7bd8,$7398,$6318,$5298,$1d4f
	dw $002a,$044b,$046b,$088c,$08ac,$0ccd,$0ced,$110e
	dw $112e,$154f,$156f,$1990,$19b0,$1dd1,$2212
retail_palabb8
	dw $7fff,$6ba9,$3659,$42bc,$471d,$4f7e,$0e83,$16c5
	dw $1f07,$2749,$2f8b,$6667,$7f71,$7ffd,$7ffe,$7fff
	dw $7d44,$7d65,$7d86,$7da7,$7dc8,$7de9,$7e0a,$7e2b
	dw $7e4c,$7e6d,$7e8e,$7eaf,$7ed0,$7ef1,$7f12,$7f33
	dw $7f54,$7f75,$7f96,$7fb7,$7fd8,$7ff9,$7ffb,$7ffd
	dw $73b1,$6ba9,$63a9,$5b87,$5367,$4f47,$4b27,$4707
	dw $42e7,$3ec7,$3aa7,$3687,$3267,$2e47,$2a27
retail_palac26
	dw $7fff,$77bd,$5b16,$6358,$6b9a,$73dc,$3e97,$4afa
	dw $575d,$5ef6,$6f7a,$77bc,$5a94,$66f7,$777b,$4711
	dw $2908,$2d29,$314a,$356b,$398c,$3dad,$41ce,$45ef
	dw $4a10,$4e31,$5252,$5673,$5a94,$5eb5,$62d6,$66f7
	dw $6b18,$6f39,$735a,$777b,$7b9c,$7fbd,$7fde,$7fff
	dw $7bde,$77bd,$739c,$6f7b,$6b5a,$6739,$6318,$5ef7
	dw $5ef7,$5ad6,$56b5,$5294,$4e73,$4a52,$4631
retail_palac94
	dw $77bd,$77bd,$6779,$6b9a,$6fbb,$73dc,$3a76,$4afa
	dw $5b7e,$6738,$6f7a,$77bc,$7f75,$7fb7,$7ff9,$4711
	dw $7c00,$7c20,$7c40,$7c60,$7c80,$7ca0,$7cc0,$7ce1
	dw $7d02,$7d23,$7d44,$7d65,$7d86,$7da7,$7dc8,$7de9
	dw $7e0a,$7e2b,$7e4c,$7e6d,$7e8e,$7ed1,$7f57,$7fdb
	dw $7fff,$7ffe,$7fdd,$7bbc,$779b,$737a,$6f59,$6b38
	dw $6717,$62f6,$5ed5,$5ab4,$5693,$5272,$4e51
retail_palad02
	dw $7fff,$005f,$14a5,$1084,$0c63,$0842,$0421,$21fb
	dw $006f,$5fe0,$2a43,$7f1f,$0011,$4ca5,$20a5,$01ff
	dw $0421,$0421,$0421,$0421,$0421,$0421,$0421,$0421
	dw $0421,$0421,$0421,$0421,$0421,$0421,$0421,$0421
	dw $0842,$0c63,$1084,$14a5,$18c6,$1ce7,$2108,$2529
	dw $14a5,$18a5,$1ca5,$20a5,$24a5,$28a5,$2ca5,$30a5
	dw $34a5,$38a5,$3ca5,$40a5,$44a5,$48a5,$4ca5
retail_palad70
	dw $7fff,$005f,$18c6,$1ce7,$2108,$2529,$294a,$327f
	dw $00f3,$6fe4,$3ac7,$7f7f,$0015,$7e37,$7e15,$22ff
	dw $7c05,$7c27,$7c69,$7cab,$7ced,$7d2f,$7d71,$7db3
	dw $7df5,$7e37,$7e79,$7ebb,$7efd,$7f3f,$777f,$6fbf
	dw $67ff,$67ff,$67ff,$67ff,$67ff,$67ff,$67ff,$67ff
	dw $1c00,$2000,$2400,$2800,$2c00,$3000,$3400,$3800
	dw $3c00,$4000,$4400,$4800,$4c00,$5000,$5400
retail_paladde
	dw $7bff,$7c00,$6734,$6b55,$6f76,$7397,$4abb,$52fb
	dw $7f98,$7f99,$7f9a,$6354,$6775,$6b96,$6fb7,$5f5e
	dw $7f78,$7f78,$7f78,$7f78,$7f78,$7f78,$7f78,$7f78
	dw $7f78,$7f78,$7f78,$7f78,$7f78,$7f78,$7f78,$7f78
	dw $7f78,$7f78,$7f78,$7f78,$7f78,$7f78,$7f78,$7f78
	dw $7b57,$7b77,$7777,$7797,$7397,$73b7,$6fb7,$6fd7
	dw $6bd7,$6bf7,$67f7,$63f7,$5ff7,$5bf7,$57f7
retail_palae4c
	dw $7bff,$7c00,$29c4,$3a48,$530e,$67b4,$1951,$19f6
	dw $7ea6,$7f0c,$7f72,$2204,$3288,$4b4e,$63f4,$2a7a
	dw $7d40,$7d60,$7d80,$7da0,$7dc0,$7de0,$7e00,$7e20
	dw $7e40,$7e40,$7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c
	dw $7f2e,$7f50,$7f72,$7f94,$7fb6,$7ff8,$7ffa,$7ffc
	dw $3288,$32a8,$32c8,$32e8,$3308,$3328,$3348,$3368
	dw $3388,$33a8,$33c8,$33e8,$37e8,$3be8,$3fe8
retail_palaeba
	dw $7fff,$02d6,$7fff,$7ffc,$7ffa,$7ff8,$7ff6,$7fd5
	dw $7fb3,$7f91,$7f6f,$7f4e,$7f4d,$7f4c,$2800,$2800
	dw $7d80,$7da1,$7dc2,$7de3,$7e04,$7e25,$7e46,$7e67
	dw $7e88,$7ea9,$7eca,$7eeb,$7f0c,$7f2d,$7f4e,$7f6f
	dw $7f91,$7fb3,$7fd5,$7ff6,$7ff8,$7ffa,$7ffc,$7fff
	dw $7fff,$7ffe,$7ffe,$7ffd,$7ffc,$7ffb,$7ffa,$7ff9
	dw $7ff8,$7ff6,$7ff5,$7ff4,$7ff3,$7ff2,$7ff1
retail_palaf28
	dw $7fff,$7e8e,$25af,$3633,$73ed,$1d48,$21aa,$260c
	dw $4eab,$56ed,$5f2f,$7f10,$7f73,$7fd6,$3248,$7f52
	dw $7d65,$7d86,$7da7,$7dc8,$7de9,$7e0a,$7e2b,$7e4c
	dw $7e6d,$7e8e,$7eaf,$7ed0,$7ef1,$7f12,$7f33,$7f54
	dw $7f75,$7f96,$7fb7,$7fd8,$7ff9,$7bf7,$7bd5,$77d3
	dw $73ed,$6bcb,$63a9,$5b87,$5367,$4f47,$4b27,$4707
	dw $42e7,$3ec7,$3aa7,$3687,$3267,$2e47,$2a27
retail_palaf96
	dw $7fff,$3220,$6a73,$3484,$0000,$0421,$0842,$0c63
	dw $1084,$0100,$3220,$7fff,$00a5,$0063,$0011,$7f1f
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0400,$0800,$0c20
	dw $1040,$1461,$1882,$1ca3,$20c4,$24e5,$20e5,$1cc6
	dw $14a5,$1084,$0c63,$0842,$0421,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000
retail_palb004
	dw $7fff,$1556,$1158,$1158,$0000,$0001,$0002,$0423
	dw $0844,$0025,$116f,$7fff,$14a7,$1086,$15ff,$269f
	dw $3547,$3148,$2d4a,$294c,$254e,$2150,$1d52,$1954
	dw $1556,$1158,$0d5a,$095c,$017e,$11bf,$15ff,$1e3f
	dw $225f,$269f,$2adf,$2f1f,$3f9f,$3f9f,$269f,$0cd2
	dw $14a7,$1086,$0c65,$0844,$0423,$0002,$0001,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000
retail_palb072
	dw $7fff,$3220,$03fb,$01eb,$0000,$0421,$0842,$0c63
	dw $1084,$00a9,$3277,$7fff,$0c60,$0840,$0011,$7f1f
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0400,$0800,$0c20
	dw $1040,$1461,$1882,$1ca3,$20c4,$24e5,$20e5,$1cc6
	dw $14a5,$1084,$0c63,$0842,$0421,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000
retail_palb0e0
	dw $7fff,$7dce,$7d20,$7d60,$7da0,$7de0,$7e20,$7e60
	dw $7ea0,$7ee0,$7f20,$7f60,$7fa0,$7fe0,$7fe4,$7fe4
	dw $7fc0,$7fc0,$7fc0,$7fc0,$7fc0,$7fc0,$7fc0,$7fc0
	dw $7fc0,$7fc0,$7fa0,$7f60,$7f20,$7ee0,$7ea0,$7e60
	dw $7e20,$7de0,$7da0,$7d60,$7d20,$7ce0,$7ca0,$7ca0
	dw $7ca0,$7ca0,$7cc0,$7ce0,$7d00,$7d20,$7d40,$7d60
	dw $7d80,$7da0,$7dc0,$7de0,$7e00,$7e20,$7e40
retail_palb14e
	dw $7bff,$5c00,$0c85,$10a6,$14c7,$14c8,$18e9,$1d83
	dw $1da2,$1d08,$2129,$254a,$2d6b,$294a,$2529,$2108
	dw $0000,$0421,$0842,$0c63,$1084,$14a5,$18c6,$1ce7
	dw $2108,$2529,$294a,$2d6b,$318c,$35ad,$39ce,$3def
	dw $4210,$4631,$4a52,$4e73,$5294,$56b5,$4210,$2d6b
	dw $1d07,$1d26,$1d45,$1d64,$1d83,$1da2,$1dc1,$1de0
	dw $1e00,$1e20,$1e40,$1e60,$1e80,$1ea0,$1ec0
retail_palb1bc
	dw $7bff,$5c00,$2d4d,$358f,$3dd1,$4613,$4e55,$1f28
	dw $1f48,$254c,$296d,$2d8e,$7ca0,$7cc0,$7ce1,$7d02
	dw $7c20,$7c40,$7c60,$7c80,$7ca0,$7cc0,$7ce1,$7d02
	dw $7d23,$7d44,$7d65,$7d86,$7da7,$7dc8,$7de9,$7e0a
	dw $7e2b,$7e4c,$7e6d,$7e8e,$76ce,$6f0e,$674e,$4b4b
	dw $1f48,$1f28,$1f08,$1ee8,$1ec8,$1ea8,$1e88,$1e68
	dw $1e48,$1e28,$1e08,$1de8,$1dc8,$1da8,$1d88
retail_palb22a
	dw $7fff,$7e40,$3a94,$46f7,$577b,$6bff,$4adf,$158c
	dw $25fd,$669f,$03ff,$01bf,$0015,$2720,$55df,$7fff
	dw $7d40,$7d60,$7d80,$7da0,$7dc0,$7de0,$7e00,$7e20
	dw $7e40,$7e40,$7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c
	dw $7f2e,$7f50,$7f72,$7f94,$7fb6,$7bd8,$77fa,$73fc
	dw $046b,$088c,$08ac,$0ccd,$0ced,$110e,$112e,$154f
	dw $156f,$1990,$19b0,$1dd1,$2212,$2633,$2a54
retail_palb298
	dw $7fff,$7e40,$3a94,$46f7,$577b,$6bff,$4adf,$158c
	dw $25fd,$669f,$03ff,$01bf,$0015,$2720,$55df,$7fff
	dw $7d40,$7d60,$7d80,$7da0,$7dc0,$7de0,$7e00,$7e20
	dw $7e40,$7e40,$7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c
	dw $7f2e,$7f50,$7f72,$7f94,$7fb6,$7bd8,$77fa,$73fc
	dw $7d40,$7d60,$7d80,$7da0,$7dc0,$7de0,$7e00,$7e20
	dw $7e40,$7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c
retail_palb306
	dw $7fff,$7e40,$3a94,$46f7,$577b,$6bff,$4adf,$158c
	dw $25fd,$669f,$03ff,$01bf,$0015,$2720,$55df,$7fff
	dw $7d40,$7d60,$7d80,$7da0,$7dc0,$7de0,$7e00,$7e20
	dw $7e40,$7e40,$7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c
	dw $7f2e,$7f50,$7f72,$7f94,$7fb6,$7bd8,$77fa,$73fc
	dw $7ef1,$7f12,$7f33,$7f54,$7f75,$7f96,$7fb7,$7fd8
	dw $7ff9,$7ffa,$7ffb,$7ffc,$7ffd,$7ffe,$7fff
retail_palb374
	dw $7fff,$7e40,$3a94,$46f7,$577b,$6bff,$4adf,$158c
	dw $25fd,$669f,$03ff,$01bf,$0015,$2720,$55df,$7fff
	dw $7d40,$7d60,$7d80,$7da0,$7dc0,$7de0,$7e00,$7e20
	dw $7e40,$7e40,$7e62,$7e84,$7ea6,$7ec8,$7eea,$7f0c
	dw $7f2e,$7f50,$7f72,$7f94,$7fb6,$7bd8,$77fa,$73fc
	dw $0125,$0146,$0167,$0188,$01a9,$01ca,$01eb,$020c
	dw $022d,$024e,$026f,$0290,$02b1,$02d2,$02f3
mrdisp_end
