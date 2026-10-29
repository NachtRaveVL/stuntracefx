; Retail CPU/raw-dynamics bridge. A8/I16, D=0, DB=$7E unless noted.
; X selects an existing early scene record; its collision pointer names a
; retail-layout GSU body. Do not feed early CAR/WHL records to these entries.
; Visual shape stays in al_shape; collision header uses al_expshape.
; Bounds use al_expposx/y/z; shape frame uses al_colframe; the freeze state
; uses al_sbyte4 and the inactivity timer al_sword2. The linked control
; owner uses al_viewpt. These fields belong to this strategy while active.
; The early dispatcher is unchanged. Frontend actor selection, CPU shape
; ownership and complete retail game scheduling remain caller responsibilities.
; CPU producers update race_rawreset/race_rawspawnflags in the saved
; context; the next task restores that context before acquiring the GSU bus.

	incpublics	mrcpu.ext
mrcpu_begin
	shorta
	longi
; US $08:B402.
retail_stuckcar
	a16
mrcp_08b404
	phx
mrcp_08b405
	lda.l m_retailobjectcount
mrcp_08b409
	beq mrcp_08b463
mrcp_08b40b
	lda.w al_collobjptr,x
mrcp_08b40e
	tax
mrcp_08b40f
	lda.l $70002c,x
mrcp_08b413
	and #$0040
mrcp_08b416
	beq mrcp_08b463
mrcp_08b418
	lda.l $70008a,x
mrcp_08b41c
	and #$0010
mrcp_08b41f
	beq mrcp_08b463
mrcp_08b421
	lda.l $700040,x
mrcp_08b425
	and #$0100
mrcp_08b428
	bne mrcp_08b463
mrcp_08b42a
	lda #$0000
mrcp_08b42d
	sta.l $70002e,x
mrcp_08b431
	sta.l $700030,x
mrcp_08b435
	sta.l $700032,x
mrcp_08b439
	sta.l $700036,x
mrcp_08b43d
	sta.l $700034,x
mrcp_08b441
	sta.l $700038,x
mrcp_08b445
	lda.l $700082,x
mrcp_08b449
	cmp #$0200
mrcp_08b44c
	beq mrcp_08b463
mrcp_08b44e
	lda #$0200
mrcp_08b451
	sta.l $700082,x
mrcp_08b455
	lda.l $700040,x
mrcp_08b459
	and #$ff9f
mrcp_08b45c
	ora #$1001
mrcp_08b45f
	sta.l $700040,x
mrcp_08b463
	plx
mrcp_08b464
	a8
mrcp_08b466
	rts
retail_disablewheels
	phx
mrcp_08b468
	a16
mrcp_08b46a
	lda.w al_collobjptr,x
mrcp_08b46d
	tax
mrcp_08b46e
	lda.l $70003e,x
mrcp_08b472
	tax
mrcp_08b473
	beq mrcp_08b486
mrcp_08b475
	lda.l $700016,x
mrcp_08b479
	ora #$0080
mrcp_08b47c
	sta.l $700016,x
mrcp_08b480
	lda.l $700034,x
mrcp_08b484
	bra mrcp_08b472
mrcp_08b486
	plx
mrcp_08b487
	a8
mrcp_08b489
	rts
	longa
	longi
; US $08:B956.
; A16/I16: mode in A, compiled definition pointer in al_sword1, spawn tag
; in al_sbyte3. Construct and bind the raw car; wheel/shadow scene actors
; remain separate. Native failure returns A16 zero without rebinding the
; CPU owner; success returns A8 after publishing shape/tag/strategy flags.
retail_createcar_l
	sta.l m_dynvar2
mrcp_08b95a
	lda.w al_worldx,x
mrcp_08b95d
	sta.l m_x1
mrcp_08b961
	lda.w al_worldy,x
mrcp_08b964
	sta.l m_y1
mrcp_08b968
	lda.w al_worldz,x
mrcp_08b96b
	sta.l m_z1
mrcp_08b96f
	lda.w al_roty,x
mrcp_08b972
	and #$00ff
mrcp_08b975
	xba
mrcp_08b976
	sta.l m_bigy
mrcp_08b97a
	lda.w al_sbyte3,x
mrcp_08b97d
	and #$00ff
mrcp_08b980
	sta.l m_dynvar3
mrcp_08b984
	lda.w al_sword1,x
mrcp_08b987
	sta.l m_dynvar1
mrcp_08b98b
	a8
mrcp_08b98d
	phx
mrcp_08b98e
	phy
mrcp_08b98f
	lda #mretail_spawncar>>16
mrcp_08b991
	ldx #mretail_spawncar&WM
mrcp_08b994
	jsl retail_rawtask_l
mrcp_08b998
	ply
mrcp_08b999
	plx
mrcp_08b99a
	a16
mrcp_08b99c
	lda.l m_dynvar1
mrcp_08b9a0
	bne mrcp_08b9a5
mrcp_08b9a2
	brl retail_createcar_return
mrcp_08b9a5
	sta.w al_collobjptr,x
mrcp_08b9a8
	lda.l m_dynvar2
mrcp_08b9ac
	sta.w al_shape,x
mrcp_08b9af
	a8
mrcp_08b9b1
	lda.l m_retailshapetag
mrcp_08b9b5
	sta.w race_animcount
mrcp_08b9b8
	lda.w race_animcount
mrcp_08b9bb
	ora #$80
mrcp_08b9bd
	sta.w $2018,x
mrcp_08b9c0
	lda.w al_sflags,x
mrcp_08b9c3
	ora #$10
mrcp_08b9c5
	sta.w al_sflags,x
; CPU wheel/shadow scene objects are created separately by their owner.
retail_createcar_return
	rtl
	shorta
	longi
; US $08:C60F.
retail_carcontrols_l
	a8
mrcp_08c611
	i16
mrcp_08c613
	stx.w race_objowner
mrcp_08c616
	lda.w al_sflags2,x
mrcp_08c619
	and #$04
mrcp_08c61b
	bne mrcp_08c621
mrcp_08c61d
	jml mrcp_08c64a
mrcp_08c621
	a16
mrcp_08c623
	phx
mrcp_08c624
	txy
mrcp_08c625
	lda.w al_collobjptr,x
mrcp_08c628
	beq mrcp_08c646
mrcp_08c62a
	tax
mrcp_08c62b
	lda.l $700040,x
mrcp_08c62f
	ora #$0200
mrcp_08c632
	sta.l $700040,x
mrcp_08c636
	lda.l $700042,x
mrcp_08c63a
	bit #$1000
mrcp_08c63d
	bne mrcp_08c646
mrcp_08c63f
	and #$d800
mrcp_08c642
	sta.l $700042,x
mrcp_08c646
	plx
mrcp_08c647
	a8
mrcp_08c649
	rtl
mrcp_08c64a
	a16
mrcp_08c64c
	phx
mrcp_08c64d
	txy
mrcp_08c64e
	lda.w al_collobjptr,x
