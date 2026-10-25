;*******************************************************************
track_scale	=	5
car_scale	=	1		(track_scale*25)/100
framespersec	=	15
ametre		=	100
dynshift	=	3		
car1_collsize	=	45

;--------------------------------------------
; max speed at accel=40 and wheel_friction=256 is about 4352


;--------------------------------------------

max_groups	=	20	; maximum amount of polygon groups for face testing (including 0 for ground).

groupflag_nocol	equ	128
groupflag_anim		equ	64

whitelinecol	=	32



;*******************************************************************

totaldynmem	=	0


;*******************************************************************
; STANDARD OBJECT STRUCTURE.


OBJTYPE_road		equ	1
OBJTYPE_marker		equ	2
OBJTYPE_exppiece	equ	4
OBJTYPE_car		equ	8
OBJTYPE_wheel		equ	16


	structure	4

	struct		OBJ_NEXT,2
	struct		OBJ_PREV,2

	struct		OBJ_STRATPTR,2

	struct		OBJ_RADX,2
	struct		OBJ_RADY,2
	struct		OBJ_RADZ,2
	struct		OBJ_FRAME,2
	struct		OBJ_COLLSHAPE,2
	struct		OBJ_COLLOBJ,2
	struct		OBJ_LASTCOLLOBJ,2
	struct		OBJ_TYPE,2
	
	struct		OBJ_COLLOBJ1,2
	struct		OBJ_COLLOBJ2,2

	struct		OBJ_MAPZ,2
	struct		OBJ_WORLDX,2
	struct		OBJ_WORLDY,2 
	struct		OBJ_WORLDZ,2 
	struct		OBJ_LEN,0	

	struct		OBJ_ROTX,2
	struct		OBJ_ROTY,2
	struct		OBJ_ROTZ,2
	struct		OBJ_VELX,2
	struct		OBJ_VELY,2
	struct		OBJ_VELZ,2
	struct		OBJ1_LEN,0	

	PRINTF	"OBJ struct size = ",OBJ_LEN,"%n"


;*******************************************************************
; ADDITIONAL BLOCK STRUCTURES.


;*******************************************************************
; CARS
max_CARS	EQU	4
	
CARflag_hitflash	equ	0

CARflag_steerLeft	equ	1
CARflag_steerRight	equ	2
CARflag_steerHardLeft	equ	4
CARflag_steerHardRight	equ	8
CARflag_Accel		equ	16
CARflag_Deccel		equ	32
CARflag_Brake		equ	64
CARflag_collide		equ	128
CARflag_boost		equ	256
CARflag_jump		equ	512
CARflag_dynoff		equ	1024
CARflag_squish		equ	2048
CARflag_suck		equ	4096
CARflag_wheely		equ	8192
CARflag_computer	equ	16384
CARflag_makestop	equ	32768

	structure	OBJ1_LEN

	struct		CAR_TORQUEX,2
	struct		CAR_TORQUEY,2
	struct		CAR_TORQUEZ,2

	struct		CAR_ENGINEROTY,2
	struct		CAR_ACCEL,2

	struct		CAR_WHEELS,2	
	struct		CAR_FLAGS,2

	struct		CAR_OFFGND,2
	struct		CAR_OFFROAD,2
	struct		CAR_WHLFRICTION,2

	struct		CAR_GNDSPEED,2
	struct		CAR_WHLTURNSPEED,2
	struct		CAR_GEAR,2
	struct		CAR_REVS,2
	struct		CAR_REVSND,2

	struct		CAR_HANDOBJ,2
	struct		CAR_SKID,2
	struct		CAR_LASTSKID,2

	struct		CAR_TEST1,2

	struct		CAR_NEARMARKER,2

	struct		CAR_CENTGY,2
