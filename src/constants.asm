CGB_A_INIT EQU $11 ; Accumulator starting value on a Gameboy Color

; Sound control
CHANNEL_CONTROL EQU $FF24
CHANNEL_OUTPUT_CONTROL EQU $FF25
DISABLE_CHANNELS_REGISTERS EQU $FF26

; Sound Channel 1
CHANNEL1_SWEEP EQU $FF10
CHANNEL1_LENGTH EQU $FF11
CHANNEL1_VOLUME EQU $FF12
CHANNEL1_LOW_FREQ EQU $FF13
CHANNEL1_HIGH_FREQ EQU $FF14

; Sound Channel 2
CHANNEL2_LENGTH EQU $FF16
CHANNEL2_VOLUME EQU $FF17
CHANNEL2_LOW_FREQ EQU $FF18
CHANNEL2_HIGH_FREQ EQU $FF19

; Sound channel 3
CHANNEL3_ON_OFF EQU $FF1A
CHANNEL3_LENGTH EQU $FF1B
CHANNEL3_OUTPUT EQU $FF1C
CHANNEL3_LOW_FREQ EQU $FF1D
CHANNEL3_HIGH_FREQ EQU $FF1E
WPRAM EQU $FF30

; Sound channel 4
CHANNEL4_LENGTH EQU $FF20
CHANNEL4_VOLUME EQU $FF21
CHANNEL4_POLY EQU $FF22
CHANNEL4_RESTART EQU $FF23

; LCD
LCD_CONTROL EQU $FF40
STAT_CONTROL EQU $FF41
LCD_BASE_CONTROL EQU %11110111
SCROLL_X EQU $FF43
SCROLL_Y EQU $FF42
LY EQU $FF44
LYC EQU $FF45
WX EQU $FF4B
WY EQU $FF4A

; VRAM
VRAM_START EQU $8000
VRAM_BG_START EQU $9800
VRAM_BANK_SELECT EQU $FF4F

; Characters
TM_CHARACTER EQU $88

; Joypad
JOYPAD_REGISTER EQU $FF00

; Interrupts
INTERRUPT_REQUEST EQU $FF0F
INTERRUPT_ENABLED EQU $FFFF
NO_INTERRUPT EQU 0
VBLANK_INTERRUPT EQU (1 << 0)
LCD_STAT_INTERRUPT EQU (1 << 1)
TIMER_INTERRUPT EQU (1 << 2)
SERIAL_INTERRUPT EQU (1 << 3)
JOYPAD_INTERRUPT EQU (1 << 4)

; Misc registers
DIV_REGISTER EQU $FF04
PALETTE_REGISTER EQU $FF47

; Game registers
FRAME_COUNTER EQU $C000
HARDWARE_TYPE EQU $C001
RANDOM_REGISTER EQU $C002
PLAYER_STRUCT EQU $C003
INTRO_COUNTER EQU $C028
CREDITS_CURRENT_LINE EQU $C029
CREDITS_LAST_ADDR_H EQU $C02A
CREDITS_LAST_ADDR_L EQU $C02B
CREDITS_LINE_POS EQU $C02C
CREDITS_SLIDING EQU $C02D
CREDITS_LINES EQU $C02E
KEYS_DISABLED EQU $C02F
MUSIC_CHANNEL_1 EQU $C030
MUSIC_CHANNEL_2 EQU $C035
MUSIC_CHANNEL_WAVE EQU $C03A
MUSIC_CHANNEL_NOISE EQU $C03F
BANK_POINTER EQU $C200

; Game constants
DMG_BG_PALETTE EQU %11011000
DMG_OBP0_PALETTE EQU %11011000
DMG_OBP1_PALETTE EQU %11011000

; Music structure
MUSIC_TIMER EQU $C030
MUSIC_PTR_H EQU $C031
MUSIC_PTR_L EQU $C032
MUSIC_START_PTR_H EQU $C033
MUSIC_START_PTR_L EQU $C034

; Basic object structure
BASIC_OBJECT_STRUCT_X_OFF EQU $0
BASIC_OBJECT_STRUCT_X_SIZE_OFF EQU $1
BASIC_OBJECT_STRUCT_X_SPEED_OFF EQU $2
BASIC_OBJECT_STRUCT_Y_OFF EQU $3
BASIC_OBJECT_STRUCT_Y_SIZE_OFF EQU $4
BASIC_OBJECT_STRUCT_Y_SPEED_OFF EQU $5

; Displayable object structure
DISPLAYABLE_OBJECT_STRUCT_BASIC_OBJECT EQU $0
DISPLAYABLE_OBJECT_STRUCT_SPRITE EQU $6
DISPLAYABLE_OBJECT_STRUCT_ORIENTATION EQU $7

; DMG Palette
BGP EQU $FF47
OBP0 EQU $FF48
OBP1 EQU $FF49

; GBC Palette
BGPI EQU $FF68
BGPD EQU $FF69
OBPI EQU $FF6A
OBPD EQU $FF6B

; SGB Commands
PAL_TRN EQU $59
DATA_SND EQU $79
MLT_REQ EQU $89
CHR_TRN EQU $99
PCT_TRN EQU $A1
MASK_EN EQU $B9

; DMA
START_DMA EQU $FF46
DMA_DELAY EQU $28
DMA EQU $FF80

; OAM
OAM_SRC_START EQU $C800

; Sprite offsets
SPRITE_POSITION_Y EQU $0
SPRITE_POSITION_X EQU $1
SPRITE_TILE_NBR EQU $2
SPRITE_ATTRIBUTE_FLAGS EQU $3

QUAVER EQU $8