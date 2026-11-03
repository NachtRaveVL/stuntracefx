; Retail weather and camera splashes, called after all geometry.
; The owner stages 800 weather bytes and a 120-byte splash/control block.
; View-car present, flags ($8A) and speed ($4A) are supplied snapshots.
; The bitmap and viewport must belong to the same view.
mrfx_begin
mretail_posteffects
	sub r0
	ramb
	iwt r10,#m_stack&WM
	cmode
	lm r0,[rfx_present]
	with r0
	from r0
	beq rfx_nowx
	nop
	lm r1,[rfx_flags]
	iwt r0,#1
	and r1
	beq rfx_weather2
	nop
	ibt r0,#16
	sm [m_retailimpactflash],r0
	ibt r0,#1
	bra rfx_weather
	nop
rfx_weather2
	iwt r0,#2
	and r1
	beq rfx_nowx
	nop
	ibt r0,#2
rfx_weather
	ibt r1,#80
	link #4
	iwt r15,#rfx_bc7d&WM
	nop
	bra rfx_camera
	nop
rfx_nowx
	sub r0
	sm [rfx_mode],r0
rfx_camera
	link #4
	iwt r15,#rfx_bf6d&WM
	nop
	sub r0
	sm [m_retailimpactflash],r0
	link #4
	iwt r15,#mretail_nearcarmarker&WM
	nop
	rpix
	stop
	nop
rfx_bc35
	sm [rfx_mode],r0
rfx_bc39
	from r11
rfx_bc3a
	stw [r10]
rfx_bc3b
	inc r10
rfx_bc3c
	inc r10
rfx_bc3d
	sub r0
rfx_bc3e
	iwt r2,#$0050
rfx_bc41
	iwt r1,#rfx_weatherbuf&WM
rfx_bc44
	ibt r3,#$00
rfx_bc46
	iwt r4,#$003f
rfx_bc49
	cache
rfx_bc4a
	with r3
rfx_bc4b
	to r0
rfx_bc4c
	not
rfx_bc4d
	inc r0
rfx_bc4e
	stb [r1]
rfx_bc50
	inc r1
rfx_bc51
	inc r3
rfx_bc52
	with r3
rfx_bc53
	and r4
rfx_bc54
	sub r0
rfx_bc55
	iwt r12,#$0009
rfx_bc58
	with r15
rfx_bc59
	to r13
rfx_bc5a
	stb [r1]
rfx_bc5c
	loop
rfx_bc5d
	inc r1
rfx_bc5e
	dec r2
rfx_bc5f
	bne rfx_bc4a
rfx_bc61
	nop
rfx_bc62
	sub r0
rfx_bc63
	sm [rfx_prevangle],r0
rfx_bc67
	sm [rfx_drift],r0
rfx_bc6b
	iwt r1,#rfx_splashes&WM
rfx_bc6e
	iwt r12,#$0030
rfx_bc71
	with r15
rfx_bc72
	to r13
rfx_bc73
	stw [r1]
rfx_bc74
	inc r1
rfx_bc75
	inc r1
rfx_bc76
	loop
rfx_bc77
	nop
rfx_bc78
	dec r10
rfx_bc79
	dec r10
rfx_bc7a
	to r15
rfx_bc7b
	ldw [r10]
rfx_bc7c
	nop
rfx_bc7d
	lm r3,[rfx_mode]
rfx_bc81
	cmp r3
rfx_bc83
	bne rfx_bc35
rfx_bc85
	nop
rfx_bc86
	ibt r3,#$01
rfx_bc88
	cmp r3
rfx_bc8a
	beq rfx_bc97
rfx_bc8c
	nop
rfx_bc8d
	ibt r3,#$02
rfx_bc8f
	cmp r3
rfx_bc91
	beq rfx_bc97
rfx_bc93
	nop
rfx_bc94
	with r11
rfx_bc95
	to r15
rfx_bc96
	nop
rfx_bc97
	from r11
rfx_bc98
	stw [r10]
rfx_bc99
	inc r10
rfx_bc9a
	inc r10
rfx_bc9b
	lms r7,[m_particlerand]
rfx_bc9e
	with r12
rfx_bc9f
	from r1
rfx_bca0
	bne rfx_bca7
rfx_bca2
	nop
rfx_bca3
	iwt r15,#rfx_bf65&WM
rfx_bca6
	nop
rfx_bca7
	with r0
rfx_bca8
	to r11
rfx_bca9
	sub r0
rfx_bcaa
	ramb
rfx_bcac
	ibt r0,#$14
rfx_bcae
	romb
rfx_bcb0
	ibt r0,#$01
rfx_bcb2
	cmode
rfx_bcb4
	from r11
rfx_bcb5
	sub #1
rfx_bcb7
	beq rfx_bcd2
rfx_bcb9
	nop
rfx_bcba
	ibt r3,#$1f
rfx_bcbc
	ibt r4,#$0f
