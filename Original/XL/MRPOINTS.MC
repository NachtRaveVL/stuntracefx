; Retail point stream prefix. Start after shape geometry has initialized
; m_rotptr and m_numpnts. Uses m_pntptr, m_shapebank and m_framenum.
; Supports long and scaled byte triples, mirrored pairs, frames and jumps.
; Stream must have nonzero frame periods and point counts, fit the caller's
; rotated-point buffer and reach an unsupported command or terminator.
; Returns that opcode in R0, with R14 pointing to its first operand.
; R10/R11 restored; other registers and flags are scratch.
mrpoints_begin
mretail_pointstream
	from r11
	stw [r10]
	inc r10
	inc r10
rpt_8836
	lms r0,[m_shapebank]
rpt_8839
	romb
rpt_883b
	lms r14,[m_pntptr]
rpt_883e
	sms [m_shapeptr],r14
	getb
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_884f
	to r1
rpt_8850
	getb
rpt_8851
	inc r14
rpt_8852
	lms r0,[m_framenum]
rpt_8855
	ibt r2,#$3f
rpt_8857
	and r2
rpt_8858
	cmp r1
rpt_885a
	bmi rpt_8860
rpt_885c
	nop
rpt_885d
	bra rpt_8858
rpt_885f
	sub r1
rpt_8860
	add r0
rpt_8861
	with r14
rpt_8862
	add r0
rpt_8863
	getb
rpt_8864
	inc r14
rpt_8865
	getbh
rpt_8867
	with r14
rpt_8868
	add r0
rpt_8869
rpt_886a
	getb
rpt_886b
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_886c
	to r12
rpt_886d
	getb
rpt_886e
	inc r14
rpt_886f
	lms r0,[m_numpnts]
rpt_8872
	add r12
rpt_8873
	sbk
rpt_8874
	lms r9,[m_rotptr]
rpt_8877
	sms [m_sp],r10
rpt_887a
	lms r10,[m_mat11]
rpt_887d
	lms r11,[m_mat21]
rpt_8880
	lms r13,[m_mat31]
rpt_8883
	lms r4,[m_mat12]
rpt_8886
	lms r7,[m_mat22]
rpt_8889
	lms r8,[m_mat32]
rpt_888c
	cache
rpt_888d
	to r1
rpt_888e
	getb
rpt_888f
	inc r14
rpt_8890
	with r1
rpt_8891
	getbh
rpt_8893
	inc r14
rpt_8894
	to r2
rpt_8895
	getb
rpt_8896
	inc r14
rpt_8897
	with r2
rpt_8898
	getbh
rpt_889a
	inc r14
rpt_889b
	to r3
rpt_889c
	getb
rpt_889d
	inc r14
rpt_889e
	with r3
rpt_889f
	getbh
rpt_88a1
	inc r14
rpt_88a2
	with r10
rpt_88a3
	to r6
rpt_88a4
	from r1
rpt_88a5
	fmult
rpt_88a6
	to r5
rpt_88a7
	rol
rpt_88a8
	with r11
rpt_88a9
	to r6
rpt_88aa
	from r2
rpt_88ab
	fmult
rpt_88ac
	rol
rpt_88ad
	with r5
rpt_88ae
	add r0
rpt_88af
	with r13
rpt_88b0
	to r6
rpt_88b1
	from r3
rpt_88b2
	fmult
rpt_88b3
	rol
rpt_88b4
	add r5
rpt_88b5
	stw [r9]
rpt_88b6
	inc r9
rpt_88b7
	inc r9
rpt_88b8
	with r4
rpt_88b9
	to r6
rpt_88ba
	from r1
rpt_88bb
	fmult
rpt_88bc
	to r5
rpt_88bd
	rol
rpt_88be
	with r7
rpt_88bf
	to r6
rpt_88c0
	from r2
rpt_88c1
	fmult
rpt_88c2
	rol
rpt_88c3
	with r5
rpt_88c4
	add r0
rpt_88c5
	with r8
rpt_88c6
	to r6
rpt_88c7
	from r3
rpt_88c8
	fmult
rpt_88c9
	rol
rpt_88ca
	add r5
rpt_88cb
	stw [r9]
rpt_88cc
	inc r9
rpt_88cd
	inc r9
rpt_88ce
	lms r6,[m_mat13]
