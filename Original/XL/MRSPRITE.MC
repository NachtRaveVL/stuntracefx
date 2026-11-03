; Retail scaled sprites, reflection and projected sprite submission.
; The original MDSPRITE entry points remain available. These routines use
; the retail material decoder and caller-bound 256-byte texture rows.
; mretail_sprite32 and mretail_usprite are STOP tasks; sprite32 draws an
; unclipped 32x32 block at (m_xc-16,m_yc-16). usprite uses m_spra/mspr_pal
; and m_sprsize/m_sprxscale. Both require a bound texture identity 0..199.
; mretail_ssprite and mretail_sprscale are R11-returning calls with R10
; on the existing software stack, RAM bank 0. sprscale takes R1=output
; size (also in m_sprxscale), m_sprsize=source side, m_sprx/m_spry=centre
; and bound pixel data.
; Scaled dimensions are 1..255; clip limits are m_xright/m_ybot.
; m_sprmask bit 15 reflects horizontally. No pixel payload is restored.
; mretail_sprproject takes R1/R2/R3=X/Y/positive Z, R5=size. It halves
; distant coordinates before doubling near ones, preserving 16-bit wraps.
; The inherited depth table ends at $4300; its exact retail extension
; is selected for $4300..$4400 without shifting old data or public values.
; Pixel cache flushing belongs to the caller of the returning routines.
; This does not install a render-list, shape interpreter or frame owner.
mrsprite_begin
mretail_sprite32
rsp_b027
	ibt r0,#$03
rsp_b029
	romb
rsp_b02b
	sub r0
rsp_b02c
	cmode
rsp_b02e
	ibt r1,#$10
rsp_b030
	lms r0,[mspr_pal]
rsp_b033
	mult r1
rsp_b034
	colour
rsp_b035
	iwt r2,#$0020
rsp_b038
	lms r1,[m_spra]
rsp_b03b
	from r1
rsp_b03c
	lob
rsp_b03d
	and r2
rsp_b03e
	beq rsp_b043
rsp_b040
	nop
rsp_b041
	ibt r0,#$04
rsp_b043
	or #8
rsp_b045
	cmode
rsp_b047
	from r1
rsp_b048
	umult #3
rsp_b04a
	iwt r1,#retail_texturedefs&WM
rsp_b04d
	to r14
rsp_b04e
	add r1
rsp_b04f
	getb
rsp_b050
	inc r14
rsp_b051
	getbh
rsp_b053
	inc r14
rsp_b054
	to r1
rsp_b055
	getb
rsp_b056
	from r1
rsp_b057
	romb
rsp_b059
	with r0
rsp_b05a
	to r14
rsp_b05b
	ibt r0,#-16
rsp_b05d
	lms r1,[m_xc]
rsp_b060
	to r1
rsp_b061
	add r1
rsp_b062
	lms r2,[m_yc]
rsp_b065
	to r2
rsp_b066
	add r2
rsp_b067
	with r1
rsp_b068
	to r9
rsp_b069
	iwt r11,#$0020
rsp_b06c
	iwt r10,#$00e0
rsp_b06f
	iwt r7,#rsp_b079&WM
rsp_b072
	ibt r8,#$20
rsp_b074
	cache
rsp_b075
	with r8
rsp_b076
	to r12
rsp_b077
	with r15
rsp_b078
	to r13
rsp_b079
	getc
rsp_b07a
	inc r14
rsp_b07b
	loop
rsp_b07c
	plot
rsp_b07d
	nop
rsp_b07e
	with r14
rsp_b07f
	add r10
rsp_b080
	with r9
rsp_b081
	to r1
rsp_b082
	dec r11
rsp_b083
	bne rsp_b075
rsp_b085
	inc r2
rsp_b086
	rpix
rsp_b088
	stop
rsp_b089
	nop
mretail_usprite
rsp_b08a
	iwt r10,#m_stack&WM
rsp_b08d
	ibt r0,#$03
rsp_b08f
	romb
rsp_b091
	sub r0
rsp_b092
	cmode
rsp_b094
	lms r0,[m_xc]
rsp_b097
	sms [m_sprx],r0
rsp_b09a
	lms r0,[m_yc]
rsp_b09d
	sms [m_spry],r0
rsp_b0a0
	ibt r1,#$10
rsp_b0a2
	lms r0,[mspr_pal]
rsp_b0a5
	mult r1
rsp_b0a6
	colour
