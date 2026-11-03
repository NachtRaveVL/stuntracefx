; Flush a bounded primitive queue. R8=queue base, m_tr2=end;
; reserve one writable sentinel word at the end. Coordinates must already
; be clipped to the target bitmap. R0=0 success/empty, 1 unsupported queue.
; The mixed entry accepts textured records too, with caller-bound pixel
; banks and texture scroll. Malformed queues are refused before any plot.
; Uses the scan-converter workspace as scratch. Caller owns pixel cache flushing.
mrflrast_begin
mretail_flatflush
	ibt r3,#0
	bra rfr_scaninit
	nop
mretail_mixedflush
	ibt r3,#1
rfr_scaninit
	with r8
	to r9
	lms r7,[m_tr2]
rfr_scan
	from r9
	cmp r7
	beq rfr_begin
	nop
	bcs rfr_refuse
	nop
	from r9
	add #1
	cmp r7
	bcs rfr_refuse
	nop
	ldb [r9]
	sex
	bmi rfr_scantexture
	nop
	ibt r6,#2
	cmp r6
	bcc rfr_refuse
	nop
	ibt r6,#25
	cmp r6
	bcs rfr_refuse
	nop
	add r0
	add r0
	add #1
	add #1
	bra rfr_scanadvance
	nop
rfr_scantexture
	with r3
	from r3
	beq rfr_refuse
	nop
	not
	ibt r6,#3
	cmp r6
	bcc rfr_refuse
	nop
	ibt r6,#10
	cmp r6
	bcs rfr_refuse
	nop
	inc r0
	add r0
	add r0
	add r0
rfr_scanadvance
	with r9
	add r0
	bcc rfr_scan
	nop
rfr_refuse
	ibt r0,#1
	jmp r11
	nop
rfr_begin
	sms [m_clipz],r8
	iwt r15,#rfr_a931&WM
	nop
rfr_a90e
	bne rfr_texorend
	nop
	iwt r15,#rfr_aaa2&WM
	nop
rfr_texorend
	inc r0
	inc r0
	beq rfr_a91e
	not
	iwt r15,#rfr_a662&WM
	nop
rfr_a91e
	lms r1,[m_clipz]
	sms [m_tr2],r1
	lms r0,[m_shapebank]
	romb
	lms r10,[m_sp]
	dec r10
	dec r10
	to r11
	ldw [r10]
	sub r0
	jmp r11
	nop
rfr_a662
	lob
	with r0
	to r12
	add r0
	add r0
	add r0
	with r0
	to r3
	ldb [r1]
	inc r1
	sms [m_sprbank],r0
	sub r0
	cmode
	ldw [r1]
	inc r1
	inc r1
	colour
	swap
	cmode
	ldw [r1]
	inc r1
	inc r1
	sms [m_sprdata],r0
	ldw [r1]
	inc r1
	inc r1
	sms [m_sprmask],r0
	from r1
	add r3
	sms [m_tr2],r0
	with r1
	to r5
	from r1
	to r4
	sub r3
	iwt r2,#$03ff
	ibt r8,#$00
	with r15
	to r13
	ldb [r5]
	stb [r4]
	inc r4
	inc r4
	inc r5
	inc r5
	ldb [r5]
	stb [r4]
	cmp r2
	bpl rfr_a6ac
	nop
	with r0
	to r2
	with r4
	to r6
rfr_a6ac
	cmp r8
	bmi rfr_a6b3
	nop
	with r0
	to r8
rfr_a6b3
	inc r4
	inc r4
	inc r5
	inc r5
	sub r0
	inc r5
	ldb [r5]
	dec r5
	stb [r5]
	inc r5
	inc r5
	stb [r4]
	inc r4
	inc r4
	inc r5
	ldb [r5]
	dec r5
	stb [r5]
	inc r5
	inc r5
	stb [r4]
	inc r4
	loop
	inc r4
	from r2
	sub r8
	bne rfr_a6da
	nop
	iwt r15,#rfr_a909&WM
	nop
rfr_a6da
	with r6
	to r4
	dec r4
	dec r4
	from r4
	to r5
	add r3
	ldb [r4]
	inc r4
	inc r4
	to r9
	swap
	with r9
	to r10
	inc r4
	inc r4
	ldb [r4]
	swap
	sms [m_dxp1],r0
	sms [m_dxp2],r0
	inc r4
	inc r4
	ldb [r4]
	swap
	sms [m_dyp1],r0
	sms [m_dyp2],r0
	inc r4
	inc r4
	sms [m_dy1],r4
	sms [m_dy2],r5
	ibt r11,#$00
	ibt r3,#$00
	cache
	iwt r15,#rfr_a7d9&WM
	nop
