; Initial SPC instruments, effect scripts, bundled music and sample directory.
; Script addresses and shared continuations are native SPC RAM addresses.
; BRR sample bodies and scene-specific replacement streams remain external.


	spc_block	spc_instrumentblock,$0590,$0078

; Twenty six-byte definitions: SRCN, ADSR1/2, GAIN, big-endian pitch scale.
spc_instruments
	spc_instrumentdef	$00,$ff,$ec,$b8,$13f0
	spc_instrumentdef	$01,$ff,$e2,$b8,$09f0
	spc_instrumentdef	$02,$8f,$e0,$b8,$0300
	spc_instrumentdef	$03,$8f,$eb,$b8,$0300
	spc_instrumentdef	$04,$ff,$e0,$b8,$07f0
	spc_instrumentdef	$05,$ff,$f1,$b8,$0760
	spc_instrumentdef	$06,$ff,$ec,$b8,$02a0
	spc_instrumentdef	$07,$8f,$f2,$b8,$01a0
	spc_instrumentdef	$08,$8f,$f2,$b8,$01a0
	spc_instrumentdef	$09,$ff,$e0,$b8,$01a0
	spc_instrumentdef	$0a,$8f,$e0,$b8,$07e0
	spc_instrumentdef	$0b,$8f,$e0,$b8,$05b0
	spc_instrumentdef	$0c,$ff,$f4,$b8,$07c0
	spc_instrumentdef	$0d,$ff,$f2,$b8,$05f0
	spc_instrumentdef	$0e,$ff,$ee,$b8,$0350
	spc_instrumentdef	$0f,$ff,$e0,$b8,$02e0
	spc_instrumentdef	$10,$ff,$e0,$b8,$0110
	spc_instrumentdef	$11,$ff,$e0,$b8,$11f0
	spc_instrumentdef	$12,$ff,$e0,$b8,$0580
	spc_instrumentdef	$13,$8f,$f2,$b8,$0300
	spc_endblock	$0078

	spc_block	spc_directoryblock,$3f00,$0050

; Twenty initial DSP directory entries: start and loop addresses.
spc_sampledirectory
	spc_sampledef	$4000,$41a7
	spc_sampledef	$425b,$4a56
	spc_sampledef	$4add,$4b0a
	spc_sampledef	$4b25,$4b7f
	spc_sampledef	$4b9a,$4fb7
	spc_sampledef	$4fff,$5344
	spc_sampledef	$565c,$623e
	spc_sampledef	$6286,$665b
	spc_sampledef	$6286,$665b
	spc_sampledef	$6286,$665b
	spc_sampledef	$665b,$7234
	spc_sampledef	$7234,$750d
	spc_sampledef	$750d,$7b8e
	spc_sampledef	$7bd6,$7fab
	spc_sampledef	$858a,$85a5
	spc_sampledef	$8c92,$9109
	spc_sampledef	$92cb,$92e6
	spc_sampledef	$9fa0,$9fe8
	spc_sampledef	$a08a,$a67b
	spc_sampledef	$ffff,$ffff
	spc_endblock	$0050

	spc_block	spc_scriptblock,$bca0,$0e64

; Effect headers retain channel/priority bits; EC spawns another header,
; F3 jumps to a headerless continuation. Waits/notes retain encoded values.
spc_effect_bca0
	spc_fxheader	$04
	spc_fxsample	$04
	spc_fxkeyoff
	spc_fxwait	$05
	spc_fxmono	$06
	spc_fxechoon
	spc_fxpitchramp	$9c,$ff
	spc_fxnote	$d1
	spc_fxsustainrate	$0d
	spc_fxwait	$2d
	spc_fxend
spc_effect_bcb0
	spc_fxheader	$04
	spc_fxspawn	spc_effect_bcc9
	spc_fxsample	$0f
	spc_fxmono	$32
	spc_fxattack	$0d
	spc_fxpitchramp	$bc,$02
	spc_fxnote	$80
	spc_fxwait	$0a
	spc_fxsample	$0d
	spc_fxsustainrate	$10
	spc_fxpitchramp	$fe,$ff
	spc_fxnote	$b0
	spc_fxwait	$3a
	spc_fxend
spc_effect_bcc9
	spc_fxheader	$03
	spc_fxvolume	$00,$50
	spc_fxsample	$23
	spc_fxnoise	$96
	spc_fxsustainrate	$14
	spc_fxvolumeramp	$4c,$04,$a8,$fd
	spc_fxpitchramp	$38,$ff
	spc_fxnote	$c3
	spc_fxwait	$0a
	spc_fxsustainrate	$10
	spc_fxvolumerampoff
	spc_fxpitchramp	$fe,$ff
	spc_fxsample	$0a
	spc_fxnote	$b7
	spc_fxwait	$30
	spc_fxend
spc_effect_bce8
	spc_fxheader	$04
	spc_fxspawn	spc_effect_bd05
	spc_fxvolume	$23,$00
spc_effect_bcef
	spc_fxdecay	$03
	spc_fxsustainlevel	$00
	spc_fxechoon
	spc_fxsample	$03
	spc_fxsustainrate	$14
	spc_fxnote	$c2
	spc_fxwait	$04
	spc_fxnote	$c4
	spc_fxwait	$04
	spc_fxnote	$c6
	spc_fxwait	$05
	spc_fxdecay	$01
	spc_fxsustainrate	$10
	spc_fxnote	$c7
	spc_fxwait	$1e
	spc_fxend
spc_effect_bd05
	spc_fxheader	$03
	spc_fxdetune	$0a
	spc_fxsample	$03
	spc_fxkeyoff
	spc_fxwait	$07
	spc_fxvolume	$00,$25
	spc_fxattack	$0e
	spc_fxjump	spc_effect_bcef
spc_effect_bd14
	spc_fxheader	$06
	spc_fxmono	$12
	spc_fxsample	$23
	spc_fxnoise	$c2
	spc_fxattack	$08
	spc_fxpitchramp	$f1,$ff
	spc_fxnote	$c0
	spc_fxwait	$3c
	spc_fxtie
	spc_fxpitchramp	$fa,$ff
	spc_fxwait	$3c
	spc_fxtie
	spc_fxsustainrate	$10
	spc_fxwait	$1e
	spc_fxend
spc_effect_bd2c
	spc_fxheader	$04
	spc_fxmono	$1e
	spc_fxsample	$03
	spc_fxnote	$c8
	spc_fxpitchramp	$64,$00
	spc_fxnote	$c8
	spc_fxwait	$0e
	spc_fxnote	$c8
	spc_fxwait	$0e
	spc_fxnote	$c8
	spc_fxwait	$0e
	spc_fxnote	$c8
	spc_fxwait	$0e
	spc_fxend
spc_effect_bd3e
	spc_fxheader	$06
	spc_fxmono	$32
	spc_fxsample	$0a
	spc_fxvolumeramp	$fa,$00,$fa,$00
	spc_fxnote	$9e
	spc_fxwait	$02
	spc_fxwait	$05
	spc_fxnote	$9b
	spc_fxwait	$04
	spc_fxwait	$02
	spc_fxnote	$9d
	spc_fxwait	$06
	spc_fxwait	$0a
	spc_fxnote	$9b
	spc_fxwait	$05
	spc_fxwait	$02
	spc_fxnote	$9e
	spc_fxwait	$04
	spc_fxwait	$03
	spc_fxnote	$9b
	spc_fxwait	$06
	spc_fxwait	$0a
	spc_fxnote	$9d
	spc_fxwait	$08
	spc_fxwait	$03
	spc_fxnote	$9b
	spc_fxwait	$06
	spc_fxwait	$02
	spc_fxnote	$9e
	spc_fxwait	$06
	spc_fxwait	$0a
	spc_fxnote	$9b
	spc_fxwait	$04
	spc_fxwait	$02
	spc_fxnote	$9d
	spc_fxwait	$04
	spc_fxwait	$03
	spc_fxnote	$a0
	spc_fxwait	$06
	spc_fxwait	$0a
	spc_fxvolumerampoff
	spc_fxmono	$64
	spc_fxnote	$a8
	spc_fxwait	$05
	spc_fxwait	$32
	spc_fxend
spc_effect_bd73
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$4b,$14
spc_effect_bd79
	spc_fxsample	$0f
	spc_fxattack	$0c
	spc_fxnote	$a4
	spc_fxwait	$04
	spc_fxnote	$9f
	spc_fxwait	$05
	spc_fxattack	$0f
	spc_fxpitchramp	$6a,$ff
	spc_fxtimeout	$1e
spc_effect_bd88
	spc_fxsample	$0d
	spc_fxnote	$aa
	spc_fxwait	$03
	spc_fxtie
	spc_fxsample	$0f
	spc_fxnote	$a4
	spc_fxwait	$05
	spc_fxtie
	spc_fxsample	$0d
	spc_fxnote	$a9
	spc_fxwait	$02
	spc_fxtie
	spc_fxsample	$0f
	spc_fxnote	$a5
	spc_fxwait	$04
	spc_fxtie
	spc_fxsample	$0d
	spc_fxnote	$a7
	spc_fxwait	$02
	spc_fxtie
	spc_fxsample	$0f
	spc_fxnote	$aa
	spc_fxwait	$05
	spc_fxtie
	spc_fxjump	spc_effect_bd88
spc_effect_bda9
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$14,$4b
	spc_fxjump	spc_effect_bd79
spc_effect_bdb2
	spc_fxheader	$06
	spc_fxsample	$12
	spc_fxattack	$0a
	spc_fxpitchramp	$3c,$00
	spc_fxnote	$ab
	spc_fxwait	$06
	spc_fxtie
	spc_fxmono	$28
	spc_fxwait	$19
	spc_fxend
spc_effect_bdc1
	spc_fxheader	$06
	spc_fxechoon
	spc_fxsample	$0e
	spc_fxkeyoff
	spc_fxwait	$14
	spc_fxvolume	$5a,$00
	spc_fxpitchramp	$0a,$00
	spc_fxnote	$aa
	spc_fxwait	$03
	spc_fxnote	$ab
	spc_fxwait	$07
	spc_fxnote	$ab
	spc_fxwait	$09
	spc_fxpitchramp	$fd,$ff
	spc_fxwait	$1d
	spc_fxpitchramp	$fd,$ff
	spc_fxsustainrate	$15
	spc_fxnote	$a9
	spc_fxwait	$12
	spc_fxend
spc_effect_bddf
	spc_fxheader	$06
	spc_fxmono	$11
	spc_fxsample	$04
	spc_fxattack	$01
	spc_fxnote	$cc
	spc_fxwait	$02
	spc_fxtie
	spc_fxpitchramp	$ec,$ff
	spc_fxnote	$cc
	spc_fxwait	$6a
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$3c
	spc_fxattack	$0f
	spc_fxpitchrampoff
	spc_fxsample	$0f
	spc_fxnote	$a4
	spc_fxwait	$05
	spc_fxnote	$9f
	spc_fxwait	$08
	spc_fxsample	$0a
	spc_fxnote	$a4
	spc_fxwait	$5a
	spc_fxend
