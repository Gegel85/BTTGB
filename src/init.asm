; Initialize the HRam ($FF80) to use DMA.
; Params:
;    a The start address divided by $100.
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Preserved
;    de -> Preserved
;    hl -> Preserved
initDMA::
	ld [START_DMA], a
	ld a, DMA_DELAY
.wait:
	dec a
	jr nz, .wait
	ret
initDMA_end:

; Enable interupts and init RAM
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
init::
	push af
	reg INTERRUPT_ENABLED, VBLANK_INTERRUPT
	call waitVBLANK

	reset LCD_CONTROL

	xor a
	ld bc, $2000
	ld de, $C000
	call fillMemory

	pop af
	dec a
	ld [HARDWARE_TYPE], a

	xor a
	ld hl, DMGPal
	ld bc, $8
	ld e, BGPI & $FF
	call setGBCPalette

	ld hl, CHANNEL_CONTROL
	ld a, $77
	ld [hli], a
	ld a, $FF
	ld [hli], a

	ld bc, initDMA_end - initDMA
	ld de, $FF80
	ld hl, initDMA
	call copyMemory

	reg BGP,  DMG_BG_PALETTE
	reg OBP0, DMG_OBP0_PALETTE
	reg OBP1, DMG_OBP1_PALETTE

	call loadSprites
	call DMA
	call initWPRAM

	reset INTERRUPT_ENABLED
	reg JOYPAD_REGISTER, $30
	reg KEY1, $1
	stop

	ret

updateRegisters::
	ret

.dec:
	or [hl]
	jr z, .skip
	dec [hl]
.skip:
	ret