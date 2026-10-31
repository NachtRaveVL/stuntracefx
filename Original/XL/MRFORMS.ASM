; Retail frontend HDMA recipes, sprite forms and animation sequences.
; Sprite coordinates are signed words; attribute and size words are native.
; Form and animation IDs remain byte offsets, with zero reserved.
	incpublics mrforms.ext
mrforms_begin
retail_fronttables
	db $37
	db $00
	db $00
	db $1d
	db $00
	db $00
	db $01
	db $00
	db $01
	db $1c
	db $00
	db $00
	db $00
	db $37
	dw race_frontclipbottom
	db $1d
	dw race_frontcliptop
	db $01
	dw race_frontwindowy0
	db $1c
	dw race_frontwindowy1
	db $20
	dw race_frontclipbottom
	db $00
	db $37
	db $03
	db $1d
	db $03
	db $01
	db $13
	db $1c
	db $13
	db $01
	db $01
	db $00
	db $37
	db $00
	db $1d
	db $00
	db $01
	db $00
	db $1c
	db $ff
	db $01
	db $00
	db $00
	db $37
	db $00
	db $1d
	db $00
	db $33
	db $00
	db $32
	db $00
	db $1c
	db $ff
	db $01
	db $00
	db $00
	db $7f
	db $17
	db $01
	db $15
	db $00
	db $3c
	db $16
	db $01
	db $17
	db $00
	db $7f
	db $17
	db $01
	db $16
	db $00
	db $77
	db $ff
	db $00
	db $01
	db $30
	db $d0
	db $02
	db $2e
	db $d2
	db $1c
	db $2d
	db $d3
	db $02
	db $2e
	db $d2
	db $01
	db $30
	db $d0
	db $01
	db $ff
	db $00
	db $00
	db $40
	dw race_frontscroll0
	db $01
	dw race_frontscroll1
	db $00
	db $5f
	db $30
	db $58
	db $20
	db $01
	db $30
	db $00
	db $5f
	db $00
	db $02
	db $03
	db $54
	db $00
	db $02
	db $03
	db $01
	db $00
	db $00
	db $01
	db $ff
	db $00
retail_fronttables_end
retail_spriteforms
	dw 0 ; native zero-ID reservation
rff_form0002
	dw 18-1
	dw 17,0,$36c0,0
	dw 26,0,$36c0,0
	dw -1,0,$36bf,0
	dw 35,0,$36c1,0
	dw 8,0,$36c1,0
	dw -16,0,$36c0,0
	dw -25,0,$36bf,0
	dw -34,0,$36be,0
	dw -43,0,$36bd,0
	dw 35,-8,$36ba,0
	dw 26,-8,$36bc,0
	dw 17,-8,$36bb,0
	dw 8,-8,$36ba,0
	dw -1,-8,$36b8,0
	dw -16,-8,$36b9,0
	dw -25,-8,$36b8,0
	dw -34,-8,$36b7,0
	dw -43,-8,$36b6,0
rff_form0094
	dw 1-1
	dw -43,-8,$3000,0
rff_form009e
	dw 24-1
	dw 40,0,$3ad9,0
	dw 32,0,$3ad8,0
	dw 24,0,$3ad7,0
	dw 16,0,$3ad6,0
	dw 8,0,$3ad5,0
	dw 0,0,$3ad4,0
	dw -8,0,$3ad3,0
	dw -16,0,$3ad2,0
	dw -24,0,$3ad1,0
	dw -32,0,$3ad0,0
	dw -40,0,$3acf,0
	dw -48,0,$3ace,0
	dw 40,-8,$3acd,0
	dw 32,-8,$3acc,0
	dw 24,-8,$3acb,0
	dw 16,-8,$3aca,0
	dw 8,-8,$3ac9,0
	dw 0,-8,$3ac8,0
	dw -8,-8,$3ac7,0
	dw -16,-8,$3ac6,0
	dw -24,-8,$3ac5,0
	dw -32,-8,$3ac4,0
	dw -40,-8,$3ac3,0
	dw -48,-8,$3ac2,0
rff_form0160
	dw 16-1
	dw 24,0,$3a0f,0
	dw 16,0,$3a0e,0
	dw 8,0,$3a0d,0
	dw 0,0,$3a0c,0
	dw -8,0,$3a0b,0
	dw -16,0,$3a0a,0
	dw -24,0,$3a09,0
	dw -32,0,$3a08,0
	dw 24,-8,$3a07,0
	dw 16,-8,$3a06,0
	dw 8,-8,$3a05,0
	dw 0,-8,$3a04,0
	dw -8,-8,$3a03,0
	dw -16,-8,$3a02,0
	dw -24,-8,$3a01,0
	dw -32,-8,$3a00,0
rff_form01e2
	dw 44-1
	dw 89,5,$3a34,0
	dw -9,5,$361a,0
	dw 81,5,$362b,0
	dw 73,5,$361e,0
	dw 65,5,$3625,0
	dw 57,5,$3625,0
	dw 49,5,$3628,0
	dw 41,5,$362b,0
	dw 33,5,$362d,0
	dw 25,5,$3627,0
	dw 17,5,$3628,0
	dw 9,5,$361c,0
	dw -65,5,$3632,0
	dw -72,5,$3625,0
	dw -80,5,$3627,0
	dw -88,5,$3628,0
	dw -26,5,$3621,0
	dw -34,5,$362d,0
	dw -41,5,$3622,0
	dw -48,5,$3630,0
	dw 101,-13,$3a32,0
	dw 93,-13,$3a1a,0
	dw 85,-13,$3a25,0
	dw 77,-13,$3a29,0
	dw 63,-13,$3a28,0
	dw 55,-13,$3a2d,0
	dw 42,-13,$3a1d,0
	dw 34,-13,$3a1e,0
	dw 26,-13,$3a27,0
	dw 18,-13,$3a20,0
	dw 11,-13,$3a22,0
	dw 4,-13,$3a2c,0
	dw -4,-13,$3a1e,0
	dw -12,-13,$3a1d,0
	dw -27,-13,$3a2c,0
	dw -34,-13,$3a22,0
	dw -46,-13,$3a1e,0
	dw -54,-13,$3a26,0
	dw -62,-13,$3a1a,0
	dw -70,-13,$3a20,0
	dw -84,-13,$3a2c,0
	dw -91,-13,$3a22,0
	dw -98,-13,$3a21,0
	dw -106,-13,$3a2d,0