mrcp_08c651
	bne mrcp_08c656
mrcp_08c653
	brl mrcp_08c8fb
mrcp_08c656
	tax
mrcp_08c657
	lda.l $70001c,x
mrcp_08c65b
	and #$0010
mrcp_08c65e
	beq mrcp_08c663
mrcp_08c660
	brl mrcp_08c8fb
mrcp_08c663
	lda.w race_buttons
mrcp_08c666
	bit #$2000
mrcp_08c669
	bne mrcp_08c66f
mrcp_08c66b
	jml mrcp_08c6ae
mrcp_08c66f
	jsr retail_cheatkeys
mrcp_08c672
	lda.w race_previous
mrcp_08c675
	bit #$2000
mrcp_08c678
	beq mrcp_08c67e
mrcp_08c67a
	jml mrcp_08c6ae
mrcp_08c67e
	phy
mrcp_08c67f
	lda.w al_viewpt,y
mrcp_08c682
	tay
mrcp_08c683
	a8
mrcp_08c685
	lda.w al_sflags2,y
mrcp_08c688
	ora #$01
mrcp_08c68a
	sta.w al_sflags2,y
mrcp_08c68d
	lda.w race_buttons
mrcp_08c690
	bit #$20
mrcp_08c692
	bne mrcp_08c698
mrcp_08c694
	jml mrcp_08c6ab
mrcp_08c698
	lda.w race_buttons
mrcp_08c69b
	bit #$10
mrcp_08c69d
	bne mrcp_08c6a3
mrcp_08c69f
	jml mrcp_08c6ab
mrcp_08c6a3
	lda.w al_sflags2,y
mrcp_08c6a6
	ora #$02
mrcp_08c6a8
	sta.w al_sflags2,y
mrcp_08c6ab
	a16
mrcp_08c6ad
	ply
mrcp_08c6ae
	lda.w racesound_playmode
mrcp_08c6b1
	and #$00ff
mrcp_08c6b4
	bne mrcp_08c6b9
mrcp_08c6b6
	brl mrcp_08c73e
mrcp_08c6b9
	jsl retail_random_l
mrcp_08c6bd
	and #$0003
mrcp_08c6c0
	clc
mrcp_08c6c1
	adc #$006e
mrcp_08c6c4
	sta.w race_scratch
mrcp_08c6c7
	lda.w al_sword2,y
mrcp_08c6ca
	bmi mrcp_08c73e
mrcp_08c6cc
	cmp.w race_scratch
mrcp_08c6cf
	bpl mrcp_08c714
mrcp_08c6d1
	inc a
mrcp_08c6d2
	sta.w al_sword2,y
mrcp_08c6d5
	cmp #$000a
mrcp_08c6d8
	bmi mrcp_08c73e
mrcp_08c6da
	lda.w race_buttons
mrcp_08c6dd
	bit #$8000
mrcp_08c6e0
	beq mrcp_08c6e6
mrcp_08c6e2
	jml mrcp_08c70c
mrcp_08c6e6
	lda.w race_buttons
mrcp_08c6e9
	bit #$4000
mrcp_08c6ec
	beq mrcp_08c6f2
mrcp_08c6ee
	jml mrcp_08c70c
mrcp_08c6f2
	lda.w race_buttons
mrcp_08c6f5
	bit #$0080
mrcp_08c6f8
	beq mrcp_08c6fe
mrcp_08c6fa
	jml mrcp_08c70c
mrcp_08c6fe
	lda.w race_buttons
mrcp_08c701
	bit #$0040
mrcp_08c704
	beq mrcp_08c70a
mrcp_08c706
	jml mrcp_08c70c
mrcp_08c70a
	bra mrcp_08c73e
mrcp_08c70c
	lda #$ffff
mrcp_08c70f
	sta.w al_sword2,y
mrcp_08c712
	bra mrcp_08c73e
mrcp_08c714
	lda.l $700064,x
mrcp_08c718
	bit #$0008
mrcp_08c71b
	bne mrcp_08c73e
mrcp_08c71d
	ora #$0008
mrcp_08c720
	sta.l $700064,x
mrcp_08c724
	phy
mrcp_08c725
	lda.w al_viewpt,y
mrcp_08c728
	tay
mrcp_08c729
	a8
mrcp_08c72b
	lda.w al_sflags2,y
mrcp_08c72e
	ora #$01
mrcp_08c730
	sta.w al_sflags2,y
mrcp_08c733
	lda.w al_sflags2,y
mrcp_08c736
	ora #$02
mrcp_08c738
	sta.w al_sflags2,y
mrcp_08c73b
	a16
mrcp_08c73d
	ply
mrcp_08c73e
	lda.w racesound_voiceoff
mrcp_08c741
	and #$00ff
mrcp_08c744
	beq mrcp_08c749
mrcp_08c746
	brl mrcp_08c8fb
mrcp_08c749
	lda.l $700040,x
mrcp_08c74d
	and #$fdff
mrcp_08c750
	sta.l $700040,x
mrcp_08c754
	lda.l $700042,x
mrcp_08c758
	bit #$1000
mrcp_08c75b
	beq mrcp_08c760
mrcp_08c75d
	brl mrcp_08c8fb
mrcp_08c760
	lda.l $700042,x
mrcp_08c764
	and #$d800
mrcp_08c767
	sta.l $700042,x
mrcp_08c76b
	lda.w race_buttons
mrcp_08c76e
	bit #$0200
mrcp_08c771
	bne mrcp_08c777
mrcp_08c773
	jml mrcp_08c784
mrcp_08c777
	lda.l $700042,x
mrcp_08c77b
	ora #$0001
mrcp_08c77e
	sta.l $700042,x
mrcp_08c782
	bra mrcp_08c79b
mrcp_08c784
	lda.w race_buttons
mrcp_08c787
	bit #$0100
mrcp_08c78a
	bne mrcp_08c790
mrcp_08c78c
	jml mrcp_08c79b
mrcp_08c790
	lda.l $700042,x
mrcp_08c794
	ora #$0002
mrcp_08c797
	sta.l $700042,x
mrcp_08c79b
	lda.w race_buttons
mrcp_08c79e
	bit #$0020
mrcp_08c7a1
	bne mrcp_08c7a7
mrcp_08c7a3
	jml mrcp_08c7b4
mrcp_08c7a7
	lda.l $700042,x
mrcp_08c7ab
	ora #$0004
mrcp_08c7ae
	sta.l $700042,x
mrcp_08c7b2
	bra mrcp_08c7cb
mrcp_08c7b4
	lda.w race_buttons
mrcp_08c7b7
	bit #$0010
mrcp_08c7ba
	bne mrcp_08c7c0
mrcp_08c7bc
	jml mrcp_08c7cb
mrcp_08c7c0
	lda.l $700042,x
mrcp_08c7c4
	ora #$0008
mrcp_08c7c7
	sta.l $700042,x
mrcp_08c7cb
	lda.w race_buttons
mrcp_08c7ce
	bit #$0080