rpt_88d1
	from r1
rpt_88d2
	fmult
rpt_88d3
	to r5
rpt_88d4
	rol
rpt_88d5
	lms r6,[m_mat23]
rpt_88d8
	from r2
rpt_88d9
	fmult
rpt_88da
	rol
rpt_88db
	with r5
rpt_88dc
	add r0
rpt_88dd
	lms r6,[m_mat33]
rpt_88e0
	from r3
rpt_88e1
	fmult
rpt_88e2
	rol
rpt_88e3
	add r5
rpt_88e4
	stw [r9]
rpt_88e5
	inc r9
rpt_88e6
	dec r12
rpt_88e7
	bne rpt_888d
rpt_88e9
	inc r9
rpt_88ea
	sms [m_rotptr],r9
rpt_88ed
	lms r10,[m_sp]
rpt_88f0
rpt_88f1
	getb
rpt_88f2
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_88f3
	to r12
rpt_88f4
	getb
rpt_88f5
	inc r14
rpt_88f6
	lms r0,[m_numpnts]
rpt_88f9
	add r12
rpt_88fa
	add r12
rpt_88fb
	sbk
rpt_88fc
	lms r9,[m_rotptr]
rpt_88ff
	cache
rpt_8900
	with r15
rpt_8901
	to r13
rpt_8902
	to r1
rpt_8903
	getb
rpt_8904
	inc r14
rpt_8905
	with r1
rpt_8906
	getbh
rpt_8908
	inc r14
rpt_8909
	to r2
rpt_890a
	getb
rpt_890b
	inc r14
rpt_890c
	with r2
rpt_890d
	getbh
rpt_890f
	inc r14
rpt_8910
	to r3
rpt_8911
	getb
rpt_8912
	inc r14
rpt_8913
	with r3
rpt_8914
	getbh
rpt_8916
	inc r14
rpt_8917
	lms r6,[m_mat11]
rpt_891a
	from r1
rpt_891b
	fmult
rpt_891c
	to r8
rpt_891d
	rol
rpt_891e
	lms r6,[m_mat21]
rpt_8921
	from r2
rpt_8922
	fmult
rpt_8923
	to r5
rpt_8924
	rol
rpt_8925
	lms r6,[m_mat31]
rpt_8928
	from r3
rpt_8929
	fmult
rpt_892a
	rol
rpt_892b
	add r5
rpt_892c
	add r8
rpt_892d
	stw [r9]
rpt_892e
	sub r8
rpt_892f
	sub r8
rpt_8930
	with r9
rpt_8931
	add #6
rpt_8933
	stw [r9]
rpt_8934
	with r9
rpt_8935
	sub #4
rpt_8937
	lms r6,[m_mat12]
rpt_893a
	from r1
rpt_893b
	fmult
rpt_893c
	to r8
rpt_893d
	rol
rpt_893e
	lms r6,[m_mat22]
rpt_8941
	from r2
rpt_8942
	fmult
rpt_8943
	to r5
rpt_8944
	rol
rpt_8945
	lms r6,[m_mat32]
rpt_8948
	from r3
rpt_8949
	fmult
rpt_894a
	rol
rpt_894b
	add r5
rpt_894c
	add r8
rpt_894d
	stw [r9]
rpt_894e
	sub r8
rpt_894f
	sub r8
rpt_8950
	with r9
rpt_8951
	add #6
rpt_8953
	stw [r9]
rpt_8954
	with r9
rpt_8955
	sub #4
rpt_8957
	lms r6,[m_mat13]
rpt_895a
	from r1
rpt_895b
	fmult
rpt_895c
	to r8
rpt_895d
	rol
rpt_895e
	lms r6,[m_mat23]
rpt_8961
	from r2
rpt_8962
	fmult
rpt_8963
	to r5
rpt_8964
	rol
rpt_8965
	lms r6,[m_mat33]
rpt_8968
	from r3
rpt_8969
	fmult
rpt_896a
	rol
rpt_896b
	add r5
rpt_896c
	add r8
rpt_896d
	stw [r9]
rpt_896e
	sub r8
rpt_896f
	sub r8
rpt_8970
	with r9
rpt_8971
	add #6
rpt_8973
	stw [r9]
rpt_8974
	with r9
rpt_8975
	sub #4
rpt_8977
	with r9
