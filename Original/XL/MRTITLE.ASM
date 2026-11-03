; Retail title input, erase confirmation and record validation.
; Strategies: A16/I16, D=0, DB=0, binary arithmetic. Save APIs retain P/DB;
; checkrecords is the native internal entry and requires DB=recordimage bank.
; Recordimage is a caller-loaded1KiB SRAM working image, not a live battery
; or filesystem binding. checksave/sumsettings publish its first512 bytes to
; the existing frontend snapshot after validation; export persistence outside
; these routines. Internal checksum/repair helpers do not publish separately.
; Title erase clears all1KiB before validation, retaining native checksums,
; sentinels, bounds tests and the diagnostic byte. Initialize forms/entities,
; recordimage, input edges and queues before dispatch. Key positions are0..7.
; The title exit waits for tag19 to finish its scroll before handing off to
; the restored graphics stages. Publish each stage before scratch reuse.
; Active scene/NMI ownership is unchanged. Shared externals come from the
; preceding frontend modules in INCBINS.
	incpublics mrtitle.ext
mrtitle_begin
rti_recordbase equ race_recordimage&WM
	longa
	longi
rti_checksave
	php
rti_03efd3
	ai8
rti_03efd5
	phb
rti_03efd6
	lda #race_recordimage>>16
rti_03efd8
	pha
rti_03efd9
	plb
rti_03efda
	a8
rti_03efdc
	clc
rti_03efdd
	lda.w rti_recordbase+11
rti_03efe0
	adc.w rti_recordbase+15
rti_03efe3
	adc.w rti_recordbase+6
rti_03efe6
	adc.w rti_recordbase+7
rti_03efe9
	adc.w rti_recordbase+12
rti_03efec
	adc.w rti_recordbase+13
rti_03efef
	adc.w rti_recordbase+14
rti_03eff2
	adc.w rti_recordbase+8
rti_03eff5
	adc.w rti_recordbase+9
rti_03eff8
	adc.w rti_recordbase+10
rti_03effb
	cmp.w rti_recordbase+20
rti_03effe
	beq rti_03f024
rti_03f000
	stz.w rti_recordbase+11
rti_03f003
	stz.w rti_recordbase+15
rti_03f006
	stz.w rti_recordbase+6
rti_03f009
	stz.w rti_recordbase+7
rti_03f00c
	stz.w rti_recordbase+12
rti_03f00f
	stz.w rti_recordbase+13
rti_03f012
	stz.w rti_recordbase+14
rti_03f015
	stz.w rti_recordbase+8
rti_03f018
	stz.w rti_recordbase+9
rti_03f01b
	stz.w rti_recordbase+10
rti_03f01e
	stz.w rti_recordbase+20
rti_03f021
	stz.w rti_recordbase+21
rti_03f024
	jsl rti_checkrecords
	jsr rti_publishrecords
rti_03f028
	plb
rti_03f029
	plp
rti_03f02a
	rtl
	longa
	longi
rti_sumsettings
	php
rti_03f02c
	a8
rti_03f02e
	clc
rti_03f02f
	lda.l race_recordimage+11
rti_03f033
	adc.l race_recordimage+6
rti_03f037
	adc.l race_recordimage+7
rti_03f03b
	adc.l race_recordimage+12
rti_03f03f
	adc.l race_recordimage+13
rti_03f043
	adc.l race_recordimage+14
rti_03f047
	adc.l race_recordimage+8
rti_03f04b
	adc.l race_recordimage+9
rti_03f04f
	adc.l race_recordimage+10
rti_03f053
	sta.l race_recordimage+20
rti_03f057
	sta.l race_recordimage+21
	jsr rti_publishrecords
rti_03f05b
	plp
rti_03f05c
	rtl
	shorti
rti_sumscore
	ldy #$05
rti_07adce
	lda #$00
rti_07add0
	clc
rti_07add1
	adc.l race_recordimage+74,x
rti_07add5
	inx
rti_07add6
	dey
rti_07add7
	bne rti_07add0
rti_07add9
	rts
rti_sumtime
	ldy #$05
rti_07adfb
	lda #$00
rti_07adfd
	clc
rti_07adfe
	adc.l race_recordimage+94,x
rti_07ae02
	inx
rti_07ae03
	dey
rti_07ae04
	bne rti_07adfd
rti_07ae06
	rts
rti_checkrecords
	php
rti_07b086
	jsr rti_checknames
rti_07b089
	jsr rti_checkcourses
rti_07b08c
	jsr rti_checkspecial
rti_07b08f
	jsr rti_checktimes
rti_07b092
	jsr rti_checkscores
rti_07b095
	plp
rti_07b096
	rtl
rti_checktimes
	ai8
rti_07b099
	ldx #$00
rti_07b09b
	ldy #$00
rti_07b09d
	phx
rti_07b09e
	phy
rti_07b09f
	jsr rti_sumtime
rti_07b0a2
	ply
rti_07b0a3
	plx
rti_07b0a4
	cmp.w rti_recordbase+67,y
rti_07b0a7
	bne rti_07b0ae
rti_07b0a9
	lda.w rti_recordbase+94,x
rti_07b0ac
	bne rti_07b0c6
rti_07b0ae
	lda #$ff
rti_07b0b0
	sta.w rti_recordbase+94,x
rti_07b0b3
	sta.w rti_recordbase+95,x
rti_07b0b6
	lda #$00
rti_07b0b8
	sta.w rti_recordbase+96,x
rti_07b0bb
	sta.w rti_recordbase+97,x
rti_07b0be
	sta.w rti_recordbase+98,x
rti_07b0c1
	lda #$fe
rti_07b0c3
	sta.w rti_recordbase+67,y
rti_07b0c6
	inx
rti_07b0c7
	inx
rti_07b0c8
	inx
rti_07b0c9
	inx
rti_07b0ca
	inx
rti_07b0cb
	iny
rti_07b0cc
	cpy #$03
rti_07b0ce
	bcc rti_07b09d
rti_07b0d0
	rts
rti_checkscores
	ai8