rff_form0344
	dw 54-1
	dw -11,-4,$3a1d,0
	dw -19,-4,$3a1e,0
	dw -27,-4,$3a27,0
	dw -35,-4,$3a20,0
	dw -42,-4,$3a22,0
	dw -49,-4,$3a2c,0
	dw -57,-4,$3a1e,0
	dw -65,-4,$3a1d,0
	dw 91,13,$3a2c,0
	dw 83,13,$3a1e,0
	dw 75,13,$3a27,0
	dw 99,13,$3a34,0
	dw 61,13,$3a2b,0
	dw 53,13,$3a1e,0
	dw 45,13,$3a29,0
	dw 37,13,$3a2e,0
	dw 29,13,$3a2c,0
	dw 15,13,$3a2b,0
	dw 7,13,$3a28,0
	dw -7,13,$3a26,0
	dw -15,13,$3a28,0
	dw -23,13,$3a1c,0
	dw -30,13,$3a22,0
	dw -37,13,$3a26,0
	dw -45,13,$3a1a,0
	dw -53,13,$3a1f,0
	dw -99,13,$3a2c,0
	dw -67,13,$3a2b,0
	dw -75,13,$3a1e,0
	dw -83,13,$3a29,0
	dw -91,13,$3a2e,0
	dw 57,-4,$3a2b,0
	dw 49,-4,$3a2e,0
	dw 41,-4,$3a28,0
	dw 33,-4,$3a32,0
	dw 19,-4,$3a2b,0
	dw 11,-4,$3a28,0
	dw 3,-4,$3a1f,0
	dw -53,-21,$3a2c,0
	dw -60,-21,$3a22,0
	dw -67,-21,$3a21,0
	dw -75,-21,$3a2d,0
	dw 66,-21,$3a2d,0
	dw 58,-21,$3a28,0
	dw 50,-21,$3a27,0
	dw 36,-21,$3a2c,0
	dw 29,-21,$3a22,0
	dw 15,-21,$3a24,0
	dw 7,-21,$3a1a,0
	dw -1,-21,$3a29,0
	dw -15,-21,$3a1e,0
	dw -23,-21,$3a26,0
	dw -31,-21,$3a1a,0
	dw -39,-21,$3a20,0
rff_form04f6
	dw 16-1
	dw 59,-4,$3a34,0
	dw 51,-4,$3a1d,0
	dw 43,-4,$3a2d,0
	dw 36,-4,$3a25,0
	dw 27,-2,$3a35,0
	dw 23,-4,$3a34,0
	dw 15,-4,$3a28,0
	dw 7,-4,$3a1c,0
	dw -15,-4,$3a1d,0
	dw -7,-4,$3a28,0
	dw -23,-4,$3a27,0
	dw -31,-4,$3a1e,0
	dw -39,-4,$3a2d,0
	dw -47,-4,$3a27,0
	dw -54,-4,$3a22,0
	dw -61,-4,$3a27,0
rff_form0578
	dw 38-1
	dw 96,120,$3a64,1
	dw 96,0,$3a61,1
	dw 80,0,$3a61,1
	dw 64,0,$3a61,1
	dw 48,0,$3a61,1
	dw 32,0,$3a61,1
	dw 16,0,$3a61,1
	dw 16,16,$3a69,1
	dw 96,104,$3a67,1
	dw 80,104,$3a67,1
	dw 64,104,$3a67,1
	dw 48,104,$3a67,1
	dw 32,104,$3a67,1
	dw 0,120,$3a63,1
	dw 16,104,$3a66,1
	dw 0,104,$3a6c,1
	dw 16,96,$3a6e,1
	dw 0,96,$3a6c,1
	dw 16,80,$3a6e,1
	dw 0,80,$3a6c,1
	dw 16,64,$3a6e,1
	dw 0,64,$3a6c,1
	dw 16,48,$3a6e,1
	dw 0,48,$3a6c,1
	dw 0,16,$3a6c,1
	dw 16,32,$3a6e,1
	dw 0,32,$3a6c,1
	dw 96,16,$3a6a,1
	dw 80,16,$3a6a,1
	dw 64,16,$3a6a,1
	dw 48,16,$3a6a,1
	dw 32,16,$3a6a,1
	dw 32,120,$3a64,1
	dw 16,120,$3a64,1
	dw 80,120,$3a64,1
	dw 64,120,$3a64,1
	dw 48,120,$3a64,1
	dw 0,0,$3a60,1
rff_form06aa
	dw 22-1
	dw -8,40,$3bfa,0
	dw -16,40,$3bf9,0
	dw -8,32,$3bea,0
	dw -16,32,$3be9,0
	dw -24,40,$3bf8,0
	dw -24,32,$3be8,0
	dw -8,0,$3a35,0
	dw -8,-8,$3a25,0
	dw 8,0,$3a50,0
	dw 8,-8,$3a40,0
	dw 0,0,$3a38,0
	dw 0,-8,$3a28,0
	dw -16,0,$3a3c,0
	dw -16,-8,$3a2c,0
	dw 8,-40,$3a34,0
	dw 8,-48,$3a24,0
	dw 0,-40,$3a1a,0
	dw 0,-48,$3a0a,0
	dw -8,-40,$3a1e,0
	dw -8,-48,$3a0e,0
	dw -16,-40,$3a50,0
	dw -16,-48,$3a40,0
rff_form075c
	dw 30-1
	dw -8,40,$3a10,0
	dw -8,32,$3a00,0
	dw -16,40,$3a12,0
	dw -24,40,$3a11,0
	dw -16,32,$3a02,0
	dw -24,32,$3a01,0
	dw 16,0,$3a36,0
	dw 16,-8,$3a26,0
	dw 8,0,$3a3e,0
	dw 8,-8,$3a2e,0
	dw 0,0,$3a32,0
	dw 0,-8,$3a22,0
	dw -8,0,$3a1d,0
	dw -8,-8,$3a0d,0
	dw -16,0,$3a1e,0
	dw -16,-8,$3a0e,0
	dw -24,0,$3a36,0
	dw -24,-8,$3a26,0
	dw 16,-40,$3a36,0
	dw 16,-48,$3a26,0
	dw 8,-40,$3a3e,0
	dw 8,-48,$3a2e,0
	dw 0,-40,$3a32,0
	dw 0,-48,$3a22,0
	dw -8,-40,$3a1d,0
	dw -8,-48,$3a0d,0
	dw -16,-40,$3a1e,0
	dw -16,-48,$3a0e,0
	dw -24,-40,$3a36,0
	dw -24,-48,$3a26,0
rff_form084e
	dw 26-1
	dw -8,40,$3a10,0
	dw -8,32,$3a00,0
	dw -16,40,$3a10,0
	dw -16,32,$3a00,0
	dw -24,40,$3a11,0
	dw -24,32,$3a01,0
	dw 16,-40,$3bf5,0
	dw 8,-40,$3bf4,0
	dw 0,-40,$3bf3,0
	dw -8,-40,$3bf2,0
	dw -16,-40,$3bf1,0
	dw -24,-40,$3bf0,0
	dw 16,-48,$3be5,0
	dw 8,-48,$3be4,0
	dw 0,-48,$3be3,0
	dw -8,-48,$3be2,0
	dw -16,-48,$3be1,0
	dw -24,-48,$3be0,0
	dw 8,0,$3bf1,0
	dw 0,0,$3bf0,0
	dw 8,-8,$3be1,0
	dw 0,-8,$3be0,0
	dw -8,0,$3bf7,0
	dw -16,0,$3bf6,0
	dw -8,-8,$3be7,0
	dw -16,-8,$3be6,0
