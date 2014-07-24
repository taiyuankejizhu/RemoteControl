#ifndef _SPI_H
#define _SPI_H
#include "gpio.h"
#include "stm8s.h"

/*****************主机发送的数据******************/
typedef union
{
	unsigned long int SPI_W_Mesg;                 
	struct
  {
		unsigned long int     Not_Used         : 14;
		unsigned long int     Not_Used1        : 12; //0x80;0x00;0x00;0x00
		unsigned long int     MSG_ID           : 5;  //00000
		unsigned long int			write			       : 1;  //1:write 
		
	}Mesg0RegDef;
	struct
  {
		unsigned long int     PWM_N            : 14; //PWM Divider N ;Fpwm = Fclk/(32*N)
		unsigned long int     Not_Used         : 10;
		unsigned long int     CHN              : 2;  //channel number 00/01/10/11
		unsigned long int     MSG_ID           : 5;  //Message Identifier 00001
		unsigned long int     write            : 1;  //write command         
	}Mesg1RegDef;
	/* SPI Message #2-PWM Offset */
	struct
  {
    unsigned long int  PhaseSyncOffset     : 5;/* Phase Synch Offset
                                               * Toffset = 
                                               *  PhaseSynchOffset / (32 * Fpwm)
                                               */
    unsigned long int  Reserve5_15         : 11;
    unsigned long int  Reserve16_23        : 8;
		unsigned long int  CHN                 : 2;/* Channel Number */
		unsigned long int  MSG_ID              : 5;/* 0 0010 = PWM Offset */
    unsigned long int  write               : 1;/**/
  }Mesg2RegDef;
	struct
  {
		unsigned long int     Cur_Set          : 11; //Average Current Set Point
		unsigned long int     Dit_EN           : 1;  //Dither Enable
		unsigned long int     Step_Size        : 10; //Dither Step Size
		unsigned long int     ON_OFF           : 1;  //Used when the channel is configured for on/off operation
		unsigned long int     EN               : 1;  //Set behavior of channel when the pin ENABLE is low
		unsigned long int     CHN              : 2; 
		unsigned long int     MSG_ID           : 5;  //00011
		unsigned long int     write            : 1;	
	}Mesg3RegDef;
	struct
  {
		unsigned long int     Dit_Step         : 6;  //Dither Step- # of Dithr Steps in 1/4 of the dither waveform period
		unsigned long int     Not_Used         : 18;
		unsigned long int     CHN              : 2;
		unsigned long int     MSG_ID           : 5;  //00100
		unsigned long int     write            : 1;	
	}Mesg4RegDef;
	struct
	{
		unsigned long int     KI               : 12; //KI-Intergral Coeffient
		unsigned long int     KP               : 12; //KP-Proportional Coefficient
		unsigned long int     CHN              : 2;
		unsigned long int     MSG_ID           : 5;  //00101
		unsigned long int     write            : 1;
	}Mesg5RegDef;
	/* SPI Message #6-Dynamic Threshold Value Set */
  struct
  {
    unsigned long int Preload              : 12;/* Integrator Preload Value 
                                               * This value will be loaded
                                               * into the integrator when
                                               * the controller transitions
                                               * from transient mode to
                                               * steady state mode.
                                               */
    unsigned long int TMThresh             : 11; /* Transfer Mode Threshold
                                               * Setpoint changes grater than this
                                               * threshold will activate the transient
                                               * mode of operation.
                                               */
		unsigned long int Reserve23            : 1; /**/
    unsigned long int CHN                  : 2; /* Channel Number */
    unsigned long int MSG_ID               : 5; /* 0 0110 = Dynamic Threshold 
                                               *          Value Set 
                                               */		
    unsigned long int write                : 1; /**/		
  }Mesg6RegDef;
	/* SPI Message #7-On/Off Control and Fault Mask Configuration */
  struct
  {
 
    unsigned long int Reserve0_10         : 11;
    unsigned long int AZDisable           : 1; /* Auto-Zero Disable
                                               *  0 = Auto-Zero Enable
                                               *  1 = Auto-Zero Disable
                                               */
    unsigned long int DIAG_TMR            : 2; /* Diagnostic Timer
                                               *  00 = TIME_1 pre-divider = 128
                                               *  01 = TIME_2 pre-divider = 192
                                               *  10 = TIME_2 pre-divider = 192
                                               *  11 = TIME_3 pre-divider = 256
                                               */
    unsigned long int FME                 : 1; /* Fault Mast for EANBLE pin
                                               *  0 = A low state on the RESET_B
                                               *      pin does not activate the
                                               *      FAULT pin.
                                               *  1 = A low state on the RESET_B
                                               *      pin does activate the FAULT
                                               *      pin.
                                               */
    unsigned long int FMR                 : 1; /* Fault Mask for RESET_B pin
                                               *  0 = A low state on the ENABLE
                                               *      pin does not activate the
                                               *      FAULT pin.
                                               *  1 = A low state on the ENABLE
                                               *      pin does activate the 
                                               *      FAULT pin.
                                               * Note:when a high to low transition
                                               * is detected on the ENABLE pin,the
                                               * ENABLE fault will be latched until
                                               * the ENABLE pin returns high AND a
                                               * diagnostic read message is received.
                                               */
		unsigned long int FM                  : 4; /* Fault Mask for Channel #x
                                               *  0 = fault don't trigger
                                               *      FAULT pin;
                                               *  1 = fault triggers FAULT
                                               *      pin.
                                               */
    unsigned long int CM                  : 4; /* Control Mode for Channel #x
                                               *  0 = Current Control
                                               *  1 = On/Off
                                               */																					 
		unsigned long int Reserve24_25        : 2;
    unsigned long int MSG_ID              : 5; /* 0 0111 = On/Off Control and Fault
                                               * Mask Configuration.\
                                               */
    unsigned long int write               : 1; /**/
																					 
  }Mesg7RegDef;
	/* SPI Message #8-Diagnostic Configuration */
  struct
  {
	  
    unsigned long int SB_RETRY3           : 4;/*  10 = 1.1V */
    unsigned long int SB3                 : 2;/*  11 = 1.3V */
    unsigned long int SB_RETRY2           : 4;/* SB_RETRYx  Short to Battery Retry Time */
    unsigned long int SB2                 : 2;/* Retry after 4 * SB_RETRY * PWM Periods */
    unsigned long int SB_RETRY1           : 4;/**/
		unsigned long int SB1                 : 2;/* SBx Short To Battery Threshold */
    unsigned long int SB_RETRY0           : 4;/*  00 = 0.7V */
    unsigned long int SB0                 : 2;/*  01 = 0.9V */
		unsigned long int Reserve24_25        : 2;
    unsigned long int MSG_ID              : 5;/* 0 1000 = Diagnostic Configuration */
    unsigned long int write               : 1;/**/

  }Mesg8RegDef;
  /* SPI Message #9-Diagnostic Read */ 
  struct
  {
		unsigned long int Reserve0_15         : 16;
		unsigned long int Reserve16_25        : 10;
    unsigned long int MSG_ID              : 5; /* 0 1001 = Diagnostic Read */
    unsigned long int write               : 1; /*write */

  }Mesg9RegDef;
	struct
	{
		unsigned long int     Not_Used        : 24;
		unsigned long int     CHN             : 2;
		unsigned long int     MSG_ID          : 5;  //01010 the command is used to read current
		unsigned long int     write           : 1; 
	}Mesg10RegDef;
	/* SPI Message #11-Autozero Read */
  struct
  {
    unsigned long int  Reserve10_15        : 16; 
		unsigned long int  Reserve16_23        : 8;
		unsigned long int  CHN                 : 2;             /* Channel Number */
    unsigned long int  MSG_ID              : 5;             /* 0 1011 = Autozero Read */
    unsigned long int  write               : 1;             /**/

  }Mesg11RegDef;
  /* SPI Message #12-Duty Cycle Read */
  struct
  {
    unsigned long int  Reserve10_15        : 16;
		unsigned long int  Reserve16_23        : 8;
		unsigned long int  CHN                 : 2;             /* Channel Number */
    unsigned long int  MSG_ID              : 5;             /* 0 1100 = Duty Cycle Read */
    unsigned long int  write               : 1;             /**/
  }Mesg12RegDef;
	struct
  {
	  unsigned long int     Mes0_7           : 8;
		unsigned long int     Mes8_15          : 8;	
		unsigned long int     Mes16_23         : 8;
		unsigned long int     Mes24_31         : 8;
	}MesgDef;
}MesgWStructDef;


