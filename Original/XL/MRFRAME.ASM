; Raw actor scheduler and asynchronous object/draw-list ownership.
; Native bank2 code uses WRAM delta $22D9; bank3 routines run from ROM.
; A8/I16, D=0, binary arithmetic. Bound callbacks return I16 and preserve
; their actor identity through the dispatcher; CPU/GSU ownership is external.
; Unlike the early camera dispatcher, raw calls publish race_protectedactor
; for deferred removal. Zero primary/secondary pointers keep its old value.
; The pool initializer links number_al early records (140), not retail's 310.
; Call it only at a quiescent scene boundary; it does not release GSU bodies.
; Stepactors requires a nonempty active list, as in the native caller.
; Objectdraw restores/saves the existing raw polygon-work context around
; the real object task while CPU cell/build/wake work runs before its wait.
; Publication follows the wait. Initialize view/target cells, player 0/1,
; effect clock, actor/cell lists, bound raw heaps and source shape headers.
; Drawparallel requires DB=0; objectdraw preserves the caller DB.
; No active scene, renderer, NMI vector or main-menu controller is installed.
	incpublics mrframe.ext
	include mrupdate.ext
	include mrcpu.ext
	include mrscene.ext
mrframe_begin
	shorta
	longi
rfr_drawparallel
	jsl retail_viewcells_l
rfr_02bf0b
	jsl retail_builddrawlist_l
rfr_02bf0e
	jsl retail_targetcells_l
rfr_02bf11
	jsl retail_wakevisible_l
rfr_02bf14
	jsl retail_waitdrawtask_l
rfr_02bf17
	jsl retail_uploaddrawlist_l
rfr_02bf1b
	rts
retail_objectdraw_l
	a8i16
	jsl retail_restorerawcontext_l
rfr_objectdraw
	a8
rfr_02bf4a
	i16
rfr_02bf4c
	stz mariotimer
rfr_02bf4e
	stz mariotimer+1
rfr_02bf50
	lda #mretail_objectframe>>16
rfr_02bf52
	ldx #mretail_objectframe&WM
rfr_02bf55
	sta.l $003034
rfr_02bf59
	phb
rfr_02bf5a
	lda #$00
rfr_02bf5c
	pha
rfr_02bf5d
	plb
rfr_02bf5e
	lda.w mario_draw_mode
rfr_02bf61
	ora #$18
rfr_02bf63
	sta.w $303a
rfr_02bf66
	stz.w $3030
rfr_02bf69
	stx.w $301e
rfr_02bf6c
	jsr rfr_drawparallel
rfr_02bf6f
	a16
rfr_02bf71
	lda mariotimer
rfr_02bf73
	sta.w race_diagword1
rfr_02bf76
	a8
	jsl retail_saverawcontext_l
rfr_02bf78
	plb
rfr_02bf79
	rtl
retail_publishview_l
	php
rfr_02bff1
	ai16
rfr_02bff3
	lda.w defaultID
rfr_02bff6
	sta.l m_defaultID
rfr_02bffa
	lda viewposx
rfr_02bffc
	sta.l m_viewposx
rfr_02c000
	lda viewposy
rfr_02c002
	sta.l m_viewposy
rfr_02c006
	lda viewposz
rfr_02c008
	sta.l m_viewposz
rfr_02c00c
	lda.w viewrotxw
rfr_02c00f
	sta.l m_viewrotx
rfr_02c013
	lda.w viewrotyw
rfr_02c016
	sta.l m_viewroty
rfr_02c01a
	lda.w viewrotzw
rfr_02c01d
	sta.l m_viewrotz
rfr_02c021
	lda.w viewposflags
rfr_02c024
	sta.l m_retailviewflags
rfr_02c028
	plp
rfr_02c029
	rtl
	shorta
retail_callactor_l
	php
rfr_03cab9
	phx
rfr_03caba
	lda.w al_stratptr+2,x
rfr_03cabd
	sta.w tjmp+2
rfr_03cac0
	a16
rfr_03cac2
	lda.w al_stratptr,x
rfr_03cac5
	beq rfr_03cae8
rfr_03cac7
	sta.w tjmp
rfr_03caca
	stx.w race_protectedactor
rfr_03cacd
	a8
rfr_03cacf
	lda #mrframe_begin>>16
rfr_03cad1
	pha
rfr_03cad2
	a16
rfr_03cad4
	lda #(rfr_03cae8-1)&WM
rfr_03cad7
	pha
rfr_03cad8
	a8
rfr_03cada
	lda.w tjmp+2
rfr_03cadd
	pha
