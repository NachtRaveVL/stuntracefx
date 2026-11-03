mrlsbr_begin
rrl_return29
	iwt r13,#rrl_return30>>16
	iwt r12,#rrl_return30&WM
	from r12
	ljmp r13
	nop
; The default bank-3 path remains valid for callers with their own palette.
; The two scene bindings point at the restored tables in the current bank.
rrl_depthmaterial
	from r3
	lob
	with r0
	to r4
	lms r0,[m_depthstab]
	iwt r3,#retail_depthscene0&WM
	cmp r3
	beq rrl_depthbank
	nop
	iwt r3,#retail_depthscene1&WM
	cmp r3
	bne rrl_depthread
	nop
rrl_depthbank
	ibt r0,#retail_depthscene0>>16
	romb
rrl_depthread
	lms r3,[m_depthsptr]
	from r4
	to r14
	add r3
	getb
	colour
	iwt r15,#rpk_90b6&WM
	nop
mrlsbr_end
