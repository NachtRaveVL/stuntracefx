; Retail particle generation, projection and lifetime ($01:B6D5-BC34).
; The first 20 inherited 14-byte records form the retail pool.
; Make: R0 type 1..7, R1 life, R2 nonzero owner, R3 amount 1..255.
; Show: R2 owner, positions and viewport bound by the draw-list caller.
; Make/show return through R11; update is a separate GSU task.
; The early MPART entry points and their pool allocation remain in place.
mrpart_begin
mretail_makeparticles
rpa_b6d5
	from r11
rpa_b6d6
	stw [r10]
rpa_b6d7
	inc r10
rpa_b6d8
	inc r10
rpa_b6d9
	with r0
rpa_b6da
	to r8
rpa_b6db
	with r1
rpa_b6dc
	to r6
rpa_b6dd
	with r2
rpa_b6de
	to r5
rpa_b6df
	with r3
rpa_b6e0
	to r9
rpa_b6e1
	ibt r0,#$14
rpa_b6e3
	romb
rpa_b6e5
	sub r0
rpa_b6e6
	ramb
rpa_b6e8
	iwt r3,#m_particles&WM
rpa_b6eb
	lms r2,[m_particlerand]
rpa_b6ee
	iwt r12,#$0014
rpa_b6f1
	cache
rpa_b6f2
	with r15
rpa_b6f3
	to r13
rpa_b6f4
	ldb [r3]
rpa_b6f6
	lob
rpa_b6f7
	bne rpa_b767
rpa_b6f9
	nop
rpa_b6fa
	sub r0
rpa_b6fb
	ibt r7,#$06
rpa_b6fd
	with r7
rpa_b6fe
	add r3
rpa_b6ff
	from r0
rpa_b700
	stw [r7]
rpa_b701
	ibt r7,#$08
rpa_b703
	with r7
rpa_b704
	add r3
rpa_b705
	from r0
rpa_b706
	stw [r7]
rpa_b707
	ibt r7,#$0a
rpa_b709
	with r7
rpa_b70a
	add r3
rpa_b70b
	from r0
rpa_b70c
	stw [r7]
rpa_b70d
	ibt r7,#$0c
rpa_b70f
	with r7
rpa_b710
	add r3
rpa_b711
	from r5
rpa_b712
	stw [r7]
rpa_b713
	from r6
rpa_b714
	stb [r3]
rpa_b716
	ibt r0,#$01
rpa_b718
	cmp r8
rpa_b71a
	bne rpa_b721
rpa_b71c
	nop
rpa_b71d
	iwt r15,#rpa_b99f&WM
rpa_b720
	nop
rpa_b721
	ibt r0,#$02
rpa_b723
	cmp r8
rpa_b725
	bne rpa_b72c
rpa_b727
	nop
rpa_b728
	iwt r15,#rpa_b8c3&WM
rpa_b72b
	nop
rpa_b72c
	ibt r0,#$03
rpa_b72e
	cmp r8
rpa_b730
	bne rpa_b737
rpa_b732
	nop
rpa_b733
	iwt r15,#rpa_b856&WM
rpa_b736
	nop
rpa_b737
	ibt r0,#$04
rpa_b739
	cmp r8
rpa_b73b
	bne rpa_b742
rpa_b73d
	nop
rpa_b73e
	iwt r15,#rpa_b92f&WM
rpa_b741
	nop
rpa_b742
	ibt r0,#$05
rpa_b744
	cmp r8
rpa_b746
	bne rpa_b74d
rpa_b748
	nop
rpa_b749
	iwt r15,#rpa_b99b&WM
rpa_b74c
	nop
rpa_b74d
	ibt r0,#$06
rpa_b74f
	cmp r8
rpa_b751
	bne rpa_b758
rpa_b753
	nop
rpa_b754
	iwt r15,#rpa_b774&WM
rpa_b757
	nop
rpa_b758
	ibt r0,#$07
rpa_b75a
	cmp r8
rpa_b75c
	bne rpa_b763
rpa_b75e
	nop
rpa_b75f
	iwt r15,#rpa_b9a3&WM
rpa_b762
	nop
rpa_b763
	dec r9
rpa_b764
	beq rpa_b76c
rpa_b766
	nop
rpa_b767
	with r3
rpa_b768
	add #14
rpa_b76a
	loop
rpa_b76b
	nop
rpa_b76c
	sms [m_particlerand],r2
rpa_b76f
	dec r10
rpa_b770
	dec r10
rpa_b771
	to r15
rpa_b772
	ldw [r10]
rpa_b773
	nop
rpa_b774
	from r9
rpa_b775
	and #15
rpa_b777
	from r6
rpa_b778
	add r0
rpa_b779
	sub #7
rpa_b77b
	ibt r7,#$00
