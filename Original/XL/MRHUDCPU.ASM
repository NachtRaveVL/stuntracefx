; A8/I16: A=script bank, X=script address, Y=Y:X origin bytes.
; Run after geometry, with the destination bitmap selected.
retail_hudscript_l
	a8i16
	sta.l $003012
	lda #0
	sta.l $003013
	a16
	txa
	sta.l $003010
	tya
	and #$00ff
	sta.l $00300e
	tya
	xba
	and #$00ff
	sta.l $00300c
	a8
	lda #mretail_hudscript>>16
	ldx #mretail_hudscript&WM
	jml runmario_l
mrhudcpu_end