rti_07b0d3
	ldx #$00
rti_07b0d5
	ldy #$00
rti_07b0d7
	phx
rti_07b0d8
	phy
rti_07b0d9
	jsr rti_sumscore
rti_07b0dc
	ply
rti_07b0dd
	plx
rti_07b0de
	cmp.w rti_recordbase+70,y
rti_07b0e1
	bne rti_07b0e8
rti_07b0e3
	lda.w rti_recordbase+74,x
rti_07b0e6
	bne rti_07b100
rti_07b0e8
	lda #$ff
rti_07b0ea
	sta.w rti_recordbase+74,x
rti_07b0ed
	sta.w rti_recordbase+75,x
rti_07b0f0
	lda #$00
rti_07b0f2
	sta.w rti_recordbase+76,x
rti_07b0f5
	sta.w rti_recordbase+77,x
rti_07b0f8
	sta.w rti_recordbase+78,x
rti_07b0fb
	lda #$fe
rti_07b0fd
	sta.w rti_recordbase+70,y
rti_07b100
	inx
rti_07b101
	inx
rti_07b102
	inx
rti_07b103
	inx
rti_07b104
	inx
rti_07b105
	iny
rti_07b106
	cpy #$04
rti_07b108
	bcc rti_07b0d7
rti_07b10a
	rts
rti_checknames
	ai16
rti_07b10d
	lda #$0000
rti_07b110
	ldx #$0002
rti_07b113
	a8
rti_07b115
	sta y2+1
rti_07b117
	sta dx+1
rti_07b119
	phx
rti_07b11a
	lda.l retail_nameblocks+3,x
rti_07b11e
	sta y2
rti_07b120
	lda.l retail_nameblocks,x
rti_07b124
	sta dx
rti_07b126
	stz x2
rti_07b128
	ldy #$000c
rti_07b12b
	ldx y2
rti_07b12d
	clc
rti_07b12e
	lda.w rti_recordbase+136,x
rti_07b131
	adc x2
rti_07b133
	sta x2
rti_07b135
	lda.w rti_recordbase+137,x
rti_07b138
	cmp #$1f
rti_07b13a
	bcc rti_07b161
rti_07b13c
	clc
rti_07b13d
	adc x2
rti_07b13f
	sta x2
rti_07b141
	inx
rti_07b142
	inx
rti_07b143
	dey
rti_07b144
	bne rti_07b12d
rti_07b146
	ldx dx
rti_07b148
	ldy #$0009
rti_07b14b
	clc
rti_07b14c
	lda.w rti_recordbase+109,x
rti_07b14f
	adc x2
rti_07b151
	sta x2
rti_07b153
	inx
rti_07b154
	dey
rti_07b155
	bne rti_07b14b
rti_07b157
	plx
rti_07b158
	lda.w rti_recordbase+45,x
rti_07b15b
	cmp x2
rti_07b15d
	bne rti_07b162
rti_07b15f
	bra rti_07b186
rti_07b161
	plx
rti_07b162
	phx
rti_07b163
	lda #$ff
rti_07b165
	ldx y2
rti_07b167
	ldy #$0018
rti_07b16a
	sta.w rti_recordbase+136,x
rti_07b16d
	inx
rti_07b16e
	dey
rti_07b16f
	bne rti_07b16a
rti_07b171
	ldx dx
rti_07b173
	lda #$00
rti_07b175
	ldy #$0009
rti_07b178
	sta.w rti_recordbase+109,x
rti_07b17b
	inx
rti_07b17c
	dey
rti_07b17d
	bne rti_07b178
rti_07b17f
	plx
rti_07b180
	lda #$e8
rti_07b182
	sta.l race_recordimage+45,x
rti_07b186
	dex
rti_07b187
	bpl rti_07b119
rti_07b189
	rts
	shorti
rti_checkspecial
	i16
rti_07b192
	ldx #$000c
rti_07b195
	stx y2
rti_07b197
	a16
rti_07b199
	lda y2
rti_07b19b
	asl a
rti_07b19c
	clc
rti_07b19d
	adc y2
rti_07b19f
	asl a
rti_07b1a0
	asl a
rti_07b1a1
	asl a
rti_07b1a2
	asl a
rti_07b1a3
	tax
rti_07b1a4
	sta dx
rti_07b1a6
	stz x2
rti_07b1a8
	ldy #$000c
rti_07b1ab
	a8
rti_07b1ad
	clc
rti_07b1ae
	lda.w rti_recordbase+208,x
rti_07b1b1
	adc x2
rti_07b1b3
	sta x2
rti_07b1b5
	lda.w rti_recordbase+209,x
rti_07b1b8
	cmp #$41
rti_07b1ba
	bcs rti_07b1ea
rti_07b1bc
	clc
rti_07b1bd
	adc x2
rti_07b1bf
	sta x2
rti_07b1c1
	clc
rti_07b1c2
	lda.w rti_recordbase+210,x
rti_07b1c5
	adc x2
rti_07b1c7
	sta x2
rti_07b1c9
	clc
rti_07b1ca
	lda.w rti_recordbase+211,x
rti_07b1cd
	adc x2
rti_07b1cf
	sta x2
rti_07b1d1
	inx
rti_07b1d2
	inx
rti_07b1d3
	inx
rti_07b1d4
	inx
rti_07b1d5
	dey
rti_07b1d6
	bne rti_07b1ad
rti_07b1d8
	ldx y2
rti_07b1da
	lda.w rti_recordbase+51,x
rti_07b1dd
	cmp x2
rti_07b1df
	bne rti_07b1ea
rti_07b1e1
	inc y2
rti_07b1e3
	lda y2
rti_07b1e5
	cmp #$10
rti_07b1e7
	bcc rti_07b197
rti_07b1e9
	rts
rti_07b1ea
	ldx dx
rti_07b1ec
	a8
rti_07b1ee
	ldy #$000c
rti_07b1f1
	lda #$00
rti_07b1f3
	sta.w rti_recordbase+208,x
rti_07b1f6
	sta.w rti_recordbase+209,x