rpa_b77d
	with r7
rpa_b77e
	add r3
rpa_b77f
	from r0
rpa_b780
	stb [r7]
rpa_b782
	ibt r0,#$10
rpa_b784
	ibt r7,#$01
rpa_b786
	with r7
rpa_b787
	add r3
rpa_b788
	from r0
rpa_b789
	stb [r7]
rpa_b78b
	with r9
rpa_b78c
	to r0
rpa_b78d
	dec r0
rpa_b78e
	add r0
rpa_b78f
	iwt r7,#particle_circle&WM
rpa_b792
	to r14
rpa_b793
	add r7
rpa_b794
	getbs
rpa_b796
	inc r14
rpa_b797
	div2
rpa_b799
	ibt r7,#$03
rpa_b79b
	with r7
rpa_b79c
	add r3
rpa_b79d
	from r0
rpa_b79e
	stb [r7]
rpa_b7a0
	ibt r7,#$06
rpa_b7a2
	with r7
rpa_b7a3
	add r3
rpa_b7a4
	from r0
rpa_b7a5
	stw [r7]
rpa_b7a6
	getbs
rpa_b7a8
	div2
rpa_b7aa
	ibt r7,#$04
rpa_b7ac
	with r7
rpa_b7ad
	add r3
rpa_b7ae
	from r0
rpa_b7af
	stb [r7]
rpa_b7b1
	ibt r7,#$08
rpa_b7b3
	with r7
rpa_b7b4
	add r3
rpa_b7b5
	from r0
rpa_b7b6
	stw [r7]
rpa_b7b7
	from r2
rpa_b7b8
	swap
rpa_b7b9
	ror
rpa_b7ba
	add r2
rpa_b7bb
	to r2
rpa_b7bc
	adc r2
rpa_b7be
	iwt r0,#$001f
rpa_b7c1
	and r2
rpa_b7c2
	sub #15
rpa_b7c4
	ibt r7,#$05
rpa_b7c6
	with r7
rpa_b7c7
	add r3
rpa_b7c8
	from r0
rpa_b7c9
	stb [r7]
rpa_b7cb
	ibt r7,#$0a
rpa_b7cd
	with r7
rpa_b7ce
	add r3
rpa_b7cf
	from r0
rpa_b7d0
	stw [r7]
rpa_b7d1
	ibt r4,#$04
rpa_b7d3
	ibt r0,#$01
rpa_b7d5
	and r12
rpa_b7d6
	beq rpa_b7db
rpa_b7d8
	nop
rpa_b7d9
	ibt r4,#$0e
rpa_b7db
	ibt r7,#$02
rpa_b7dd
	with r7
rpa_b7de
	add r3
rpa_b7df
	from r4
rpa_b7e0
	stb [r7]
rpa_b7e2
	iwt r15,#rpa_b763&WM
rpa_b7e5
	nop
rpa_b7e6
	from r9
rpa_b7e7
	and #15
rpa_b7e9
	from r6
rpa_b7ea
	add r0
rpa_b7eb
	sub #7
rpa_b7ed
	ibt r7,#$00
rpa_b7ef
	with r7
rpa_b7f0
	add r3
rpa_b7f1
	from r0
rpa_b7f2
	stb [r7]
rpa_b7f4
	ibt r0,#$10
rpa_b7f6
	ibt r7,#$01
rpa_b7f8
	with r7
rpa_b7f9
	add r3
rpa_b7fa
	from r0
rpa_b7fb
	stb [r7]
rpa_b7fd
	with r9
rpa_b7fe
	to r0
rpa_b7ff
	dec r0
rpa_b800
	add r0
rpa_b801
	iwt r7,#particle_circle&WM
rpa_b804
	to r14
rpa_b805
	add r7
rpa_b806
	getbs
rpa_b808
	inc r14
rpa_b809
	ibt r7,#$03
rpa_b80b
	with r7
rpa_b80c
	add r3
rpa_b80d
	from r0
rpa_b80e
	stb [r7]
rpa_b810
	ibt r7,#$06
rpa_b812
	with r7
rpa_b813
	add r3
rpa_b814
	from r0
rpa_b815
	stw [r7]
rpa_b816
	getbs
rpa_b818
	ibt r7,#$04
rpa_b81a
	with r7
rpa_b81b
	add r3
rpa_b81c
	from r0
rpa_b81d
	stb [r7]
rpa_b81f
	ibt r7,#$08
rpa_b821
	with r7
rpa_b822
	add r3
rpa_b823
	from r0
rpa_b824
	stw [r7]
rpa_b825
	from r2
rpa_b826
	swap
rpa_b827
	ror
rpa_b828
	add r2
rpa_b829
	to r2
rpa_b82a
	adc r2
rpa_b82c
	iwt r0,#$003f