rsp_b0a7
	iwt r2,#$0020
rsp_b0aa
	lms r1,[m_spra]
rsp_b0ad
	from r1
rsp_b0ae
	lob
rsp_b0af
	and r2
rsp_b0b0
	beq rsp_b0b5
rsp_b0b2
	nop
rsp_b0b3
	ibt r0,#$04
rsp_b0b5
	or #8
rsp_b0b7
	cmode
rsp_b0b9
	from r1
rsp_b0ba
	umult #3
rsp_b0bc
	iwt r1,#retail_texturedefs&WM
rsp_b0bf
	to r14
rsp_b0c0
	add r1
rsp_b0c1
	getb
rsp_b0c2
	inc r14
rsp_b0c3
	getbh
rsp_b0c5
	inc r14
rsp_b0c6
	sms [m_sprdata],r0
rsp_b0c9
	getb
rsp_b0ca
	sms [m_sprbank],r0
rsp_b0cd
	lms r1,[m_sprxscale]
rsp_b0d0
	link #4
rsp_b0d1
	iwt r15,#rsp_b17d&WM
rsp_b0d4
	nop
rsp_b0d5
	rpix
rsp_b0d7
	stop
rsp_b0d8
	nop
mretail_ssprite
rsp_b0d9
	from r11
rsp_b0da
	stw [r10]
rsp_b0db
	inc r10
rsp_b0dc
	inc r10
rsp_b0dd
	lms r3,[m_bigz]
rsp_b0e0
	iwt r0,#$0080
rsp_b0e3
	sub r3
rsp_b0e4
	bpl rsp_b123
rsp_b0e6
	nop
rsp_b0e7
	lms r0,[m_sprxscale]
rsp_b0ea
	with r1
rsp_b0eb
	from r0
rsp_b0ec
	bmi rsp_b128
rsp_b0ee
	nop
rsp_b0ef
	cache
rsp_b0f0
	lms r12,[m_shift]
rsp_b0f3
	with r12
rsp_b0f4
	from r12
rsp_b0f5
	beq rsp_b100
rsp_b0f7
	nop
rsp_b0f8
	with r1
rsp_b0f9
	to r0
rsp_b0fa
	with r15
rsp_b0fb
	to r13
rsp_b0fc
	loop
rsp_b0fd
	add r0
rsp_b0fe
	with r0
rsp_b0ff
	to r1
rsp_b100
	lms r0,[m_spra]
rsp_b103
	add r0
rsp_b104
	to r1
rsp_b105
	add r1
rsp_b106
	bne rsp_b10b
rsp_b108
	nop
rsp_b109
	ibt r1,#$01
rsp_b10b
	with r1
rsp_b10c
	to r5
rsp_b10d
	lms r1,[m_bigx]
rsp_b110
	lms r2,[m_bigy]
rsp_b113
	link #4
rsp_b114
	iwt r15,#rsp_b2a4&WM
rsp_b117
	nop
rsp_b118
	sms [m_sprx],r1
rsp_b11b
	sms [m_spry],r2
rsp_b11e
	with r1
rsp_b11f
	from r5
rsp_b120
	bne rsp_b14c
rsp_b122
	nop
rsp_b123
	dec r10
rsp_b124
	dec r10
rsp_b125
	to r15
rsp_b126
	ldw [r10]
rsp_b127
	nop
rsp_b128
	from r1
rsp_b129
	stw [r10]
rsp_b12a
	inc r10
rsp_b12b
	inc r10
rsp_b12c
	lms r1,[m_bigx]
rsp_b12f
	lms r2,[m_bigy]
rsp_b132
	link #4
rsp_b133
	iwt r15,#rsp_b2a4&WM
rsp_b136
	nop
rsp_b137
	sms [m_sprx],r1
rsp_b13a
	sms [m_spry],r2
rsp_b13d
	dec r10
rsp_b13e
	dec r10
rsp_b13f
	to r1
rsp_b140
	ldw [r10]
rsp_b141
	with r1
rsp_b142
	not
rsp_b143
	inc r1
rsp_b144
	bne rsp_b14c
rsp_b146
	nop
rsp_b147
	dec r10
rsp_b148
	dec r10
rsp_b149
	to r15
rsp_b14a
	ldw [r10]
rsp_b14b
	nop
rsp_b14c
	iwt r0,#$00f0
rsp_b14f
	sub r1
rsp_b150
	bpl rsp_b155