rti_07b1f9
	lda #$ff
rti_07b1fb
	sta.w rti_recordbase+210,x
rti_07b1fe
	sta.w rti_recordbase+211,x
rti_07b201
	inx
rti_07b202
	inx
rti_07b203
	inx
rti_07b204
	inx
rti_07b205
	dey
rti_07b206
	bne rti_07b1f1
rti_07b208
	ldx y2
rti_07b20a
	lda #$e8
rti_07b20c
	sta.w rti_recordbase+51,x
rti_07b20f
	bra rti_07b1e1
	shorti
rti_checkcourses
	i16
rti_07b213
	ldx #$0000
rti_07b216
	stx y2
rti_07b218
	a16
rti_07b21a
	lda y2
rti_07b21c
	asl a
rti_07b21d
	asl a
rti_07b21e
	tax
rti_07b21f
	a8
rti_07b221
	lda.l race_recordimage+976,x
rti_07b225
	sta x2
rti_07b227
	lda.l race_recordimage+977,x
rti_07b22b
	clc
rti_07b22c
	adc x2
rti_07b22e
	sta x2
rti_07b230
	lda.l race_recordimage+978,x
rti_07b234
	clc
rti_07b235
	adc x2
rti_07b237
	sta x2
rti_07b239
	lda.l race_recordimage+979,x
rti_07b23d
	clc
rti_07b23e
	adc x2
rti_07b240
	a16
rti_07b242
	and #$00ff
rti_07b245
	sta x2
rti_07b247
	lda y2
rti_07b249
	asl a
rti_07b24a
	clc
rti_07b24b
	adc y2
rti_07b24d
	asl a
rti_07b24e
	asl a
rti_07b24f
	asl a
rti_07b250
	asl a
rti_07b251
	tax
rti_07b252
	sta dx
rti_07b254
	ldy #$000c
rti_07b257
	a8
rti_07b259
	clc
rti_07b25a
	lda.w rti_recordbase+208,x
rti_07b25d
	pha
rti_07b25e
	cmp #$ff
rti_07b260
	beq rti_07b26b
rti_07b262
	and #$7f
rti_07b264
	cmp #$64
rti_07b266
	bcc rti_07b26b
rti_07b268
	pla
rti_07b269
	bra rti_07b2dd
rti_07b26b
	pla
rti_07b26c
	clc
rti_07b26d
	adc x2
rti_07b26f
	sta x2
rti_07b271
	lda.w rti_recordbase+209,x
rti_07b274
	pha
rti_07b275
	cmp #$ff
rti_07b277
	beq rti_07b28d
rti_07b279
	and #$1f
rti_07b27b
	cmp #$1e
rti_07b27d
	bcc rti_07b282
rti_07b27f
	pla
rti_07b280
	bra rti_07b2dd
rti_07b282
	pla
rti_07b283
	pha
rti_07b284
	and #$e0
rti_07b286
	cmp #$20
rti_07b288
	bcs rti_07b28d
rti_07b28a
	pla
rti_07b28b
	bra rti_07b2dd
rti_07b28d
	pla
rti_07b28e
	clc
rti_07b28f
	adc x2
rti_07b291
	sta x2
rti_07b293
	lda.w rti_recordbase+210,x
rti_07b296
	pha
rti_07b297
	cmp #$ff
rti_07b299
	beq rti_07b2a4
rti_07b29b
	and #$1f
rti_07b29d
	cmp #$1c
rti_07b29f
	bcc rti_07b2a4
rti_07b2a1
	pla
rti_07b2a2
	bra rti_07b2dd
rti_07b2a4
	pla
rti_07b2a5
	clc
rti_07b2a6
	adc x2
rti_07b2a8
	sta x2
rti_07b2aa
	lda.w rti_recordbase+211,x
rti_07b2ad
	pha
rti_07b2ae
	cmp #$ff
rti_07b2b0
	beq rti_07b2bb
rti_07b2b2
	and #$03
rti_07b2b4
	cmp #$38
rti_07b2b6
	bcc rti_07b2bb
rti_07b2b8
	pla
rti_07b2b9
	bra rti_07b2dd
rti_07b2bb
	pla
rti_07b2bc
	clc
rti_07b2bd
	adc x2
rti_07b2bf
	sta x2
rti_07b2c1
	inx
rti_07b2c2
	inx
rti_07b2c3
	inx
rti_07b2c4
	inx
rti_07b2c5
	dey
rti_07b2c6
	bne rti_07b25a
rti_07b2c8
	ldx y2
rti_07b2ca
	lda.w rti_recordbase+51,x
rti_07b2cd
	cmp x2
rti_07b2cf
	bne rti_07b2dd
rti_07b2d1
	inc y2
rti_07b2d3
	lda y2
rti_07b2d5
	cmp #$0c
rti_07b2d7
	bcs rti_07b2dc
rti_07b2d9
	jmp rti_07b218
rti_07b2dc
	rts
rti_07b2dd
	pha
rti_07b2de
	lda #$11
rti_07b2e0
	sta.l race_recorderror
rti_07b2e4
	pla
rti_07b2e5
	a16
rti_07b2e7
	ldx dx
rti_07b2e9
	a8
rti_07b2eb
	ldy #$0030
rti_07b2ee
	lda #$ff
rti_07b2f0
	sta.w rti_recordbase+208,x
rti_07b2f3
	inx
rti_07b2f4
	dey
rti_07b2f5
	bne rti_07b2f0
rti_07b2f7
	ldx y2
rti_07b2f9
	a16
rti_07b2fb
	lda y2
rti_07b2fd
	and #$00ff
rti_07b300
	asl a
rti_07b301
	asl a
rti_07b302
	tay
rti_07b303
	a8
rti_07b305
	lda #$ff
rti_07b307
	sta.w rti_recordbase+976,y
rti_07b30a
	sta.w rti_recordbase+977,y
rti_07b30d
	sta.w rti_recordbase+978,y
rti_07b310
	sta.w rti_recordbase+979,y
rti_07b313
	lda #$cc
rti_07b315
	sta.w rti_recordbase+51,x