spc_effect_be00
	spc_fxheader	$06
	spc_fxvolume	$00,$64
	spc_fxsample	$24
	spc_fxpitchramp	$0a,$00
	spc_fxnote	$b4
	spc_fxwait	$13
	spc_fxnote	$b9
	spc_fxwait	$0a
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxvolume	$00,$14
	spc_fxwait	$0a
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxpitchramp	$e2,$ff
	spc_fxvolume	$00,$5a
	spc_fxnote	$b5
	spc_fxwait	$14
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxsustainrate	$10
	spc_fxwait	$28
	spc_fxend
spc_effect_be23
	spc_fxheader	$03
	spc_fxmode	$01
	spc_fxspawn	spc_effect_be41
	spc_fxsample	$03
	spc_fxechoon
	spc_fxdetune	$14
	spc_fxattack	$0e
	spc_fxsustainrate	$1a
	spc_fxvolume	$0a,$28
	spc_fxnote	$c5
	spc_fxwait	$06
	spc_fxnote	$cc
	spc_fxwait	$05
	spc_fxsustainrate	$13
	spc_fxvolume	$06,$1e
	spc_fxnote	$d1
	spc_fxwait	$3c
	spc_fxend
spc_effect_be41
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxsample	$03
	spc_fxechoon
	spc_fxattack	$0e
	spc_fxsustainrate	$1a
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxvolume	$28,$0a
	spc_fxnote	$c9
	spc_fxwait	$06
	spc_fxsustainrate	$13
	spc_fxvolume	$1e,$06
	spc_fxnote	$d1
	spc_fxwait	$3c
	spc_fxend
spc_effect_be5a
	spc_fxheader	$05
	spc_fxmode	$01
	spc_fxmono	$32
	spc_fxsample	$02
	spc_fxnote	$a3
	spc_fxwait	$05
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxwait	$1c
	spc_fxend
spc_effect_be67
	spc_fxheader	$05
	spc_fxmode	$01
	spc_fxmono	$37
	spc_fxattack	$05
	spc_fxsample	$10
	spc_fxnote	$b9
	spc_fxwait	$32
	spc_fxtie
	spc_fxnote	$ba
	spc_fxwait	$28
	spc_fxtie
	spc_fxsustainrate	$12
	spc_fxnote	$b9
	spc_fxwait	$1e
	spc_fxtie
	spc_fxnote	$b8
	spc_fxwait	$1e
	spc_fxend
spc_effect_be7e
	spc_fxheader	$04
	spc_fxmono	$41
	spc_fxsample	$0e
	spc_fxattack	$0a
	spc_fxpitchramp	$1e,$00
	spc_fxnote	$90
	spc_fxwait	$12
	spc_fxnote	$90
	spc_fxwait	$11
	spc_fxend
spc_effect_be8d
	spc_fxheader	$04
	spc_fxmono	$28
	spc_fxsample	$12
	spc_fxattack	$0a
	spc_fxpitchramp	$3c,$00
	spc_fxnote	$ab
	spc_fxwait	$13
	spc_fxnote	$ab
	spc_fxwait	$16
	spc_fxend
spc_effect_be9c
	spc_fxheader	$a7
	spc_fxmode	$01
	spc_fxsample	$1c
spc_effect_bea1
	spc_fxmono	$2a
	spc_fxnote	$cb
	spc_fxspawn	spc_effect_bebd
	spc_fxsustainrate	$0a
	spc_fxpitchramp	$20,$03
	spc_fxwait	$0c
	spc_fxtie
	spc_fxpitchramp	$e2,$ff
	spc_fxwait	$7e
	spc_fxtie
	spc_fxwait	$3c
	spc_fxend
spc_effect_beb5
	spc_fxheader	$a7
	spc_fxmode	$01
	spc_fxsample	$20
	spc_fxjump	spc_effect_bea1
spc_effect_bebd
	spc_fxheader	$a6
	spc_fxmode	$01
	spc_fxmono	$23
	spc_fxsample	$0d
	spc_fxattack	$08
	spc_fxnote	$80
	spc_fxsustainrate	$0c
	spc_fxpitchramp	$b4,$00
	spc_fxwait	$0a
	spc_fxtie
	spc_fxpitchramp	$f0,$ff
	spc_fxwait	$7e
	spc_fxend
spc_effect_bed3
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxspawn	spc_effect_bf11
	spc_fxdetune	$0a
	spc_fxvolume	$3f,$0f
	spc_fxsample	$03
spc_effect_bee0
	spc_fxechoon
	spc_fxdecay	$05
	spc_fxsustainlevel	$02
	spc_fxsustainrate	$15
	spc_fxpitchramp	$0a,$00
	spc_fxnote	$c3
	spc_fxwait	$04
	spc_fxnote	$ca
	spc_fxwait	$04
	spc_fxnote	$d1
	spc_fxwait	$04
	spc_fxnote	$d3
	spc_fxwait	$06
	spc_fxnote	$cf
	spc_fxwait	$07
	spc_fxnote	$ca
	spc_fxwait	$08
	spc_fxsustainrate	$11
	spc_fxnote	$cf
	spc_fxwait	$08
	spc_fxvolumeramp	$78,$ec,$78,$ec
	spc_fxwait	$02
	spc_fxvolumerampoff
	spc_fxnote	$d1
	spc_fxwait	$04
	spc_fxnote	$d3
	spc_fxwait	$06
	spc_fxnote	$cf
	spc_fxwait	$07
	spc_fxnote	$ca
	spc_fxwait	$08
	spc_fxsustainrate	$14
	spc_fxpitchramp	$03,$00
	spc_fxnote	$cf
	spc_fxwait	$0c
	spc_fxend
spc_effect_bf11
	spc_fxheader	$03
	spc_fxmode	$01
	spc_fxsample	$03
	spc_fxkeyoff
	spc_fxwait	$0a
	spc_fxechoon
	spc_fxvolume	$0f,$3f
	spc_fxattack	$0e
	spc_fxjump	spc_effect_bee0
spc_effect_bf21
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxspawn	spc_effect_bf42
	spc_fxvolume	$2b,$14
	spc_fxnote	$ab
	spc_fxtimeout	$41
spc_effect_bf2d
	spc_fxsample	$02
	spc_fxattack	$09
	spc_fxvolumeramp	$2e,$ff,$2e,$ff
spc_effect_bf36
	spc_fxpitchramp	$e4,$fd
	spc_fxwait	$02
	spc_fxtie
	spc_fxpitchramp	$f4,$01
	spc_fxwait	$04
	spc_fxjump	spc_effect_bf36
spc_effect_bf42
	spc_fxheader	$03
	spc_fxmode	$01
	spc_fxtimeout	$3c
	spc_fxvolume	$14,$2b
	spc_fxsample	$12
	spc_fxpitchramp	$4b,$00
	spc_fxnote	$84
	spc_fxwait	$0a
	spc_fxnote	$af
	spc_fxjump	spc_effect_bf2d
spc_effect_bf55
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxsample	$03
	spc_fxattack	$07
	spc_fxnote	$ae
	spc_fxpitchramp	$fa,$00
	spc_fxmono	$5a
	spc_fxwait	$0a
	spc_fxnote	$ab
	spc_fxmono	$4b
	spc_fxwait	$0a
	spc_fxnote	$ab
	spc_fxmono	$28
	spc_fxwait	$0a
	spc_fxnote	$ab
	spc_fxmono	$19
	spc_fxwait	$0a
	spc_fxnote	$ab
	spc_fxmono	$0f
	spc_fxwait	$0a
	spc_fxend
spc_effect_bf74
	spc_fxheader	$04
	spc_fxmono	$64
	spc_fxsample	$0a
	spc_fxnote	$ab
	spc_fxwait	$01
	spc_fxwait	$01
	spc_fxnote	$a8
	spc_fxwait	$01
	spc_fxwait	$03
	spc_fxpitchramp	$ff,$ff
	spc_fxnote	$9a
	spc_fxwait	$7e
	spc_fxend
spc_effect_bf85
	spc_fxheader	$01
	spc_fxmode	$01
	spc_fxmono	$19
	spc_fxsample	$03
	spc_fxattack	$0d
	spc_fxnote	$c3
	spc_fxwait	$14
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$07
	spc_fxattack	$0f
	spc_fxsustainrate	$0f
	spc_fxwait	$14
	spc_fxend
spc_effect_bf9a
	spc_fxheader	$00
	spc_fxmode	$01
	spc_fxmono	$19
	spc_fxsample	$03
	spc_fxattack	$0d
	spc_fxnote	$cf
	spc_fxwait	$3c
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$07
	spc_fxattack	$0f
	spc_fxsustainrate	$0f
	spc_fxwait	$28
	spc_fxend
spc_effect_bfaf
	spc_fxheader	$05
	spc_fxechoon
	spc_fxsample	$24
	spc_fxmono	$2b
	spc_fxnote	$c7
	spc_fxpitchramp	$90,$01
	spc_fxwait	$04
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxwait	$1b
	spc_fxtie
	spc_fxend
spc_effect_bfbf
	spc_fxheader	$85
	spc_fxmode	$02
	spc_fxmono	$0a
	spc_fxsample	$0e
spc_effect_bfc6
	spc_fxnote	$b4
	spc_fxwait	$02
	spc_fxtie
	spc_fxnote	$b6
	spc_fxwait	$02
	spc_fxtie
	spc_fxnote	$b3
	spc_fxwait	$02
	spc_fxtie
	spc_fxjump	spc_effect_bfc6
spc_effect_bfd2
	spc_fxheader	$a5
	spc_fxmode	$02
	spc_fxmono	$1e
	spc_fxsustainrate	$08
	spc_fxpitchramp	$fe,$ff
	spc_fxsample	$0e
	spc_fxnote	$b8
	spc_fxwait	$7e
	spc_fxend
spc_effect_bfe1
	spc_fxheader	$85
	spc_fxmode	$03
	spc_fxechoon
	spc_fxmono	$55
	spc_fxsustainrate	$19
	spc_fxsample	$0f
	spc_fxnote	$80
	spc_fxwait	$32
	spc_fxend
spc_effect_bfee
	spc_fxheader	$05
	spc_fxmode	$02
	spc_fxmono	$7f
	spc_fxsample	$24
	spc_fxsustainrate	$0f
	spc_fxnote	$b2
	spc_fxwait	$1e
	spc_fxend
spc_effect_bffa
	spc_fxheader	$85
	spc_fxmode	$02
	spc_fxmono	$50
	spc_fxattack	$0d
	spc_fxsample	$0d
	spc_fxechoon
spc_effect_c004
	spc_fxnote	$a4
	spc_fxwait	$04
	spc_fxtie
	spc_fxechooff
	spc_fxnote	$a7
	spc_fxwait	$03
	spc_fxtie
	spc_fxechoon
	spc_fxnote	$a9
	spc_fxwait	$02
	spc_fxtie
	spc_fxechooff
	spc_fxattack	$08
	spc_fxpitchramp	$18,$fc
	spc_fxnote	$a6
	spc_fxwait	$1e
	spc_fxjump	spc_effect_c004
