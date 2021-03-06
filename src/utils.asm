; Uncompress compressed data
; Params:
;    a  ->
;    hl -> Pointer to the compressed data
;    de -> Destination address
;    bc -> Data size
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
uncompress::
	push af
	push de
	push hl
	pop de
	pop hl
	push hl
	ld hl, .case0
	rla
	rla
	rla
	add a, l
	ld l, a
	ld a, h
	adc $00
	ld h, a
	jp hl
.case0:
	pop hl
	ld a, [de]
	ld [hli], a
	ld [hli], a
	jr .endCase
	nop
	nop
.case1:
	pop hl
	xor a
	ld [hli], a
	ld a, [de]
	cpl
	ld [hli], a
	jr .endCase
.endCase:

	inc de
	dec bc
	xor a
	or b
	or c
	jr nz, .continue
	pop af
	push hl
	push de
	pop hl
	pop de
	ret
.continue:
	pop af
	push hl
	push de
	pop hl
	pop de
	jr uncompress

; Generates a pseudo random number.
; Params:
;    None
; Return:
;    a -> The number generated
; Registers:
;    af -> Not preserved
;    bc -> Preserved
;    de -> Preserved
;    hl -> Preserved
random::
	push hl

	ld a, [RANDOM_REGISTER]
	ld hl, DIV_REGISTER
	add a, [hl]
	ld [RANDOM_REGISTER], a

	pop hl
	ret

; Wait for VBLANK. Only returns when a VBLANK occurs.
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Preserved
;    de -> Preserved
;    hl -> Preserved
waitVBLANK::
	ld a, [LCD_CONTROL] ; Check if LCD is disabled
	bit 7, a
	ret z

	ld a, [INTERRUPT_ENABLED] ; Save old interrupt enabled
	push af
	reset INTERRUPT_REQUEST; Clear old requests
	reg INTERRUPT_ENABLED, VBLANK_INTERRUPT; Enable only VBLANK interrupt
.loop:
	halt   ; Wait for interrupt
	pop af ; Restore old interrupt enabled
	ld [INTERRUPT_ENABLED], a
	ret

; Wait for VBLANK. Only returns when a VBLANK occurs.
; Params:
;    a -> The number of frames to wait for.
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Preserved
;    de -> Preserved
;    hl -> Not preserved
waitFrames::
	ld hl, FRAME_COUNTER
	ld [hl], a
	reg INTERRUPT_ENABLED, VBLANK_INTERRUPT
	xor a
.loop:
	or [hl]
	ret z
	reset INTERRUPT_REQUEST
	halt
	jr .loop

; Get all the pressed keys.
; Params:
;    None
; Return:
;    (Pressed when bit is 0)
;    a -> All the pressed keys
;       bit 0 -> Right
;       bit 1 -> Left
;       bit 2 -> Up
;       bit 3 -> Down
;       bit 4 -> A
;       bit 5 -> B
;       bit 6 -> Select
;       bit 7 -> Start
; Registers:
;    af -> Not preserved
;    b  -> Not preserved
;    c  -> Preserved
;    de -> Preserved
;    hl -> Not preserved
getKeys::
	ld hl, $FF00
	ld a, %00010000
	ld [hl], a
	ld a, [hl]
	ld a, [hl]
	ld a, [hl]
	ld a, [hl]
	ld a, [hl]
	and a, $F
	ld b, a
	swap b

	ld a, %00100000
	ld [hl], a
	ld a, [hl]
	ld a, [hl]
	ld a, [hl]
	ld a, [hl]
	ld a, [hl]
	and a, $F
	or b
	ret

; Get all the pressed keys but disabled ones.
; Also disables all keys that are currently pressed.
; Params:
;    None
; Return:
;    (Pressed when bit is 0)
;    a -> All the pressed keys
;       bit 0 -> Right
;       bit 1 -> Left
;       bit 2 -> Up
;       bit 3 -> Down
;       bit 4 -> A
;       bit 5 -> B
;       bit 6 -> Select
;       bit 7 -> Start
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Preserved
;    hl -> Not preserved
getKeysFiltered::
	call getKeys
	ld b, a
	ld hl, KEYS_DISABLED
	ld a, [hl]
	or b
	ld c, a
	ld a, b
	cpl
	ld [hl], a
	ld a, c
	ret

writeNumber::
    ld b, a

    swap a
    and a, $F
    add a, $30
    ld [de], a
    inc de

    ld a, b
    and a, $F
    add a, $30
    ld [de], a
    inc de
    ret