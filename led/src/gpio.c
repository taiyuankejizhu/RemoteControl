#include "gpio.h"

/*******************************************************************************
* 函数原型：void GPIO_H_Init(void);
* 函数功能：GPIO 初始化
* 输入参数：NONE 
* 输出参数：NONE
*******************************************************************************/
void GPIO_H_Init(void)
{
	
	GPIO_DeInit(GPIOA);
	/*设置SPI片选CS引脚PA_5*/
	GPIO_Init(GPIOA,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*设置TLE7242的ENABLE引脚*/
	GPIO_Init(GPIOA,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*设置TLE7242的RESET_B引脚*/
	GPIO_Init(GPIOA,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
	
	GPIO_DeInit(GPIOB);
	/*设置按键输入端口为浮动输入模式*/
	GPIO_Init(GPIOB,GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3,GPIO_MODE_IN_FL_NO_IT);
	/*设置指示灯端口为低速输出模式*/
	GPIO_Init(GPIOB,GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_FAST);
	
	GPIO_DeInit(GPIOC);
	/*设置SPI时钟SCK引脚PC_5*/
	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*设置SPI主输出MO引脚PC_6*/
	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
	/*设置SPI主输入MI引脚PC_7*/
	GPIO_Init(GPIOC,GPIO_PIN_7,GPIO_MODE_IN_PU_NO_IT);
	
	GPIO_DeInit(GPIOE);
	/*设置TLE7242的FAULT引脚*/
	GPIO_Init(GPIOE,GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
	
	GPIO_DeInit(GPIOG);
	/*设置TLE7242的PHASE_SY引脚*/
	GPIO_Init(GPIOG,GPIO_PIN_0,GPIO_MODE_OUT_PP_LOW_SLOW);
	
	/*设置TLE7242的ENABLE,RESET_B输出高电平*/
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