rfr_a710
	sms [m_xp1],r7
	sms [m_xp2],r8
	from r11
	sub r3
	bmi rfr_a729
	nop
	sms [m_x1],r0
	from r3
	swap
	to r2
	or r2
	sub r0
	sms [m_x2],r0
	bra rfr_a736
	nop
rfr_a729
	from r3
	sub r11
	sms [m_x2],r0
	from r11
	swap
	to r2
	or r2
	sub r0
	sms [m_x1],r0
rfr_a736
	from r9
	to r1
	hib
	from r10
	hib
	to r12
	sub r1
	bcs rfr_a742
	inc r12
	ibt r12,#$01
rfr_a742
	iwt r0,#reciptab16s&WM
	add r12
	to r14
	add r12
	to r6
	getb
	inc r14
	with r6
	getbh
	lms r0,[m_yp2]
	lms r4,[m_dxp2]
	add r4
	sbk
	lms r8,[m_dxp1]
	from r4
	sub r8
	fmult
	to r5
	rol
	lms r0,[m_yp1]
	add r8
	sms [m_dxp1],r0
	lms r0,[m_clipdx]
	lms r4,[m_dyp2]
	add r4
	sbk
	lms r7,[m_dyp1]
	from r4
	sub r7
	fmult
	to r6
	rol
	lms r0,[m_texptr]
	add r7
	sms [m_dyp1],r0
	lms r4,[m_sprxscroll]
	with r8
	add r4
	lms r4,[m_spryscroll]
	with r7
	add r4
	lms r0,[m_sprbank]
	lob
	romb
	lms r4,[m_sprdata]
	lms r3,[m_sprmask]
	with r15
	to r13
	merge
	and r3
	to r14
	add r4
	with r7
	add r6
	with r8
	add r5
	getc
	loop
	plot
	sub r0
	romb
	lms r7,[m_xp1]
	lms r8,[m_xp2]
	with r9
	add r7
	bpl rfr_a7b6
	nop
	iwt r0,#$0800
	add r9
	bmi rfr_a7b6
	nop
	ibt r9,#$00
rfr_a7b6
	with r10
	add r8
	bpl rfr_a7c4
	nop
	iwt r0,#$0800
	add r10
	bmi rfr_a7c4
	nop
	ibt r10,#$00
rfr_a7c4
	inc r2
	from r2
	swap
	dec r0
	to r2
	swap
	from r2
	hib
	beq rfr_a7d3
	nop
	iwt r15,#rfr_a736&WM
	nop
rfr_a7d3
	lms r11,[m_x1]
	lms r3,[m_x2]
rfr_a7d9
	with r0
	from r11
	beq rfr_a7e2
	nop
	iwt r15,#rfr_a870&WM
	nop
rfr_a7e2
	ibt r0,#$7f
	add r9
	to r9
	hib
	lms r0,[m_dxp1]
	hib
	sbk
	lms r0,[m_dyp1]
	hib
	sbk
	lms r6,[m_dy1]
rfr_a7f4
	with r9
	to r12
	lms r0,[m_dxp1]
	sms [m_xp1inc],r0
	lms r0,[m_dyp1]
	sms [m_yp1inc],r0
	to r9
	ldb [r6]
	inc r6
	inc r6
	to r4
	ldb [r6]
	inc r6
	inc r6
	ldb [r6]
	sms [m_dxp1],r0
	inc r6
	inc r6
	ldb [r6]
	sms [m_dyp1],r0
	inc r6
	inc r6
	from r4
	to r11
	sub r2
	beq rfr_a7f4
	nop
	bpl rfr_a827
	nop
	iwt r15,#rfr_a909&WM
	nop
rfr_a827
	sms [m_dy1],r6
	iwt r0,#reciptab16s&WM
	add r11
	to r14
	add r11
	to r6
	getb
	inc r14
	with r6
	getbh
	from r9
	sub r12
	from r12
	to r9
	swap
	lmult
	with r4
	add r4
	rol
	lob
	swap
	with r4
	hib
	to r7
	or r4
	lms r0,[m_dxp1]
	lms r1,[m_xp1inc]
	sub r1
	lob
	swap
	fmult
	rol
	sms [m_yp1],r0
	lms r0,[m_xp1inc]
	swap
	sms [m_dxp1],r0
	lms r0,[m_dyp1]
	lms r1,[m_yp1inc]
	sub r1
	lob
	swap
	fmult
	rol
	sms [m_texptr],r0
	lms r0,[m_yp1inc]
	swap
	sms [m_dyp1],r0
