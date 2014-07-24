   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 43 void SPI_DeInit(void)
  32                     ; 44 {
  34                     	switch	.text
  35  0000               _SPI_DeInit:
  39                     ; 45     SPI->CR1    = SPI_CR1_RESET_VALUE;
  41  0000 725f5200      	clr	20992
  42                     ; 46     SPI->CR2    = SPI_CR2_RESET_VALUE;
  44  0004 725f5201      	clr	20993
  45                     ; 47     SPI->ICR    = SPI_ICR_RESET_VALUE;
  47  0008 725f5202      	clr	20994
  48                     ; 48     SPI->SR     = SPI_SR_RESET_VALUE;
  50  000c 35025203      	mov	20995,#2
  51                     ; 49     SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  53  0010 35075205      	mov	20997,#7
  54                     ; 50 }
  57  0014 81            	ret
 373                     ; 65 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, u8 CRCPolynomial)
 373                     ; 66 {
 374                     	switch	.text
 375  0015               _SPI_Init:
 377  0015 89            	pushw	x
 378       00000000      OFST:	set	0
 381                     ; 68     assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 383                     ; 69     assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 385                     ; 70     assert_param(IS_SPI_MODE_OK(Mode));
 387                     ; 71     assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 389                     ; 72     assert_param(IS_SPI_PHASE_OK(ClockPhase));
 391                     ; 73     assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 393                     ; 74     assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 395                     ; 75     assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 397                     ; 78     SPI->CR1 = (u8)((u8)(FirstBit) |
 397                     ; 79                     (u8)(BaudRatePrescaler) |
 397                     ; 80                     (u8)(ClockPolarity) |
 397                     ; 81                     (u8)(ClockPhase));
 399  0016 9f            	ld	a,xl
 400  0017 1a01          	or	a,(OFST+1,sp)
 401  0019 1a06          	or	a,(OFST+6,sp)
 402  001b 1a07          	or	a,(OFST+7,sp)
 403  001d c75200        	ld	20992,a
 404                     ; 84     SPI->CR2 = (u8)((u8)(Data_Direction) | (u8)(Slave_Management));
 406  0020 7b08          	ld	a,(OFST+8,sp)
 407  0022 1a09          	or	a,(OFST+9,sp)
 408  0024 c75201        	ld	20993,a
 409                     ; 86     if (Mode == SPI_MODE_MASTER)
 411  0027 7b05          	ld	a,(OFST+5,sp)
 412  0029 a104          	cp	a,#4
 413  002b 2606          	jrne	L302
 414                     ; 88         SPI->CR2 |= (u8)SPI_CR2_SSI;
 416  002d 72105201      	bset	20993,#0
 418  0031 2004          	jra	L502
 419  0033               L302:
 420                     ; 92         SPI->CR2 &= (u8)~(SPI_CR2_SSI);
 422  0033 72115201      	bres	20993,#0
 423  0037               L502:
 424                     ; 96     SPI->CR1 |= (u8)(Mode);
 426  0037 c65200        	ld	a,20992
 427  003a 1a05          	or	a,(OFST+5,sp)
 428  003c c75200        	ld	20992,a
 429                     ; 99     SPI->CRCPR = (u8)CRCPolynomial;
 431  003f 7b0a          	ld	a,(OFST+10,sp)
 432  0041 c75205        	ld	20997,a
 433                     ; 100 }
 436  0044 85            	popw	x
 437  0045 81            	ret
 492                     ; 111 void SPI_Cmd(FunctionalState NewState)
 492                     ; 112 {
 493                     	switch	.text
 494  0046               _SPI_Cmd:
 498                     ; 114     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 500                     ; 116     if (NewState != DISABLE)
 502  0046 4d            	tnz	a
 503  0047 2706          	jreq	L532
 504                     ; 118         SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 506  0049 721c5200      	bset	20992,#6
 508  004d 2004          	jra	L732
 509  004f               L532:
 510                     ; 122         SPI->CR1 &= (u8)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 512  004f 721d5200      	bres	20992,#6
 513  0053               L732:
 514                     ; 124 }
 517  0053 81            	ret
 626                     ; 135 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 626                     ; 136 {
 627                     	switch	.text
 628  0054               _SPI_ITConfig:
 630  0054 89            	pushw	x
 631  0055 88            	push	a
 632       00000001      OFST:	set	1
 635                     ; 137     u8 itpos = 0;
 637  0056 0f01          	clr	(OFST+0,sp)
 638                     ; 139     assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 640                     ; 140     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 642                     ; 143     itpos = (u8)((u8)1 << (u8)((u8)SPI_IT & (u8)0x0F));
 644  0058 9e            	ld	a,xh
 645  0059 a40f          	and	a,#15
 646  005b 5f            	clrw	x
 647  005c 97            	ld	xl,a
 648  005d a601          	ld	a,#1
 649  005f 5d            	tnzw	x
 650  0060 2704          	jreq	L41
 651  0062               L61:
 652  0062 48            	sll	a
 653  0063 5a            	decw	x
 654  0064 26fc          	jrne	L61
 655  0066               L41:
 656  0066 6b01          	ld	(OFST+0,sp),a
 657                     ; 145     if (NewState != DISABLE)
 659  0068 0d03          	tnz	(OFST+2,sp)
 660  006a 270a          	jreq	L113
 661                     ; 147         SPI->ICR |= itpos; /* Enable interrupt*/
 663  006c c65202        	ld	a,20994
 664  006f 1a01          	or	a,(OFST+0,sp)
 665  0071 c75202        	ld	20994,a
 667  0074 2009          	jra	L313
 668  0076               L113:
 669                     ; 151         SPI->ICR &= (u8)(~itpos); /* Disable interrupt*/
 671  0076 7b01          	ld	a,(OFST+0,sp)
 672  0078 43            	cpl	a
 673  0079 c45202        	and	a,20994
 674  007c c75202        	ld	20994,a
 675  007f               L313:
 676                     ; 153 }
 679  007f 5b03          	addw	sp,#3
 680  0081 81            	ret
 714                     ; 160 void SPI_SendData(u8 Data)
 714                     ; 161 {
 715                     	switch	.text
 716  0082               _SPI_SendData:
 720                     ; 162     SPI->DR = Data; /* Write in the DR register the data to be sent*/
 722  0082 c75204        	ld	20996,a
 723                     ; 163 }
 726  0085 81            	ret
 749                     ; 171 u8 SPI_ReceiveData(void)
 749                     ; 172 {
 750                     	switch	.text
 751  0086               _SPI_ReceiveData:
 755                     ; 173     return ((u8)SPI->DR); /* Return the data in the DR register*/
 757  0086 c65204        	ld	a,20996
 760  0089 81            	ret
 796                     ; 185 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 796                     ; 186 {
 797                     	switch	.text
 798  008a               _SPI_NSSInternalSoftwareCmd:
 802                     ; 188     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 804                     ; 190     if (NewState != DISABLE)
 806  008a 4d            	tnz	a
 807  008b 2706          	jreq	L163
 808                     ; 192         SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 810  008d 72105201      	bset	20993,#0
 812  0091 2004          	jra	L363
 813  0093               L163:
 814                     ; 196         SPI->CR2 &= (u8)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 816  0093 72115201      	bres	20993,#0
 817  0097               L363:
 818                     ; 198 }
 821  0097 81            	ret
 844                     ; 207 void SPI_TransmitCRC(void)
 844                     ; 208 {
 845                     	switch	.text
 846  0098               _SPI_TransmitCRC:
 850                     ; 209     SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 852  0098 72185201      	bset	20993,#4
 853                     ; 210 }
 856  009c 81            	ret
 893                     ; 221 void SPI_CalculateCRCCmd(FunctionalState NewState)
 893                     ; 222 {
 894                     	switch	.text
 895  009d               _SPI_CalculateCRCCmd:
 897  009d 88            	push	a
 898       00000000      OFST:	set	0
 901                     ; 224     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 903                     ; 227     SPI_Cmd(DISABLE);
 905  009e 4f            	clr	a
 906  009f ada5          	call	_SPI_Cmd
 908                     ; 229     if (NewState != DISABLE)
 910  00a1 0d01          	tnz	(OFST+1,sp)
 911  00a3 2706          	jreq	L314
 912                     ; 231         SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 914  00a5 721a5201      	bset	20993,#5
 916  00a9 2004          	jra	L514
 917  00ab               L314:
 918                     ; 235         SPI->CR2 &= (u8)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 920  00ab 721b5201      	bres	20993,#5
 921  00af               L514:
 922                     ; 237 }
 925  00af 84            	pop	a
 926  00b0 81            	ret
 990                     ; 244 u8 SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 990                     ; 245 {
 991                     	switch	.text
 992  00b1               _SPI_GetCRC:
 994  00b1 88            	push	a
 995       00000001      OFST:	set	1
 998                     ; 246     u8 crcreg = 0;
1000  00b2 0f01          	clr	(OFST+0,sp)
1001                     ; 249     assert_param(IS_SPI_CRC_OK(SPI_CRC));
1003                     ; 251     if (SPI_CRC != SPI_CRC_RX)
1005  00b4 4d            	tnz	a
1006  00b5 2707          	jreq	L154
1007                     ; 253         crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1009  00b7 c65207        	ld	a,20999
1010  00ba 6b01          	ld	(OFST+0,sp),a
1012  00bc 2005          	jra	L354
1013  00be               L154:
1014                     ; 257         crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1016  00be c65206        	ld	a,20998
1017  00c1 6b01          	ld	(OFST+0,sp),a
1018  00c3               L354:
1019                     ; 261     return crcreg;
1021  00c3 7b01          	ld	a,(OFST+0,sp)
1024  00c5 5b01          	addw	sp,#1
1025  00c7 81            	ret
1050                     ; 271 void SPI_ResetCRC(void)
1050                     ; 272 {
1051                     	switch	.text
1052  00c8               _SPI_ResetCRC:
1056                     ; 275     SPI_CalculateCRCCmd(ENABLE);
1058  00c8 a601          	ld	a,#1
1059  00ca add1          	call	_SPI_CalculateCRCCmd
1061                     ; 278     SPI_Cmd(ENABLE);
1063  00cc a601          	ld	a,#1
1064  00ce cd0046        	call	_SPI_Cmd
1066                     ; 279 }
1069  00d1 81            	ret
1093                     ; 287 u8 SPI_GetCRCPolynomial(void)
1093                     ; 288 {
1094                     	switch	.text
1095  00d2               _SPI_GetCRCPolynomial:
1099                     ; 289     return SPI->CRCPR; /* Return the CRC polynomial register */
1101  00d2 c65205        	ld	a,20997
1104  00d5 81            	ret
1160                     ; 298 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1160                     ; 299 {
1161                     	switch	.text
1162  00d6               _SPI_BiDirectionalLineConfig:
1166                     ; 301     assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1168                     ; 303     if (SPI_Direction != SPI_DIRECTION_RX)
1170  00d6 4d            	tnz	a
1171  00d7 2706          	jreq	L325
1172                     ; 305         SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1174  00d9 721c5201      	bset	20993,#6
1176  00dd 2004          	jra	L525
1177  00df               L325:
1178                     ; 309         SPI->CR2 &= (u8)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1180  00df 721d5201      	bres	20993,#6
1181  00e3               L525:
1182                     ; 311 }
1185  00e3 81            	ret
1306                     ; 321 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1306                     ; 322 {
1307                     	switch	.text
1308  00e4               _SPI_GetFlagStatus:
1310  00e4 88            	push	a
1311       00000001      OFST:	set	1
1314                     ; 323     FlagStatus status = RESET;
1316  00e5 0f01          	clr	(OFST+0,sp)
1317                     ; 325     assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1319                     ; 328     if ((SPI->SR & (u8)SPI_FLAG) != (u8)RESET)
1321  00e7 c45203        	and	a,20995
1322  00ea 2706          	jreq	L306
1323                     ; 330         status = SET; /* SPI_FLAG is set */
1325  00ec a601          	ld	a,#1
1326  00ee 6b01          	ld	(OFST+0,sp),a
1328  00f0 2002          	jra	L506
1329  00f2               L306:
1330                     ; 334         status = RESET; /* SPI_FLAG is reset*/
1332  00f2 0f01          	clr	(OFST+0,sp)
1333  00f4               L506:
1334                     ; 338     return status;
1336  00f4 7b01          	ld	a,(OFST+0,sp)
1339  00f6 5b01          	addw	sp,#1
1340  00f8 81            	ret
1375                     ; 357 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1375                     ; 358 {
1376                     	switch	.text
1377  00f9               _SPI_ClearFlag:
1381                     ; 359     assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1383                     ; 361     SPI->SR = (u8)(~SPI_FLAG);
1385  00f9 43            	cpl	a
1386  00fa c75203        	ld	20995,a
1387                     ; 362 }
1390  00fd 81            	ret
1472                     ; 377 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1472                     ; 378 {
1473                     	switch	.text
1474  00fe               _SPI_GetITStatus:
1476  00fe 88            	push	a
1477  00ff 89            	pushw	x
1478       00000002      OFST:	set	2
1481                     ; 379     ITStatus pendingbitstatus = RESET;
1483  0100 7b02          	ld	a,(OFST+0,sp)
1484  0102 97            	ld	xl,a
1485                     ; 380     u8 itpos = 0;
1487  0103 7b01          	ld	a,(OFST-1,sp)
1488  0105 97            	ld	xl,a
1489                     ; 381     u8 itmask1 = 0;
1491  0106 7b02          	ld	a,(OFST+0,sp)
1492  0108 97            	ld	xl,a
1493                     ; 382     u8 itmask2 = 0;
1495  0109 7b02          	ld	a,(OFST+0,sp)
1496  010b 97            	ld	xl,a
1497                     ; 383     u8 enablestatus = 0;
1499  010c 7b02          	ld	a,(OFST+0,sp)
1500  010e 97            	ld	xl,a
1501                     ; 384     assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1503                     ; 386     itpos = (u8)((u8)1 << ((u8)SPI_IT & (u8)0x0F));
1505  010f 7b03          	ld	a,(OFST+1,sp)
1506  0111 a40f          	and	a,#15
1507  0113 5f            	clrw	x
1508  0114 97            	ld	xl,a
1509  0115 a601          	ld	a,#1
1510  0117 5d            	tnzw	x
1511  0118 2704          	jreq	L05
1512  011a               L25:
1513  011a 48            	sll	a
1514  011b 5a            	decw	x
1515  011c 26fc          	jrne	L25
1516  011e               L05:
1517  011e 6b01          	ld	(OFST-1,sp),a
1518                     ; 389     itmask1 = (u8)((u8)SPI_IT >> (u8)4);
1520  0120 7b03          	ld	a,(OFST+1,sp)
1521  0122 4e            	swap	a
1522  0123 a40f          	and	a,#15
1523  0125 6b02          	ld	(OFST+0,sp),a
1524                     ; 391     itmask2 = (u8)((u8)1 << itmask1);
1526  0127 7b02          	ld	a,(OFST+0,sp)
1527  0129 5f            	clrw	x
1528  012a 97            	ld	xl,a
1529  012b a601          	ld	a,#1
1530  012d 5d            	tnzw	x
1531  012e 2704          	jreq	L45
1532  0130               L65:
1533  0130 48            	sll	a
1534  0131 5a            	decw	x
1535  0132 26fc          	jrne	L65
1536  0134               L45:
1537  0134 6b02          	ld	(OFST+0,sp),a
1538                     ; 393     enablestatus = (u8)((u8)SPI->SR & itmask2);
1540  0136 c65203        	ld	a,20995
1541  0139 1402          	and	a,(OFST+0,sp)
1542  013b 6b02          	ld	(OFST+0,sp),a
1543                     ; 395     if (((SPI->ICR & itpos) != RESET) && enablestatus)
1545  013d c65202        	ld	a,20994
1546  0140 1501          	bcp	a,(OFST-1,sp)
1547  0142 270a          	jreq	L766
1549  0144 0d02          	tnz	(OFST+0,sp)
1550  0146 2706          	jreq	L766
1551                     ; 398         pendingbitstatus = SET;
1553  0148 a601          	ld	a,#1
1554  014a 6b02          	ld	(OFST+0,sp),a
1556  014c 2002          	jra	L176
1557  014e               L766:
1558                     ; 403         pendingbitstatus = RESET;
1560  014e 0f02          	clr	(OFST+0,sp)
1561  0150               L176:
1562                     ; 406     return  pendingbitstatus;
1564  0150 7b02          	ld	a,(OFST+0,sp)
1567  0152 5b03          	addw	sp,#3
1568  0154 81            	ret
1613                     ; 424 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1613                     ; 425 {
1614                     	switch	.text
1615  0155               _SPI_ClearITPendingBit:
1617  0155 88            	push	a
1618       00000001      OFST:	set	1
1621                     ; 426     u8 itpos = 0;
1623  0156 0f01          	clr	(OFST+0,sp)
1624                     ; 427     assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1626                     ; 432     itpos = (u8)((u8)1 << (((u8)SPI_IT & (u8)0xF0) >> 4));
1628  0158 a4f0          	and	a,#240
1629  015a 4e            	swap	a
1630  015b a40f          	and	a,#15
1631  015d 5f            	clrw	x
1632  015e 97            	ld	xl,a
1633  015f a601          	ld	a,#1
1634  0161 5d            	tnzw	x
1635  0162 2704          	jreq	L26
1636  0164               L46:
1637  0164 48            	sll	a
1638  0165 5a            	decw	x
1639  0166 26fc          	jrne	L46
1640  0168               L26:
1641  0168 6b01          	ld	(OFST+0,sp),a
1642                     ; 434     SPI->SR = (u8)(~itpos);
1644  016a 7b01          	ld	a,(OFST+0,sp)
1645  016c 43            	cpl	a
1646  016d c75203        	ld	20995,a
1647                     ; 436 }
1650  0170 84            	pop	a
1651  0171 81            	ret
1664                     	xdef	_SPI_ClearITPendingBit
1665                     	xdef	_SPI_GetITStatus
1666                     	xdef	_SPI_ClearFlag
1667                     	xdef	_SPI_GetFlagStatus
1668                     	xdef	_SPI_BiDirectionalLineConfig
1669                     	xdef	_SPI_GetCRCPolynomial
1670                     	xdef	_SPI_ResetCRC
1671                     	xdef	_SPI_GetCRC
1672                     	xdef	_SPI_CalculateCRCCmd
1673                     	xdef	_SPI_TransmitCRC
1674                     	xdef	_SPI_NSSInternalSoftwareCmd
1675                     	xdef	_SPI_ReceiveData
1676                     	xdef	_SPI_SendData
1677                     	xdef	_SPI_ITConfig
1678                     	xdef	_SPI_Cmd
1679                     	xdef	_SPI_Init
1680                     	xdef	_SPI_DeInit
1699                     	end
