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
	include	mrheap.ext
	incpublics	mrupdate.ext
	include	mrforce.ext
	include	mrcoll.ext
	include	mrwheel.ext
	include	rcardefs.ext

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
	mario	on
rsp	equr	10
	incfile	mrupdate.mc
	mario	off
	bankend	6

	include	tail.inc



