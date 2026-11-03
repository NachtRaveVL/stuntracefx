; Prepare the retail shape scale, matrices and light vector before decoding.
; Bank 0 RAM, R10 software stack and R11 same-bank return.
; The combined entry also runs shade setup with the scene mode in R7.
; R0-R9 and R12-R14 are scratch. ROMBR is scratch on general rotations.
mrgeom_begin
mretail_shadegeometry
	from r11
	stw [r10]
	inc r10
	inc r10
	link #4
	iwt r15,#mretail_shadesetup&WM
	nop
	bra rgeo_8651
	nop
mretail_shapegeometry
	from r11
	stw [r10]
	inc r10
	inc r10
rgeo_8651
	cache
rgeo_8652
	ibt r0,#$01
rgeo_8654
	lms r12,[m_shift]
rgeo_8657
	with r12
rgeo_8658
	from r12
rgeo_8659
	beq rgeo_8660
rgeo_865b
	nop
rgeo_865c
	with r15
rgeo_865d
	to r13
rgeo_865e
	loop
rgeo_865f
	add r0
rgeo_8660
	sms [m_scale],r0
rgeo_8663
	lms r1,[m_rotx]
rgeo_8666
	from r1
rgeo_8667
	lob
rgeo_8668
	swap
rgeo_8669
	not
rgeo_866a
	inc r0
rgeo_866b
	sbk
rgeo_866c
	lms r2,[m_roty]
rgeo_866f
	from r2
rgeo_8670
	lob
rgeo_8671
	swap
rgeo_8672
	not
rgeo_8673
	inc r0
rgeo_8674
	sbk
rgeo_8675
	lms r3,[m_rotz]
rgeo_8678
	from r3
rgeo_8679
	lob
rgeo_867a
	swap
rgeo_867b
	not
rgeo_867c
	inc r0
rgeo_867d
	sbk
rgeo_867e
	from r1
rgeo_867f
	or r3
rgeo_8680
	beq rgeo_8687
rgeo_8682
	nop
rgeo_8683
	iwt r15,#rgeo_8741&WM
rgeo_8686
	nop
rgeo_8687
	or r2
rgeo_8688
	bne rgeo_86d8
rgeo_868a
	nop
rgeo_868b
	lms r0,[m_wmat11]
rgeo_868e
	sms [m_mat11],r0
rgeo_8691
	lms r0,[m_wmat12]
rgeo_8694
	sms [m_mat12],r0
rgeo_8697
	lms r0,[m_wmat13]
rgeo_869a
	sms [m_mat13],r0
rgeo_869d
	lms r0,[m_wmat21]
rgeo_86a0
	sms [m_mat21],r0
rgeo_86a3
	lms r0,[m_wmat22]
rgeo_86a6
	sms [m_mat22],r0
rgeo_86a9
	lms r0,[m_wmat23]
rgeo_86ac
	sms [m_mat23],r0
rgeo_86af
	lms r0,[m_wmat31]
rgeo_86b2
	sms [m_mat31],r0
rgeo_86b5
	lms r0,[m_wmat32]
rgeo_86b8
	sms [m_mat32],r0
rgeo_86bb
	lms r0,[m_wmat33]
rgeo_86be
	sms [m_mat33],r0
rgeo_86c1
	lms r0,[m_objflags]
rgeo_86c4
	iwt r1,#$2000
rgeo_86c7
	and r1
rgeo_86c8
	beq rgeo_86d4
rgeo_86ca
	sub r0
rgeo_86cb
	sms [m_mat21],r0
rgeo_86ce
	sms [m_mat22],r0
rgeo_86d1
	sms [m_mat23],r0
rgeo_86d4
	iwt r15,#rgeo_8778&WM
rgeo_86d7
	nop
rgeo_86d8
	iwt r4,#$0040
rgeo_86db
	from r2
rgeo_86dc
	sub r4
rgeo_86dd
	bne rgeo_86e4
rgeo_86df
	nop
rgeo_86e0
	iwt r15,#rgeo_8741&WM
rgeo_86e3
	nop