/*****************从机返回的数据*****************/
typedef union
{
	unsigned long int SPI_R_Mesg;                 //0x00;0x83;0x00;0x00
	struct
  {
		unsigned long int     zero             : 8;  //0000 0000
		unsigned long int     Ver_Num          : 8;  //0000 0000 Version Number
    unsigned long int     IC_Man_ID        : 8;  //1100 0001 IC Manufacture ID Number
		unsigned long int     MSG_ID           : 5;  //00000
		unsigned long int			read			       : 1;  //0:read	
	}Mesg0RegDef;
	struct
  {
		unsigned long int     PWM_N            : 14; //PWM Divider N ;Fpwm = Fclk/(32*N)
		unsigned long int     zero             : 10; //0000 0000 00
		unsigned long int     CHN              : 2;  //channel number 00/01/10/11
		unsigned long int     MSG_ID           : 5;  //Message Identifier 00001
		unsigned long int     read             : 1;  //read command  0       	
	}Mesg1RegDef;
	/* SPI Response Message of #2 */
  struct
  {
    unsigned long int PhaseSyncOffset     : 5;
    unsigned long int Reserve5_15         : 11;
    unsigned long int Reserve16_23        : 8;		
		unsigned long int CHN                 : 2;
    unsigned long int MSG_ID              : 5;
    unsigned long int read                : 1;
  }Mesg2RegDef;
	struct
  {
		unsigned long int     Cur_Set         : 11; //Average Current Set Point
		unsigned long int     Dit_EN          : 1;  //Dither Enable
		unsigned long int     Step_Size       : 10; //Dither Step Size
		unsigned long int     ON_OFF          : 1;  //Used when the channel is configured for on/off operation
    unsigned long int     EN              : 1;  //Set behavior of channel when the pin ENABLE is low
		unsigned long int     CHN             : 2; 
		unsigned long int     MSG_ID          : 5;  //00011
		unsigned long int     read            : 1;  //0
	}Mesg3RegDef;
	struct
  {
		unsigned long int     Dit_Step        : 6;  //Dither Step- # of Dithr Steps in 1/4 of the dither waveform period
		unsigned long int     zero            : 18; //0000 0000 0000 0000 00
    unsigned long int     CHN             : 2;
		unsigned long int     MSG_ID          : 5;  //00100
		unsigned long int     read            : 1;  //0
	}Mesg4RegDef;
	struct
	{
		unsigned long int     KI              : 12; //KI-Intergral Coeffient
		unsigned long int     KP              : 12; //KP-Proportional Coefficient
		unsigned long int     CHN             : 2;
		unsigned long int     MSG_ID          : 5;  //00101
		unsigned long int     read            : 1;  //0
	}Mesg5RegDef;
	/* SPI Response Message of #6 */
  struct
  {
    unsigned long int  Preload            : 12;/* Integrator Preload Value 
                                               * This value will be loaded
                                               * into the integrator when
                                               * the controller transitions
                                               * from transient mode to
                                               * steady state mode.
                                               */
    unsigned long int  TMThresh           : 11;  
		unsigned long int  Reserve23          : 1;/**/
		unsigned long int  ChannelNumber      : 2;/* Channel Number */
    unsigned long int  MSG_ID             : 5;/* 0 0110 = Dynamic Threshold 
                                               *          Value Set 
                                               */
    unsigned long int  read               : 1;/**/
  }Mesg6RegDef;
	/* SPI Response Message of #7 */
  struct
  {
    unsigned long int  Reserve0_10        : 11;
    unsigned long int  AZDisable          : 1;/* Auto-Zero Disable
                                               *  0 = Auto-Zero Enable
                                               *  1 = Auto-Zero Disable
                                               */
    unsigned long int  DIAG_TMR           : 2;/* Diagnostic Timer
                                               *  00 = TIME_1 pre-divider = 128
                                               *  01 = TIME_2 pre-divider = 192
                                               *  10 = TIME_2 pre-divider = 192
                                               *  11 = TIME_3 pre-divider = 256
                                               */
    unsigned long int  FME                : 1;/* Fault Mast for EANBLE pin
                                               *  0 = A low state on the RESET_B
                                               *      pin does not activate the
                                               *      FAULT pin.
                                               *  1 = A low state on the RESET_B
                                               *      pin does activate the FAULT
                                               *      pin.
                                               */
    unsigned long int  FMR                : 1;/* Fault Mask for RESET_B pin
                                               *  0 = A low state on the ENABLE
                                               *      pin does not activate the
                                               *      FAULT pin.
                                               *  1 = A low state on the ENABLE
                                               *      pin does activate the 
                                               *      FAULT pin.
                                               * Note:when a high to low transition
                                               * is detected on the ENABLE pin,the
                                               * ENABLE fault will be latched until
                                               * the ENABLE pin returns high AND a
                                               * diagnostic read message is received.
                                               */
	  unsigned long int  FM                 : 4;/* Fault Mask for Channel #x
                                               *  0 = fault don't trigger
                                               *      FAULT pin;
                                               *  1 = fault triggers FAULT
                                               *      pin.
                                               */
    unsigned long int  CM                 : 4;             /* Control Mode for Channel #x
                                               *  0 = Current Control
                                               *  1 = On/Off
                                               */																					 
		unsigned long int  Reserve24_25       : 2;
    unsigned long int  MSG_ID             : 5; /* 0 0111 = On/Off Control and Fault
                                               * Mask Configuration.
                                               */
    unsigned long int  read               : 1;/**/
  }Mesg7RegDef;
  /* SPI Response Message of #8 */
  struct
  {
    unsigned long int  SB_RETRY3          : 4;             /*  10 = 1.1V */
    unsigned long int  SB3                : 2;             /*  11 = 1.3V */
    unsigned long int  SB_RETRY2          : 4;             /*SB_RETRYx  Short to Battery Retry Time */
    unsigned long int  SB2                : 2;             /* Retry after 4 * SB_RETRY * PWM Periods */
    unsigned long int  SB_RETRY1          : 4;             /**/
		unsigned long int  SB1                : 2;             /* SBx Short To Battery Threshold */
    unsigned long int  SB_RETRY0          : 4;             /*  00 = 0.7V */
    unsigned long int  SB0                : 2;             /*  01 = 0.9V */
		unsigned long int  Reserve24_25       : 2;
    unsigned long int  MSG_ID             : 5;             /* 0 1000 = Diagnostic Configuration */
    unsigned long int  read               : 1;             /**/
  }Mesg8RegDef;
  /* SPI Response Message of #9 */
  struct
  {
    unsigned long int  RBL                : 1;
    unsigned long int  ENL                : 1;
    unsigned long int  OLON3              : 1;
    unsigned long int  OLOFF3             : 1;
    unsigned long int  SBTST3             : 1;
    unsigned long int  SB3                : 1;
    unsigned long int  OFFTST3            : 1;
    unsigned long int  SG3                : 1;
		unsigned long int  OLON2              : 1;
    unsigned long int  OLOFF2             : 1;
    unsigned long int  SBTST2             : 1;
    unsigned long int  SB2                : 1;
    unsigned long int  OFFTST2            : 1;
    unsigned long int  SG2                : 1;
    unsigned long int  OLON1              : 1;
    unsigned long int  OLOFF1             : 1;
	  unsigned long int  SBTST1             : 1;
    unsigned long int  SB1                : 1;
    unsigned long int  OFFTST1            : 1;
    unsigned long int  SG1                : 1;
    unsigned long int  OLON0              : 1;
    unsigned long int  OLOFF0             : 1;
    unsigned long int  SBTST0             : 1;
    unsigned long int  SB0                : 1;	
		unsigned long int  OFFTST0            : 1;
    unsigned long int  SG0                : 1;
    unsigned long int  MSG_ID             : 5;
    unsigned long int  read               : 1;
  }Mesg9RegDef;
	struct
	{
		unsigned long int     Cur_Read        : 14; //current read
		unsigned long int     zero            : 10; //0000 0000 00
		unsigned long int     CHN             : 2;
		unsigned long int     MSG_ID          : 5;  //01010 the command is used to read current
		unsigned long int     read            : 1;  //0
	}Mesg10RegDef;
	/* SPI Response Message of #11 */
  struct
  {
    unsigned long int AutozeroOffValue    : 6;
    unsigned long int AutozeroOnValue     : 6;
    unsigned long int AZoff               : 1;
    unsigned long int AZon                : 1;
    unsigned long int PSL                 : 1;
    unsigned long int OVL                 : 1;
		unsigned long int Reserve16_23        : 8;
		unsigned long int channel             : 2;
    unsigned long int MSG_ID              : 5;
    unsigned long int read                : 1;
  }Mesg11RegDef;
  /* SPI Response Message of #12 */
  struct
  {
    unsigned long int DutyCycle           : 19;
		unsigned long int Reserve19_23        : 5;
		unsigned long int Channel             : 2;
    unsigned long int MSG_ID              : 5;
    unsigned long int read                : 1;
  }Mesg12RegDef;
	struct
  {
		unsigned long int     Mes0_7          : 8;
		unsigned long int     Mes8_15         : 8;
		unsigned long int     Mes16_23        : 8;
		unsigned long int     Mes24_31        : 8;
	}MesgDef;
}MesgRStructDef;

/* Private function prototypes -----------------------------------------------*/
void delay(void);
void SPI_H_Init(void);
void SPI_W_Byte(MesgWStructDef *data);
void SPI_W_R_Byte(MesgWStructDef *data);
void ProportionalValve1_Init(void);
void ProportionalValve2_Init(void);
void ProportionalValve3_Init(void);
void ProportionalValve4_Init(void);

#endif