mrcp_08c7d1
	bne mrcp_08c7d7
mrcp_08c7d3
	jml mrcp_08c7f7
mrcp_08c7d7
	lda.l $700042,x
mrcp_08c7db
	ora #$2040
mrcp_08c7de
	sta.l $700042,x
mrcp_08c7e2
	lda.l $70004a,x
mrcp_08c7e6
	sec
mrcp_08c7e7
	sbc #$0032
mrcp_08c7ea
	bpl mrcp_08c7f7
mrcp_08c7ec
	lda.l $700042,x
mrcp_08c7f0
	ora #$0020
mrcp_08c7f3
	sta.l $700042,x
mrcp_08c7f7
	lda.w race_buttons
mrcp_08c7fa
	bit #$4000
mrcp_08c7fd
	bne mrcp_08c803
mrcp_08c7ff
	jml mrcp_08c84c
mrcp_08c803
	lda.l $70006a,x
mrcp_08c807
	beq mrcp_08c816
mrcp_08c809
	lda.l $700042,x
mrcp_08c80d
	ora #$0400
mrcp_08c810
	sta.l $700042,x
mrcp_08c814
	bra mrcp_08c84c
mrcp_08c816
	lda.w racesound_player
mrcp_08c819
	and #$00ff
mrcp_08c81c
	beq mrcp_08c823
mrcp_08c81e
	lda.w race_carstate1
mrcp_08c821
	bra mrcp_08c826
mrcp_08c823
	lda.w race_carstate0
mrcp_08c826
	bit #$0010
mrcp_08c829
	bne mrcp_08c84a
mrcp_08c82b
	pha
mrcp_08c82c
	lda #$005e
mrcp_08c82f
	jsl queue_raceplayer_l
mrcp_08c833
	pla
mrcp_08c834
	ora #$0010
mrcp_08c837
	pha
mrcp_08c838
	lda.w racesound_player
mrcp_08c83b
	and #$00ff
mrcp_08c83e
	beq mrcp_08c846
mrcp_08c840
	pla
mrcp_08c841
	sta.w race_carstate1
mrcp_08c844
	bra mrcp_08c84a
mrcp_08c846
	pla
mrcp_08c847
	sta.w race_carstate0
mrcp_08c84a
	bra mrcp_08c879
mrcp_08c84c
	lda.w racesound_player
mrcp_08c84f
	and #$00ff
mrcp_08c852
	beq mrcp_08c859
mrcp_08c854
	lda.w race_carstate1
mrcp_08c857
	bra mrcp_08c85c
mrcp_08c859
	lda.w race_carstate0
mrcp_08c85c
	bit #$0010
mrcp_08c85f
	beq mrcp_08c879
mrcp_08c861
	pha
mrcp_08c862
	pla
mrcp_08c863
	and #$ffef
mrcp_08c866
	pha
mrcp_08c867
	lda.w racesound_player
mrcp_08c86a
	and #$00ff
mrcp_08c86d
	beq mrcp_08c875
mrcp_08c86f
	pla
mrcp_08c870
	sta.w race_carstate1
mrcp_08c873
	bra mrcp_08c879
mrcp_08c875
	pla
mrcp_08c876
	sta.w race_carstate0
mrcp_08c879
	lda.w race_buttons
mrcp_08c87c
	bit #$0040
mrcp_08c87f
	bne mrcp_08c885
mrcp_08c881
	jml mrcp_08c8ab
mrcp_08c885
	lda.w race_previous
mrcp_08c888
	bit #$0040
mrcp_08c88b
	beq mrcp_08c891
mrcp_08c88d
	jml mrcp_08c8ab
mrcp_08c891
	lda.l $70005e,x
mrcp_08c895
	bne mrcp_08c8ab
mrcp_08c897
	lda.l $700040,x
mrcp_08c89b
	and #$0100
mrcp_08c89e
	bne mrcp_08c8ab
mrcp_08c8a0
	lda.l $700042,x
mrcp_08c8a4
	ora #$0080
mrcp_08c8a7
	sta.l $700042,x
mrcp_08c8ab
	lda.w race_buttons
mrcp_08c8ae
	bit #$8000
mrcp_08c8b1
	bne mrcp_08c8b7
mrcp_08c8b3
	jml mrcp_08c8c2
mrcp_08c8b7
	lda.l $700042,x
mrcp_08c8bb
	ora #$0010
mrcp_08c8be
	sta.l $700042,x
mrcp_08c8c2
	lda.l $700040,x
mrcp_08c8c6
	and #$0100
mrcp_08c8c9
	beq mrcp_08c8fb
mrcp_08c8cb
	lda.w race_buttons
mrcp_08c8ce
	bit #$0400
mrcp_08c8d1
	bne mrcp_08c8d7
mrcp_08c8d3
	jml mrcp_08c8e3
mrcp_08c8d7
	lda.l $700026,x
mrcp_08c8db
	sec
mrcp_08c8dc
	sbc #$0600
mrcp_08c8df
	sta.l $700026,x
mrcp_08c8e3
	lda.w race_buttons
mrcp_08c8e6
	bit #$0800
mrcp_08c8e9
	bne mrcp_08c8ef
mrcp_08c8eb
	jml mrcp_08c8fb
mrcp_08c8ef
	lda.l $700026,x
mrcp_08c8f3
	clc
mrcp_08c8f4
	adc #$0600
mrcp_08c8f7
	sta.l $700026,x
mrcp_08c8fb
	plx
mrcp_08c8fc
	a8
mrcp_08c8fe
	rtl
	longa
	longi
retail_cheatkeys
	inc.w race_cheatclock
mrcp_08c902
	lda.w race_cheatstate
mrcp_08c905
	beq mrcp_08c938
mrcp_08c907
	cmp #$0001
mrcp_08c90a
	beq mrcp_08c94e
mrcp_08c90c
	cmp #$0002
mrcp_08c90f
	beq mrcp_08c964
mrcp_08c911
	cmp #$0003
mrcp_08c914
	beq mrcp_08c97a
mrcp_08c916
	lda #$0048
mrcp_08c919
	jsl queue_raceplayer_l
mrcp_08c91d
	lda.l $700040,x
mrcp_08c921
	ora #$2000
mrcp_08c924
	sta.l $700040,x
mrcp_08c928
	lda #$0180
mrcp_08c92b
	sta.l $70006a,x
mrcp_08c92f
	lda #$1000
mrcp_08c932
	; Retain the native cheat's distant +$0400 write, including its wrap.
	sta.l $700400,x
mrcp_08c936
	bra mrcp_08c999
mrcp_08c938
	lda.w race_cheatclock
mrcp_08c93b
	cmp #$0005
mrcp_08c93e
	bpl mrcp_08c999
mrcp_08c940
	lda.w race_buttons
mrcp_08c943
	bit #$0040
mrcp_08c946
	beq mrcp_08c94c
mrcp_08c948
	jml mrcp_08c9a0
mrcp_08c94c
	bra mrcp_08c99f
