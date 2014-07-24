#include "spi.h"

extern MesgWStructDef        Mesg;
extern MesgRStructDef        RMesg;
/* Private functions ---------------------------------------------------------*/
/*******************************************************************************
* ����ԭ�ͣ�void delay(void);
* �������ܣ�����ʵ����ʱ���ܣ���ʱʱ�� 5 us ����
* ���������NONE 
* ���������NONE 
*******************************************************************************/
void delay(void)
{
	unsigned char i;
	for (i = 0; i < 50; i++)
  {
		;
	}
}

/*******************************************************************************
* ����ԭ�ͣ�void SPI_H_Init(void);
* �������ܣ�SPI ģ���ʼ��
* ���������NONE 
* ���������NONE
*******************************************************************************/
void SPI_H_Init(void)
{
	SPI_DeInit();
	SPI_Init( SPI_FIRSTBIT_MSB,                                //MSB
						SPI_BAUDRATEPRESCALER_16,                        //SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, 
						SPI_MODE_MASTER,                                //SPI_Mode_TypeDef Mode, 
						SPI_CLOCKPOLARITY_HIGH,                         //SPI_ClockPolarity_TypeDef ClockPolarity, 
						SPI_CLOCKPHASE_1EDGE,                           //SPI_ClockPhase_TypeDef ClockPhase, 
						SPI_DATADIRECTION_2LINES_FULLDUPLEX,            //SPI_DataDirection_TypeDef Data_Direction,
						SPI_NSS_SOFT,                                   //SPI_NSS_TypeDef Slave_Management, 
						(u8)0x07);
	SPI_Cmd(ENABLE);
}
/*******************************************************************************
* ����ԭ�ͣ�void SPI_W_R_Byte(MesgWStructDef *data);
* �������ܣ�ͨ�� SPI ���ͽ���Message
* �������������Ϊ MesgWStructDef �Ĺ�����ָ�룬��ָ���λ��ΪҪ���� Message
*           ���ڵ�λ�ã�����μ� MesgWStructDef ���������� 
* ���������NONE
*******************************************************************************/
void SPI_W_R_Byte(MesgWStructDef *data)
{
	GPIO_CS0();
	delay();
	
	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
	SPI_SendData(data->MesgDef.Mes24_31);	
	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
	RMesg.MesgDef.Mes24_31 = SPI_ReceiveData();	
	
	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
	SPI_SendData(data->MesgDef.Mes16_23);
	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
	RMesg.MesgDef.Mes16_23 = SPI_ReceiveData();
	
	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
	SPI_SendData(data->MesgDef.Mes8_15);
	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
	RMesg.MesgDef.Mes8_15 = SPI_ReceiveData();	
	
	while (!(SPI_GetFlagStatus(SPI_FLAG_TXE)));
	SPI_SendData(data->MesgDef.Mes0_7);
	while (!(SPI_GetFlagStatus(SPI_FLAG_RXNE)));
	RMesg.MesgDef.Mes0_7 = SPI_ReceiveData();
	
	delay();
	GPIO_CS1();
	delay();	
}
/*******************************************************************************
* ����ԭ�ͣ�void ProportionalValve1_Init(void);
* �������ܣ���ʼ�� TLE7242-G ͨ��һ
* ���������NONE 
* ���������NONE 
*******************************************************************************/
void ProportionalValve1_Init(void)
{
	/* SPI Message #0 */
	Mesg.SPI_W_Mesg = 0;
	SPI_W_R_Byte(&Mesg);
	/* SPI Message #7 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg7RegDef.write     = 1;
	Mesg.Mesg7RegDef.MSG_ID    = 7;
	Mesg.Mesg7RegDef.CM        = 0;
	Mesg.Mesg7RegDef.FM        = 8;
	Mesg.Mesg7RegDef.FMR       = 0;
	Mesg.Mesg7RegDef.FME       = 0;
	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
	Mesg.Mesg7RegDef.AZDisable = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #3 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg3RegDef.Cur_Set   = 0;			
	Mesg.Mesg3RegDef.Dit_EN    = 1;
	Mesg.Mesg3RegDef.Step_Size = 0;
	Mesg.Mesg3RegDef.ON_OFF    = 0;
	Mesg.Mesg3RegDef.EN        = 1;  
	Mesg.Mesg3RegDef.CHN       = 0;
	Mesg.Mesg3RegDef.MSG_ID    = 3; 
	Mesg.Mesg3RegDef.write     = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
  /* SPI Message #1 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1.5KHz
	Mesg.Mesg1RegDef.CHN    = 0;
	Mesg.Mesg1RegDef.MSG_ID = 1;
	Mesg.Mesg1RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #2 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg2RegDef.write  = 1;
	Mesg.Mesg2RegDef.MSG_ID = 2;
	Mesg.Mesg2RegDef.CHN    = 0;
	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #4 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg4RegDef.write    = 1;
	Mesg.Mesg4RegDef.MSG_ID   = 4;
	Mesg.Mesg4RegDef.CHN      = 0;
	Mesg.Mesg4RegDef.Dit_Step = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #5 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg5RegDef.KI     = 240; 
	Mesg.Mesg5RegDef.KP     = 246;
	Mesg.Mesg5RegDef.CHN    = 0;
	Mesg.Mesg5RegDef.MSG_ID = 5;
	Mesg.Mesg5RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #6 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg6RegDef.write    = 1;
	Mesg.Mesg6RegDef.CHN      = 0;
	Mesg.Mesg6RegDef.MSG_ID   = 6;
	Mesg.Mesg6RegDef.TMThresh = 200;
	Mesg.Mesg6RegDef.Preload  = 5;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg9RegDef.write  = 1;
	Mesg.Mesg9RegDef.MSG_ID = 9;
	SPI_W_R_Byte(&Mesg);
	delay();delay();delay();delay();
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #10 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg10RegDef.write  = 1;
	Mesg.Mesg10RegDef.MSG_ID = 10;
	Mesg.Mesg10RegDef.CHN    = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
}
/*******************************************************************************
* ����ԭ�ͣ�void ProportionalValve2_Init(void);
* �������ܣ���ʼ�� TLE7242-G ͨ����
* ���������NONE 
* ���������NONE 
*******************************************************************************/
void ProportionalValve2_Init(void)
{
	/* SPI Message #0 */
	Mesg.SPI_W_Mesg = 0;
	SPI_W_R_Byte(&Mesg);
	/* SPI Message #7 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg7RegDef.write     = 1;
	Mesg.Mesg7RegDef.MSG_ID    = 7;
	Mesg.Mesg7RegDef.CM        = 0;
	Mesg.Mesg7RegDef.FM        = 0;
	Mesg.Mesg7RegDef.FMR       = 0;
	Mesg.Mesg7RegDef.FME       = 0;
	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
	Mesg.Mesg7RegDef.AZDisable = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #3 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg3RegDef.Cur_Set   = 0;			/* Current = 200mA */
	Mesg.Mesg3RegDef.Dit_EN    = 1;
	Mesg.Mesg3RegDef.Step_Size = 0;
	Mesg.Mesg3RegDef.ON_OFF    = 0;
	Mesg.Mesg3RegDef.EN        = 1;  
	Mesg.Mesg3RegDef.CHN       = 1;
	Mesg.Mesg3RegDef.MSG_ID    = 3; 
	Mesg.Mesg3RegDef.write     = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
  /* SPI Message #1 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1KHz
	Mesg.Mesg1RegDef.CHN    = 1;
	Mesg.Mesg1RegDef.MSG_ID = 1;
	Mesg.Mesg1RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #2 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg2RegDef.write  = 1;
	Mesg.Mesg2RegDef.MSG_ID = 2;
	Mesg.Mesg2RegDef.CHN    = 1;
	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #4 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg4RegDef.write    = 1;
	Mesg.Mesg4RegDef.MSG_ID   = 4;
	Mesg.Mesg4RegDef.CHN      = 1;
	Mesg.Mesg4RegDef.Dit_Step = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #5 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg5RegDef.KI     = 215; 
	Mesg.Mesg5RegDef.KP     = 115;
	Mesg.Mesg5RegDef.CHN    = 1;
	Mesg.Mesg5RegDef.MSG_ID = 5;
	Mesg.Mesg5RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #6 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg6RegDef.write    = 1;
	Mesg.Mesg6RegDef.CHN      = 1;
	Mesg.Mesg6RegDef.MSG_ID   = 6;
	Mesg.Mesg6RegDef.TMThresh = 300;
	Mesg.Mesg6RegDef.Preload  = 5;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #10 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg10RegDef.write  = 1;
	Mesg.Mesg10RegDef.MSG_ID = 10;
	Mesg.Mesg10RegDef.CHN    = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
}
/*******************************************************************************
* ����ԭ�ͣ�void ProportionalValve3_Init(void);
* �������ܣ���ʼ�� TLE7242-G ͨ����
* ���������NONE 
* ���������NONE 
*******************************************************************************/
void ProportionalValve3_Init(void)
{
	/* SPI Message #0 */
	Mesg.SPI_W_Mesg = 0;
	SPI_W_R_Byte(&Mesg);
	/* SPI Message #7 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg7RegDef.write     = 1;
	Mesg.Mesg7RegDef.MSG_ID    = 7;
	Mesg.Mesg7RegDef.CM        = 0;
	Mesg.Mesg7RegDef.FM        = 0;
	Mesg.Mesg7RegDef.FMR       = 0;
	Mesg.Mesg7RegDef.FME       = 0;
	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
	Mesg.Mesg7RegDef.AZDisable = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay(); 
	/* SPI Message #3 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg3RegDef.Cur_Set   = 309;			/* Current = 200mA */
	Mesg.Mesg3RegDef.Dit_EN    = 1;
	Mesg.Mesg3RegDef.Step_Size = 0;
	Mesg.Mesg3RegDef.ON_OFF    = 0;
	Mesg.Mesg3RegDef.EN        = 1;  
	Mesg.Mesg3RegDef.CHN       = 2;
	Mesg.Mesg3RegDef.MSG_ID    = 3; 
	Mesg.Mesg3RegDef.write     = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
  /* SPI Message #1 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1KHz
	Mesg.Mesg1RegDef.CHN    = 2;
	Mesg.Mesg1RegDef.MSG_ID = 1;
	Mesg.Mesg1RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #2 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg2RegDef.write  = 1;
	Mesg.Mesg2RegDef.MSG_ID = 2;
	Mesg.Mesg2RegDef.CHN    = 2;
	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #4 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg4RegDef.write    = 1;
	Mesg.Mesg4RegDef.MSG_ID   = 4;
	Mesg.Mesg4RegDef.CHN      = 2;
	Mesg.Mesg4RegDef.Dit_Step = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #5 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg5RegDef.KI     = 215; 
	Mesg.Mesg5RegDef.KP     = 115;
	Mesg.Mesg5RegDef.CHN    = 2;
	Mesg.Mesg5RegDef.MSG_ID = 5;
	Mesg.Mesg5RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #6 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg6RegDef.write    = 1;
	Mesg.Mesg6RegDef.CHN      = 2;
	Mesg.Mesg6RegDef.MSG_ID   = 6;
	Mesg.Mesg6RegDef.TMThresh = 0x00;
	Mesg.Mesg6RegDef.Preload  = 5;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #10 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg10RegDef.write  = 1;
	Mesg.Mesg10RegDef.MSG_ID = 10;
	Mesg.Mesg10RegDef.CHN    = 2;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
}
/*******************************************************************************
* ����ԭ�ͣ�void ProportionalValve4_Init(void);
* �������ܣ���ʼ�� TLE7242-G ͨ����
* ���������NONE 
* ���������NONE 
*******************************************************************************/
void ProportionalValve4_Init(void)
{
	/* SPI Message #0 */
	Mesg.SPI_W_Mesg = 0;
	SPI_W_R_Byte(&Mesg);
	/* SPI Message #7 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg7RegDef.write     = 1;
	Mesg.Mesg7RegDef.MSG_ID    = 7;
	Mesg.Mesg7RegDef.CM        = 0;
	Mesg.Mesg7RegDef.FM        = 0;
	Mesg.Mesg7RegDef.FMR       = 0;
	Mesg.Mesg7RegDef.FME       = 0;
	Mesg.Mesg7RegDef.DIAG_TMR  = 0;
	Mesg.Mesg7RegDef.AZDisable = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay(); 
	/* SPI Message #3 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg3RegDef.Cur_Set   = 0;			/* Current = 200mA */
	Mesg.Mesg3RegDef.Dit_EN    = 1;
	Mesg.Mesg3RegDef.Step_Size = 0;
	Mesg.Mesg3RegDef.ON_OFF    = 0;
	Mesg.Mesg3RegDef.EN        = 1;  
	Mesg.Mesg3RegDef.CHN       = 3;
	Mesg.Mesg3RegDef.MSG_ID    = 3; 
	Mesg.Mesg3RegDef.write     = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
  /* SPI Message #1 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg1RegDef.PWM_N  = 667;            //TLE7242_CHN1 Fpwm=1KHz
	Mesg.Mesg1RegDef.CHN    = 3;
	Mesg.Mesg1RegDef.MSG_ID = 1;
	Mesg.Mesg1RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #2 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg2RegDef.write  = 1;
	Mesg.Mesg2RegDef.MSG_ID = 2;
	Mesg.Mesg2RegDef.CHN    = 3;
	Mesg.Mesg2RegDef.PhaseSyncOffset = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #4 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg4RegDef.write    = 1;
	Mesg.Mesg4RegDef.MSG_ID   = 4;
	Mesg.Mesg4RegDef.CHN      = 3;
	Mesg.Mesg4RegDef.Dit_Step = 0;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #5 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg5RegDef.KI     = 215; 
	Mesg.Mesg5RegDef.KP     = 115;
	Mesg.Mesg5RegDef.CHN    = 3;
	Mesg.Mesg5RegDef.MSG_ID = 5;
	Mesg.Mesg5RegDef.write  = 1;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #6 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg6RegDef.write    = 1;
	Mesg.Mesg6RegDef.CHN      = 3;
	Mesg.Mesg6RegDef.MSG_ID   = 6;
	Mesg.Mesg6RegDef.TMThresh = 0x00;
	Mesg.Mesg6RegDef.Preload  = 5;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
	/* SPI Message #10 */
	Mesg.SPI_W_Mesg = 0;
	Mesg.Mesg10RegDef.write  = 1;
	Mesg.Mesg10RegDef.MSG_ID = 10;
	Mesg.Mesg10RegDef.CHN    = 3;
	SPI_W_R_Byte(&Mesg);
	delay();
	delay();
}
