	include	header.inc
	include	spcmacs.inc
	include	strathdr.inc
	include	gstrats.ext
	include	windows.ext
	include	bootnmi.ext
	include	gastrats.ext

	bank	11
	incfile	pstrats.asm
;	incfile	pistrats.asm
;	incfile	pcstrats.asm
;	incfile	gb2strats.asm
	incfile	xlspcp.mc
	bankend	11

	include	tail.inc