rfx_bcbe
	ibt r5,#$07
rfx_bcc0
	ibt r6,#$05
rfx_bcc2
	iwt r0,#$0020
rfx_bcc5
	sm [(rfx_tmp+8)],r0
rfx_bcc9
	ibt r0,#$64
rfx_bccb
	sm [(rfx_tmp+6)],r0
rfx_bccf
	bra rfx_bce7
rfx_bcd1
	nop
rfx_bcd2
	ibt r3,#$1f
rfx_bcd4
	ibt r4,#$3f
rfx_bcd6
	ibt r5,#$1f
rfx_bcd8
	ibt r6,#$28
rfx_bcda
	iwt r0,#$002a
rfx_bcdd
	sm [(rfx_tmp+8)],r0
rfx_bce1
	ibt r0,#$1e
rfx_bce3
	sm [(rfx_tmp+6)],r0
rfx_bce7
	lm r2,[rfx_drift]
rfx_bceb
	from r7
rfx_bcec
	swap
rfx_bced
	ror
rfx_bcee
	add r7
rfx_bcef
	to r7
rfx_bcf0
	adc r7
rfx_bcf2
	to r1
rfx_bcf3
	and r3
rfx_bcf4
	bne rfx_bcfb
rfx_bcf6
	nop
rfx_bcf7
	hib
rfx_bcf8
	and r4
rfx_bcf9
	to r2
rfx_bcfa
	sub r5
rfx_bcfb
	lm r1,[rfx_drift]
rfx_bcff
	from r2
rfx_bd00
	sub r1
rfx_bd01
	div2
rfx_bd03
	div2
rfx_bd05
	div2
rfx_bd07
	add r1
rfx_bd08
	sbk
rfx_bd09
	lm r0,[m_viewrotx]
rfx_bd0d
	lm r1,[rfx_prevangle]
rfx_bd11
	sm [rfx_prevangle],r0
rfx_bd15
	sub r1
rfx_bd16
	div2
rfx_bd18
	div2
rfx_bd1a
	div2
rfx_bd1c
	div2
rfx_bd1e
	div2
rfx_bd20
	not
rfx_bd21
	inc r0
rfx_bd22
	lm r1,[rfx_drift]
rfx_bd26
	add r1
rfx_bd27
	sm [rfx_tmp],r0
rfx_bd2b
	sm [(rfx_tmp+2)],r6
rfx_bd2f
	lm r0,[rfx_speed]
rfx_bd37
	with r0
rfx_bd38
	from r0
rfx_bd39
	bpl rfx_bd40
rfx_bd3b
	nop
rfx_bd3c
	iwt r15,#rfx_bf65&WM
rfx_bd3f
	nop
rfx_bd40
	not
rfx_bd41
	inc r0
rfx_bd42
	div2
rfx_bd44
	div2
rfx_bd46
	div2
rfx_bd48
	sm [(rfx_tmp+4)],r0
rfx_bd4c
	iwt r8,#rfx_weatherbuf&WM
rfx_bd4f
	cache
rfx_bd50
	with r15
rfx_bd51
	to r13
rfx_bd52
	ldb [r8]
rfx_bd54
	sex
rfx_bd55
	beq rfx_bd66
rfx_bd57
	dec r0
rfx_bd58
	bpl rfx_bdaa
rfx_bd5a
	nop
rfx_bd5b
	inc r0
rfx_bd5c
	inc r0
rfx_bd5d
	stb [r8]
rfx_bd5f
	with r8
rfx_bd60
	add #10
rfx_bd62
	iwt r15,#rfx_bf2a&WM
rfx_bd65
	nop
rfx_bd66
	lm r0,[(rfx_tmp+6)]
rfx_bd6a
	stb [r8]
rfx_bd6c
	inc r8
rfx_bd6d
	from r7
rfx_bd6e
	swap
rfx_bd6f
	ror
rfx_bd70
	add r7
rfx_bd71
	to r7
rfx_bd72
	adc r7
rfx_bd74
	lm r0,[(rfx_tmp+8)]
rfx_bd78
	stb [r8]
rfx_bd7a
	inc r8
rfx_bd7b
	iwt r3,#$01ff
rfx_bd7e
	to r3
rfx_bd7f
	and r3
rfx_bd80
	from r7
rfx_bd81
	swap
rfx_bd82
	ror
rfx_bd83
	add r7
rfx_bd84
	to r7
rfx_bd85
	adc r7
rfx_bd87
	iwt r1,#$03ff
rfx_bd8a
	and r1
rfx_bd8b
	iwt r1,#$01ff
rfx_bd8e
	sub r1
rfx_bd8f
	stw [r8]
rfx_bd90
	inc r8
rfx_bd91
	inc r8
rfx_bd92
	lms r1,[m_vanishy]
rfx_bd95
	from r3
rfx_bd96
	div2
rfx_bd98
	add r1
