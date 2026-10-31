; Retail frontend selection, record sprites and window strategies.
; A16/I16, D=0, DB=0, binary arithmetic unless an entry saves P.
; Bank9 callback bridges retain the near callback ABI. Initialize forms,
; entity lists and caller-owned input/record snapshots before dispatch.
; Record constructor IDs are the native $0290-$04B2 catalogue offsets;
; earlier menu definitions are not part of this catalogue. Group ID $0036
; builds all 20 record entities in native order. It requires 20 free slots;
; exhaustion retains the non-returning retail palette diagnostic.
; The retail 88-byte default copy is intentional here, including its spill
; into the following slot (or the relocated register queue for slot21).
; Do not publish that queue until its owner has reset its byte count.
; Each captured input queue holds eight words; the consumer drains newest-first.
; Menurecords is a caller-loaded 512-byte snapshot of native SRAM $FC00;
; persistent storage and active scene/NMI ownership are not installed here.
	incpublics mrmenu.ext
	include mrhooks.ext
	include mrdisp.ext
	include mrfront.ext
	include mrblank.ext
	include xlsound.ext
mrmenu_begin
	longa
	longi
rmu_pushinput0
	php
rmu_0b88a2
	ai16
rmu_0b88a4
	ldx.w race_menuinputbytes0
rmu_0b88a7
	cpx #$0010
rmu_0b88aa
	beq rmu_0b88b5
rmu_0b88ac
	sta.l race_menuinputqueue0,x
rmu_0b88b0
	inx
rmu_0b88b1
	inx
rmu_0b88b2
	stx.w race_menuinputbytes0
rmu_0b88b5
	plp
rmu_0b88b6
	rts
rmu_pushinput1
	php
rmu_0b88b8
	ai16
rmu_0b88ba
	ldx.w race_menuinputbytes
rmu_0b88bd
	cpx #$0010
rmu_0b88c0
	beq rmu_0b88cb
rmu_0b88c2
	sta.l race_menuinputqueue,x
rmu_0b88c6
	inx
rmu_0b88c7
	inx
rmu_0b88c8
	stx.w race_menuinputbytes
rmu_0b88cb
	plp
rmu_0b88cc
	rts
rmu_newentity
	php
rmu_0bb507
	ai16
rmu_0bb509
	jsl retail_allocentity_l
rmu_0bb50c
	cpx #$ffff
rmu_0bb50f
	bne rmu_0bb514
rmu_0bb511
	brl rmu_0bb648
rmu_0bb514
	lda.l retail_entitytemplate
rmu_0bb518
	sta.w $0000,x
rmu_0bb51b
	lda.l retail_entitytemplate+2
rmu_0bb51f
	sta.w $0002,x
rmu_0bb522
	lda.l retail_entitytemplate+4
rmu_0bb526
	sta.w $0004,x
rmu_0bb529
	lda.l retail_entitytemplate+6
rmu_0bb52d
	sta.w $0006,x
rmu_0bb530
	lda.l retail_entitytemplate+8
rmu_0bb534
	sta.w $0008,x
rmu_0bb537
	lda.l retail_entitytemplate+10
rmu_0bb53b
	sta.w $000a,x
rmu_0bb53e
	lda.l retail_entitytemplate+12
rmu_0bb542
	sta.w $000c,x
rmu_0bb545
	lda.l retail_entitytemplate+14
rmu_0bb549
	sta.w $000e,x
rmu_0bb54c
	lda.l retail_entitytemplate+16
rmu_0bb550
	sta.w $0010,x
rmu_0bb553
	lda.l retail_entitytemplate+18
rmu_0bb557
	sta.w $0012,x
rmu_0bb55a
	lda.l retail_entitytemplate+20
rmu_0bb55e
	sta.w $0014,x
rmu_0bb561
	lda.l retail_entitytemplate+22
rmu_0bb565
	sta.w $0016,x
rmu_0bb568
	lda.l retail_entitytemplate+24
rmu_0bb56c
	sta.w $0018,x
rmu_0bb56f
	lda.l retail_entitytemplate+26
rmu_0bb573
	sta.w $001a,x
rmu_0bb576
	lda.l retail_entitytemplate+28
rmu_0bb57a
	sta.w $001c,x
rmu_0bb57d
	lda.l retail_entitytemplate+30
rmu_0bb581
	sta.w $001e,x
rmu_0bb584
	lda.l retail_entitytemplate+32
rmu_0bb588
	sta.w $0020,x
rmu_0bb58b
	lda.l retail_entitytemplate+34
rmu_0bb58f
	sta.w $0022,x
rmu_0bb592
	lda.l retail_entitytemplate+36
rmu_0bb596
	sta.w $0024,x
rmu_0bb599
	lda.l retail_entitytemplate+38
rmu_0bb59d
	sta.w $0026,x
rmu_0bb5a0
	lda.l retail_entitytemplate+40
rmu_0bb5a4
	sta.w $0028,x
rmu_0bb5a7
	lda.l retail_entitytemplate+42
rmu_0bb5ab
	sta.w $002a,x
; Native writes beyond a 44-byte slot. The last slot spills into the
; register queue in retail; redirect that spill to its relocated binding.
	cpx #race_entities+21*44
	bne rmu_0bb5ae
	jsr rmu_lastspill
	jmp rmu_0bb648
rmu_0bb5ae
	lda.l retail_entitytemplate+44
rmu_0bb5b2
	sta.w $002c,x
rmu_0bb5b5
	lda.l retail_entitytemplate+46
rmu_0bb5b9
	sta.w $002e,x
rmu_0bb5bc
	lda.l retail_entitytemplate+48
rmu_0bb5c0
	sta.w $0030,x
rmu_0bb5c3
	lda.l retail_entitytemplate+50
rmu_0bb5c7
	sta.w $0032,x
rmu_0bb5ca
	lda.l retail_entitytemplate+52
rmu_0bb5ce
	sta.w $0034,x
rmu_0bb5d1
	lda.l retail_entitytemplate+54
rmu_0bb5d5
	sta.w $0036,x
rmu_0bb5d8
	lda.l retail_entitytemplate+56
rmu_0bb5dc
	sta.w $0038,x
rmu_0bb5df
	lda.l retail_entitytemplate+58
rmu_0bb5e3
	sta.w $003a,x
rmu_0bb5e6
	lda.l retail_entitytemplate+60
rmu_0bb5ea
	sta.w $003c,x
rmu_0bb5ed
	lda.l retail_entitytemplate+62
rmu_0bb5f1
	sta.w $003e,x
rmu_0bb5f4
	lda.l retail_entitytemplate+64
rmu_0bb5f8
	sta.w $0040,x
rmu_0bb5fb
	lda.l retail_entitytemplate+66
rmu_0bb5ff
	sta.w $0042,x
rmu_0bb602
	lda.l retail_entitytemplate+68
rmu_0bb606
	sta.w $0044,x
rmu_0bb609
	lda.l retail_entitytemplate+70
rmu_0bb60d
	sta.w $0046,x
rmu_0bb610
	lda.l retail_entitytemplate+72
rmu_0bb614
	sta.w $0048,x
rmu_0bb617
	lda.l retail_entitytemplate+74
rmu_0bb61b
	sta.w $004a,x
rmu_0bb61e
	lda.l retail_entitytemplate+76
rmu_0bb622
	sta.w $004c,x
rmu_0bb625
	lda.l retail_entitytemplate+78
rmu_0bb629
	sta.w $004e,x
rmu_0bb62c
	lda.l retail_entitytemplate+80
rmu_0bb630
	sta.w $0050,x
rmu_0bb633
	lda.l retail_entitytemplate+82
rmu_0bb637
	sta.w $0052,x
rmu_0bb63a
	lda.l retail_entitytemplate+84
rmu_0bb63e
	sta.w $0054,x
rmu_0bb641
	lda.l retail_entitytemplate+86
rmu_0bb645
	sta.w $0056,x
rmu_0bb648
	plp
rmu_0bb649
	rts
rmu_menucursor
	php
rmu_0bc724
	ai16
rmu_0bc726
	pha
rmu_0bc727
	asl a
rmu_0bc728
	tax
rmu_0bc729
	lda.l race_menucursors,x
rmu_0bc72d
	ldy #race_menucursory-2
rmu_0bc730
	sta.w $0002,y
rmu_0bc733
	pla
rmu_0bc734
	plp
rmu_0bc735
	rts
rmu_menuselected
	ai16
rmu_0bc738
	lda #$0000
rmu_0bc73b
	sta.l race_menumatch
rmu_0bc73f
	lda.l race_menucurrent
rmu_0bc743
	cmp.l race_menuchoice
rmu_0bc747
	bne rmu_0bc757
rmu_0bc749
	lda.l race_menuchoice
rmu_0bc74d
	asl a
rmu_0bc74e
	tax
rmu_0bc74f
	lda.l retail_menuselectbits,x
rmu_0bc753
	sta.l race_menumatch
rmu_0bc757
	rts
rmu_menuinputs
	stz.w race_menuheld
rmu_0bc763
	lda.l race_menuinputbytes
rmu_0bc767
	dec a
rmu_0bc768
	dec a
rmu_0bc769
	bmi rmu_0bc789
rmu_0bc76b
	tax
rmu_0bc76c
	lda.l race_menuinputqueue,x
rmu_0bc770
	sta.w race_frontdebug
rmu_0bc773
	ora.w race_menuheld
rmu_0bc776
	sta.w race_menuheld
rmu_0bc779
	phx
rmu_0bc77a
	jsr rmu_menuinput
rmu_0bc77d
	pla
rmu_0bc77e
	dec a
rmu_0bc77f
	dec a
rmu_0bc780
	bpl rmu_0bc76b
rmu_0bc782
	lda #$0000
rmu_0bc785
	sta.l race_menuinputbytes
rmu_0bc789
	rts
rmu_menuinput
	lda.w race_frontdebug
rmu_0bc78d
	and #$0200
rmu_0bc790
	beq rmu_0bc7d4
rmu_0bc792
	a8
rmu_0bc794
	lda #$45
rmu_0bc796
	jsl queue_raceplayer_l
rmu_0bc79a
	a16
rmu_0bc79c
	lda.l race_menuchoice
rmu_0bc7a0
	asl a
rmu_0bc7a1
	phx
rmu_0bc7a2
	tax
rmu_0bc7a3
	lda.l retail_menuleft,x
rmu_0bc7a7
	plx
rmu_0bc7a8
	sta.l race_menuchoice
rmu_0bc7ac
	lda.l race_menurecords+11
rmu_0bc7b0
	and #$0004
rmu_0bc7b3
	bne rmu_0bc7c5
rmu_0bc7b5
	lda.l race_menuchoice
rmu_0bc7b9
	cmp #$0003
rmu_0bc7bc
	bne rmu_0bc7c5
rmu_0bc7be
	lda #$0002
rmu_0bc7c1
	sta.l race_menuchoice
rmu_0bc7c5
	lda.l race_menuchoice
rmu_0bc7c9
	pha