rsp_b152
	add r1
rsp_b153
	with r0
rsp_b154
	to r1
rsp_b155
	sms [m_sprxscale],r1
rsp_b158
	lms r0,[m_spr0]
rsp_b15b
	link #4
rsp_b15c
	iwt r15,#mretail_material&WM
rsp_b15f
	nop
rsp_b160
	lms r0,[m_texturemap]
rsp_b163
	with r0
rsp_b164
	from r0
rsp_b165
	beq rsp_b123
rsp_b167
	nop
rsp_b168
	lms r1,[m_sprxscale]
rsp_b16b
	lms r0,[m_sprmask]
rsp_b16e
	lob
rsp_b16f
	inc r0
rsp_b170
	sms [m_sprsize],r0
rsp_b173
	lms r0,[m_tcmodecol]
rsp_b176
	colour
rsp_b177
	swap
rsp_b178
	cmode
rsp_b17a
	bra rsp_b182
rsp_b17c
	nop
mretail_sprscale
rsp_b17d
	from r11
rsp_b17e
	stw [r10]
rsp_b17f
	inc r10
rsp_b180
	inc r10
rsp_b181
	cache
rsp_b182
	from r1
rsp_b183
	to r3
rsp_b184
	not
rsp_b185
	inc r3
rsp_b186
	sms [m_clipleft],r3
rsp_b189
	lms r3,[m_xright]
rsp_b18c
	with r3
rsp_b18d
	sub r1
rsp_b18e
	sms [m_clipright],r3
rsp_b191
	ibt r3,#-1
rsp_b193
	from r1
rsp_b194
	lsr
rsp_b195
	sbc r3
rsp_b197
	lms r3,[m_sprx]
rsp_b19a
	from r3
rsp_b19b
	sub r0
rsp_b19c
	sbk
rsp_b19d
	lms r3,[m_clipleft]
rsp_b1a0
	inc r3
rsp_b1a1
	cmp r3
rsp_b1a3
	bpl rsp_b1ab
rsp_b1a5
	nop
rsp_b1a6
	dec r10
rsp_b1a7
	dec r10
rsp_b1a8
	to r15
rsp_b1a9
	ldw [r10]
rsp_b1aa
	nop
rsp_b1ab
	lms r3,[m_xright]
rsp_b1ae
	cmp r3
rsp_b1b0
	bpl rsp_b1a6
rsp_b1b2
	nop
rsp_b1b3
	ibt r3,#-1
rsp_b1b5
	from r1
rsp_b1b6
	lsr
rsp_b1b7
	sbc r3
rsp_b1b9
	lms r3,[m_spry]
rsp_b1bc
	from r3
rsp_b1bd
	sub r0
rsp_b1be
	sbk
rsp_b1bf
	lms r6,[m_sprsize]
rsp_b1c2
	from r1
rsp_b1c3
	sub r6
rsp_b1c4
	bcc rsp_b1cb
rsp_b1c6
	nop
rsp_b1c7
	iwt r15,#rsp_b2ed&WM
rsp_b1ca
	nop
rsp_b1cb
	with r6
rsp_b1cc
	to r4
rsp_b1cd
	ibt r0,#$00
rsp_b1cf
	romb
rsp_b1d1
	iwt r0,#reciptab16s&WM
rsp_b1d4
	add r1
rsp_b1d5
	to r14
rsp_b1d6
	add r1
rsp_b1d7
	to r6
rsp_b1d8
	getb
rsp_b1d9
	inc r14
rsp_b1da
	with r6
rsp_b1db
	getbh
rsp_b1dd
	from r4
rsp_b1de
	swap
rsp_b1df
	fmult
rsp_b1e0
	to r9
rsp_b1e1
	rol
rsp_b1e2
	cache
rsp_b1e3
	lms r2,[m_spry]
rsp_b1e6
	ibt r7,#$00
rsp_b1e8
	with r7
rsp_b1e9
	to r8
rsp_b1ea
	lms r4,[m_sprxscale]
rsp_b1ed
	with r4
rsp_b1ee
	to r6
rsp_b1ef
	lms r0,[m_sprbank]
rsp_b1f2
	romb
rsp_b1f4
	lms r5,[m_sprdata]
rsp_b1f7
	lms r3,[m_sprx]
rsp_b1fa
	lms r0,[m_sprmask]
rsp_b1fd
	with r0
rsp_b1fe
	from r0
rsp_b1ff
	bpl rsp_b206