rgeo_86e4
	sub r4
rgeo_86e5
	bne rgeo_8741
rgeo_86e7
	nop
rgeo_86e8
	lms r0,[m_wmat11]
rgeo_86eb
	not
rgeo_86ec
	inc r0
rgeo_86ed
	sms [m_mat11],r0
rgeo_86f0
	lms r0,[m_wmat12]
rgeo_86f3
	not
rgeo_86f4
	inc r0
rgeo_86f5
	sms [m_mat12],r0
rgeo_86f8
	lms r0,[m_wmat13]
rgeo_86fb
	not
rgeo_86fc
	inc r0
rgeo_86fd
	sms [m_mat13],r0
rgeo_8700
	lms r0,[m_wmat21]
rgeo_8703
	sms [m_mat21],r0
rgeo_8706
	lms r0,[m_wmat22]
rgeo_8709
	sms [m_mat22],r0
rgeo_870c
	lms r0,[m_wmat23]
rgeo_870f
	sms [m_mat23],r0
rgeo_8712
	lms r0,[m_wmat31]
rgeo_8715
	not
rgeo_8716
	inc r0
rgeo_8717
	sms [m_mat31],r0
rgeo_871a
	lms r0,[m_wmat32]
rgeo_871d
	not
rgeo_871e
	inc r0
rgeo_871f
	sms [m_mat32],r0
rgeo_8722
	lms r0,[m_wmat33]
rgeo_8725
	not
rgeo_8726
	inc r0
rgeo_8727
	sms [m_mat33],r0
rgeo_872a
	lms r0,[m_objflags]
rgeo_872d
	iwt r1,#$2000
rgeo_8730
	and r1
rgeo_8731
	beq rgeo_873d
rgeo_8733
	sub r0
rgeo_8734
	sms [m_mat21],r0
rgeo_8737
	sms [m_mat22],r0
rgeo_873a
	sms [m_mat23],r0
rgeo_873d
	iwt r15,#rgeo_8778&WM
rgeo_8740
	nop
rgeo_8741
	iwt r9,#m_rmat11&WM
rgeo_8744
	link #4
rgeo_8745
	iwt r15,#rgeo_rotate&WM
rgeo_8748
	nop
rgeo_8749
	iwt r9,#m_rmat11&WM
rgeo_874c
	link #4
rgeo_874d
	iwt r15,#rgeo_transpose&WM
rgeo_8750
	nop
rgeo_8751
	lms r0,[m_objflags]
rgeo_8754
	iwt r1,#$2000
rgeo_8757
	and r1
rgeo_8758
	beq rgeo_8770
rgeo_875a
	sub r0
rgeo_875b
	sms [m_rmat12],r0
rgeo_875e
	sms [m_rmat22],r0
rgeo_8761
	sms [m_rmat32],r0
rgeo_8764
	iwt r9,#m_mat11&WM
rgeo_8767
	link #4
rgeo_8768
	iwt r15,#rgeo_975b&WM
rgeo_876b
	nop
rgeo_876c
	iwt r15,#rgeo_8778&WM
rgeo_876f
	nop
rgeo_8770
	iwt r9,#m_mat11&WM
rgeo_8773
	link #4
rgeo_8774
	iwt r15,#rgeo_975b&WM
rgeo_8777
	nop
rgeo_8778
	iwt r0,#$0000
rgeo_877b
	sms [m_lightx],r0
rgeo_877e
	iwt r0,#$393e
rgeo_8781
	sms [m_lighty],r0
rgeo_8784
	iwt r0,#$727c
rgeo_8787
	sms [m_lightz],r0
rgeo_878a
	lms r1,[m_lightx]
rgeo_878d
	lms r2,[m_lighty]
rgeo_8790
	lms r3,[m_lightz]
rgeo_8793
	lms r6,[m_mat11]
rgeo_8796
	from r1
rgeo_8797
	fmult
rgeo_8798
	to r5
rgeo_8799
	rol
rgeo_879a
	lms r6,[m_mat12]
rgeo_879d
	from r2
rgeo_879e
	fmult