rmu_0bc7ca
	jsr rmu_menuselected
rmu_0bc7cd
	pla
rmu_0bc7ce
	jsr rmu_menucursor
rmu_0bc7d1
	jsr rmu_menulabels
rmu_0bc7d4
	lda.w race_frontdebug
rmu_0bc7d7
	and #$0100
rmu_0bc7da
	beq rmu_0bc81e
rmu_0bc7dc
	a8
rmu_0bc7de
	lda #$45
rmu_0bc7e0
	jsl queue_raceplayer_l
rmu_0bc7e4
	a16
rmu_0bc7e6
	lda.l race_menuchoice
rmu_0bc7ea
	asl a
rmu_0bc7eb
	phx
rmu_0bc7ec
	tax
rmu_0bc7ed
	lda.l retail_menuright,x
rmu_0bc7f1
	plx
rmu_0bc7f2
	sta.l race_menuchoice
rmu_0bc7f6
	lda.l race_menurecords+11
rmu_0bc7fa
	and #$0004
rmu_0bc7fd
	bne rmu_0bc80f
rmu_0bc7ff
	lda.l race_menuchoice
rmu_0bc803
	cmp #$0003
rmu_0bc806
	bne rmu_0bc80f
rmu_0bc808
	lda #$0001
rmu_0bc80b
	sta.l race_menuchoice
rmu_0bc80f
	lda.l race_menuchoice
rmu_0bc813
	pha
rmu_0bc814
	jsr rmu_menuselected
rmu_0bc817
	pla
rmu_0bc818
	jsr rmu_menucursor
rmu_0bc81b
	jsr rmu_menulabels
rmu_0bc81e
	rts
rmu_menulabels
	asl a
rmu_0bc830
	asl a
rmu_0bc831
	tax
rmu_0bc832
	lda.l retail_menulabelanims,x
rmu_0bc836
	pha
rmu_0bc837
	lda.l retail_menulabelanims+2,x
rmu_0bc83b
	pha
rmu_0bc83c
	lda #$0005
rmu_0bc83f
	jsl retail_findentity_l
rmu_0bc842
	pla
rmu_0bc843
	cmp $14,x
rmu_0bc845
	beq rmu_0bc84d
rmu_0bc847
	sta $14,x
rmu_0bc849
	stz $16,x
rmu_0bc84b
	stz $18,x
rmu_0bc84d
	lda #$0003
rmu_0bc850
	jsl retail_findentity_l
rmu_0bc853
	pla
rmu_0bc854
	cmp $14,x
rmu_0bc856
	beq rmu_0bc85e
rmu_0bc858
	sta $14,x
rmu_0bc85a
	stz $16,x
rmu_0bc85c
	stz $18,x
rmu_0bc85e
	ldx.w race_entitycurrent
rmu_0bc861
	rts
rmu_dimcolor
	lda.l race_menucolor
rmu_0bc913
	beq rmu_0bc933
rmu_0bc915
	dec a
rmu_0bc916
	dec a
rmu_0bc917
	bpl rmu_0bc91c
rmu_0bc919
	lda #$0000
rmu_0bc91c
	sta.l race_menucolor
rmu_0bc920
	a8
rmu_0bc922
	ora #$e0
rmu_0bc924
	a8
rmu_0bc926
	i16
rmu_0bc928
	phx
rmu_0bc929
	ldx #$2132
rmu_0bc92c
	jsl retail_queueregister_l
rmu_0bc930
	plx
rmu_0bc931
	a16
rmu_0bc933
	rts
rmu_brightcolor
	lda.l race_menucolor
rmu_0bc938
	cmp #$001f
rmu_0bc93b
	beq rmu_0bc95e
rmu_0bc93d
	inc a
rmu_0bc93e
	inc a
rmu_0bc93f
	cmp #$001f
rmu_0bc942
	bcc rmu_0bc947
rmu_0bc944
	lda #$001f
rmu_0bc947
	sta.l race_menucolor
rmu_0bc94b
	a8
rmu_0bc94d
	ora #$e0
rmu_0bc94f
	a8
rmu_0bc951
	i16
rmu_0bc953
	phx
rmu_0bc954
	ldx #$2132
rmu_0bc957
	jsl retail_queueregister_l
rmu_0bc95b
	plx
rmu_0bc95c
	a16
rmu_0bc95e
	rts
rmu_trackleft
	lda #$01cf
rmu_0bc988
	sec
rmu_0bc989
	sbc.l race_frontscroll3
rmu_0bc98d
	sta $02,x
rmu_0bc98f
	jsl retail_stepentityanim_l
rmu_0bc992
	rts
rmu_trackright
	lda #$0194
rmu_0bc996
	sec
rmu_0bc997
	sbc.l race_frontscroll3
rmu_0bc99b
	sta $02,x
rmu_0bc99d
	jsl retail_stepentityanim_l
rmu_0bc9a0
	rts
rmu_entityvisibility
	sty.w race_oambits
rmu_0bc9a4
	sta.w race_oamword
rmu_0bc9a7
	phx
rmu_0bc9a8
	ldy.w race_entitybytes
rmu_0bc9ab
	dey
rmu_0bc9ac
	dey
rmu_0bc9ad
	bmi rmu_0bc9c2
rmu_0bc9af
	ldx.w race_entitylist,y
rmu_0bc9b2
	lda $1a,x
rmu_0bc9b4
	cmp.w race_oamword
rmu_0bc9b7
	bne rmu_0bc9be
rmu_0bc9b9
	lda.w race_oambits
rmu_0bc9bc
	sta $10,x
rmu_0bc9be
	dey
rmu_0bc9bf
	dey
rmu_0bc9c0
	bpl rmu_0bc9af
rmu_0bc9c2
	plx
rmu_0bc9c3
	rts
rmu_menudefaults
	php
rmu_0bd4c4
	ai16
rmu_0bd4c6
	lda #$0006
rmu_0bd4c9
	sta.l race_bitmapstage
rmu_0bd4cd
	lda #$0000
rmu_0bd4d0
	sta.l race_frontfast
rmu_0bd4d4
	lda #$0000
rmu_0bd4d7
	sta.l race_menuunknown8
rmu_0bd4db
	lda #$0001
rmu_0bd4de
	sta.l race_menuactive
rmu_0bd4e2
	lda #$0000
rmu_0bd4e5
	sta.l race_menuunknown7
rmu_0bd4e9
	sta.l race_menuunknown6
rmu_0bd4ed
	sta.l race_menuunknown5
rmu_0bd4f1
	sta.l race_menuunknown0
rmu_0bd4f5
	sta.l race_menucurrent
rmu_0bd4f9
	sta.l race_menuchoice
rmu_0bd4fd
	sta.l race_menuunknown3
rmu_0bd501
	sta.l race_menuoptions0
rmu_0bd505
	sta.l race_menuunknown4
rmu_0bd509
	lda #$0000
rmu_0bd50c
	sta.l race_menumatch
rmu_0bd510
	lda #$0000
rmu_0bd513
	sta.l race_menuunknown1
rmu_0bd517
	lda #$0000
rmu_0bd51a
	sta.l race_menuunknown2
rmu_0bd51e
	lda #$0003
rmu_0bd521
	sta.l race_menulimit
rmu_0bd525
	lda #$0001
rmu_0bd528
	sta.l race_menunext
rmu_0bd52c
	sta.l race_menuoption
rmu_0bd530
	sta.l race_menuoptions1
rmu_0bd534
	lda #$0002
rmu_0bd537
	sta.l race_menuoptions2
rmu_0bd53b
	lda.l race_menurecords+8
rmu_0bd53f
	and #$00ff
rmu_0bd542
	sta.l race_menuaudio0
rmu_0bd546
	lda.l race_menurecords+9
rmu_0bd54a
	and #$00ff
rmu_0bd54d
	sta.l race_menuaudio1
rmu_0bd551
	lda.l race_menurecords+10
rmu_0bd555
	and #$00ff
rmu_0bd558
	sta.l race_menuaudio2
rmu_0bd55c
	lda #$ffff
rmu_0bd55f
	sta.l race_menupending
rmu_0bd563
	lda #$001f
rmu_0bd566
	sta.l race_menucolor
rmu_0bd56a
	plp
rmu_0bd56b
	rts
rmu_delayanim
	dec $1e,x
rmu_0bd5ee
	bmi rmu_0bd5f1
rmu_0bd5f0
	rts
rmu_0bd5f1
	lda #rhk_animate&WM
rmu_0bd5f4
	sta $08,x
rmu_animate
	jsl retail_stepentityanim_l
rmu_0bd5f9
	rts
rmu_recordwait
	dec $0a,x
rmu_0bd8ab
	bpl rmu_0bd8b4
rmu_0bd8ad
	lda #rhk_recordopen&WM
rmu_0bd8b0
	sta $08,x
rmu_0bd8b2
	stz $0a,x
rmu_0bd8b4
	rts
rmu_recordopen
	ai16
rmu_0bd8b7
	lda $0a,x
rmu_0bd8b9
	clc
rmu_0bd8ba
	adc #$0004
rmu_0bd8bd
	cmp #$0066
rmu_0bd8c0
	bcc rmu_0bd8c5
rmu_0bd8c2
	lda #$0066
rmu_0bd8c5
	sta $0a,x
rmu_0bd8c7
	sta.l race_frontanimy
rmu_0bd8cb
	pha
rmu_0bd8cc
	lda #$0066
rmu_0bd8cf
	sec
rmu_0bd8d0
	sbc $0a,x
rmu_0bd8d2
	sta.w race_entityscrolly
rmu_0bd8d5
	pla
rmu_0bd8d6
	cmp #$0066
rmu_0bd8d9
	beq rmu_0bd8dc
rmu_0bd8db
	rts
rmu_0bd8dc
	lda #rhk_recordshade0&WM
rmu_0bd8df
	sta $08,x
rmu_0bd8e1
	lda #$0000
rmu_0bd8e4
	sta $0a,x
rmu_0bd8e6
	a8
rmu_0bd8e8
	lda #$e8
rmu_0bd8ea
	a8
rmu_0bd8ec
	i16
rmu_0bd8ee
	phx
rmu_0bd8ef
	ldx #$420c
rmu_0bd8f2
	jsl retail_queueregister_l
rmu_0bd8f6
	plx
rmu_0bd8f7
	a16
rmu_0bd8f9
	rts
rmu_recordshade0
	lda $0a,x
rmu_0bd8fc
	clc
rmu_0bd8fd
	adc #$0008
rmu_0bd900
	sta $0a,x
rmu_0bd902
	cmp #$0100
rmu_0bd905
	beq rmu_0bd910
rmu_0bd907
	a8
rmu_0bd909
	sta.l race_fronttables+56
rmu_0bd90d
	a16
rmu_0bd90f
	rts
rmu_0bd910
	lda #rhk_recordshade1&WM
rmu_0bd913
	sta $08,x
rmu_0bd915
	lda #$0000
rmu_0bd918
	sta $0a,x
