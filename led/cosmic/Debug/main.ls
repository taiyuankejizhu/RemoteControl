   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  39                     ; 11 void main()
  39                     ; 12 {
  41                     	switch	.text
  42  0000               _main:
  46                     ; 13 	GPIO_H_Init();
  48  0000 cd0000        	call	_GPIO_H_Init
  50                     ; 14 	SPI_H_Init();
  52  0003 cd0000        	call	_SPI_H_Init
  54  0006               L12:
  55                     ; 18 		if (!GPIO_KEY(KEY_3))
  57  0006 a608          	ld	a,#8
  58  0008 cd0000        	call	_GPIO_KEY
  60  000b 4d            	tnz	a
  61  000c 260a          	jrne	L52
  62                     ; 20 			ProportionalValve3_Init();
  64  000e cd0000        	call	_ProportionalValve3_Init
  66                     ; 21 			GPIO_LED(LED_2);
  68  0011 a640          	ld	a,#64
  69  0013 cd0000        	call	_GPIO_LED
  72  0016 20ee          	jra	L12
  73  0018               L52:
  74                     ; 23 		else if(!GPIO_KEY(KEY_2))
  76  0018 a604          	ld	a,#4
  77  001a cd0000        	call	_GPIO_KEY
  79  001d 4d            	tnz	a
  80  001e 260a          	jrne	L13
  81                     ; 25 			ProportionalValve3_Init();
  83  0020 cd0000        	call	_ProportionalValve3_Init
  85                     ; 26 			GPIO_LED(LED_1);
  87  0023 a620          	ld	a,#32
  88  0025 cd0000        	call	_GPIO_LED
  91  0028 20dc          	jra	L12
  92  002a               L13:
  93                     ; 28 		else if(!GPIO_KEY(KEY_1))
  95  002a a602          	ld	a,#2
  96  002c cd0000        	call	_GPIO_KEY
  98  002f 4d            	tnz	a
  99  0030 260a          	jrne	L53
 100                     ; 30 			ProportionalValve2_Init();
 102  0032 cd0000        	call	_ProportionalValve2_Init
 104                     ; 31 			GPIO_LED(LED_0);
 106  0035 a610          	ld	a,#16
 107  0037 cd0000        	call	_GPIO_LED
 110  003a 20ca          	jra	L12
 111  003c               L53:
 112                     ; 34 		else if(!GPIO_KEY(KEY_0))
 114  003c a601          	ld	a,#1
 115  003e cd0000        	call	_GPIO_KEY
 117  0041 4d            	tnz	a
 118  0042 26c2          	jrne	L12
 119                     ; 36 			ProportionalValve1_Init();
 121  0044 cd0000        	call	_ProportionalValve1_Init
 123                     ; 37 			GPIO_LED(LED_0);
 125  0047 a610          	ld	a,#16
 126  0049 cd0000        	call	_GPIO_LED
 128                     ; 38 			GPIO_LED(LED_1);
 130  004c a620          	ld	a,#32
 131  004e cd0000        	call	_GPIO_LED
 133                     ; 39 			GPIO_LED(LED_2);
 135  0051 a640          	ld	a,#64
 136  0053 cd0000        	call	_GPIO_LED
 138  0056 20ae          	jra	L12
2627                     	xdef	_main
2628                     	switch	.ubsct
2629  0000               _RMesg:
2630  0000 00000000      	ds.b	4
2631                     	xdef	_RMesg
2632  0004               _Mesg:
2633  0004 00000000      	ds.b	4
2634                     	xdef	_Mesg
2635                     	xref	_ProportionalValve3_Init
2636                     	xref	_ProportionalValve2_Init
2637                     	xref	_ProportionalValve1_Init
2638                     	xref	_SPI_H_Init
2639                     	xref	_GPIO_KEY
2640                     	xref	_GPIO_LED
2641                     	xref	_GPIO_H_Init
2661                     	end