rfx_bd99
	not
rfx_bd9a
	inc r0
rfx_bd9b
	stw [r8]
rfx_bd9c
	inc r8
rfx_bd9d
	inc r8
rfx_bd9e
	from r3
rfx_bd9f
	stw [r8]
rfx_bda0
	inc r8
rfx_bda1
	inc r8
rfx_bda2
	sub r0
rfx_bda3
	stw [r8]
rfx_bda4
	inc r8
rfx_bda5
	inc r8
rfx_bda6
	iwt r15,#rfx_bf2a&WM
rfx_bda9
	nop
rfx_bdaa
	stb [r8]
rfx_bdac
	inc r8
rfx_bdad
	ldb [r8]
rfx_bdaf
	inc r8
rfx_bdb0
	colour
rfx_bdb1
	iwt r6,#$01ff
rfx_bdb4
	lm r1,[rfx_tmp]
rfx_bdb8
	ldw [r8]
rfx_bdb9
	inc r8
rfx_bdba
	inc r8
rfx_bdbb
	add r1
rfx_bdbc
	bpl rfx_bdc9
rfx_bdbe
	nop
rfx_bdbf
	add r6
rfx_bdc0
	bpl rfx_bddd
rfx_bdc2
	sub r6
rfx_bdc3
	with r6
rfx_bdc4
	to r0
rfx_bdc5
	dec r0
rfx_bdc6
	bra rfx_bdd1
rfx_bdc8
	nop
rfx_bdc9
	sub r6
rfx_bdca
	bmi rfx_bddd
rfx_bdcc
	add r6
rfx_bdcd
	with r6
rfx_bdce
	to r0
rfx_bdcf
	not
rfx_bdd0
	inc r0
rfx_bdd1
	sbk
rfx_bdd2
	with r8
rfx_bdd3
	add #4
rfx_bdd5
	sub r0
rfx_bdd6
	stw [r8]
rfx_bdd7
	inc r8
rfx_bdd8
	inc r8
rfx_bdd9
	iwt r15,#rfx_bf2a&WM
rfx_bddc
	nop
rfx_bddd
	sbk
rfx_bdde
	with r0
rfx_bddf
	to r9
rfx_bde0
	iwt r6,#$00ff
rfx_bde3
	lm r1,[(rfx_tmp+2)]
rfx_bde7
	ldw [r8]
rfx_bde8
	inc r8
rfx_bde9
	inc r8
rfx_bdea
	add r1
rfx_bdeb
	bpl rfx_bdf8
rfx_bded
	nop
rfx_bdee
	add r6
rfx_bdef
	bpl rfx_be0c
rfx_bdf1
	sub r6
rfx_bdf2
	with r6
rfx_bdf3
	to r0
rfx_bdf4
	dec r0
rfx_bdf5
	bra rfx_be00
rfx_bdf7
	nop
rfx_bdf8
	sub r6
rfx_bdf9
	bmi rfx_be0c
rfx_bdfb
	add r6
rfx_bdfc
	with r6
rfx_bdfd
	to r0
rfx_bdfe
	not
rfx_bdff
	inc r0
rfx_be00
	sbk
rfx_be01
	with r8
rfx_be02
	add #2
rfx_be04
	sub r0
rfx_be05
	stw [r8]
rfx_be06
	inc r8
rfx_be07
	inc r8
rfx_be08
	iwt r15,#rfx_bf2a&WM
rfx_be0b
	nop
rfx_be0c
	sbk
rfx_be0d
	with r0
rfx_be0e
	to r5
rfx_be0f
	iwt r6,#$01ff
rfx_be12
	lm r1,[(rfx_tmp+4)]
rfx_be16
	ldw [r8]
rfx_be17
	inc r8
rfx_be18
	inc r8
rfx_be19
	add r1
rfx_be1a
	bpl rfx_be22
rfx_be1c
	nop
rfx_be1d
	with r6
rfx_be1e
	to r0
rfx_be1f
	bra rfx_be28
rfx_be21
	nop
rfx_be22
	cmp r6
rfx_be24
	bmi rfx_be31
rfx_be26
	nop
rfx_be27
	sub r0
rfx_be28
	sbk
rfx_be29
	sub r0
rfx_be2a
	stw [r8]
rfx_be2b
	inc r8
rfx_be2c
	inc r8
rfx_be2d
	iwt r15,#rfx_bf2a&WM
rfx_be30
	nop
rfx_be31
	sbk
rfx_be32
	with r0
rfx_be33
	to r4
rfx_be34
	iwt r6,#$012c
rfx_be37
	with r6
rfx_be38
	add r4
rfx_be39
	with r6
rfx_be3a
	add r6
rfx_be3b
	iwt r0,#ztab&WM
rfx_be3e
	to r14
rfx_be3f
	add r6
rfx_be40
	to r6
rfx_be41
	getb
rfx_be42
	inc r14
rfx_be43
	with r6