rff_form0920
	dw 26-1
	dw -8,40,$3bfa,0
	dw -16,40,$3bf9,0
	dw -24,40,$3bf8,0
	dw -8,32,$3bea,0
	dw -16,32,$3be9,0
	dw -24,32,$3be8,0
	dw 8,0,$3bf1,0
	dw 0,0,$3bf0,0
	dw 8,-8,$3be1,0
	dw 0,-8,$3be0,0
	dw -8,0,$3bf7,0
	dw -16,0,$3bf6,0
	dw -8,-8,$3be7,0
	dw -16,-8,$3be6,0
	dw 16,-40,$3a36,0
	dw 16,-48,$3a26,0
	dw 8,-40,$3a3e,0
	dw 8,-48,$3a2e,0
	dw 0,-40,$3a32,0
	dw 0,-48,$3a22,0
	dw -8,-40,$3a1d,0
	dw -8,-48,$3a0d,0
	dw -16,-40,$3a1e,0
	dw -16,-48,$3a0e,0
	dw -24,-40,$3a36,0
	dw -24,-48,$3a26,0
rff_form09f2
	dw 32-1
	dw 21,4,$b64d,1
	dw 37,4,$b64e,1
	dw 5,4,$b64c,1
	dw 21,-11,$364d,1
	dw 37,-11,$364e,1
	dw 5,-11,$364c,1
	dw 48,34,$321e,0
	dw 48,26,$320e,0
	dw 40,34,$3236,0
	dw 40,26,$3226,0
	dw 32,34,$321a,0
	dw 32,26,$320a,0
	dw 24,34,$3237,0
	dw 24,26,$3227,0
	dw 12,34,$323b,0
	dw 12,26,$322b,0
	dw 4,34,$323e,0
	dw 4,26,$322e,0
	dw -4,34,$3238,0
	dw -4,26,$3228,0
	dw -12,34,$3252,0
	dw -12,26,$3242,0
	dw -24,34,$323d,0
	dw -24,26,$322d,0
	dw -32,34,$323e,0
	dw -32,26,$322e,0
	dw -40,34,$3239,0
	dw -40,26,$3229,0
	dw -48,34,$3237,0
	dw -48,26,$3227,0
	dw -56,34,$3232,0
	dw -56,26,$3222,0
rff_form0af4
	dw 6-1
	dw 5,0,$3a1a,0
	dw 5,-8,$3a0a,0
	dw -4,0,$3a1a,0
	dw -4,-8,$3a0a,0
	dw -13,0,$3a1a,0
	dw -13,-8,$3a0a,0
rff_form0b26
	dw 28-1
	dw 42,0,$3238,0
	dw 42,-8,$3228,0
	dw 34,0,$3232,0
	dw 34,-8,$3222,0
	dw 26,0,$323d,0
	dw 26,-8,$322d,0
	dw 18,0,$321c,0
	dw 18,-8,$320c,0
	dw 2,0,$3235,0
	dw 2,-8,$3225,0
	dw -14,0,$323c,0
	dw -14,-8,$322c,0
	dw -26,0,$3252,0
	dw -26,-8,$3242,0
	dw 50,0,$3237,0
	dw 50,-8,$3227,0
	dw -50,0,$3237,0
	dw -50,-8,$3227,0
	dw -34,0,$3236,0
	dw -34,-8,$3226,0
	dw 10,0,$321e,0
	dw 10,-8,$320e,0
	dw -6,0,$321e,0
	dw -6,-8,$320e,0
	dw -42,0,$321e,0
	dw -42,-8,$320e,0
	dw -58,0,$321e,0
	dw -58,-8,$320e,0
rff_form0c08
	dw 12-1
	dw 0,16,$f657,0
	dw -8,16,$b657,0
	dw 0,-24,$7657,0
	dw -8,-24,$3657,0
	dw 16,0,$f647,0
	dw 16,-8,$7647,0
	dw -24,0,$b647,0
	dw -24,-8,$3647,0
	dw 0,0,$f648,1
	dw 0,-16,$7648,1
	dw -16,0,$b648,1
	dw -16,-16,$3648,1
rff_form0c6a
	dw 4-1
	dw 0,0,$f648,1
	dw 0,-16,$7648,1
	dw -16,0,$b648,1
	dw -16,-16,$3648,1
rff_form0c8c
	dw 10-1
	dw 0,16,$f657,0
	dw -8,16,$b657,0
	dw 0,-24,$7657,0
	dw -8,-24,$3657,0
	dw 16,0,$f647,0
	dw 16,-8,$7647,0
	dw 0,0,$f648,1
	dw 0,-16,$7648,1
	dw -16,0,$b648,1
	dw -16,-16,$3648,1
rff_form0cde
	dw 10-1
	dw 0,16,$f657,0
	dw -8,16,$b657,0
	dw 0,-24,$7657,0
	dw -8,-24,$3657,0
	dw -24,0,$b647,0
	dw -24,-8,$3647,0
	dw 0,0,$f648,1
	dw 0,-16,$7648,1
	dw -16,0,$b648,1
	dw -16,-16,$3648,1
rff_form0d30
	dw 4-1
	dw 0,0,$36a2,1
	dw -16,0,$36a0,1
	dw 0,-16,$3682,1
	dw -16,-16,$3680,1
rff_form0d52
	dw 4-1
	dw 0,0,$36a6,1
	dw -16,0,$36a4,1
	dw 0,-16,$3686,1
	dw -16,-16,$3684,1
rff_form0d74
	dw 4-1
	dw 0,0,$36aa,1
	dw -16,0,$36a8,1
	dw 0,-16,$368a,1
	dw -16,-16,$3688,1
rff_form0d96
	dw 14-1
	dw 22,0,$3611,0
	dw 22,-8,$3601,0
	dw 10,0,$3a3b,0
	dw 10,-8,$3a2b,0
	dw 2,0,$3a1e,0
	dw 2,-8,$3a0e,0
	dw -6,0,$3a52,0
	dw -6,-8,$3a42,0
	dw -14,0,$3a1a,0
	dw -14,-8,$3a0a,0
	dw -22,0,$3a35,0
	dw -22,-8,$3a25,0
	dw -30,0,$3a39,0
	dw -30,-8,$3a29,0