rsp_b201
	nop
rsp_b202
	iwt r15,#rsp_b251&WM
rsp_b205
	nop
rsp_b206
	with r3
rsp_b207
	from r3
rsp_b208
	bpl rsp_b220
rsp_b20a
	nop
rsp_b20b
	with r6
rsp_b20c
	to r12
rsp_b20d
	with r15
rsp_b20e
	to r13
rsp_b20f
	bpl rsp_b21b
rsp_b211
	nop
rsp_b212
	with r8
rsp_b213
	add r9
rsp_b214
	loop
rsp_b215
	inc r3
rsp_b216
	dec r10
rsp_b217
	dec r10
rsp_b218
	to r15
rsp_b219
	ldw [r10]
rsp_b21a
	nop
rsp_b21b
	with r12
rsp_b21c
	to r6
rsp_b21d
	merge
rsp_b21e
	to r5
rsp_b21f
	add r5
rsp_b220
	lms r0,[m_clipright]
rsp_b223
	sub r3
rsp_b224
	bpl rsp_b22a
rsp_b226
	nop
rsp_b227
	with r6
rsp_b228
	add r0
rsp_b229
	inc r6
rsp_b22a
	iwt r13,#rsp_b23e&WM
rsp_b22d
	lms r0,[m_ybot]
rsp_b230
	dec r0
rsp_b231
	sub r2
rsp_b232
	bcc rsp_b246
rsp_b234
	nop
rsp_b235
	ibt r8,#$00
rsp_b237
	merge
rsp_b238
	to r14
rsp_b239
	add r5
rsp_b23a
	with r3
rsp_b23b
	to r1
rsp_b23c
	with r6
rsp_b23d
	to r12
rsp_b23e
	with r8
rsp_b23f
	add r9
rsp_b240
	merge
rsp_b241
	getc
rsp_b242
	to r14
rsp_b243
	add r5
rsp_b244
	loop
rsp_b245
	plot
rsp_b246
	with r7
rsp_b247
	add r9
rsp_b248
	dec r4
rsp_b249
	bne rsp_b22d
rsp_b24b
	inc r2
rsp_b24c
	dec r10
rsp_b24d
	dec r10
rsp_b24e
	to r15
rsp_b24f
	ldw [r10]
rsp_b250
	nop
rsp_b251
	lms r0,[m_sprsize]
rsp_b254
	with r5
rsp_b255
	add r0
rsp_b256
	dec r5
rsp_b257
	with r3
rsp_b258
	from r3
rsp_b259
	bpl rsp_b271
rsp_b25b
	nop
rsp_b25c
	with r6
rsp_b25d
	to r12
rsp_b25e
	with r15
rsp_b25f
	to r13
rsp_b260
	bpl rsp_b26c
rsp_b262
	nop
rsp_b263
	with r8
rsp_b264
	sub r9
rsp_b265
	loop
rsp_b266
	inc r3
rsp_b267
	dec r10
rsp_b268
	dec r10
rsp_b269
	to r15
rsp_b26a
	ldw [r10]
rsp_b26b
	nop
rsp_b26c
	with r12
rsp_b26d
	to r6
rsp_b26e
	merge
rsp_b26f
	to r5
rsp_b270
	add r5
rsp_b271
	with r3
rsp_b272
	to r1
rsp_b273
	lms r0,[m_clipright]
rsp_b276
	sub r1
rsp_b277
	bpl rsp_b27d
rsp_b279
	nop
rsp_b27a
	with r6
rsp_b27b
	add r0
rsp_b27c
	inc r6
rsp_b27d
	iwt r13,#rsp_b291&WM
rsp_b280
	lms r0,[m_ybot]
rsp_b283
	dec r0
rsp_b284
	sub r2
rsp_b285
	bcc rsp_b299
rsp_b287
	nop
rsp_b288
	ibt r8,#$00
rsp_b28a
	merge
rsp_b28b
	to r14
rsp_b28c
	add r5
rsp_b28d
	with r3
rsp_b28e
	to r1
rsp_b28f
	with r6
rsp_b290
	to r12
rsp_b291
	with r8
rsp_b292
	sub r9
rsp_b293
	merge
rsp_b294
	getc
rsp_b295
	to r14
rsp_b296
	add r5
rsp_b297
	loop
rsp_b298
	plot
rsp_b299
	with r7
rsp_b29a
	add r9
rsp_b29b
	dec r4