rfx_be44
	getbh
rfx_be46
	with r9
rfx_be47
	fmult
rfx_be48
	with r9
rfx_be49
	rol
rfx_be4a
	lms r1,[m_vanishx]
rfx_be4d
	with r1
rfx_be4e
	add r9
rfx_be4f
	lms r0,[m_xleft]
rfx_be52
	cmp r1
rfx_be54
	bmi rfx_be5b
rfx_be56
	nop
rfx_be57
	iwt r15,#rfx_bf4d&WM
rfx_be5a
	nop
rfx_be5b
	lms r0,[m_xright]
rfx_be5e
	sub #2
rfx_be60
	cmp r1
rfx_be62
	bpl rfx_be69
rfx_be64
	nop
rfx_be65
	iwt r15,#rfx_bf4d&WM
rfx_be68
	nop
rfx_be69
	with r5
rfx_be6a
	fmult
rfx_be6b
	with r5
rfx_be6c
	rol
rfx_be6d
	lms r2,[m_vanishy]
rfx_be70
	iwt r0,#$0014
rfx_be73
	with r2
rfx_be74
	sub r0
rfx_be75
	with r2
rfx_be76
	add r5
rfx_be77
	lms r0,[m_ytop]
rfx_be7a
	cmp r2
rfx_be7c
	bmi rfx_be83
rfx_be7e
	nop
rfx_be7f
	iwt r15,#rfx_bf4d&WM
rfx_be82
	nop
rfx_be83
	nop
rfx_be84
	lms r0,[m_ybot]
rfx_be87
	sub #4
rfx_be89
	cmp r2
rfx_be8b
	bpl rfx_be92
rfx_be8d
	nop
rfx_be8e
	iwt r15,#rfx_bf53&WM
rfx_be91
	nop
rfx_be92
	nop
rfx_be93
	from r11
rfx_be94
	sub #1
rfx_be96
	beq rfx_beb2
rfx_be98
	nop
rfx_be99
	inc r8
rfx_be9a
	inc r8
rfx_be9b
	iwt r0,#$0100
rfx_be9e
	cmp r4
rfx_bea0
	bpl rfx_bea8
rfx_bea2
	nop
rfx_bea3
	plot
rfx_bea4
	iwt r15,#rfx_bf2a&WM
rfx_bea7
	nop
rfx_bea8
	plot
rfx_bea9
	plot
rfx_beaa
	inc r2
rfx_beab
	dec r1
rfx_beac
	dec r1
rfx_bead
	plot
rfx_beae
	plot
rfx_beaf
	bra rfx_bf2a
rfx_beb1
	nop
rfx_beb2
	ldw [r8]
rfx_beb3
	to r3
rfx_beb4
	lob
rfx_beb5
	to r9
rfx_beb6
	hib
rfx_beb7
	from r1
rfx_beb8
	stb [r8]
rfx_beba
	inc r8
rfx_bebb
	from r2
rfx_bebc
	stb [r8]
rfx_bebe
	inc r8
rfx_bebf
	with r0
rfx_bec0
	from r0
rfx_bec1
	beq rfx_bf2a
rfx_bec3
	nop
rfx_bec4
	from r12
rfx_bec5
	stw [r10]
rfx_bec6
	inc r10
rfx_bec7
	inc r10
rfx_bec8
	from r13
rfx_bec9
	stw [r10]
rfx_beca
	inc r10
rfx_becb
	inc r10
rfx_becc
	from r8
rfx_becd
	stw [r10]
rfx_bece
	inc r10
rfx_becf
	inc r10
rfx_bed0
	from r7
rfx_bed1
	stw [r10]
rfx_bed2
	inc r10
rfx_bed3
	inc r10
rfx_bed4
	ibt r5,#$01
rfx_bed6
	with r3
rfx_bed7
	sub r1
rfx_bed8
	bpl rfx_bee0
rfx_beda
	nop
rfx_bedb
	ibt r5,#-1
rfx_bedd
	with r3
rfx_bede
	not
rfx_bedf
	inc r3
rfx_bee0
	ibt r6,#$01
rfx_bee2
	with r9
rfx_bee3
	sub r2
rfx_bee4
	bpl rfx_beec
rfx_bee6
	nop
rfx_bee7
	ibt r6,#-1
rfx_bee9
	with r9
rfx_beea
	not
rfx_beeb
	inc r9
rfx_beec
	from r3
rfx_beed
	sub r9
rfx_beee
	bmi rfx_bf06
rfx_bef0
	nop
rfx_bef1
	with r3
rfx_bef2
	to r12
rfx_bef3
	inc r12
rfx_bef4
	lsr
rfx_bef5
	sub r9
rfx_bef6
	with r15
rfx_bef7
	to r13
rfx_bef8
	bcs rfx_befe
rfx_befa
	plot
rfx_befb
	add r3
rfx_befc
	with r2
rfx_befd
	add r6