rmu_0bd91a
	rts
rmu_recordshade1
	lda $0a,x
rmu_0bd91d
	clc
rmu_0bd91e
	adc #$0008
rmu_0bd921
	sta $0a,x
rmu_0bd923
	cmp #$0100
rmu_0bd926
	beq rmu_0bd931
rmu_0bd928
	a8
rmu_0bd92a
	sta.l race_fronttables+58
rmu_0bd92e
	a16
rmu_0bd930
	rts
rmu_0bd931
	lda #rhk_recordinput&WM
rmu_0bd934
	sta $08,x
rmu_0bd936
	lda #$0000
rmu_0bd939
	sta $0a,x
rmu_0bd93b
	a8
rmu_0bd93d
	lda #$e0
rmu_0bd93f
	a8
rmu_0bd941
	i16
rmu_0bd943
	phx
rmu_0bd944
	ldx #$420c
rmu_0bd947
	jsl retail_queueregister_l
rmu_0bd94b
	plx
rmu_0bd94c
	lda #$00
rmu_0bd94e
	a8
rmu_0bd950
	i16
rmu_0bd952
	phx
rmu_0bd953
	ldx #$212e
rmu_0bd956
	jsl retail_queueregister_l
rmu_0bd95a
	plx
rmu_0bd95b
	a16
rmu_0bd95d
	lda.l race_recordselected
rmu_0bd961
	and #$00ff
rmu_0bd964
	cmp #$0000
rmu_0bd967
	beq rmu_0bd984
rmu_0bd969
	lda.l race_menumode
rmu_0bd96d
	and #$00ff
rmu_0bd970
	cmp #$0008
rmu_0bd973
	bne rmu_0bd984
rmu_0bd975
	lda #$0018
rmu_0bd978
	jsl retail_findentity_l
rmu_0bd97b
	lda #rhk_recordflash&WM
rmu_0bd97e
	sta $08,x
rmu_0bd980
	stz $0a,x
rmu_0bd982
	stz $22,x
rmu_0bd984
	rts
rmu_recordwinner
	lda.l race_recordselected
rmu_0bd989
	and #$00ff
rmu_0bd98c
	cmp $22,x
rmu_0bd98e
	bne rmu_0bd9ac
rmu_0bd990
	lda.l race_menumode
rmu_0bd994
	and #$00ff
rmu_0bd997
	cmp #$0008
rmu_0bd99a
	bne rmu_0bd9ac
rmu_0bd99c
	jsl retail_clonespritelist_l
rmu_0bd99f
	ldx.w race_entitycurrent
rmu_0bd9a2
	lda #rhk_recordflash&WM
rmu_0bd9a5
	sta $08,x
rmu_0bd9a7
	stz $22,x
rmu_0bd9a9
	stz $0a,x
rmu_0bd9ab
	rts
rmu_0bd9ac
	jmp rmu_delayanim
rmu_recordvehicle
	lda.l race_recordselected
rmu_0bd9b3
	and #$00ff
rmu_0bd9b6
	cmp $22,x
rmu_0bd9b8
	bne rmu_0bd9d2
rmu_0bd9ba
	jsr rmu_recordindex
rmu_0bd9bd
	lda.l race_menurecords+111,x
rmu_0bd9c1
	and #$0003
rmu_0bd9c4
	asl a
rmu_0bd9c5
	tax
rmu_0bd9c6
	lda.l retail_recordcaranims+8,x
rmu_0bd9ca
	ldx.w race_entitycurrent
rmu_0bd9cd
	sta $14,x
rmu_0bd9cf
	jmp rmu_delayanim
rmu_0bd9d2
	jsr rmu_recordindex
rmu_0bd9d5
	lda.l race_menurecords+111,x
rmu_0bd9d9
	and #$0003
rmu_0bd9dc
	asl a
rmu_0bd9dd
	tax
rmu_0bd9de
	lda.l retail_recordcaranims,x
rmu_0bd9e2
	ldx.w race_entitycurrent
rmu_0bd9e5
	sta $14,x
rmu_0bd9e7
	jmp rmu_delayanim
rmu_recordindex
	lda.l race_displaychoice
rmu_0bd9ee
	and #$00ff
rmu_0bd9f1
	sta.w race_oambits
rmu_0bd9f4
	asl a
rmu_0bd9f5
	asl a
rmu_0bd9f6
	asl a
rmu_0bd9f7
	clc
rmu_0bd9f8
	adc.w race_oambits
rmu_0bd9fb
	sta.w race_oamword
rmu_0bd9fe
	lda $22,x
rmu_0bda00
	dec a
rmu_0bda01
	sta.w race_oambits
rmu_0bda04
	asl a
rmu_0bda05
	clc
rmu_0bda06
	adc.w race_oambits
rmu_0bda09
	clc
rmu_0bda0a
	adc.w race_oamword
rmu_0bda0d
	tax
rmu_0bda0e
	rts
rmu_recordslide
	jsl retail_clonespritelist_l
rmu_0bda22
	lda.l race_recordflashcount
rmu_0bda26
	sta $0a,x
rmu_0bda28
	lda.l race_recordflashphase
rmu_0bda2c
	sta $22,x
rmu_0bda2e
	lda #rhk_recordflash&WM
rmu_0bda31
	sta $08,x
rmu_recordflash
	dec $0a,x
rmu_0bda35
	bpl rmu_0bda44
rmu_0bda37
	lda #$0005
rmu_0bda3a
	sta $0a,x
rmu_0bda3c
	lda $22,x
rmu_0bda3e
	inc a
rmu_0bda3f
	and #$0001
rmu_0bda42
	sta $22,x
rmu_0bda44
	lda $22,x
rmu_0bda46
	asl a
rmu_0bda47
	tax
rmu_0bda48
	lda.l retail_recordpalettes,x
rmu_0bda4c
	sta.w race_oambits
rmu_0bda4f
	ldx.w race_entitycurrent
rmu_0bda52
	lda $0a,x
rmu_0bda54
	sta.l race_recordflashcount
rmu_0bda58
	lda $22,x
rmu_0bda5a
	sta.l race_recordflashphase
rmu_0bda5e
	jsr rmu_spritepalette
rmu_0bda61
	rts
rmu_spritepalette
	phx
rmu_0bda63
	lda $12,x
rmu_0bda65
	tax
rmu_0bda66
	lda.l race_spritelists,x
rmu_0bda6a
	tay
rmu_0bda6b
	inx
rmu_0bda6c
	inx
rmu_0bda6d
	lda.l race_spritelists+4,x
rmu_0bda71
	and #$f1ff
rmu_0bda74
	ora.w race_oambits
rmu_0bda77
	sta.l race_spritelists+4,x
rmu_0bda7b
	txa
rmu_0bda7c
	clc
rmu_0bda7d
	adc #$0008
rmu_0bda80
	tax
rmu_0bda81
	dey
rmu_0bda82
	bpl rmu_0bda6d
rmu_0bda84
	plx
rmu_0bda85
	rts
rmu_recordinput
	ldy.w race_menuedges
rmu_0bda8d
	tya
rmu_0bda8e
	and #$9000
rmu_0bda91
	beq rmu_0bdad0
rmu_0bda93
	lda.l race_menumode
rmu_0bda97
	and #$00ff
rmu_0bda9a
	cmp #$0008
rmu_0bda9d
	bne rmu_0bdaba
rmu_0bda9f
	lda.w race_recordselected
rmu_0bdaa2
	and #$00ff
rmu_0bdaa5
	lda #rhk_recordclose&WM
rmu_0bdaa8
	sta $08,x
rmu_0bdaaa
	lda #$0066
rmu_0bdaad
	sta $0a,x
rmu_0bdaaf
	a8
rmu_0bdab1
	lda #$46
rmu_0bdab3
	jsl queue_raceplayer_l
rmu_0bdab7
	a16
rmu_0bdab9
	rts
rmu_0bdaba
	lda #$0001
rmu_0bdabd
	sta.w race_menuexit
rmu_0bdac0
	ldy.w race_entityindex
rmu_0bdac3
	jsl retail_freeentity_l
rmu_0bdac6
	a8
rmu_0bdac8
	lda #$46
rmu_0bdaca
	jsl queue_raceplayer_l
rmu_0bdace
	a16
rmu_0bdad0
	rts
rmu_recordclose
	ai16
rmu_0bdad3
	lda $0a,x
rmu_0bdad5
	sec
rmu_0bdad6
	sbc #$0004
rmu_0bdad9
	bpl rmu_0bdade
rmu_0bdadb
	lda #$0000
rmu_0bdade
	sta $0a,x
rmu_0bdae0
	sta.l race_frontanimy
rmu_0bdae4
	pha
rmu_0bdae5
	lda #$0066
rmu_0bdae8
	sec
rmu_0bdae9
	sbc $0a,x
rmu_0bdaeb
	sta.w race_entityscrolly
rmu_0bdaee
	pla
rmu_0bdaef
	cmp #$0000
rmu_0bdaf2
	beq rmu_0bdaf5
rmu_0bdaf4
	rts
rmu_0bdaf5
	lda #rhk_recordreopen&WM
rmu_0bdaf8
	sta $08,x
rmu_0bdafa
	lda #$0000
rmu_0bdafd
	sta $0a,x
rmu_0bdaff
	lda #$005f
rmu_0bdb02
	sta.l race_frontbasey0
rmu_0bdb06
	lda #$0014
rmu_0bdb09
	ldy #$ffff
rmu_0bdb0c
	jsr rmu_entityvisibility
rmu_0bdb0f
	lda #$0015
rmu_0bdb12
	ldy #$ffff
rmu_0bdb15
	jsr rmu_entityvisibility
rmu_0bdb18
	lda #$0016
rmu_0bdb1b
	ldy #$ffff
rmu_0bdb1e
	jsr rmu_entityvisibility
rmu_0bdb21
	lda #$0017
rmu_0bdb24
	ldy #$ffff
rmu_0bdb27
	jsr rmu_entityvisibility
rmu_0bdb2a
	lda #$001a
rmu_0bdb2d
	ldy #$0000
rmu_0bdb30
	jsr rmu_entityvisibility
rmu_0bdb33
	lda #$001b
rmu_0bdb36
	ldy #$0000
rmu_0bdb39
	jsr rmu_entityvisibility
rmu_0bdb3c
	lda #$001c
rmu_0bdb3f
	ldy #$0000
rmu_0bdb42
	jsr rmu_entityvisibility
rmu_0bdb45
	lda #$001d
rmu_0bdb48
	ldy #$0000
rmu_0bdb4b
	jsr rmu_entityvisibility
rmu_0bdb4e
	lda #$001e
rmu_0bdb51
	ldy #$0000
rmu_0bdb54
	jsr rmu_entityvisibility
rmu_0bdb57
	lda #$001f
rmu_0bdb5a
	ldy #$0000
rmu_0bdb5d
	jsr rmu_entityvisibility
rmu_0bdb60
	lda #$0020
rmu_0bdb63
	ldy #$0000