rti_07b318
	jmp rti_07b218
	longa
rti_logoaway
	jsl retail_stepentityanim_l
rti_0bce8d
	lda $0a,x
rti_0bce8f
	inc a
rti_0bce90
	and #$0001
rti_0bce93
	sta $0a,x
rti_0bce95
	bne rti_0bce9f
rti_0bce97
	lda $22,x
rti_0bce99
	clc
rti_0bce9a
	adc #$0001
rti_0bce9d
	sta $22,x
rti_0bce9f
	lda $20,x
rti_0bcea1
	clc
rti_0bcea2
	adc $22,x
rti_0bcea4
	sta $20,x
rti_0bcea6
	lda $20,x
rti_0bcea8
	bmi rti_0bcead
rti_0bceaa
	brl rti_0bcef7
rti_0bcead
	cmp #$ffa8
rti_0bceb0
	bcc rti_0bceb5
rti_0bceb2
	brl rti_0bcef7
rti_0bceb5
	lda #rhk_logodrop&WM
rti_0bceb8
	sta $08,x
rti_0bceba
	a8
rti_0bcebc
	lda #$13
rti_0bcebe
	jsl queue_racesound0_l
rti_0bcec2
	a16
rti_0bcec4
	a8
rti_0bcec6
	a16
rti_0bcec8
	lda #$0000
rti_0bcecb
	sec
rti_0bcecc
	sbc $20,x
rti_0bcece
	a8
rti_0bced0
	xba
rti_0bced1
	a8
rti_0bced3
	i16
rti_0bced5
	phx
rti_0bced6
	ldx #$210e
rti_0bced9
	jsl retail_queueregister_l
rti_0bcedd
	plx
rti_0bcede
	xba
rti_0bcedf
	a8
rti_0bcee1
	i16
rti_0bcee3
	phx
rti_0bcee4
	ldx #$210e
rti_0bcee7
	jsl retail_queueregister_l
rti_0bceeb
	plx
rti_0bceec
	a16
rti_0bceee
	lda $20,x
rti_0bcef0
	clc
rti_0bcef1
	adc #$004d
rti_0bcef4
	sta $06,x
rti_0bcef6
	rts
rti_0bcef7
	lda #$0000
rti_0bcefa
	sec
rti_0bcefb
	sbc $20,x
rti_0bcefd
	a8
rti_0bceff
	xba
rti_0bcf00
	a8
rti_0bcf02
	i16
rti_0bcf04
	phx
rti_0bcf05
	ldx #$210e
rti_0bcf08
	jsl retail_queueregister_l
rti_0bcf0c
	plx
rti_0bcf0d
	xba
rti_0bcf0e
	a8
rti_0bcf10
	i16
rti_0bcf12
	phx
rti_0bcf13
	ldx #$210e
rti_0bcf16
	jsl retail_queueregister_l
rti_0bcf1a
	plx
rti_0bcf1b
	a16
rti_0bcf1d
	lda $20,x
rti_0bcf1f
	clc
rti_0bcf20
	adc #$004d
rti_0bcf23
	sta $06,x
rti_0bcf25
	rts
rti_logodrop
	jsl retail_stepentityanim_l
rti_0bcf2a
	lda $0a,x
rti_0bcf2c
	inc a
rti_0bcf2d
	and #$0001
rti_0bcf30
	sta $0a,x
rti_0bcf32
	bne rti_0bcf3c
rti_0bcf34
	lda $22,x
rti_0bcf36
	clc
rti_0bcf37
	adc #$0001
rti_0bcf3a
	sta $22,x
rti_0bcf3c
	lda $20,x
rti_0bcf3e
	clc
rti_0bcf3f
	adc $22,x
rti_0bcf41
	sta $20,x
rti_0bcf43
	lda $20,x
rti_0bcf45
	bmi rti_0bcf64
rti_0bcf47
	cmp #$00dc
rti_0bcf4a
	bcs rti_0bcf93
rti_0bcf4c
	cmp #$001e
rti_0bcf4f
	bcc rti_0bcf64
rti_0bcf51
	a8
rti_0bcf53
	lda #$20
rti_0bcf55
	a8
rti_0bcf57
	i16
rti_0bcf59
	phx
rti_0bcf5a
	ldx #$420c
rti_0bcf5d
	jsl retail_queueregister_l
rti_0bcf61
	plx
rti_0bcf62
	a16
rti_0bcf64
	lda #$0000
rti_0bcf67
	sec
rti_0bcf68
	sbc $20,x
rti_0bcf6a
	a8
rti_0bcf6c
	xba
rti_0bcf6d
	a8
rti_0bcf6f
	i16
rti_0bcf71
	phx
rti_0bcf72
	ldx #$210e
rti_0bcf75
	jsl retail_queueregister_l
rti_0bcf79
	plx
rti_0bcf7a
	xba
rti_0bcf7b
	a8
rti_0bcf7d
	i16
rti_0bcf7f
	phx
rti_0bcf80
	ldx #$210e
rti_0bcf83
	jsl retail_queueregister_l
rti_0bcf87
	plx
rti_0bcf88
	a16
rti_0bcf8a
	lda $20,x
rti_0bcf8c
	clc
rti_0bcf8d
	adc #$004d
rti_0bcf90
	sta $06,x
rti_0bcf92
	rts
rti_0bcf93
	ldx.w race_entitycurrent
rti_0bcf96
	lda #rhk_logoidle&WM
rti_0bcf99
	sta $08,x
rti_0bcf9b
	rts
rti_titlestart
	lda.w race_menuedges
rti_0bd028
	and #$9000
rti_0bd02b
	bne rti_0bd030
rti_0bd02d
	brl rti_0bd067
rti_0bd030
	lda #$0011
rti_0bd033
	ldy #$ffff
rti_0bd036
	jsl retail_entityvisibility_l
rti_0bd039
	lda #$0013
rti_0bd03c
	jsl retail_findentity_l
rti_0bd03f
	lda #rhk_logoaway&WM
rti_0bd042
	sta $08,x