mrcp_08c94e
	lda.w race_cheatclock
mrcp_08c951
	cmp #$0005
mrcp_08c954
	bpl mrcp_08c999
mrcp_08c956
	lda.w race_buttons
mrcp_08c959
	bit #$0080
mrcp_08c95c
	beq mrcp_08c962
mrcp_08c95e
	jml mrcp_08c9a0
mrcp_08c962
	bra mrcp_08c99f
mrcp_08c964
	lda.w race_cheatclock
mrcp_08c967
	cmp #$0005
mrcp_08c96a
	bpl mrcp_08c999
mrcp_08c96c
	lda.w race_buttons
mrcp_08c96f
	bit #$4000
mrcp_08c972
	beq mrcp_08c978
mrcp_08c974
	jml mrcp_08c9a0
mrcp_08c978
	bra mrcp_08c99f
mrcp_08c97a
	lda.w race_cheatclock
mrcp_08c97d
	cmp #$0011
mrcp_08c980
	bpl mrcp_08c999
mrcp_08c982
	lda.w race_buttons
mrcp_08c985
	bit #$0800
mrcp_08c988
	bne mrcp_08c98e
mrcp_08c98a
	jml mrcp_08c99f
mrcp_08c98e
	lda.w race_cheatclock
mrcp_08c991
	cmp #$000c
mrcp_08c994
	bmi mrcp_08c999
mrcp_08c996
	jmp mrcp_08c916
mrcp_08c999
	stz.w race_cheatclock
mrcp_08c99c
	stz.w race_cheatstate
mrcp_08c99f
	rts
mrcp_08c9a0
	stz.w race_cheatclock
mrcp_08c9a3
	inc.w race_cheatstate
mrcp_08c9a6
	bra mrcp_08c99f
mrcp_08c9a8
	rtl
	shorta
	longi
retail_publishcar_l
	a8
mrcp_08c9ab
	lda.w al_sflags2,x
mrcp_08c9ae
	and #$df
mrcp_08c9b0
	sta.w al_sflags2,x
mrcp_08c9b3
	lda.w al_sflags2,x
mrcp_08c9b6
	and #$bf
mrcp_08c9b8
	sta.w al_sflags2,x
mrcp_08c9bb
	phx
mrcp_08c9bc
	lda.w al_sbyte4,x
mrcp_08c9bf
	cmp #$01
mrcp_08c9c1
	bne mrcp_08c9db
mrcp_08c9c3
	lda #$02
mrcp_08c9c5
	sta.w al_sbyte4,x
mrcp_08c9c8
	a16
mrcp_08c9ca
	lda.w al_collobjptr,x
mrcp_08c9cd
	tax
mrcp_08c9ce
	lda.l $700016,x
mrcp_08c9d2
	ora #$0400
mrcp_08c9d5
	sta.l $700016,x
mrcp_08c9d9
	bra mrcp_08c9ec
mrcp_08c9db
	a16
mrcp_08c9dd
	lda.w al_collobjptr,x
mrcp_08c9e0
	tax
mrcp_08c9e1
	lda.l $700016,x
mrcp_08c9e5
	and #$fbff
mrcp_08c9e8
	sta.l $700016,x
mrcp_08c9ec
	plx
mrcp_08c9ed
	a8
mrcp_08c9ef
	phx
mrcp_08c9f0
	txy
mrcp_08c9f1
	a16
mrcp_08c9f3
	lda.w al_collobjptr,x
mrcp_08c9f6
	tax
mrcp_08c9f7
	lda.l $700040,x
mrcp_08c9fb
	sta.l $700090,x
mrcp_08c9ff
	lda.l $70001e,x
mrcp_08ca03
	sta.w al_worldx,y
mrcp_08ca06
	lda.l $700020,x
mrcp_08ca0a
	sta.w al_worldy,y
mrcp_08ca0d
	lda.l $700022,x
mrcp_08ca11
	sta.w al_worldz,y
mrcp_08ca14
	a8
mrcp_08ca16
	lda.l $700027,x
mrcp_08ca1a
	sta.w al_rotx,y
mrcp_08ca1d
	lda.l $700029,x
mrcp_08ca21
	sta.w al_rotz,y
mrcp_08ca24
	lda.l $700025,x
mrcp_08ca28
	sta.w al_roty,y
mrcp_08ca2b
	plx
mrcp_08ca2c
	rtl
retail_stopbody_l
	lda.w al_flags+1,x
mrcp_08ca30
	ora #$01
mrcp_08ca32
	sta.w al_flags+1,x
mrcp_08ca35
	a16
mrcp_08ca37
	lda #$0000
mrcp_08ca3a
	sta.w al_stratptr,x
mrcp_08ca3d
	a8
mrcp_08ca3f
	lda #$00
mrcp_08ca41
	sta.w al_stratptr+2,x
mrcp_08ca44
	rtl
retail_framebody_l
	lda.w al_sbyte1,x
mrcp_08ca48
	sta.w race_animcount
mrcp_08ca4b
	lda.w race_animcount
mrcp_08ca4e
	ora #$80
mrcp_08ca50
	sta.w al_colframe,x
mrcp_08ca53
	brl mrcp_08cd2d
retail_forwardbody_l
	a16
mrcp_08ca58
	lda #retail_forwardbody_step&WM
mrcp_08ca5b
	sta.w al_stratptr,x
mrcp_08ca5e
	a8
mrcp_08ca60
	lda #mrcpu_begin>>16
mrcp_08ca62
	sta.w al_stratptr+2,x
mrcp_08ca65
	lda #$00
mrcp_08ca67
	ora #$80
mrcp_08ca69
	sta.w al_colframe,x
mrcp_08ca6c
	brl mrcp_08cd46
retail_forwardbody_step
	inc.w al_sbyte3,x
mrcp_08ca72
	lda.w al_sbyte3,x
mrcp_08ca75
	cmp.w al_sbyte2,x
mrcp_08ca78
	bne mrcp_08ca9f
mrcp_08ca7a
	stz.w al_sbyte3,x
mrcp_08ca7d
	lda.w al_sbyte1,x
mrcp_08ca80
	sta.w race_animcount
mrcp_08ca83
	lda.w al_colframe,x
mrcp_08ca86
	clc
mrcp_08ca87
	adc #$01
mrcp_08ca89
	bmi mrcp_08ca8f
mrcp_08ca8b
	clc
mrcp_08ca8c
	adc.w race_animcount
mrcp_08ca8f
	and #$7f
mrcp_08ca91
	cmp.w race_animcount
mrcp_08ca94
	bcc mrcp_08ca9a
mrcp_08ca96
	sec
mrcp_08ca97
	sbc.w race_animcount
mrcp_08ca9a
	ora #$80
mrcp_08ca9c
	sta.w al_colframe,x
mrcp_08ca9f
	brl retail_publishbodyframe_l
retail_backwardbody_l
	a16
mrcp_08caa4
	lda #retail_backwardbody_step&WM
mrcp_08caa7
	sta.w al_stratptr,x