rpa_b82f
	and r2
rpa_b830
	iwt r7,#$001f
rpa_b833
	sub r7
rpa_b834
	ibt r7,#$05
rpa_b836
	with r7
rpa_b837
	add r3
rpa_b838
	from r0
rpa_b839
	stb [r7]
rpa_b83b
	ibt r7,#$0a
rpa_b83d
	with r7
rpa_b83e
	add r3
rpa_b83f
	from r0
rpa_b840
	stw [r7]
rpa_b841
	ibt r4,#$04
rpa_b843
	ibt r0,#$01
rpa_b845
	and r12
rpa_b846
	beq rpa_b84b
rpa_b848
	nop
rpa_b849
	ibt r4,#$0e
rpa_b84b
	ibt r7,#$02
rpa_b84d
	with r7
rpa_b84e
	add r3
rpa_b84f
	from r4
rpa_b850
	stb [r7]
rpa_b852
	iwt r15,#rpa_b763&WM
rpa_b855
	nop
rpa_b856
	from r2
rpa_b857
	swap
rpa_b858
	ror
rpa_b859
	add r2
rpa_b85a
	to r2
rpa_b85b
	adc r2
rpa_b85d
	ibt r7,#$07
rpa_b85f
	and r7
rpa_b860
	from r6
rpa_b861
	sub r0
rpa_b862
	stb [r3]
rpa_b864
	ibt r0,#$00
rpa_b866
	ibt r7,#$01
rpa_b868
	with r7
rpa_b869
	add r3
rpa_b86a
	from r0
rpa_b86b
	stb [r7]
rpa_b86d
	ibt r4,#$00
rpa_b86f
	from r2
rpa_b870
	swap
rpa_b871
	ror
rpa_b872
	add r2
rpa_b873
	to r2
rpa_b874
	adc r2
rpa_b876
	ibt r0,#$0f
rpa_b878
	and r2
rpa_b879
	ibt r7,#$07
rpa_b87b
	sub r7
rpa_b87c
	ibt r7,#$03
rpa_b87e
	with r7
rpa_b87f
	add r3
rpa_b880
	from r0
rpa_b881
	stb [r7]
rpa_b883
	from r2
rpa_b884
	swap
rpa_b885
	ror
rpa_b886
	add r2
rpa_b887
	to r2
rpa_b888
	adc r2
rpa_b88a
	ibt r0,#$0f
rpa_b88c
	and r2
rpa_b88d
	ibt r7,#$07
rpa_b88f
	sub r7
rpa_b890
	ibt r7,#$04
rpa_b892
	with r7
rpa_b893
	add r3
rpa_b894
	from r0
rpa_b895
	stb [r7]
rpa_b897
	from r2
rpa_b898
	swap
rpa_b899
	ror
rpa_b89a
	add r2
rpa_b89b
	to r2
rpa_b89c
	adc r2
rpa_b89e
	ibt r0,#$7f
rpa_b8a0
	and r2
rpa_b8a1
	not
rpa_b8a2
	inc r0
rpa_b8a3
	ibt r7,#$05
rpa_b8a5
	with r7
rpa_b8a6
	add r3
rpa_b8a7
	from r0
rpa_b8a8
	stb [r7]
rpa_b8aa
	from r2
rpa_b8ab
	swap
rpa_b8ac
	ror
rpa_b8ad
	add r2
rpa_b8ae
	to r2
rpa_b8af
	adc r2
rpa_b8b1
	ibt r0,#$03
rpa_b8b3
	and r2
rpa_b8b4
	iwt r7,#$0083
rpa_b8b7
	add r7
rpa_b8b8
	ibt r7,#$02
rpa_b8ba
	with r7
rpa_b8bb
	add r3
rpa_b8bc
	from r0
rpa_b8bd
	stb [r7]
rpa_b8bf
	iwt r15,#rpa_b763&WM
rpa_b8c2
	nop
rpa_b8c3
	from r2
rpa_b8c4
	swap
rpa_b8c5
	ror
rpa_b8c6
	add r2
rpa_b8c7
	to r2
rpa_b8c8
	adc r2
rpa_b8ca
	ibt r7,#$07
rpa_b8cc
	and r7
rpa_b8cd
	from r6
rpa_b8ce
	sub r0
rpa_b8cf
	stb [r3]
rpa_b8d1
	ibt r0,#$02
rpa_b8d3
	ibt r7,#$01
rpa_b8d5
	with r7
rpa_b8d6
	add r3
rpa_b8d7
	from r0
rpa_b8d8
	stb [r7]
rpa_b8da
	ibt r4,#$00
rpa_b8dc
	from r2
rpa_b8dd
	swap
rpa_b8de
	ror
rpa_b8df
	add r2