rsp_b29c
	bne rsp_b280
rsp_b29e
	inc r2
rsp_b29f
	dec r10
rsp_b2a0
	dec r10
rsp_b2a1
	to r15
rsp_b2a2
	ldw [r10]
rsp_b2a3
	nop
mretail_sprproject
rsp_b2a4
	ibt r0,#$14
rsp_b2a6
	romb
rsp_b2a8
	iwt r0,#$4400
rsp_b2ab
	sub r3
rsp_b2ac
	bpl rsp_b2b9
rsp_b2ae
	nop
rsp_b2af
	with r1
rsp_b2b0
	asr
rsp_b2b1
	with r2
rsp_b2b2
	asr
rsp_b2b3
	with r5
rsp_b2b4
	asr
rsp_b2b5
	with r3
rsp_b2b6
	bra rsp_b2a8
rsp_b2b8
	asr
rsp_b2b9
	iwt r0,#$0100
rsp_b2bc
	sub r3
rsp_b2bd
	bmi rsp_b2ca
rsp_b2bf
	nop
rsp_b2c0
	with r5
rsp_b2c1
	add r5
rsp_b2c2
	with r1
rsp_b2c3
	add r1
rsp_b2c4
	with r2
rsp_b2c5
	add r2
rsp_b2c6
	with r3
rsp_b2c7
	bra rsp_b2b9
rsp_b2c9
	add r3
rsp_b2ca
	with r3
rsp_b2cb
	bic #1
rsp_b2cd
	iwt r0,#ztab&WM
; R6 is replaced by the fetched reciprocal below.
	iwt r6,#$4300
	from r3
	cmp r6
	blt rsp_ztprefix
	nop
	ibt r0,#retail_spriteztail>>16
	romb
	iwt r0,#(retail_spriteztail-$4300)&WM
rsp_ztprefix
rsp_b2d0
	to r14
rsp_b2d1
	add r3
rsp_b2d2
	to r6
rsp_b2d3
	getb
rsp_b2d4
	inc r14
rsp_b2d5
	with r6
rsp_b2d6
	getbh
	ibt r0,#ztab>>16
	romb
rsp_b2d8
	from r1
rsp_b2d9
	fmult
rsp_b2da
	lms r1,[m_vanishx]
rsp_b2dd
	with r1
rsp_b2de
	add r0
rsp_b2df
	from r2
rsp_b2e0
	fmult
rsp_b2e1
	lms r2,[m_vanishy]
rsp_b2e4
	with r2
rsp_b2e5
	add r0
rsp_b2e6
	from r5
rsp_b2e7
	fmult
rsp_b2e8
	to r5
rsp_b2e9
	with r0
rsp_b2ea
	to r5
rsp_b2eb
	jmp r11
rsp_b2ec
	nop
rsp_b2ed
	with r6
rsp_b2ee
	to r0
rsp_b2ef
	with r1
rsp_b2f0
	to r6
rsp_b2f1
	cmp r6
rsp_b2f3
	bne rsp_b2fc
rsp_b2f5
	nop
rsp_b2f6
	iwt r4,#$ffff
rsp_b2f9
	bra rsp_b303
rsp_b2fb
	nop
rsp_b2fc
	ibt r4,#$00
rsp_b2fe
	link #4
rsp_b2ff
	iwt r15,#rsp_81bc&WM
rsp_b302
	nop
rsp_b303
	with r4
rsp_b304
	to r9
rsp_b305
	cache
rsp_b306
	lms r6,[m_sprsize]
rsp_b309
	lms r3,[m_sprx]
rsp_b30c
	lms r2,[m_spry]
rsp_b30f
	ibt r7,#$00
rsp_b311
	ibt r11,#$00
rsp_b313
	lms r0,[m_sprbank]
rsp_b316
	romb
rsp_b318
	lms r5,[m_sprdata]
rsp_b31b
	with r9
rsp_b31c
	bic #1
rsp_b31e
	lms r0,[m_sprmask]
rsp_b321
	with r0
rsp_b322
	from r0
rsp_b323
	bpl rsp_b32a
rsp_b325
	nop
rsp_b326
	iwt r15,#rsp_b3ab&WM
rsp_b329
	nop
rsp_b32a
	with r6
rsp_b32b
	to r13
rsp_b32c
	lms r0,[m_xright]
rsp_b32f
	to r6
rsp_b330
	sub r3
rsp_b331
	from r9
rsp_b332
	lsr
