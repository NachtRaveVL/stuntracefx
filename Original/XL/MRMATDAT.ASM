; Native texture identities, palette byte window and UV records.
; Descriptor addresses name native payload identities. Bind the referenced
; pixel data before rendering; these tables do not restore those payloads.
; Fixed-colour lookup keeps its native 256-byte read window, including
; bytes overlapping the following table. The UV pointers are rebound.
	incpublics mrmatdat.ext
mrmatdat_begin
retail_texturedefs
	dl $128000
	dl $128020
	dl $128040
	dl $128060
	dl $128080
	dl $1280a0
	dl $1280c0
	dl $1280e0
	dl $12a000
	dl $12a040
	dl $12a080
	dl $12a0c0
	dl $12a0e0
	dl $12c000
	dl $12c020
	dl $12c060
	dl $12c080
	dl $12c0a0
	dl $12c0e0
	dl $12e000
	dl $12e020
	dl $12e040
	dl $12e060
	dl $12e080
	dl $12e0a0
	dl $12e0c0
	dl $12e0e0
	dl $128000
	dl $128020
	dl $128040
	dl $128060
	dl $128080
	dl $1280a0
	dl $1280c0
	dl $1280e0
	dl $12a000
	dl $12a020
	dl $12a040
	dl $12a060
	dl $12a080
	dl $12a0a0
	dl $12a0c0
	dl $12a0e0
	dl $12a0e0
	dl $12c000
	dl $12c040
	dl $12c040
	dl $12c060
	dl $12c060
	dl $12c080
	dl $12c0a0
	dl $12c0c0
	dl $12c0e0
	dl $12e000
	dl $12e040
	dl $12e060
	dl $12e080
	dl $12e080
	dl $12e0a0
	dl $12e0c0
	dl $12e0e0
	dl $138000
	dl $138010
	dl $138020
	dl $138030
	dl $138040
	dl $138050
	dl $138060
	dl $138070
	dl $138080
	dl $138090
	dl $1380a0
	dl $1380b0
	dl $1380c0
	dl $1380d0
	dl $1380e0
	dl $1380f0
	dl $139000
	dl $139010
	dl $139020
	dl $139030
	dl $139040
	dl $139050
	dl $139060
	dl $139070
	dl $139080
	dl $139090
	dl $1390a0
	dl $1390b0
	dl $1390c0
	dl $1390d0
	dl $1390e0
	dl $1390f0
	dl $13a000
	dl $13a020
	dl $13a040
	dl $13a060
	dl $13a080
	dl $13a0a0
	dl $13a0c0
	dl $13a0e0
	dl $13c000
	dl $13c020
	dl $13c040
	dl $13c060
	dl $13c080
	dl $13c0a0
	dl $13c0c0
	dl $13c0e0
	dl $13e000
	dl $13e020
	dl $13e060
	dl $13e080
	dl $13e0a0
	dl $13e0c0
	dl $138000
	dl $138010
	dl $138020
	dl $138030
	dl $138040
	dl $138050
	dl $138060
	dl $138070
	dl $138080
	dl $138090
	dl $1380a0
	dl $1380b0
	dl $1380c0
	dl $1380d0
	dl $1380e0
	dl $1380f0
	dl $139000
	dl $139010
	dl $139020
	dl $139030
	dl $139040
	dl $139050
	dl $139060
	dl $139070
	dl $139080
	dl $13a000
	dl $13a020
	dl $13a040
	dl $13a060
	dl $13a080
	dl $13a0a0
	dl $13a0e0
	dl $13c000
	dl $13c020
	dl $13c040
	dl $13c060
	dl $13c080
	dl $13c0a0
	dl $13c0c0
	dl $13c0e0
	dl $13e000
	dl $13e020
	dl $13e040
	dl $13e060
	dl $13e080
	dl $13e0a0
	dl $13e0c0
	dl $13e0e0
	dl $068000
	dl $068010
	dl $068020
	dl $068030
	dl $068040
	dl $068050
	dl $068060
	dl $068070
	dl $068080
	dl $068090
	dl $0680a0
	dl $0680b0
	dl $0680c0
	dl $0680d0
	dl $0680e0
	dl $0680f0
	dl $069000
	dl $069010
	dl $069020
	dl $069030
	dl $069040
	dl $069050
	dl $069060
	dl $069070
	dl $069080
	dl $069090
	dl $0690a0
	dl $0690b0
	dl $0690c0
	dl $0690d0
	dl $0690e0
	dl $0690f0
	dl $06a000
	dl $06a020
	dl $06a040
	dl $06a060
	dl $06a080