rpa_b8e0
	to r2
rpa_b8e1
	adc r2
rpa_b8e3
	ibt r0,#$0f
rpa_b8e5
	and r2
rpa_b8e6
	ibt r7,#$07
rpa_b8e8
	sub r7
rpa_b8e9
	ibt r7,#$03
rpa_b8eb
	with r7
rpa_b8ec
	add r3
rpa_b8ed
	from r0
rpa_b8ee
	stb [r7]
rpa_b8f0
	from r2
rpa_b8f1
	swap
rpa_b8f2
	ror
rpa_b8f3
	add r2
rpa_b8f4
	to r2
rpa_b8f5
	adc r2
rpa_b8f7
	ibt r0,#$07
rpa_b8f9
	and r2
rpa_b8fa
	ibt r7,#$03
rpa_b8fc
	sub r7
rpa_b8fd
	ibt r7,#$04
rpa_b8ff
	with r7
rpa_b900
	add r3
rpa_b901
	from r0
rpa_b902
	stb [r7]
rpa_b904
	from r2
rpa_b905
	swap
rpa_b906
	ror
rpa_b907
	add r2
rpa_b908
	to r2
rpa_b909
	adc r2
rpa_b90b
	ibt r0,#$1f
rpa_b90d
	and r2
rpa_b90e
	not
rpa_b90f
	inc r0
rpa_b910
	ibt r7,#$05
rpa_b912
	with r7
rpa_b913
	add r3
rpa_b914
	from r0
rpa_b915
	stb [r7]
rpa_b917
	from r2
rpa_b918
	swap
rpa_b919
	ror
rpa_b91a
	add r2
rpa_b91b
	to r2
rpa_b91c
	adc r2
rpa_b91e
	ibt r0,#$03
rpa_b920
	and r2
rpa_b921
	ibt r7,#$68
rpa_b923
	add r7
rpa_b924
	ibt r7,#$02
rpa_b926
	with r7
rpa_b927
	add r3
rpa_b928
	from r0
rpa_b929
	stb [r7]
rpa_b92b
	iwt r15,#rpa_b763&WM
rpa_b92e
	nop
rpa_b92f
	from r2
rpa_b930
	swap
rpa_b931
	ror
rpa_b932
	add r2
rpa_b933
	to r2
rpa_b934
	adc r2
rpa_b936
	ibt r7,#$07
rpa_b938
	and r7
rpa_b939
	from r6
rpa_b93a
	sub r0
rpa_b93b
	stb [r3]
rpa_b93d
	ibt r0,#$04
rpa_b93f
	ibt r7,#$01
rpa_b941
	with r7
rpa_b942
	add r3
rpa_b943
	from r0
rpa_b944
	stb [r7]
rpa_b946
	ibt r4,#$00
rpa_b948
	from r2
rpa_b949
	swap
rpa_b94a
	ror
rpa_b94b
	add r2
rpa_b94c
	to r2
rpa_b94d
	adc r2
rpa_b94f
	ibt r0,#$0f
rpa_b951
	and r2
rpa_b952
	ibt r7,#$07
rpa_b954
	sub r7
rpa_b955
	ibt r7,#$03
rpa_b957
	with r7
rpa_b958
	add r3
rpa_b959
	from r0
rpa_b95a
	stb [r7]
rpa_b95c
	from r2
rpa_b95d
	swap
rpa_b95e
	ror
rpa_b95f
	add r2
rpa_b960
	to r2
rpa_b961
	adc r2
rpa_b963
	ibt r0,#$07
rpa_b965
	and r2
rpa_b966
	ibt r7,#$03
rpa_b968
	sub r7
rpa_b969
	ibt r7,#$04
rpa_b96b
	with r7
rpa_b96c
	add r3
rpa_b96d
	from r0
rpa_b96e
	stb [r7]
rpa_b970
	from r2
rpa_b971
	swap
rpa_b972
	ror
rpa_b973
	add r2
rpa_b974
	to r2
rpa_b975
	adc r2
rpa_b977
	ibt r0,#$1f
rpa_b979
	and r2
rpa_b97a
	not
rpa_b97b
	inc r0
rpa_b97c
	ibt r7,#$05
rpa_b97e
	with r7
rpa_b97f
	add r3
rpa_b980
	from r0
rpa_b981
	stb [r7]
rpa_b983
	from r2
rpa_b984
	swap
rpa_b985
	ror
rpa_b986
	add r2
rpa_b987
	to r2
rpa_b988
	adc r2
rpa_b98a
	ibt r0,#$03
rpa_b98c
	and r2
rpa_b98d
	ibt r7,#$68
rpa_b98f
	add r7
rpa_b990
	ibt r7,#$02
rpa_b992
	with r7
rpa_b993
	add r3
rpa_b994
	from r0