rpt_8978
	add #6
rpt_897a
	loop
rpt_897b
	nop
rpt_897c
	sms [m_rotptr],r9
rpt_897f
rpt_8980
	getb
rpt_8981
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_8982
	lms r9,[m_rotptr]
rpt_8985
	sms [m_sp],r10
rpt_8988
	lms r11,[m_mat21]
rpt_898b
	lms r13,[m_mat31]
rpt_898e
	lms r4,[m_mat12]
rpt_8991
	lms r7,[m_mat22]
rpt_8994
	lms r8,[m_mat32]
rpt_8997
	lms r10,[m_mat13]
rpt_899a
	to r12
rpt_899b
	getb
rpt_899c
	inc r14
rpt_899d
	lms r0,[m_numpnts]
rpt_89a0
	add r12
rpt_89a1
	sbk
rpt_89a2
	cache
rpt_89a3
	getb
rpt_89a4
	inc r14
rpt_89a5
	lms r5,[m_scale]
rpt_89a8
	to r1
rpt_89a9
	mult r5
rpt_89aa
	getb
rpt_89ab
	inc r14
rpt_89ac
	lms r6,[m_mat11]
rpt_89af
	to r2
rpt_89b0
	mult r5
rpt_89b1
	getb
rpt_89b2
	inc r14
rpt_89b3
	to r3
rpt_89b4
	mult r5
rpt_89b5
	from r1
rpt_89b6
	fmult
rpt_89b7
	to r5
rpt_89b8
	rol
rpt_89b9
	with r11
rpt_89ba
	to r6
rpt_89bb
	from r2
rpt_89bc
	fmult
rpt_89bd
	rol
rpt_89be
	with r5
rpt_89bf
	add r0
rpt_89c0
	with r13
rpt_89c1
	to r6
rpt_89c2
	from r3
rpt_89c3
	fmult
rpt_89c4
	rol
rpt_89c5
	add r5
rpt_89c6
	stw [r9]
rpt_89c7
	inc r9
rpt_89c8
	inc r9
rpt_89c9
	with r4
rpt_89ca
	to r6
rpt_89cb
	from r1
rpt_89cc
	fmult
rpt_89cd
	to r5
rpt_89ce
	rol
rpt_89cf
	with r7
rpt_89d0
	to r6
rpt_89d1
	from r2
rpt_89d2
	fmult
rpt_89d3
	rol
rpt_89d4
	with r5
rpt_89d5
	add r0
rpt_89d6
	with r8
rpt_89d7
	to r6
rpt_89d8
	from r3
rpt_89d9
	fmult
rpt_89da
	rol
rpt_89db
	add r5
rpt_89dc
	stw [r9]
rpt_89dd
	inc r9
rpt_89de
	inc r9
rpt_89df
	with r10
rpt_89e0
	to r6
rpt_89e1
	from r1
rpt_89e2
	fmult
rpt_89e3
	to r5
rpt_89e4
	rol
rpt_89e5
	lms r6,[m_mat23]
rpt_89e8
	from r2
rpt_89e9
	fmult
rpt_89ea
	rol
rpt_89eb
	with r5
rpt_89ec
	add r0
rpt_89ed
	lms r6,[m_mat33]
rpt_89f0
	from r3
rpt_89f1
	fmult
rpt_89f2
	rol
rpt_89f3
	add r5
rpt_89f4
	stw [r9]
rpt_89f5
	inc r9
rpt_89f6
	dec r12
rpt_89f7
	bne rpt_89a3
rpt_89f9
	inc r9
rpt_89fa
	lms r10,[m_sp]
rpt_89fd
	sms [m_rotptr],r9
rpt_8a00
rpt_8a01
	getb
rpt_8a02
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_8a03
	lms r9,[m_rotptr]
rpt_8a06
	sms [m_sp],r10
rpt_8a09
	lms r11,[m_mat21]
rpt_8a0c
	lms r13,[m_mat31]
rpt_8a0f
	lms r4,[m_mat12]
rpt_8a12
	lms r7,[m_mat22]
rpt_8a15
	lms r10,[m_mat13]
rpt_8a18
	to r12
rpt_8a19
	getb
rpt_8a1a
	inc r14
rpt_8a1b
	lms r0,[m_numpnts]
rpt_8a1e
	add r12
