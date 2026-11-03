; Return from the bank 1 matrix helpers to the shape setup bank.
	extern mretail_georeturn29
mretail_georeturn1
	iwt r13,#mretail_georeturn29>>16
	iwt r12,#mretail_georeturn29&WM
	from r12
	ljmp r13
	nop