spc_effect_c01a
	spc_fxheader	$a7
	spc_fxspawn	spc_effect_c03b
	spc_fxspawn	spc_effect_c061
	spc_fxmono	$40
	spc_fxsample	$0d
	spc_fxattack	$04
	spc_fxsustainrate	$0c
	spc_fxpitchramp	$fd,$ff
	spc_fxnote	$b0
	spc_fxwait	$78
	spc_fxtie
	spc_fxpitchramp	$01,$00
	spc_fxwait	$7e
	spc_fxtie
	spc_fxwait	$7e
	spc_fxpitchrampoff
	spc_fxattack	$0f
	spc_fxsustainrate	$00
	spc_fxend
spc_effect_c03b
	spc_fxheader	$a6
	spc_fxechoon
	spc_fxsustainrate	$10
	spc_fxsample	$0f
	spc_fxmono	$48
	spc_fxnote	$bc
	spc_fxwait	$03
	spc_fxmono	$30
	spc_fxnote	$b5
	spc_fxwait	$07
	spc_fxnote	$b4
	spc_fxwait	$78
	spc_fxsample	$0d
	spc_fxpitchramp	$05,$00
	spc_fxmono	$23
	spc_fxattack	$0d
	spc_fxsustainrate	$0b
	spc_fxnote	$8b
	spc_fxwait	$1e
	spc_fxtie
	spc_fxpitchramp	$fe,$ff
	spc_fxwait	$32
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxwait	$4b
	spc_fxend
spc_effect_c061
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxsustainrate	$0b
	spc_fxsample	$0a
	spc_fxmono	$40
	spc_fxnote	$b7
	spc_fxwait	$02
	spc_fxwait	$02
	spc_fxnote	$bb
	spc_fxwait	$64
	spc_fxmono	$00
	spc_fxvolumeramp	$1e,$00,$00,$00
	spc_fxsample	$04
	spc_fxskipkeyoff
	spc_fxdecay	$07
	spc_fxsustainrate	$01
	spc_fxechoon
	spc_fxnote	$c7
	spc_fxwait	$1a
	spc_fxnote	$c3
	spc_fxwait	$1a
	spc_fxnote	$c7
	spc_fxwait	$1a
	spc_fxnote	$c3
	spc_fxwait	$1a
	spc_fxvolumeramp	$f1,$ff,$1e,$00
	spc_fxnote	$c7
	spc_fxwait	$1a
	spc_fxnote	$c3
	spc_fxwait	$1a
	spc_fxechooff
	spc_fxpitchramp	$f9,$ff
	spc_fxvolumeramp	$f6,$ff,$50,$00
	spc_fxnote	$c7
	spc_fxwait	$1a
	spc_fxnote	$c3
	spc_fxwait	$1a
	spc_fxend
spc_effect_c09d
	spc_fxheader	$04
	spc_fxsample	$04
	spc_fxvolume	$08,$0f
	spc_fxattack	$0a
	spc_fxtimeout	$3f
spc_effect_c0a7
	spc_fxpitchramp	$90,$01
	spc_fxnote	$c3
	spc_fxwait	$08
	spc_fxtie
	spc_fxpitchramp	$70,$fe
	spc_fxwait	$08
	spc_fxtie
	spc_fxjump	spc_effect_c0a7
spc_effect_c0b5
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$20,$00
spc_effect_c0bb
	spc_fxsample	$0d
	spc_fxechoon
	spc_fxattack	$04
	spc_fxsustainrate	$0d
	spc_fxpitchramp	$e2,$ff
	spc_fxnote	$c8
	spc_fxwait	$64
	spc_fxend
spc_effect_c0c8
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$00,$20
	spc_fxjump	spc_effect_c0bb
spc_effect_c0d1
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$32,$1e
spc_effect_c0d7
	spc_fxsustainrate	$1c
	spc_fxechoon
	spc_fxsample	$0f
	spc_fxnote	$a4
	spc_fxwait	$02
	spc_fxskipkeyoff
	spc_fxnote	$a8
	spc_fxwait	$03
	spc_fxsustainrate	$00
	spc_fxsample	$0d
	spc_fxpitchramp	$d0,$07
	spc_fxskipkeyoff
	spc_fxnote	$8c
	spc_fxwait	$02
	spc_fxend
spc_effect_c0ec
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$1e,$32
	spc_fxjump	spc_effect_c0d7
spc_effect_c0f5
	spc_fxheader	$06
	spc_fxsample	$25
	spc_fxvolume	$04,$20
	spc_fxattack	$0c
	spc_fxnote	$c3
	spc_fxwait	$06
	spc_fxtie
	spc_fxpitchramp	$28,$00
	spc_fxwait	$0f
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxpitchramp	$d8,$ff
	spc_fxwait	$0f
	spc_fxend
spc_effect_c10b
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxspawn	spc_effect_c138
	spc_fxdetune	$28
	spc_fxattack	$0d
	spc_fxsample	$03
	spc_fxkeyoff
	spc_fxwait	$0c
	spc_fxvolume	$14,$28
spc_effect_c11c
	spc_fxsample	$05
	spc_fxechoon
	spc_fxsustainrate	$12
	spc_fxnote	$ca
	spc_fxwait	$04
	spc_fxnote	$cc
	spc_fxwait	$04
	spc_fxnote	$cf
	spc_fxwait	$04
	spc_fxnote	$d1
	spc_fxwait	$05
	spc_fxnote	$d3
	spc_fxwait	$06
	spc_fxtie
	spc_fxvolumeramp	$60,$f0,$60,$f0
	spc_fxwait	$02
	spc_fxvolumerampoff
	spc_fxnote	$d1
	spc_fxwait	$04
	spc_fxnote	$d3
	spc_fxwait	$04
	spc_fxend
spc_effect_c138
	spc_fxheader	$03
	spc_fxmode	$01
	spc_fxdetune	$3c
	spc_fxvolume	$28,$14
	spc_fxjump	spc_effect_c11c
spc_effect_c143
	spc_fxheader	$06
	spc_fxmode	$01
	spc_fxvolume	$01,$1e
	spc_fxvolumeramp	$1e,$00,$e2,$ff
	spc_fxjump	spc_effect_c164
spc_effect_c151
	spc_fxheader	$06
	spc_fxmode	$01
	spc_fxvolume	$1e,$01
	spc_fxvolumeramp	$e2,$ff,$1e,$00
	spc_fxjump	spc_effect_c164
spc_effect_c15f
	spc_fxheader	$06
	spc_fxmode	$01
	spc_fxmono	$19
spc_effect_c164
	spc_fxechoon
	spc_fxsample	$03
	spc_fxdecay	$04
	spc_fxsustainlevel	$04
	spc_fxsustainrate	$10
	spc_fxnote	$c8
spc_effect_c16e
	spc_fxwait	$06
	spc_fxjump	spc_effect_c16e
spc_effect_c172
	spc_fxheader	$06
	spc_fxvolume	$01,$1e
	spc_fxjump	spc_effect_c183
spc_effect_c179
	spc_fxheader	$06
	spc_fxmono	$19
	spc_fxjump	spc_effect_c183
spc_effect_c17f
	spc_fxheader	$06
	spc_fxvolume	$1e,$01
spc_effect_c183
	spc_fxmode	$01
	spc_fxechoon
	spc_fxsample	$03
	spc_fxdecay	$04
	spc_fxsustainlevel	$04
	spc_fxsustainrate	$10
	spc_fxnote	$c8
	spc_fxwait	$32
	spc_fxend
spc_effect_c191
	spc_fxheader	$06
	spc_fxechoon
	spc_fxmono	$1e
	spc_fxsample	$23
	spc_fxnoise	$a6
	spc_fxattack	$02
	spc_fxpitchramp	$fe,$ff
	spc_fxnote	$ca
	spc_fxwait	$7e
	spc_fxtie
	spc_fxpitchramp	$f6,$ff
	spc_fxwait	$7e
	spc_fxtie
	spc_fxwait	$28
	spc_fxtie
	spc_fxpitchramp	$ff,$ff
	spc_fxsustainrate	$0a
	spc_fxwait	$7e
	spc_fxtie
	spc_fxwait	$7e
	spc_fxend
spc_effect_c1b1
	spc_fxheader	$03
	spc_fxmode	$01
	spc_fxspawn	spc_effect_c1c9
	spc_fxechoon
	spc_fxsample	$05
	spc_fxdetune	$32
	spc_fxsustainrate	$14
	spc_fxvolume	$20,$00
	spc_fxnote	$c2
	spc_fxwait	$07
	spc_fxvolume	$0b,$18
	spc_fxnote	$ca
	spc_fxwait	$18
	spc_fxend
spc_effect_c1c9
	spc_fxheader	$02
	spc_fxmode	$01
	spc_fxechoon
	spc_fxsample	$05
	spc_fxdetune	$32
	spc_fxsustainrate	$14
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxvolume	$18,$0b
	spc_fxnote	$c6
	spc_fxwait	$08
	spc_fxvolume	$00,$32
	spc_fxnote	$ce
	spc_fxwait	$14
	spc_fxend
spc_effect_c1e0
	spc_fxheader	$02
	spc_fxmode	$01
	spc_fxspawn	spc_effect_c1f3
	spc_fxspawn	spc_effect_c2dc
	spc_fxechoon
	spc_fxsample	$05
	spc_fxdetune	$32
	spc_fxsustainrate	$14
	spc_fxjump	spc_effect_c25c
spc_effect_c1f3
	spc_fxheader	$01
	spc_fxmode	$01
	spc_fxechoon
	spc_fxjump	spc_effect_c2b3
spc_effect_c1fa
	spc_fxheader	$03
	spc_fxmode	$01
	spc_fxspawn	spc_effect_c237
	spc_fxspawn	spc_effect_c287
	spc_fxechoon
	spc_fxsample	$05
	spc_fxdetune	$32
	spc_fxsustainrate	$14
	spc_fxvolume	$00,$20
	spc_fxnote	$c2
	spc_fxwait	$07
	spc_fxvolume	$18,$0b
	spc_fxnote	$ca
	spc_fxwait	$18
	spc_fxattack	$0e
	spc_fxvolume	$00,$0a
	spc_fxnote	$c2
	spc_fxwait	$08
	spc_fxvolume	$06,$03
	spc_fxnote	$ca
	spc_fxwait	$18
	spc_fxattack	$0d
	spc_fxvolume	$00,$07
	spc_fxnote	$c2
	spc_fxwait	$04
	spc_fxvolume	$02,$04
	spc_fxnote	$c6
	spc_fxwait	$04
	spc_fxvolume	$04,$02
	spc_fxnote	$ca
	spc_fxwait	$04
	spc_fxvolume	$07,$00
	spc_fxnote	$ce
	spc_fxwait	$18
	spc_fxend