rff_form0e08
	dw 14-1
	dw 22,0,$3612,0
	dw 22,-8,$3602,0
	dw 10,0,$3a3b,0
	dw 10,-8,$3a2b,0
	dw 2,0,$3a1e,0
	dw 2,-8,$3a0e,0
	dw -6,0,$3a52,0
	dw -6,-8,$3a42,0
	dw -14,0,$3a1a,0
	dw -14,-8,$3a0a,0
	dw -22,0,$3a35,0
	dw -22,-8,$3a25,0
	dw -30,0,$3a39,0
	dw -30,-8,$3a29,0
rff_form0e7a
	dw 12-1
	dw 16,0,$321e,0
	dw 16,-8,$320e,0
	dw 8,0,$3239,0
	dw 8,-8,$3229,0
	dw 0,0,$3252,0
	dw 0,-8,$3242,0
	dw -8,0,$323d,0
	dw -8,-8,$322d,0
	dw -16,0,$3254,0
	dw -16,-8,$3244,0
	dw -24,0,$321f,0
	dw -24,-8,$320f,0
rff_form0edc
	dw 11-1
	dw 12,-12,$3246,0
	dw 12,0,$321e,0
	dw 12,-8,$320e,0
	dw 4,0,$3239,0
	dw 4,-8,$3229,0
	dw -4,0,$323e,0
	dw -4,-8,$322e,0
	dw -12,0,$3238,0
	dw -12,-8,$3228,0
	dw -20,0,$321c,0
	dw -20,-8,$320c,0
rff_form0f36
	dw 6-1
	dw 8,0,$321d,0
	dw 8,-8,$320d,0
	dw -4,0,$3250,0
	dw -4,-8,$3240,0
	dw -16,0,$3214,0
	dw -16,-8,$3204,0
rff_form0f68
	dw 6-1
	dw -16,0,$3212,0
	dw -16,-8,$3202,0
	dw 8,0,$321d,0
	dw 8,-8,$320d,0
	dw -4,0,$3250,0
	dw -4,-8,$3240,0
rff_form0f9a
	dw 2-1
	dw -9,0,$f64a,1
	dw -9,-16,$764a,1
rff_form0fac
	dw 2-1
	dw -9,0,$f24a,1
	dw -9,-16,$724a,1
rff_form0fbe
	dw 2-1
	dw -7,0,$b64a,1
	dw -7,-16,$364a,1
rff_form0fd0
	dw 2-1
	dw -7,0,$b24a,1
	dw -7,-16,$324a,1
rff_form0fe2
	dw 1-1
	dw -30,-8,$3188,0
rff_form0fec
	dw 1-1
	dw -30,-8,$3188,0
rff_form0ff6
	dw 9-1
	dw -80,-8,$3b00,1
	dw -64,-8,$3b02,1
	dw -48,-8,$3b04,1
	dw -32,-8,$3b06,1
	dw -16,-8,$3b08,1
	dw 16,-8,$3b0a,1
	dw 32,-8,$3b0c,1
	dw 48,-8,$3b0e,1
	dw 64,-8,$3b20,1
rff_form1040
	dw 9-1
	dw -80,-8,$3322,1
	dw -64,-8,$3324,1
	dw -48,-8,$3326,1
	dw -32,-8,$3328,1
	dw -16,-8,$332a,1
	dw 16,-8,$332c,1
	dw 32,-8,$332e,1
	dw 48,-8,$3340,1
	dw 64,-8,$3342,1
rff_form108a
	dw 10-1
	dw -88,-8,$3344,1
	dw -72,-8,$3346,1
	dw -56,-8,$3348,1
	dw -40,-8,$334a,1
	dw -24,-8,$334c,1
	dw -8,-8,$334e,1
	dw 24,-8,$3360,1
	dw 40,-8,$3362,1
	dw 56,-8,$3364,1
	dw 72,-8,$3366,1
rff_form10dc
	dw 8-1
	dw -72,-8,$3368,1
	dw -56,-8,$336a,1
	dw -40,-8,$336c,1
	dw -24,-8,$336e,1
	dw 8,-8,$3380,1
	dw 24,-8,$3382,1
	dw 40,-8,$3384,1
	dw 56,-8,$3386,1
rff_form111e
	dw 7-1
	dw -64,-8,$3368,1
	dw -48,-8,$336a,1
	dw -32,-8,$336c,1
	dw -16,-8,$336e,1
	dw 16,-8,$3380,1
	dw 32,-8,$3382,1
	dw 48,-8,$3384,1
rff_form1158
	dw 4-1
	dw 0,0,$36a2,1
	dw -16,0,$36a0,1
	dw 0,-16,$3682,1
	dw -16,-16,$3680,1
rff_form117a
	dw 4-1
	dw 0,0,$36a6,1
	dw -16,0,$36a4,1
	dw 0,-16,$3686,1
	dw -16,-16,$3684,1
rff_form119c
	dw 4-1
	dw 0,0,$36aa,1
	dw -16,0,$36a8,1
	dw 0,-16,$368a,1
	dw -16,-16,$3688,1
rff_form11be
	dw 4-1
	dw 0,0,$36ae,1
	dw -16,0,$36ac,1
	dw 0,-16,$368e,1
	dw -16,-16,$368c,1
rff_form11e0
	dw 4-1
	dw 0,0,$36e2,1
	dw -16,0,$36e0,1
	dw 0,-16,$36c2,1
	dw -16,-16,$36c0,1
rff_form1202
	dw 4-1
	dw 0,0,$36e6,1
	dw -16,0,$36e4,1
	dw 0,-16,$36c6,1
	dw -16,-16,$36c4,1
rff_form1224
	dw 4-1
	dw 0,0,$36ea,1
	dw -16,0,$36e8,1
	dw 0,-16,$36ca,1
	dw -16,-16,$36c8,1
rff_form1246
	dw 4-1
	dw 0,0,$36ee,1
	dw -16,0,$36ec,1
	dw 0,-16,$36ce,1
	dw -16,-16,$36cc,1
rff_form1268
	dw 4-1
	dw 0,0,$37c2,1
	dw -16,0,$37c0,1
	dw 0,-16,$37a2,1
	dw -16,-16,$37a0,1
rff_form128a
	dw 4-1
	dw 0,0,$37c6,1
	dw -16,0,$37c4,1
	dw 0,-16,$37a6,1
	dw -16,-16,$37a4,1
rff_form12ac
	dw 4-1
	dw 0,0,$37ca,1
	dw -16,0,$37c8,1
	dw 0,-16,$37aa,1
	dw -16,-16,$37a8,1
rff_form12ce
	dw 4-1
	dw 0,0,$37ce,1
	dw -16,0,$37cc,1
	dw 0,-16,$37ae,1
	dw -16,-16,$37ac,1