rpt_8a1f
	add r12
rpt_8a20
	sbk
rpt_8a21
	cache
rpt_8a22
	getb
rpt_8a23
	inc r14
rpt_8a24
	lms r5,[m_scale]
rpt_8a27
	to r1
rpt_8a28
	mult r5
rpt_8a29
	getb
rpt_8a2a
	inc r14
rpt_8a2b
	lms r6,[m_mat11]
rpt_8a2e
	to r2
rpt_8a2f
	mult r5
rpt_8a30
	getb
rpt_8a31
	inc r14
rpt_8a32
	to r3
rpt_8a33
	mult r5
rpt_8a34
	from r1
rpt_8a35
	fmult
rpt_8a36
	to r8
rpt_8a37
	rol
rpt_8a38
	with r11
rpt_8a39
	to r6
rpt_8a3a
	from r2
rpt_8a3b
	fmult
rpt_8a3c
	to r5
rpt_8a3d
	rol
rpt_8a3e
	with r13
rpt_8a3f
	to r6
rpt_8a40
	from r3
rpt_8a41
	fmult
rpt_8a42
	rol
rpt_8a43
	add r5
rpt_8a44
	add r8
rpt_8a45
	stw [r9]
rpt_8a46
	sub r8
rpt_8a47
	sub r8
rpt_8a48
	with r9
rpt_8a49
	add #6
rpt_8a4b
	stw [r9]
rpt_8a4c
	with r9
rpt_8a4d
	sub #4
rpt_8a4f
	with r4
rpt_8a50
	to r6
rpt_8a51
	from r1
rpt_8a52
	fmult
rpt_8a53
	to r8
rpt_8a54
	rol
rpt_8a55
	with r7
rpt_8a56
	to r6
rpt_8a57
	from r2
rpt_8a58
	fmult
rpt_8a59
	to r5
rpt_8a5a
	rol
rpt_8a5b
	lms r6,[m_mat32]
rpt_8a5e
	from r3
rpt_8a5f
	fmult
rpt_8a60
	rol
rpt_8a61
	add r5
rpt_8a62
	add r8
rpt_8a63
	stw [r9]
rpt_8a64
	sub r8
rpt_8a65
	sub r8
rpt_8a66
	with r9
rpt_8a67
	add #6
rpt_8a69
	stw [r9]
rpt_8a6a
	with r9
rpt_8a6b
	sub #4
rpt_8a6d
	with r10
rpt_8a6e
	to r6
rpt_8a6f
	from r1
rpt_8a70
	fmult
rpt_8a71
	to r8
rpt_8a72
	rol
rpt_8a73
	lms r6,[m_mat23]
rpt_8a76
	from r2
rpt_8a77
	fmult
rpt_8a78
	to r5
rpt_8a79
	rol
rpt_8a7a
	lms r6,[m_mat33]
rpt_8a7d
	from r3
rpt_8a7e
	fmult
rpt_8a7f
	rol
rpt_8a80
	add r5
rpt_8a81
	add r8
rpt_8a82
	stw [r9]
rpt_8a83
	sub r8
rpt_8a84
	sub r8
rpt_8a85
	with r9
rpt_8a86
	add #6
rpt_8a88
	stw [r9]
rpt_8a89
	inc r9
rpt_8a8a
	dec r12
rpt_8a8b
	bne rpt_8a22
rpt_8a8d
	inc r9
rpt_8a8e
	lms r10,[m_sp]
rpt_8a91
	sms [m_rotptr],r9
rpt_8a94
rpt_8a95
	getb
rpt_8a96
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_8a97
	lms r0,[m_shift]
rpt_8a9a
	sub #3
rpt_8a9c
	bmi rpt_8aa3
rpt_8a9e
	nop
rpt_8a9f
	iwt r15,#rpt_8982&WM
rpt_8aa2
	nop
rpt_8aa3
	nop
rpt_8aa4
	lms r11,[m_rotptr]
rpt_8aa7
	lms r5,[m_mat1211]
rpt_8aaa
	lms r6,[m_mat2113]
rpt_8aad
	lms r7,[m_mat2322]
rpt_8ab0
	lms r8,[m_mat3231]
rpt_8ab3
	lms r9,[m_mat0033]
rpt_8ab6
	lms r1,[m_scale]