spc_effect_c237
	spc_fxheader	$02
	spc_fxmode	$01
	spc_fxechoon
	spc_fxsample	$05
	spc_fxdetune	$32
	spc_fxsustainrate	$14
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxvolume	$0b,$18
	spc_fxnote	$c6
	spc_fxwait	$08
	spc_fxvolume	$32,$00
	spc_fxnote	$ce
	spc_fxwait	$18
	spc_fxattack	$0e
	spc_fxvolume	$03,$06
	spc_fxnote	$c6
	spc_fxwait	$08
	spc_fxvolume	$0a,$00
	spc_fxnote	$ce
	spc_fxwait	$18
	spc_fxspawn	spc_effect_c2dc
spc_effect_c25c
	spc_fxsample	$02
	spc_fxdetune	$00
	spc_fxsustainrate	$14
spc_effect_c262
	spc_fxmono	$0a
	spc_fxnote	$ab
	spc_fxwait	$18
	spc_fxnote	$a6
	spc_fxwait	$18
	spc_fxnote	$a4
	spc_fxwait	$18
	spc_fxnote	$a4
	spc_fxwait	$10
	spc_fxnote	$ab
	spc_fxwait	$08
	spc_fxnote	$ab
	spc_fxwait	$10
	spc_fxnote	$a4
	spc_fxwait	$08
	spc_fxnote	$a5
	spc_fxwait	$08
	spc_fxnote	$a6
	spc_fxwait	$18
	spc_fxnote	$ad
	spc_fxwait	$18
	spc_fxnote	$ab
	spc_fxwait	$18
	spc_fxnote	$ab
	spc_fxwait	$10
	spc_fxnote	$ab
	spc_fxwait	$08
	spc_fxnote	$a6
	spc_fxwait	$10
	spc_fxnote	$a8
	spc_fxwait	$08
	spc_fxnote	$aa
	spc_fxwait	$08
	spc_fxjump	spc_effect_c262
spc_effect_c287
	spc_fxheader	$01
	spc_fxmode	$01
	spc_fxechoon
	spc_fxkeyoff
	spc_fxwait	$04
	spc_fxsample	$0b
	spc_fxmono	$02
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxmono	$02
	spc_fxnote	$bf
	spc_fxwait	$08
	spc_fxmono	$03
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxmono	$07
	spc_fxnote	$bf
	spc_fxwait	$08
	spc_fxsample	$0a
	spc_fxmono	$04
	spc_fxnote	$c9
	spc_fxwait	$08
	spc_fxsample	$0b
	spc_fxmono	$02
	spc_fxnote	$bf
	spc_fxwait	$08
	spc_fxmono	$05
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$bf
	spc_fxwait	$08
spc_effect_c2b3
	spc_fxsample	$0b
	spc_fxmono	$09
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxmono	$04
	spc_fxnote	$bf
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxmono	$0b
	spc_fxnote	$bf
	spc_fxwait	$08
	spc_fxsample	$0a
	spc_fxmono	$08
	spc_fxnote	$c9
	spc_fxwait	$08
	spc_fxsample	$0b
	spc_fxmono	$04
	spc_fxnote	$bf
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxmono	$0b
	spc_fxnote	$bf
	spc_fxwait	$08
	spc_fxjump	spc_effect_c2b3
spc_effect_c2dc
	spc_fxheader	$00
	spc_fxmode	$01
	spc_fxechoon
	spc_fxsample	$03
	spc_fxsustainrate	$14
	spc_fxkeyoff
	spc_fxwait	$01
spc_effect_c2e6
	spc_fxmono	$08
	spc_fxnote	$c3
	spc_fxwait	$10
	spc_fxnote	$c7
	spc_fxwait	$08
	spc_fxnote	$ca
	spc_fxwait	$0c
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$04
	spc_fxmono	$08
	spc_fxnote	$be
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c3
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c8
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$02
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c0
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c1
	spc_fxwait	$08
	spc_fxnote	$c2
	spc_fxwait	$10
	spc_fxnote	$c5
	spc_fxwait	$08
	spc_fxnote	$ca
	spc_fxwait	$0c
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$04
	spc_fxmono	$08
	spc_fxnote	$c2
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c3
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$c7
	spc_fxwait	$08
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$08
	spc_fxmono	$08
	spc_fxnote	$ca
	spc_fxwait	$0e
	spc_fxtie
	spc_fxmono	$05
	spc_fxwait	$02
	spc_fxmono	$08
	spc_fxnote	$be
	spc_fxwait	$18
	spc_fxjump	spc_effect_c2e6
spc_effect_c34f
	spc_fxheader	$02
	spc_fxmode	$01
	spc_fxspawn	spc_effect_c37d
	spc_fxspawn	spc_effect_c395
	spc_fxsample	$03
	spc_fxvolume	$03,$19
	spc_fxechoon
	spc_fxsustainrate	$0b
	spc_fxnote	$c7
	spc_fxwait	$07
	spc_fxnote	$c1
	spc_fxwait	$07
	spc_fxnote	$c7
	spc_fxwait	$07
	spc_fxnote	$c6
	spc_fxwait	$07
	spc_fxnote	$c0
	spc_fxwait	$07
	spc_fxnote	$c6
	spc_fxwait	$07
	spc_fxnote	$c5
	spc_fxwait	$07
	spc_fxnote	$bf
	spc_fxwait	$07
	spc_fxnote	$c5
	spc_fxwait	$08
	spc_fxnote	$c4
	spc_fxwait	$08
	spc_fxnote	$be
	spc_fxwait	$09
	spc_fxnote	$c4
	spc_fxwait	$09
	spc_fxsustainrate	$0e
	spc_fxnote	$bd
	spc_fxwait	$64
	spc_fxend
spc_effect_c37d
	spc_fxheader	$01
	spc_fxmode	$01
	spc_fxsample	$03
	spc_fxvolume	$00,$23
	spc_fxechoon
	spc_fxsustainrate	$0b
	spc_fxnote	$b7
	spc_fxwait	$15
	spc_fxnote	$bc
	spc_fxwait	$15
	spc_fxnote	$b5
	spc_fxwait	$15
	spc_fxnote	$b4
	spc_fxwait	$15
	spc_fxsustainrate	$0e
	spc_fxnote	$b3
	spc_fxwait	$64
	spc_fxend
spc_effect_c395
	spc_fxheader	$00
	spc_fxmode	$01
	spc_fxsample	$02
	spc_fxechoon
	spc_fxvolume	$10,$00
	spc_fxpitchramp	$26,$00
	spc_fxnote	$c5
	spc_fxwait	$09
	spc_fxtie
	spc_fxnote	$c7
	spc_fxpitchrampoff
	spc_fxwait	$07
	spc_fxtie
	spc_fxpitchramp	$b4,$ff
	spc_fxwait	$04
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxpitchramp	$26,$00
	spc_fxnote	$c4
	spc_fxwait	$09
	spc_fxtie
	spc_fxnote	$c6
	spc_fxpitchrampoff
	spc_fxwait	$07
	spc_fxtie
	spc_fxpitchramp	$b4,$ff
	spc_fxwait	$04
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxpitchramp	$26,$00
	spc_fxnote	$c3
	spc_fxwait	$09
	spc_fxtie
	spc_fxnote	$c5
	spc_fxpitchrampoff
	spc_fxwait	$07
	spc_fxtie
	spc_fxpitchramp	$b4,$ff
	spc_fxwait	$04
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxpitchramp	$26,$00
	spc_fxnote	$c2
	spc_fxwait	$09
	spc_fxtie
	spc_fxnote	$c4
	spc_fxpitchrampoff
	spc_fxwait	$07
	spc_fxtie
	spc_fxpitchramp	$b4,$ff
	spc_fxwait	$04
	spc_fxkeyoff
	spc_fxwait	$02
	spc_fxsustainrate	$10
	spc_fxpitchramp	$27,$00
	spc_fxnote	$c1
	spc_fxwait	$09
	spc_fxtie
	spc_fxnote	$c3
	spc_fxpitchrampoff
	spc_fxwait	$64
	spc_fxend
spc_effect_c3ea
	spc_fxheader	$04
	spc_fxtimeout	$23
	spc_fxnote	$c2
	spc_fxmono	$30
	spc_fxsustainrate	$13
	spc_fxjump	spc_effect_c4f2
spc_effect_c3f5
	spc_fxheader	$04
	spc_fxtimeout	$13
	spc_fxjump	spc_effect_c409
spc_effect_c3fb
	spc_fxheader	$04
	spc_fxjump	spc_effect_c409
spc_effect_c3ff
	spc_fxheader	$04
	spc_fxspawn	spc_effect_c4ad
	spc_fxmono	$50
	spc_fxsample	$0f
	spc_fxnote	$ab
	spc_fxwait	$05
spc_effect_c409
	spc_fxmono	$46
	spc_fxsample	$0f
	spc_fxnote	$a8
	spc_fxpitchramp	$fb,$ff
	spc_fxwait	$02
	spc_fxsample	$0a
	spc_fxwait	$05
	spc_fxpitchramp	$03,$00
	spc_fxwait	$28
	spc_fxend
spc_effect_c41a
	spc_fxheader	$07
	spc_fxmode	$01
	spc_fxspawn	spc_effect_c431
	spc_fxmono	$13
	spc_fxsample	$10
	spc_fxnote	$c8
spc_effect_c425
	spc_fxattack	$0e
	spc_fxpitchramp	$44,$fd
	spc_fxwait	$07
	spc_fxtie
	spc_fxpitchramp	$26,$02
	spc_fxwait	$07
	spc_fxend
spc_effect_c431
	spc_fxheader	$06
	spc_fxmode	$01
	spc_fxechoon
	spc_fxmono	$12
	spc_fxsample	$0a
	spc_fxnote	$cc
	spc_fxjump	spc_effect_c425
spc_effect_c43d
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$00,$1d
	spc_fxsample	$03
	spc_fxattack	$0d
	spc_fxnote	$ce
	spc_fxwait	$0a
spc_effect_c449
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxvolume	$02,$0a
	spc_fxattack	$0f
	spc_fxsustainrate	$0f
	spc_fxwait	$14
	spc_fxend
spc_effect_c454
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxvolume	$00,$18
	spc_fxsample	$03
	spc_fxattack	$0d
	spc_fxnote	$ce
	spc_fxwait	$3c
	spc_fxjump	spc_effect_c449
spc_effect_c463
	spc_fxheader	$04
	spc_fxsample	$0a
	spc_fxmono	$50
	spc_fxnote	$ab
	spc_fxwait	$08
	spc_fxend
spc_effect_c46b
	spc_fxheader	$04
	spc_fxsample	$0a
	spc_fxmono	$5a
	spc_fxnote	$ab
	spc_fxwait	$10
	spc_fxend
spc_effect_c473
	spc_fxheader	$04
	spc_fxsample	$0a
	spc_fxmono	$5f
	spc_fxnote	$ab
	spc_fxwait	$20
	spc_fxend
spc_effect_c47b
	spc_fxheader	$04
	spc_fxsample	$0a
	spc_fxmono	$64
	spc_fxnote	$ab
	spc_fxwait	$40
	spc_fxend
