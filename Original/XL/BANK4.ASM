
	include	header.inc
	include	strathdr.inc
	include	bgmacs.inc

	include	gstrats.ext
	include	pstrats.ext
	include	incbins.ext
	include	fontdata.ext
	include	bgs.ext
	include	planets.ext
	include	ramstuff.ext
	include	irq.ext
	include	bootnmi.ext
	include	mdata.ext
	include	continue.ext
	include	coltabs.ext
	include	mem.ext
	include	xlsound.ext
	include	mkmacs.inc
	include	spcmacs.inc
	include	marioi.inc
	incpublics	mrforce.ext
	incpublics	mrcoll.ext
	incpublics	mrwheel.ext
	include	mrheap.ext
	include	mrupdate.ext
	incpublics	sgdata.ext

;------------------------------------------------------------------
	bank	4
;	incfile	paths.asm
;	incfile	d2strats.asm
	incfile	xlsload.asm
	incfile	xlspc.asm
	incfile	xlspca.asm
	incfile	rcardefs.mc
	incfile	xlrace.asm
	mario	on
rsp	equr	10
	incfile	mmacs.mc
	incfile	mrforce.mc
	incfile	mrcoll.mc
	incfile	mrwheel.mc

; Return raw-runtime calls to their bank without changing r0.
mretail_heapreturn4
	iwt	r13,#5
	iwt	r12,#mrhp_farreturn5&WM
	from	r12
	ljmp	r13
	nop
mretail_runtimereturn4
	iwt	r13,#6
	iwt	r12,#mrrt_farreturn6&WM
	from	r12
	ljmp	r13
	nop
	mario	off
	bankend	4
;------------------------------------------------------------------


	include	tail.inc