rsp_b333
	fmult
rsp_b334
	to r4
rsp_b335
	rol
rsp_b336
	from r13
rsp_b337
	sub r4
rsp_b338
	dec r0
rsp_b339
	bmi rsp_b33e
rsp_b33b
	nop
rsp_b33c
	with r4
rsp_b33d
	to r13
rsp_b33e
	with r13
rsp_b33f
	to r6
rsp_b340
	with r3
rsp_b341
	from r3
rsp_b342
	bpl rsp_b35e
rsp_b344
	nop
rsp_b345
	from r3
rsp_b346
	to r6
rsp_b347
	not
rsp_b348
	inc r6
rsp_b349
	from r9
rsp_b34a
	lsr
rsp_b34b
	lmult
rsp_b34d
	from r4
rsp_b34e
	to r11
rsp_b34f
	add r4
rsp_b350
	rol
rsp_b351
	bmi rsp_b3a6
rsp_b353
	nop
rsp_b354
	with r5
rsp_b355
	add r0
rsp_b356
	from r13
rsp_b357
	to r6
rsp_b358
	sub r0
rsp_b359
	bmi rsp_b3a6
rsp_b35b
	nop
rsp_b35c
	ibt r3,#$00
rsp_b35e
	with r6
rsp_b35f
	from r6
rsp_b360
	beq rsp_b3a6
rsp_b362
	nop
rsp_b363
	ibt r4,#$00
rsp_b365
	with r2
rsp_b366
	from r2
rsp_b367
	bmi rsp_b398
rsp_b369
	nop
rsp_b36a
	lms r0,[m_ybot]
rsp_b36d
	dec r0
rsp_b36e
	sub r2
rsp_b36f
	bmi rsp_b3a6
rsp_b371
	nop
rsp_b372
	from r4
rsp_b373
	swap
rsp_b374
	to r14
rsp_b375
	add r5
rsp_b376
	with r3
rsp_b377
	to r1
rsp_b378
	with r11
rsp_b379
	to r0
rsp_b37a
	getc
rsp_b37b
	with r6
rsp_b37c
	to r12
rsp_b37d
	dec r12
rsp_b37e
	beq rsp_b38a
rsp_b380
	nop
rsp_b381
	with r15
rsp_b382
	to r13
rsp_b383
	inc r14
rsp_b384
	add r9
rsp_b385
	bcc rsp_b384
rsp_b387
	plot
rsp_b388
	loop
rsp_b389
	getc
rsp_b38a
	with r0
rsp_b38b
	to r8
rsp_b38c
	lms r0,[m_xright]
rsp_b38f
	cmp r1
rsp_b391
	bmi rsp_b398
rsp_b393
	with r8
rsp_b394
	add r9
rsp_b395
	bcc rsp_b38f
rsp_b397
	plot
rsp_b398
	nop
rsp_b399
	with r7
rsp_b39a
	sub r9
rsp_b39b
	bcs rsp_b365
rsp_b39d
	inc r2
rsp_b39e
	inc r4
rsp_b39f
	lms r0,[m_sprsize]
rsp_b3a2
	sub r4
rsp_b3a3
	bne rsp_b365
rsp_b3a5
	nop
rsp_b3a6
	dec r10
rsp_b3a7
	dec r10
rsp_b3a8
	to r15
rsp_b3a9
	ldw [r10]
rsp_b3aa
	nop
rsp_b3ab
	with r5
rsp_b3ac
	add r6
rsp_b3ad
	dec r5
rsp_b3ae
	with r6
rsp_b3af
	to r13
rsp_b3b0
	lms r0,[m_xright]
rsp_b3b3
	to r6
rsp_b3b4
	sub r3
rsp_b3b5
	from r9
rsp_b3b6
	lsr
rsp_b3b7
	fmult
rsp_b3b8
	to r4
rsp_b3b9
	rol
rsp_b3ba
	from r13
rsp_b3bb
	sub r4
rsp_b3bc
	dec r0
rsp_b3bd
	bmi rsp_b3c2
rsp_b3bf
	nop
rsp_b3c0
	with r4
rsp_b3c1
	to r13
rsp_b3c2
	with r13
rsp_b3c3
	to r6
rsp_b3c4
	with r3
rsp_b3c5
	from r3
rsp_b3c6
	bpl rsp_b3e2
rsp_b3c8
	nop
rsp_b3c9
	from r3
rsp_b3ca
	to r6