rff_form12f0
	dw 22-1
	dw 65,-12,$3b36,0
	dw -41,4,$3b38,0
	dw 23,4,$3728,0
	dw 15,4,$3727,0
	dw -15,4,$3b2c,0
	dw -23,4,$3b1e,0
	dw -31,4,$3b32,0
	dw 51,-12,$3b2c,0
	dw 43,-12,$3b1d,0
	dw 35,-12,$3b2b,0
	dw 27,-12,$3b28,0
	dw 19,-12,$3b1c,0
	dw 11,-12,$3b1e,0
	dw 3,-12,$3b2b,0
	dw -11,-12,$3b25,0
	dw -19,-12,$3b25,0
	dw -27,-12,$3b1a,0
	dw -41,-12,$3b2b,0
	dw -49,-12,$3b1a,0
	dw -57,-12,$3b1e,0
	dw -65,-12,$3b25,0
	dw -73,-12,$3b1c,0
rff_form13a2
	dw 21-1
	dw 65,-12,$3b36,0
	dw 23,4,$3728,0
	dw 15,4,$3727,0
	dw -15,4,$3b2c,0
	dw -23,4,$3b1e,0
	dw -31,4,$3b32,0
	dw 51,-12,$3b2c,0
	dw 43,-12,$3b1d,0
	dw 35,-12,$3b2b,0
	dw 27,-12,$3b28,0
	dw 19,-12,$3b1c,0
	dw 11,-12,$3b1e,0
	dw 3,-12,$3b2b,0
	dw -11,-12,$3b25,0
	dw -19,-12,$3b25,0
	dw -27,-12,$3b1a,0
	dw -41,-12,$3b2b,0
	dw -49,-12,$3b1a,0
	dw -57,-12,$3b1e,0
	dw -65,-12,$3b25,0
	dw -73,-12,$3b1c,0
rff_form144c
	dw 21-1
	dw 65,-12,$3b36,0
	dw 23,4,$3b28,0
	dw 15,4,$3b27,0
	dw -15,4,$372c,0
	dw -23,4,$371e,0
	dw -31,4,$3732,0
	dw 51,-12,$3b2c,0
	dw 43,-12,$3b1d,0
	dw 35,-12,$3b2b,0
	dw 27,-12,$3b28,0
	dw 19,-12,$3b1c,0
	dw 11,-12,$3b1e,0
	dw 3,-12,$3b2b,0
	dw -11,-12,$3b25,0
	dw -19,-12,$3b25,0
	dw -27,-12,$3b1a,0
	dw -41,-12,$3b2b,0
	dw -49,-12,$3b1a,0
	dw -57,-12,$3b1e,0
	dw -65,-12,$3b25,0
	dw -73,-12,$3b1c,0
rff_form14f6
	dw 22-1
	dw 5,4,$3b38,0
	dw 65,-12,$3b36,0
	dw 23,4,$3b28,0
	dw 15,4,$3b27,0
	dw -15,4,$372c,0
	dw -23,4,$371e,0
	dw -31,4,$3732,0
	dw 51,-12,$3b2c,0
	dw 43,-12,$3b1d,0
	dw 35,-12,$3b2b,0
	dw 27,-12,$3b28,0
	dw 19,-12,$3b1c,0
	dw 11,-12,$3b1e,0
	dw 3,-12,$3b2b,0
	dw -11,-12,$3b25,0
	dw -19,-12,$3b25,0
	dw -27,-12,$3b1a,0
	dw -41,-12,$3b2b,0
	dw -49,-12,$3b1a,0
	dw -57,-12,$3b1e,0
	dw -65,-12,$3b25,0
	dw -73,-12,$3b1c,0
rff_form15a8
	dw 17-1
	dw -41,4,$3b38,0
	dw 45,-12,$3b36,0
	dw 31,-12,$3b1e,0
	dw 23,-12,$3b2b,0
	dw 15,-12,$3b2e,0
	dw 7,-12,$3b2c,0
	dw -7,-12,$3b2e,0
	dw -15,-12,$3b28,0
	dw -23,-12,$3b32,0
	dw -37,-12,$3b1e,0
	dw -45,-12,$3b2b,0
	dw -53,-12,$3b1a,0
	dw 23,4,$3728,0
	dw 15,4,$3727,0
	dw -15,4,$3b2c,0
	dw -23,4,$3b1e,0
	dw -31,4,$3b32,0
rff_form1632
	dw 16-1
	dw 45,-12,$3b36,0
	dw 31,-12,$3b1e,0
	dw 23,-12,$3b2b,0
	dw 15,-12,$3b2e,0
	dw 7,-12,$3b2c,0
	dw -7,-12,$3b2e,0
	dw -15,-12,$3b28,0
	dw -23,-12,$3b32,0
	dw -37,-12,$3b1e,0
	dw -45,-12,$3b2b,0
	dw -53,-12,$3b1a,0
	dw 23,4,$3728,0
	dw 15,4,$3727,0
	dw -15,4,$3b2c,0
	dw -23,4,$3b1e,0
	dw -31,4,$3b32,0
rff_form16b4
	dw 17-1
	dw 5,4,$3b38,0
	dw 45,-12,$3b36,0
	dw 31,-12,$3b1e,0
	dw 23,-12,$3b2b,0
	dw 15,-12,$3b2e,0
	dw 7,-12,$3b2c,0
	dw -7,-12,$3b2e,0
	dw -15,-12,$3b28,0
	dw -23,-12,$3b32,0
	dw -37,-12,$3b1e,0
	dw -45,-12,$3b2b,0
	dw -53,-12,$3b1a,0
	dw 23,4,$3b28,0
	dw 15,4,$3b27,0
	dw -15,4,$372c,0
	dw -23,4,$371e,0
	dw -31,4,$3732,0
rff_form173e
	dw 16-1
	dw 45,-12,$3b36,0
	dw 31,-12,$3b1e,0
	dw 23,-12,$3b2b,0
	dw 15,-12,$3b2e,0
	dw 7,-12,$3b2c,0
	dw -7,-12,$3b2e,0
	dw -15,-12,$3b28,0
	dw -23,-12,$3b32,0
	dw -37,-12,$3b1e,0
	dw -45,-12,$3b2b,0
	dw -53,-12,$3b1a,0
	dw 23,4,$3b28,0
	dw 15,4,$3b27,0
	dw -15,4,$372c,0
	dw -23,4,$371e,0
	dw -31,4,$3732,0
rff_form17c0
	dw 4-1
	dw 0,-4,$3b27,0
	dw 8,-4,$3b1e,0
	dw -8,-4,$3b28,0
	dw -16,-4,$3b1d,0
rff_form17e2
	dw 7-1
	dw -28,-4,$3624,0
	dw -12,-4,$3624,0
	dw -4,-4,$3624,0
	dw 12,-4,$3624,0
	dw 20,-4,$3624,0
	dw 4,-4,$3627,0
	dw -20,-4,$3626,0
