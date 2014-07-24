   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  36                     ; 9 void GPIO_H_Init(void)
  36                     ; 10 {
  38                     	switch	.text
  39  0000               _GPIO_H_Init:
  43                     ; 12 	GPIO_DeInit(GPIOA);
  45  0000 ae5000        	ldw	x,#20480
  46  0003 cd0000        	call	_GPIO_DeInit
  48                     ; 14 	GPIO_Init(GPIOA,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_SLOW);
  50  0006 4bc0          	push	#192
  51  0008 4b10          	push	#16
  52  000a ae5000        	ldw	x,#20480
  53  000d cd0000        	call	_GPIO_Init
  55  0010 85            	popw	x
  56                     ; 16 	GPIO_Init(GPIOA,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
  58  0011 4bc0          	push	#192
  59  0013 4b20          	push	#32
  60  0015 ae5000        	ldw	x,#20480
  61  0018 cd0000        	call	_GPIO_Init
  63  001b 85            	popw	x
  64                     ; 18 	GPIO_Init(GPIOA,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
  66  001c 4bc0          	push	#192
  67  001e 4b40          	push	#64
  68  0020 ae5000        	ldw	x,#20480
  69  0023 cd0000        	call	_GPIO_Init
  71  0026 85            	popw	x
  72                     ; 20 	GPIO_DeInit(GPIOB);
  74  0027 ae5005        	ldw	x,#20485
  75  002a cd0000        	call	_GPIO_DeInit
  77                     ; 22 	GPIO_Init(GPIOB,GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3,GPIO_MODE_IN_FL_NO_IT);
  79  002d 4b00          	push	#0
  80  002f 4b0f          	push	#15
  81  0031 ae5005        	ldw	x,#20485
  82  0034 cd0000        	call	_GPIO_Init
  84  0037 85            	popw	x
  85                     ; 24 	GPIO_Init(GPIOB,GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_FAST);
  87  0038 4be0          	push	#224
  88  003a 4b70          	push	#112
  89  003c ae5005        	ldw	x,#20485
  90  003f cd0000        	call	_GPIO_Init
  92  0042 85            	popw	x
  93                     ; 26 	GPIO_DeInit(GPIOC);
  95  0043 ae500a        	ldw	x,#20490
  96  0046 cd0000        	call	_GPIO_DeInit
  98                     ; 28 	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
 100  0049 4bc0          	push	#192
 101  004b 4b20          	push	#32
 102  004d ae500a        	ldw	x,#20490
 103  0050 cd0000        	call	_GPIO_Init
 105  0053 85            	popw	x
 106                     ; 30 	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
 108  0054 4bc0          	push	#192
 109  0056 4b40          	push	#64
 110  0058 ae500a        	ldw	x,#20490
 111  005b cd0000        	call	_GPIO_Init
 113  005e 85            	popw	x
 114                     ; 32 	GPIO_Init(GPIOC,GPIO_PIN_7,GPIO_MODE_IN_PU_NO_IT);
 116  005f 4b40          	push	#64
 117  0061 4b80          	push	#128
 118  0063 ae500a        	ldw	x,#20490
 119  0066 cd0000        	call	_GPIO_Init
 121  0069 85            	popw	x
 122                     ; 34 	GPIO_DeInit(GPIOE);
 124  006a ae5014        	ldw	x,#20500
 125  006d cd0000        	call	_GPIO_DeInit
 127                     ; 36 	GPIO_Init(GPIOE,GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
 129  0070 4b40          	push	#64
 130  0072 4b20          	push	#32
 131  0074 ae5014        	ldw	x,#20500
 132  0077 cd0000        	call	_GPIO_Init
 134  007a 85            	popw	x
 135                     ; 38 	GPIO_DeInit(GPIOG);
 137  007b ae501e        	ldw	x,#20510
 138  007e cd0000        	call	_GPIO_DeInit
 140                     ; 40 	GPIO_Init(GPIOG,GPIO_PIN_0,GPIO_MODE_OUT_PP_LOW_SLOW);
 142  0081 4bc0          	push	#192
 143  0083 4b01          	push	#1
 144  0085 ae501e        	ldw	x,#20510
 145  0088 cd0000        	call	_GPIO_Init
 147  008b 85            	popw	x
 148                     ; 43 	GPIO_WriteHigh(GPIOA,GPIO_PIN_5);
 150  008c 4b20          	push	#32
 151  008e ae5000        	ldw	x,#20480
 152  0091 cd0000        	call	_GPIO_WriteHigh
 154  0094 84            	pop	a
 155                     ; 44 	delay();
 157  0095 cd0000        	call	_delay
 159                     ; 45 	delay();
 161  0098 cd0000        	call	_delay
 163                     ; 46 	GPIO_WriteHigh(GPIOA,GPIO_PIN_6);
 165  009b 4b40          	push	#64
 166  009d ae5000        	ldw	x,#20480
 167  00a0 cd0000        	call	_GPIO_WriteHigh
 169  00a3 84            	pop	a
 170                     ; 47 }
 173  00a4 81            	ret
 197                     ; 49 void GPIO_CS0(void)
 197                     ; 50 {
 198                     	switch	.text
 199  00a5               _GPIO_CS0:
 203                     ; 51 	GPIO_WriteLow(GPIOA,GPIO_PIN_4);
 205  00a5 4b10          	push	#16
 206  00a7 ae5000        	ldw	x,#20480
 207  00aa cd0000        	call	_GPIO_WriteLow
 209  00ad 84            	pop	a
 210                     ; 52 }
 213  00ae 81            	ret
 237                     ; 54 void GPIO_CS1(void)
 237                     ; 55 {
 238                     	switch	.text
 239  00af               _GPIO_CS1:
 243                     ; 56 	GPIO_WriteHigh(GPIOA,GPIO_PIN_4);
 245  00af 4b10          	push	#16
 246  00b1 ae5000        	ldw	x,#20480
 247  00b4 cd0000        	call	_GPIO_WriteHigh
 249  00b7 84            	pop	a
 250                     ; 57 }
 253  00b8 81            	ret
 374                     ; 59 void GPIO_LED(GPIO_Pin_TypeDef led)
 374                     ; 60 {
 375                     	switch	.text
 376  00b9               _GPIO_LED:
 378  00b9 88            	push	a
 379       00000000      OFST:	set	0
 382                     ; 61 	GPIO_WriteHigh(LED_PORT,led);
 384  00ba 88            	push	a
 385  00bb ae5005        	ldw	x,#20485
 386  00be cd0000        	call	_GPIO_WriteHigh
 388  00c1 84            	pop	a
 389                     ; 62 	delay();
 391  00c2 cd0000        	call	_delay
 393                     ; 63 	GPIO_WriteLow(LED_PORT,led);
 395  00c5 7b01          	ld	a,(OFST+1,sp)
 396  00c7 88            	push	a
 397  00c8 ae5005        	ldw	x,#20485
 398  00cb cd0000        	call	_GPIO_WriteLow
 400  00ce 84            	pop	a
 401                     ; 64 }
 404  00cf 84            	pop	a
 405  00d0 81            	ret
 462                     ; 66 BitStatus GPIO_KEY(GPIO_Pin_TypeDef key)
 462                     ; 67 {
 463                     	switch	.text
 464  00d1               _GPIO_KEY:
 468                     ; 68 	return GPIO_ReadInputPin(KEY_PORT,key);
 470  00d1 88            	push	a
 471  00d2 ae5005        	ldw	x,#20485
 472  00d5 cd0000        	call	_GPIO_ReadInputPin
 474  00d8 5b01          	addw	sp,#1
 477  00da 81            	ret
 490                     	xdef	_GPIO_KEY
 491                     	xdef	_GPIO_LED
 492                     	xdef	_GPIO_CS1
 493                     	xdef	_GPIO_CS0
 494                     	xdef	_GPIO_H_Init
 495                     	xref	_delay
 496                     	xref	_GPIO_ReadInputPin
 497                     	xref	_GPIO_WriteLow
 498                     	xref	_GPIO_WriteHigh
 499                     	xref	_GPIO_Init
 500                     	xref	_GPIO_DeInit
 519                     	end