rfr_a870
	with r0
	from r3
	beq rfr_a879
	nop
	iwt r15,#rfr_a710&WM
	nop
rfr_a879
	ibt r0,#$7f
	add r10
	to r10
	hib
	lms r0,[m_dxp2]
	hib
	sbk
	lms r0,[m_dyp2]
	hib
	sbk
	lms r6,[m_dy2]
rfr_a88b
	with r10
	to r12
	lms r0,[m_dxp2]
	sms [m_xp2inc],r0
	lms r0,[m_dyp2]
	sms [m_yp2inc],r0
	dec r6
	dec r6
	ldb [r6]
	sms [m_dyp2],r0
	dec r6
	dec r6
	ldb [r6]
	sms [m_dxp2],r0
	dec r6
	dec r6
	ldb [r6]
	dec r6
	dec r6
	to r10
	ldb [r6]
	to r3
	sub r2
	beq rfr_a88b
	nop
	bpl rfr_a8bc
	nop
	iwt r15,#rfr_a909&WM
	nop
rfr_a8bc
	sms [m_dy2],r6
	iwt r0,#reciptab16s&WM
	add r3
	to r14
	add r3
	to r6
	getb
	inc r14
	with r6
	getbh
	from r10
	sub r12
	from r12
	to r10
	swap
	lmult
	with r4
	add r4
	rol
	lob
	swap
	with r4
	hib
	to r8
	or r4
	lms r0,[m_dxp2]
	lms r1,[m_xp2inc]
	sub r1
	lob
	swap
	fmult
	rol
	sms [m_yp2],r0
	lms r0,[m_xp2inc]
	swap
	sms [m_dxp2],r0
	lms r0,[m_dyp2]
	lms r1,[m_yp2inc]
	sub r1
	lob
	swap
	fmult
	rol
	sms [m_clipdx],r0
	lms r0,[m_yp2inc]
	swap
	sms [m_dyp2],r0
	iwt r15,#rfr_a710&WM
	nop
rfr_a909
	iwt r15,#rfr_a950&WM
	nop
	cache
rfr_a931
	lms r1,[m_tr2]
	lms r0,[m_clipz]
	sub r1
	bne rfr_a93d
	nop
	sub r0
	jmp r11
	nop
rfr_a93d
	from r11
	stw [r10]
	inc r10
	inc r10
	sms [m_sp],r10
	sub r0
	stw [r1]
	lms r1,[m_clipz]
	sms [m_tr2],r1
	ibt r0,#$00
	romb
rfr_a950
	lms r1,[m_tr2]
	ldb [r1]
	sex
	inc r1
	sub #3
	bpl rfr_a95c
	inc r0
	iwt r15,#rfr_a90e&WM
	nop
rfr_a95c
	cache
	inc r0
	inc r0
	with r0
	to r12
	add r0
	add r0
	with r0
	to r3
	ibt r0,#$70
	colour
	ibt r0,#$00
	cmode
	ldb [r1]
	inc r1
	colour
	from r1
	add r3
	sms [m_tr2],r0
	with r1
	to r5
	from r1
	to r4
	sub r3
	iwt r2,#$03ff
	ibt r8,#$00
	with r15
	to r13
	ldb [r5]
	stb [r4]
	inc r4
	inc r4
	inc r5
	inc r5
	ldb [r5]
	stb [r4]
	cmp r2
	bpl rfr_a996
	inc r5
	with r0
	to r2
	with r4
	to r6
rfr_a996
	sub r8
	bmi rfr_a99c
	inc r5
	to r8
	add r8
rfr_a99c
	inc r4
	loop
	inc r4
	from r8
	sub r2
	dec r0
	dec r0
	bpl rfr_a9aa
	nop
	iwt r15,#rfr_aa74&WM
	nop
rfr_a9aa
	dec r6
	dec r6
	from r6
	to r5
	add r3
	dec r5
	dec r5
	to r8
	ldb [r6]
	with r6
	add #4
	to r9
	from r8
	swap
	iwt r13,#rfr_aa49&WM
	with r3
	bra rfr_a9d0
	sub r3
rfr_a9c1
	with r11
	from r11
	bne rfr_aa03
	nop
	ibt r0,#$7f
	add r7
	to r7
	hib
	lms r6,[m_dy1]
rfr_a9ce
	with r7
	to r8