rff_form181c
	dw 9-1
	dw -4,-4,$320f,0
	dw -12,-4,$3218,0
	dw -23,-4,$321d,0
	dw -31,-4,$321e,0
	dw -39,-4,$3218,0
	dw 31,-4,$3214,0
	dw 23,-4,$3217,0
	dw 15,-4,$320a,0
	dw 7,-4,$321b,0
rff_form1866
	dw 9-1
	dw -4,-4,$360f,0
	dw -12,-4,$3618,0
	dw -23,-4,$361d,0
	dw -31,-4,$361e,0
	dw -39,-4,$3618,0
	dw 31,-4,$3614,0
	dw 23,-4,$3617,0
	dw 15,-4,$360a,0
	dw 7,-4,$361b,0
rff_form18b0
	dw 6-1
	dw 16,-4,$3211,0
	dw 8,-4,$321c,0
	dw 0,-4,$320a,0
	dw -8,-4,$3215,0
	dw -16,-4,$3219,0
	dw -24,-4,$321c,0
rff_form18e2
	dw 6-1
	dw 16,-4,$3611,0
	dw 8,-4,$361c,0
	dw 0,-4,$360a,0
	dw -8,-4,$3615,0
	dw -16,-4,$3619,0
	dw -24,-4,$361c,0
rff_form1914
	dw 5-1
	dw 12,-4,$3211,0
	dw 4,-4,$321c,0
	dw -4,-4,$320a,0
	dw -12,-4,$321b,0
	dw -20,-4,$320c,0
rff_form193e
	dw 5-1
	dw 12,-4,$3611,0
	dw 4,-4,$361c,0
	dw -4,-4,$360a,0
	dw -12,-4,$361b,0
	dw -20,-4,$360c,0
rff_form1968
	dw 6-1
	dw 18,-4,$3219,0
	dw 10,-4,$321e,0
	dw -2,-4,$320e,0
	dw -10,-4,$3216,0
	dw -18,-4,$3212,0
	dw -26,-4,$321d,0
rff_form199a
	dw 6-1
	dw 18,-4,$3619,0
	dw 10,-4,$361e,0
	dw -2,-4,$360e,0
	dw -10,-4,$3616,0
	dw -18,-4,$3612,0
	dw -26,-4,$361d,0
rff_form19cc
	dw 6-1
	dw 0,-4,$3212,0
	dw -8,-4,$321d,0
	dw 16,-4,$320e,0
	dw -16,-4,$320e,0
	dw 8,-4,$321b,0
	dw -24,-4,$321b,0
rff_form19fe
	dw 6-1
	dw 0,-4,$3612,0
	dw -8,-4,$361d,0
	dw 16,-4,$360e,0
	dw -16,-4,$360e,0
	dw 8,-4,$361b,0
	dw -24,-4,$361b,0
rff_form1a30
	dw 3-1
	dw -11,1,$3a38,0
	dw 0,1,$7a48,0
	dw -8,-8,$3a30,1
rff_form1a4a
	dw 3-1
	dw 0,1,$7a49,0
	dw -11,1,$3a39,0
	dw -8,-9,$3a30,1
rff_form1a64
	dw 3-1
	dw -11,1,$3a38,0
	dw 0,1,$7a48,0
	dw -8,-10,$3a30,1
rff_form1a7e
	dw 3-1
	dw 1,1,$7a39,0
	dw -10,1,$3a38,0
	dw -8,-8,$3a32,1
rff_form1a98
	dw 3-1
	dw 1,1,$7a38,0
	dw -10,1,$3a39,0
	dw -8,-9,$3a32,1
rff_form1ab2
	dw 3-1
	dw 1,1,$7a39,0
	dw -10,1,$3a38,0
	dw -8,-10,$3a32,1
rff_form1acc
	dw 3-1
	dw 1,1,$7a49,0
	dw -9,1,$3a48,0
	dw -8,-8,$3a34,1
rff_form1ae6
	dw 3-1
	dw -9,1,$3a49,0
	dw 1,1,$7a48,0
	dw -8,-9,$3a34,1
rff_form1b00
	dw 3-1
	dw 1,1,$7a49,0
	dw -9,1,$3a48,0
	dw -8,-10,$3a34,1
rff_form1b1a
	dw 3-1
	dw 1,1,$7a38,0
	dw -10,1,$3a48,0
	dw -8,-7,$3a36,1
rff_form1b34
	dw 3-1
	dw 1,1,$7a39,0
	dw -10,1,$3a49,0
	dw -8,-8,$3a36,1
rff_form1b4e
	dw 3-1
	dw 1,1,$7a38,0
	dw -10,1,$3a48,0
	dw -8,-9,$3a36,1
rff_form1b68
	dw 10-1
	dw 12,0,$3085,0
	dw 12,-8,$3075,0
	dw 4,0,$306a,0
	dw 4,-8,$305a,0
	dw -4,0,$308d,0
	dw -4,-8,$307d,0
	dw -12,0,$3088,0
	dw -12,-8,$3078,0
	dw -20,0,$308d,0
	dw -20,-8,$307d,0
rff_form1bba
	dw 2-1
	dw -4,0,$3461,0
	dw -4,-8,$3451,0
rff_form1bcc
	dw 2-1
	dw -4,0,$3262,0
	dw -4,-8,$3252,0
rff_form1bde
	dw 2-1
	dw -4,0,$3063,0
	dw -4,-8,$3053,0
rff_form1bf0
	dw 14-1
	dw -32,-8,$3450,0
	dw -32,0,$3460,0
	dw -24,-8,$3450,0
	dw -24,0,$3460,0
	dw -8,-8,$3450,0
	dw -8,0,$3460,0
	dw 0,-8,$3450,0
	dw 0,0,$3460,0
	dw 16,-8,$3450,0
	dw 16,0,$3460,0
	dw 24,-8,$3450,0
	dw 24,0,$3460,0
	dw -16,-8,$3496,0
	dw 8,-8,$3497,0
rff_form1c62
	dw 14-1
	dw -32,-8,$3250,0
	dw -32,0,$3260,0
	dw -24,-8,$3250,0
	dw -24,0,$3260,0
	dw -8,-8,$3250,0
	dw -8,0,$3260,0
	dw 0,-8,$3250,0
	dw 0,0,$3260,0
	dw 16,-8,$3250,0
	dw 16,0,$3260,0
	dw 24,-8,$3250,0
	dw 24,0,$3260,0
	dw -16,-8,$3296,0
	dw 8,-8,$3297,0