mrcp_08caaa
	a8
mrcp_08caac
	lda #mrcpu_begin>>16
mrcp_08caae
	sta.w al_stratptr+2,x
mrcp_08cab1
	lda.w al_sbyte1,x
mrcp_08cab4
	dec a
mrcp_08cab5
	sta.w race_animcount
mrcp_08cab8
	lda.w race_animcount
mrcp_08cabb
	ora #$80
mrcp_08cabd
	sta.w al_colframe,x
mrcp_08cac0
	brl mrcp_08cd46
retail_backwardbody_step
	inc.w al_sbyte3,x
mrcp_08cac6
	lda.w al_sbyte3,x
mrcp_08cac9
	cmp.w al_sbyte2,x
mrcp_08cacc
	bne mrcp_08caf3
mrcp_08cace
	stz.w al_sbyte3,x
mrcp_08cad1
	lda.w al_sbyte1,x
mrcp_08cad4
	sta.w race_animcount
mrcp_08cad7
	lda.w al_colframe,x
mrcp_08cada
	clc
mrcp_08cadb
	adc #$ff
mrcp_08cadd
	bmi mrcp_08cae3
mrcp_08cadf
	clc
mrcp_08cae0
	adc.w race_animcount
mrcp_08cae3
	and #$7f
mrcp_08cae5
	cmp.w race_animcount
mrcp_08cae8
	bcc mrcp_08caee
mrcp_08caea
	sec
mrcp_08caeb
	sbc.w race_animcount
mrcp_08caee
	ora #$80
mrcp_08caf0
	sta.w al_colframe,x
mrcp_08caf3
	brl retail_publishbodyframe_l
retail_pingpongbody_l
	a16
mrcp_08caf8
	lda #retail_pingpongbody_step&WM
mrcp_08cafb
	sta.w al_stratptr,x
mrcp_08cafe
	a8
mrcp_08cb00
	lda #mrcpu_begin>>16
mrcp_08cb02
	sta.w al_stratptr+2,x
mrcp_08cb05
	lda #$00
mrcp_08cb07
	ora #$80
mrcp_08cb09
	sta.w al_colframe,x
mrcp_08cb0c
	lda.w al_sbyte3,x
mrcp_08cb0f
	sta.w al_vx,x
mrcp_08cb12
	brl mrcp_08cd46
retail_pingpongbody_step
	lda.w al_vx,x
mrcp_08cb18
	beq mrcp_08cb1f
mrcp_08cb1a
	dec.w al_vx,x
mrcp_08cb1d
	bra mrcp_08cb6b
mrcp_08cb1f
	lda.w al_vy,x
mrcp_08cb22
	sta.w race_animcount
mrcp_08cb25
	lda.w race_animcount
mrcp_08cb28
	ora #$80
mrcp_08cb2a
	sta.w al_colframe,x
mrcp_08cb2d
	lda.w al_sbyte1,x
mrcp_08cb30
	sta.w race_animcount
mrcp_08cb33
	dec a
mrcp_08cb34
	sta.w race_animcount+1
mrcp_08cb37
	inc.w al_offroadtime,x
mrcp_08cb3a
	lda.w al_offroadtime,x
mrcp_08cb3d
	cmp.w al_sbyte2,x
mrcp_08cb40
	bne mrcp_08cb6b
mrcp_08cb42
	stz.w al_offroadtime,x
mrcp_08cb45
	lda.w al_sflags2,x
mrcp_08cb48
	and #$01
mrcp_08cb4a
	beq mrcp_08cb50
mrcp_08cb4c
	jml mrcp_08cb5f
mrcp_08cb50
	lda.w al_colframe,x
mrcp_08cb53
	and #$7f
mrcp_08cb55
	cmp.w race_animcount+1
mrcp_08cb58
	beq mrcp_08cb6e
mrcp_08cb5a
	inc.w al_vy,x
mrcp_08cb5d
	bra mrcp_08cb6b
mrcp_08cb5f
	lda.w al_colframe,x
mrcp_08cb62
	and #$7f
mrcp_08cb64
	cmp #$00
mrcp_08cb66
	beq mrcp_08cb6e
mrcp_08cb68
	dec.w al_vy,x
mrcp_08cb6b
	brl retail_publishbodyframe_l
mrcp_08cb6e
	lda.w al_sflags2,x
mrcp_08cb71
	eor #$01
mrcp_08cb73
	sta.w al_sflags2,x
mrcp_08cb76
	lda.w al_sbyte3,x
mrcp_08cb79
	sta.w al_vx,x
mrcp_08cb7c
	bra mrcp_08cb6b
retail_publishbodyframe_l
	txy
mrcp_08cb7f
	a16
mrcp_08cb81
	lda.w al_collobjptr,x
mrcp_08cb84
	beq mrcp_08cb91
mrcp_08cb86
	tax
mrcp_08cb87
	lda.w al_colframe,y
mrcp_08cb8a
	and #$007f
mrcp_08cb8d
	sta.l $700012,x
mrcp_08cb91
	tyx
mrcp_08cb92
	a8
mrcp_08cb94
	jml retail_bodyframe_l
retail_makefragment_l
	phx
mrcp_08cb99
	phy
mrcp_08cb9a
	lda #mrupdate_begin>>16
mrcp_08cb9c
	ldx #mretail_spawnfragment&WM
mrcp_08cb9f
	jsl retail_rawtask_l
mrcp_08cba3
	ply
mrcp_08cba4
	plx
mrcp_08cba5
	a16
mrcp_08cba7
	lda #$0000
mrcp_08cbaa
	sta.w race_callback
mrcp_08cbad
	a8
mrcp_08cbaf
	brl retail_bindrawobject_l
retail_makeheldbody_l
	phx
mrcp_08cbb3
	phy
mrcp_08cbb4
	lda #mrupdate_begin>>16
mrcp_08cbb6
	ldx #mretail_spawn8c95&WM
mrcp_08cbb9
	jsl retail_rawtask_l
mrcp_08cbbd
	ply
mrcp_08cbbe
	plx
mrcp_08cbbf
	a16
mrcp_08cbc1
	lda #mretail_holdcontacts&WM
mrcp_08cbc4
	sta.w race_callback
mrcp_08cbc7
	a8
mrcp_08cbc9
	jmp retail_bindrawobject_l
retail_makefallingbody_l
	phx
mrcp_08cbcd
	phy
mrcp_08cbce
	lda #mrupdate_begin>>16
mrcp_08cbd0
	ldx #mretail_spawn8c0a&WM
mrcp_08cbd3
	jsl retail_rawtask_l
mrcp_08cbd7
	ply
mrcp_08cbd8
	plx
mrcp_08cbd9
	a16
mrcp_08cbdb
	lda #mretail_fallingbody&WM
mrcp_08cbde
	sta.w race_callback
mrcp_08cbe1
	a8
mrcp_08cbe3
	jmp retail_bindrawobject_l
retail_makedragbody_l
	phx