rmu_0bdb66
	jsr rmu_entityvisibility
rmu_0bdb69
	lda #$0021
rmu_0bdb6c
	ldy #$0000
rmu_0bdb6f
	jsr rmu_entityvisibility
rmu_0bdb72
	lda #$0022
rmu_0bdb75
	ldy #$0000
rmu_0bdb78
	jsr rmu_entityvisibility
rmu_0bdb7b
	lda #$0023
rmu_0bdb7e
	ldy #$0000
rmu_0bdb81
	jsr rmu_entityvisibility
rmu_0bdb84
	lda #$0024
rmu_0bdb87
	ldy #$0000
rmu_0bdb8a
	jsr rmu_entityvisibility
rmu_0bdb8d
	lda #$0025
rmu_0bdb90
	ldy #$0000
rmu_0bdb93
	jsr rmu_entityvisibility
rmu_0bdb96
	lda #$0018
rmu_0bdb99
	jsl retail_findentity_l
rmu_0bdb9c
	lda.l race_recordselected
rmu_0bdba0
	and #$00ff
rmu_0bdba3
	beq rmu_0bdc01
rmu_0bdba5
	cmp #$0001
rmu_0bdba8
	bne rmu_0bdbc6
rmu_0bdbaa
	lda $14,x
rmu_0bdbac
	cmp #$0262
rmu_0bdbaf
	beq rmu_0bdbba
rmu_0bdbb1
	lda #$0262
rmu_0bdbb4
	sta $14,x
rmu_0bdbb6
	stz $16,x
rmu_0bdbb8
	stz $18,x
rmu_0bdbba
	lda #$0088
rmu_0bdbbd
	sta $02,x
rmu_0bdbbf
	lda #rhk_recordslide&WM
rmu_0bdbc2
	sta $08,x
rmu_0bdbc4
	bra rmu_0bdc01
rmu_0bdbc6
	cmp #$0002
rmu_0bdbc9
	bne rmu_0bdbe7
rmu_0bdbcb
	lda $14,x
rmu_0bdbcd
	cmp #$0268
rmu_0bdbd0
	beq rmu_0bdbdb
rmu_0bdbd2
	lda #$0268
rmu_0bdbd5
	sta $14,x
rmu_0bdbd7
	stz $16,x
rmu_0bdbd9
	stz $18,x
rmu_0bdbdb
	lda #$0088
rmu_0bdbde
	sta $02,x
rmu_0bdbe0
	lda #rhk_recordslide&WM
rmu_0bdbe3
	sta $08,x
rmu_0bdbe5
	bra rmu_0bdc01
rmu_0bdbe7
	lda $14,x
rmu_0bdbe9
	cmp #$026e
rmu_0bdbec
	beq rmu_0bdbf7
rmu_0bdbee
	lda #$026e
rmu_0bdbf1
	sta $14,x
rmu_0bdbf3
	stz $16,x
rmu_0bdbf5
	stz $18,x
rmu_0bdbf7
	lda #$0088
rmu_0bdbfa
	sta $02,x
rmu_0bdbfc
	lda #rhk_recordslide&WM
rmu_0bdbff
	sta $08,x
rmu_0bdc01
	lda #$0019
rmu_0bdc04
	jsl retail_findentity_l
rmu_0bdc07
	lda.l race_recordselected
rmu_0bdc0b
	and #$00ff
rmu_0bdc0e
	beq rmu_0bdc6c
rmu_0bdc10
	cmp #$0001
rmu_0bdc13
	bne rmu_0bdc31
rmu_0bdc15
	lda $14,x
rmu_0bdc17
	cmp #$0250
rmu_0bdc1a
	beq rmu_0bdc25
rmu_0bdc1c
	lda #$0250
rmu_0bdc1f
	sta $14,x
rmu_0bdc21
	stz $16,x
rmu_0bdc23
	stz $18,x
rmu_0bdc25
	lda #$0058
rmu_0bdc28
	sta $02,x
rmu_0bdc2a
	lda #rhk_delayanim&WM
rmu_0bdc2d
	sta $08,x
rmu_0bdc2f
	bra rmu_0bdc6c
rmu_0bdc31
	cmp #$0002
rmu_0bdc34
	bne rmu_0bdc52
rmu_0bdc36
	lda $14,x
rmu_0bdc38
	cmp #$0256
rmu_0bdc3b
	beq rmu_0bdc46
rmu_0bdc3d
	lda #$0256
rmu_0bdc40
	sta $14,x
rmu_0bdc42
	stz $16,x
rmu_0bdc44
	stz $18,x
rmu_0bdc46
	lda #$0058
rmu_0bdc49
	sta $02,x
rmu_0bdc4b
	lda #rhk_delayanim&WM
rmu_0bdc4e
	sta $08,x
rmu_0bdc50
	bra rmu_0bdc6c
rmu_0bdc52
	lda $14,x
rmu_0bdc54
	cmp #$025c
rmu_0bdc57
	beq rmu_0bdc62
rmu_0bdc59
	lda #$025c
rmu_0bdc5c
	sta $14,x
rmu_0bdc5e
	stz $16,x
rmu_0bdc60
	stz $18,x
rmu_0bdc62
	lda #$0058
rmu_0bdc65
	sta $02,x
rmu_0bdc67
	lda #rhk_delayanim&WM
rmu_0bdc6a
	sta $08,x
rmu_0bdc6c
	rts
rmu_recordreopen
	ai16
rmu_0bdc6f
	lda $0a,x
rmu_0bdc71
	clc
rmu_0bdc72
	adc #$0004
rmu_0bdc75
	cmp #$0066
rmu_0bdc78
	bcc rmu_0bdc7d
rmu_0bdc7a
	lda #$0066
rmu_0bdc7d
	sta $0a,x
rmu_0bdc7f
	sta.l race_frontanimy
rmu_0bdc83
	pha
rmu_0bdc84
	lda #$0066
rmu_0bdc87
	sec
rmu_0bdc88
	sbc $0a,x
rmu_0bdc8a
	sta.w race_entityscrolly
rmu_0bdc8d
	pla
rmu_0bdc8e
	cmp #$0066
rmu_0bdc91
	beq rmu_0bdc94
rmu_0bdc93
	rts
rmu_0bdc94
	lda #rhk_recordexit&WM
rmu_0bdc97
	sta $08,x
rmu_0bdc99
	lda #$0000
rmu_0bdc9c
	sta $0a,x
rmu_0bdc9e
	rts
rmu_recordexit
	ldy.w race_menuedges
rmu_0bdca2
	tya
rmu_0bdca3
	and #$9000
rmu_0bdca6
	beq rmu_0bdcbe
rmu_0bdca8
	lda #$0001
rmu_0bdcab
	sta.w race_menuexit
rmu_0bdcae
	ldy.w race_entityindex
rmu_0bdcb1
	jsl retail_freeentity_l
rmu_0bdcb4
	a8
rmu_0bdcb6
	lda #$46
rmu_0bdcb8
	jsl queue_raceplayer_l
rmu_0bdcbc
	a16
rmu_0bdcbe
	rts
rmu_recordtotal
	lda.l race_menumode
rmu_0bdcc3
	and #$00ff
rmu_0bdcc6
	cmp #$0008
rmu_0bdcc9
	bne rmu_0bdcf3
rmu_0bdccb
	jsl retail_clonespritelist_l
rmu_0bdcce
	lda $12,x
rmu_0bdcd0
	inc a
rmu_0bdcd1
	inc a
rmu_0bdcd2
	sta.w race_oamword
rmu_0bdcd5
	lda.l race_menutotal+2
rmu_0bdcd9
	jsr rmu_timebyte
rmu_0bdcdc
	lda.l race_menutotal+1
rmu_0bdce0
	jsr rmu_timebyte
rmu_0bdce3
	lda.l race_menutotal
rmu_0bdce7
	jsr rmu_timebyte
rmu_0bdcea
	ldx.w race_entitycurrent
rmu_0bdced
	lda #rhk_recordidle&WM
rmu_0bdcf0
	sta $08,x
rmu_0bdcf2
	rts
rmu_0bdcf3
	ldx.w race_entitycurrent
rmu_0bdcf6
	lda #$ffff
rmu_0bdcf9
	sta $10,x
rmu_0bdcfb
	lda #rhk_recordidle&WM
rmu_0bdcfe
	sta $08,x
rmu_0bdd00
	rts
rmu_recordflag
	lda.l race_menumode
rmu_0bdd05
	and #$00ff
rmu_0bdd08
	cmp #$0008
rmu_0bdd0b
	bne rmu_0bdd10
rmu_0bdd0d
	jmp rmu_delayanim
rmu_0bdd10
	ldx.w race_entitycurrent
rmu_0bdd13
	lda #$ffff
rmu_0bdd16
	sta $10,x
rmu_0bdd18
	lda #rhk_recordidle&WM
rmu_0bdd1b
	sta $08,x
rmu_0bdd1d
	rts
rmu_recordname
	jsl retail_clonespritelist_l
rmu_0bdd21
	lda $12,x
rmu_0bdd23
	inc a
rmu_0bdd24
	inc a
rmu_0bdd25
	sta.w race_menutemp
rmu_0bdd28
	jsr rmu_recordindex
rmu_0bdd2b
	lda.l race_menurecords+109,x
rmu_0bdd2f
	sta.w race_oambits
rmu_0bdd32
	and #$001f
rmu_0bdd35
	jsr rmu_nameglyph
rmu_0bdd38
	lda.w race_oambits
rmu_0bdd3b
	lsr a
rmu_0bdd3c
	lsr a
rmu_0bdd3d
	lsr a
rmu_0bdd3e
	lsr a
rmu_0bdd3f
	lsr a
rmu_0bdd40
	sta.w race_oambits
rmu_0bdd43
	and #$001f
rmu_0bdd46
	jsr rmu_nameglyph
rmu_0bdd49
	lda.w race_oambits
rmu_0bdd4c
	lsr a
rmu_0bdd4d
	lsr a
rmu_0bdd4e
	lsr a
rmu_0bdd4f
	lsr a
rmu_0bdd50
	lsr a
rmu_0bdd51
	sta.w race_oambits
rmu_0bdd54
	and #$001f
rmu_0bdd57
	jsr rmu_nameglyph
rmu_0bdd5a
	ldx.w race_entitycurrent
rmu_0bdd5d
	lda.l race_recordselected
rmu_0bdd61
	and #$00ff
rmu_0bdd64
	cmp $22,x
rmu_0bdd66
	bne rmu_0bdd81
rmu_0bdd68
	lda.l race_menumode
rmu_0bdd6c
	and #$00ff
rmu_0bdd6f
	cmp #$0008
rmu_0bdd72
	bne rmu_0bdd81
rmu_0bdd74
	ldx.w race_entitycurrent
rmu_0bdd77
	lda #rhk_recordflash&WM
rmu_0bdd7a
	sta $08,x
rmu_0bdd7c
	stz $22,x
rmu_0bdd7e
	stz $0a,x