spc_effect_c483
	spc_fxheader	$04
	spc_fxechoon
	spc_fxsample	$0f
	spc_fxmode	$04
	spc_fxmono	$28
	spc_fxnote	$b7
	spc_fxsustainrate	$10
	spc_fxwait	$02
	spc_fxmono	$19
	spc_fxsample	$0a
	spc_fxnote	$b7
	spc_fxechooff
	spc_fxwait	$05
	spc_fxnote	$ab
	spc_fxwait	$05
	spc_fxend
spc_effect_c499
	spc_fxheader	$04
	spc_fxsample	$0f
	spc_fxmode	$04
	spc_fxspawn	spc_effect_c4ad
	spc_fxmono	$23
	spc_fxsustainrate	$0d
	spc_fxnote	$af
	spc_fxwait	$01
	spc_fxwait	$04
	spc_fxmono	$32
	spc_fxnote	$b2
	spc_fxwait	$2d
	spc_fxend
spc_effect_c4ad
	spc_fxheader	$03
	spc_fxsample	$0a
	spc_fxmode	$04
	spc_fxmono	$23
	spc_fxnote	$a6
	spc_fxwait	$05
	spc_fxsample	$0d
	spc_fxsustainrate	$0f
	spc_fxpitchramp	$02,$00
	spc_fxnote	$af
	spc_fxwait	$23
	spc_fxend
spc_effect_c4c0
	spc_fxheader	$04
	spc_fxmode	$04
	spc_fxmono	$32
	spc_fxsustainrate	$0e
	spc_fxsample	$0a
	spc_fxnote	$b5
	spc_fxwait	$05
	spc_fxpitchramp	$24,$ff
	spc_fxsample	$0f
	spc_fxnote	$aa
	spc_fxwait	$02
	spc_fxnote	$b2
	spc_fxwait	$03
	spc_fxnote	$b1
	spc_fxwait	$02
	spc_fxvolumeramp	$7c,$fc,$7c,$fc
	spc_fxnote	$a8
	spc_fxwait	$03
	spc_fxnote	$b2
	spc_fxwait	$06
	spc_fxnote	$b0
	spc_fxwait	$07
	spc_fxpitchramp	$f6,$ff
	spc_fxnote	$a4
	spc_fxwait	$0a
	spc_fxend
spc_effect_c4e7
	spc_fxheader	$04
	spc_fxspawn	spc_effect_c506
	spc_fxtimeout	$78
	spc_fxnote	$c0
	spc_fxmono	$2d
	spc_fxsustainrate	$0f
spc_effect_c4f2
	spc_fxechoon
	spc_fxsample	$06
	spc_fxpitchramp	$a2,$fe
	spc_fxwait	$06
spc_effect_c4f9
	spc_fxpitchramp	$91,$01
	spc_fxwait	$04
	spc_fxtie
	spc_fxpitchramp	$70,$fe
	spc_fxwait	$04
	spc_fxtie
	spc_fxjump	spc_effect_c4f9
spc_effect_c506
	spc_fxheader	$03
	spc_fxsustainrate	$05
	spc_fxsample	$0f
	spc_fxmono	$28
	spc_fxnote	$a8
	spc_fxwait	$02
	spc_fxnote	$a3
	spc_fxwait	$03
	spc_fxnote	$ad
	spc_fxwait	$27
	spc_fxend
spc_effect_c514
	spc_fxheader	$04
	spc_fxsustainrate	$10
	spc_fxmono	$50
	spc_fxsample	$0f
	spc_fxnote	$b0
	spc_fxwait	$02
	spc_fxwait	$02
	spc_fxsample	$0a
	spc_fxnote	$b7
	spc_fxwait	$05
	spc_fxspawn	spc_effect_c506
	spc_fxwait	$0f
	spc_fxmono	$46
	spc_fxsample	$0d
	spc_fxnote	$a3
	spc_fxpitchramp	$02,$00
	spc_fxwait	$74
	spc_fxend
spc_effect_c530
	spc_fxheader	$04
	spc_fxspawn	spc_effect_c552
	spc_fxspawn	spc_effect_c56e
	spc_fxechoon
	spc_fxvolume	$1c,$21
	spc_fxsample	$20
	spc_fxvolumeramp	$fb,$ff,$00,$00
	spc_fxnote	$9f
	spc_fxwait	$0e
	spc_fxtie
spc_effect_c545
	spc_fxpitchramp	$13,$01
	spc_fxwait	$0e
	spc_fxtie
	spc_fxpitchramp	$ce,$ff
	spc_fxwait	$46
	spc_fxtie
	spc_fxjump	spc_effect_c545
spc_effect_c552
	spc_fxheader	$00
	spc_fxvolume	$32,$00
	spc_fxsample	$20
	spc_fxechoon
	spc_fxnote	$b4
	spc_fxvolumeramp	$00,$00,$f6,$ff
spc_effect_c55f
	spc_fxwait	$24
	spc_fxpitchramp	$66,$00
	spc_fxwait	$24
	spc_fxtie
	spc_fxpitchramp	$9c,$ff
	spc_fxwait	$24
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxjump	spc_effect_c55f
spc_effect_c56e
	spc_fxheader	$01
	spc_fxvolume	$00,$1b
	spc_fxsample	$20
	spc_fxechoon
	spc_fxnote	$9f
	spc_fxwait	$0a
	spc_fxvolumeramp	$fb,$ff,$fb,$ff
spc_effect_c57c
	spc_fxpitchramp	$90,$01
	spc_fxwait	$10
	spc_fxtie
	spc_fxpitchramp	$06,$ff
	spc_fxwait	$18
	spc_fxtie
	spc_fxjump	spc_effect_c57c
spc_effect_c589
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxmono	$23
	spc_fxsample	$03
	spc_fxattack	$06
	spc_fxpitchramp	$1e,$00
	spc_fxnote	$a8
	spc_fxwait	$1e
	spc_fxend
spc_effect_c598
	spc_fxheader	$04
	spc_fxmode	$01
	spc_fxmono	$2d
	spc_fxsample	$03
	spc_fxattack	$06
	spc_fxsustainrate	$0e
	spc_fxpitchramp	$d8,$ff
	spc_fxnote	$bc
	spc_fxwait	$28
	spc_fxend
spc_effect_c5a9
	spc_fxheader	$06
	spc_fxechoon
	spc_fxvolume	$1e,$00
	spc_fxsample	$25
	spc_fxattack	$0b
	spc_fxtimeout	$32
	spc_fxnote	$c3
spc_effect_c5b5
	spc_fxwait	$05
	spc_fxtie
	spc_fxpitchramp	$6a,$ff
	spc_fxwait	$08
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxpitchramp	$3c,$00
	spc_fxwait	$0a
	spc_fxpitchramp	$82,$00
	spc_fxkeyoff
	spc_fxwait	$05
	spc_fxjump	spc_effect_c5b5
spc_effect_c5c9
	spc_fxheader	$06
	spc_fxsample	$24
	spc_fxechoon
	spc_fxattack	$06
	spc_fxvolume	$00,$7e
	spc_fxvolumeramp	$2c,$01,$4c,$ff
	spc_fxpitchramp	$64,$00
	spc_fxnote	$a2
	spc_fxwait	$05
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxwait	$5f
	spc_fxvolumerampoff
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxvolume	$0f,$03
	spc_fxwait	$14
	spc_fxend
spc_effect_c5e7
	spc_fxheader	$04
	spc_fxmono	$1e
	spc_fxnote	$c8
	spc_fxtimeout	$1c
	spc_fxjump	spc_effect_c5f5
spc_effect_c5f0
	spc_fxheader	$06
	spc_fxmono	$0e
	spc_fxnote	$c9
	spc_fxechoon
spc_effect_c5f5
	spc_fxsample	$11
	spc_fxattack	$0e
	spc_fxpitchramp	$32,$00
	spc_fxwait	$03
	spc_fxtie
	spc_fxpitchramp	$01,$00
	spc_fxwait	$19
	spc_fxpitchrampoff
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$08
	spc_fxattack	$0f
	spc_fxsustainrate	$0a
	spc_fxwait	$14
	spc_fxend
spc_effect_c60d
	spc_fxheader	$04
	spc_fxmono	$1e
	spc_fxnote	$af
	spc_fxtimeout	$28
	spc_fxjump	spc_effect_c61b
spc_effect_c616
	spc_fxheader	$06
	spc_fxmono	$14
	spc_fxnote	$b0
	spc_fxechoon
spc_effect_c61b
	spc_fxsample	$02
	spc_fxpitchramp	$01,$00
	spc_fxattack	$0e
	spc_fxwait	$0a
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxwait	$1e
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$0d
	spc_fxattack	$0f
	spc_fxsustainrate	$0a
	spc_fxwait	$14
	spc_fxend
spc_effect_c630
	spc_fxheader	$04
	spc_fxmono	$2f
	spc_fxsample	$12
	spc_fxnote	$b2
	spc_fxechoon
	spc_fxwait	$19
	spc_fxend
spc_effect_c639
	spc_fxheader	$06
	spc_fxmono	$19
	spc_fxsample	$12
	spc_fxnote	$b3
	spc_fxechoon
	spc_fxwait	$14
	spc_fxwait	$16
	spc_fxend
spc_effect_c643
	spc_fxheader	$04
	spc_fxmono	$1e
	spc_fxechoon
	spc_fxsample	$11
	spc_fxnote	$bd
	spc_fxwait	$19
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$09
	spc_fxsustainrate	$0a
	spc_fxwait	$14
	spc_fxend
spc_effect_c653
	spc_fxheader	$04
	spc_fxmono	$64
	spc_fxsample	$24
	spc_fxattack	$0b
	spc_fxdecay	$00
	spc_fxsustainlevel	$04
	spc_fxpitchramp	$14,$00
	spc_fxnote	$a8
	spc_fxwait	$03
	spc_fxtie
	spc_fxpitchrampoff
	spc_fxwait	$50
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$14
	spc_fxattack	$0f
	spc_fxwait	$1e
	spc_fxend
spc_effect_c66e
	spc_fxheader	$04
	spc_fxnote	$d3
	spc_fxattack	$09
	spc_fxsample	$1c
	spc_fxechoon
	spc_fxwait	$7f
	spc_fxend
spc_effect_c677
	spc_fxheader	$84
	spc_fxnote	$d3
	spc_fxattack	$06
	spc_fxsample	$20
	spc_fxechoon
	spc_fxwait	$7f
	spc_fxend
spc_effect_c680
	spc_fxheader	$87
	spc_fxechoon
	spc_fxspawn	spc_effect_c6b2
	spc_fxnote	$80
	spc_fxsample	$1c
	spc_fxwait	$7f
	spc_fxend
