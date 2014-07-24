   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  98                     ; 45 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
  98                     ; 46 {
 100                     	switch	.text
 101  0000               _GPIO_DeInit:
 105                     ; 47     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 107  0000 7f            	clr	(x)
 108                     ; 48     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 110  0001 6f02          	clr	(2,x)
 111                     ; 49     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 113  0003 6f03          	clr	(3,x)
 114                     ; 50     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 116  0005 6f04          	clr	(4,x)
 117                     ; 51 }
 120  0007 81            	ret
 360                     ; 62 void GPIO_Init(GPIO_TypeDef* GPIOx,
 360                     ; 63                GPIO_Pin_TypeDef GPIO_Pin,
 360                     ; 64                GPIO_Mode_TypeDef GPIO_Mode)
 360                     ; 65 {
 361                     	switch	.text
 362  0008               _GPIO_Init:
 364  0008 89            	pushw	x
 365       00000000      OFST:	set	0
 368                     ; 70     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 370                     ; 71     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 372                     ; 77     if ((((u8)(GPIO_Mode)) & (u8)0x80) != (u8)0x00) /* Output mode */
 374  0009 7b06          	ld	a,(OFST+6,sp)
 375  000b a580          	bcp	a,#128
 376  000d 271d          	jreq	L771
 377                     ; 79         if ((((u8)(GPIO_Mode)) & (u8)0x10) != (u8)0x00) /* High level */
 379  000f 7b06          	ld	a,(OFST+6,sp)
 380  0011 a510          	bcp	a,#16
 381  0013 2706          	jreq	L102
 382                     ; 81             GPIOx->ODR |= (u8)GPIO_Pin;
 384  0015 f6            	ld	a,(x)
 385  0016 1a05          	or	a,(OFST+5,sp)
 386  0018 f7            	ld	(x),a
 388  0019 2007          	jra	L302
 389  001b               L102:
 390                     ; 84             GPIOx->ODR &= (u8)(~(GPIO_Pin));
 392  001b 1e01          	ldw	x,(OFST+1,sp)
 393  001d 7b05          	ld	a,(OFST+5,sp)
 394  001f 43            	cpl	a
 395  0020 f4            	and	a,(x)
 396  0021 f7            	ld	(x),a
 397  0022               L302:
 398                     ; 87         GPIOx->DDR |= (u8)GPIO_Pin;
 400  0022 1e01          	ldw	x,(OFST+1,sp)
 401  0024 e602          	ld	a,(2,x)
 402  0026 1a05          	or	a,(OFST+5,sp)
 403  0028 e702          	ld	(2,x),a
 405  002a 2009          	jra	L502
 406  002c               L771:
 407                     ; 91         GPIOx->DDR &= (u8)(~(GPIO_Pin));
 409  002c 1e01          	ldw	x,(OFST+1,sp)
 410  002e 7b05          	ld	a,(OFST+5,sp)
 411  0030 43            	cpl	a
 412  0031 e402          	and	a,(2,x)
 413  0033 e702          	ld	(2,x),a
 414  0035               L502:
 415                     ; 98     if ((((u8)(GPIO_Mode)) & (u8)0x40) != (u8)0x00) /* Pull-Up or Push-Pull */
 417  0035 7b06          	ld	a,(OFST+6,sp)
 418  0037 a540          	bcp	a,#64
 419  0039 270a          	jreq	L702
 420                     ; 100         GPIOx->CR1 |= (u8)GPIO_Pin;
 422  003b 1e01          	ldw	x,(OFST+1,sp)
 423  003d e603          	ld	a,(3,x)
 424  003f 1a05          	or	a,(OFST+5,sp)
 425  0041 e703          	ld	(3,x),a
 427  0043 2009          	jra	L112
 428  0045               L702:
 429                     ; 103         GPIOx->CR1 &= (u8)(~(GPIO_Pin));
 431  0045 1e01          	ldw	x,(OFST+1,sp)
 432  0047 7b05          	ld	a,(OFST+5,sp)
 433  0049 43            	cpl	a
 434  004a e403          	and	a,(3,x)
 435  004c e703          	ld	(3,x),a
 436  004e               L112:
 437                     ; 110     if ((((u8)(GPIO_Mode)) & (u8)0x20) != (u8)0x00) /* Interrupt or Slow slope */
 439  004e 7b06          	ld	a,(OFST+6,sp)
 440  0050 a520          	bcp	a,#32
 441  0052 270a          	jreq	L312
 442                     ; 112         GPIOx->CR2 |= (u8)GPIO_Pin;
 444  0054 1e01          	ldw	x,(OFST+1,sp)
 445  0056 e604          	ld	a,(4,x)
 446  0058 1a05          	or	a,(OFST+5,sp)
 447  005a e704          	ld	(4,x),a
 449  005c 2009          	jra	L512
 450  005e               L312:
 451                     ; 115         GPIOx->CR2 &= (u8)(~(GPIO_Pin));
 453  005e 1e01          	ldw	x,(OFST+1,sp)
 454  0060 7b05          	ld	a,(OFST+5,sp)
 455  0062 43            	cpl	a
 456  0063 e404          	and	a,(4,x)
 457  0065 e704          	ld	(4,x),a
 458  0067               L512:
 459                     ; 118 }
 462  0067 85            	popw	x
 463  0068 81            	ret
 509                     ; 129 void GPIO_Write(GPIO_TypeDef* GPIOx, u8 PortVal)
 509                     ; 130 {
 510                     	switch	.text
 511  0069               _GPIO_Write:
 513  0069 89            	pushw	x
 514       00000000      OFST:	set	0
 517                     ; 131     GPIOx->ODR = PortVal;
 519  006a 7b05          	ld	a,(OFST+5,sp)
 520  006c 1e01          	ldw	x,(OFST+1,sp)
 521  006e f7            	ld	(x),a
 522                     ; 132 }
 525  006f 85            	popw	x
 526  0070 81            	ret
 573                     ; 143 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 573                     ; 144 {
 574                     	switch	.text
 575  0071               _GPIO_WriteHigh:
 577  0071 89            	pushw	x
 578       00000000      OFST:	set	0
 581                     ; 145     GPIOx->ODR |= (u8)PortPins;
 583  0072 f6            	ld	a,(x)
 584  0073 1a05          	or	a,(OFST+5,sp)
 585  0075 f7            	ld	(x),a
 586                     ; 146 }
 589  0076 85            	popw	x
 590  0077 81            	ret
 637                     ; 157 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 637                     ; 158 {
 638                     	switch	.text
 639  0078               _GPIO_WriteLow:
 641  0078 89            	pushw	x
 642       00000000      OFST:	set	0
 645                     ; 159     GPIOx->ODR &= (u8)(~PortPins);
 647  0079 7b05          	ld	a,(OFST+5,sp)
 648  007b 43            	cpl	a
 649  007c f4            	and	a,(x)
 650  007d f7            	ld	(x),a
 651                     ; 160 }
 654  007e 85            	popw	x
 655  007f 81            	ret
 702                     ; 171 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 702                     ; 172 {
 703                     	switch	.text
 704  0080               _GPIO_WriteReverse:
 706  0080 89            	pushw	x
 707       00000000      OFST:	set	0
 710                     ; 173     GPIOx->ODR ^= (u8)PortPins;
 712  0081 f6            	ld	a,(x)
 713  0082 1805          	xor	a,	(OFST+5,sp)
 714  0084 f7            	ld	(x),a
 715                     ; 174 }
 718  0085 85            	popw	x
 719  0086 81            	ret
 757                     ; 183 u8 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 757                     ; 184 {
 758                     	switch	.text
 759  0087               _GPIO_ReadOutputData:
 763                     ; 185     return ((u8)GPIOx->ODR);
 765  0087 f6            	ld	a,(x)
 768  0088 81            	ret
 805                     ; 195 u8 GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 805                     ; 196 {
 806                     	switch	.text
 807  0089               _GPIO_ReadInputData:
 811                     ; 197     return ((u8)GPIOx->IDR);
 813  0089 e601          	ld	a,(1,x)
 816  008b 81            	ret
 884                     ; 210 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 884                     ; 211 {
 885                     	switch	.text
 886  008c               _GPIO_ReadInputPin:
 888  008c 89            	pushw	x
 889       00000000      OFST:	set	0
 892                     ; 212     return ((BitStatus)(GPIOx->IDR & (vu8)GPIO_Pin));
 894  008d e601          	ld	a,(1,x)
 895  008f 1405          	and	a,(OFST+5,sp)
 898  0091 85            	popw	x
 899  0092 81            	ret
 977                     ; 223 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 977                     ; 224 {
 978                     	switch	.text
 979  0093               _GPIO_ExternalPullUpConfig:
 981  0093 89            	pushw	x
 982       00000000      OFST:	set	0
 985                     ; 226     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 987                     ; 227     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 989                     ; 229     if (NewState != DISABLE) /* External Pull-Up Set*/
 991  0094 0d06          	tnz	(OFST+6,sp)
 992  0096 2708          	jreq	L374
 993                     ; 231         GPIOx->CR1 |= (u8)GPIO_Pin;
 995  0098 e603          	ld	a,(3,x)
 996  009a 1a05          	or	a,(OFST+5,sp)
 997  009c e703          	ld	(3,x),a
 999  009e 2009          	jra	L574
1000  00a0               L374:
1001                     ; 234         GPIOx->CR1 &= (u8)(~(GPIO_Pin));
1003  00a0 1e01          	ldw	x,(OFST+1,sp)
1004  00a2 7b05          	ld	a,(OFST+5,sp)
1005  00a4 43            	cpl	a
1006  00a5 e403          	and	a,(3,x)
1007  00a7 e703          	ld	(3,x),a
1008  00a9               L574:
1009                     ; 236 }
1012  00a9 85            	popw	x
1013  00aa 81            	ret
1026                     	xdef	_GPIO_ExternalPullUpConfig
1027                     	xdef	_GPIO_ReadInputPin
1028                     	xdef	_GPIO_ReadOutputData
1029                     	xdef	_GPIO_ReadInputData
1030                     	xdef	_GPIO_WriteReverse
1031                     	xdef	_GPIO_WriteLow
1032                     	xdef	_GPIO_WriteHigh
1033                     	xdef	_GPIO_Write
1034                     	xdef	_GPIO_Init
1035                     	xdef	_GPIO_DeInit
1054                     	end