rmu_0bdd80
	rts
rmu_0bdd81
	lda #rhk_recordidle&WM
rmu_0bdd84
	sta $08,x
rmu_0bdd86
	rts
rmu_nameglyph
	phx
rmu_0bdd88
	asl a
rmu_0bdd89
	tax
rmu_0bdd8a
	lda.l retail_recordfont,x
rmu_0bdd8e
	sta.w race_spritesleft
rmu_0bdd91
	ldx.w race_menutemp
rmu_0bdd94
	lda.l race_spritelists+4,x
rmu_0bdd98
	and #$fe00
rmu_0bdd9b
	ora.w race_spritesleft
rmu_0bdd9e
	sta.l race_spritelists+4,x
rmu_0bdda2
	lda.w race_menutemp
rmu_0bdda5
	clc
rmu_0bdda6
	adc #$0008
rmu_0bdda9
	sta.w race_menutemp
rmu_0bddac
	lda.w race_spritesleft
rmu_0bddaf
	clc
rmu_0bddb0
	adc #$0010
rmu_0bddb3
	sta.w race_spritesleft
rmu_0bddb6
	ldx.w race_menutemp
rmu_0bddb9
	lda.l race_spritelists+4,x
rmu_0bddbd
	and #$fe00
rmu_0bddc0
	ora.w race_spritesleft
rmu_0bddc3
	sta.l race_spritelists+4,x
rmu_0bddc7
	lda.w race_menutemp
rmu_0bddca
	clc
rmu_0bddcb
	adc #$0008
rmu_0bddce
	sta.w race_menutemp
rmu_0bddd1
	plx
rmu_0bddd2
	rts
rmu_recordtime
	jsl retail_clonespritelist_l
rmu_0bde0e
	lda $12,x
rmu_0bde10
	inc a
rmu_0bde11
	inc a
rmu_0bde12
	sta.w race_oamword
rmu_0bde15
	lda $22,x
rmu_0bde17
	tax
rmu_0bde18
	lda.l race_recordtimes+2,x
rmu_0bde1c
	pha
rmu_0bde1d
	phx
rmu_0bde1e
	and #$00ff
rmu_0bde21
	cmp #$00ff
rmu_0bde24
	bne rmu_0bde29
rmu_0bde26
	jsr rmu_recordmissing
rmu_0bde29
	plx
rmu_0bde2a
	pla
rmu_0bde2b
	jsr rmu_timebyte
rmu_0bde2e
	lda.l race_recordtimes+1,x
rmu_0bde32
	jsr rmu_timebyte
rmu_0bde35
	lda.l race_recordtimes,x
rmu_0bde39
	jsr rmu_timebyte
rmu_0bde3c
	ldx.w race_entitycurrent
rmu_0bde3f
	lda.l race_recordselected
rmu_0bde43
	and #$00ff
rmu_0bde46
	cmp $20,x
rmu_0bde48
	bne rmu_0bde63
rmu_0bde4a
	lda.l race_menumode
rmu_0bde4e
	and #$00ff
rmu_0bde51
	cmp #$0008
rmu_0bde54
	bne rmu_0bde63
rmu_0bde56
	ldx.w race_entitycurrent
rmu_0bde59
	lda #rhk_recordflash&WM
rmu_0bde5c
	sta $08,x
rmu_0bde5e
	stz $22,x
rmu_0bde60
	stz $0a,x
rmu_0bde62
	rts
rmu_0bde63
	lda #rhk_recordidle&WM
rmu_0bde66
	sta $08,x
rmu_0bde68
	rts
rmu_timebyte
	and #$00ff
rmu_0bde6c
	sta.w race_menutemp
rmu_0bde6f
	lsr a
rmu_0bde70
	lsr a
rmu_0bde71
	lsr a
rmu_0bde72
	lsr a
rmu_0bde73
	and #$000f
rmu_0bde76
	jsr rmu_timeglyph
rmu_0bde79
	lda.w race_menutemp
rmu_0bde7c
	and #$000f
rmu_0bde7f
	jsr rmu_timeglyph
rmu_0bde82
	rts
rmu_timeglyph
	phx
rmu_0bde84
	cmp #$000f
rmu_0bde87
	bne rmu_0bde8c
rmu_0bde89
	lda #$0044
rmu_0bde8c
	clc
rmu_0bde8d
	adc #$0050
rmu_0bde90
	sta.w race_spritesleft
rmu_0bde93
	ldx.w race_oamword
rmu_0bde96
	lda.l race_spritelists+4,x
rmu_0bde9a
	and #$fe00
rmu_0bde9d
	ora.w race_spritesleft
rmu_0bdea0
	sta.l race_spritelists+4,x
rmu_0bdea4
	lda.w race_oamword
rmu_0bdea7
	clc
rmu_0bdea8
	adc #$0008
rmu_0bdeab
	sta.w race_oamword
rmu_0bdeae
	lda.w race_spritesleft
rmu_0bdeb1
	clc
rmu_0bdeb2
	adc #$0010
rmu_0bdeb5
	sta.w race_spritesleft
rmu_0bdeb8
	ldx.w race_oamword
rmu_0bdebb
	lda.l race_spritelists+4,x
rmu_0bdebf
	and #$fe00
rmu_0bdec2
	ora.w race_spritesleft
rmu_0bdec5
	sta.l race_spritelists+4,x
rmu_0bdec9
	lda.w race_oamword
rmu_0bdecc
	clc
rmu_0bdecd
	adc #$0008
rmu_0bded0
	sta.w race_oamword
rmu_0bded3
	plx
rmu_0bded4
	rts
rmu_recordmissing
	lda.w race_oambits
rmu_0bded8
	pha
rmu_0bded9
	lda.w race_oamword
rmu_0bdedc
	pha
rmu_0bdedd
	ldx.w race_entitycurrent
rmu_0bdee0
	lda $1a,x
rmu_0bdee2
	cmp #$0020
rmu_0bdee5
	beq rmu_0bdf3a
rmu_0bdee7
	cmp #$0021
rmu_0bdeea
	beq rmu_0bdf13
rmu_0bdeec
	lda #$0025
rmu_0bdeef
	jsl retail_findentity_l
rmu_0bdef2
	jsr rmu_blankname
rmu_0bdef5
	lda #$001f
rmu_0bdef8
	jsl retail_findentity_l
rmu_0bdefb
	lda #$ffff
rmu_0bdefe
	sta $10,x
rmu_0bdf00
	lda #$0200
rmu_0bdf03
	sta $02,x
rmu_0bdf05
	lda #rhk_recordidle&WM
rmu_0bdf08
	sta $08,x
rmu_0bdf0a
	pla
rmu_0bdf0b
	sta.w race_oamword
rmu_0bdf0e
	pla
rmu_0bdf0f
	sta.w race_oambits
rmu_0bdf12
	rts
rmu_0bdf13
	lda #$0024
rmu_0bdf16
	jsl retail_findentity_l
rmu_0bdf19
	jsr rmu_blankname
rmu_0bdf1c
	lda #$001e
rmu_0bdf1f
	jsl retail_findentity_l
rmu_0bdf22
	lda #$ffff
rmu_0bdf25
	sta $10,x
rmu_0bdf27
	lda #$0200
rmu_0bdf2a
	sta $02,x
rmu_0bdf2c
	lda #rhk_recordidle&WM
rmu_0bdf2f
	sta $08,x
rmu_0bdf31
	pla
rmu_0bdf32
	sta.w race_oamword
rmu_0bdf35
	pla
rmu_0bdf36
	sta.w race_oambits
rmu_0bdf39
	rts
rmu_0bdf3a
	lda #$0023
rmu_0bdf3d
	jsl retail_findentity_l
rmu_0bdf40
	jsr rmu_blankname
rmu_0bdf43
	lda #$001d
rmu_0bdf46
	jsl retail_findentity_l
rmu_0bdf49
	lda #$ffff
rmu_0bdf4c
	sta $10,x
rmu_0bdf4e
	lda #$0200
rmu_0bdf51
	sta $02,x
rmu_0bdf53
	lda #rhk_recordidle&WM
rmu_0bdf56
	sta $08,x
rmu_0bdf58
	pla
rmu_0bdf59
	sta.w race_oamword
rmu_0bdf5c
	pla
rmu_0bdf5d
	sta.w race_oambits
rmu_0bdf60
	rts
rmu_blankname
	lda $12,x
rmu_0bdf63
	inc a
rmu_0bdf64
	inc a
rmu_0bdf65
	sta.w race_menutemp
rmu_0bdf68
	lda #$001a
rmu_0bdf6b
	jsr rmu_nameglyph
rmu_0bdf6e
	lda #$001a
rmu_0bdf71
	jsr rmu_nameglyph
rmu_0bdf74
	lda #$001a
rmu_0bdf77
	jsr rmu_nameglyph
rmu_0bdf7a
	rts
rmu_recordidle
	rts
rmu_vehicletiles
	dec $0a,x
rmu_0bdf7e
	bpl rmu_0bdfca
rmu_0bdf80
	lda #$0006
rmu_0bdf83
	sta $0a,x
rmu_0bdf85
	lda $22,x
rmu_0bdf87
	inc a
rmu_0bdf88
	and #$0003
rmu_0bdf8b
	sta $22,x
rmu_0bdf8d
	asl a
rmu_0bdf8e
	tax
rmu_0bdf8f
	lda.l retail_recordframes,x
rmu_0bdf93
	sta.w race_oambits
rmu_0bdf96
	lda.l race_menucurrent
rmu_0bdf9a
	asl a
rmu_0bdf9b
	tax
rmu_0bdf9c
	lda.l retail_recordcars,x
rmu_0bdfa0
	clc
rmu_0bdfa1
	adc.w race_oambits
rmu_0bdfa4
	clc
rmu_0bdfa5
	adc #$3000
rmu_0bdfa8
	ai16
rmu_0bdfaa
	sta.w race_transfersource
rmu_0bdfad
	lda #$0080
rmu_0bdfb0
	sta.w race_transferbytes
rmu_0bdfb3
	lda #$0070
rmu_0bdfb6
	sta.w race_transferbank
rmu_0bdfb9
	lda #$15c0
rmu_0bdfbc
	sta.w race_transferdest
rmu_0bdfbf
	jsl retail_queuegraphics_l
rmu_0bdfc3
	a16
rmu_0bdfc5
	i16
rmu_0bdfc7
	ldx.w race_entitycurrent
rmu_0bdfca
	rts
rmu_rank0
	dec $0a,x
rmu_0bdfdd
	bpl rmu_0be005
rmu_0bdfdf
	stz $10,x
rmu_0bdfe1
	lda #rhk_0be018&WM
rmu_0bdfe4
	sta $08,x
rmu_0bdfe6
	lda.l race_menumode
rmu_0bdfea
	and #$00ff
rmu_0bdfed
	cmp #$0008
rmu_0bdff0
	beq rmu_0be00c
rmu_0bdff2
	lda.l race_menurank
rmu_0bdff6
	and #$00ff