rti_0bd044
	lda #$fff6
rti_0bd047
	sta $22,x
rti_0bd049
	ldx.w race_entitycurrent
rti_0bd04c
	lda #rhk_titlewait&WM
rti_0bd04f
	sta $08,x
rti_0bd051
	lda #$ffff
rti_0bd054
	sta $10,x
rti_0bd056
	a8
rti_0bd058
	lda #$46
rti_0bd05a
	jsl queue_raceplayer_l
rti_0bd05e
	a16
rti_0bd060
	rts
rti_0bd067
	rts
rti_titlewait
	lda #$0013
rti_0bd06b
	jsl retail_findentity_l
rti_0bd06e
	lda $08,x
rti_0bd070
	cmp #rhk_logoidle&WM
rti_0bd073
	bne rti_0bd07b
rti_0bd075
	ldx.w race_entitycurrent
rti_0bd078
	jsr rti_titleclose
rti_0bd07b
	rts
rti_titleclose
	a8
rti_0bd07e
	i16
rti_0bd080
	lda #$00
rti_0bd082
	a8
rti_0bd084
	i16
rti_0bd086
	phx
rti_0bd087
	ldx #$210e
rti_0bd08a
	jsl retail_queueregister_l
rti_0bd08e
	plx
rti_0bd08f
	a8
rti_0bd091
	i16
rti_0bd093
	phx
rti_0bd094
	ldx #$210e
rti_0bd097
	jsl retail_queueregister_l
rti_0bd09b
	plx
rti_0bd09c
	lda #$00
rti_0bd09e
	a8
rti_0bd0a0
	i16
rti_0bd0a2
	phx
rti_0bd0a3
	ldx #$420c
rti_0bd0a6
	jsl retail_queueregister_l
rti_0bd0aa
	plx
rti_0bd0ab
	a8
rti_0bd0ad
	i16
rti_0bd0af
	phx
rti_0bd0b0
	ldx #$212f
rti_0bd0b3
	jsl retail_queueregister_l
rti_0bd0b7
	plx
rti_0bd0b8
	a8
rti_0bd0ba
	i16
rti_0bd0bc
	phx
rti_0bd0bd
	ldx #$212e
rti_0bd0c0
	jsl retail_queueregister_l
rti_0bd0c4
	plx
rti_0bd0c5
	lda #$01
rti_0bd0c7
	a8
rti_0bd0c9
	i16
rti_0bd0cb
	phx
rti_0bd0cc
	ldx #$2131
rti_0bd0cf
	jsl retail_queueregister_l
rti_0bd0d3
	plx
rti_0bd0d4
	lda #$02
rti_0bd0d6
	a8
rti_0bd0d8
	i16
rti_0bd0da
	phx
rti_0bd0db
	ldx #$2130
rti_0bd0de
	jsl retail_queueregister_l
rti_0bd0e2
	plx
rti_0bd0e3
	a8
rti_0bd0e5
	i16
rti_0bd0e7
	phx
rti_0bd0e8
	ldx #$212d
rti_0bd0eb
	jsl retail_queueregister_l
rti_0bd0ef
	plx
rti_0bd0f0
	lda #$65
rti_0bd0f2
	a8
rti_0bd0f4
	i16
rti_0bd0f6
	phx
rti_0bd0f7
	ldx #$2108
rti_0bd0fa
	jsl retail_queueregister_l
rti_0bd0fe
	plx
rti_0bd0ff
	lda #$61
rti_0bd101
	a8
rti_0bd103
	i16
rti_0bd105
	phx
rti_0bd106
	ldx #$2107
rti_0bd109
	jsl retail_queueregister_l
rti_0bd10d
	plx
rti_0bd10e
	lda #$20
rti_0bd110
	a8
rti_0bd112
	i16
rti_0bd114
	phx
rti_0bd115
	ldx #$210b
rti_0bd118
	jsl retail_queueregister_l
rti_0bd11c
	plx
rti_0bd11d
	lda #$17
rti_0bd11f
	a8
rti_0bd121
	i16
rti_0bd123
	phx
rti_0bd124
	ldx #$212c
rti_0bd127
	jsl retail_queueregister_l
rti_0bd12b
	plx
rti_0bd12c
	a16
rti_0bd12e
	ldx.w race_entitycurrent
rti_0bd131
	lda #$0011
rti_0bd134
	ldy #$ffff
rti_0bd137
	jsl retail_entityvisibility_l
rti_0bd13a
	lda #$ffff
rti_0bd13d
	sta $10,x
rti_0bd13f
	lda #rhk_titlefade&WM
rti_0bd142
	sta $08,x
rti_0bd144
	lda #$0040
rti_0bd147
	sta $0a,x
rti_0bd149
	rts
rti_titlefade
	lda $0a,x
rti_0bd14c
	dec a
rti_0bd14d
	dec a
rti_0bd14e
	bmi rti_0bd17c
rti_0bd150
	sta $0a,x
rti_0bd152
	lsr a
rti_0bd153
	asl a
rti_0bd154
	tax
rti_0bd155
	lda.l retail_crossfadelevels,x
rti_0bd159
	sta.w race_oambits
rti_0bd15c
	ldy #$003f
rti_0bd15f
	ldx #$0080
rti_0bd162
	jsl retail_scalepalette_l
rti_0bd166
	lda.w race_oambits
rti_0bd169
	dec a
rti_0bd16a
	eor #$001f
rti_0bd16d
	inc a
rti_0bd16e
	sta.w race_oambits
rti_0bd171
	ldy #$0003
rti_0bd174
	ldx #$0018
rti_0bd177
	jsl retail_scalepalette_l
rti_0bd17b
	rts
rti_0bd17c
	a8
rti_0bd17e
	ai16
rti_0bd180
	lda #$0080
rti_0bd183
	sta.l race_transferbytes
rti_0bd187
	lda #retail_titlefont>>16
rti_0bd18a
	sta.l race_transferbank
rti_0bd18e
	lda #retail_titlefont&WM
rti_0bd191
	sta.l race_transfersource
rti_0bd195
	lda #$7000