spc_effect_c68a
	spc_fxheader	$87
	spc_fxechoon
	spc_fxspawn	spc_effect_c6b9
	spc_fxsample	$1c
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c694
	spc_fxheader	$87
	spc_fxechoon
	spc_fxspawn	spc_effect_c6c0
	spc_fxsample	$1c
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c69e
	spc_fxheader	$87
	spc_fxechoon
	spc_fxspawn	spc_effect_c6c7
	spc_fxsample	$1c
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6a8
	spc_fxheader	$87
	spc_fxechoon
	spc_fxspawn	spc_effect_c6ce
	spc_fxsample	$1c
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6b2
	spc_fxheader	$86
	spc_fxechoon
	spc_fxsample	$20
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6b9
	spc_fxheader	$86
	spc_fxechoon
	spc_fxsample	$20
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6c0
	spc_fxheader	$86
	spc_fxechoon
	spc_fxsample	$20
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6c7
	spc_fxheader	$86
	spc_fxechoon
	spc_fxsample	$20
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6ce
	spc_fxheader	$86
	spc_fxechoon
	spc_fxsample	$20
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6d5
	spc_fxheader	$c7
	spc_fxechoon
	spc_fxnote	$80
	spc_fxwait	$7f
	spc_fxend
spc_effect_c6da
	spc_fxheader	$04
	spc_fxmono	$3c
	spc_fxsample	$12
	spc_fxattack	$0a
	spc_fxpitchramp	$b0,$ff
	spc_fxnote	$b2
	spc_fxwait	$07
	spc_fxtie
	spc_fxpitchramp	$50,$00
	spc_fxnote	$9f
	spc_fxwait	$0d
	spc_fxend
spc_effect_c6ed
	spc_fxheader	$04
	spc_fxmono	$32
	spc_fxsample	$0e
	spc_fxpitchramp	$9c,$ff
	spc_fxnote	$b2
	spc_fxwait	$05
	spc_fxsample	$12
	spc_fxpitchramp	$50,$00
	spc_fxnote	$a6
	spc_fxwait	$0f
	spc_fxend
spc_effect_c6ff
	spc_fxheader	$04
	spc_fxsample	$24
	spc_fxmono	$64
	spc_fxdecay	$05
	spc_fxsustainlevel	$03
	spc_fxsustainrate	$10
	spc_fxnote	$c0
spc_effect_c70b
	spc_fxwait	$14
	spc_fxkeyoff
	spc_fxwait	$01
	spc_fxmono	$08
	spc_fxsustainrate	$12
	spc_fxwait	$13
	spc_fxend
spc_effect_c714
	spc_fxheader	$04
	spc_fxsample	$24
	spc_fxmono	$46
	spc_fxdecay	$05
	spc_fxsustainlevel	$03
	spc_fxsustainrate	$10
	spc_fxnote	$c0
	spc_fxwait	$14
	spc_fxwait	$14
	spc_fxwait	$14
	spc_fxjump	spc_effect_c70b
spc_effect_c726
	spc_fxheader	$04
	spc_fxsample	$0d
	spc_fxmono	$32
	spc_fxattack	$08
	spc_fxsustainrate	$12
	spc_fxpitchramp	$ec,$ff
	spc_fxnote	$b7
	spc_fxwait	$1e
	spc_fxend

; Bundled music: order words, eight-channel patterns and track bytecode.
spc_music_c735
	spc_musicpattern	spc_music_c73f
spc_music_c737
	spc_musicpattern	spc_music_c74f
	spc_musicloop	$ff,spc_music_c737
	spc_musicend
spc_music_c73f
	dw	spc_music_c75f,0,0,0,0,0,0,0
spc_music_c74f
	dw	spc_music_c76e,spc_music_c7b9,spc_music_c826,spc_music_c849,0,0,spc_music_c868,0
spc_music_c75f
	spc_musicpercussionbase	$09
	spc_musictempo	$1b
	spc_musicvolume	$b4
	spc_musicecho	$db,$11,$11
	spc_musicechoconfig	$03,$50,$02
	spc_trackend
spc_music_c76e
	spc_musictrackvolume	$e6
	spc_musicinstrument	$05
	spc_musicfinetuning	$aa
	spc_musicpan	$0f
	spc_trackgate	$06,$28
	spc_tracknote	$a4
	spc_tracknote	$a8
	spc_tracknote	$ab
	spc_tracknote	$a4
	spc_tracknote	$a8
	spc_tracknote	$ab
	spc_tracknote	$a4
	spc_tracknote	$a8
	spc_tracknote	$ab
	spc_tracknote	$a4
	spc_tracknote	$a8
	spc_tracknote	$ab
	spc_tracknote	$a4
	spc_tracknote	$a8
	spc_tracknote	$ab
	spc_tracknote	$a4
	spc_tracknote	$a6
	spc_tracknote	$aa
	spc_tracknote	$ad
	spc_tracknote	$a6
	spc_tracknote	$aa
	spc_tracknote	$ad
	spc_tracknote	$a6
	spc_tracknote	$aa
	spc_tracknote	$ad
	spc_tracknote	$a6
	spc_tracknote	$aa
	spc_tracknote	$ad
	spc_tracknote	$a6
	spc_tracknote	$aa
	spc_tracknote	$ad
	spc_tracknote	$aa
	spc_tracknote	$a6
	spc_tracknote	$ab
	spc_tracknote	$af
	spc_tracknote	$a6
	spc_tracknote	$ab
	spc_tracknote	$af
	spc_tracknote	$a6
	spc_tracknote	$ab
	spc_tracknote	$af
	spc_tracknote	$a6
	spc_tracknote	$ab
	spc_tracknote	$af
	spc_tracknote	$a6
	spc_tracknote	$ab
	spc_tracknote	$af
	spc_tracknote	$ab
	spc_tracknote	$a4
	spc_tracknote	$a9
	spc_tracknote	$ad
	spc_tracknote	$a4
	spc_tracknote	$a9
	spc_tracknote	$ad
	spc_tracknote	$a4
	spc_tracknote	$a7
	spc_tracknote	$ac
	spc_tracknote	$a4
	spc_tracknote	$a7
	spc_tracknote	$ac
	spc_tracknote	$a4
	spc_tracknote	$a7
	spc_tracknote	$ac
	spc_tracknote	$a7
	spc_trackend
spc_music_c7b9
	spc_musictrackvolume	$ff
	spc_musicinstrument	$00
	spc_musicfinetuning	$1e
	spc_musicpan	$06
	spc_trackgate	$18,$5d
	spc_tracknote	$8c
	spc_trackgate	$06,$6c
	spc_tracknote	$8c
	spc_trackgate	$0c,$2d
	spc_tracknote	$8c
	spc_trackgate	$0c,$2c
	spc_tracknote	$8c
	spc_trackgate	$0c,$2d
	spc_tracknote	$8c
	spc_trackgate	$06,$6c
	spc_tracknote	$8c
	spc_trackgate	$0c,$4d
	spc_tracknote	$8c
	spc_trackgate	$0c,$7c
	spc_tracknote	$87
	spc_trackgate	$18,$5d
	spc_tracknote	$8c
	spc_trackgate	$06,$6c
	spc_tracknote	$8c
	spc_trackgate	$0c,$2d
	spc_tracknote	$8c
	spc_trackgate	$0c,$2c
	spc_tracknote	$8c
	spc_trackgate	$0c,$2d
	spc_tracknote	$8c
	spc_trackgate	$06,$6c
	spc_tracknote	$8c
	spc_trackgate	$0c,$2c
	spc_tracknote	$8c
	spc_trackgate	$0c,$7d
	spc_tracknote	$8c
	spc_trackgate	$17,$5c
	spc_tracknote	$8b
	spc_trackgate	$07,$7f
	spc_tracknote	$87
	spc_trackgate	$0c,$2c
	spc_tracknote	$8b
	spc_tracknote	$8e
	spc_trackgate	$0c,$7b
	spc_tracknote	$92
	spc_musicpitchslide	$00,$05,$93
	spc_tracktime	$06
	spc_tracknote	$91
	spc_trackgate	$0c,$4d
	spc_tracknote	$8e
	spc_musicpitchslide	$06,$01,$8b
	spc_trackgate	$0c,$7f
	spc_tracknote	$87
	spc_trackgate	$18,$5f
	spc_tracknote	$85
	spc_trackgate	$06,$7d
	spc_tracknote	$8c
	spc_trackgate	$0c,$2c
	spc_tracknote	$91
	spc_trackgate	$0c,$2f
	spc_tracknote	$88
	spc_trackgate	$0c,$2e
	spc_tracknote	$8c
	spc_trackgate	$06,$7d
	spc_tracknote	$8f
	spc_trackgate	$0c,$3c
	spc_tracknote	$94
	spc_trackgate	$0c,$7e
	spc_tracknote	$88
spc_music_c826
	spc_musictrackvolume	$f5
	spc_musicpan	$0b
	spc_musiccall	spc_music_c8a0,$03
	spc_trackgate	$18,$7d
	spc_tracknote	$ca
	spc_trackgate	$12,$78
	spc_tracknote	$cb
	spc_trackgate	$0c,$7b
	spc_tracknote	$ca
	spc_trackgate	$06,$79
	spc_tracknote	$cb
	spc_trackgate	$0c,$7b
	spc_tracknote	$ca
	spc_trackgate	$06,$7a
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$79
	spc_tracknote	$cb
	spc_trackgate	$06,$78
	spc_tracknote	$cb
spc_music_c849
	spc_musictrackvolume	$c8
	spc_musicinstrument	$05
	spc_musicfinetuning	$aa
	spc_musicpan	$0f
	spc_tracktime	$0c
	spc_tracknote	$c9
	spc_trackgate	$12,$08
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_musiccall	spc_music_c8b6,$02
	spc_tracktime	$06
	spc_tracknote	$c9
	spc_tracktime	$12
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_trackgate	$0c,$18
	spc_tracknote	$b0
spc_music_c868
	spc_musictrackvolume	$ff
	spc_musicpan	$08
	spc_trackgate	$24,$77
	spc_tracknote	$ce
	spc_trackgate	$06,$7a
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_trackgate	$0c,$7a
	spc_tracknote	$cc
	spc_tracktime	$06
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_trackgate	$0c,$7c
	spc_tracknote	$cc
	spc_trackgate	$06,$7a
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_musiccall	spc_music_c8bf,$02
	spc_trackgate	$0c,$7a
	spc_tracknote	$cc
	spc_tracktime	$06
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_trackgate	$0c,$7c
	spc_tracknote	$cc
	spc_trackgate	$06,$7a
	spc_tracknote	$cc
	spc_trackgate	$1e,$76
	spc_tracknote	$ce
	spc_musicpan	$0d
	spc_tracktime	$18
	spc_tracknote	$ce
	spc_trackend
spc_music_c8a0
	spc_trackgate	$18,$7d
	spc_tracknote	$ca
	spc_trackgate	$12,$78
	spc_tracknote	$cb
	spc_trackgate	$0c,$7b
	spc_tracknote	$ca
	spc_trackgate	$0c,$7c
	spc_tracknote	$ca
	spc_trackgate	$06,$7b
	spc_tracknote	$ca
	spc_trackgate	$0c,$78
	spc_tracknote	$cb
	spc_trackgate	$0c,$7b
	spc_tracknote	$ca
	spc_trackend
