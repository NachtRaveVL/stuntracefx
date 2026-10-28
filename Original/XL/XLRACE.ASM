; Retail vehicle identity -> audio kind, US $03:EC43-$03:EC6A.
; Bank-9 identities remain native until retail vehicle creation is bound.
; A16: definition identity. Returns A=0..4, X/Y/DB/D preserved; flags scratch.

	incpublics	xlrace.ext

race_defkind_l
	longa
	jsr	race_defkind
	rtl
race_defkind
	cmp	#$81b9
	bne	.kind1
	lda	#$0000
	rts
.kind1
	cmp	#$853d
	bne	.kind2
	lda	#$0001
	rts
.kind2
	cmp	#$8411
	bne	.kind3
	lda	#$0002
	rts
.kind3
	cmp	#$82e5
	bne	.kind4
	lda	#$0003
	rts
.kind4
	lda	#$0004
	rts

; US $03:DCEF-$03:DD1A. D=DB=0; restore P, A/X scratch, Y preserved.
; Inputs are the two selected native definition identities. The cached
; first-player kind changes only while either reload block is active.
race_selectkinds_l
	php
	a16
	lda.l	race_def0
	jsr	race_defkind
	ai8
	sta	racesound_kind0
	ldx	racesound_block0
	bne	.cache
	ldx	racesound_block1
	beq	.second
.cache
	sta	race_cachedkind
.second
	a16
	lda.l	race_def1
	jsr	race_defkind
	a8
	sta	racesound_kind1
	plp
	rtl

; US $03:EDDF-$03:EDF3. The shared five-byte kind map is already restored.
; Native indexing is unguarded; caller supplies a selected kind 0..4.
race_enginecommand_l
	php
	ai8
	ldx	racesound_kind0
	lda.l	raceload_kindmap,x
	jsl	queue_racesound0_l
	plp
	rtl