rgeo_879f
	rol
rgeo_87a0
	with r5
rgeo_87a1
	add r0
rgeo_87a2
	lms r6,[m_mat13]
rgeo_87a5
	from r3
rgeo_87a6
	fmult
rgeo_87a7
	rol
rgeo_87a8
	add r5
rgeo_87a9
	hib
rgeo_87aa
	sex
rgeo_87ab
	sms [m_rotlightx],r0
rgeo_87ae
	lms r6,[m_mat21]
rgeo_87b1
	from r1
rgeo_87b2
	fmult
rgeo_87b3
	to r5
rgeo_87b4
	rol
rgeo_87b5
	lms r6,[m_mat22]
rgeo_87b8
	from r2
rgeo_87b9
	fmult
rgeo_87ba
	rol
rgeo_87bb
	with r5
rgeo_87bc
	add r0
rgeo_87bd
	lms r6,[m_mat23]
rgeo_87c0
	from r3
rgeo_87c1
	fmult
rgeo_87c2
	rol
rgeo_87c3
	add r5
rgeo_87c4
	hib
rgeo_87c5
	sex
rgeo_87c6
	sms [m_rotlighty],r0
rgeo_87c9
	lms r6,[m_mat31]
rgeo_87cc
	from r1
rgeo_87cd
	fmult
rgeo_87ce
	to r5
rgeo_87cf
	rol
rgeo_87d0
	lms r6,[m_mat32]
rgeo_87d3
	from r2
rgeo_87d4
	fmult
rgeo_87d5
	rol
rgeo_87d6
	with r5
rgeo_87d7
	add r0
rgeo_87d8
	lms r6,[m_mat33]
rgeo_87db
	from r3
rgeo_87dc
	fmult
rgeo_87dd
	rol
rgeo_87de
	add r5
rgeo_87df
	hib
rgeo_87e0
	sex
rgeo_87e1
	sms [m_rotlightz],r0
rgeo_87e4
	lms r0,[m_shift]
rgeo_87e7
	sub #3
rgeo_87e9
	bpl rgeo_882c
rgeo_87eb
	nop
rgeo_87ec
	iwt r2,#(m_mat11+1)&WM
rgeo_87ef
	to r1
rgeo_87f0
	ldb [r2]
rgeo_87f2
	inc r2
rgeo_87f3
	inc r2
rgeo_87f4
	ldb [r2]
rgeo_87f6
	swap
rgeo_87f7
	or r1
rgeo_87f8
	sms [m_mat1211],r0
rgeo_87fb
	inc r2
rgeo_87fc
	inc r2
rgeo_87fd
	to r1
rgeo_87fe
	ldb [r2]
rgeo_8800
	inc r2
rgeo_8801
	inc r2
rgeo_8802
	ldb [r2]
rgeo_8804
	swap
rgeo_8805
	or r1
rgeo_8806
	sms [m_mat2113],r0
rgeo_8809
	inc r2
rgeo_880a
	inc r2
rgeo_880b
	to r1
rgeo_880c
	ldb [r2]
rgeo_880e
	inc r2
rgeo_880f
	inc r2
rgeo_8810
	ldb [r2]
rgeo_8812
	swap
rgeo_8813
	or r1
rgeo_8814
	sms [m_mat2322],r0
rgeo_8817
	inc r2
rgeo_8818
	inc r2
rgeo_8819
	to r1
rgeo_881a
	ldb [r2]
rgeo_881c
	inc r2
rgeo_881d
	inc r2
rgeo_881e
	ldb [r2]
rgeo_8820
	swap
rgeo_8821
	or r1
rgeo_8822
	sms [m_mat3231],r0
rgeo_8825
	inc r2
rgeo_8826
	inc r2
rgeo_8827
	ldb [r2]
rgeo_8829
	sms [m_mat0033],r0
rgeo_882c
	sub r0
rgeo_882d
	sms [m_numpnts],r0
rgeo_8830
	iwt r0,#m_rotpnts&WM
rgeo_8833
	sms [m_rotptr],r0
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
rgeo_975b
	with r11