rff_form1cd4
	dw 14-1
	dw -32,-8,$3050,0
	dw -32,0,$3060,0
	dw -24,-8,$3050,0
	dw -24,0,$3060,0
	dw -8,-8,$3050,0
	dw -8,0,$3060,0
	dw 0,-8,$3050,0
	dw 0,0,$3060,0
	dw 16,-8,$3050,0
	dw 16,0,$3060,0
	dw 24,-8,$3050,0
	dw 24,0,$3060,0
	dw -16,-8,$3096,0
	dw 8,-8,$3097,0
rff_form1d46
	dw 14-1
	dw -32,-8,$3650,0
	dw -32,0,$3660,0
	dw -24,-8,$3650,0
	dw -24,0,$3660,0
	dw -8,-8,$3650,0
	dw -8,0,$3660,0
	dw 0,-8,$3650,0
	dw 0,0,$3660,0
	dw 16,-8,$3650,0
	dw 16,0,$3660,0
	dw 24,-8,$3650,0
	dw 24,0,$3660,0
	dw -16,-8,$3696,0
	dw 8,-8,$3697,0
rff_form1db8
	dw 6-1
	dw -12,-8,$345a,0
	dw -12,0,$346a,0
	dw -4,-8,$345a,0
	dw -4,0,$346a,0
	dw 4,-8,$345a,0
	dw 4,0,$346a,0
rff_form1dea
	dw 6-1
	dw -12,-8,$325a,0
	dw -12,0,$326a,0
	dw -4,-8,$325a,0
	dw -4,0,$326a,0
	dw 4,-8,$325a,0
	dw 4,0,$326a,0
rff_form1e1c
	dw 6-1
	dw -12,-8,$305a,0
	dw -12,0,$306a,0
	dw -4,-8,$305a,0
	dw -4,0,$306a,0
	dw 4,-8,$305a,0
	dw 4,0,$306a,0
rff_form1e4e
	dw 12-1
	dw 16,0,$346d,0
	dw 16,-8,$345d,0
	dw 8,0,$346e,0
	dw 8,-8,$345e,0
	dw 0,0,$3484,0
	dw 0,-8,$3474,0
	dw -8,0,$3487,0
	dw -8,-8,$3477,0
	dw -16,0,$346a,0
	dw -16,-8,$345a,0
	dw -24,0,$348b,0
	dw -24,-8,$347b,0
rff_form1eb0
	dw 12-1
	dw 16,0,$326d,0
	dw 16,-8,$325d,0
	dw 8,0,$326e,0
	dw 8,-8,$325e,0
	dw 0,0,$3284,0
	dw 0,-8,$3274,0
	dw -8,0,$3287,0
	dw -8,-8,$3277,0
	dw -16,0,$326a,0
	dw -16,-8,$325a,0
	dw -24,0,$328b,0
	dw -24,-8,$327b,0
rff_form1f12
	dw 12-1
	dw 16,0,$306d,0
	dw 16,-8,$305d,0
	dw 8,0,$306e,0
	dw 8,-8,$305e,0
	dw 0,0,$3084,0
	dw 0,-8,$3074,0
	dw -8,0,$3087,0
	dw -8,-8,$3077,0
	dw -16,0,$306a,0
	dw -16,-8,$305a,0
	dw -24,0,$308b,0
	dw -24,-8,$307b,0
rff_form1f74
	dw 6-1
	dw -12,0,$3661,0
	dw -12,-8,$3651,0
	dw 6,0,$36f3,0
	dw -2,0,$36f2,0
	dw 6,-8,$36e3,0
	dw -2,-8,$36e2,0
rff_form1fa6
	dw 6-1
	dw -12,0,$3662,0
	dw -12,-8,$3652,0
	dw 6,0,$36f5,0
	dw -2,0,$36f4,0
	dw 6,-8,$36e5,0
	dw -2,-8,$36e4,0
rff_form1fd8
	dw 6-1
	dw -12,0,$3663,0
	dw -12,-8,$3653,0
	dw 6,0,$36f5,0
	dw 6,-8,$36e5,0
	dw -2,0,$36f6,0
	dw -2,-8,$36e6,0
retail_spriteforms_end
retail_spriteanims
	dw 0 ; native zero-ID reservation
rff_anim0002
	dw 21,rff_form0002-retail_spriteforms
	dw 21,rff_form0094-retail_spriteforms
	dw -1
rff_anim000c
	dw 1,rff_form009e-retail_spriteforms
	dw -1
rff_anim0012
	dw 1,rff_form0160-retail_spriteforms
	dw -1
rff_anim0018
	dw 1,rff_form01e2-retail_spriteforms
	dw -1
rff_anim001e
	dw 1,rff_form0344-retail_spriteforms
	dw -1
rff_anim0024
	dw 1,rff_form04f6-retail_spriteforms
	dw -1
rff_anim002a
	dw 1,rff_form0578-retail_spriteforms
	dw -1
rff_anim0030
	dw 5,rff_form06aa-retail_spriteforms
	dw -1
rff_anim0036
	dw 1,rff_form075c-retail_spriteforms
	dw -1
rff_anim003c
	dw 5,rff_form084e-retail_spriteforms
	dw -1
rff_anim0042
	dw 5,rff_form0920-retail_spriteforms
	dw -1
rff_anim0048
	dw 1,rff_form09f2-retail_spriteforms
	dw -1
rff_anim004e
	dw 1,rff_form0af4-retail_spriteforms
	dw -1
rff_anim0054
	dw 1,rff_form0b26-retail_spriteforms
	dw -1
rff_anim005a
	dw 11,rff_form0c08-retail_spriteforms
	dw 11,rff_form0c6a-retail_spriteforms
	dw -1
rff_anim0064
	dw 11,rff_form0c8c-retail_spriteforms
	dw 11,rff_form0c6a-retail_spriteforms
	dw -1
rff_anim006e
	dw 11,rff_form0cde-retail_spriteforms
	dw 11,rff_form0c6a-retail_spriteforms
	dw -1
rff_anim0078
	dw 1,rff_form0d30-retail_spriteforms
	dw -1
rff_anim007e
	dw 1,rff_form0d52-retail_spriteforms
	dw -1
rff_anim0084
	dw 1,rff_form0d74-retail_spriteforms
	dw -1
rff_anim008a
	dw 1,rff_form0d96-retail_spriteforms
	dw -1
rff_anim0090
	dw 1,rff_form0e08-retail_spriteforms
	dw -1
rff_anim0096
	dw 1,rff_form0e7a-retail_spriteforms
	dw -1
rff_anim009c
	dw 1,rff_form0edc-retail_spriteforms
	dw -1
rff_anim00a2
	dw 1,rff_form0f36-retail_spriteforms
	dw -1
rff_anim00a8
	dw 1,rff_form0f68-retail_spriteforms
	dw -1
rff_anim00ae
	dw 12,rff_form0f9a-retail_spriteforms
	dw 12,rff_form0fac-retail_spriteforms
	dw -1