rfx_befe
	dec r1
rfx_beff
	with r1
rfx_bf00
	add r5
rfx_bf01
	loop
rfx_bf02
	sub r9
rfx_bf03
	bra rfx_bf1a
rfx_bf05
	nop
rfx_bf06
	with r9
rfx_bf07
	to r12
rfx_bf08
	inc r12
rfx_bf09
	not
rfx_bf0a
	inc r0
rfx_bf0b
	lsr
rfx_bf0c
	sub r3
rfx_bf0d
	with r15
rfx_bf0e
	to r13
rfx_bf0f
	bcs rfx_bf15
rfx_bf11
	plot
rfx_bf12
	add r9
rfx_bf13
	with r1
rfx_bf14
	add r5
rfx_bf15
	dec r1
rfx_bf16
	with r2
rfx_bf17
	add r6
rfx_bf18
	loop
rfx_bf19
	sub r3
rfx_bf1a
	dec r10
rfx_bf1b
	dec r10
rfx_bf1c
	to r7
rfx_bf1d
	ldw [r10]
rfx_bf1e
	dec r10
rfx_bf1f
	dec r10
rfx_bf20
	to r8
rfx_bf21
	ldw [r10]
rfx_bf22
	dec r10
rfx_bf23
	dec r10
rfx_bf24
	to r13
rfx_bf25
	ldw [r10]
rfx_bf26
	dec r10
rfx_bf27
	dec r10
rfx_bf28
	to r12
rfx_bf29
	ldw [r10]
rfx_bf2a
	loop
rfx_bf2b
	nop
rfx_bf2c
	bra rfx_bf65
rfx_bf2e
	nop
rfx_bf2f
	bra rfx_bf2a
rfx_bf31
	nop
rfx_bf32
	bra rfx_bf2a
rfx_bf34
	nop
rfx_bf35
	iwt r2,#$0000
rfx_bf38
	bra rfx_bf3e
rfx_bf3a
	nop
rfx_bf3b
	iwt r2,#$01ff
rfx_bf3e
	with r8
rfx_bf3f
	to r1
rfx_bf40
	with r8
rfx_bf41
	sub #10
rfx_bf43
	with r8
rfx_bf44
	add #6
rfx_bf46
	from r2
rfx_bf47
	stw [r8]
rfx_bf48
	with r1
rfx_bf49
	to r8
rfx_bf4a
	bra rfx_bf2a
rfx_bf4c
	nop
rfx_bf4d
	sub r0
rfx_bf4e
	stw [r8]
rfx_bf4f
	inc r8
rfx_bf50
	bra rfx_bf2a
rfx_bf52
	inc r8
rfx_bf53
	with r8
rfx_bf54
	to r1
rfx_bf55
	with r8
rfx_bf56
	sub #8
rfx_bf58
	with r8
rfx_bf59
	add #0
rfx_bf5b
	ibt r0,#$01
rfx_bf5d
	stb [r8]
rfx_bf5f
	with r1
rfx_bf60
	to r8
rfx_bf61
	inc r8
rfx_bf62
	bra rfx_bf2a
rfx_bf64
	inc r8
rfx_bf65
	sms [m_particlerand],r7
rfx_bf68
	dec r10
rfx_bf69
	dec r10
rfx_bf6a
	to r15
rfx_bf6b
	ldw [r10]
rfx_bf6c
	nop
rfx_bf6d
	from r11
rfx_bf6e
	stw [r10]
rfx_bf6f
	inc r10
rfx_bf70
	inc r10
rfx_bf71
	lm r1,[m_retailviewflags]
rfx_bf75
	iwt r0,#$4000
rfx_bf78
	and r1
rfx_bf79
	beq rfx_bfb2
rfx_bf7b
	nop
rfx_bf7c
	ibt r2,#$00
rfx_bf7e
	lm r0,[rfx_speed]
rfx_bf86
	with r0
rfx_bf87
	from r0
rfx_bf88
	bmi rfx_bf9e
rfx_bf8a
	nop
rfx_bf8b
	div2
rfx_bf8d
	div2
rfx_bf8f
	div2
rfx_bf91
	with r0
rfx_bf92
	to r2
rfx_bf93
	lm r0,[m_retailimpactflash]
rfx_bf97
	cmp r2
rfx_bf99
	bpl rfx_bf9e
rfx_bf9b
	nop
rfx_bf9c
	with r0
rfx_bf9d
	to r2
rfx_bf9e
	with r0
rfx_bf9f
	from r2
rfx_bfa0
	beq rfx_bfa8
rfx_bfa2
	nop
rfx_bfa3
	link #4
rfx_bfa4
	iwt r15,#rfx_c130&WM
rfx_bfa7
	nop
rfx_bfa8
	link #4
rfx_bfa9
	iwt r15,#rfx_c060&WM
rfx_bfac
	nop
rfx_bfad
	link #4