rpa_b995
	stb [r7]
rpa_b997
	iwt r15,#rpa_b763&WM
rpa_b99a
	nop
rpa_b99b
	iwt r15,#rpa_b763&WM
rpa_b99e
	nop
rpa_b99f
	iwt r15,#rpa_b763&WM
rpa_b9a2
	nop
rpa_b9a3
	from r9
rpa_b9a4
	and #15
rpa_b9a6
	from r6
rpa_b9a7
	add r0
rpa_b9a8
	sub #7
rpa_b9aa
	ibt r7,#$00
rpa_b9ac
	with r7
rpa_b9ad
	add r3
rpa_b9ae
	from r0
rpa_b9af
	stb [r7]
rpa_b9b1
	ibt r0,#$10
rpa_b9b3
	ibt r7,#$01
rpa_b9b5
	with r7
rpa_b9b6
	add r3
rpa_b9b7
	from r0
rpa_b9b8
	stb [r7]
rpa_b9ba
	with r9
rpa_b9bb
	to r0
rpa_b9bc
	dec r0
rpa_b9bd
	add r0
rpa_b9be
	iwt r7,#particle_circle&WM
rpa_b9c1
	to r14
rpa_b9c2
	add r7
rpa_b9c3
	getbs
rpa_b9c5
	inc r14
rpa_b9c6
	ibt r7,#$03
rpa_b9c8
	with r7
rpa_b9c9
	add r3
rpa_b9ca
	from r0
rpa_b9cb
	stb [r7]
rpa_b9cd
	ibt r7,#$06
rpa_b9cf
	with r7
rpa_b9d0
	add r3
rpa_b9d1
	from r0
rpa_b9d2
	stw [r7]
rpa_b9d3
	getbs
rpa_b9d5
	ibt r7,#$04
rpa_b9d7
	with r7
rpa_b9d8
	add r3
rpa_b9d9
	from r0
rpa_b9da
	stb [r7]
rpa_b9dc
	ibt r7,#$08
rpa_b9de
	with r7
rpa_b9df
	add r3
rpa_b9e0
	from r0
rpa_b9e1
	stw [r7]
rpa_b9e2
	from r2
rpa_b9e3
	swap
rpa_b9e4
	ror
rpa_b9e5
	add r2
rpa_b9e6
	to r2
rpa_b9e7
	adc r2
rpa_b9e9
	iwt r0,#$003f
rpa_b9ec
	and r2
rpa_b9ed
	iwt r7,#$001f
rpa_b9f0
	sub r7
rpa_b9f1
	ibt r7,#$05
rpa_b9f3
	with r7
rpa_b9f4
	add r3
rpa_b9f5
	from r0
rpa_b9f6
	stb [r7]
rpa_b9f8
	ibt r7,#$0a
rpa_b9fa
	with r7
rpa_b9fb
	add r3
rpa_b9fc
	from r0
rpa_b9fd
	stw [r7]
rpa_b9fe
	ibt r4,#$04
rpa_ba00
	ibt r0,#$01
rpa_ba02
	and r12
rpa_ba03
	beq rpa_ba08
rpa_ba05
	nop
rpa_ba06
	ibt r4,#$0e
rpa_ba08
	ibt r7,#$02
rpa_ba0a
	with r7
rpa_ba0b
	add r3
rpa_ba0c
	from r4
rpa_ba0d
	stb [r7]
rpa_ba0f
	iwt r15,#rpa_b763&WM
rpa_ba12
	nop
mretail_showparticles
rpa_ba13
	from r11
rpa_ba14
	stw [r10]
rpa_ba15
	inc r10
rpa_ba16
	inc r10
rpa_ba17
	with r2
rpa_ba18
	to r7
rpa_ba19
	ibt r0,#$14
rpa_ba1b
	romb
rpa_ba1d
	iwt r11,#(m_particles+12)&WM
rpa_ba20
	iwt r12,#$0014
rpa_ba23
	cache
rpa_ba24
	ldw [r11]
rpa_ba25
	sub r7
rpa_ba26
	beq rpa_ba35
rpa_ba28
	nop
rpa_ba29
	with r11
rpa_ba2a
	add #14
rpa_ba2c
	dec r12
rpa_ba2d
	bne rpa_ba24
rpa_ba2f
	nop
rpa_ba30
	dec r10
rpa_ba31
	dec r10
rpa_ba32
	to r15
rpa_ba33
	ldw [r10]
rpa_ba34
	nop
rpa_ba35
	with r11
rpa_ba36
	sub #12
rpa_ba38
	ibt r0,#$03
rpa_ba3a
	add r11
rpa_ba3b
	ldb [r0]
rpa_ba3d
	sex
rpa_ba3e
	ibt r1,#$06
rpa_ba40
	with r1