mrcp_08cbe7
	phy
mrcp_08cbe8
	lda #mrupdate_begin>>16
mrcp_08cbea
	ldx #mretail_spawn8c0a&WM
mrcp_08cbed
	jsl retail_rawtask_l
mrcp_08cbf1
	ply
mrcp_08cbf2
	plx
mrcp_08cbf3
	a16
mrcp_08cbf5
	lda #mretail_dragbody&WM
mrcp_08cbf8
	sta.w race_callback
mrcp_08cbfb
	a8
mrcp_08cbfd
	bra retail_bindrawobject_l
retail_makebody_l
	phx
mrcp_08cc00
	phy
mrcp_08cc01
	lda #mrupdate_begin>>16
mrcp_08cc03
	ldx #mretail_spawn8c0a&WM
mrcp_08cc06
	jsl retail_rawtask_l
mrcp_08cc0a
	ply
mrcp_08cc0b
	plx
mrcp_08cc0c
	a16
mrcp_08cc0e
	lda #$0000
mrcp_08cc11
	sta.w race_callback
mrcp_08cc14
	a8
mrcp_08cc16
	bra retail_bindrawobject_l
retail_makeheldsolid_l
	phx
mrcp_08cc19
	phy
mrcp_08cc1a
	lda #mrupdate_begin>>16
mrcp_08cc1c
	ldx #mretail_spawn8c0a&WM
mrcp_08cc1f
	jsl retail_rawtask_l
mrcp_08cc23
	ply
mrcp_08cc24
	plx
mrcp_08cc25
	a16
mrcp_08cc27
	lda #mretail_holdcontacts&WM
mrcp_08cc2a
	sta.w race_callback
mrcp_08cc2d
	a8
mrcp_08cc2f
	bra retail_bindrawobject_l
retail_makelandingbody_l
	phx
mrcp_08cc32
	phy
mrcp_08cc33
	lda #mrupdate_begin>>16
mrcp_08cc35
	ldx #mretail_spawn8c3b&WM
mrcp_08cc38
	jsl retail_rawtask_l
mrcp_08cc3c
	ply
mrcp_08cc3d
	plx
mrcp_08cc3e
	a16
mrcp_08cc40
	lda #mretail_landingbody&WM
mrcp_08cc43
	sta.w race_callback
mrcp_08cc46
	a8
mrcp_08cc48
	bra retail_bindrawobject_l
retail_makecontactbody_l
	phx
mrcp_08cc4b
	phy
mrcp_08cc4c
	lda #mrupdate_begin>>16
mrcp_08cc4e
	ldx #mretail_spawn8c6c&WM
mrcp_08cc51
	jsl retail_rawtask_l
mrcp_08cc55
	ply
mrcp_08cc56
	plx
mrcp_08cc57
	a16
mrcp_08cc59
	lda #mretail_contactbody&WM
mrcp_08cc5c
	sta.w race_callback
mrcp_08cc5f
	a8
mrcp_08cc61
	bra retail_bindrawobject_l
retail_makedragsolid_l
	phx
mrcp_08cc64
	phy
mrcp_08cc65
	lda #mrupdate_begin>>16
mrcp_08cc67
	ldx #mretail_spawnsolid&WM
mrcp_08cc6a
	jsl retail_rawtask_l
mrcp_08cc6e
	ply
mrcp_08cc6f
	plx
mrcp_08cc70
	a16
mrcp_08cc72
	lda #mretail_dragbody&WM
mrcp_08cc75
	sta.w race_callback
mrcp_08cc78
	a8
mrcp_08cc7a
	bra retail_bindrawobject_l
retail_bindrawobject_l
	a16
mrcp_08cc7e
	lda.l m_dynvar1
mrcp_08cc82
	sta.w al_collobjptr,x
mrcp_08cc85
	bne mrcp_08cc8a
mrcp_08cc87
	brl mrcp_08cc9e
mrcp_08cc8a
	phx
mrcp_08cc8b
	txy
mrcp_08cc8c
	tax
mrcp_08cc8d
	lda.w race_callback
mrcp_08cc90
	sta.l $70000a,x
mrcp_08cc94
	plx
mrcp_08cc95
	a8
mrcp_08cc97
	jsl retail_synctoraw_l
mrcp_08cc9b
	lda #$00
mrcp_08cc9d
	rtl
mrcp_08cc9e
	a8
mrcp_08cca0
	lda #$ff
mrcp_08cca2
	rtl
retail_makecollidable_l
	a16
mrcp_08cca5
	lda.w al_collobjptr,x
mrcp_08cca8
	beq mrcp_08ccbb
mrcp_08ccaa
	phx
mrcp_08ccab
	tax
mrcp_08ccac
	lda.l $700016,x
mrcp_08ccb0
	ora #$0010
mrcp_08ccb3
	and #$feff
mrcp_08ccb6
	sta.l $700016,x
mrcp_08ccba
	plx
mrcp_08ccbb
	a8
mrcp_08ccbd
	rtl
retail_setcollisionmask_l
	a16
mrcp_08ccc0
	lda.w al_collobjptr,x
mrcp_08ccc3
	beq mrcp_08cccf
mrcp_08ccc5
	phx
mrcp_08ccc6
	tax
mrcp_08ccc7
	lda #$0002
mrcp_08ccca
	sta.l $70001a,x
mrcp_08ccce
	plx
mrcp_08cccf
	a8
mrcp_08ccd1
	rtl
retail_setrawbounds_l
	a16
mrcp_08ccd4
	lda.w al_collobjptr,x
mrcp_08ccd7
	beq mrcp_08ccee
mrcp_08ccd9
	phx
mrcp_08ccda
	tax
mrcp_08ccdb
	lda x1
mrcp_08ccdd
	sta.l $70000c,x
mrcp_08cce1
	lda y1
mrcp_08cce3
	sta.l $70000e,x
mrcp_08cce7
	lda z1
mrcp_08cce9
	sta.l $700010,x
mrcp_08cced
	plx
mrcp_08ccee
	a8
mrcp_08ccf0
	rtl
retail_orrawtype_l
	a16
mrcp_08ccf3
	lda.w al_collobjptr,x
mrcp_08ccf6
	beq mrcp_08cd05
mrcp_08ccf8
	phx
mrcp_08ccf9
	tax
mrcp_08ccfa
	lda.l $700016,x
mrcp_08ccfe
	ora x1
mrcp_08cd00
	sta.l $700016,x
mrcp_08cd04
	plx
mrcp_08cd05
	a8
mrcp_08cd07
	rtl
retail_setrawmass_l
	a16
mrcp_08cd0a
	and #$00ff
mrcp_08cd0d
	xba
mrcp_08cd0e
	sta.w race_coltype
mrcp_08cd11
	a16
mrcp_08cd13
	lda.w al_collobjptr,x
mrcp_08cd16
	beq mrcp_08cd22
mrcp_08cd18
	phx
mrcp_08cd19
	tax
mrcp_08cd1a
	lda.w race_coltype