rff_anim00b8
	dw 12,rff_form0fbe-retail_spriteforms
	dw 12,rff_form0fd0-retail_spriteforms
	dw -1
rff_anim00c2
	dw 1,rff_form0fac-retail_spriteforms
	dw -1
rff_anim00c8
	dw 1,rff_form0fd0-retail_spriteforms
	dw -1
rff_anim00ce
	dw 10,rff_form0d96-retail_spriteforms
	dw 10,rff_form0fe2-retail_spriteforms
	dw -1
rff_anim00d8
	dw 10,rff_form0e08-retail_spriteforms
	dw 10,rff_form0fec-retail_spriteforms
	dw -1
rff_anim00e2
	dw 1,rff_form0ff6-retail_spriteforms
	dw -1
rff_anim00e8
	dw 1,rff_form1040-retail_spriteforms
	dw -1
rff_anim00ee
	dw 1,rff_form108a-retail_spriteforms
	dw -1
rff_anim00f4
	dw 1,rff_form10dc-retail_spriteforms
	dw -1
rff_anim00fa
	dw 1,rff_form111e-retail_spriteforms
	dw -1
rff_anim0100
	dw 1,rff_form1158-retail_spriteforms
	dw -1
rff_anim0106
	dw 1,rff_form117a-retail_spriteforms
	dw -1
rff_anim010c
	dw 1,rff_form119c-retail_spriteforms
	dw -1
rff_anim0112
	dw 1,rff_form11be-retail_spriteforms
	dw -1
rff_anim0118
	dw 1,rff_form11e0-retail_spriteforms
	dw -1
rff_anim011e
	dw 1,rff_form1202-retail_spriteforms
	dw -1
rff_anim0124
	dw 1,rff_form1224-retail_spriteforms
	dw -1
rff_anim012a
	dw 1,rff_form1246-retail_spriteforms
	dw -1
rff_anim0130
	dw 1,rff_form1268-retail_spriteforms
	dw -1
rff_anim0136
	dw 1,rff_form128a-retail_spriteforms
	dw -1
rff_anim013c
	dw 1,rff_form12ac-retail_spriteforms
	dw -1
rff_anim0142
	dw 1,rff_form12ce-retail_spriteforms
	dw -1
rff_anim0148
	dw 16,rff_form12f0-retail_spriteforms
	dw 16,rff_form13a2-retail_spriteforms
	dw -1
rff_anim0152
	dw 16,rff_form144c-retail_spriteforms
	dw 16,rff_form14f6-retail_spriteforms
	dw -1
rff_anim015c
	dw 16,rff_form15a8-retail_spriteforms
	dw 16,rff_form1632-retail_spriteforms
	dw -1
rff_anim0166
	dw 16,rff_form16b4-retail_spriteforms
	dw 16,rff_form173e-retail_spriteforms
	dw -1
rff_anim0170
	dw 1,rff_form17c0-retail_spriteforms
	dw -1
rff_anim0176
	dw 1,rff_form17e2-retail_spriteforms
	dw -1
rff_anim017c
	dw 5,rff_form181c-retail_spriteforms
	dw 5,rff_form1866-retail_spriteforms
	dw -1
rff_anim0186
	dw 5,rff_form18b0-retail_spriteforms
	dw 5,rff_form18e2-retail_spriteforms
	dw -1
rff_anim0190
	dw 5,rff_form1914-retail_spriteforms
	dw 5,rff_form193e-retail_spriteforms
	dw -1
rff_anim019a
	dw 5,rff_form1968-retail_spriteforms
	dw 5,rff_form199a-retail_spriteforms
	dw -1
rff_anim01a4
	dw 5,rff_form19cc-retail_spriteforms
	dw 5,rff_form19fe-retail_spriteforms
	dw -1
rff_anim01ae
	dw 1,rff_form1a4a-retail_spriteforms
	dw -1
rff_anim01b4
	dw 7,rff_form1a30-retail_spriteforms
	dw 7,rff_form1a4a-retail_spriteforms
	dw 7,rff_form1a64-retail_spriteforms
	dw 7,rff_form1a4a-retail_spriteforms
	dw -1
rff_anim01c6
	dw 1,rff_form1a98-retail_spriteforms
	dw -1
rff_anim01cc
	dw 7,rff_form1a7e-retail_spriteforms
	dw 7,rff_form1a98-retail_spriteforms
	dw 7,rff_form1ab2-retail_spriteforms
	dw 7,rff_form1a98-retail_spriteforms
	dw -1
rff_anim01de
	dw 1,rff_form1ae6-retail_spriteforms
	dw -1
rff_anim01e4
	dw 7,rff_form1acc-retail_spriteforms
	dw 7,rff_form1ae6-retail_spriteforms
	dw 7,rff_form1b00-retail_spriteforms
	dw 7,rff_form1ae6-retail_spriteforms
	dw -1
rff_anim01f6
	dw 1,rff_form1b34-retail_spriteforms
	dw -1
rff_anim01fc
	dw 7,rff_form1b1a-retail_spriteforms
	dw 7,rff_form1b34-retail_spriteforms
	dw 7,rff_form1b4e-retail_spriteforms
	dw 7,rff_form1b34-retail_spriteforms
	dw -1
rff_anim020e
	dw 1,rff_form1b68-retail_spriteforms
	dw -1
rff_anim0214
	dw 1,rff_form1bba-retail_spriteforms
	dw -1
rff_anim021a
	dw 1,rff_form1bcc-retail_spriteforms
	dw -1
rff_anim0220
	dw 1,rff_form1bde-retail_spriteforms
	dw -1
rff_anim0226
	dw 1,rff_form1bf0-retail_spriteforms
	dw -1
rff_anim022c
	dw 1,rff_form1c62-retail_spriteforms
	dw -1
rff_anim0232
	dw 1,rff_form1cd4-retail_spriteforms
	dw -1
rff_anim0238
	dw 1,rff_form1d46-retail_spriteforms
	dw -1
rff_anim023e
	dw 1,rff_form1db8-retail_spriteforms
	dw -1
rff_anim0244
	dw 1,rff_form1dea-retail_spriteforms
	dw -1
rff_anim024a
	dw 1,rff_form1e1c-retail_spriteforms
	dw -1
rff_anim0250
	dw 1,rff_form1e4e-retail_spriteforms
	dw -1
rff_anim0256
	dw 1,rff_form1eb0-retail_spriteforms
	dw -1
rff_anim025c
	dw 1,rff_form1f12-retail_spriteforms
	dw -1
rff_anim0262
	dw 1,rff_form1f74-retail_spriteforms
	dw -1
rff_anim0268
	dw 1,rff_form1fa6-retail_spriteforms
	dw -1
rff_anim026e
	dw 1,rff_form1fd8-retail_spriteforms
	dw -1
retail_spriteanims_end
mrforms_end