rfx_bfae
	iwt r15,#rfx_c175&WM
rfx_bfb1
	nop
rfx_bfb2
	dec r10
rfx_bfb3
	dec r10
rfx_bfb4
	to r15
rfx_bfb5
	ldw [r10]
rfx_bfb6
	nop
rfx_bfb7
	from r11
rfx_bfb8
	stw [r10]
rfx_bfb9
	inc r10
rfx_bfba
	inc r10
rfx_bfbb
	sm [rfx_tmp],r1
rfx_bfbf
	with r1
rfx_bfc0
	sub #8
rfx_bfc2
	sm [(rfx_tmp+2)],r1
rfx_bfc6
	with r2
rfx_bfc7
	to r9
rfx_bfc8
	with r2
rfx_bfc9
	to r6
rfx_bfca
	with r6
rfx_bfcb
	sub #8
rfx_bfcd
	add r0
rfx_bfce
	to r1
rfx_bfcf
	add r0
rfx_bfd0
	ibt r0,#rfx_stamptab>>16
rfx_bfd2
	romb
rfx_bfd4
	iwt r14,#rfx_stamptab&WM
rfx_bfd7
	with r14
rfx_bfd8
	add r1
rfx_bfd9
	to r1
rfx_bfda
	getb
rfx_bfdb
	inc r14
rfx_bfdc
	with r1
rfx_bfdd
	getbh
rfx_bfdf
	inc r14
rfx_bfe0
	to r8
rfx_bfe1
	getb
rfx_bfe2
	inc r14
rfx_bfe3
	with r8
rfx_bfe4
	getbh
rfx_bfe6
	inc r14
rfx_bfe7
	with r1
rfx_bfe8
	to r14
rfx_bfe9
	iwt r7,#$0010
rfx_bfec
	iwt r11,#(rfx_stampbuf+2)&WM
rfx_bfef
	cache
rfx_bff0
	with r14
rfx_bff1
	to r1
rfx_bff2
	with r8
rfx_bff3
	to r14
rfx_bff4
	getbs
rfx_bff6
	inc r8
rfx_bff7
	to r4
rfx_bff8
	add r9
rfx_bff9
	with r1
rfx_bffa
	to r14
rfx_bffb
	lm r3,[rfx_tmp]
rfx_bfff
	lm r5,[(rfx_tmp+2)]
rfx_c003
	iwt r12,#$0010
rfx_c006
	with r15
rfx_c007
	to r13
rfx_c008
	getb
rfx_c009
	sex
rfx_c00a
	beq rfx_c01e
rfx_c00c
	inc r14
rfx_c00d
	to r1
rfx_c00e
	add r3
rfx_c00f
	with r4
rfx_c010
	to r2
rfx_c011
	rpix
rfx_c013
	stw [r11]
rfx_c014
	inc r11
rfx_c015
	inc r11
rfx_c016
	from r5
rfx_c017
	stb [r11]
rfx_c019
	inc r11
rfx_c01a
	from r6
rfx_c01b
	stb [r11]
rfx_c01d
	inc r11
rfx_c01e
	loop
rfx_c01f
	inc r5
rfx_c020
	dec r7
rfx_c021
	bne rfx_bff0
rfx_c023
	inc r6
rfx_c024
	iwt r1,#(rfx_stampbuf+2)&WM
rfx_c027
	from r11
rfx_c028
	sub r1
rfx_c029
	div2
rfx_c02b
	div2
rfx_c02d
	iwt r1,#rfx_stampbuf&WM
rfx_c030
	to r2
rfx_c031
	ldw [r1]
rfx_c032
	add r2
rfx_c033
	sbk
rfx_c034
	dec r10
rfx_c035
	dec r10
rfx_c036
	to r15
rfx_c037
	ldw [r10]
rfx_c038
	nop
rfx_c039
	iwt r3,#rfx_stampbuf&WM
rfx_c03c
	ldw [r3]
rfx_c03d
	inc r3
rfx_c03e
	inc r3
rfx_c03f
	with r12
rfx_c040
	from r0
rfx_c041
	beq rfx_c05d
rfx_c043
	nop
rfx_c044
	ibt r0,#$01
rfx_c046
	cmode
rfx_c048
	cache
rfx_c049
	with r15
rfx_c04a
	to r13
rfx_c04b
	ldw [r3]
rfx_c04c
	inc r3
rfx_c04d
	inc r3
rfx_c04e
	colour
rfx_c04f
	to r1
rfx_c050
	sub r0
rfx_c051
	with r1
rfx_c052
	to r2
rfx_c053
	to r1
rfx_c054
	ldb [r3]
rfx_c056
	inc r3
rfx_c057
	to r2
rfx_c058
	ldb [r3]
rfx_c05a
	inc r3
rfx_c05b
	loop
rfx_c05c
	plot
rfx_c05d
	with r11
rfx_c05e
	to r15
rfx_c05f
	nop