rmu_0bdff9
	cmp #$0000
rmu_0bdffc
	beq rmu_0be002
rmu_0bdffe
	bcc rmu_0be006
rmu_0be000
	bne rmu_0be00c
rmu_0be002
	jsr rmu_rankmode
rmu_0be005
	rts
rmu_0be006
	lda #$ffff
rmu_0be009
	sta $10,x
rmu_0be00b
	rts
rmu_0be00c
	lda #$0000
rmu_0be00f
	jsr rmu_rankvalue
rmu_0be012
	lda #rhk_0be0df&WM
rmu_0be015
	sta $08,x
rmu_0be017
	rts
rmu_0be018
	jsl retail_stepentityanim_l
rmu_0be01b
	rts
rmu_rank1
	dec $0a,x
rmu_0be01e
	bpl rmu_0be046
rmu_0be020
	stz $10,x
rmu_0be022
	lda #rhk_0be059&WM
rmu_0be025
	sta $08,x
rmu_0be027
	lda.l race_menumode
rmu_0be02b
	and #$00ff
rmu_0be02e
	cmp #$0008
rmu_0be031
	beq rmu_0be04d
rmu_0be033
	lda.l race_menurank
rmu_0be037
	and #$00ff
rmu_0be03a
	cmp #$0001
rmu_0be03d
	beq rmu_0be043
rmu_0be03f
	bcc rmu_0be047
rmu_0be041
	bne rmu_0be04d
rmu_0be043
	jsr rmu_rankmode
rmu_0be046
	rts
rmu_0be047
	lda #$ffff
rmu_0be04a
	sta $10,x
rmu_0be04c
	rts
rmu_0be04d
	lda #$0001
rmu_0be050
	jsr rmu_rankvalue
rmu_0be053
	lda #rhk_0be0df&WM
rmu_0be056
	sta $08,x
rmu_0be058
	rts
rmu_0be059
	jsl retail_stepentityanim_l
rmu_0be05c
	rts
rmu_rank2
	dec $0a,x
rmu_0be05f
	bpl rmu_0be087
rmu_0be061
	stz $10,x
rmu_0be063
	lda #rhk_0be09a&WM
rmu_0be066
	sta $08,x
rmu_0be068
	lda.l race_menumode
rmu_0be06c
	and #$00ff
rmu_0be06f
	cmp #$0008
rmu_0be072
	beq rmu_0be08e
rmu_0be074
	lda.l race_menurank
rmu_0be078
	and #$00ff
rmu_0be07b
	cmp #$0002
rmu_0be07e
	beq rmu_0be084
rmu_0be080
	bcc rmu_0be088
rmu_0be082
	bne rmu_0be08e
rmu_0be084
	jsr rmu_rankmode
rmu_0be087
	rts
rmu_0be088
	lda #$ffff
rmu_0be08b
	sta $10,x
rmu_0be08d
	rts
rmu_0be08e
	lda #$0002
rmu_0be091
	jsr rmu_rankvalue
rmu_0be094
	lda #rhk_0be0df&WM
rmu_0be097
	sta $08,x
rmu_0be099
	rts
rmu_0be09a
	jsl retail_stepentityanim_l
rmu_0be09d
	rts
rmu_rank3
	dec $0a,x
rmu_0be0a0
	bpl rmu_0be0c8
rmu_0be0a2
	stz $10,x
rmu_0be0a4
	lda #rhk_0be0db&WM
rmu_0be0a7
	sta $08,x
rmu_0be0a9
	lda.l race_menumode
rmu_0be0ad
	and #$00ff
rmu_0be0b0
	cmp #$0008
rmu_0be0b3
	beq rmu_0be0cf
rmu_0be0b5
	lda.l race_menurank
rmu_0be0b9
	and #$00ff
rmu_0be0bc
	cmp #$0003
rmu_0be0bf
	beq rmu_0be0c5
rmu_0be0c1
	bcc rmu_0be0c9
rmu_0be0c3
	bne rmu_0be0cf
rmu_0be0c5
	jsr rmu_rankmode
rmu_0be0c8
	rts
rmu_0be0c9
	lda #$ffff
rmu_0be0cc
	sta $10,x
rmu_0be0ce
	rts
rmu_0be0cf
	lda #$0003
rmu_0be0d2
	jsr rmu_rankvalue
rmu_0be0d5
	lda #rhk_0be0df&WM
rmu_0be0d8
	sta $08,x
rmu_0be0da
	rts
rmu_0be0db
	jsl retail_stepentityanim_l
rmu_0be0de
	rts
rmu_0be0df
	rts
rmu_rankvalue
	pha
rmu_0be0e1
	jsl retail_clonespritelist_l
rmu_0be0e4
	pla
rmu_0be0e5
	sta.w race_oambits
rmu_0be0e8
	lda $12,x
rmu_0be0ea
	inc a
rmu_0be0eb
	inc a
rmu_0be0ec
	sta.w race_oamword
rmu_0be0ef
	lda.w race_oambits
rmu_0be0f2
	asl a
rmu_0be0f3
	clc
rmu_0be0f4
	adc.w race_oambits
rmu_0be0f7
	tax
rmu_0be0f8
	lda.l race_rankvalues+2,x
rmu_0be0fc
	and #$000f
rmu_0be0ff
	jsr rmu_rankglyph
rmu_0be102
	lda.l race_rankvalues+1,x
rmu_0be106
	jsr rmu_rankbyte
rmu_0be109
	lda.l race_rankvalues,x
rmu_0be10d
	jsr rmu_rankbyte
rmu_0be110
	ldx.w race_entitycurrent
rmu_0be113
	rts
rmu_rankbyte
	and #$00ff
rmu_0be117
	sta.w race_menutemp
rmu_0be11a
	lsr a
rmu_0be11b
	lsr a
rmu_0be11c
	lsr a
rmu_0be11d
	lsr a
rmu_0be11e
	and #$000f
rmu_0be121
	jsr rmu_rankglyph
rmu_0be124
	lda.w race_menutemp
rmu_0be127
	and #$000f
rmu_0be12a
	jsr rmu_rankglyph
rmu_0be12d
	rts
rmu_rankglyph
	phx
rmu_0be12f
	sta.w race_spritesleft
rmu_0be132
	ldx.w race_oamword
rmu_0be135
	lda.l race_spritelists+4,x
rmu_0be139
	and #$fe00
rmu_0be13c
	ora.w race_spritesleft
rmu_0be13f
	sta.l race_spritelists+4,x
rmu_0be143
	lda.w race_oamword
rmu_0be146
	clc
rmu_0be147
	adc #$0008
rmu_0be14a
	sta.w race_oamword
rmu_0be14d
	plx
rmu_0be14e
	rts
rmu_rankmode
	lda.l race_menumode
rmu_0be153
	and #$00ff
rmu_0be156
	cmp #$0006
rmu_0be159
	beq rmu_0be170
rmu_0be15b
	cmp #$000a
rmu_0be15e
	beq rmu_0be181
rmu_0be160
	cmp #$000c
rmu_0be163
	beq rmu_0be192
rmu_0be165
	cmp #$000e
rmu_0be168
	beq rmu_0be1a3
rmu_0be16a
	cmp #$0010
rmu_0be16d
	beq rmu_0be1b4
rmu_0be16f
	rts
rmu_0be170
	lda $14,x
rmu_0be172
	cmp #$01a4
rmu_0be175
	beq rmu_0be180
rmu_0be177
	lda #$01a4
rmu_0be17a
	sta $14,x
rmu_0be17c
	stz $16,x
rmu_0be17e
	stz $18,x
rmu_0be180
	rts
rmu_0be181
	lda $14,x
rmu_0be183
	cmp #$017c
rmu_0be186
	beq rmu_0be191
rmu_0be188
	lda #$017c
rmu_0be18b
	sta $14,x
rmu_0be18d
	stz $16,x
rmu_0be18f
	stz $18,x
rmu_0be191
	rts
rmu_0be192
	lda $14,x
rmu_0be194
	cmp #$019a
rmu_0be197
	beq rmu_0be1a2
rmu_0be199
	lda #$019a
rmu_0be19c
	sta $14,x
rmu_0be19e
	stz $16,x
rmu_0be1a0
	stz $18,x
rmu_0be1a2
	rts
rmu_0be1a3
	lda $14,x
rmu_0be1a5
	cmp #$0190
rmu_0be1a8
	beq rmu_0be1b3
rmu_0be1aa
	lda #$0190
rmu_0be1ad
	sta $14,x
rmu_0be1af
	stz $16,x
rmu_0be1b1
	stz $18,x
rmu_0be1b3
	rts
rmu_0be1b4
	lda $14,x
rmu_0be1b6
	cmp #$0186
rmu_0be1b9
	beq rmu_0be1c4
rmu_0be1bb
	lda #$0186
rmu_0be1be
	sta $14,x
rmu_0be1c0
	stz $16,x
rmu_0be1c2
	stz $18,x
rmu_0be1c4
	rts
rmu_recordgroupwide
	a16
rmu_recordgroup
	php
rmu_0be459
	ai16
rmu_0be45b
	stx.w race_entityx
rmu_0be45e
	ldx.w race_entityx
rmu_0be461
	lda.l retail_recordgroupbase,x
rmu_0be465
	bmi rmu_0be478
rmu_0be467
	tax
rmu_0be468
	jsr rmu_0be4b5
rmu_0be46b
	cpx #$ffff
rmu_0be46e
	beq rmu_0be47a
rmu_0be470
	inc.w race_entityx
rmu_0be473
	inc.w race_entityx
rmu_0be476
	bra rmu_0be45e
rmu_0be478
	plp
rmu_0be479
	rtl
rmu_0be47a
	a8
rmu_0be47c
	lda #$0f
rmu_0be47e
	sta.l $002100
rmu_0be482
	lda #$00
rmu_0be484
	sta.l $00420c
rmu_0be488
	sta.l $004200
rmu_0be48c
	sta.l $00212c
rmu_0be490
	ldx #$0000
rmu_0be493
	txy
rmu_0be494
	txa
rmu_0be495
	sta.l $002121
rmu_0be499
	sta.l $002121
rmu_0be49d
	tya
rmu_0be49e
	sta.l $002122
rmu_0be4a2
	sta.l $002122
rmu_0be4a6
	iny
rmu_0be4a7
	nop
rmu_0be4a8
	nop
rmu_0be4a9
	nop
rmu_0be4aa
	nop
rmu_0be4ab
	nop
rmu_0be4ac
	nop
rmu_0be4ad
	nop
rmu_0be4ae
	nop
rmu_0be4af
	nop
rmu_0be4b0
	jmp rmu_0be494
	longa
rmu_newrecord
	a16
rmu_0be4b5
	txy
rmu_0be4b6
	jsr rmu_newentity
rmu_0be4b9
	cpx #$ffff
rmu_0be4bc
	bne rmu_0be4c1
rmu_0be4be
	brl rmu_0be4e3
rmu_0be4c1
	stx.w race_newentity