rti_0bd198
	sta.l race_transferdest
rti_0bd19c
	jsl retail_queuegraphics_l
rti_0bd1a0
	a8
rti_0bd1a2
	i16
rti_0bd1a4
	lda #$70
rti_0bd1a6
	a8
rti_0bd1a8
	i16
rti_0bd1aa
	phx
rti_0bd1ab
	ldx #$210b
rti_0bd1ae
	jsl retail_queueregister_l
rti_0bd1b2
	plx
rti_0bd1b3
	lda #$7d
rti_0bd1b5
	a8
rti_0bd1b7
	i16
rti_0bd1b9
	phx
rti_0bd1ba
	ldx #$2108
rti_0bd1bd
	jsl retail_queueregister_l
rti_0bd1c1
	plx
rti_0bd1c2
	lda #$03
rti_0bd1c4
	a8
rti_0bd1c6
	i16
rti_0bd1c8
	phx
rti_0bd1c9
	ldx #$2105
rti_0bd1cc
	jsl retail_queueregister_l
rti_0bd1d0
	plx
rti_0bd1d1
	lda #$02
rti_0bd1d3
	a8
rti_0bd1d5
	i16
rti_0bd1d7
	phx
rti_0bd1d8
	ldx #$212c
rti_0bd1db
	jsl retail_queueregister_l
rti_0bd1df
	plx
rti_0bd1e0
	lda #$00
rti_0bd1e2
	a8
rti_0bd1e4
	i16
rti_0bd1e6
	phx
rti_0bd1e7
	ldx #$420c
rti_0bd1ea
	jsl retail_queueregister_l
rti_0bd1ee
	plx
rti_0bd1ef
	ai16
rti_0bd1f1
	lda #rhk_loadobjects&WM
rti_0bd1f4
	sta $08,x
rti_0bd1f6
	rts
rti_titleinput
	dec $1e,x
rti_0bd5fc
	bmi rti_0bd5ff
rti_0bd5fe
	rts
rti_0bd5ff
	lda #rhk_titlekeys&WM
rti_0bd602
	sta $08,x
rti_0bd604
	stz $0a,x
rti_titlekeys
	jsl retail_stepentityanim_l
rti_0bd609
	lda.w race_menuedges
rti_0bd60c
	beq rti_0bd66c
rti_0bd60e
	and #$0800
rti_0bd611
	beq rti_0bd61c
rti_0bd613
	stz $0a,x
rti_0bd615
	lda #$0000
rti_0bd618
	sta.l race_titlesequence
rti_0bd61c
	lda.w race_menuedges
rti_0bd61f
	lda $0a,x
rti_0bd621
	asl a
rti_0bd622
	tax
rti_0bd623
	lda.l retail_titlekeys,x
rti_0bd627
	sta.w race_oambits
rti_0bd62a
	ldx.w race_entitycurrent
rti_0bd62d
	lda.w race_menuedges
rti_0bd630
	and.w race_oambits
rti_0bd633
	bne rti_0bd63b
rti_0bd635
	stz $0a,x
rti_0bd637
	jsr rti_titlestart
rti_0bd63a
	rts
rti_0bd63b
	stz.w race_menuedges
rti_0bd63e
	lda $0a,x
rti_0bd640
	inc a
rti_0bd641
	sta $0a,x
rti_0bd643
	cmp #$0008
rti_0bd646
	bne rti_0bd66c
rti_0bd648
	jsr rti_confirmwindow
rti_0bd64b
	a8
rti_0bd64d
	lda #$46
rti_0bd64f
	jsl queue_raceplayer_l
rti_0bd653
	a16
rti_0bd655
	lda #rhk_titleconfirm&WM
rti_0bd658
	sta $08,x
rti_0bd65a
	stz $0a,x
rti_0bd65c
	lda $14,x
rti_0bd65e
	cmp #$0152
rti_0bd661
	beq rti_0bd66c
rti_0bd663
	lda #$0152
rti_0bd666
	sta $14,x
rti_0bd668
	stz $16,x
rti_0bd66a
	stz $18,x
rti_0bd66c
	rts
rti_confirmwindow
	a8
rti_0bd67f
	lda #$50
rti_0bd681
	a8
rti_0bd683
	i16
rti_0bd685
	phx
rti_0bd686
	ldx #$420c
rti_0bd689
	jsl retail_queueregister_l
rti_0bd68d
	plx
rti_0bd68e
	lda #$07
rti_0bd690
	a8
rti_0bd692
	i16
rti_0bd694
	phx
rti_0bd695
	ldx #$212f
rti_0bd698
	jsl retail_queueregister_l
rti_0bd69c
	plx
rti_0bd69d
	lda #$ff
rti_0bd69f
	a8
rti_0bd6a1
	i16
rti_0bd6a3
	phx
rti_0bd6a4
	ldx #$2132
rti_0bd6a7
	jsl retail_queueregister_l
rti_0bd6ab
	plx
rti_0bd6ac
	lda #$a7
rti_0bd6ae
	a8
rti_0bd6b0
	i16
rti_0bd6b2
	phx
rti_0bd6b3
	ldx #$2131
rti_0bd6b6
	jsl retail_queueregister_l
rti_0bd6ba
	plx
rti_0bd6bb
	lda #$20
rti_0bd6bd
	a8
rti_0bd6bf
	i16
rti_0bd6c1
	phx
rti_0bd6c2
	ldx #$2130
rti_0bd6c5
	jsl retail_queueregister_l
rti_0bd6c9
	plx
rti_0bd6ca
	lda #$00
rti_0bd6cc
	a8
rti_0bd6ce
	i16
rti_0bd6d0
	phx
rti_0bd6d1
	ldx #$2123
rti_0bd6d4
	jsl retail_queueregister_l
rti_0bd6d8
	plx
rti_0bd6d9
	a8
rti_0bd6db
	i16
rti_0bd6dd
	phx
rti_0bd6de
	ldx #$2124
rti_0bd6e1
	jsl retail_queueregister_l
rti_0bd6e5
	plx
