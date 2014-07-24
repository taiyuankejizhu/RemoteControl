#include "gpio.h"

/*******************************************************************************
* ����ԭ�ͣ�void GPIO_H_Init(void);
* �������ܣ�GPIO ��ʼ��
* ���������NONE 
* ���������NONE
*******************************************************************************/
void GPIO_H_Init(void)
{
	
	GPIO_DeInit(GPIOA);
	/*����SPIƬѡCS����PA_5*/
	GPIO_Init(GPIOA,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*����TLE7242��ENABLE����*/
	GPIO_Init(GPIOA,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*����TLE7242��RESET_B����*/
	GPIO_Init(GPIOA,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
	
	GPIO_DeInit(GPIOB);
	/*���ð�������˿�Ϊ��������ģʽ*/
	GPIO_Init(GPIOB,GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3,GPIO_MODE_IN_FL_NO_IT);
	/*����ָʾ�ƶ˿�Ϊ�������ģʽ*/
	GPIO_Init(GPIOB,GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_FAST);
	
	GPIO_DeInit(GPIOC);
	/*����SPIʱ��SCK����PC_5*/
	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*����SPI�����MO����PC_6*/
	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*����SPI������MI����PC_7*/
	GPIO_Init(GPIOC,GPIO_PIN_7,GPIO_MODE_IN_PU_NO_IT);
	
	GPIO_DeInit(GPIOE);
	/*����TLE7242��FAULT����*/
	GPIO_Init(GPIOE,GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
	
	GPIO_DeInit(GPIOG);
	/*����TLE7242��PHASE_SY����*/
	GPIO_Init(GPIOG,GPIO_PIN_0,GPIO_MODE_OUT_PP_LOW_SLOW);
	
	/*����TLE7242��ENABLE,RESET_B����ߵ�ƽ*/
	GPIO_WriteHigh(GPIOA,GPIO_PIN_5);
	delay();
	delay();
	GPIO_WriteHigh(GPIOA,GPIO_PIN_6);
}

void GPIO_CS0(void)
{
	GPIO_WriteLow(GPIOA,GPIO_PIN_4);
}

void GPIO_CS1(void)
{
	GPIO_WriteHigh(GPIOA,GPIO_PIN_4);
}

void GPIO_LED(GPIO_Pin_TypeDef led)
{
	GPIO_WriteHigh(LED_PORT,led);
	delay();
	GPIO_WriteLow(LED_PORT,led);
}

BitStatus GPIO_KEY(GPIO_Pin_TypeDef key)
{
	return GPIO_ReadInputPin(KEY_PORT,key);
}