rmu_0be4c4
	tyx
rmu_0be4c5
	lda.l retail_recorddefbase,x
rmu_0be4c9
	bmi rmu_0be4df
rmu_0be4cb
	clc
rmu_0be4cc
	adc.w race_newentity
rmu_0be4cf
	tay
rmu_0be4d0
	lda.l retail_recorddefbase+2,x
rmu_0be4d4
	sta.w $0000,y
rmu_0be4d7
	txa
rmu_0be4d8
	clc
rmu_0be4d9
	adc #$0004
rmu_0be4dc
	tax
rmu_0be4dd
	bra rmu_0be4c5
rmu_0be4df
	ldx.w race_newentity
rmu_0be4e2
	rts
rmu_0be4e3
	ldx #$ffff
rmu_0be4e6
	rts
rmu_queuescroll
	php
rmu_0bf444
	ai8
rmu_0bf446
	lda #$00
rmu_0bf448
	a8
rmu_0bf44a
	i16
rmu_0bf44c
	phx
rmu_0bf44d
	ldx #$210d
rmu_0bf450
	jsl retail_queueregister_l
rmu_0bf454
	plx
rmu_0bf455
	a8
rmu_0bf457
	i16
rmu_0bf459
	phx
rmu_0bf45a
	ldx #$210d
rmu_0bf45d
	jsl retail_queueregister_l
rmu_0bf461
	plx
rmu_0bf462
	a8
rmu_0bf464
	i16
rmu_0bf466
	phx
rmu_0bf467
	ldx #$210f
rmu_0bf46a
	jsl retail_queueregister_l
rmu_0bf46e
	plx
rmu_0bf46f
	a8
rmu_0bf471
	i16
rmu_0bf473
	phx
rmu_0bf474
	ldx #$210f
rmu_0bf477
	jsl retail_queueregister_l
rmu_0bf47b
	plx
rmu_0bf47c
	a8
rmu_0bf47e
	i16
rmu_0bf480
	phx
rmu_0bf481
	ldx #$210e
rmu_0bf484
	jsl retail_queueregister_l
rmu_0bf488
	plx
rmu_0bf489
	a8
rmu_0bf48b
	i16
rmu_0bf48d
	phx
rmu_0bf48e
	ldx #$210e
rmu_0bf491
	jsl retail_queueregister_l
rmu_0bf495
	plx
rmu_0bf496
	a8
rmu_0bf498
	i16
rmu_0bf49a
	phx
rmu_0bf49b
	ldx #$2110
rmu_0bf49e
	jsl retail_queueregister_l
rmu_0bf4a2
	plx
rmu_0bf4a3
	a8
rmu_0bf4a5
	i16
rmu_0bf4a7
	phx
rmu_0bf4a8
	ldx #$2110
rmu_0bf4ab
	jsl retail_queueregister_l
rmu_0bf4af
	plx
rmu_0bf4b0
	plp
rmu_0bf4b1
	rts
	longa
rmu_recordwindow
	php
rmu_0bf678
	a8
rmu_0bf67a
	lda #$22
rmu_0bf67c
	sta.w $2123
rmu_0bf67f
	lda #$00
rmu_0bf681
	sta.w $2124
rmu_0bf684
	lda #$30
rmu_0bf686
	sta.w $2125
rmu_0bf689
	lda #$20
rmu_0bf68b
	sta.w $2126
rmu_0bf68e
	lda #$88
rmu_0bf690
	sta.w $2127
rmu_0bf693
	lda #$01
rmu_0bf695
	sta.w $212e
rmu_0bf698
	sta.w $212f
rmu_0bf69b
	sta.w $212d
rmu_0bf69e
	plp
rmu_0bf69f
	rts
	longa
rmu_recordmath
	php
rmu_0bf6a1
	a8
rmu_0bf6a3
	lda #$41
rmu_0bf6a5
	sta.l $002131
rmu_0bf6a9
	lda #$02
rmu_0bf6ab
	sta.l $002130
rmu_0bf6af
	lda #$00
rmu_0bf6b1
	sta.w $212d
rmu_0bf6b4
	plp
rmu_0bf6b5
	rts
	longa
rmu_menutilemap
	php
rmu_0bf6eb
	ai16
rmu_0bf6ed
	ldx #$0000
rmu_0bf6f0
	ldy #$017f
rmu_0bf6f3
	lda.l $703000,x
rmu_0bf6f7
	clc
rmu_0bf6f8
	adc #$0100
rmu_0bf6fb
	sta.l $703000,x
rmu_0bf6ff
	sta.l $703800,x
rmu_0bf703
	inx
rmu_0bf704
	inx
rmu_0bf705
	dey
rmu_0bf706
	bpl rmu_0bf6f3
rmu_0bf708
	lda #$000a
rmu_0bf70b
	sta.w race_oambits
rmu_0bf70e
	ldy #$0003
rmu_0bf711
	lda.l $703000,x
rmu_0bf715
	clc
rmu_0bf716
	adc #$0100
rmu_0bf719
	sta.l $703000,x
rmu_0bf71d
	sta.l $703800,x
rmu_0bf721
	inx
rmu_0bf722
	inx
rmu_0bf723
	dey
rmu_0bf724
	bpl rmu_0bf711
rmu_0bf726
	lda.w race_oamword
rmu_0bf729
	ora #$2000
rmu_0bf72c
	ldy #$000c
rmu_0bf72f
	pha
rmu_0bf730
	lda.l $703000,x
rmu_0bf734
	clc
rmu_0bf735
	adc #$0100
rmu_0bf738
	sta.l $703800,x
rmu_0bf73c
	pla
rmu_0bf73d
	sta.l $703000,x
rmu_0bf741
	clc
rmu_0bf742
	adc #$000b
rmu_0bf745
	inx
rmu_0bf746
	inx
rmu_0bf747
	dey
rmu_0bf748
	bpl rmu_0bf72f
rmu_0bf74a
	ldy #$000e
rmu_0bf74d
	lda.l $703000,x
rmu_0bf751
	clc
rmu_0bf752
	adc #$0100
rmu_0bf755
	sta.l $703000,x
rmu_0bf759
	sta.l $703800,x
rmu_0bf75d
	inx
rmu_0bf75e
	inx
rmu_0bf75f
	dey
rmu_0bf760
	bpl rmu_0bf74d
rmu_0bf762
	inc.w race_oamword
rmu_0bf765
	dec.w race_oambits
rmu_0bf768
	bpl rmu_0bf70e
rmu_0bf76a
	ldy #$009f
rmu_0bf76d
	lda.l $703000,x
rmu_0bf771
	clc
rmu_0bf772
	adc #$0100
rmu_0bf775
	sta.l $703000,x
rmu_0bf779
	sta.l $703800,x
rmu_0bf77d
	inx
rmu_0bf77e
	inx
rmu_0bf77f
	dey
rmu_0bf780
	bpl rmu_0bf76d
rmu_0bf782
	plp
rmu_0bf783
	rts
retail_pushinput0_l
	jsr rmu_pushinput0
	rtl
retail_pushinput1_l
	jsr rmu_pushinput1
	rtl
retail_newentity_l
	jsr rmu_newentity
	rtl
retail_menucursor_l
	jsr rmu_menucursor
	rtl
retail_menuselected_l
	jsr rmu_menuselected
	rtl
retail_menuinputs_l
	jsr rmu_menuinputs
	rtl
retail_menuinput_l
	jsr rmu_menuinput
	rtl
retail_menulabels_l
	jsr rmu_menulabels
	rtl
retail_dimcolor_l
	jsr rmu_dimcolor
	rtl
retail_brightcolor_l
	jsr rmu_brightcolor
	rtl
retail_trackleft_l
	jsr rmu_trackleft
	rtl
retail_trackright_l
	jsr rmu_trackright
	rtl
retail_entityvisibility_l
	jsr rmu_entityvisibility
	rtl
retail_menudefaults_l
	jsr rmu_menudefaults
	rtl
retail_delayanim_l
	jsr rmu_delayanim
	rtl
retail_animate_l
	jsr rmu_animate
	rtl
retail_recordwait_l
	jsr rmu_recordwait
	rtl
retail_recordopen_l
	jsr rmu_recordopen
	rtl
retail_recordshade0_l
	jsr rmu_recordshade0
	rtl
retail_recordshade1_l
	jsr rmu_recordshade1
	rtl
retail_recordwinner_l
	jsr rmu_recordwinner
	rtl
retail_recordvehicle_l
	jsr rmu_recordvehicle
	rtl
retail_recordindex_l
	jsr rmu_recordindex
	rtl
retail_recordslide_l
	jsr rmu_recordslide
	rtl
retail_recordflash_l
	jsr rmu_recordflash
	rtl
retail_spritepalette_l
	jsr rmu_spritepalette
	rtl
retail_recordinput_l
	jsr rmu_recordinput
	rtl
retail_recordclose_l
	jsr rmu_recordclose
	rtl
retail_recordreopen_l
	jsr rmu_recordreopen
	rtl
retail_recordexit_l
	jsr rmu_recordexit
	rtl
retail_recordtotal_l
	jsr rmu_recordtotal
	rtl
retail_recordflag_l
	jsr rmu_recordflag
	rtl
retail_recordname_l
	jsr rmu_recordname
	rtl
retail_nameglyph_l
	jsr rmu_nameglyph
	rtl
retail_recordtime_l
	jsr rmu_recordtime
	rtl
retail_timebyte_l
	jsr rmu_timebyte
	rtl
retail_timeglyph_l
	jsr rmu_timeglyph
	rtl
retail_recordmissing_l
	jsr rmu_recordmissing
	rtl
retail_blankname_l
	jsr rmu_blankname
	rtl
retail_recordidle_l
	jsr rmu_recordidle
	rtl
retail_vehicletiles_l
	jsr rmu_vehicletiles
	rtl
retail_rank0_l
	jsr rmu_rank0
	rtl
retail_rank1_l
	jsr rmu_rank1
	rtl
retail_rank2_l
	jsr rmu_rank2
	rtl
retail_rank3_l
	jsr rmu_rank3
	rtl
retail_rankvalue_l
	jsr rmu_rankvalue
	rtl
retail_rankbyte_l
	jsr rmu_rankbyte
	rtl
retail_rankglyph_l
	jsr rmu_rankglyph
	rtl
retail_rankmode_l
	jsr rmu_rankmode
	rtl
retail_newrecord_l
	jsr rmu_newrecord
	rtl
retail_queuescroll_l
	jsr rmu_queuescroll
	rtl
retail_recordwindow_l
	jsr rmu_recordwindow
	rtl
retail_recordmath_l
	jsr rmu_recordmath
	rtl
retail_menutilemap_l
	jsr rmu_menutilemap
	rtl
rmc_trackleft
	jsr rmu_trackleft
	rtl
rmc_trackright
	jsr rmu_trackright
	rtl
rmc_delayanim
	jsr rmu_delayanim
	rtl
rmc_animate
	jsr rmu_animate
	rtl