rpt_8ab9
	from r9
rpt_8aba
	lob
rpt_8abb
	swap
rpt_8abc
	to r9
rpt_8abd
	or r1
rpt_8abe
	to r12
rpt_8abf
	getb
rpt_8ac0
	inc r14
rpt_8ac1
	lms r0,[m_numpnts]
rpt_8ac4
	add r12
rpt_8ac5
	sbk
rpt_8ac6
	cache
rpt_8ac7
	with r15
rpt_8ac8
	to r13
rpt_8ac9
	to r1
rpt_8aca
	getb
rpt_8acb
	inc r14
rpt_8acc
	from r5
rpt_8acd
	to r4
rpt_8ace
	mult r1
rpt_8acf
	to r2
rpt_8ad0
	getb
rpt_8ad1
	inc r14
rpt_8ad2
	from r6
rpt_8ad3
	hib
rpt_8ad4
	mult r2
rpt_8ad5
	to r4
rpt_8ad6
	add r4
rpt_8ad7
	to r3
rpt_8ad8
	getb
rpt_8ad9
	inc r14
rpt_8ada
	from r8
rpt_8adb
	mult r3
rpt_8adc
	add r4
rpt_8add
	add r0
rpt_8ade
	hib
rpt_8adf
	mult r9
rpt_8ae0
	stw [r11]
rpt_8ae1
	inc r11
rpt_8ae2
	inc r11
rpt_8ae3
	from r5
rpt_8ae4
	hib
rpt_8ae5
	to r4
rpt_8ae6
	mult r1
rpt_8ae7
	from r7
rpt_8ae8
	mult r2
rpt_8ae9
	to r4
rpt_8aea
	add r4
rpt_8aeb
	from r8
rpt_8aec
	hib
rpt_8aed
	mult r3
rpt_8aee
	add r4
rpt_8aef
	add r0
rpt_8af0
	hib
rpt_8af1
	mult r9
rpt_8af2
	stw [r11]
rpt_8af3
	inc r11
rpt_8af4
	inc r11
rpt_8af5
	from r6
rpt_8af6
	to r4
rpt_8af7
	mult r1
rpt_8af8
	from r7
rpt_8af9
	hib
rpt_8afa
	mult r2
rpt_8afb
	to r4
rpt_8afc
	add r4
rpt_8afd
	from r9
rpt_8afe
	hib
rpt_8aff
	mult r3
rpt_8b00
	add r4
rpt_8b01
	add r0
rpt_8b02
	hib
rpt_8b03
	mult r9
rpt_8b04
	stw [r11]
rpt_8b05
	inc r11
rpt_8b06
	loop
rpt_8b07
	inc r11
rpt_8b08
	sms [m_rotptr],r11
rpt_8b0b
rpt_8b0c
	getb
rpt_8b0d
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_8b0e
	lms r0,[m_shift]
rpt_8b11
	sub #3
rpt_8b13
	bmi rpt_8b1a
rpt_8b15
	nop
rpt_8b16
	iwt r15,#rpt_8a03&WM
rpt_8b19
	nop
rpt_8b1a
	nop
rpt_8b1b
	lms r11,[m_rotptr]
rpt_8b1e
	lms r5,[m_mat1211]
rpt_8b21
	lms r6,[m_mat2113]
rpt_8b24
	lms r7,[m_mat2322]
rpt_8b27
	lms r8,[m_mat3231]
rpt_8b2a
	lms r9,[m_mat0033]
rpt_8b2d
	lms r1,[m_scale]
rpt_8b30
	from r9
rpt_8b31
	lob
rpt_8b32
	swap
rpt_8b33
	to r9
rpt_8b34
	or r1
rpt_8b35
	to r12
rpt_8b36
	getb
rpt_8b37
	inc r14
rpt_8b38
	lms r0,[m_numpnts]
rpt_8b3b
	add r12
rpt_8b3c
	add r12
rpt_8b3d
	sbk
rpt_8b3e
	cache
rpt_8b3f
	to r1
rpt_8b40
	getb
rpt_8b41
	inc r14
rpt_8b42
	from r5
rpt_8b43
	to r13
rpt_8b44
	mult r1
rpt_8b45
	to r2
rpt_8b46
	getb
rpt_8b47
	inc r14
rpt_8b48
	from r6
rpt_8b49
	hib
