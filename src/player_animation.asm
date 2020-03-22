; Initialize the animations timer.
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
initAnimation::
	reg ANIMATION_TIMER, ANIMATION_TIME
	ret

; Update animations.
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
updateAnimation::
	ld hl, ANIMATION_TIMER
	xor a
	cp [hl]
	jr nz, .notReady

	ld hl, PLAYER_STRUCT + DISPLAYABLE_OBJECT_STRUCT_SPRITE
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	call initAnimation
	jr .end

.notReady::
	dec [hl]

.end:
	xor a

	ld hl, PLAYER_STRUCT + BASIC_OBJECT_STRUCT_Y_SPEED_OFF
	cp [hl]
	jr nz, .jump

	ld hl, PLAYER_STRUCT + BASIC_OBJECT_STRUCT_X_SPEED_OFF
	cp [hl]
	jr nz, .walk

	ld a, PLAYER_SPRITE_NBR
	call playerAnimation
	ret

.walk:
	ld a, PLAYER_SPRITE_WALK_NBR
	call playerAnimation
	ret

.jump:
	jp playerAnimationJump


; Animate player.
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
playerAnimation::
	push af
	dec a
	ld hl, PLAYER_STRUCT + DISPLAYABLE_OBJECT_STRUCT_SPRITE
	cp [hl]
	jr nc, .resetAnim

	add 13
	cp [hl]
	jr c, .resetAnim
	pop af
	ret

.resetAnim:
	pop af
	ld [hl], a
	jp initAnimation

; Animate player jump.
; Params:
;    None
; Return:
;    None
; Registers:
;    af -> Not preserved
;    bc -> Not preserved
;    de -> Not preserved
;    hl -> Not preserved
playerAnimationJump::
	reg PLAYER_STRUCT + DISPLAYABLE_OBJECT_STRUCT_SPRITE, PLAYER_SPRITE_JUMP_NBR
	ret