rgeo_975c
	to r8
rgeo_975d
	lms r1,[m_rmat11]
rgeo_9760
	lms r2,[m_rmat12]
rgeo_9763
	lms r3,[m_rmat13]
rgeo_9766
	link #4
rgeo_9767
	iwt r15,#rgeo_978b&WM
rgeo_976a
	nop
rgeo_976b
	lms r1,[m_rmat21]
rgeo_976e
	lms r2,[m_rmat22]
rgeo_9771
	lms r3,[m_rmat23]
rgeo_9774
	link #4
rgeo_9775
	iwt r15,#rgeo_978b&WM
rgeo_9778
	nop
rgeo_9779
	lms r1,[m_rmat31]
rgeo_977c
	lms r2,[m_rmat32]
rgeo_977f
	lms r3,[m_rmat33]
rgeo_9782
	link #4
rgeo_9783
	iwt r15,#rgeo_978b&WM
rgeo_9786
	nop
rgeo_9787
	with r8
rgeo_9788
	to r11
rgeo_9789
	jmp r11
rgeo_978a
	nop
rgeo_978b
	cache
rgeo_978c
	lms r6,[m_wmat11]
rgeo_978f
	from r1
rgeo_9790
	fmult
rgeo_9791
	to r5
rgeo_9792
	rol
rgeo_9793
	lms r6,[m_wmat21]
rgeo_9796
	from r2
rgeo_9797
	fmult
rgeo_9798
	rol
rgeo_9799
	with r5
rgeo_979a
	add r0
rgeo_979b
	lms r6,[m_wmat31]
rgeo_979e
	from r3
rgeo_979f
	fmult
rgeo_97a0
	rol
rgeo_97a1
	add r5
rgeo_97a2
	stw [r9]
rgeo_97a3
	inc r9
rgeo_97a4
	inc r9
rgeo_97a5
	lms r6,[m_wmat12]
rgeo_97a8
	from r1
rgeo_97a9
	fmult
rgeo_97aa
	to r5
rgeo_97ab
	rol
rgeo_97ac
	lms r6,[m_wmat22]
rgeo_97af
	from r2
rgeo_97b0
	fmult
rgeo_97b1
	rol
rgeo_97b2
	with r5
rgeo_97b3
	add r0
rgeo_97b4
	lms r6,[m_wmat32]
rgeo_97b7
	from r3
rgeo_97b8
	fmult
rgeo_97b9
	rol
rgeo_97ba
	add r5
rgeo_97bb
	stw [r9]
rgeo_97bc
	inc r9
rgeo_97bd
	inc r9
rgeo_97be
	lms r6,[m_wmat13]
rgeo_97c1
	from r1
rgeo_97c2
	fmult
rgeo_97c3
	to r5
rgeo_97c4
	rol
rgeo_97c5
	lms r6,[m_wmat23]
rgeo_97c8
	from r2
rgeo_97c9
	fmult
rgeo_97ca
	rol
rgeo_97cb
	with r5
rgeo_97cc
	add r0
rgeo_97cd
	lms r6,[m_wmat33]
rgeo_97d0
	from r3
rgeo_97d1
	fmult
rgeo_97d2
	rol
rgeo_97d3
	add r5
rgeo_97d4
	stw [r9]
rgeo_97d5
	inc r9
rgeo_97d6
	inc r9
rgeo_97d7
	jmp r11
rgeo_97d8
	nop
; Call the original bank 1 rotation and transpose routines.
rgeo_rotate
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#mretail_georeturn1&WM
	iwt r13,#mcrotmatzxy16>>16
	iwt r12,#mcrotmatzxy16&WM
	from r12
	ljmp r13
	nop
rgeo_transpose
	from r11
	stw [r10]
	inc r10
	inc r10
	iwt r11,#mretail_georeturn1&WM
	iwt r13,#mtransmat16>>16
	iwt r12,#mtransmat16&WM
	from r12
	ljmp r13
	nop
mretail_georeturn29
	dec r10
	dec r10
	to r11
	ldw [r10]
	jmp r11
	nop
mrgeom_end
