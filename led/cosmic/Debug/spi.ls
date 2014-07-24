   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  43                     ; 12 void delay(void)
  43                     ; 13 {
  45                     	switch	.text
  46  0000               _delay:
  48  0000 88            	push	a
  49       00000001      OFST:	set	1
  52                     ; 15 	for (i = 0; i < 50; i++)
  54  0001 0f01          	clr	(OFST+0,sp)
  55  0003               L72:
  59  0003 0c01          	inc	(OFST+0,sp)
  62  0005 7b01          	ld	a,(OFST+0,sp)
  63  0007 a132          	cp	a,#50
  64  0009 25f8          	jrult	L72
  65                     ; 19 }
  68  000b 84            	pop	a
  69  000c 81            	ret
  95                     ; 27 void SPI_H_Init(void)
  95                     ; 28 {
  96                     	switch	.text
  97  000d               _SPI_H_Init:
 101                     ; 29 	SPI_DeInit();
 103  000d cd0000        	call	_SPI_DeInit
 105                     ; 30 	SPI_Init( SPI_FIRSTBIT_MSB,                                //MSB
 105                     ; 31 						SPI_BAUDRATEPRESCALER_16,                        //SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, 
 105                     ; 32 						SPI_MODE_MASTER,                                //SPI_Mode_TypeDef Mode, 
 105                     ; 33 						SPI_CLOCKPOLARITY_HIGH,                         //SPI_ClockPolarity_TypeDef ClockPolarity, 
 105                     ; 34 						SPI_CLOCKPHASE_1EDGE,                           //SPI_ClockPhase_TypeDef ClockPhase, 
 105                     ; 35 						SPI_DATADIRECTION_2LINES_FULLDUPLEX,            //SPI_DataDirection_TypeDef Data_Direction,
 105                     ; 36 						SPI_NSS_SOFT,                                   //SPI_NSS_TypeDef Slave_Management, 
 105                     ; 37 						(u8)0x07);
 107  0010 4b07          	push	#7
 108  0012 4b02          	push	#2
 109  0014 4b00          	push	#0
 110  0016 4b00          	push	#0
 111  0018 4b02          	push	#2
 112  001a 4b04          	push	#4
 113  001c ae0018        	ldw	x,#24
 114  001f 4f            	clr	a
 115  0020 95            	ld	xh,a
 116  0021 cd0000        	call	_SPI_Init
 118  0024 5b06          	addw	sp,#6
 119                     ; 38 	SPI_Cmd(ENABLE);
 121  0026 a601          	ld	a,#1
 122  0028 cd0000        	call	_SPI_Cmd
 124                     ; 39 }
 127  002b 81            	ret