rsp_b3cb
	not
rsp_b3cc
	inc r6
rsp_b3cd
	from r9
rsp_b3ce
	lsr
rsp_b3cf
	lmult
rsp_b3d1
	from r4
rsp_b3d2
	to r11
rsp_b3d3
	add r4
rsp_b3d4
	rol
rsp_b3d5
	bmi rsp_b42a
rsp_b3d7
	nop
rsp_b3d8
	with r5
rsp_b3d9
	sub r0
rsp_b3da
	from r13
rsp_b3db
	to r6
rsp_b3dc
	sub r0
rsp_b3dd
	bmi rsp_b42a
rsp_b3df
	nop
rsp_b3e0
	ibt r3,#$00
rsp_b3e2
	with r6
rsp_b3e3
	from r6
rsp_b3e4
	beq rsp_b42a
rsp_b3e6
	nop
rsp_b3e7
	ibt r4,#$00
rsp_b3e9
	with r2
rsp_b3ea
	from r2
rsp_b3eb
	bmi rsp_b41c
rsp_b3ed
	nop
rsp_b3ee
	lms r0,[m_ybot]
rsp_b3f1
	dec r0
rsp_b3f2
	sub r2
rsp_b3f3
	bmi rsp_b42a
rsp_b3f5
	nop
rsp_b3f6
	from r4
rsp_b3f7
	swap
rsp_b3f8
	to r14
rsp_b3f9
	add r5
rsp_b3fa
	with r3
rsp_b3fb
	to r1
rsp_b3fc
	with r11
rsp_b3fd
	to r0
rsp_b3fe
	getc
rsp_b3ff
	with r6
rsp_b400
	to r12
rsp_b401
	dec r12
rsp_b402
	beq rsp_b40e
rsp_b404
	nop
rsp_b405
	with r15
rsp_b406
	to r13
rsp_b407
	dec r14
rsp_b408
	add r9
rsp_b409
	bcc rsp_b408
rsp_b40b
	plot
rsp_b40c
	loop
rsp_b40d
	getc
rsp_b40e
	with r0
rsp_b40f
	to r8
rsp_b410
	lms r0,[m_xright]
rsp_b413
	cmp r1
rsp_b415
	bmi rsp_b41c
rsp_b417
	with r8
rsp_b418
	add r9
rsp_b419
	bcc rsp_b413
rsp_b41b
	plot
rsp_b41c
	nop
rsp_b41d
	with r7
rsp_b41e
	sub r9
rsp_b41f
	bcs rsp_b3e9
rsp_b421
	inc r2
rsp_b422
	inc r4
rsp_b423
	lms r0,[m_sprsize]
rsp_b426
	sub r4
rsp_b427
	bne rsp_b3e9
rsp_b429
	nop
rsp_b42a
	dec r10
rsp_b42b
	dec r10
rsp_b42c
	to r15
rsp_b42d
	ldw [r10]
rsp_b42e
	nop
; Same-bank copy of the inherited divider; no new physical credit.
mretail_sprdivide
rsp_81bc
	with r0
rsp_81bd
	from r0
rsp_81be
	bmi rsp_81c6
rsp_81c0
	nop
rsp_81c1
	with r6
rsp_81c2
	from r6
rsp_81c3
	bpl rsp_81cb
rsp_81c5
	nop
rsp_81c6
	with r6
rsp_81c7
	lsr
rsp_81c8
	lsr
rsp_81c9
	with r4
rsp_81ca
	ror
rsp_81cb
	ibt r12,#$10
rsp_81cd
	with r4
rsp_81ce
	add r4
rsp_81cf
	rol
rsp_81d0
	with r15
rsp_81d1
	to r13
rsp_81d2
	sub r6
rsp_81d3
	bcc rsp_81dc
rsp_81d5
	nop
rsp_81d6
	with r4
rsp_81d7
	rol
rsp_81d8
	loop
rsp_81d9
	rol
rsp_81da
	jmp r11
rsp_81db
	lsr
rsp_81dc
	add r6
rsp_81dd
	with r4
rsp_81de
	add r4
rsp_81df
	loop
rsp_81e0
	rol
rsp_81e1
	jmp r11
rsp_81e2
	lsr
mrsprite_codeend
retail_spriteztail
sprzv = $4300
	rept 129
	dw 32767*256/sprzv
sprzv = sprzv+2
	endr
retail_spriteztail_end
mrsprite_end