;	struct		CAR_CENTGZ,2

	struct		CAR_JUMP,2
	struct		CAR_SHADOWY,2
	struct		CAR_OFFROADTIME,2

	struct		CAR_ACCELY,2
	struct		CAR_SQUISHY,2
	struct		CAR_SUCK,2
	struct		CAR_SIZEANIM,2
	struct		CAR_ZIMPACT,2

	struct		CAR_OFFROADFRICTION,2
	struct		CAR_ROADFRICTION,2

	struct		CAR_DAMTIME,2
	struct		CAR_TOTALDAMAGE,2
	struct		CAR_TWISTTIME,2
	
	struct		CAR_BOOSTTIME,2

; Retail camera turn lag uses the velocity/forward-axis dot product.
; Appended here to retain all existing early-build car field offsets.
	struct		CAR_VELALIGN,2

; Last route query index (retail car $58), one-based; zero = no result.
; Keep the early CAR_NEARMARKER object pointer and all old offsets intact.
; mmake_obj clears the complete enlarged block, including this field.
	struct		CAR_ROUTEINDEX,2

; Retail car $70 packed-route control word. Keep it separate from the
; early CAR_FLAGS word; bit 1 selects reverse route traversal.
; TODO: Restore the retail producers for this and its remaining bits.
CARroutemode_reverse	equ	2
CARroutemode_query	equ	4
CARroutemode_slowspeed	equ	32
	struct		CAR_ROUTEMODE,2

; Retail car $42 prepared control word. Route AI writes this before the
; common car-control consumer applies collision and strategy adjustments.
	struct		CAR_CONTROL,2

; Retail car $7c/$7e route-AI counters. Appended to preserve every early
; structure offset. FIXME: Their original source names are not known.
	struct		CAR_AIDELAY,2
	struct		CAR_AISTUCK,2

; Retail car $74/$16 avoidance-list link and skip flags. Keep these
; separate from the early mixed object list and OBJ_TYPE field.
; FIXME: Names reconstructed; flags $0080/$0400 are identified here.
; mlink_avoidcar restores list insertion; early lifetime hooks maintain it.
; mread_carflags reads the retail definition's flags, including $0400.
; TODO: Restore its constructor caller; the early cardef format differs.
CARaiflag_skipcontact	equ	$0080
CARaiflag_skipavoid	equ	$0400
	struct		CAR_AINEXT,2
	struct		CAR_AIFLAGS,2

; Retail car $72/$88 frozen-route countdown and race rank.
; Appended to retain all early offsets; mmake_obj clears both words.
; FIXME: Names reconstructed. Slots must differ by -3..3 for the timing
; table. mrank_routecars assigns the one-based ranks.
	struct		CAR_ROUTECOUNT,2
	struct		CAR_ROUTESLOT,2

; Retail car $1c/$2c/$18 state, motion flags and contact list.
; Keep these separate from early object type/collision fields.
; FIXME: Names reconstructed. TODO: Restore flag/list producers.
CARroutestate_player	equ	$0008
CARroutestate_frozen	equ	$0010
CARroutestate_contacts	equ	$0040
CARmotion_skiproute	equ	$0040
	struct		CAR_ROUTESTATE,2
	struct		CAR_MOTIONFLAGS,2
	struct		CAR_CONTACTS,2

; Retail car $7a/$86/$84 progress used by the race-rank scan.
; Keep accepted route position separate from CAR_ROUTEINDEX, which
; nearest-point/query paths may change without advancing lap progress.
	struct		CAR_ROUTELAPS,2
	struct		CAR_ROUTESEEN,2
	struct		CAR_ROUTEDIST,2

 	
	struct		CAR_LEN,0	

	mmax_structs	CAR_LEN,max_cars


	PRINTF	"CAR struct size = ",CAR_LEN,"%n"


;*******************************************************************
; Wheel blocks

