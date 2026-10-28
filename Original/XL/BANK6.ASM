	include	header.inc
	include	spcmacs.inc
	include	strathdr.inc
	include	pstrats.ext
	include	shmacs.inc
	include	windows.ext
	include	bgmacs.inc
	include	maps\maplist.ext
	include	marioi.inc
	include	bootnmi.ext
	include	gastrats.ext
	

	incpublics	mhofs.ext

;------------------------------------------------------------------
	bank	6
	incfile	gstrats.asm
;	incfile	gcstrats.asm
;	incfile	expstrat.asm

cacheon	=	1
     	incfile	mmacs.mc
	mario	on
	incfile	mhofs.mc		;Kristers .mc files
	mario	off


	incfile	xlspcu.asm
	bankend	6

	include	tail.inc