rti_0bd6e6
	lda #$30
rti_0bd6e8
	a8
rti_0bd6ea
	i16
rti_0bd6ec
	phx
rti_0bd6ed
	ldx #$2125
rti_0bd6f0
	jsl retail_queueregister_l
rti_0bd6f4
	plx
rti_0bd6f5
	a16
rti_0bd6f7
	rts
rti_cancelwindow
	a8
rti_0bd6fa
	lda #$10
rti_0bd6fc
	a8
rti_0bd6fe
	i16
rti_0bd700
	phx
rti_0bd701
	ldx #$420c
rti_0bd704
	jsl retail_queueregister_l
rti_0bd708
	plx
rti_0bd709
	lda #$00
rti_0bd70b
	a8
rti_0bd70d
	i16
rti_0bd70f
	phx
rti_0bd710
	ldx #$212f
rti_0bd713
	jsl retail_queueregister_l
rti_0bd717
	plx
rti_0bd718
	a16
rti_0bd71a
	rts
rti_titleconfirm
	jsl retail_stepentityanim_l
rti_0bd71e
	lda.w race_menuedges
rti_0bd721
	and #$0200
rti_0bd724
	beq rti_0bd749
rti_0bd726
	lda $0a,x
rti_0bd728
	bne rti_0bd749
rti_0bd72a
	lda #$0001
rti_0bd72d
	sta $0a,x
rti_0bd72f
	lda $14,x
rti_0bd731
	cmp #$0148
rti_0bd734
	beq rti_0bd73f
rti_0bd736
	lda #$0148
rti_0bd739
	sta $14,x
rti_0bd73b
	stz $16,x
rti_0bd73d
	stz $18,x
rti_0bd73f
	a8
rti_0bd741
	lda #$45
rti_0bd743
	jsl queue_raceplayer_l
rti_0bd747
	a16
rti_0bd749
	lda.w race_menuedges
rti_0bd74c
	and #$0100
rti_0bd74f
	beq rti_0bd771
rti_0bd751
	lda $0a,x
rti_0bd753
	beq rti_0bd771
rti_0bd755
	a8
rti_0bd757
	lda #$45
rti_0bd759
	jsl queue_raceplayer_l
rti_0bd75d
	a16
rti_0bd75f
	stz $0a,x
rti_0bd761
	lda $14,x
rti_0bd763
	cmp #$0152
rti_0bd766
	beq rti_0bd771
rti_0bd768
	lda #$0152
rti_0bd76b
	sta $14,x
rti_0bd76d
	stz $16,x
rti_0bd76f
	stz $18,x
rti_0bd771
	lda.w race_menuedges
rti_0bd774
	and #$8000
rti_0bd777
	beq rti_0bd79e
rti_0bd779
	lda $0a,x
rti_0bd77b
	beq rti_0bd79f
rti_0bd77d
	lda $14,x
rti_0bd77f
	cmp #$0166
rti_0bd782
	beq rti_0bd78d
rti_0bd784
	lda #$0166
rti_0bd787
	sta $14,x
rti_0bd789
	stz $16,x
rti_0bd78b
	stz $18,x
rti_0bd78d
	lda #rhk_titleerase&WM
rti_0bd790
	sta $08,x
rti_0bd792
	stz $0a,x
rti_0bd794
	a8
rti_0bd796
	lda #$46
rti_0bd798
	jsl queue_raceplayer_l
rti_0bd79c
	a16
rti_0bd79e
	rts
rti_0bd79f
	lda #rhk_titlekeys&WM
rti_0bd7a2
	sta $08,x
rti_0bd7a4
	jsr rti_cancelwindow
rti_0bd7a7
	a8
rti_0bd7a9
	lda #$47
rti_0bd7ab
	jsl queue_raceplayer_l
rti_0bd7af
	a16
rti_0bd7b1
	lda $14,x
rti_0bd7b3
	cmp #$0002
rti_0bd7b6
	beq rti_0bd7c1
rti_0bd7b8
	lda #$0002
rti_0bd7bb
	sta $14,x
rti_0bd7bd
	stz $16,x
rti_0bd7bf
	stz $18,x
rti_0bd7c1
	rts
rti_titleerase
	jsl retail_stepentityanim_l
rti_0bd7c5
	lda.w race_menuedges
rti_0bd7c8
	and #$0200
rti_0bd7cb
	beq rti_0bd7f0
rti_0bd7cd
	lda $0a,x
rti_0bd7cf
	bne rti_0bd7f0
rti_0bd7d1
	lda #$0001
rti_0bd7d4
	sta $0a,x
rti_0bd7d6
	lda $14,x
rti_0bd7d8
	cmp #$015c
rti_0bd7db
	beq rti_0bd7e6
rti_0bd7dd
	lda #$015c
rti_0bd7e0
	sta $14,x
rti_0bd7e2
	stz $16,x
rti_0bd7e4
	stz $18,x
rti_0bd7e6
	a8
rti_0bd7e8
	lda #$45
rti_0bd7ea
	jsl queue_raceplayer_l
rti_0bd7ee
	a16
rti_0bd7f0
	lda.w race_menuedges
rti_0bd7f3
	and #$0100
rti_0bd7f6
	beq rti_0bd818
rti_0bd7f8
	lda $0a,x
rti_0bd7fa
	beq rti_0bd818
rti_0bd7fc
	stz $0a,x
rti_0bd7fe
	lda $14,x
rti_0bd800
	cmp #$0166
rti_0bd803
	beq rti_0bd80e
rti_0bd805
	lda #$0166
rti_0bd808
	sta $14,x
rti_0bd80a
	stz $16,x
rti_0bd80c
	stz $18,x
rti_0bd80e
	a8
rti_0bd810
	lda #$45
rti_0bd812
	jsl queue_raceplayer_l
rti_0bd816
	a16
rti_0bd818
	lda.w race_menuedges
rti_0bd81b
	and #$8000
rti_0bd81e
	beq rti_0bd84e
rti_0bd820
	lda $0a,x
rti_0bd822
	beq rti_0bd84f