rpa_ba41
	add r11
rpa_ba42
	to r1
rpa_ba43
	ldw [r1]
rpa_ba44
	with r1
rpa_ba45
	to r3
rpa_ba46
	add r1
rpa_ba47
	sbk
rpa_ba48
	lms r4,[m_bigx]
rpa_ba4b
	to r1
rpa_ba4c
	add r4
rpa_ba4d
	ibt r0,#$04
rpa_ba4f
	add r11
rpa_ba50
	ldb [r0]
rpa_ba52
	sex
rpa_ba53
	ibt r2,#$08
rpa_ba55
	with r2
rpa_ba56
	add r11
rpa_ba57
	to r2
rpa_ba58
	ldw [r2]
rpa_ba59
	with r2
rpa_ba5a
	to r9
rpa_ba5b
	add r2
rpa_ba5c
	sbk
rpa_ba5d
	lms r4,[m_bigy]
rpa_ba60
	to r2
rpa_ba61
	add r4
rpa_ba62
	ibt r0,#$05
rpa_ba64
	add r11
rpa_ba65
	ldb [r0]
rpa_ba67
	sex
rpa_ba68
	ibt r6,#$0a
rpa_ba6a
	with r6
rpa_ba6b
	add r11
rpa_ba6c
	to r6
rpa_ba6d
	ldw [r6]
rpa_ba6e
	with r6
rpa_ba6f
	to r13
rpa_ba70
	add r6
rpa_ba71
	sbk
rpa_ba72
	lms r4,[m_bigz]
rpa_ba75
	to r6
rpa_ba76
	add r4
rpa_ba77
	ibt r5,#$01
rpa_ba79
	with r5
rpa_ba7a
	add r11
rpa_ba7b
	to r5
rpa_ba7c
	ldb [r5]
rpa_ba7e
	from r5
rpa_ba7f
	or #1
rpa_ba81
	ibt r4,#$01
rpa_ba83
	with r4
rpa_ba84
	add r11
rpa_ba85
	from r0
rpa_ba86
	stb [r4]
rpa_ba88
	from r5
rpa_ba89
	and #2
rpa_ba8b
	beq rpa_ba9c
rpa_ba8d
	nop
rpa_ba8e
	ibt r0,#$04
rpa_ba90
	add r11
rpa_ba91
	ldb [r0]
rpa_ba93
	add #1
rpa_ba95
	ibt r4,#$04
rpa_ba97
	with r4
rpa_ba98
	add r11
rpa_ba99
	from r0
rpa_ba9a
	stb [r4]
rpa_ba9c
	with r6
rpa_ba9d
	from r6
rpa_ba9e
	bmi rpa_bb0d
rpa_baa0
	nop
rpa_baa1
	iwt r0,#$4400
rpa_baa4
	sub r6
rpa_baa5
	bpl rpa_baab
rpa_baa7
	nop
rpa_baa8
	iwt r6,#$43ff
rpa_baab
	iwt r0,#$0100
rpa_baae
	sub r6
rpa_baaf
	bmi rpa_bab9
rpa_bab1
	nop
rpa_bab2
	beq rpa_bab9
rpa_bab4
	nop
rpa_bab5
	iwt r15,#rpa_bb0d&WM
rpa_bab8
	nop
rpa_bab9
	with r6
rpa_baba
	bic #1
rpa_babc
	iwt r15,#rpa_depth_babc&WM
	nop
rpa_bac7
	from r1
rpa_bac8
	fmult
rpa_bac9
	lms r5,[m_vanishx]
rpa_bacc
	to r1
rpa_bacd
	add r5
rpa_bace
	lms r4,[m_xright]
rpa_bad1
	from r1
rpa_bad2
	sub r4
rpa_bad3
	bcc rpa_bada
rpa_bad5
	nop
rpa_bad6
	iwt r15,#rpa_bb0d&WM
rpa_bad9
	nop
rpa_bada
	add r4
rpa_badb
	from r2
rpa_badc
	fmult
rpa_badd
	lms r5,[m_vanishy]
rpa_bae0
	to r2
rpa_bae1
	add r5
rpa_bae2
	lms r5,[m_ybot]
rpa_bae5
	from r2
rpa_bae6
	sub r5
rpa_bae7
	bcc rpa_baee
rpa_bae9
	nop
rpa_baea
	iwt r15,#rpa_bb0d&WM
rpa_baed
	nop
rpa_baee
	add r5
rpa_baef
	sub r0
rpa_baf0
	cmode
rpa_baf2
	ibt r0,#$02
rpa_baf4
	add r11
rpa_baf5
	ldb [r0]
rpa_baf7
	colour
rpa_baf8
	ibt r0,#$08
rpa_bafa
	cmode
rpa_bafc
	ibt r0,#$01