rfx_c060
	lms r0,[m_xleft]
rfx_c063
	to r8
rfx_c064
	add #8
rfx_c066
	lms r0,[m_xright]
rfx_c069
	to r7
rfx_c06a
	sub #8
rfx_c06c
	lms r0,[m_ytop]
rfx_c06f
	to r4
rfx_c070
	add #8
rfx_c072
	lms r0,[m_ybot]
rfx_c075
	to r5
rfx_c076
	sub #8
rfx_c078
	iwt r6,#$0000
rfx_c07b
	lm r0,[rfx_speed]
rfx_c083
	with r0
rfx_c084
	from r0
rfx_c085
	bmi rfx_c08d
rfx_c087
	nop
rfx_c088
	add r0
rfx_c089
	add r0
rfx_c08a
	add r0
rfx_c08b
	with r0
rfx_c08c
	to r6
rfx_c08d
	iwt r3,#rfx_splashes&WM
rfx_c090
	iwt r12,#$0010
rfx_c093
	with r15
rfx_c094
	to r13
rfx_c095
	ldb [r3]
rfx_c097
	lob
rfx_c098
	with r0
rfx_c099
	from r0
rfx_c09a
	beq rfx_c0d8
rfx_c09c
	nop
rfx_c09d
	dec r0
rfx_c09e
	stb [r3]
rfx_c0a0
	inc r3
rfx_c0a1
	to r2
rfx_c0a2
	ldb [r3]
rfx_c0a4
	inc r3
rfx_c0a5
	lms r9,[m_vanishx]
rfx_c0a8
	to r1
rfx_c0a9
	ldw [r3]
rfx_c0aa
	inc r3
rfx_c0ab
	inc r3
rfx_c0ac
	with r2
rfx_c0ad
	to r0
rfx_c0ae
	lob
rfx_c0af
	to r2
rfx_c0b0
	ldw [r3]
rfx_c0b1
	inc r3
rfx_c0b2
	inc r3
rfx_c0b3
	with r1
rfx_c0b4
	to r0
rfx_c0b5
	cmp r8
rfx_c0b7
	bmi rfx_c0cb
rfx_c0b9
	nop
rfx_c0ba
	cmp r7
rfx_c0bc
	bpl rfx_c0cb
rfx_c0be
	nop
rfx_c0bf
	with r2
rfx_c0c0
	to r0
rfx_c0c1
	cmp r4
rfx_c0c3
	bmi rfx_c0cb
rfx_c0c5
	nop
rfx_c0c6
	cmp r5
rfx_c0c8
	bmi rfx_c0d3
rfx_c0ca
	nop
rfx_c0cb
	with r3
rfx_c0cc
	sub #6
rfx_c0ce
	sub r0
rfx_c0cf
	stw [r3]
rfx_c0d0
	with r3
rfx_c0d1
	add #6
rfx_c0d3
	loop
rfx_c0d4
	nop
rfx_c0d5
	bra rfx_c0dd
rfx_c0d7
	nop
rfx_c0d8
	with r3
rfx_c0d9
	add #6
rfx_c0db
	loop
rfx_c0dc
	nop
rfx_c0dd
	with r11
rfx_c0de
	to r15
rfx_c0df
	nop
rfx_c130
	lms r4,[m_particlerand]
rfx_c133
	iwt r1,#rfx_splashes&WM
rfx_c136
	with r0
rfx_c137
	to r12
rfx_c138
	with r15
rfx_c139
	to r13
rfx_c13a
	ldb [r1]
rfx_c13c
	lob
rfx_c13d
	bne rfx_c16a
rfx_c13f
	nop
rfx_c140
	ibt r0,#$08
rfx_c142
	stb [r1]
rfx_c144
	inc r1
rfx_c145
	from r4
rfx_c146
	swap
rfx_c147
	ror
rfx_c148
	add r4
rfx_c149
	to r4
rfx_c14a
	adc r4
rfx_c14c
	and #1
rfx_c14e
	inc r0
rfx_c14f
	stb [r1]
rfx_c151
	inc r1
rfx_c152
	from r4
rfx_c153
	swap
rfx_c154
	ror
rfx_c155
	add r4
rfx_c156
	to r4
rfx_c157
	adc r4
rfx_c159
	to r2
rfx_c15a
	lob
rfx_c15b
	to r3
rfx_c15c
	hib
rfx_c15d
	from r2
rfx_c15e
	stw [r1]
rfx_c15f
	inc r1
rfx_c160
	inc r1
rfx_c161
	from r3
rfx_c162
	stw [r1]
rfx_c163
	inc r1
rfx_c164
	inc r1
rfx_c165
	loop
rfx_c166
	nop
rfx_c167
	bra rfx_c16f
rfx_c169
	nop
rfx_c16a
	with r1
rfx_c16b
	add #6
rfx_c16d
	loop
rfx_c16e
	nop