rfr_a9d0
	to r7
	ldb [r6]
	inc r6
	inc r6
	ldb [r6]
	inc r6
	to r11
	sub r2
	bpl rfr_a9e1
	nop
	iwt r15,#rfr_aa70&WM
	nop
rfr_a9e1
	beq rfr_a9ce
	inc r6
	iwt r0,#reciptab16s&WM
	add r11
	to r14
	add r11
	sms [m_dy1],r6
	from r7
	sub r8
	to r6
	getb
	inc r14
	from r8
	to r7
	swap
	with r6
	getbh
	lmult
	with r4
	add r4
	rol
	lob
	swap
	with r4
	hib
	to r8
	or r4
rfr_aa03
	with r3
	from r3
	bne rfr_aa3f
	nop
	ibt r0,#$7f
	add r9
	to r9
	hib
rfr_aa0d
	with r9
	to r10
	ldb [r5]
	dec r5
	dec r5
	to r9
	ldb [r5]
	dec r5
	to r3
	sub r2
	bpl rfr_aa20
	nop
	iwt r15,#rfr_aa70&WM
	nop
rfr_aa20
	beq rfr_aa0d
	dec r5
	iwt r0,#reciptab16s&WM
	add r3
	to r14
	add r3
	from r9
	sub r10
	to r6
	getb
	inc r14
	from r10
	to r9
	swap
	with r6
	getbh
	lmult
	with r4
	add r4
	rol
	lob
	swap
	with r4
	hib
	to r10
	or r4
rfr_aa3f
	from r7
	to r1
	hib
	from r9
	hib
	to r12
	sub r1
	bmi rfr_aa4b
	inc r12
rfr_aa49
	loop
	plot
rfr_aa4b
	with r7
	add r8
	bpl rfr_aa59
	dec r11
	iwt r0,#$0800
	add r7
	bmi rfr_aa59
	nop
	ibt r7,#$00
rfr_aa59
	with r9
	add r10
	bpl rfr_aa67
	dec r3
	iwt r0,#$0800
	add r9
	bmi rfr_aa67
	nop
	ibt r9,#$00
rfr_aa67
	from r11
	and r3
	bne rfr_aa3f
	inc r2
	iwt r15,#rfr_a9c1&WM
	nop
rfr_aa70
	iwt r15,#rfr_a950&WM
	nop
rfr_aa74
	from r3
	lsr
	to r12
	lsr
	iwt r1,#$03ff
	ibt r8,#$00
	with r15
	to r13
	ldb [r4]
	cmp r1
	bpl rfr_aa88
	inc r4
	with r0
	to r1
rfr_aa88
	sub r8
	bmi rfr_aa8e
	inc r4
	to r8
	add r8
rfr_aa8e
	inc r4
	loop
	inc r4
	from r8
	to r12
	sub r1
	bmi rfr_aa9e
	nop
	beq rfr_aa9e
	nop
	with r15
	to r13
	loop
	plot
rfr_aa9e
	iwt r15,#rfr_a950&WM
	nop
rfr_aaa2
	ibt r0,#$70
	colour
	ibt r0,#$00
	cmode
	with r1
	to r7
	ldb [r7]
	inc r7
	colour
	to r1
	ldb [r7]
	inc r7
	inc r7
	to r2
	ldb [r7]
	inc r7
	inc r7
	to r3
	ldb [r7]
	inc r7
	inc r7
	to r4
	ldb [r7]
	inc r7
	inc r7
	sms [m_tr2],r7
	ibt r5,#$01
	with r3
	sub r1
	bpl rfr_aad2
	nop
	ibt r5,#-1
	with r3
	not
	inc r3
rfr_aad2
	ibt r6,#$01
	with r4
	sub r2
	bpl rfr_aade
	nop
	ibt r6,#-1
	with r4
	not
	inc r4
rfr_aade
	from r3
	sub r4
	bmi rfr_aaf9
	nop
	with r3
	to r12
	inc r12
	lsr
	sub r4
	with r15
	to r13
	bcs rfr_aaf0
	plot
	add r3
	with r2
	add r6
rfr_aaf0
	dec r1
	with r1
	add r5
	loop
	sub r4
	iwt r15,#rfr_a950&WM
	nop
rfr_aaf9
	with r4
	to r12
	inc r12
	not
	inc r0
	lsr
	sub r3
	with r15
	to r13
	bcs rfr_ab08
	plot
	add r4
	with r1
	add r5
rfr_ab08
	dec r1
	with r2
	add r6
	loop
	sub r3
	iwt r15,#rfr_a950&WM
	nop
mrflrast_end