WHLflag_rear		EQU	1
WHLflag_front		EQU	2
WHLflag_test1		EQU	4
WHLflag_offroad		EQU	8	; if wheel is NOT inside shape radius.
WHLflag_power		EQU	16
WHLflag_ongnd		EQU	32	; if wheel IS on a ground polygon.
WHLflag_skid		EQU	64
WHLflag_onslope		EQU	128

; Retail wheel $46 bit $0400: retain pose and zero velocity.
; TODO: Restore the retail flag producer.
WHLflag_routehold	EQU	$0400


	structure	OBJ1_LEN

	struct		WHL_NEXT,2  
	
	struct		WHL_ROTOFFX,2	
	struct		WHL_ROTOFFY,2	
	struct		WHL_ROTOFFZ,2	

	struct		WHL_OFFSETX,2	
	struct		WHL_OFFSETY,2	
	struct		WHL_OFFSETZ,2

	struct		WHL_NOFFSETX,2
	struct		WHL_NOFFSETY,2
	struct		WHL_NOFFSETZ,2

	struct		WHL_ROTXSPEED,2

	struct		WHL_TEMP1,2
	struct		WHL_FLAGS,2

	struct		WHL_GNDFRICTION,2

	struct		WHL_SPRINGX,2
	struct		WHL_SPRINGY,2
	struct		WHL_SPRINGZ,2


	struct		WHL_MAXGRIP,2

	struct		WHL_TRACKFORCEX,2
	struct		WHL_TRACKFORCEY,2
	struct		WHL_TRACKFORCEZ,2

	struct		WHL_DAMAGE,2

; Retail wheel $18 collision-contact cache, separate from collision
; object pointers and early scratch. mmake_obj clears the enlarged block.
	struct		WHL_CONTACTS,2

	struct		WHL_LEN,0


	mmax_structs	WHL_LEN,4*max_cars


	PRINTF	"WHL struct size = ",WHL_LEN,"%n"


;*******************************************************************
; track objects


TOBJflag_hitflash	equ	1
TOBJflag_stratflag1	equ	2

	
	structure	OBJ_LEN
	struct		TOBJ_NEXT,2
	struct		TOBJ_FLAGS,2
	struct		TOBJ_LEN,0

	mmax_structs	TOBJ_LEN,30


	PRINTF	"track obj struct size = ",tobj_LEN,"%n"



;*******************************************************************
; explosion objects

	structure	OBJ1_LEN
;	struct		EXPOBJ_FLAGS,2
	struct		EXPOBJ_OBJECT,2
;	struct		EXPOBJ_COUNT,2
;	struct		EXPOBJ_SHAPE,2

	struct		EXPOBJ_LEN,0

	mmax_structs	EXPOBJ_LEN,15


	PRINTF	"explosion obj struct size = ",EXPOBJ_LEN,"%n"

;*******************************************************************
; hand job-ects (ho ho very droll)

	structure	OBJ_LEN
	struct		HANDOBJ_OBJECT,2

	struct		HANDOBJ_LEN,0

	mmax_structs	HANDOBJ_LEN,2


	PRINTF	"hand obj struct size = ",HANDOBJ_LEN,"%n"

; Retail collision-contact records. The first four bytes are the existing
; dynamics allocator's next/size header; ownership uses a separate link.
; FIXME: Names reconstructed. These are not early OBJ/CAR/WHL offsets.
CT_NEXTFREE	equ	0
CT_SIZE		equ	2
CT_VELX		equ	4
CT_VELZ		equ	6
CT_WORLDX	equ	8
CT_WORLDZ	equ	10
CT_OBJECT	equ	12
CT_NEXT		equ	14
CT_FLAGS	equ	16
CT_LEN		equ	18
CTflag_used	equ	1
CTflag_hold	equ	4


;******************************************************************************************
deftrack	MACRO
	global	\1
\1_xlen	=	\2<<track_scale
\1_zlen	=	\3<<track_scale
	IFEQ	NARG-4
\1_frames	=	\4
	ENDC
	ENDM
;******************************************************************************************