mrcp_08cd1d
	sta.l $70002a,x
mrcp_08cd21
	plx
mrcp_08cd22
	a8
mrcp_08cd24
	rtl
retail_fragmentbody_l
	lda.w al_sflags,x
mrcp_08cd28
	ora #$20
mrcp_08cd2a
	sta.w al_sflags,x
mrcp_08cd2d
	a16
mrcp_08cd2f
	lda #$0000
mrcp_08cd32
	sta.w al_sword1,x
mrcp_08cd35
	a8
mrcp_08cd37
	a16
mrcp_08cd39
	lda #retail_bodyframe_l&WM
mrcp_08cd3c
	sta.w al_stratptr,x
mrcp_08cd3f
	a8
mrcp_08cd41
	lda #mrcpu_begin>>16
mrcp_08cd43
	sta.w al_stratptr+2,x
mrcp_08cd46
	a16
mrcp_08cd48
	lda #retail_fragmentbody_init&WM
mrcp_08cd4b
	sta.w al_tempstratptr,x
mrcp_08cd4e
	a8
mrcp_08cd50
	lda #mrcpu_begin>>16
mrcp_08cd52
	sta.w al_tempstratptr+2,x
retail_fragmentbody_init
	jsl retail_makefragment_l
mrcp_08cd59
	bpl mrcp_08cd5e
mrcp_08cd5b
	brl mrcp_08cd83
mrcp_08cd5e
	a16
mrcp_08cd60
	txy
mrcp_08cd61
	lda.w al_collobjptr,x
mrcp_08cd64
	tax
mrcp_08cd65
	lda.w al_type,y
mrcp_08cd68
	ora.l $700016,x
mrcp_08cd6c
	sta.l $700016,x
mrcp_08cd70
	lda.l $700016,x
mrcp_08cd74
	ora.w al_sword1,y
mrcp_08cd77
	sta.l $700016,x
mrcp_08cd7b
	tyx
mrcp_08cd7c
	a8
retail_bodyframe_l
	jsl retail_keeprawobject_l
mrcp_08cd82
	rtl
mrcp_08cd83
	rtl
	shorta
	longi
; US $08:CF41.
retail_nextcontact_l
	a16
mrcp_08cf43
	lda.w race_contactnext
mrcp_08cf46
	beq mrcp_08cf8e
mrcp_08cf48
	phx
mrcp_08cf49
	tax
mrcp_08cf4a
	lda.l $700010,x
mrcp_08cf4e
	and #$0002
mrcp_08cf51
	bne mrcp_08cf5c
mrcp_08cf53
	lda.l $70000e,x
mrcp_08cf57
	bne mrcp_08cf49
mrcp_08cf59
	plx
mrcp_08cf5a
	bra mrcp_08cf8e
mrcp_08cf5c
	lda.l $70000c,x
mrcp_08cf60
	tay
mrcp_08cf61
	lda.l $70000e,x
mrcp_08cf65
	sta.w race_contactnext
mrcp_08cf68
	tyx
mrcp_08cf69
	stz.w race_colmode
mrcp_08cf6c
	lda.l $700016,x
mrcp_08cf70
	bit #$0002
mrcp_08cf73
	beq mrcp_08cf7c
mrcp_08cf75
	lda.l $700064,x
mrcp_08cf79
	sta.w race_colmode
mrcp_08cf7c
	lda.l $700016,x
mrcp_08cf80
	sta.w race_coltype
mrcp_08cf83
	stz.w race_colresult
mrcp_08cf86
	jsr retail_contactflags
mrcp_08cf89
	plx
mrcp_08cf8a
	a8
mrcp_08cf8c
	sec
mrcp_08cf8d
	rtl
mrcp_08cf8e
	a8
mrcp_08cf90
	clc
mrcp_08cf91
	rtl
retail_objectcontacts_l
	a16
mrcp_08cf94
	lda.w al_collobjptr,x
mrcp_08cf97
	bne mrcp_08cf9c
mrcp_08cf99
	brl mrcp_08d019
mrcp_08cf9c
	phx
mrcp_08cf9d
	tax
mrcp_08cf9e
	stz.w race_colresult
mrcp_08cfa1
	lda.l $70001c,x
mrcp_08cfa5
	and #$0001
mrcp_08cfa8
	beq mrcp_08cfc5
mrcp_08cfaa
	lda.w race_colresult
mrcp_08cfad
	ora #$0010
mrcp_08cfb0
	sta.w race_colresult
mrcp_08cfb3
	lda.l m_carflags
mrcp_08cfb7
	and #$0020
mrcp_08cfba
	beq mrcp_08cfc5
mrcp_08cfbc
	lda.w race_colresult
mrcp_08cfbf
	ora #$0080
mrcp_08cfc2
	sta.w race_colresult
mrcp_08cfc5
	lda.l $70002c,x
mrcp_08cfc9
	and #$0020
mrcp_08cfcc
	ora.w race_colresult
mrcp_08cfcf
	sta.w race_colresult
mrcp_08cfd2
	stz.w race_coltype
mrcp_08cfd5
	stz.w race_colmode
mrcp_08cfd8
	lda.l $700018,x
mrcp_08cfdc
	tax
mrcp_08cfdd
	beq mrcp_08d012
mrcp_08cfdf
	lda.l $700010,x
mrcp_08cfe3
	and #$0002
mrcp_08cfe6
	beq mrcp_08d00c
mrcp_08cfe8
	lda.l $70000c,x
mrcp_08cfec
	txy
mrcp_08cfed
	tax
mrcp_08cfee
	lda.l $700016,x
mrcp_08cff2
	bit #$0002
mrcp_08cff5
	beq mrcp_08d005
mrcp_08cff7
	lda.l $700064,x
mrcp_08cffb
	ora.w race_colmode
mrcp_08cffe
	sta.w race_colmode
mrcp_08d001
	lda.l $700016,x
mrcp_08d005
	ora.w race_coltype
mrcp_08d008
	sta.w race_coltype
mrcp_08d00b
	tyx
mrcp_08d00c
	lda.l $70000e,x
mrcp_08d010
	bra mrcp_08cfdc
mrcp_08d012
	plx
mrcp_08d013
	jsr retail_contactflags
mrcp_08d016
	a8
mrcp_08d018
	rtl
mrcp_08d019
	a8
mrcp_08d01b
	lda #$00
mrcp_08d01d
	rtl
	longa
	longi
retail_contactflags
	lda.w race_colmode
mrcp_08d021
	beq mrcp_08d04a
mrcp_08d023
	bit #$0001
mrcp_08d026
	beq mrcp_08d02d
mrcp_08d028
	lda #$0001
mrcp_08d02b
	bra mrcp_08d041
mrcp_08d02d
	bit #$0002
mrcp_08d030
	beq mrcp_08d037
mrcp_08d032
	lda #$0002
mrcp_08d035
	bra mrcp_08d041
mrcp_08d037
	bit #$0004
mrcp_08d03a
	beq mrcp_08d041