1243                     ; 47 void SPI_W_R_Byte(MesgWStructDef *data)
1243                     ; 48 {
1244                     	switch	.text
1245  002c               _SPI_W_R_Byte:
1247  002c 89            	pushw	x
1248       00000000      OFST:	set	0
1251                     ; 49 	GPIO_CS0();
1253  002d cd0000        	call	_GPIO_CS0
1255                     ; 50 	delay();
1257  0030 adce          	call	_delay
1260  0032               L567:
1261                     ; 52 	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
1263  0032 a602          	ld	a,#2
1264  0034 cd0000        	call	_SPI_GetFlagStatus
1266  0037 4d            	tnz	a
1267  0038 27f8          	jreq	L567
1268                     ; 53 	SPI_SendData(data->MesgDef.Mes24_31);	
1270  003a 1e01          	ldw	x,(OFST+1,sp)
1271  003c f6            	ld	a,(x)
1272  003d cd0000        	call	_SPI_SendData
1275  0040               L377:
1276                     ; 54 	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
1278  0040 a601          	ld	a,#1
1279  0042 cd0000        	call	_SPI_GetFlagStatus
1281  0045 4d            	tnz	a
1282  0046 27f8          	jreq	L377
1283                     ; 55 	RMesg.MesgDef.Mes24_31 = SPI_ReceiveData();	
1285  0048 cd0000        	call	_SPI_ReceiveData
1287  004b b700          	ld	_RMesg,a
1289  004d               L3001:
1290                     ; 57 	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
1292  004d a602          	ld	a,#2
1293  004f cd0000        	call	_SPI_GetFlagStatus
1295  0052 4d            	tnz	a
1296  0053 27f8          	jreq	L3001
1297                     ; 58 	SPI_SendData(data->MesgDef.Mes16_23);
1299  0055 1e01          	ldw	x,(OFST+1,sp)
1300  0057 e601          	ld	a,(1,x)
1301  0059 cd0000        	call	_SPI_SendData
1304  005c               L1101:
1305                     ; 59 	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
1307  005c a601          	ld	a,#1
1308  005e cd0000        	call	_SPI_GetFlagStatus
1310  0061 4d            	tnz	a
1311  0062 27f8          	jreq	L1101
1312                     ; 60 	RMesg.MesgDef.Mes16_23 = SPI_ReceiveData();
1314  0064 cd0000        	call	_SPI_ReceiveData
1316  0067 b701          	ld	_RMesg+1,a
1318  0069               L1201:
1319                     ; 62 	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
1321  0069 a602          	ld	a,#2
1322  006b cd0000        	call	_SPI_GetFlagStatus
1324  006e 4d            	tnz	a
1325  006f 27f8          	jreq	L1201
1326                     ; 63 	SPI_SendData(data->MesgDef.Mes8_15);
1328  0071 1e01          	ldw	x,(OFST+1,sp)
1329  0073 e602          	ld	a,(2,x)
1330  0075 cd0000        	call	_SPI_SendData
1333  0078               L7201:
1334                     ; 64 	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
1336  0078 a601          	ld	a,#1
1337  007a cd0000        	call	_SPI_GetFlagStatus
1339  007d 4d            	tnz	a
1340  007e 27f8          	jreq	L7201
1341                     ; 65 	RMesg.MesgDef.Mes8_15 = SPI_ReceiveData();	
1343  0080 cd0000        	call	_SPI_ReceiveData
1345  0083 b702          	ld	_RMesg+2,a
1347  0085               L7301:
1348                     ; 67 	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
1350  0085 a602          	ld	a,#2
1351  0087 cd0000        	call	_SPI_GetFlagStatus
1353  008a 4d            	tnz	a
1354  008b 27f8          	jreq	L7301
1355                     ; 68 	SPI_SendData(data->MesgDef.Mes0_7);
1357  008d 1e01          	ldw	x,(OFST+1,sp)
1358  008f e603          	ld	a,(3,x)
1359  0091 cd0000        	call	_SPI_SendData
1362  0094               L5401:
1363                     ; 69 	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
1365  0094 a601          	ld	a,#1
1366  0096 cd0000        	call	_SPI_GetFlagStatus
1368  0099 4d            	tnz	a
1369  009a 27f8          	jreq	L5401
1370                     ; 70 	RMesg.MesgDef.Mes0_7 = SPI_ReceiveData();
1372  009c cd0000        	call	_SPI_ReceiveData
1374  009f b703          	ld	_RMesg+3,a
1375                     ; 72 	delay();
1377  00a1 cd0000        	call	_delay
1379                     ; 73 	GPIO_CS1;
1381  00a4 ce0000        	ldw	x,_GPIO_CS1
1382                     ; 74 	delay();	
1384  00a7 cd0000        	call	_delay
1386                     ; 75 }
1389  00aa 85            	popw	x
1390  00ab 81            	ret
1417                     ; 82 void ProportionalValve1_Init(void)
1417                     ; 83 {
1418                     	switch	.text
1419  00ac               _ProportionalValve1_Init:
1423                     ; 85 	Mesg.SPI_W_Mesg = 0;
1425  00ac ae0000        	ldw	x,#0
1426  00af bf02          	ldw	_Mesg+2,x
1427  00b1 ae0000        	ldw	x,#0
1428  00b4 bf00          	ldw	_Mesg,x
1429                     ; 86 	SPI_W_R_Byte(&Mesg);
1431  00b6 ae0000        	ldw	x,#_Mesg
1432  00b9 cd002c        	call	_SPI_W_R_Byte
1434                     ; 88 	Mesg.SPI_W_Mesg = 0;
1436  00bc ae0000        	ldw	x,#0
1437  00bf bf02          	ldw	_Mesg+2,x
1438  00c1 ae0000        	ldw	x,#0
1439  00c4 bf00          	ldw	_Mesg,x
1440                     ; 89 	Mesg.Mesg7RegDef.write     = 1;
1442  00c6 721e0000      	bset	_Mesg,#7
1443                     ; 90 	Mesg.Mesg7RegDef.MSG_ID    = 7;
1445  00ca b600          	ld	a,_Mesg
1446  00cc a483          	and	a,#131
1447  00ce aa1c          	or	a,#28
1448  00d0 b700          	ld	_Mesg,a
1449                     ; 91 	Mesg.Mesg7RegDef.CM        = 0;
1451  00d2 b601          	ld	a,_Mesg+1
1452  00d4 a40f          	and	a,#15
1453  00d6 b701          	ld	_Mesg+1,a
1454                     ; 92 	Mesg.Mesg7RegDef.FM        = 8;
1456  00d8 b601          	ld	a,_Mesg+1
1457  00da a4f0          	and	a,#240
1458  00dc aa08          	or	a,#8
1459  00de b701          	ld	_Mesg+1,a
1460                     ; 93 	Mesg.Mesg7RegDef.FMR       = 0;
1462  00e0 721f0002      	bres	_Mesg+2,#7
1463                     ; 94 	Mesg.Mesg7RegDef.FME       = 0;
1465  00e4 721d0002      	bres	_Mesg+2,#6
1466                     ; 95 	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
1468  00e8 72190002      	bres	_Mesg+2,#4
1469  00ec 721b0002      	bres	_Mesg+2,#5
1470                     ; 96 	Mesg.Mesg7RegDef.AZDisable = 0;
1472  00f0 72170002      	bres	_Mesg+2,#3
1473                     ; 97 	SPI_W_R_Byte(&Mesg);
1475  00f4 ae0000        	ldw	x,#_Mesg
1476  00f7 cd002c        	call	_SPI_W_R_Byte
1478                     ; 98 	delay();
1480  00fa cd0000        	call	_delay
1482                     ; 99 	delay();
1484  00fd cd0000        	call	_delay
1486                     ; 101 	Mesg.SPI_W_Mesg = 0;
1488  0100 ae0000        	ldw	x,#0
1489  0103 bf02          	ldw	_Mesg+2,x
1490  0105 ae0000        	ldw	x,#0
1491  0108 bf00          	ldw	_Mesg,x
1492                     ; 102 	Mesg.Mesg3RegDef.Cur_Set   = 0;			
1494  010a 3f03          	clr	_Mesg+3
1495  010c b602          	ld	a,_Mesg+2
1496  010e a4f8          	and	a,#248
1497  0110 b702          	ld	_Mesg+2,a
1498                     ; 103 	Mesg.Mesg3RegDef.Dit_EN    = 1;
1500  0112 72160002      	bset	_Mesg+2,#3
1501                     ; 104 	Mesg.Mesg3RegDef.Step_Size = 0;
1503  0116 b602          	ld	a,_Mesg+2
1504  0118 a40f          	and	a,#15
1505  011a b702          	ld	_Mesg+2,a
1506  011c b601          	ld	a,_Mesg+1
1507  011e a4c0          	and	a,#192
1508  0120 b701          	ld	_Mesg+1,a
1509                     ; 105 	Mesg.Mesg3RegDef.ON_OFF    = 0;
1511  0122 721d0001      	bres	_Mesg+1,#6
1512                     ; 106 	Mesg.Mesg3RegDef.EN        = 1;  
1514  0126 721e0001      	bset	_Mesg+1,#7
1515                     ; 107 	Mesg.Mesg3RegDef.CHN       = 0;
1517  012a 72110000      	bres	_Mesg,#0
1518  012e 72130000      	bres	_Mesg,#1
1519                     ; 108 	Mesg.Mesg3RegDef.MSG_ID    = 3; 
1521  0132 b600          	ld	a,_Mesg
1522  0134 a483          	and	a,#131
1523  0136 aa0c          	or	a,#12
1524  0138 b700          	ld	_Mesg,a
1525                     ; 109 	Mesg.Mesg3RegDef.write     = 1;
1527  013a 721e0000      	bset	_Mesg,#7
1528                     ; 110 	SPI_W_R_Byte(&Mesg);
1530  013e ae0000        	ldw	x,#_Mesg
1531  0141 cd002c        	call	_SPI_W_R_Byte
1533                     ; 111 	delay();
1535  0144 cd0000        	call	_delay
1537                     ; 112 	delay();
1539  0147 cd0000        	call	_delay
1541                     ; 114 	Mesg.SPI_W_Mesg = 0;
1543  014a ae0000        	ldw	x,#0
1544  014d bf02          	ldw	_Mesg+2,x
1545  014f ae0000        	ldw	x,#0
1546  0152 bf00          	ldw	_Mesg,x
1547                     ; 115 	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1.5KHz
1549  0154 b603          	ld	a,_Mesg+3
1550  0156 a400          	and	a,#0
1551  0158 aa9b          	or	a,#155
1552  015a b703          	ld	_Mesg+3,a
1553  015c b602          	ld	a,_Mesg+2
1554  015e a4c0          	and	a,#192
1555  0160 aa02          	or	a,#2
1556  0162 b702          	ld	_Mesg+2,a
1557                     ; 116 	Mesg.Mesg1RegDef.CHN    = 0;
1559  0164 72110000      	bres	_Mesg,#0
1560  0168 72130000      	bres	_Mesg,#1
1561                     ; 117 	Mesg.Mesg1RegDef.MSG_ID = 1;
1563  016c b600          	ld	a,_Mesg
1564  016e a483          	and	a,#131
1565  0170 aa04          	or	a,#4
1566  0172 b700          	ld	_Mesg,a
1567                     ; 118 	Mesg.Mesg1RegDef.write  = 1;
1569  0174 721e0000      	bset	_Mesg,#7
1570                     ; 119 	SPI_W_R_Byte(&Mesg);
1572  0178 ae0000        	ldw	x,#_Mesg
1573  017b cd002c        	call	_SPI_W_R_Byte
1575                     ; 120 	delay();
1577  017e cd0000        	call	_delay
1579                     ; 121 	delay();
1581  0181 cd0000        	call	_delay
1583                     ; 123 	Mesg.SPI_W_Mesg = 0;
1585  0184 ae0000        	ldw	x,#0
1586  0187 bf02          	ldw	_Mesg+2,x
1587  0189 ae0000        	ldw	x,#0
1588  018c bf00          	ldw	_Mesg,x
1589                     ; 124 	Mesg.Mesg2RegDef.write  = 1;
1591  018e 721e0000      	bset	_Mesg,#7
1592                     ; 125 	Mesg.Mesg2RegDef.MSG_ID = 2;
1594  0192 b600          	ld	a,_Mesg
1595  0194 a483          	and	a,#131
1596  0196 aa08          	or	a,#8
1597  0198 b700          	ld	_Mesg,a
1598                     ; 126 	Mesg.Mesg2RegDef.CHN    = 0;
1600  019a 72110000      	bres	_Mesg,#0
1601  019e 72130000      	bres	_Mesg,#1
1602                     ; 127 	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
1604  01a2 b603          	ld	a,_Mesg+3
1605  01a4 a4e0          	and	a,#224
1606  01a6 b703          	ld	_Mesg+3,a
1607                     ; 128 	SPI_W_R_Byte(&Mesg);
1609  01a8 ae0000        	ldw	x,#_Mesg
1610  01ab cd002c        	call	_SPI_W_R_Byte
1612                     ; 129 	delay();
1614  01ae cd0000        	call	_delay
1616                     ; 130 	delay();
1618  01b1 cd0000        	call	_delay
1620                     ; 132 	Mesg.SPI_W_Mesg = 0;
1622  01b4 ae0000        	ldw	x,#0
1623  01b7 bf02          	ldw	_Mesg+2,x
1624  01b9 ae0000        	ldw	x,#0
1625  01bc bf00          	ldw	_Mesg,x
1626                     ; 133 	Mesg.Mesg4RegDef.write    = 1;
1628  01be 721e0000      	bset	_Mesg,#7
1629                     ; 134 	Mesg.Mesg4RegDef.MSG_ID   = 4;
1631  01c2 b600          	ld	a,_Mesg
1632  01c4 a483          	and	a,#131
1633  01c6 aa10          	or	a,#16
1634  01c8 b700          	ld	_Mesg,a
1635                     ; 135 	Mesg.Mesg4RegDef.CHN      = 0;
1637  01ca 72110000      	bres	_Mesg,#0
1638  01ce 72130000      	bres	_Mesg,#1
1639                     ; 136 	Mesg.Mesg4RegDef.Dit_Step = 0;
1641  01d2 b603          	ld	a,_Mesg+3
1642  01d4 a4c0          	and	a,#192
1643  01d6 b703          	ld	_Mesg+3,a
1644                     ; 137 	SPI_W_R_Byte(&Mesg);
1646  01d8 ae0000        	ldw	x,#_Mesg
1647  01db cd002c        	call	_SPI_W_R_Byte
1649                     ; 138 	delay();
1651  01de cd0000        	call	_delay
1653                     ; 139 	delay();
1655  01e1 cd0000        	call	_delay
1657                     ; 141 	Mesg.SPI_W_Mesg = 0;
1659  01e4 ae0000        	ldw	x,#0
1660  01e7 bf02          	ldw	_Mesg+2,x
1661  01e9 ae0000        	ldw	x,#0
1662  01ec bf00          	ldw	_Mesg,x
1663                     ; 142 	Mesg.Mesg5RegDef.KI     = 240; 
1665  01ee b603          	ld	a,_Mesg+3
1666  01f0 a400          	and	a,#0
1667  01f2 aaf0          	or	a,#240
1668  01f4 b703          	ld	_Mesg+3,a
1669  01f6 b602          	ld	a,_Mesg+2
1670  01f8 a4f0          	and	a,#240
1671  01fa b702          	ld	_Mesg+2,a
1672                     ; 143 	Mesg.Mesg5RegDef.KP     = 246;
1674  01fc b602          	ld	a,_Mesg+2
1675  01fe a40f          	and	a,#15
1676  0200 aa60          	or	a,#96
1677  0202 b702          	ld	_Mesg+2,a
1678  0204 b601          	ld	a,_Mesg+1
1679  0206 a400          	and	a,#0
1680  0208 aa0f          	or	a,#15
1681  020a b701          	ld	_Mesg+1,a
1682                     ; 144 	Mesg.Mesg5RegDef.CHN    = 0;
1684  020c 72110000      	bres	_Mesg,#0
1685  0210 72130000      	bres	_Mesg,#1
1686                     ; 145 	Mesg.Mesg5RegDef.MSG_ID = 5;
1688  0214 b600          	ld	a,_Mesg
1689  0216 a483          	and	a,#131
1690  0218 aa14          	or	a,#20
1691  021a b700          	ld	_Mesg,a
1692                     ; 146 	Mesg.Mesg5RegDef.write  = 1;
1694  021c 721e0000      	bset	_Mesg,#7
1695                     ; 147 	SPI_W_R_Byte(&Mesg);
1697  0220 ae0000        	ldw	x,#_Mesg
1698  0223 cd002c        	call	_SPI_W_R_Byte
1700                     ; 148 	delay();
1702  0226 cd0000        	call	_delay
1704                     ; 149 	delay();
1706  0229 cd0000        	call	_delay
1708                     ; 151 	Mesg.SPI_W_Mesg = 0;
1710  022c ae0000        	ldw	x,#0
1711  022f bf02          	ldw	_Mesg+2,x
1712  0231 ae0000        	ldw	x,#0
1713  0234 bf00          	ldw	_Mesg,x
1714                     ; 152 	Mesg.Mesg6RegDef.write    = 1;
1716  0236 721e0000      	bset	_Mesg,#7
1717                     ; 153 	Mesg.Mesg6RegDef.CHN      = 0;
1719  023a 72110000      	bres	_Mesg,#0
1720  023e 72130000      	bres	_Mesg,#1
1721                     ; 154 	Mesg.Mesg6RegDef.MSG_ID   = 6;
1723  0242 b600          	ld	a,_Mesg
1724  0244 a483          	and	a,#131
1725  0246 aa18          	or	a,#24
1726  0248 b700          	ld	_Mesg,a
1727                     ; 155 	Mesg.Mesg6RegDef.TMThresh = 200;
1729  024a b602          	ld	a,_Mesg+2
1730  024c a40f          	and	a,#15
1731  024e aa80          	or	a,#128
1732  0250 b702          	ld	_Mesg+2,a
1733  0252 b601          	ld	a,_Mesg+1
1734  0254 a480          	and	a,#128
1735  0256 aa0c          	or	a,#12
1736  0258 b701          	ld	_Mesg+1,a
1737                     ; 156 	Mesg.Mesg6RegDef.Preload  = 5;
1739  025a b603          	ld	a,_Mesg+3
1740  025c a400          	and	a,#0
1741  025e aa05          	or	a,#5
1742  0260 b703          	ld	_Mesg+3,a
1743  0262 b602          	ld	a,_Mesg+2
1744  0264 a4f0          	and	a,#240
1745  0266 b702          	ld	_Mesg+2,a
1746                     ; 157 	SPI_W_R_Byte(&Mesg);
1748  0268 ae0000        	ldw	x,#_Mesg
1749  026b cd002c        	call	_SPI_W_R_Byte
1751                     ; 158 	delay();
1753  026e cd0000        	call	_delay
1755                     ; 159 	delay();
1757  0271 cd0000        	call	_delay
1759                     ; 160 	Mesg.SPI_W_Mesg = 0;
1761  0274 ae0000        	ldw	x,#0
1762  0277 bf02          	ldw	_Mesg+2,x
1763  0279 ae0000        	ldw	x,#0
1764  027c bf00          	ldw	_Mesg,x
1765                     ; 161 	Mesg.Mesg9RegDef.write  = 1;
1767  027e 721e0000      	bset	_Mesg,#7
1768                     ; 162 	Mesg.Mesg9RegDef.MSG_ID = 9;
1770  0282 b600          	ld	a,_Mesg
1771  0284 a483          	and	a,#131
1772  0286 aa24          	or	a,#36
1773  0288 b700          	ld	_Mesg,a
1774                     ; 163 	SPI_W_R_Byte(&Mesg);
1776  028a ae0000        	ldw	x,#_Mesg
1777  028d cd002c        	call	_SPI_W_R_Byte
1779                     ; 164 	delay();delay();delay();delay();
1781  0290 cd0000        	call	_delay
1785  0293 cd0000        	call	_delay
1789  0296 cd0000        	call	_delay
1793  0299 cd0000        	call	_delay
1795                     ; 165 	SPI_W_R_Byte(&Mesg);
1797  029c ae0000        	ldw	x,#_Mesg
1798  029f cd002c        	call	_SPI_W_R_Byte
1800                     ; 166 	delay();
1802  02a2 cd0000        	call	_delay
1804                     ; 167 	delay();
1806  02a5 cd0000        	call	_delay
1808                     ; 169 	Mesg.SPI_W_Mesg = 0;
1810  02a8 ae0000        	ldw	x,#0
1811  02ab bf02          	ldw	_Mesg+2,x
1812  02ad ae0000        	ldw	x,#0
1813  02b0 bf00          	ldw	_Mesg,x
1814                     ; 170 	Mesg.Mesg10RegDef.write  = 1;
1816  02b2 721e0000      	bset	_Mesg,#7
1817                     ; 171 	Mesg.Mesg10RegDef.MSG_ID = 10;
1819  02b6 b600          	ld	a,_Mesg
1820  02b8 a483          	and	a,#131
1821  02ba aa28          	or	a,#40
1822  02bc b700          	ld	_Mesg,a
1823                     ; 172 	Mesg.Mesg10RegDef.CHN    = 0;
1825  02be 72110000      	bres	_Mesg,#0
1826  02c2 72130000      	bres	_Mesg,#1
1827                     ; 173 	SPI_W_R_Byte(&Mesg);
1829  02c6 ae0000        	ldw	x,#_Mesg
1830  02c9 cd002c        	call	_SPI_W_R_Byte
1832                     ; 174 	delay();
1834  02cc cd0000        	call	_delay
1836                     ; 175 	delay();
1838  02cf cd0000        	call	_delay
1840                     ; 176 }
1843  02d2 81            	ret
1870                     ; 183 void ProportionalValve2_Init(void)
1870                     ; 184 {
1871                     	switch	.text
1872  02d3               _ProportionalValve2_Init:
1876                     ; 186 	Mesg.SPI_W_Mesg = 0;
1878  02d3 ae0000        	ldw	x,#0
1879  02d6 bf02          	ldw	_Mesg+2,x
1880  02d8 ae0000        	ldw	x,#0
1881  02db bf00          	ldw	_Mesg,x
1882                     ; 187 	SPI_W_R_Byte(&Mesg);
1884  02dd ae0000        	ldw	x,#_Mesg
1885  02e0 cd002c        	call	_SPI_W_R_Byte
1887                     ; 189 	Mesg.SPI_W_Mesg = 0;
1889  02e3 ae0000        	ldw	x,#0
1890  02e6 bf02          	ldw	_Mesg+2,x
1891  02e8 ae0000        	ldw	x,#0
1892  02eb bf00          	ldw	_Mesg,x
1893                     ; 190 	Mesg.Mesg7RegDef.write     = 1;
1895  02ed 721e0000      	bset	_Mesg,#7
1896                     ; 191 	Mesg.Mesg7RegDef.MSG_ID    = 7;
1898  02f1 b600          	ld	a,_Mesg
1899  02f3 a483          	and	a,#131
1900  02f5 aa1c          	or	a,#28
1901  02f7 b700          	ld	_Mesg,a
1902                     ; 192 	Mesg.Mesg7RegDef.CM        = 0;
1904  02f9 b601          	ld	a,_Mesg+1
1905  02fb a40f          	and	a,#15
1906  02fd b701          	ld	_Mesg+1,a
1907                     ; 193 	Mesg.Mesg7RegDef.FM        = 0;
1909  02ff b601          	ld	a,_Mesg+1
1910  0301 a4f0          	and	a,#240
1911  0303 b701          	ld	_Mesg+1,a
1912                     ; 194 	Mesg.Mesg7RegDef.FMR       = 0;
1914  0305 721f0002      	bres	_Mesg+2,#7
1915                     ; 195 	Mesg.Mesg7RegDef.FME       = 0;
1917  0309 721d0002      	bres	_Mesg+2,#6
1918                     ; 196 	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
1920  030d 72190002      	bres	_Mesg+2,#4
1921  0311 721b0002      	bres	_Mesg+2,#5
1922                     ; 197 	Mesg.Mesg7RegDef.AZDisable = 0;
1924  0315 72170002      	bres	_Mesg+2,#3
1925                     ; 198 	SPI_W_R_Byte(&Mesg);
1927  0319 ae0000        	ldw	x,#_Mesg
1928  031c cd002c        	call	_SPI_W_R_Byte
1930                     ; 199 	delay();
1932  031f cd0000        	call	_delay
1934                     ; 200 	delay();
1936  0322 cd0000        	call	_delay
1938                     ; 202 	Mesg.SPI_W_Mesg = 0;
1940  0325 ae0000        	ldw	x,#0
1941  0328 bf02          	ldw	_Mesg+2,x
1942  032a ae0000        	ldw	x,#0
1943  032d bf00          	ldw	_Mesg,x
1944                     ; 203 	Mesg.Mesg3RegDef.Cur_Set   = 0;			/* Current = 200mA */
1946  032f 3f03          	clr	_Mesg+3
1947  0331 b602          	ld	a,_Mesg+2
1948  0333 a4f8          	and	a,#248
1949  0335 b702          	ld	_Mesg+2,a
1950                     ; 204 	Mesg.Mesg3RegDef.Dit_EN    = 1;
1952  0337 72160002      	bset	_Mesg+2,#3
1953                     ; 205 	Mesg.Mesg3RegDef.Step_Size = 0;
1955  033b b602          	ld	a,_Mesg+2
1956  033d a40f          	and	a,#15
1957  033f b702          	ld	_Mesg+2,a
1958  0341 b601          	ld	a,_Mesg+1
1959  0343 a4c0          	and	a,#192
1960  0345 b701          	ld	_Mesg+1,a
1961                     ; 206 	Mesg.Mesg3RegDef.ON_OFF    = 0;
1963  0347 721d0001      	bres	_Mesg+1,#6
1964                     ; 207 	Mesg.Mesg3RegDef.EN        = 1;  
1966  034b 721e0001      	bset	_Mesg+1,#7
1967                     ; 208 	Mesg.Mesg3RegDef.CHN       = 1;
1969  034f 72100000      	bset	_Mesg,#0
1970  0353 72130000      	bres	_Mesg,#1
1971                     ; 209 	Mesg.Mesg3RegDef.MSG_ID    = 3; 
1973  0357 b600          	ld	a,_Mesg
1974  0359 a483          	and	a,#131
1975  035b aa0c          	or	a,#12
1976  035d b700          	ld	_Mesg,a
1977                     ; 210 	Mesg.Mesg3RegDef.write     = 1;
1979  035f 721e0000      	bset	_Mesg,#7
1980                     ; 211 	SPI_W_R_Byte(&Mesg);
1982  0363 ae0000        	ldw	x,#_Mesg
1983  0366 cd002c        	call	_SPI_W_R_Byte
1985                     ; 212 	delay();
1987  0369 cd0000        	call	_delay
1989                     ; 213 	delay();
1991  036c cd0000        	call	_delay
1993                     ; 215 	Mesg.SPI_W_Mesg = 0;
1995  036f ae0000        	ldw	x,#0
1996  0372 bf02          	ldw	_Mesg+2,x
1997  0374 ae0000        	ldw	x,#0
1998  0377 bf00          	ldw	_Mesg,x
1999                     ; 216 	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1KHz
2001  0379 b603          	ld	a,_Mesg+3
2002  037b a400          	and	a,#0
2003  037d aa9b          	or	a,#155
2004  037f b703          	ld	_Mesg+3,a
2005  0381 b602          	ld	a,_Mesg+2
2006  0383 a4c0          	and	a,#192
2007  0385 aa02          	or	a,#2
2008  0387 b702          	ld	_Mesg+2,a
2009                     ; 217 	Mesg.Mesg1RegDef.CHN    = 1;
2011  0389 72100000      	bset	_Mesg,#0
2012  038d 72130000      	bres	_Mesg,#1
2013                     ; 218 	Mesg.Mesg1RegDef.MSG_ID = 1;
2015  0391 b600          	ld	a,_Mesg
2016  0393 a483          	and	a,#131
2017  0395 aa04          	or	a,#4
2018  0397 b700          	ld	_Mesg,a
2019                     ; 219 	Mesg.Mesg1RegDef.write  = 1;
2021  0399 721e0000      	bset	_Mesg,#7
2022                     ; 220 	SPI_W_R_Byte(&Mesg);
2024  039d ae0000        	ldw	x,#_Mesg
2025  03a0 cd002c        	call	_SPI_W_R_Byte
2027                     ; 221 	delay();
2029  03a3 cd0000        	call	_delay
2031                     ; 222 	delay();
2033  03a6 cd0000        	call	_delay
2035                     ; 224 	Mesg.SPI_W_Mesg = 0;
2037  03a9 ae0000        	ldw	x,#0
2038  03ac bf02          	ldw	_Mesg+2,x
2039  03ae ae0000        	ldw	x,#0
2040  03b1 bf00          	ldw	_Mesg,x
2041                     ; 225 	Mesg.Mesg2RegDef.write  = 1;
2043  03b3 721e0000      	bset	_Mesg,#7
2044                     ; 226 	Mesg.Mesg2RegDef.MSG_ID = 2;
2046  03b7 b600          	ld	a,_Mesg
2047  03b9 a483          	and	a,#131
2048  03bb aa08          	or	a,#8
2049  03bd b700          	ld	_Mesg,a
2050                     ; 227 	Mesg.Mesg2RegDef.CHN    = 1;
2052  03bf 72100000      	bset	_Mesg,#0
2053  03c3 72130000      	bres	_Mesg,#1
2054                     ; 228 	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
2056  03c7 b603          	ld	a,_Mesg+3
2057  03c9 a4e0          	and	a,#224
2058  03cb b703          	ld	_Mesg+3,a
2059                     ; 229 	SPI_W_R_Byte(&Mesg);
2061  03cd ae0000        	ldw	x,#_Mesg
2062  03d0 cd002c        	call	_SPI_W_R_Byte
2064                     ; 230 	delay();
2066  03d3 cd0000        	call	_delay
2068                     ; 231 	delay();
2070  03d6 cd0000        	call	_delay
2072                     ; 233 	Mesg.SPI_W_Mesg = 0;
2074  03d9 ae0000        	ldw	x,#0
2075  03dc bf02          	ldw	_Mesg+2,x
2076  03de ae0000        	ldw	x,#0
2077  03e1 bf00          	ldw	_Mesg,x
2078                     ; 234 	Mesg.Mesg4RegDef.write    = 1;
2080  03e3 721e0000      	bset	_Mesg,#7
2081                     ; 235 	Mesg.Mesg4RegDef.MSG_ID   = 4;
2083  03e7 b600          	ld	a,_Mesg
2084  03e9 a483          	and	a,#131
2085  03eb aa10          	or	a,#16
2086  03ed b700          	ld	_Mesg,a
2087                     ; 236 	Mesg.Mesg4RegDef.CHN      = 1;
2089  03ef 72100000      	bset	_Mesg,#0
2090  03f3 72130000      	bres	_Mesg,#1
2091                     ; 237 	Mesg.Mesg4RegDef.Dit_Step = 0;
2093  03f7 b603          	ld	a,_Mesg+3
2094  03f9 a4c0          	and	a,#192
2095  03fb b703          	ld	_Mesg+3,a
2096                     ; 238 	SPI_W_R_Byte(&Mesg);
2098  03fd ae0000        	ldw	x,#_Mesg
2099  0400 cd002c        	call	_SPI_W_R_Byte
2101                     ; 239 	delay();
2103  0403 cd0000        	call	_delay
2105                     ; 240 	delay();
2107  0406 cd0000        	call	_delay
2109                     ; 242 	Mesg.SPI_W_Mesg = 0;
2111  0409 ae0000        	ldw	x,#0
2112  040c bf02          	ldw	_Mesg+2,x
2113  040e ae0000        	ldw	x,#0
2114  0411 bf00          	ldw	_Mesg,x
2115                     ; 243 	Mesg.Mesg5RegDef.KI     = 215; 
2117  0413 b603          	ld	a,_Mesg+3
2118  0415 a400          	and	a,#0
2119  0417 aad7          	or	a,#215
2120  0419 b703          	ld	_Mesg+3,a
2121  041b b602          	ld	a,_Mesg+2
2122  041d a4f0          	and	a,#240
2123  041f b702          	ld	_Mesg+2,a
2124                     ; 244 	Mesg.Mesg5RegDef.KP     = 115;
2126  0421 b602          	ld	a,_Mesg+2
2127  0423 a40f          	and	a,#15
2128  0425 aa30          	or	a,#48
2129  0427 b702          	ld	_Mesg+2,a
2130  0429 b601          	ld	a,_Mesg+1
2131  042b a400          	and	a,#0
2132  042d aa07          	or	a,#7
2133  042f b701          	ld	_Mesg+1,a
2134                     ; 245 	Mesg.Mesg5RegDef.CHN    = 1;
2136  0431 72100000      	bset	_Mesg,#0
2137  0435 72130000      	bres	_Mesg,#1
2138                     ; 246 	Mesg.Mesg5RegDef.MSG_ID = 5;
2140  0439 b600          	ld	a,_Mesg
2141  043b a483          	and	a,#131
2142  043d aa14          	or	a,#20
2143  043f b700          	ld	_Mesg,a
2144                     ; 247 	Mesg.Mesg5RegDef.write  = 1;
2146  0441 721e0000      	bset	_Mesg,#7
2147                     ; 248 	SPI_W_R_Byte(&Mesg);
2149  0445 ae0000        	ldw	x,#_Mesg
2150  0448 cd002c        	call	_SPI_W_R_Byte
2152                     ; 249 	delay();
2154  044b cd0000        	call	_delay
2156                     ; 250 	delay();
2158  044e cd0000        	call	_delay
2160                     ; 252 	Mesg.SPI_W_Mesg = 0;
2162  0451 ae0000        	ldw	x,#0
2163  0454 bf02          	ldw	_Mesg+2,x
2164  0456 ae0000        	ldw	x,#0
2165  0459 bf00          	ldw	_Mesg,x
2166                     ; 253 	Mesg.Mesg6RegDef.write    = 1;
2168  045b 721e0000      	bset	_Mesg,#7
2169                     ; 254 	Mesg.Mesg6RegDef.CHN      = 1;
2171  045f 72100000      	bset	_Mesg,#0
2172  0463 72130000      	bres	_Mesg,#1
2173                     ; 255 	Mesg.Mesg6RegDef.MSG_ID   = 6;
2175  0467 b600          	ld	a,_Mesg
2176  0469 a483          	and	a,#131
2177  046b aa18          	or	a,#24
2178  046d b700          	ld	_Mesg,a
2179                     ; 256 	Mesg.Mesg6RegDef.TMThresh = 300;
2181  046f b602          	ld	a,_Mesg+2
2182  0471 a40f          	and	a,#15
2183  0473 aac0          	or	a,#192
2184  0475 b702          	ld	_Mesg+2,a
2185  0477 b601          	ld	a,_Mesg+1
2186  0479 a480          	and	a,#128
2187  047b aa12          	or	a,#18
2188  047d b701          	ld	_Mesg+1,a
2189                     ; 257 	Mesg.Mesg6RegDef.Preload  = 5;
2191  047f b603          	ld	a,_Mesg+3
2192  0481 a400          	and	a,#0
2193  0483 aa05          	or	a,#5
2194  0485 b703          	ld	_Mesg+3,a
2195  0487 b602          	ld	a,_Mesg+2
2196  0489 a4f0          	and	a,#240
2197  048b b702          	ld	_Mesg+2,a
2198                     ; 258 	SPI_W_R_Byte(&Mesg);
2200  048d ae0000        	ldw	x,#_Mesg
2201  0490 cd002c        	call	_SPI_W_R_Byte
2203                     ; 259 	delay();
2205  0493 cd0000        	call	_delay
2207                     ; 260 	delay();
2209  0496 cd0000        	call	_delay
2211                     ; 262 	Mesg.SPI_W_Mesg = 0;
2213  0499 ae0000        	ldw	x,#0
2214  049c bf02          	ldw	_Mesg+2,x
2215  049e ae0000        	ldw	x,#0
2216  04a1 bf00          	ldw	_Mesg,x
2217                     ; 263 	Mesg.Mesg10RegDef.write  = 1;
2219  04a3 721e0000      	bset	_Mesg,#7
2220                     ; 264 	Mesg.Mesg10RegDef.MSG_ID = 10;
2222  04a7 b600          	ld	a,_Mesg
2223  04a9 a483          	and	a,#131
2224  04ab aa28          	or	a,#40
2225  04ad b700          	ld	_Mesg,a
2226                     ; 265 	Mesg.Mesg10RegDef.CHN    = 1;
2228  04af 72100000      	bset	_Mesg,#0
2229  04b3 72130000      	bres	_Mesg,#1
2230                     ; 266 	SPI_W_R_Byte(&Mesg);
2232  04b7 ae0000        	ldw	x,#_Mesg
2233  04ba cd002c        	call	_SPI_W_R_Byte
2235                     ; 267 	delay();
2237  04bd cd0000        	call	_delay
2239                     ; 268 	delay();
2241  04c0 cd0000        	call	_delay
2243                     ; 269 }
2246  04c3 81            	ret
2273                     ; 276 void ProportionalValve3_Init(void)
2273                     ; 277 {
2274                     	switch	.text
2275  04c4               _ProportionalValve3_Init:
2279                     ; 279 	Mesg.SPI_W_Mesg = 0;
2281  04c4 ae0000        	ldw	x,#0
2282  04c7 bf02          	ldw	_Mesg+2,x
2283  04c9 ae0000        	ldw	x,#0
2284  04cc bf00          	ldw	_Mesg,x
2285                     ; 280 	SPI_W_R_Byte(&Mesg);
2287  04ce ae0000        	ldw	x,#_Mesg
2288  04d1 cd002c        	call	_SPI_W_R_Byte
2290                     ; 282 	Mesg.SPI_W_Mesg = 0;
2292  04d4 ae0000        	ldw	x,#0
2293  04d7 bf02          	ldw	_Mesg+2,x
2294  04d9 ae0000        	ldw	x,#0
2295  04dc bf00          	ldw	_Mesg,x
2296                     ; 283 	Mesg.Mesg7RegDef.write     = 1;
2298  04de 721e0000      	bset	_Mesg,#7
2299                     ; 284 	Mesg.Mesg7RegDef.MSG_ID    = 7;
2301  04e2 b600          	ld	a,_Mesg
2302  04e4 a483          	and	a,#131
2303  04e6 aa1c          	or	a,#28
2304  04e8 b700          	ld	_Mesg,a
2305                     ; 285 	Mesg.Mesg7RegDef.CM        = 0;
2307  04ea b601          	ld	a,_Mesg+1
2308  04ec a40f          	and	a,#15
2309  04ee b701          	ld	_Mesg+1,a
2310                     ; 286 	Mesg.Mesg7RegDef.FM        = 0;
2312  04f0 b601          	ld	a,_Mesg+1
2313  04f2 a4f0          	and	a,#240
2314  04f4 b701          	ld	_Mesg+1,a
2315                     ; 287 	Mesg.Mesg7RegDef.FMR       = 0;
2317  04f6 721f0002      	bres	_Mesg+2,#7
2318                     ; 288 	Mesg.Mesg7RegDef.FME       = 0;
2320  04fa 721d0002      	bres	_Mesg+2,#6
2321                     ; 289 	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
2323  04fe 72190002      	bres	_Mesg+2,#4
2324  0502 721b0002      	bres	_Mesg+2,#5
2325                     ; 290 	Mesg.Mesg7RegDef.AZDisable = 0;
2327  0506 72170002      	bres	_Mesg+2,#3
2328                     ; 291 	SPI_W_R_Byte(&Mesg);
2330  050a ae0000        	ldw	x,#_Mesg
2331  050d cd002c        	call	_SPI_W_R_Byte
2333                     ; 292 	delay();
2335  0510 cd0000        	call	_delay
2337                     ; 293 	delay(); 
2339  0513 cd0000        	call	_delay
2341                     ; 295 	Mesg.SPI_W_Mesg = 0;
2343  0516 ae0000        	ldw	x,#0
2344  0519 bf02          	ldw	_Mesg+2,x
2345  051b ae0000        	ldw	x,#0
2346  051e bf00          	ldw	_Mesg,x
2347                     ; 296 	Mesg.Mesg3RegDef.Cur_Set   = 309;			/* Current = 200mA */
2349  0520 b603          	ld	a,_Mesg+3
2350  0522 a400          	and	a,#0
2351  0524 aa35          	or	a,#53
2352  0526 b703          	ld	_Mesg+3,a
2353  0528 b602          	ld	a,_Mesg+2
2354  052a a4f8          	and	a,#248
2355  052c aa01          	or	a,#1
2356  052e b702          	ld	_Mesg+2,a
2357                     ; 297 	Mesg.Mesg3RegDef.Dit_EN    = 1;
2359  0530 72160002      	bset	_Mesg+2,#3
2360                     ; 298 	Mesg.Mesg3RegDef.Step_Size = 0;
2362  0534 b602          	ld	a,_Mesg+2
2363  0536 a40f          	and	a,#15
2364  0538 b702          	ld	_Mesg+2,a
2365  053a b601          	ld	a,_Mesg+1
2366  053c a4c0          	and	a,#192
2367  053e b701          	ld	_Mesg+1,a
2368                     ; 299 	Mesg.Mesg3RegDef.ON_OFF    = 0;
2370  0540 721d0001      	bres	_Mesg+1,#6
2371                     ; 300 	Mesg.Mesg3RegDef.EN        = 1;  
2373  0544 721e0001      	bset	_Mesg+1,#7
2374                     ; 301 	Mesg.Mesg3RegDef.CHN       = 2;
2376  0548 72110000      	bres	_Mesg,#0
2377  054c 72120000      	bset	_Mesg,#1
2378                     ; 302 	Mesg.Mesg3RegDef.MSG_ID    = 3; 
2380  0550 b600          	ld	a,_Mesg
2381  0552 a483          	and	a,#131
2382  0554 aa0c          	or	a,#12
2383  0556 b700          	ld	_Mesg,a
2384                     ; 303 	Mesg.Mesg3RegDef.write     = 1;
2386  0558 721e0000      	bset	_Mesg,#7
2387                     ; 304 	SPI_W_R_Byte(&Mesg);
2389  055c ae0000        	ldw	x,#_Mesg
2390  055f cd002c        	call	_SPI_W_R_Byte
2392                     ; 305 	delay();
2394  0562 cd0000        	call	_delay
2396                     ; 306 	delay();
2398  0565 cd0000        	call	_delay
2400                     ; 308 	Mesg.SPI_W_Mesg = 0;
2402  0568 ae0000        	ldw	x,#0
2403  056b bf02          	ldw	_Mesg+2,x
2404  056d ae0000        	ldw	x,#0
2405  0570 bf00          	ldw	_Mesg,x
2406                     ; 309 	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1KHz
2408  0572 b603          	ld	a,_Mesg+3
2409  0574 a400          	and	a,#0
2410  0576 aa9b          	or	a,#155
2411  0578 b703          	ld	_Mesg+3,a
2412  057a b602          	ld	a,_Mesg+2
2413  057c a4c0          	and	a,#192
2414  057e aa02          	or	a,#2
2415  0580 b702          	ld	_Mesg+2,a
2416                     ; 310 	Mesg.Mesg1RegDef.CHN    = 2;
2418  0582 72110000      	bres	_Mesg,#0
2419  0586 72120000      	bset	_Mesg,#1
2420                     ; 311 	Mesg.Mesg1RegDef.MSG_ID = 1;
2422  058a b600          	ld	a,_Mesg
2423  058c a483          	and	a,#131
2424  058e aa04          	or	a,#4
2425  0590 b700          	ld	_Mesg,a
2426                     ; 312 	Mesg.Mesg1RegDef.write  = 1;
2428  0592 721e0000      	bset	_Mesg,#7
2429                     ; 313 	SPI_W_R_Byte(&Mesg);
2431  0596 ae0000        	ldw	x,#_Mesg
2432  0599 cd002c        	call	_SPI_W_R_Byte
2434                     ; 314 	delay();
2436  059c cd0000        	call	_delay
2438                     ; 315 	delay();
2440  059f cd0000        	call	_delay
2442                     ; 317 	Mesg.SPI_W_Mesg = 0;
2444  05a2 ae0000        	ldw	x,#0
2445  05a5 bf02          	ldw	_Mesg+2,x
2446  05a7 ae0000        	ldw	x,#0
2447  05aa bf00          	ldw	_Mesg,x
2448                     ; 318 	Mesg.Mesg2RegDef.write  = 1;
2450  05ac 721e0000      	bset	_Mesg,#7
2451                     ; 319 	Mesg.Mesg2RegDef.MSG_ID = 2;
2453  05b0 b600          	ld	a,_Mesg
2454  05b2 a483          	and	a,#131
2455  05b4 aa08          	or	a,#8
2456  05b6 b700          	ld	_Mesg,a
2457                     ; 320 	Mesg.Mesg2RegDef.CHN    = 2;
2459  05b8 72110000      	bres	_Mesg,#0
2460  05bc 72120000      	bset	_Mesg,#1
2461                     ; 321 	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
2463  05c0 b603          	ld	a,_Mesg+3
2464  05c2 a4e0          	and	a,#224
2465  05c4 b703          	ld	_Mesg+3,a
2466                     ; 322 	SPI_W_R_Byte(&Mesg);
2468  05c6 ae0000        	ldw	x,#_Mesg
2469  05c9 cd002c        	call	_SPI_W_R_Byte
2471                     ; 323 	delay();
2473  05cc cd0000        	call	_delay
2475                     ; 324 	delay();
2477  05cf cd0000        	call	_delay
2479                     ; 326 	Mesg.SPI_W_Mesg = 0;
2481  05d2 ae0000        	ldw	x,#0
2482  05d5 bf02          	ldw	_Mesg+2,x
2483  05d7 ae0000        	ldw	x,#0
2484  05da bf00          	ldw	_Mesg,x
2485                     ; 327 	Mesg.Mesg4RegDef.write    = 1;
2487  05dc 721e0000      	bset	_Mesg,#7
2488                     ; 328 	Mesg.Mesg4RegDef.MSG_ID   = 4;
2490  05e0 b600          	ld	a,_Mesg
2491  05e2 a483          	and	a,#131
2492  05e4 aa10          	or	a,#16
2493  05e6 b700          	ld	_Mesg,a
2494                     ; 329 	Mesg.Mesg4RegDef.CHN      = 2;
2496  05e8 72110000      	bres	_Mesg,#0
2497  05ec 72120000      	bset	_Mesg,#1
2498                     ; 330 	Mesg.Mesg4RegDef.Dit_Step = 0;
2500  05f0 b603          	ld	a,_Mesg+3
2501  05f2 a4c0          	and	a,#192
2502  05f4 b703          	ld	_Mesg+3,a
2503                     ; 331 	SPI_W_R_Byte(&Mesg);
2505  05f6 ae0000        	ldw	x,#_Mesg
2506  05f9 cd002c        	call	_SPI_W_R_Byte
2508                     ; 332 	delay();
2510  05fc cd0000        	call	_delay
2512                     ; 333 	delay();
2514  05ff cd0000        	call	_delay
2516                     ; 335 	Mesg.SPI_W_Mesg = 0;
2518  0602 ae0000        	ldw	x,#0
2519  0605 bf02          	ldw	_Mesg+2,x
2520  0607 ae0000        	ldw	x,#0
2521  060a bf00          	ldw	_Mesg,x
2522                     ; 336 	Mesg.Mesg5RegDef.KI     = 215; 
2524  060c b603          	ld	a,_Mesg+3
2525  060e a400          	and	a,#0
2526  0610 aad7          	or	a,#215
2527  0612 b703          	ld	_Mesg+3,a
2528  0614 b602          	ld	a,_Mesg+2
2529  0616 a4f0          	and	a,#240
2530  0618 b702          	ld	_Mesg+2,a
2531                     ; 337 	Mesg.Mesg5RegDef.KP     = 115;
2533  061a b602          	ld	a,_Mesg+2
2534  061c a40f          	and	a,#15
2535  061e aa30          	or	a,#48
2536  0620 b702          	ld	_Mesg+2,a
2537  0622 b601          	ld	a,_Mesg+1
2538  0624 a400          	and	a,#0
2539  0626 aa07          	or	a,#7
2540  0628 b701          	ld	_Mesg+1,a
2541                     ; 338 	Mesg.Mesg5RegDef.CHN    = 2;
2543  062a 72110000      	bres	_Mesg,#0
2544  062e 72120000      	bset	_Mesg,#1
2545                     ; 339 	Mesg.Mesg5RegDef.MSG_ID = 5;
2547  0632 b600          	ld	a,_Mesg
2548  0634 a483          	and	a,#131
2549  0636 aa14          	or	a,#20
2550  0638 b700          	ld	_Mesg,a
2551                     ; 340 	Mesg.Mesg5RegDef.write  = 1;
2553  063a 721e0000      	bset	_Mesg,#7
2554                     ; 341 	SPI_W_R_Byte(&Mesg);
2556  063e ae0000        	ldw	x,#_Mesg
2557  0641 cd002c        	call	_SPI_W_R_Byte
2559                     ; 342 	delay();
2561  0644 cd0000        	call	_delay
2563                     ; 343 	delay();
2565  0647 cd0000        	call	_delay
2567                     ; 345 	Mesg.SPI_W_Mesg = 0;
2569  064a ae0000        	ldw	x,#0
2570  064d bf02          	ldw	_Mesg+2,x
2571  064f ae0000        	ldw	x,#0
2572  0652 bf00          	ldw	_Mesg,x
2573                     ; 346 	Mesg.Mesg6RegDef.write    = 1;
2575  0654 721e0000      	bset	_Mesg,#7
2576                     ; 347 	Mesg.Mesg6RegDef.CHN      = 2;
2578  0658 72110000      	bres	_Mesg,#0
2579  065c 72120000      	bset	_Mesg,#1
2580                     ; 348 	Mesg.Mesg6RegDef.MSG_ID   = 6;
2582  0660 b600          	ld	a,_Mesg
2583  0662 a483          	and	a,#131
2584  0664 aa18          	or	a,#24
2585  0666 b700          	ld	_Mesg,a
2586                     ; 349 	Mesg.Mesg6RegDef.TMThresh = 0x00;
2588  0668 b602          	ld	a,_Mesg+2
2589  066a a40f          	and	a,#15
2590  066c b702          	ld	_Mesg+2,a
2591  066e b601          	ld	a,_Mesg+1
2592  0670 a480          	and	a,#128
2593  0672 b701          	ld	_Mesg+1,a
2594                     ; 350 	Mesg.Mesg6RegDef.Preload  = 5;
2596  0674 b603          	ld	a,_Mesg+3
2597  0676 a400          	and	a,#0
2598  0678 aa05          	or	a,#5
2599  067a b703          	ld	_Mesg+3,a
2600  067c b602          	ld	a,_Mesg+2
2601  067e a4f0          	and	a,#240
2602  0680 b702          	ld	_Mesg+2,a
2603                     ; 351 	SPI_W_R_Byte(&Mesg);
2605  0682 ae0000        	ldw	x,#_Mesg
2606  0685 cd002c        	call	_SPI_W_R_Byte
2608                     ; 352 	delay();
2610  0688 cd0000        	call	_delay
2612                     ; 353 	delay();
2614  068b cd0000        	call	_delay
2616                     ; 355 	Mesg.SPI_W_Mesg = 0;
2618  068e ae0000        	ldw	x,#0
2619  0691 bf02          	ldw	_Mesg+2,x
2620  0693 ae0000        	ldw	x,#0
2621  0696 bf00          	ldw	_Mesg,x
2622                     ; 356 	Mesg.Mesg10RegDef.write  = 1;
2624  0698 721e0000      	bset	_Mesg,#7
2625                     ; 357 	Mesg.Mesg10RegDef.MSG_ID = 10;
2627  069c b600          	ld	a,_Mesg
2628  069e a483          	and	a,#131
2629  06a0 aa28          	or	a,#40
2630  06a2 b700          	ld	_Mesg,a
2631                     ; 358 	Mesg.Mesg10RegDef.CHN    = 2;
2633  06a4 72110000      	bres	_Mesg,#0
2634  06a8 72120000      	bset	_Mesg,#1
2635                     ; 359 	SPI_W_R_Byte(&Mesg);
2637  06ac ae0000        	ldw	x,#_Mesg
2638  06af cd002c        	call	_SPI_W_R_Byte
2640                     ; 360 	delay();
2642  06b2 cd0000        	call	_delay
2644                     ; 361 	delay();
2646  06b5 cd0000        	call	_delay
2648                     ; 362 }
2651  06b8 81            	ret
2678                     ; 369 void ProportionalValve4_Init(void)
2678                     ; 370 {
2679                     	switch	.text
2680  06b9               _ProportionalValve4_Init:
2684                     ; 372 	Mesg.SPI_W_Mesg = 0;
2686  06b9 ae0000        	ldw	x,#0
2687  06bc bf02          	ldw	_Mesg+2,x
2688  06be ae0000        	ldw	x,#0
2689  06c1 bf00          	ldw	_Mesg,x
2690                     ; 373 	SPI_W_R_Byte(&Mesg);
2692  06c3 ae0000        	ldw	x,#_Mesg
2693  06c6 cd002c        	call	_SPI_W_R_Byte
2695                     ; 375 	Mesg.SPI_W_Mesg = 0;
2697  06c9 ae0000        	ldw	x,#0
2698  06cc bf02          	ldw	_Mesg+2,x
2699  06ce ae0000        	ldw	x,#0
2700  06d1 bf00          	ldw	_Mesg,x
2701                     ; 376 	Mesg.Mesg7RegDef.write     = 1;
2703  06d3 721e0000      	bset	_Mesg,#7
2704                     ; 377 	Mesg.Mesg7RegDef.MSG_ID    = 7;
2706  06d7 b600          	ld	a,_Mesg
2707  06d9 a483          	and	a,#131
2708  06db aa1c          	or	a,#28
2709  06dd b700          	ld	_Mesg,a
2710                     ; 378 	Mesg.Mesg7RegDef.CM        = 0;
2712  06df b601          	ld	a,_Mesg+1
2713  06e1 a40f          	and	a,#15
2714  06e3 b701          	ld	_Mesg+1,a
2715                     ; 379 	Mesg.Mesg7RegDef.FM        = 0;
2717  06e5 b601          	ld	a,_Mesg+1
2718  06e7 a4f0          	and	a,#240
2719  06e9 b701          	ld	_Mesg+1,a
2720                     ; 380 	Mesg.Mesg7RegDef.FMR       = 0;
2722  06eb 721f0002      	bres	_Mesg+2,#7
2723                     ; 381 	Mesg.Mesg7RegDef.FME       = 0;
2725  06ef 721d0002      	bres	_Mesg+2,#6
2726                     ; 382 	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
2728  06f3 72190002      	bres	_Mesg+2,#4
2729  06f7 721b0002      	bres	_Mesg+2,#5
2730                     ; 383 	Mesg.Mesg7RegDef.AZDisable = 0;
2732  06fb 72170002      	bres	_Mesg+2,#3
2733                     ; 384 	SPI_W_R_Byte(&Mesg);
2735  06ff ae0000        	ldw	x,#_Mesg
2736  0702 cd002c        	call	_SPI_W_R_Byte
2738                     ; 385 	delay();
2740  0705 cd0000        	call	_delay
2742                     ; 386 	delay(); 
2744  0708 cd0000        	call	_delay
2746                     ; 388 	Mesg.SPI_W_Mesg = 0;
2748  070b ae0000        	ldw	x,#0
2749  070e bf02          	ldw	_Mesg+2,x
2750  0710 ae0000        	ldw	x,#0
2751  0713 bf00          	ldw	_Mesg,x
2752                     ; 389 	Mesg.Mesg3RegDef.Cur_Set   = 0;			/* Current = 200mA */
2754  0715 3f03          	clr	_Mesg+3
2755  0717 b602          	ld	a,_Mesg+2
2756  0719 a4f8          	and	a,#248
2757  071b b702          	ld	_Mesg+2,a
2758                     ; 390 	Mesg.Mesg3RegDef.Dit_EN    = 1;
2760  071d 72160002      	bset	_Mesg+2,#3
2761                     ; 391 	Mesg.Mesg3RegDef.Step_Size = 0;
2763  0721 b602          	ld	a,_Mesg+2
2764  0723 a40f          	and	a,#15
2765  0725 b702          	ld	_Mesg+2,a
2766  0727 b601          	ld	a,_Mesg+1
2767  0729 a4c0          	and	a,#192
2768  072b b701          	ld	_Mesg+1,a
2769                     ; 392 	Mesg.Mesg3RegDef.ON_OFF    = 0;
2771  072d 721d0001      	bres	_Mesg+1,#6
2772                     ; 393 	Mesg.Mesg3RegDef.EN        = 1;  
2774  0731 721e0001      	bset	_Mesg+1,#7
2775                     ; 394 	Mesg.Mesg3RegDef.CHN       = 3;
2777  0735 72100000      	bset	_Mesg,#0
2778  0739 72120000      	bset	_Mesg,#1
2779                     ; 395 	Mesg.Mesg3RegDef.MSG_ID    = 3; 
2781  073d b600          	ld	a,_Mesg
2782  073f a483          	and	a,#131
2783  0741 aa0c          	or	a,#12
2784  0743 b700          	ld	_Mesg,a
2785                     ; 396 	Mesg.Mesg3RegDef.write     = 1;
2787  0745 721e0000      	bset	_Mesg,#7
2788                     ; 397 	SPI_W_R_Byte(&Mesg);
2790  0749 ae0000        	ldw	x,#_Mesg
2791  074c cd002c        	call	_SPI_W_R_Byte
2793                     ; 398 	delay();
2795  074f cd0000        	call	_delay
2797                     ; 399 	delay();
2799  0752 cd0000        	call	_delay
2801                     ; 401 	Mesg.SPI_W_Mesg = 0;
2803  0755 ae0000        	ldw	x,#0
2804  0758 bf02          	ldw	_Mesg+2,x
2805  075a ae0000        	ldw	x,#0
2806  075d bf00          	ldw	_Mesg,x
2807                     ; 402 	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1KHz
2809  075f b603          	ld	a,_Mesg+3
2810  0761 a400          	and	a,#0
2811  0763 aa9b          	or	a,#155
2812  0765 b703          	ld	_Mesg+3,a
2813  0767 b602          	ld	a,_Mesg+2
2814  0769 a4c0          	and	a,#192
2815  076b aa02          	or	a,#2
2816  076d b702          	ld	_Mesg+2,a
2817                     ; 403 	Mesg.Mesg1RegDef.CHN    = 3;
2819  076f 72100000      	bset	_Mesg,#0
2820  0773 72120000      	bset	_Mesg,#1
2821                     ; 404 	Mesg.Mesg1RegDef.MSG_ID = 1;
2823  0777 b600          	ld	a,_Mesg
2824  0779 a483          	and	a,#131
2825  077b aa04          	or	a,#4
2826  077d b700          	ld	_Mesg,a
2827                     ; 405 	Mesg.Mesg1RegDef.write  = 1;
2829  077f 721e0000      	bset	_Mesg,#7
2830                     ; 406 	SPI_W_R_Byte(&Mesg);
2832  0783 ae0000        	ldw	x,#_Mesg
2833  0786 cd002c        	call	_SPI_W_R_Byte
2835                     ; 407 	delay();
2837  0789 cd0000        	call	_delay
2839                     ; 408 	delay();
2841  078c cd0000        	call	_delay
2843                     ; 410 	Mesg.SPI_W_Mesg = 0;
2845  078f ae0000        	ldw	x,#0
2846  0792 bf02          	ldw	_Mesg+2,x
2847  0794 ae0000        	ldw	x,#0
2848  0797 bf00          	ldw	_Mesg,x
2849                     ; 411 	Mesg.Mesg2RegDef.write  = 1;
2851  0799 721e0000      	bset	_Mesg,#7
2852                     ; 412 	Mesg.Mesg2RegDef.MSG_ID = 2;
2854  079d b600          	ld	a,_Mesg
2855  079f a483          	and	a,#131
2856  07a1 aa08          	or	a,#8
2857  07a3 b700          	ld	_Mesg,a
2858                     ; 413 	Mesg.Mesg2RegDef.CHN    = 3;
2860  07a5 72100000      	bset	_Mesg,#0
2861  07a9 72120000      	bset	_Mesg,#1
2862                     ; 414 	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
2864  07ad b603          	ld	a,_Mesg+3
2865  07af a4e0          	and	a,#224
2866  07b1 b703          	ld	_Mesg+3,a
2867                     ; 415 	SPI_W_R_Byte(&Mesg);
2869  07b3 ae0000        	ldw	x,#_Mesg
2870  07b6 cd002c        	call	_SPI_W_R_Byte
2872                     ; 416 	delay();
2874  07b9 cd0000        	call	_delay
2876                     ; 417 	delay();
2878  07bc cd0000        	call	_delay
2880                     ; 419 	Mesg.SPI_W_Mesg = 0;
2882  07bf ae0000        	ldw	x,#0
2883  07c2 bf02          	ldw	_Mesg+2,x
2884  07c4 ae0000        	ldw	x,#0
2885  07c7 bf00          	ldw	_Mesg,x
2886                     ; 420 	Mesg.Mesg4RegDef.write    = 1;
2888  07c9 721e0000      	bset	_Mesg,#7
2889                     ; 421 	Mesg.Mesg4RegDef.MSG_ID   = 4;
2891  07cd b600          	ld	a,_Mesg
2892  07cf a483          	and	a,#131
2893  07d1 aa10          	or	a,#16
2894  07d3 b700          	ld	_Mesg,a
2895                     ; 422 	Mesg.Mesg4RegDef.CHN      = 3;
2897  07d5 72100000      	bset	_Mesg,#0
2898  07d9 72120000      	bset	_Mesg,#1
2899                     ; 423 	Mesg.Mesg4RegDef.Dit_Step = 0;
2901  07dd b603          	ld	a,_Mesg+3
2902  07df a4c0          	and	a,#192
2903  07e1 b703          	ld	_Mesg+3,a
2904                     ; 424 	SPI_W_R_Byte(&Mesg);
2906  07e3 ae0000        	ldw	x,#_Mesg
2907  07e6 cd002c        	call	_SPI_W_R_Byte
2909                     ; 425 	delay();
2911  07e9 cd0000        	call	_delay
2913                     ; 426 	delay();
2915  07ec cd0000        	call	_delay
2917                     ; 428 	Mesg.SPI_W_Mesg = 0;
2919  07ef ae0000        	ldw	x,#0
2920  07f2 bf02          	ldw	_Mesg+2,x
2921  07f4 ae0000        	ldw	x,#0
2922  07f7 bf00          	ldw	_Mesg,x
2923                     ; 429 	Mesg.Mesg5RegDef.KI     = 215; 
2925  07f9 b603          	ld	a,_Mesg+3
2926  07fb a400          	and	a,#0
2927  07fd aad7          	or	a,#215
2928  07ff b703          	ld	_Mesg+3,a
2929  0801 b602          	ld	a,_Mesg+2
2930  0803 a4f0          	and	a,#240
2931  0805 b702          	ld	_Mesg+2,a
2932                     ; 430 	Mesg.Mesg5RegDef.KP     = 115;
2934  0807 b602          	ld	a,_Mesg+2
2935  0809 a40f          	and	a,#15
2936  080b aa30          	or	a,#48
2937  080d b702          	ld	_Mesg+2,a
2938  080f b601          	ld	a,_Mesg+1
2939  0811 a400          	and	a,#0
2940  0813 aa07          	or	a,#7
2941  0815 b701          	ld	_Mesg+1,a
2942                     ; 431 	Mesg.Mesg5RegDef.CHN    = 3;
2944  0817 72100000      	bset	_Mesg,#0
2945  081b 72120000      	bset	_Mesg,#1
2946                     ; 432 	Mesg.Mesg5RegDef.MSG_ID = 5;
2948  081f b600          	ld	a,_Mesg
2949  0821 a483          	and	a,#131
2950  0823 aa14          	or	a,#20
2951  0825 b700          	ld	_Mesg,a
2952                     ; 433 	Mesg.Mesg5RegDef.write  = 1;
2954  0827 721e0000      	bset	_Mesg,#7
2955                     ; 434 	SPI_W_R_Byte(&Mesg);
2957  082b ae0000        	ldw	x,#_Mesg
2958  082e cd002c        	call	_SPI_W_R_Byte
2960                     ; 435 	delay();
2962  0831 cd0000        	call	_delay
2964                     ; 436 	delay();
2966  0834 cd0000        	call	_delay
2968                     ; 438 	Mesg.SPI_W_Mesg = 0;
2970  0837 ae0000        	ldw	x,#0
2971  083a bf02          	ldw	_Mesg+2,x
2972  083c ae0000        	ldw	x,#0
2973  083f bf00          	ldw	_Mesg,x
2974                     ; 439 	Mesg.Mesg6RegDef.write    = 1;
2976  0841 721e0000      	bset	_Mesg,#7
2977                     ; 440 	Mesg.Mesg6RegDef.CHN      = 3;
2979  0845 72100000      	bset	_Mesg,#0
2980  0849 72120000      	bset	_Mesg,#1
2981                     ; 441 	Mesg.Mesg6RegDef.MSG_ID   = 6;
2983  084d b600          	ld	a,_Mesg
2984  084f a483          	and	a,#131
2985  0851 aa18          	or	a,#24
2986  0853 b700          	ld	_Mesg,a
2987                     ; 442 	Mesg.Mesg6RegDef.TMThresh = 0x00;
2989  0855 b602          	ld	a,_Mesg+2
2990  0857 a40f          	and	a,#15
2991  0859 b702          	ld	_Mesg+2,a
2992  085b b601          	ld	a,_Mesg+1
2993  085d a480          	and	a,#128
2994  085f b701          	ld	_Mesg+1,a
2995                     ; 443 	Mesg.Mesg6RegDef.Preload  = 5;
2997  0861 b603          	ld	a,_Mesg+3
2998  0863 a400          	and	a,#0
2999  0865 aa05          	or	a,#5
3000  0867 b703          	ld	_Mesg+3,a
3001  0869 b602          	ld	a,_Mesg+2
3002  086b a4f0          	and	a,#240
3003  086d b702          	ld	_Mesg+2,a
3004                     ; 444 	SPI_W_R_Byte(&Mesg);
3006  086f ae0000        	ldw	x,#_Mesg
3007  0872 cd002c        	call	_SPI_W_R_Byte
3009                     ; 445 	delay();
3011  0875 cd0000        	call	_delay
3013                     ; 446 	delay();
3015  0878 cd0000        	call	_delay
3017                     ; 448 	Mesg.SPI_W_Mesg = 0;
3019  087b ae0000        	ldw	x,#0
3020  087e bf02          	ldw	_Mesg+2,x
3021  0880 ae0000        	ldw	x,#0
3022  0883 bf00          	ldw	_Mesg,x
3023                     ; 449 	Mesg.Mesg10RegDef.write  = 1;
3025  0885 721e0000      	bset	_Mesg,#7
3026                     ; 450 	Mesg.Mesg10RegDef.MSG_ID = 10;
3028  0889 b600          	ld	a,_Mesg
3029  088b a483          	and	a,#131
3030  088d aa28          	or	a,#40
3031  088f b700          	ld	_Mesg,a
3032                     ; 451 	Mesg.Mesg10RegDef.CHN    = 3;
3034  0891 72100000      	bset	_Mesg,#0
3035  0895 72120000      	bset	_Mesg,#1
3036                     ; 452 	SPI_W_R_Byte(&Mesg);
3038  0899 ae0000        	ldw	x,#_Mesg
3039  089c cd002c        	call	_SPI_W_R_Byte
3041                     ; 453 	delay();
3043  089f cd0000        	call	_delay
3045                     ; 454 	delay();
3047  08a2 cd0000        	call	_delay
3049                     ; 455 }
3052  08a5 81            	ret
3065                     	xref.b	_RMesg
3066                     	xref.b	_Mesg
3067                     	xdef	_ProportionalValve4_Init
3068                     	xdef	_ProportionalValve3_Init
3069                     	xdef	_ProportionalValve2_Init
3070                     	xdef	_ProportionalValve1_Init
3071                     	xdef	_SPI_W_R_Byte
3072                     	xdef	_SPI_H_Init
3073                     	xdef	_delay
3074                     	xref	_GPIO_CS1
3075                     	xref	_GPIO_CS0
3076                     	xref	_SPI_GetFlagStatus
3077                     	xref	_SPI_ReceiveData
3078                     	xref	_SPI_SendData
3079                     	xref	_SPI_Cmd
3080                     	xref	_SPI_Init
3081                     	xref	_SPI_DeInit
3100                     	end