rfx_c16f
	sms [m_particlerand],r4
rfx_c172
	with r11
rfx_c173
	to r15
rfx_c174
	nop
rfx_c175
	from r11
rfx_c176
	stw [r10]
rfx_c177
	inc r10
rfx_c178
	inc r10
rfx_c179
	iwt r3,#rfx_splashes&WM
rfx_c17c
	iwt r4,#$0010
rfx_c17f
	from r4
rfx_c180
	stw [r10]
rfx_c181
	inc r10
rfx_c182
	inc r10
rfx_c183
	from r3
rfx_c184
	stw [r10]
rfx_c185
	inc r10
rfx_c186
	inc r10
rfx_c187
	ldb [r3]
rfx_c189
	lob
rfx_c18a
	with r0
rfx_c18b
	from r0
rfx_c18c
	beq rfx_c1aa
rfx_c18e
	nop
rfx_c18f
	iwt r1,#rfx_stampbuf&WM
rfx_c192
	ibt r2,#$00
rfx_c194
	from r2
rfx_c195
	stw [r1]
rfx_c196
	inc r3
rfx_c197
	inc r3
rfx_c198
	to r1
rfx_c199
	ldw [r3]
rfx_c19a
	inc r3
rfx_c19b
	inc r3
rfx_c19c
	to r2
rfx_c19d
	ldw [r3]
rfx_c19e
	inc r3
rfx_c19f
	inc r3
rfx_c1a0
	link #4
rfx_c1a1
	iwt r15,#rfx_bfb7&WM
rfx_c1a4
	nop
rfx_c1a5
	link #4
rfx_c1a6
	iwt r15,#rfx_c039&WM
rfx_c1a9
	nop
rfx_c1aa
	dec r10
rfx_c1ab
	dec r10
rfx_c1ac
	to r3
rfx_c1ad
	ldw [r10]
rfx_c1ae
	dec r10
rfx_c1af
	dec r10
rfx_c1b0
	to r4
rfx_c1b1
	ldw [r10]
rfx_c1b2
	with r3
rfx_c1b3
	add #6
rfx_c1b5
	dec r4
rfx_c1b6
	bne rfx_c17f
rfx_c1b8
	nop
rfx_c1b9
	dec r10
rfx_c1ba
	dec r10
rfx_c1bb
	to r15
rfx_c1bc
	ldw [r10]
rfx_c1bd
	nop
; Native D12F gate and F6 icon path. Other HUD bytecode stays separate.
; rfx_iconstyle is the target car's retail $96 identity (0..3).
mretail_nearcarmarker
	lm r0,[m_viewroadflags]
	and #1
	beq rfx_markerret
	nop
	lm r2,[m_nearcar]
	with r2
	from r2
	beq rfx_markerret
	nop
	lm r1,[m_playercar]
	from r2
	cmp r1
	beq rfx_markerret
	nop
	lm r1,[m_retailplayer2]
	from r2
	cmp r1
	beq rfx_markerret
	nop
	lm r0,[m_nearcardepth]
	with r0
	from r0
	bmi rfx_markerret
	nop
	lm r0,[rfx_iconstyle]
	ibt r1,#4
	cmp r1
	bcs rfx_markerret
	nop
	bra rfx_marker
	nop
rfx_markerret
	jmp r11
	nop
rfx_marker
; Style-to-palette order in D1CB: 0,3,2,1.
	with r0
	from r0
	beq rfx_palette
	nop
	not
	inc r0
	and #3
rfx_palette
	add r0
	add r0
	with r0
	to r8
	ibt r0,#rfx_icon>>16
	romb
	iwt r1,#rfx_iconpal&WM
	from r8
	to r14
	add r1
	iwt r9,#rfx_iconcols&WM
	with r9
	to r8
	ibt r12,#4
	with r15
	to r13
	getb
	stb [r8]
	inc r14
	loop
	inc r8
	lm r0,[m_nearcarside]
	div2
	lm r1,[m_vanishx]
	add r1
	bpl rfx_icon_left
	nop
	sub r0
rfx_icon_left
	ibt r4,#17
	lm r1,[m_xright]
	with r1
	sub r4
	cmp r1
	bmi rfx_icon_x
	nop
	with r1
	to r0
rfx_icon_x
	with r0
	to r4
	sub r0
	cmode
	iwt r14,#rfx_icon&WM
	ibt r2,#104
	ibt r7,#24
rfx_icon_row
	with r4
	to r1
	ibt r6,#4
rfx_icon_byte
	to r3
	getb
	inc r14
	ibt r12,#4
	with r15
	to r13
	from r3
	and #3
	add r9
	ldb [r0]
	colour
	plot
	with r3
	lsr
	with r3
	lsr
	loop
	nop
	dec r6
	bne rfx_icon_byte
	nop
	dec r7
	bne rfx_icon_row
	inc r2
	rpix
	jmp r11
	nop
mrfx_end
