ORG 0x7c00
jmp entry 
nop
DB	"HELLOX86"	;OEM
DW	512	;sector size
DB	1	;cluster (Block) size
DW	1	;FAT start
DB	2	;number of FAT
DW	224	;number of root dir
DW	2880	;number of sectors (16bit)
DB	0xf0	;media type
DW	9	;FAT size in sectors
DW	18	;track size in sectors
DW	2	;number of faces
DD	0	;number of hidden sectors
DD	2880	;number of sectors (32bit)
DB	0	;the drive number of int13
DB	0	;reserved
DB	0x29	;
DD	0xffffffff	;volumn ID
DB	"HELLO-OS   "	;volumn label
DB	"FAT12   "	;filesystem type
RESB	18

entry: 
mov	AX, 0
mov	SS, AX
mov	SP, 0x7c00
mov	DS, AX
mov	ES, AX
mov	SI, message

mov	AX, 0x0820
mov	ES, AX
mov	CH, 0
mov	DH, 0
mov	CL, 2

mov	AH, 0x02
mov	AL, 1
mov	BX, 0
mov	DL, 0x00
int	0x13
jc	finish



putloop:
mov	AL, [SI]
add	SI, 1
cmp	AL, 0
je	finish
mov	AH, 0x0e
mov BX, 15
int	0x10
jmp putloop

finish:
hlt
jmp finish

message:; "\n\nHello, world!\n\0"
DB	0x0a, 0x0a
DB	"Hello, world!"
DB	0x0a
DB	0

RESB	377
DB 0x55, 0xaa

DB	0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
RESB	4600
DB	0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
RESB	1469432