spc_music_c8b6
	spc_tracktime	$06
	spc_tracknote	$c9
	spc_tracktime	$12
	spc_tracknote	$b2
	spc_tracknote	$b2
	spc_tracknote	$b2
	spc_tracknote	$b2
	spc_tracknote	$b2
	spc_trackend
spc_music_c8bf
	spc_trackgate	$0c,$7a
	spc_tracknote	$cc
	spc_tracktime	$06
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_trackgate	$0c,$7c
	spc_tracknote	$cc
	spc_trackgate	$06,$7a
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_trackgate	$0c,$7a
	spc_tracknote	$cc
	spc_tracktime	$06
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_trackgate	$0c,$7c
	spc_tracknote	$cc
	spc_trackgate	$06,$7a
	spc_tracknote	$cc
	spc_trackgate	$06,$78
	spc_tracknote	$cc
	spc_trackend
spc_music_c8e2
	spc_musicpattern	spc_music_c8e8
	spc_musicpattern	spc_music_c8f8
	spc_musicend
spc_music_c8e8
	dw	spc_music_c908,0,0,0,0,0,0,0
spc_music_c8f8
	dw	spc_music_c917,spc_music_c949,spc_music_c97f,spc_music_c9e1,spc_music_ca14,spc_music_ca43,0,0
spc_music_c908
	spc_musicpercussionbase	$09
	spc_musictempo	$1b
	spc_musicvolume	$aa
	spc_musicecho	$3b,$11,$11
	spc_musicechoconfig	$03,$50,$02
	spc_trackend
spc_music_c917
	spc_musictrackvolume	$ff
	spc_musicinstrument	$01
	spc_musicfinetuning	$19
	spc_musicpan	$06
	spc_tracktime	$0c
	spc_tracknote	$c9
	spc_trackgate	$06,$7c
	spc_tracknote	$a4
	spc_tracknote	$a3
	spc_trackgate	$0c,$2c
	spc_tracknote	$a2
	spc_trackgate	$06,$7c
	spc_tracknote	$a0
	spc_trackgate	$0c,$2c
	spc_tracknote	$a1
	spc_tracknote	$a3
	spc_tracknote	$a4
	spc_tracknote	$a6
	spc_trackgate	$06,$7c
	spc_tracknote	$a7
	spc_tracknote	$a8
	spc_tracknote	$9f
	spc_tracknote	$a0
	spc_trackgate	$0c,$2c
	spc_tracknote	$a1
	spc_trackgate	$06,$7c
	spc_tracknote	$a2
	spc_tracknote	$a3
	spc_trackgate	$18,$2c
	spc_tracknote	$a4
	spc_trackgate	$1e,$3d
	spc_tracknote	$a4
	spc_musicpitchslide	$0e,$07,$98
	spc_trackend
spc_music_c949
	spc_musictrackvolume	$ff
	spc_musicinstrument	$00
	spc_musicfinetuning	$1e
	spc_musicpan	$06
	spc_trackgate	$0c,$6f
	spc_tracknote	$8c
	spc_trackgate	$06,$7e
	spc_tracknote	$8c
	spc_tracknote	$8c
	spc_trackgate	$0c,$4e
	spc_tracknote	$90
	spc_trackgate	$06,$7e
	spc_tracknote	$90
	spc_trackgate	$0c,$3e
	spc_tracknote	$91
	spc_tracknote	$91
	spc_tracknote	$92
	spc_trackgate	$0c,$6f
	spc_tracknote	$88
	spc_trackgate	$06,$7f
	spc_tracknote	$88
	spc_tracknote	$87
	spc_trackgate	$18,$7c
	spc_tracknote	$93
	spc_musicpitchslide	$04,$14,$88
	spc_trackgate	$06,$6e
	spc_tracknote	$87
	spc_trackgate	$06,$7f
	spc_tracknote	$87
	spc_trackgate	$18,$2e
	spc_tracknote	$8c
	spc_trackgate	$12,$6f
	spc_tracknote	$8c
	spc_tracktime	$0c
	spc_tracknote	$c9
spc_music_c97f
	spc_musictrackvolume	$ff
	spc_musicpan	$0b
	spc_trackgate	$06,$7a
	spc_tracknote	$cb
	spc_trackgate	$06,$7e
	spc_tracknote	$ca
	spc_trackgate	$06,$79
	spc_tracknote	$cb
	spc_trackgate	$06,$76
	spc_tracknote	$cb
	spc_musicinstrument	$cd
	spc_musicpan	$10
	spc_tracknote	$9d
	spc_musicpan	$0b
	spc_trackgate	$06,$7a
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$78
	spc_tracknote	$cb
	spc_trackgate	$06,$7e
	spc_tracknote	$ca
	spc_trackgate	$06,$78
	spc_tracknote	$cb
	spc_trackgate	$06,$74
	spc_tracknote	$cb
	spc_trackgate	$06,$76
	spc_tracknote	$cb
	spc_trackgate	$06,$7e
	spc_tracknote	$ca
	spc_trackgate	$06,$7a
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$78
	spc_tracknote	$cb
	spc_trackgate	$06,$7a
	spc_tracknote	$cb
	spc_trackgate	$06,$76
	spc_tracknote	$cb
	spc_trackgate	$06,$7e
	spc_tracknote	$ca
	spc_trackgate	$06,$7a
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$79
	spc_tracknote	$cb
	spc_trackgate	$06,$76
	spc_tracknote	$cb
	spc_trackgate	$12,$7b
	spc_tracknote	$cb
	spc_trackgate	$06,$77
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$7b
	spc_tracknote	$cb
	spc_trackgate	$06,$76
	spc_tracknote	$cb
	spc_trackgate	$06,$7a
	spc_tracknote	$cb
	spc_trackgate	$06,$78
	spc_tracknote	$cb
spc_music_c9e1
	spc_musictrackvolume	$ff
	spc_musicinstrument	$03
	spc_musicfinetuning	$0a
	spc_musicpan	$0f
	spc_trackgate	$0c,$77
	spc_tracknote	$a4
	spc_tracktime	$06
	spc_tracknote	$a4
	spc_tracknote	$a6
	spc_tracktime	$0c
	spc_tracknote	$a8
	spc_tracktime	$06
	spc_tracknote	$a8
	spc_tracktime	$0c
	spc_tracknote	$a9
	spc_tracknote	$a9
	spc_tracknote	$aa
	spc_tracknote	$aa
	spc_tracktime	$06
	spc_tracknote	$aa
	spc_trackgate	$12,$37
	spc_tracknote	$a8
	spc_musicinstrument	$01
	spc_musicfinetuning	$19
	spc_musicpan	$07
	spc_trackgate	$0c,$29
	spc_tracknote	$9f
	spc_trackgate	$06,$79
	spc_tracknote	$9f
	spc_tracknote	$9f
	spc_trackgate	$18,$29
	spc_tracknote	$9f
	spc_trackgate	$1e,$3a
	spc_tracknote	$a1
	spc_musicpitchslide	$0e,$07,$95
spc_music_ca14
	spc_musictrackvolume	$ff
	spc_musicinstrument	$03
	spc_musicfinetuning	$0a
	spc_musicpan	$0f
	spc_trackgate	$0c,$77
	spc_tracknote	$b0
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_tracktime	$06
	spc_tracknote	$ae
	spc_tracktime	$0c
	spc_tracknote	$ad
	spc_tracknote	$ad
	spc_tracknote	$ad
	spc_tracknote	$ad
	spc_tracktime	$06
	spc_tracknote	$ad
	spc_tracktime	$12
	spc_tracknote	$ab
	spc_musicinstrument	$01
	spc_musicfinetuning	$19
	spc_musicpan	$08
	spc_trackgate	$0c,$29
	spc_tracknote	$9d
	spc_trackgate	$06,$79
	spc_tracknote	$9d
	spc_tracknote	$9d
	spc_trackgate	$18,$29
	spc_tracknote	$9c
	spc_trackgate	$1e,$3a
	spc_tracknote	$9f
	spc_musicpitchslide	$0e,$07,$93
spc_music_ca43
	spc_musictrackvolume	$d7
	spc_musicinstrument	$02
	spc_musicfinetuning	$00
	spc_musicpan	$0e
	spc_tracktime	$0c
	spc_tracknote	$c9
	spc_trackgate	$06,$7b
	spc_tracknote	$b0
	spc_tracknote	$af
	spc_trackgate	$0c,$2b
	spc_tracknote	$ae
	spc_trackgate	$06,$7b
	spc_tracknote	$ac
	spc_trackgate	$0c,$2b
	spc_tracknote	$ad
	spc_tracknote	$af
	spc_tracknote	$b0
	spc_tracknote	$b2
	spc_trackgate	$06,$7b
	spc_tracknote	$b3
	spc_tracknote	$b4
	spc_tracknote	$ab
	spc_tracknote	$ac
	spc_trackgate	$0c,$2b
	spc_tracknote	$ad
	spc_trackgate	$06,$7b
	spc_tracknote	$ae
	spc_tracknote	$af
	spc_trackgate	$18,$2b
	spc_tracknote	$b0
	spc_trackgate	$1e,$3c
	spc_tracknote	$bc
	spc_musicpitchslide	$0e,$07,$b0
	spc_trackend

; Multiply A by Y+(X<<8): low product in A, next byte in Y; X retains
; the high partial product. The native carry into X is not propagated.
spc_ca75
	spc_push_a
	spc_mul_ya
	spc_mov_dp_a	$26
	spc_mov_dp_y	$27
	spc_mov_a_xreg
	spc_mov_y_a
	spc_pop_a
	spc_mul_ya
	spc_push_a
	spc_mov_a_y
	spc_mov_x_a
	spc_pop_a
	spc_mov_y_a
	spc_mov_a_i	$00
	spc_addw_ya_dp	$26
	spc_ret

; Divide YA by X in two SPC DIV steps; quotient in YA, high byte in $27.
spc_ca89
	spc_push_a
	spc_push_y
	spc_mov_y_i	$00
	spc_pop_a
	spc_div_ya_x
	spc_mov_dp_a	$27
	spc_pop_a
	spc_div_ya_x
	spc_mov_y_dp	$27
	spc_ret

; Right volume arrays are eight bytes above the corresponding left arrays.
spc_ca96
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_inc_x
	spc_ret
spc_ca9f
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_dec_x
	spc_ret

; Twelve effect pitch words, indexed by semitone before octave shifting.
spc_effectpitches
	dw	$217c,$237a,$2596,$27d2
	dw	$2a30,$2cb2,$2f5a,$322c
	dw	$3528,$3850,$3baa,$3f36

; Sample $23 on voices 1-7 updates one of four generated BRR regions.
spc_cac0
	spc_mov_x_i	$07
spc_cac2
	spc_mov_a_abs_x	$03c8
	spc_cmp_a_i	$23
	spc_beq	spc_cacd
	spc_dec_x
	spc_bne	spc_cac2
	spc_ret
spc_cacd
	spc_dec_abs	$0563
	spc_mov_a_abs	$0563
	spc_and_a_i	$03
	spc_mov_y_i	$3f
	spc_mul_ya
	spc_mov_y_a
	spc_mov_dp_i	$20,$07