retail_texturedefs_end
retail_texturepals
	db $e0,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$10,$10,$10,$10,$10,$10,$10,$10
	db $10,$10,$60,$10,$20,$10,$10,$d0,$80,$10,$80,$20,$20,$20,$20,$20
	db $20,$10,$10,$10,$10,$10,$90,$00,$10,$a0,$80,$a0,$70,$80,$a0,$80
	db $a0,$10,$10,$10,$10,$10,$10,$10,$80,$a0,$d0,$90,$10,$10,$10,$10
	db $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
	db $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$a0,$a0,$a0
	db $a0,$10,$10,$10,$10,$10,$50,$50,$10,$a0,$a0,$a0,$a0,$10,$10,$20
	db $20,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$10
	db $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$80,$80,$80,$80
	db $10,$70,$80,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$80,$e0,$e0,$e0,$e0,$e0
	db $e0,$e0,$80,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
	db $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
	db $10,$10,$10,$10,$10,$10,$10,$10,$9b,$a0,$a5,$a0,$af,$a0,$b9,$a0
	db $c3,$a0,$cd,$a0,$d7,$a0,$e1,$a0,$eb,$a0,$f5,$a0,$ff,$a0,$09,$a1
	db $13,$a1,$1d,$a1,$27,$a1,$31,$a1,$3b,$a1,$1f,$1f,$00,$00,$1f,$00
	db $1f,$1f,$00,$1f,$3f,$3f,$3f,$00,$00,$00,$00,$3f,$3f,$3f,$7f,$0f
retail_texturepals_end
retail_texturexys
	dw retail_texturexy0&WM
	dw retail_texturexy1&WM
	dw retail_texturexy2&WM
	dw retail_texturexy3&WM
	dw retail_texturexy4&WM
	dw retail_texturexy5&WM
	dw retail_texturexy6&WM
	dw retail_texturexy7&WM
	dw retail_texturexy8&WM
	dw retail_texturexy9&WM
	dw retail_texturexy10&WM
	dw retail_texturexy11&WM
	dw retail_texturexy12&WM
	dw retail_texturexy13&WM
	dw retail_texturexy14&WM
	dw retail_texturexy15&WM
	dw retail_texturexy16&WM
retail_texturexys_end
retail_texturexy0
	dw $1f1f
	db $00,$00,$1f,$00,$1f,$1f,$00,$1f
retail_texturexy1
	dw $3f3f
	db $3f,$00,$00,$00,$00,$3f,$3f,$3f
retail_texturexy2
	dw $0f7f
	db $00,$00,$00,$0f,$0f,$0f,$0f,$00
retail_texturexy3
	dw $1f1f
	db $00,$00,$7f,$00,$7f,$1f,$00,$1f
retail_texturexy4
	dw $0f3f
	db $00,$00,$3f,$00,$3f,$0f,$00,$0f
retail_texturexy5
	dw $0f3f
	db $3f,$00,$00,$00,$00,$0f,$3f,$0f
retail_texturexy6
	dw $3f3f
	db $00,$00,$3f,$00,$3f,$3f,$00,$3f
retail_texturexy7
	dw $077f
	db $1f,$00,$00,$00,$00,$07,$1f,$07
retail_texturexy8
	dw $1f1f
	db $1f,$00,$00,$00,$00,$1f,$1f,$1f
retail_texturexy9
	dw $0f0f
	db $00,$00,$0f,$00,$0f,$0f,$00,$0f
retail_texturexy10
	dw $1f3f
	db $00,$00,$3f,$00,$3f,$1f,$00,$1f
retail_texturexy11
	dw $1f3f
	db $3f,$00,$00,$00,$00,$1f,$3f,$1f
retail_texturexy12
	dw $9f1f
	db $1f,$00,$00,$00,$00,$1f,$1f,$1f
retail_texturexy13
	dw $8f0f
	db $00,$00,$0f,$00,$0f,$0f,$00,$0f
retail_texturexy14
	dw $0707
	db $00,$00,$07,$00,$07,$07,$00,$07
retail_texturexy15
	dw $8707
	db $00,$00,$07,$00,$07,$07,$00,$07
retail_texturexy16
	dw $1f7f
	db $7f,$00,$00,$00,$00,$0f,$7f,$0f
mrmatdat_end