rpa_bafe
	add r11
rpa_baff
	ldb [r0]
rpa_bb01
	and #4
rpa_bb03
	bne rpa_bb14
rpa_bb05
	nop
rpa_bb06
	plot
rpa_bb07
	plot
rpa_bb08
	inc r2
rpa_bb09
	dec r1
rpa_bb0a
	dec r1
rpa_bb0b
	plot
rpa_bb0c
	plot
rpa_bb0d
	with r11
rpa_bb0e
	add #12
rpa_bb10
	iwt r15,#rpa_ba29&WM
rpa_bb13
	nop
rpa_bb14
	lms r0,[m_bigx]
rpa_bb17
	to r3
rpa_bb18
	add r3
rpa_bb19
	lms r0,[m_bigy]
rpa_bb1c
	to r9
rpa_bb1d
	add r9
rpa_bb1e
	lms r0,[m_bigz]
rpa_bb21
	to r13
rpa_bb22
	add r13
rpa_bb23
	with r13
rpa_bb24
	to r6
rpa_bb25
	iwt r0,#$4400
rpa_bb28
	sub r6
rpa_bb29
	bpl rpa_bb2f
rpa_bb2b
	nop
rpa_bb2c
	iwt r6,#$43ff
rpa_bb2f
	iwt r0,#$0100
rpa_bb32
	sub r6
rpa_bb33
	bmi rpa_bb3d
rpa_bb35
	nop
rpa_bb36
	beq rpa_bb3d
rpa_bb38
	nop
rpa_bb39
	iwt r15,#rpa_bb0d&WM
rpa_bb3c
	nop
rpa_bb3d
	with r6
rpa_bb3e
	bic #1
rpa_bb40
	iwt r15,#rpa_depth_bb40&WM
	nop
rpa_bb4b
	from r3
rpa_bb4c
	fmult
rpa_bb4d
	lms r5,[m_vanishx]
rpa_bb50
	to r3
rpa_bb51
	add r5
rpa_bb52
	lms r4,[m_xright]
rpa_bb55
	from r3
rpa_bb56
	sub r4
rpa_bb57
	bcc rpa_bb5e
rpa_bb59
	nop
rpa_bb5a
	iwt r15,#rpa_bb0d&WM
rpa_bb5d
	nop
rpa_bb5e
	add r4
rpa_bb5f
	from r9
rpa_bb60
	fmult
rpa_bb61
	lms r5,[m_vanishy]
rpa_bb64
	to r9
rpa_bb65
	add r5
rpa_bb66
	lms r5,[m_ybot]
rpa_bb69
	from r9
rpa_bb6a
	sub r5
rpa_bb6b
	bcc rpa_bb72
rpa_bb6d
	nop
rpa_bb6e
	iwt r15,#rpa_bb0d&WM
rpa_bb71
	nop
rpa_bb72
	add r5
rpa_bb73
	sms [m_cnt],r12
rpa_bb76
	ibt r5,#$01
rpa_bb78
	with r3
rpa_bb79
	sub r1
rpa_bb7a
	bpl rpa_bb82
rpa_bb7c
	nop
rpa_bb7d
	ibt r5,#-1
rpa_bb7f
	with r3
rpa_bb80
	not
rpa_bb81
	inc r3
rpa_bb82
	ibt r6,#$01
rpa_bb84
	with r9
rpa_bb85
	sub r2
rpa_bb86
	bpl rpa_bb8e
rpa_bb88
	nop
rpa_bb89
	ibt r6,#-1
rpa_bb8b
	with r9
rpa_bb8c
	not
rpa_bb8d
	inc r9
rpa_bb8e
	from r3
rpa_bb8f
	sub r9
rpa_bb90
	bmi rpa_bbac
rpa_bb92
	nop
rpa_bb93
	with r3
rpa_bb94
	to r12
rpa_bb95
	inc r12
rpa_bb96
	lsr
rpa_bb97
	sub r9
rpa_bb98
	with r15
rpa_bb99
	to r13
rpa_bb9a
	bcs rpa_bba0
rpa_bb9c
	plot
rpa_bb9d
	add r3
rpa_bb9e
	with r2
rpa_bb9f
	add r6
rpa_bba0
	dec r1
rpa_bba1
	with r1
rpa_bba2
	add r5
rpa_bba3
	loop
rpa_bba4
	sub r9
rpa_bba5
	lms r12,[m_cnt]
rpa_bba8
	iwt r15,#rpa_bb0d&WM
rpa_bbab
	nop
rpa_bbac
	with r9
rpa_bbad
	to r12
rpa_bbae
	inc r12
rpa_bbaf
	not
rpa_bbb0
	inc r0
rpa_bbb1
	lsr
rpa_bbb2
	sub r3