spc_cadc
	spc_inc_y
	spc_mov_x_i	$04
spc_cadf
	spc_mov1_c	$0019,6
	spc_eor1_c	$0019,5
	spc_rol_dp	$18
	spc_rol_dp	$19
	spc_mov_a_dp	$19
	spc_and_a_i	$d0
	spc_or_a_i	$11
	spc_mov_abs_y_a	$ff00
	spc_inc_y
	spc_mov_a_dp	$18
	spc_and_a_i	$ff
	spc_or_a_i	$11
	spc_mov_abs_y_a	$ff00
	spc_inc_y
	spc_dec_x
	spc_bne	spc_cadf
	spc_dbnz_dp	$20,spc_cadc
	spc_ret
	spc_endblock	$0e64

	spc_block	spc_bundledsongblock,$cb10,$01b3
spc_music_cb10
	spc_musicpattern	spc_music_cb16
	spc_musicpattern	spc_music_cb26
	spc_musicend
spc_music_cb16
	dw	spc_music_cb36,0,0,0,0,0,0,0
spc_music_cb26
	dw	spc_music_cb45,spc_music_cb84,spc_music_cbbc,spc_music_cbfe,spc_music_cc5c,spc_music_cc8f,0,0
spc_music_cb36
	spc_musicpercussionbase	$09
	spc_musictempo	$1e
	spc_musicvolume	$a5
	spc_musicecho	$3b,$11,$11
	spc_musicechoconfig	$03,$50,$02
	spc_trackend
spc_music_cb45
	spc_musictrackvolume	$ff
	spc_musicinstrument	$01
	spc_musicfinetuning	$19
	spc_musicpan	$05
	spc_trackgate	$06,$5e
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_tracknote	$ab
	spc_trackgate	$0d,$3e
	spc_tracknote	$a9
	spc_tracktime	$02
	spc_tracknote	$c9
	spc_trackgate	$06,$5e
	spc_tracknote	$ab
	spc_tracknote	$a9
	spc_tracknote	$a7
	spc_trackgate	$0d,$3e
	spc_tracknote	$a4
	spc_tracktime	$02
	spc_tracknote	$c9
	spc_trackgate	$06,$5e
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_tracknote	$ab
	spc_tracknote	$ae
	spc_tracknote	$ab
	spc_tracknote	$a9
	spc_tracknote	$ab
	spc_tracknote	$a9
	spc_tracknote	$a7
	spc_tracknote	$a9
	spc_tracknote	$a7
	spc_tracknote	$a4
	spc_tracknote	$b3
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_tracknote	$ab
	spc_tracknote	$ae
	spc_tracknote	$ab
	spc_tracknote	$a9
	spc_tracknote	$ab
	spc_tracknote	$a9
	spc_tracknote	$a7
	spc_trackgate	$18,$3e
	spc_tracknote	$a4
	spc_musicpitchslide	$11,$07,$9c
	spc_tracknote	$c9
	spc_trackend
spc_music_cb84
	spc_musictrackvolume	$ff
	spc_musicinstrument	$00
	spc_musicfinetuning	$1e
	spc_musicpan	$06
	spc_trackgate	$42,$5e
	spc_tracknote	$8c
	spc_musicpitchslide	$05,$1e,$98
	spc_trackgate	$06,$7e
	spc_tracknote	$8c
	spc_tracknote	$8f
	spc_tracknote	$91
	spc_trackgate	$06,$7d
	spc_tracknote	$8f
	spc_tracknote	$91
	spc_tracknote	$93
	spc_tracknote	$91
	spc_tracknote	$93
	spc_tracknote	$96
	spc_tracknote	$93
	spc_tracknote	$96
	spc_trackgate	$06,$7c
	spc_tracknote	$98
	spc_trackgate	$06,$7d
	spc_tracknote	$96
	spc_trackgate	$06,$7c
	spc_tracknote	$98
	spc_tracknote	$9b
	spc_tracknote	$98
	spc_tracknote	$9b
	spc_tracknote	$9d
	spc_tracknote	$9b
	spc_tracknote	$9d
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9f
	spc_tracknote	$a2
	spc_trackgate	$30,$2f
	spc_tracknote	$8c
	spc_musicpitchslide	$0c,$0d,$87
spc_music_cbbc
	spc_musictrackvolume	$ff
	spc_musicinstrument	$01
	spc_musicfinetuning	$19
	spc_musicpan	$0d
	spc_tracktime	$01
	spc_tracknote	$c9
	spc_trackgate	$06,$7e
	spc_tracknote	$a4
	spc_tracknote	$a2
	spc_tracknote	$9f
	spc_trackgate	$0d,$3e
	spc_tracknote	$9d
	spc_tracktime	$02
	spc_tracknote	$c9
	spc_trackgate	$06,$7e
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9b
	spc_trackgate	$0d,$3e
	spc_tracknote	$98
	spc_tracktime	$02
	spc_tracknote	$c9
	spc_trackgate	$06,$7e
	spc_tracknote	$a4
	spc_tracknote	$a2
	spc_tracknote	$9f
	spc_trackgate	$06,$7f
	spc_tracknote	$a2
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9b
	spc_tracknote	$9d
	spc_tracknote	$9b
	spc_tracknote	$98
	spc_tracknote	$a7
	spc_tracknote	$a4
	spc_tracknote	$a2
	spc_tracknote	$a4
	spc_tracknote	$a2
	spc_tracknote	$9f
	spc_tracknote	$a2
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9b
	spc_tracktime	$18
	spc_tracknote	$a8
	spc_musicpitchslide	$11,$07,$9f
	spc_tracktime	$17
	spc_tracknote	$c9
spc_music_cbfe
	spc_musictrackvolume	$ff
	spc_musicpan	$0b
	spc_trackgate	$06,$7b
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$78
	spc_tracknote	$cb
	spc_trackgate	$0f,$7b
	spc_tracknote	$cb
	spc_tracktime	$06
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$78
	spc_tracknote	$cb
	spc_trackgate	$0f,$7b
	spc_tracknote	$cb
	spc_musicpan	$0d
	spc_trackgate	$36,$79
	spc_tracknote	$ce
	spc_musicpan	$0b
	spc_trackgate	$06,$7b
	spc_tracknote	$cb
	spc_trackgate	$06,$75
	spc_tracknote	$cb
	spc_trackgate	$06,$78
	spc_tracknote	$cb
	spc_musicinstrument	$cd
	spc_musicpan	$06
	spc_trackgate	$06,$7c
	spc_tracknote	$a4
	spc_trackgate	$06,$79
	spc_tracknote	$a4
	spc_trackgate	$06,$77
	spc_tracknote	$a4
	spc_musicpan	$0e
	spc_trackgate	$06,$7d
	spc_tracknote	$a1
	spc_trackgate	$06,$7a
	spc_tracknote	$a1
	spc_trackgate	$06,$78
	spc_tracknote	$a1
	spc_musicpan	$10
	spc_trackgate	$06,$7d
	spc_tracknote	$9d
	spc_trackgate	$06,$7a
	spc_tracknote	$9d
	spc_trackgate	$06,$78
	spc_tracknote	$9d
	spc_musicpan	$12
	spc_trackgate	$06,$7c
	spc_tracknote	$9a
	spc_trackgate	$06,$7a
	spc_tracknote	$9a
	spc_trackgate	$06,$77
	spc_tracknote	$9a
	spc_musicpan	$08
	spc_trackgate	$30,$7f
	spc_tracknote	$ce
spc_music_cc5c
	spc_musictrackvolume	$ff
	spc_musicinstrument	$01
	spc_musicfinetuning	$19
	spc_musicpan	$07
	spc_musictrackvolumeramp	$43,$78
	spc_trackgate	$43,$1b
	spc_tracknote	$a4
	spc_musicpitchslide	$06,$12,$98
	spc_tracktime	$24
	spc_tracknote	$c9
	spc_musictrackvolume	$ff
	spc_trackgate	$06,$5e
	spc_tracknote	$b3
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_tracknote	$ab
	spc_tracknote	$ae
	spc_tracknote	$ab
	spc_tracknote	$a9
	spc_tracknote	$ab
	spc_tracknote	$a9
	spc_tracknote	$a7
	spc_tracknote	$a9
	spc_tracknote	$a7
	spc_tracknote	$a4
	spc_tracknote	$a7
	spc_tracknote	$a4
	spc_tracknote	$a2
	spc_trackgate	$18,$7a
	spc_tracknote	$a4
	spc_musicpitchslide	$11,$07,$9c
	spc_tracktime	$17
	spc_tracknote	$c9
spc_music_cc8f
	spc_musictrackvolume	$ff
	spc_musicinstrument	$01
	spc_musicfinetuning	$19
	spc_musicpan	$10
	spc_musictrackvolumeramp	$43,$78
	spc_trackgate	$43,$1b
	spc_tracknote	$b0
	spc_musicpitchslide	$06,$12,$a4
	spc_tracktime	$24
	spc_tracknote	$c9
	spc_musictrackvolume	$ff
	spc_trackgate	$06,$7e
	spc_tracknote	$a7
	spc_tracknote	$a4
	spc_tracknote	$a2
	spc_tracknote	$a4
	spc_tracknote	$a2
	spc_tracknote	$9f
	spc_tracknote	$a2
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9f
	spc_tracknote	$9d
	spc_tracknote	$9b
	spc_tracknote	$9d
	spc_tracknote	$9b
	spc_tracknote	$98
	spc_tracknote	$b3
	spc_tracknote	$b0
	spc_tracknote	$ae
	spc_trackgate	$18,$7a
	spc_tracknote	$ab
	spc_musicpitchslide	$11,$07,$a3
	spc_tracktime	$17
	spc_tracknote	$c9
	spc_trackend
	spc_endblock	$01b3

	spc_block	spc_noiseblock,$edf0,$0050

; Set generated BRR headers and directory slot $23; ensure a nonzero PRNG.
spc_edf0
	spc_mov_y_i	$00
	spc_mov_x_i	$1b
spc_edf4
	spc_mov_abs_y_a	$ff00
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_inc_y
	spc_dec_x
	spc_bne	spc_edf4
	spc_inc_a
	spc_mov_abs_y_a	$ff00
	spc_mov_y_i	$ff
	spc_mov_a_i	$00
	spc_mov_abs_a	$3f8c
	spc_mov_abs_y	$3f8d
	spc_mov_abs_a	$3f8e
	spc_mov_abs_y	$3f8f
	spc_mov_a_dp	$18
	spc_or_a_dp	$19
	spc_bne	spc_ee1f
	spc_inc_dp	$18
spc_ee1f
	spc_ret

; Nearby pitch offsets and left/right volume pairs.
spc_nearpitches
	dw	$02ee,$06d6,$08ca,$09c4
	dw	$0a28,$0a5a,$0a8c,$0abe
spc_nearvolumes
	db	$78,$14,$8c,$28,$a0,$3c,$b4,$50
	db	$c8,$64,$dc,$78,$f0,$8c,$dc,$a0
	spc_endblock	$0050
