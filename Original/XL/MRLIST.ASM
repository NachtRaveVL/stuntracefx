; CPU ownership of the standalone retail render task.
mrlistcpu_begin
; A8/I16, A=scene, X/Y=queue base/limit. Call after sorting has stopped.
; The normal CPU task owner sets screen access mode and waits for STOP.
retail_renderlist_l
	a8i16
	sta.l $00300e
	lda #0
	sta.l $00300f
	a16
	txa
	sta.l $003010
	tya
	sta.l $003012
	a8
	lda #mretail_renderlist>>16
	ldx #mretail_renderlist&WM
	jml runmario_l

; A8/I16, A=scene. The caller has published the view matrix and the
; retail draw records and owns the stopped GSU. Sort and then draw.
; The retail producer is limited to 49 records; recycle the unused
; tail of the 70-record source array for the queue and sentinel.
; Carry set: count exceeds the retail producer limit; nothing launched.
rlist_maxdraw equ 49
rlist_queue equ rlist_maxdraw*dl_sizeof
rlist_limit equ number_drawal*dl_sizeof-2
	iflt rlist_limit-rlist_queue-208
	fail
	endc
retail_renderframe_l
	a8i16
	pha
	lda.l m_numshapes
	cmp #rlist_maxdraw+1
	bcc rlist_sort
	pla
	sec
	rtl
rlist_sort
	lda #mretail_sortdrawlist>>16
	ldx #mretail_sortdrawlist&WM
	jsl runmario_l
	pla
	ldx #(m_drawlist+rlist_queue)&WM
	ldy #(m_drawlist+rlist_limit)&WM
	jsl retail_renderlist_l
	clc
	rtl
mrlistcpu_end

; Run at the frame owner's particle lifetime update point.
retail_ageparticles_l
	a8i16
	lda #mretail_updateparticles>>16
	ldx #mretail_updateparticles&WM
	jml runmario_l