mrcp_08d03c
	lda #$0004
mrcp_08d03f
	bra mrcp_08d041
mrcp_08d041
	ora #$0004
mrcp_08d044
	ora.w race_colresult
mrcp_08d047
	sta.w race_colresult
mrcp_08d04a
	lda.w race_coltype
mrcp_08d04d
	bit #$0001
mrcp_08d050
	beq mrcp_08d05b
mrcp_08d052
	lda.w race_colresult
mrcp_08d055
	ora #$0008
mrcp_08d058
	sta.w race_colresult
mrcp_08d05b
	lda.w race_coltype
mrcp_08d05e
	bit #$0800
mrcp_08d061
	beq mrcp_08d06c
mrcp_08d063
	lda.w race_colresult
mrcp_08d066
	ora #$0080
mrcp_08d069
	sta.w race_colresult
mrcp_08d06c
	lda.w race_colresult
mrcp_08d06f
	rts
	shorta
	longi
retail_keeprawobject_l
	lda.w al_collobjptr,x
mrcp_08d073
	ora.w al_collobjptr+1,x
mrcp_08d076
	bne mrcp_08d07f
mrcp_08d078
	lda #$ff
mrcp_08d07a
	sta.w al_sbyte4,x
mrcp_08d07d
	bra mrcp_08d099
mrcp_08d07f
	a16
mrcp_08d081
	lda.w al_collobjptr,x
mrcp_08d084
	beq mrcp_08d099
mrcp_08d086
	txy
mrcp_08d087
	tax
mrcp_08d088
	lda.l $70001c,x
mrcp_08d08c
	ora #$0004
mrcp_08d08f
	sta.l $70001c,x
mrcp_08d093
	tyx
mrcp_08d094
	a8
mrcp_08d096
	lda #$00
mrcp_08d098
	rtl
mrcp_08d099
	a8
mrcp_08d09b
	lda #$ff
mrcp_08d09d
	rtl
	shorta
	longi
; US $08:D86F.
retail_synctoraw_l
	a16
mrcp_08d871
	txy
mrcp_08d872
	lda.w al_collobjptr,x
mrcp_08d875
	beq mrcp_08d8be
mrcp_08d877
	tax
mrcp_08d878
	lda.w al_expposx,y
mrcp_08d87b
	sta.l $70000c,x
mrcp_08d87f
	lda.w al_expposy,y
mrcp_08d882
	sta.l $70000e,x
mrcp_08d886
	lda.w al_expposz,y
mrcp_08d889
	sta.l $700010,x
mrcp_08d88d
	lda.w al_expshape,y
mrcp_08d890
	sta.l $700014,x
mrcp_08d894
	lda.w al_worldx,y
mrcp_08d897
	sta.l $70001e,x
mrcp_08d89b
	lda.w al_worldy,y
mrcp_08d89e
	sta.l $700020,x
mrcp_08d8a2
	lda.w al_worldz,y
mrcp_08d8a5
	sta.l $700022,x
mrcp_08d8a9
	lda.w al_roty,y
mrcp_08d8ac
	and #$00ff
mrcp_08d8af
	xba
mrcp_08d8b0
	sta.l $700024,x
mrcp_08d8b4
	lda.w al_colframe,y
mrcp_08d8b7
	and #$007f
mrcp_08d8ba
	sta.l $700012,x
mrcp_08d8be
	a8
mrcp_08d8c0
	tyx
mrcp_08d8c1
	rtl
retail_rawposition_l
	a16
mrcp_08d8c4
	txy
mrcp_08d8c5
	lda.w al_collobjptr,x
mrcp_08d8c8
	beq mrcp_08d8e0
mrcp_08d8ca
	tax
mrcp_08d8cb
	lda.w al_worldx,y
mrcp_08d8ce
	sta.l $70001e,x
mrcp_08d8d2
	lda.w al_worldy,y
mrcp_08d8d5
	sta.l $700020,x
mrcp_08d8d9
	lda.w al_worldz,y
mrcp_08d8dc
	sta.l $700022,x
mrcp_08d8e0
	tyx
mrcp_08d8e1
	a8
mrcp_08d8e3
	rtl
	shorta
	longi
; US $02:DF79.
retail_random_l
	jsr mrcp_02df7d
mrcp_02df7c
	rtl
mrcp_02df7d
	php
mrcp_02df7e
	a8
mrcp_02df80
	lda rand
mrcp_02df82
	clc
mrcp_02df83
	sbc rand+1
mrcp_02df85
	sta rand+1
mrcp_02df87
	sbc rand+2
mrcp_02df89
	sta rand+2
mrcp_02df8b
	sbc rand+3
mrcp_02df8d
	sta rand+3
mrcp_02df8f
	sbc rand
mrcp_02df91
	sta rand
mrcp_02df93
	plp
mrcp_02df94
	rts

; Bind already initialized heaps: X/Y are their bank-zero roots. Snapshot
; starts cleared; this neither clears heap storage nor resets object lists.
; Call only at a scene boundary with GSU stopped and CPU owning its RAM.
retail_bindrawcontext_l
 php
 phx
 phy
 a16
 lda #0
 ldx #84
.clear
 sta.l race_rawcontext,x
 dex
 dex
 bpl .clear
 ply
 plx
 stx race_rawcontext+60
 sty race_rawcontext+62
 plp
 jsl retail_restorerawcontext_l
 rtl

; Preserve the 86-byte polygon workspace across rendering. Invalidate the
; shared decoded-point cache before resuming dynamics after another user.
; Both copies preserve A/X/Y/P; entry A8/I16, CPU owns stopped GSU RAM.
retail_restorerawcontext_l
 php
 phx
 a16
 pha
 ldx #84
.copy
 lda.l race_rawcontext,x
 sta.l m_retailwheelparams,x
 dex
 dex
 bpl .copy
 lda #$ffff
 sta.l m_oldshape
 pla
 a8
 plx
 plp
 rtl
retail_saverawcontext_l
 php
 phx
 a16
 pha
 ldx #84
.copy
 lda.l m_retailwheelparams,x
 sta.l race_rawcontext,x
 dex
 dex
 bpl .copy
 pla
 a8
 plx
 plp
 rtl

; A=GSU bank, X=task address, I16. Surround the original SASMX-era
; synchronous launcher; it still owns the hardware handshake and wait.
retail_rawtask_l
 jsl retail_restorerawcontext_l
 jsl runmario_l
 jsl retail_saverawcontext_l
 rtl

; Run the restored object task after CPU strategies have marked survivors.
; Keep register ownership as the original s_runmario macro does.
retail_objectframe_l
 phx
 phy
 lda #mretail_objectframe>>16
 ldx #mretail_objectframe&WM
 jsl retail_rawtask_l
 ply
 plx
 rtl

; Callable long-return entries for the two native local helpers.
retail_stuckcar_l
 jsr retail_stuckcar
 rtl
retail_disablewheels_l
 jsr retail_disablewheels
 rtl

mrcpu_end
