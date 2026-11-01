; Near callbacks for the bank29 frontend strategies.
	incpublics mrhooks.ext
	include mrmenu.ext
mrhooks_begin
rhk_trackleft
	jsl rmc_trackleft
	rts
rhk_trackright
	jsl rmc_trackright
	rts
rhk_delayanim
	jsl rmc_delayanim
	rts
rhk_animate
	jsl rmc_animate
	rts
rhk_recordwait
	jsl rmc_recordwait
	rts
rhk_recordopen
	jsl rmc_recordopen
	rts
rhk_recordshade0
	jsl rmc_recordshade0
	rts
rhk_recordshade1
	jsl rmc_recordshade1
	rts
rhk_recordwinner
	jsl rmc_recordwinner
	rts
rhk_recordvehicle
	jsl rmc_recordvehicle
	rts
rhk_recordslide
	jsl rmc_recordslide
	rts
rhk_recordflash
	jsl rmc_recordflash
	rts
rhk_recordinput
	jsl rmc_recordinput
	rts
rhk_recordclose
	jsl rmc_recordclose
	rts
rhk_recordreopen
	jsl rmc_recordreopen
	rts
rhk_recordexit
	jsl rmc_recordexit
	rts
rhk_recordtotal
	jsl rmc_recordtotal
	rts
rhk_recordflag
	jsl rmc_recordflag
	rts
rhk_recordname
	jsl rmc_recordname
	rts
rhk_recordtime
	jsl rmc_recordtime
	rts
rhk_recordidle
	jsl rmc_recordidle
	rts
rhk_vehicletiles
	jsl rmc_vehicletiles
	rts
rhk_rank0
	jsl rmc_rank0
	rts
rhk_0be018
	jsl rmc_0be018
	rts
rhk_rank1
	jsl rmc_rank1
	rts
rhk_0be059
	jsl rmc_0be059
	rts
rhk_rank2
	jsl rmc_rank2
	rts
rhk_0be09a
	jsl rmc_0be09a
	rts
rhk_rank3
	jsl rmc_rank3
	rts
rhk_0be0db
	jsl rmc_0be0db
	rts
rhk_0be0df
	jsl rmc_0be0df
	rts
mrhooks_end
; Near callbacks for the additional frontend animation strategies.
	include mrui.ext
mruihooks_begin
rhk_audiolabels
	jsl ruc_audiolabels
	rts
rhk_0bc47b
	jsl ruc_0bc47b
	rts
rhk_logofadeout
	jsl ruc_logofadeout
	rts
rhk_logowait
	jsl ruc_logowait
	rts
rhk_logofadein
	jsl ruc_logofadein
	rts
rhk_logofinish
	jsl ruc_logofinish
	rts
rhk_option0
	jsl ruc_option0
	rts
rhk_0bcaee
	jsl ruc_0bcaee
	rts
rhk_option1
	jsl ruc_option1
	rts
rhk_0bcb01
	jsl ruc_0bcb01
	rts
rhk_0bcb06
	jsl ruc_0bcb06
	rts
rhk_option2
	jsl ruc_option2
	rts
rhk_0bcb1b
	jsl ruc_0bcb1b
	rts
rhk_option3
	jsl ruc_option3
	rts
rhk_0bcb3d
	jsl ruc_0bcb3d
	rts
rhk_0bcb42
	jsl ruc_0bcb42
	rts
rhk_0bcb74
	jsl ruc_0bcb74
	rts
rhk_logodelay
	jsl ruc_logodelay
	rts
rhk_logostart
	jsl ruc_logostart
	rts
rhk_logobounce
	jsl ruc_logobounce
	rts
rhk_logoidle
	jsl ruc_logoidle
	rts
rhk_palettedelay
	jsl ruc_palettedelay
	rts
rhk_palettecrossfade
	jsl ruc_palettecrossfade
	rts
mruihooks_end
; Frontend packed-resource stage callbacks.
	include mrtiles.ext
mrtiles_hooks_begin
rhk_loadobjects
	jsl rtc_loadobjects
	rts
rhk_loadmap
	jsl rtc_loadmap
	rts
rhk_loadmenumap
	jsl rtc_loadmenumap
	rts
rhk_loadback
	jsl rtc_loadback
	rts
rhk_loadback1
	jsl rtc_loadback1
	rts
rhk_loadback2
	jsl rtc_loadback2
	rts
rhk_loadback3
	jsl rtc_loadback3
	rts
rhk_loadcaches
	jsl rtc_loadcaches
	rts
rhk_clearfront
	jsl rtc_clearfront
	rts
rhk_clearfront1
	jsl rtc_clearfront1
	rts
rhk_clearfront2
	jsl rtc_clearfront2
	rts
rhk_clearfront3
	jsl rtc_clearfront3
	rts
rhk_loadfinished
	jsl rtc_loadfinished
	rts
mrtiles_hooks_end
; Near title/input strategy entries.
	include mrtitle.ext
mrtitle_hooks_begin
rhk_logoaway
	jsl rtt_logoaway
	rts
rhk_logodrop
	jsl rtt_logodrop
	rts
rhk_titlestart
	jsl rtt_titlestart
	rts
rhk_titlewait
	jsl rtt_titlewait
	rts
rhk_titlefade
	jsl rtt_titlefade
	rts
rhk_titleinput
	jsl rtt_titleinput
	rts
rhk_titlekeys
	jsl rtt_titlekeys
	rts
rhk_titleconfirm
	jsl rtt_titleconfirm
	rts
rhk_titleerase
	jsl rtt_titleerase
	rts
rhk_titleerased
	jsl rtt_titleerased
	rts
mrtitle_hooks_end
