; A8/I16; X points to 928 owned bytes in $7e, within one bank.
; Stage only after drawing. The render queue and projected points are dead.
; The first 914 bytes contain weather state and scratch; next are native
; car flags, signed speed and a nonzero active-car-present word.
; Offset 920: marker style; remaining six bytes are scratch.
; State may be zeroed by the owner when entering a scene.
retail_posteffects_l
	a8i16
	phb
	phx
	a16
	ldy #m_rotpnts&WM
	lda #799
	db $54,$70,$7e
	ldy #m_clippolybuf&WM
	lda #127
	db $54,$70,$7e
	a8
	lda #mretail_posteffects>>16
	ldx #mretail_posteffects&WM
	jsl runmario_l
	ply
	a16
	ldx #m_rotpnts&WM
	lda #799
	db $54,$7e,$70
	ldx #m_clippolybuf&WM
	lda #127
	db $54,$7e,$70
	a8
	plb
	rtl

; A=scene, X=WRAM effects state. Keep the renderer's count guard.
retail_renderfx_l
	a8i16
	phx
	jsl retail_renderframe_l
	plx
	bcs rfx_render_reject
	jsl retail_posteffects_l
	clc
rfx_render_reject
	rtl
rfx_cpu_end