rti_0bd824
	jsr rti_eraserecords
rti_0bd827
	ldx.w race_entitycurrent
rti_0bd82a
	lda $14,x
rti_0bd82c
	cmp #$0170
rti_0bd82f
	beq rti_0bd83a
rti_0bd831
	lda #$0170
rti_0bd834
	sta $14,x
rti_0bd836
	stz $16,x
rti_0bd838
	stz $18,x
rti_0bd83a
	a8
rti_0bd83c
	lda #$36
rti_0bd83e
	jsl queue_raceplayer_l
rti_0bd842
	a16
rti_0bd844
	lda #rhk_titleerased&WM
rti_0bd847
	sta $08,x
rti_0bd849
	lda #$0040
rti_0bd84c
	sta $0a,x
rti_0bd84e
	rts
rti_0bd84f
	lda #rhk_titlekeys&WM
rti_0bd852
	sta $08,x
rti_0bd854
	jsr rti_cancelwindow
rti_0bd857
	a8
rti_0bd859
	lda #$47
rti_0bd85b
	jsl queue_raceplayer_l
rti_0bd85f
	a16
rti_0bd861
	lda $14,x
rti_0bd863
	cmp #$0002
rti_0bd866
	beq rti_0bd871
rti_0bd868
	lda #$0002
rti_0bd86b
	sta $14,x
rti_0bd86d
	stz $16,x
rti_0bd86f
	stz $18,x
rti_0bd871
	rts
rti_titleerased
	jsl retail_stepentityanim_l
rti_0bd875
	dec $0a,x
rti_0bd877
	bpl rti_0bd891
rti_0bd879
	lda #rhk_titlekeys&WM
rti_0bd87c
	sta $08,x
rti_0bd87e
	jsr rti_cancelwindow
rti_0bd881
	lda $14,x
rti_0bd883
	cmp #$0002
rti_0bd886
	beq rti_0bd891
rti_0bd888
	lda #$0002
rti_0bd88b
	sta $14,x
rti_0bd88d
	stz $16,x
rti_0bd88f
	stz $18,x
rti_0bd891
	rts
rti_eraserecords
	ldx #$0000
rti_0bd895
	lda #$0000
rti_0bd898
	sta.l race_recordimage,x
rti_0bd89c
	inx
rti_0bd89d
	inx
rti_0bd89e
	cpx #$0400
rti_0bd8a1
	bne rti_0bd898
rti_0bd8a3
	jsl rti_checksave
rti_0bd8a7
	rts
retail_checksave_l equ rti_checksave
retail_sumsettings_l equ rti_sumsettings
retail_sumscore_l
	jsr rti_sumscore
	rtl
retail_sumtime_l
	jsr rti_sumtime
	rtl
retail_checkrecords_l equ rti_checkrecords
retail_checktimes_l
	jsr rti_checktimes
	rtl
retail_checkscores_l
	jsr rti_checkscores
	rtl
retail_checknames_l
	jsr rti_checknames
	rtl
retail_checkspecial_l
	jsr rti_checkspecial
	rtl
retail_checkcourses_l
	jsr rti_checkcourses
	rtl
retail_logoaway_l
	jsr rti_logoaway
	rtl
retail_logodrop_l
	jsr rti_logodrop
	rtl
retail_titlestart_l
	jsr rti_titlestart
	rtl
retail_titlewait_l
	jsr rti_titlewait
	rtl
retail_titleclose_l
	jsr rti_titleclose
	rtl
retail_titlefade_l
	jsr rti_titlefade
	rtl
retail_titleinput_l
	jsr rti_titleinput
	rtl
retail_titlekeys_l
	jsr rti_titlekeys
	rtl
retail_confirmwindow_l
	jsr rti_confirmwindow
	rtl
retail_cancelwindow_l
	jsr rti_cancelwindow
	rtl
retail_titleconfirm_l
	jsr rti_titleconfirm
	rtl
retail_titleerase_l
	jsr rti_titleerase
	rtl
retail_titleerased_l
	jsr rti_titleerased
	rtl
retail_eraserecords_l
	jsr rti_eraserecords
	rtl
rtt_logoaway
	jsr rti_logoaway
	rtl
rtt_logodrop
	jsr rti_logodrop
	rtl
rtt_titlestart
	jsr rti_titlestart
	rtl
rtt_titlewait
	jsr rti_titlewait
	rtl
rtt_titlefade
	jsr rti_titlefade
	rtl
rtt_titleinput
	jsr rti_titleinput
	rtl
rtt_titlekeys
	jsr rti_titlekeys
	rtl
rtt_titleconfirm
	jsr rti_titleconfirm
	rtl
rtt_titleerase
	jsr rti_titleerase
	rtl
rtt_titleerased
	jsr rti_titleerased
	rtl
	longa
	longi
rti_publishrecords
	php
	ai16
	pha
	phx
	ldx #0
rti_publishloop
	lda.l race_recordimage,x
	sta.l race_menurecords,x
	inx
	inx
	cpx #512
	bne rti_publishloop
	plx
	pla
	plp
	rts
retail_titlefont
	dw $ff01
	dw $fe03
	dw $fc07
	dw $f80f
	dw $f01f
	dw $e03f
	dw $c07f
	dw $80ff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $7f80
	dw $3fc0
	dw $1fe0
	dw $0ff0
	dw $07f8
	dw $03fc
	dw $01fe
	dw $00ff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $00ff
	dw $807f
	dw $c03f
	dw $e01f
	dw $f00f
	dw $f807
	dw $fc03
	dw $fe01
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $00fe
	dw $01fc
	dw $03f8
	dw $07f0
	dw $0fe0
	dw $1fc0
	dw $3f80
	dw $7f00
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
	dw $ffff
retail_titlefont_end
retail_titlekeys
	dw $0800
	dw $0200
	dw $0400
	dw $0100
	dw $0040
	dw $4000
	dw $8000
	dw $0080
retail_titlekeys_end
retail_nameblocks
	dw $0900
	dw $0012
	dw $3018
retail_nameblocks_end
mrtitle_end