rmc_recordwait
	jsr rmu_recordwait
	rtl
rmc_recordopen
	jsr rmu_recordopen
	rtl
rmc_recordshade0
	jsr rmu_recordshade0
	rtl
rmc_recordshade1
	jsr rmu_recordshade1
	rtl
rmc_recordwinner
	jsr rmu_recordwinner
	rtl
rmc_recordvehicle
	jsr rmu_recordvehicle
	rtl
rmc_recordslide
	jsr rmu_recordslide
	rtl
rmc_recordflash
	jsr rmu_recordflash
	rtl
rmc_recordinput
	jsr rmu_recordinput
	rtl
rmc_recordclose
	jsr rmu_recordclose
	rtl
rmc_recordreopen
	jsr rmu_recordreopen
	rtl
rmc_recordexit
	jsr rmu_recordexit
	rtl
rmc_recordtotal
	jsr rmu_recordtotal
	rtl
rmc_recordflag
	jsr rmu_recordflag
	rtl
rmc_recordname
	jsr rmu_recordname
	rtl
rmc_recordtime
	jsr rmu_recordtime
	rtl
rmc_recordidle
	jsr rmu_recordidle
	rtl
rmc_vehicletiles
	jsr rmu_vehicletiles
	rtl
rmc_rank0
	jsr rmu_rank0
	rtl
rmc_0be018
	jsr rmu_0be018
	rtl
rmc_rank1
	jsr rmu_rank1
	rtl
rmc_0be059
	jsr rmu_0be059
	rtl
rmc_rank2
	jsr rmu_rank2
	rtl
rmc_0be09a
	jsr rmu_0be09a
	rtl
rmc_rank3
	jsr rmu_rank3
	rtl
rmc_0be0db
	jsr rmu_0be0db
	rtl
rmc_0be0df
	jsr rmu_0be0df
	rtl
	longa
	longi
rmu_lastspill
	lda.l retail_entitytemplate+44
	sta.w race_regbytes
	lda.l retail_entitytemplate+46
	sta.w race_regbytes+2
	lda.l retail_entitytemplate+48
	sta.w race_regbytes+4
	lda.l retail_entitytemplate+50
	sta.w race_regbytes+6
	lda.l retail_entitytemplate+52
	sta.w race_regbytes+8
	lda.l retail_entitytemplate+54
	sta.w race_regbytes+10
	lda.l retail_entitytemplate+56
	sta.w race_regbytes+12
	lda.l retail_entitytemplate+58
	sta.w race_regbytes+14
	lda.l retail_entitytemplate+60
	sta.w race_regbytes+16
	lda.l retail_entitytemplate+62
	sta.w race_regbytes+18
	lda.l retail_entitytemplate+64
	sta.w race_regbytes+20
	lda.l retail_entitytemplate+66
	sta.w race_regbytes+22
	lda.l retail_entitytemplate+68
	sta.w race_regbytes+24
	lda.l retail_entitytemplate+70
	sta.w race_regbytes+26
	lda.l retail_entitytemplate+72
	sta.w race_regbytes+28
	lda.l retail_entitytemplate+74
	sta.w race_regbytes+30
	lda.l retail_entitytemplate+76
	sta.w race_regbytes+32
	lda.l retail_entitytemplate+78
	sta.w race_regbytes+34
	lda.l retail_entitytemplate+80
	sta.w race_regbytes+36
	lda.l retail_entitytemplate+82
	sta.w race_regbytes+38
	lda.l retail_entitytemplate+84
	sta.w race_regbytes+40
	lda.l retail_entitytemplate+86
	sta.w race_regbytes+42
	rts
retail_recordgroupids
	dw $0290
	dw $029e
	dw $02bc
	dw $02da
	dw $02f8
	dw $04b2
	dw $049c
	dw $0328
	dw $0346
	dw $0364
	dw $03dc
	dw $03fe
	dw $0420
	dw $0442
	dw $0460
	dw $047e
	dw $0382
	dw $03a0
	dw $03be
	dw $0316
	dw $ffff
retail_recordgroupids_end
retail_menuselectbits
	dw $0001
	dw $0002
	dw $0001
	dw $0002
retail_menuselectbits_end
retail_menuleft
	dw $0001
	dw $0003
	dw $0000
	dw $0002
retail_menuleft_end
retail_menuright
	dw $0002
	dw $0000
	dw $0003
	dw $0001
retail_menuright_end
retail_menulabelanims
	dw $0036
	dw $009c
	dw $003c
	dw $00a2
	dw $0030
	dw $0096
	dw $0042
	dw $00a8
retail_menulabelanims_end
retail_recordcaranims
	dw $01ae
	dw $01c6
	dw $01de
	dw $01f6
	dw $01b4
	dw $01cc
	dw $01e4
	dw $01fc
retail_recordcaranims_end
retail_recordpalettes
	dw $0200
	dw $0600
retail_recordpalettes_end
retail_recordfont
	dw $005a
	dw $005b
	dw $005c
	dw $005d
	dw $005e
	dw $005f
	dw $0070
	dw $0071
	dw $0072
	dw $0073
	dw $0074
	dw $0075
	dw $0076
	dw $0077
	dw $0078
	dw $0079
	dw $007a
	dw $007b
	dw $007c
	dw $007d
	dw $007e
	dw $007f
	dw $0090
	dw $0091
	dw $0092
	dw $0093
	dw $0094
	dw $0095
retail_recordfont_end
retail_recordframes
	dw $0000
	dw $0200
	dw $0400
	dw $0200
retail_recordframes_end
retail_recordcars
	dw $0080
	dw $0100
	dw $0000
	dw $0180
retail_recordcars_end
retail_recorddefinitions
rmu_definition0290
	dw 8,rhk_recordwait&WM
	dw 10,$0020
	dw 16,$ffff
	dw -1
rmu_definition029e
	dw 2,$0052
	dw 6,$0062
	dw 8,rhk_rank0&WM
	dw 20,$0176
	dw 26,$0014
	dw 10,$0030
	dw 16,$ffff
	dw -1
rmu_definition02bc
	dw 2,$00b0
	dw 6,$0062
	dw 8,rhk_rank1&WM
	dw 20,$0176
	dw 26,$0015
	dw 10,$0030
	dw 16,$ffff
	dw -1
rmu_definition02da
	dw 2,$0052
	dw 6,$0092
	dw 8,rhk_rank2&WM
	dw 20,$0176
	dw 26,$0016
	dw 10,$0030
	dw 16,$ffff
	dw -1
rmu_definition02f8
	dw 2,$00b0
	dw 6,$0092
	dw 8,rhk_rank3&WM
	dw 20,$0176
	dw 26,$0017
	dw 10,$0030
	dw 16,$ffff
	dw -1
rmu_definition0316
	dw 8,rhk_vehicletiles&WM
	dw 10,$0000
	dw 34,$0000
	dw 16,$ffff
	dw -1
rmu_definition0328
	dw 2,$0030
	dw 6,$0070
	dw 8,rhk_recordwinner&WM
	dw 20,$0214
	dw 26,$001a
	dw 34,$0001
	dw 16,$ffff
	dw -1
rmu_definition0346
	dw 2,$0030
	dw 6,$0088
	dw 8,rhk_recordwinner&WM
	dw 20,$021a
	dw 26,$001b
	dw 34,$0002
	dw 16,$ffff
	dw -1
rmu_definition0364
	dw 2,$0030
	dw 6,$00a0
	dw 8,rhk_recordwinner&WM
	dw 20,$0220
	dw 26,$001c
	dw 34,$0003
	dw 16,$ffff
	dw -1
rmu_definition0382
	dw 2,$0050
	dw 6,$0070
	dw 8,rhk_recordvehicle&WM
	dw 20,$01f6
	dw 26,$001d
	dw 34,$0001
	dw 16,$ffff
	dw -1
rmu_definition03a0
	dw 2,$0050
	dw 6,$0088
	dw 8,rhk_recordvehicle&WM
	dw 20,$01c6
	dw 26,$001e
	dw 34,$0002
	dw 16,$ffff
	dw -1
rmu_definition03be
	dw 2,$0050
	dw 6,$00a0
	dw 8,rhk_recordvehicle&WM
	dw 20,$01ae
	dw 26,$001f
	dw 34,$0003
	dw 16,$ffff
	dw -1
rmu_definition03dc
	dw 2,$008c
	dw 6,$0070
	dw 8,rhk_recordtime&WM
	dw 20,$0226
	dw 26,$0020
	dw 34,$0009
	dw 32,$0001
	dw 16,$ffff
	dw -1
rmu_definition03fe
	dw 2,$008c
	dw 6,$0088
	dw 8,rhk_recordtime&WM
	dw 20,$022c
	dw 26,$0021
	dw 34,$0015
	dw 32,$0002
	dw 16,$ffff
	dw -1
rmu_definition0420
	dw 2,$008c
	dw 6,$00a0
	dw 8,rhk_recordtime&WM
	dw 20,$0232
	dw 26,$0022
	dw 34,$0021
	dw 32,$0003
	dw 16,$ffff
	dw -1
rmu_definition0442
	dw 2,$00cc
	dw 6,$0070
	dw 8,rhk_recordname&WM
	dw 20,$023e
	dw 26,$0023
	dw 34,$0001
	dw 16,$ffff
	dw -1
rmu_definition0460
	dw 2,$00cc
	dw 6,$0088
	dw 8,rhk_recordname&WM
	dw 20,$0244
	dw 26,$0024
	dw 34,$0002
	dw 16,$ffff
	dw -1
rmu_definition047e
	dw 2,$00cc
	dw 6,$00a0
	dw 8,rhk_recordname&WM
	dw 20,$024a
	dw 26,$0025
	dw 34,$0003
	dw 16,$ffff
	dw -1
rmu_definition049c
	dw 2,$008c
	dw 6,$00c8
	dw 8,rhk_recordtotal&WM
	dw 20,$0238
	dw 26,$0018
	dw -1
rmu_definition04b2
	dw 2,$0050
	dw 6,$00c8
	dw 8,rhk_recordflag&WM
	dw 20,$020e
	dw 26,$0019
	dw -1
retail_recorddefinitions_end
retail_entitytemplate
	dw $0000
	dw $efef
	dw $0000
	dw $efef
	dw retail_entityidle&WM
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $ffff
	dw $ffff
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $8b08
	dw $20e2
	dw $10c2
	dw $00a9
	dw $ab48
	dw $80a9
	dw $008d
	dw $9c21
	dw $420c
	dw $0b9c
	dw $9c42
	dw $11da
	dw $009c
	dw $a942
	dw $8d03
	dw $2105
	dw $60a9
	dw $078d
	dw $a921
	dw $8d65
	dw $2108
	dw $00a9
retail_entitytemplate_end
retail_recorddefbase equ retail_recorddefinitions-$0290
retail_recordgroupbase equ retail_recordgroupids-$0036
retail_recordgroupwide_l equ rmu_recordgroupwide
retail_recordgroup_l equ rmu_recordgroup
mrmenu_end