rpt_8b4a
	to r4
rpt_8b4b
	mult r2
rpt_8b4c
	to r3
rpt_8b4d
	getb
rpt_8b4e
	inc r14
rpt_8b4f
	from r8
rpt_8b50
	mult r3
rpt_8b51
	to r4
rpt_8b52
	add r4
rpt_8b53
	from r4
rpt_8b54
	add r13
rpt_8b55
	add r0
rpt_8b56
	hib
rpt_8b57
	mult r9
rpt_8b58
	stw [r11]
rpt_8b59
	with r11
rpt_8b5a
	add #6
rpt_8b5c
	from r4
rpt_8b5d
	sub r13
rpt_8b5e
	add r0
rpt_8b5f
	hib
rpt_8b60
	mult r9
rpt_8b61
	stw [r11]
rpt_8b62
	with r11
rpt_8b63
	sub #4
rpt_8b65
	from r5
rpt_8b66
	hib
rpt_8b67
	to r13
rpt_8b68
	mult r1
rpt_8b69
	from r7
rpt_8b6a
	to r4
rpt_8b6b
	mult r2
rpt_8b6c
	from r8
rpt_8b6d
	hib
rpt_8b6e
	mult r3
rpt_8b6f
	to r4
rpt_8b70
	add r4
rpt_8b71
	from r4
rpt_8b72
	add r13
rpt_8b73
	add r0
rpt_8b74
	hib
rpt_8b75
	mult r9
rpt_8b76
	stw [r11]
rpt_8b77
	with r11
rpt_8b78
	add #6
rpt_8b7a
	from r4
rpt_8b7b
	sub r13
rpt_8b7c
	add r0
rpt_8b7d
	hib
rpt_8b7e
	mult r9
rpt_8b7f
	stw [r11]
rpt_8b80
	with r11
rpt_8b81
	sub #4
rpt_8b83
	from r6
rpt_8b84
	to r13
rpt_8b85
	mult r1
rpt_8b86
	from r7
rpt_8b87
	hib
rpt_8b88
	to r4
rpt_8b89
	mult r2
rpt_8b8a
	from r9
rpt_8b8b
	hib
rpt_8b8c
	mult r3
rpt_8b8d
	to r4
rpt_8b8e
	add r4
rpt_8b8f
	from r4
rpt_8b90
	add r13
rpt_8b91
	add r0
rpt_8b92
	hib
rpt_8b93
	mult r9
rpt_8b94
	stw [r11]
rpt_8b95
	with r11
rpt_8b96
	add #6
rpt_8b98
	from r4
rpt_8b99
	sub r13
rpt_8b9a
	add r0
rpt_8b9b
	hib
rpt_8b9c
	mult r9
rpt_8b9d
	stw [r11]
rpt_8b9e
	inc r11
rpt_8b9f
	inc r11
rpt_8ba0
	dec r12
rpt_8ba1
	bne rpt_8b3f
rpt_8ba3
	nop
rpt_8ba4
	sms [m_rotptr],r11
rpt_8ba7
rpt_8ba8
	getb
rpt_8ba9
	inc r14
	iwt r15,#rpt_dispatch&WM
	nop
rpt_dispatch
	ibt r1,#$08
	cmp r1
	bne rpt_try0
	nop
	iwt r15,#rpt_886c&WM
	nop
rpt_try0
	ibt r1,#$4c
	cmp r1
	bne rpt_try1
	nop
	iwt r15,#rpt_886c&WM
	nop
rpt_try1
	ibt r1,#$34
	cmp r1
	bne rpt_try2
	nop
	iwt r15,#rpt_88f3&WM
	nop
rpt_try2
	ibt r1,#$1c
	cmp r1
	bne rpt_try3
	nop
	iwt r15,#rpt_884f&WM
	nop
rpt_try3
	ibt r1,#$20
	cmp r1
	bne rpt_try4
	nop
	iwt r15,#rpt_8863&WM
	nop
rpt_try4
	ibt r1,#$04
	cmp r1
	bne rpt_try5
	nop
	iwt r15,#rpt_8a97&WM
	nop
rpt_try5
	ibt r1,#$38
	cmp r1
	bne rpt_try6
	nop
	iwt r15,#rpt_8b0e&WM
	nop
rpt_try6
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
mrpoints_end