rfr_03cade
	a16
rfr_03cae0
	lda.w tjmp
rfr_03cae3
	dec a
rfr_03cae4
	pha
rfr_03cae5
	a8
rfr_03cae7
	rtl
	longa
rfr_03cae8
	plx
	shorta
rfr_03cae9
	plp
rfr_03caea
	rtl
retail_calltempactor_l
	php
rfr_03caec
	phx
rfr_03caed
	lda.w al_tempstratptr+2,x
rfr_03caf0
	sta.w tjmp+2
rfr_03caf3
	a16
rfr_03caf5
	lda.w al_tempstratptr,x
rfr_03caf8
	beq rfr_03cb20
rfr_03cafa
	sta.w tjmp
rfr_03cafd
	lda.w al_collobjptr,x
rfr_03cb00
	bne rfr_03cb20
rfr_03cb02
	stx.w race_protectedactor
rfr_03cb05
	a8
rfr_03cb07
	lda #mrframe_begin>>16
rfr_03cb09
	pha
rfr_03cb0a
	a16
rfr_03cb0c
	lda #(rfr_03cb20-1)&WM
rfr_03cb0f
	pha
rfr_03cb10
	a8
rfr_03cb12
	lda.w tjmp+2
rfr_03cb15
	pha
rfr_03cb16
	a16
rfr_03cb18
	lda.w tjmp
rfr_03cb1b
	dec a
rfr_03cb1c
	pha
rfr_03cb1d
	a8
rfr_03cb1f
	rtl
	longa
rfr_03cb20
	a8
rfr_03cb22
	plx
rfr_03cb23
	plp
rfr_03cb24
	rtl
retail_stepactors_l
	a8
rfr_03d38a
	inc.w race_effectclock
rfr_03d38d
	bne rfr_03d392
rfr_03d38f
	inc.w race_effectclock+1
rfr_03d392
	i16
rfr_03d394
	phb
rfr_03d395
	lda #$7e
rfr_03d397
	pha
rfr_03d398
	plb
rfr_03d399
	ldx.w alxlst
rfr_03d39c
	stz.w race_removerequest
rfr_03d39f
	lda.w al_sbyte4,x
rfr_03d3a2
	beq rfr_03d3cb
rfr_03d3a4
	bmi rfr_03d3b4
rfr_03d3a6
	dec a
rfr_03d3a7
	bne rfr_03d3bf
rfr_03d3a9
	stz.w al_collobjptr,x
rfr_03d3ac
	stz.w al_collobjptr+1,x
rfr_03d3af
	stz.w al_sbyte4,x
rfr_03d3b2
	bra rfr_03d3cb
rfr_03d3b4
	lda #$03
rfr_03d3b6
	sta.w al_sbyte4,x
rfr_03d3b9
	jsl retail_calltempactor_l
rfr_03d3bd
	bra rfr_03d3c6
rfr_03d3bf
	sta.w al_sbyte4,x
rfr_03d3c2
	jsl retail_callactor_l
rfr_03d3c6
	lda.w race_removerequest
rfr_03d3c9
	bne rfr_03d3d3
rfr_03d3cb
	ldy.w al_next,x
rfr_03d3ce
	tyx
rfr_03d3cf
	bne rfr_03d39c
rfr_03d3d1
	bra rfr_03d3dc
rfr_03d3d3
	ldy.w al_next,x
rfr_03d3d6
	jsl retail_removeactor_l
rfr_03d3da
	bra rfr_03d3ce
rfr_03d3dc
	plb
rfr_03d3dd
	rtl
retail_initactorpool_l
	php
rfr_03d3df
	a8
rfr_03d3e1
	phb
rfr_03d3e2
	lda #$7e
rfr_03d3e4
	pha
rfr_03d3e5
	plb
rfr_03d3e6
	ai16
rfr_03d3e8
	stz.w alxlst
rfr_03d3eb
	stz.w race_actorcurrent
rfr_03d3ee
	lda #$0001
rfr_03d3f1
	sta.w alxfreelst
rfr_03d3f4
	ldy #number_al
rfr_03d3f7
	tax
rfr_03d3f8
	clc
rfr_03d3f9
	adc #alx_size
rfr_03d3fc
	sta.w al_next,x
rfr_03d3ff
	dey
rfr_03d400
	bne rfr_03d3f7
rfr_03d402
	stz.w al_next,x
rfr_03d405
	a8
rfr_03d407
	plb
rfr_03d408
	plp
rfr_03d409
	rtl
retail_drawparallel_l
	jsr rfr_drawparallel
	rtl
mrframe_end
