; Backward GSU LZ stream writer. Native match choices and field widths
; are explicit; words are big-endian and bits are consumed least-first.
; The final word carries the refill sentinel, followed by output length.

cru_flush	macro
	db	(crubuffer>>24)&$ff,(crubuffer>>16)&$ff
	db	(crubuffer>>8)&$ff,crubuffer&$ff
crubuffer = 1
crubitsleft = 32
	endm

cru_begin	macro
crubuffer = 1
crubitsleft = 32
crubytes = 0
cruliterals = 0
	endm

cru_bits	macro
cruvalue = \2
	rept	\1
	ifeq	crubitsleft
	cru_flush
	endc
crubuffer = (crubuffer<<1)+(cruvalue&1)
cruvalue = cruvalue>>1
crubitsleft = crubitsleft-1
	endr
	endm

cru_bytes	macro
cruliterals = cruliterals+NARG
	cru_bits	8,\1
	ifgt	NARG-1
	cru_bits	8,\2
	endc
	ifgt	NARG-2
	cru_bits	8,\3
	endc
	ifgt	NARG-3
	cru_bits	8,\4
	endc
	ifgt	NARG-4
	cru_bits	8,\5
	endc
	ifgt	NARG-5
	cru_bits	8,\6
	endc
	ifgt	NARG-6
	cru_bits	8,\7
	endc
	ifgt	NARG-7
	cru_bits	8,\8
	endc
	endm

; Form: 0 = short, 1 = 7..22, 2 = ten-bit, 3 = eighteen-bit.
cru_raw	macro
	ifne	cruliterals-(\1)
	fail
	endc
cruliterals = 0
crubytes = crubytes+\1
	ifeq	\2
	cru_bits	3,\1
	elseif
	ifeq	(\2)-1
	cru_bits	4,(\1)-7
	cru_bits	1,0
	elseif
	ifeq	(\2)-3
	cru_bits	18,\1
	cru_bits	10,0
	elseif
	cru_bits	10,\1
	endc
	cru_bits	1,1
	endc
	cru_bits	3,7
	endc
	endm

; Length, distance width, distance, length extension form (when length > 4).
cru_copy	macro
	ifne	cruliterals
	fail
	endc
crubytes = crubytes+\1
	cru_bits	\2,\3
	ifeq	(\1)-3
	ifeq	(\2)-8
	cru_bits	1,1
	elseif
	cru_bits	1,0
	endc
	elseif
	ifgt	(\1)-3
	ifeq	(\2)-16
	cru_bits	1,0
	elseif
	ifeq	(\2)-8
	cru_bits	1,1
	elseif
	cru_bits	1,0
	endc
	cru_bits	1,1
	endc
	endc
	endc
	iflt	(\1)-5
	cru_bits	2,(\1)-2
	elseif
	ifeq	(\4)-3
	cru_bits	8,\1
	elseif
	ifeq	(\4)-2
	cru_bits	2,(\1)-7
	endc
	endc
	cru_bits	2,\4
	cru_bits	2,3
	endc
	endm

cru_end	macro
	ifne	cruliterals
	fail
	endc
	ifne	crubytes-(\1)
	fail
	endc
	ifeq	crubitsleft
	cru_flush
	endc
	cru_flush
	db	0,0,((\1)>>8)&$ff,(\1)&$ff
	endm