rpa_bbb3
	with r15
rpa_bbb4
	to r13
rpa_bbb5
	bcs rpa_bbbb
rpa_bbb7
	plot
rpa_bbb8
	add r9
rpa_bbb9
	with r1
rpa_bbba
	add r5
rpa_bbbb
	dec r1
rpa_bbbc
	with r2
rpa_bbbd
	add r6
rpa_bbbe
	loop
rpa_bbbf
	sub r3
rpa_bbc0
	lms r12,[m_cnt]
rpa_bbc3
	iwt r15,#rpa_bb0d&WM
rpa_bbc6
	nop
mretail_updateparticles
rpa_bbc7
	iwt r10,#m_stack&WM
rpa_bbca
	ibt r0,#$14
rpa_bbcc
	romb
rpa_bbce
	sub r0
rpa_bbcf
	ramb
rpa_bbd1
	iwt r8,#$000e
rpa_bbd4
	iwt r9,#m_particles&WM
rpa_bbd7
	iwt r12,#$0014
rpa_bbda
	ibt r5,#$20
rpa_bbdc
	cache
rpa_bbdd
	with r15
rpa_bbde
	to r13
rpa_bbdf
	ldb [r9]
rpa_bbe1
	lob
rpa_bbe2
	beq rpa_bc17
rpa_bbe4
	nop
rpa_bbe5
	dec r0
rpa_bbe6
	stb [r9]
rpa_bbe8
	with r0
rpa_bbe9
	to r7
rpa_bbea
	ibt r0,#$01
rpa_bbec
	add r9
rpa_bbed
	ldb [r0]
rpa_bbef
	ibt r6,#$10
rpa_bbf1
	and r6
rpa_bbf2
	beq rpa_bc09
rpa_bbf4
	nop
rpa_bbf5
	with r7
rpa_bbf6
	to r0
rpa_bbf7
	cmp r5
rpa_bbf9
	bpl rpa_bc09
rpa_bbfb
	nop
rpa_bbfc
	iwt r14,#partfadetab&WM
rpa_bbff
	with r14
rpa_bc00
	add r0
rpa_bc01
	getb
rpa_bc02
	ibt r7,#$02
rpa_bc04
	with r7
rpa_bc05
	add r9
rpa_bc06
	from r0
rpa_bc07
	stb [r7]
rpa_bc09
	ibt r0,#$01
rpa_bc0b
	add r9
rpa_bc0c
	ldb [r0]
rpa_bc0e
	with r0
rpa_bc0f
	to r6
rpa_bc10
	and #1
rpa_bc12
	bne rpa_bc24
rpa_bc14
	sub r0
rpa_bc15
	stb [r9]
rpa_bc17
	ibt r7,#$0c
rpa_bc19
	with r7
rpa_bc1a
	add r9
rpa_bc1b
	from r0
rpa_bc1c
	stw [r7]
rpa_bc1d
	with r9
rpa_bc1e
	add r8
rpa_bc1f
	loop
rpa_bc20
	nop
rpa_bc21
	bra rpa_bc33
rpa_bc23
	nop
rpa_bc24
	with r6
rpa_bc25
	to r0
rpa_bc26
	bic #1
rpa_bc28
	ibt r7,#$01
rpa_bc2a
	with r7
rpa_bc2b
	add r9
rpa_bc2c
	from r0
rpa_bc2d
	stb [r7]
rpa_bc2f
	with r9
rpa_bc30
	add r8
rpa_bc31
	loop
rpa_bc32
	nop
rpa_bc33
	stop
rpa_bc34
	nop
rpa_depth_babc
	iwt r0,#$4300
	from r6
	cmp r0
	bcc rpa_zbase_babc
	nop
	ibt r0,#retail_spriteztail>>16
	romb
	iwt r0,#(retail_spriteztail-$4300)&WM
	bra rpa_zget_babc
	nop
rpa_zbase_babc
	iwt r0,#ztab&WM
rpa_zget_babc
	to r14
	add r6
	to r6
	getb
	inc r14
	with r6
	getbh
	ibt r0,#ztab>>16
	romb
	iwt r15,#rpa_bac7&WM
	nop
rpa_depth_bb40
	iwt r0,#$4300
	from r6
	cmp r0
	bcc rpa_zbase_bb40
	nop
	ibt r0,#retail_spriteztail>>16
	romb
	iwt r0,#(retail_spriteztail-$4300)&WM
	bra rpa_zget_bb40
	nop
rpa_zbase_bb40
	iwt r0,#ztab&WM
rpa_zget_bb40
	to r14
	add r6
	to r6
	getb
	inc r14
	with r6
	getbh
	ibt r0,#ztab>>16
	romb
	iwt r15,#rpa_bb4b&WM
	nop
mrpart_end
