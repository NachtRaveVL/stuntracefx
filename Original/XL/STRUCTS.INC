;-------------------------------------------------------------
; STRUCTS.INC
;


alcon	=	1
	fopen	alvars.txt

;List structures---------------------------------------
;(first 4 bytes are _next & _prev)
;	structure	4
;	defal	alxblock,2
;	struct	al_start,0
;	struct	al_size,0

;	alc	viewblk,al_size
;	alc	alblks,al_size*number_al


	xalc	alxblkstart,1

	structure	alxblkstart
	struct	alx_start,0
	defalx	next,2
	defalx	prev,2
	defalx	shape,2
	defalx	ptr,2		; ptr to attached alien 
	defalx	flags,1
	defalx	type,1
	defalx	count,1
	defalx	count1,1
	defalx	worldx,2		; world x,y,z
	defalx	worldy,2
	defalx	worldz,2
	defalx	mapz,1
	defalx	worldzh,1
	defalx	rotx,1		; angles x,y,z
	defalx	roty,1
	defalx	rotz,1
	defalx	vel,1

	defalx	colframe,1
	include	GILESalx.inc
	defalx	animframe,1
	defalx	snd1,1
	defalx	snd2,1
	defalx	coltab,2
	defalx	tx,1
	defalx	ty,1
	struct	alx_end,0

alx_size	=	alx_end-alx_start
alxblks	=	1
	xalc	alxblks2,alx_size*number_al
	PRINTF	"alxblkstart =$",:$alxblkstart,"%n"
	PRINTF	"alxblks2 =$",:$alxblks2,"%n"
	

	fclose

;----------------------------------


;Strategy data block
	structure	4
	struct	sb_ptr,2
	struct	sb_x,2
	struct	sb_y,2
	struct	sb_z,2
	struct	sb_size,0

;Zed Sort block
	structure	4
	struct	zb_ptr,2
	struct	zb_x,2
	struct	zb_shadx,2
	struct	zb_y,2
	struct	zb_shady,2
	struct	zb_z,2
	struct	zb_shadz,2
	struct	zb_sz,2
	struct	zb_size,0


;----- structure of drawlist format
	structure	$700000
	struct		dl_next,2
	struct		dl_sortz,2
	struct		dl_rotx,1
	struct		dl_roty,1
	struct		dl_rotz,1
	struct		dl_sflags,1
	struct		dl_shape,2
	struct		dl_shady,2
	struct		dl_shadx,2
	struct		dl_shadz,2
	struct		dl_y,2
	struct		dl_x,2
	struct		dl_z,2
	struct		dl_coltab,2
	struct		dl_expcnt,1
	struct		dl_animframe,1
	struct		dl_colframe,1
	struct		dl_depth,1
	struct		dl_tscrollx,1
	struct		dl_tscrolly,1
	struct		dl_size,0
dl_sizeof	equ		dl_size-$700000


;----- structure of allocation array of colour window
	structure	0
	struct		wm_coldata,1
	struct		wm_coldata_r,1
	struct		wm_coldata_g,1
	struct		wm_coldata_b,1
	struct		wm_ts,1
	struct		wm_cgswsel,1
	struct		wm_cgadsub,1
	struct		wm_val,1
	struct		wm_sizeof,0

wm_wbglog	equ	wm_cgadsub

maxwindows	=	0
; the windows are in priority order - highest is first
	defwindow	wipe
	defwindow	blackfade
	defwindow	whitefade
	defwindow	redfade
	defwindow	halffade
	defwindow	dyingred
	defwindow	hitflash
	defwindow	circle



	xalc	collisttemp,0

;----------------------------------
; collision list structure
	structure	collisttemp
	struct	cl_alien,2
	struct	cl_colbox,2
	struct	cl_xmax,2
	struct	cl_ymax,2
	struct	cl_zmax,2
	struct	cl_size,0

cl_sizeof	=	cl_size-collisttemp


; COLBOXES
	xalc	collist,number_al*cl_sizeof

;----------------------------------

;----------------------------------
; Retail camera fields used by the angle and offset-animation routines.
; Names reconstructed. Only recovered fields are named here; the full
; record extent is vc_sizeof.
; The record is indexed from direct page zero, in low Work RAM.

vc_flags	equ	$00
vc_target	equ	$02	; object offset, as used by al_worldx,x
vc_worldx	equ	$08
vc_worldy	equ	$0a
vc_worldz	equ	$0c
vc_rotx	equ	$0e	; 16 bit pitch
vc_roty	equ	$10	; 16 bit yaw
vc_rotz	equ	$12	; 16 bit roll
vc_orbitx	equ	$14	; pitch used to rotate the local offset
vc_orbity	equ	$16	; lagged yaw used to rotate the local offset

; Current local offset and the destination followed by the animation.
vc_offx	equ	$1a
vc_offy	equ	$1c
vc_offz	equ	$1e
vc_destx	equ	$20
vc_desty	equ	$22
vc_destz	equ	$24

vc_speedx	equ	$26	; speed-dependent offset for camera callers
vc_speedy	equ	$28
vc_speedz	equ	$2a
vc_shakex	equ	$2c
vc_shakey	equ	$2e
vc_shakez	equ	$30
vc_biasx	equ	$35	; extra orbit rotation
vc_biasy	equ	$37
vc_biasz	equ	$39
vc_sizeof	equ	$3b	; spacing of the two retail camera records

vcf_fixedpos	equ	$0002
vcf_speedoff	equ	$0004
vcf_poslag	equ	$0008	; X/Z quarter-step, Y eighth-step
vcf_heightlag	equ	$0010	; X/Z direct; asymmetric Y lag
vcf_worldoff	equ	$0100	; local offset without object rotation
vcf_nosteerlag	equ	$0200	; suppress the hard-steering override
vcf_cameramap	equ	$2000	; use camera cell for the target map reference
vcf_yawlagmask	equ	$1c00
vcf_yawlagauto	equ	$0400	; half or quarter, by velocity alignment
vcf_yawlag4	equ	$0800
vcf_yawlag12	equ	$0c00	; 5/32 then divide by two
vcf_yawlag25	equ	$1000	; 5/32 then divide by four

vcf_lookat	equ	$0001	; face the target object
vcf_pitchlag	equ	$0040	; quarter-step toward target pitch
vcf_followrot	equ	$4000	; half-step toward object angles
vcf_roll	equ	$8000	; retain roll (otherwise force zero)

alcon	=	0


