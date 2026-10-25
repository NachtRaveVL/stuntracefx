



rx	equr	1
ry	equr	2
rz	equr	3
rsumlo	equr	7
rsumhi	equr	0	;8


; 16 bit world rotate
;
; in:	m_x1,y1,z1
; out:	m_bigx,y,z
; dead: r0-r7


mwmatrotp16
	mcache

	lms	rx,[m_x1]
	lms	ry,[m_y1]
	lms	rz,[m_z1]


	mdotprod16mq	m_wmat11,m_wmat21,m_wmat31
	sms	[m_bigx],rsumhi
	mdotprod16mq	m_wmat12,m_wmat22,m_wmat32
	sms	[m_bigy],rsumhi
	mdotprod16mq	m_wmat13,m_wmat23,m_wmat33
	sms	[m_bigz],rsumhi

	stop
	nop


; Rotate by the transpose of the world matrix, US retail $01:82ce.
; Entry name reconstructed; inputs/results match mwmatrotp16.
; This takes rows where mwmatrotp16 takes columns.

mwmatrotp16t
	mcache

	lms	rx,[m_x1]
	lms	ry,[m_y1]
	lms	rz,[m_z1]

	mdotprod16mq	m_wmat11,m_wmat12,m_wmat13
	sms	[m_bigx],rsumhi
	mdotprod16mq	m_wmat21,m_wmat22,m_wmat23
	sms	[m_bigy],rsumhi
	mdotprod16mq	m_wmat31,m_wmat32,m_wmat33
	sms	[m_bigz],rsumhi

	stop
	nop


; Coarse planar projection, US $04:c15c-$04:c19c.
; r1/r3 = X/Z, r2 = unsigned byte yaw; ROM bank 0 already selected.
; Return r1/r2 = forward, r3 = side, at approximately quarter scale.
; Preserve the native high-word subtraction and its borrow from the
; opposite low-word subtraction. Coefficients are signed table bytes;
; both results use the signed high-word shift.
; r0/r4-r9/r14/flags scratch; r10-r13 preserved, RAM bank unchanged.
; r14 ends at sintab+yaw. No angle masking or bank selection is added.
mrotate_xz8
	mpush	r11
	miwt	r0,costab
	to	r14
	add	r2
	getb
	to	r5
	swap
	miwt	r0,sintab
	to	r14
	add	r2
	getb
	to	r9
	swap
	with	r1
	to	r6
	from	r9
	to	r8
	lmult
	with	r4
	to	r7
	with	r3
	to	r6
	from	r5
	lmult
	with	r7
	add	r4
	adc	r8
	to	r2
	asr
	with	r3
	to	r6
	from	r9
	to	r8
	lmult
	with	r4
	to	r7
	with	r1
	to	r6
	from	r5
	lmult
	with	r7
	sub	r4
	sbc	r8
	to	r3
	asr
	with	r2
	to	r1
	mpop	pc
	nop


	ifeq	1

rsumhi	equr	0
rx	equr	1
ry	equr	2
rz	equr	3

rm11	equr	13
rm12	equr	12
rm13	equr	11

rm21	equr	10
rm22	equr	9
rm23	equr	8

rm31	equr	7
rm32	equr	;6
rm33	equr	4

rinptr	equr	14
routptr	equr	;11

rcnt	equr	;12
rloop	equr	;13


mrotpnts16
	mgetwi	rcnt
	miwt	routptr,m_rotpnts

	move	r13,pc
	
	mgetwi	rx
	mgetwi	ry
	mgetwi	rz

	mdotprod16m	m_mat11,m_mat21,m_mat31
	mstwi	routptr
	mdotprod16m	m_mat12,m_mat22,m_mat32
	mstwi	routptr
	mdotprod16m	m_mat13,m_mat23,m_mat33
	mstwi	routptr

	loop
	nop	

	endc

