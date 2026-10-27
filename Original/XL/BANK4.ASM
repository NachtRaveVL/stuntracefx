
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

;------------------------------------------------------------------
	bank	4
;	incfile	paths.asm
;	incfile	d2strats.asm
	incfile	xlsload.asm
	incfile	xlspc.asm
	incfile	xlspca.asm
	bankend	4
;------------------------------------------------------------------


	include	tail.inc



