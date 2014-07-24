/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "spi.h"
#include "gpio.h"

MesgWStructDef        Mesg;
MesgRStructDef        RMesg;

void main()
{
	GPIO_H_Init();
	SPI_H_Init();
	
  while (1)
	{
		if (!GPIO_KEY(KEY_3))
    {
			ProportionalValve3_Init();
			GPIO_LED(LED_2);
    }
		else if(!GPIO_KEY(KEY_2))
		{
			ProportionalValve3_Init();
			GPIO_LED(LED_1);
	  }
		else if(!GPIO_KEY(KEY_1))
		{
			ProportionalValve2_Init();
			GPIO_LED(LED_0);
	  }
		
		else if(!GPIO_KEY(KEY_0))
		{		
			ProportionalValve1_Init();
			GPIO_LED(LED_0);
			GPIO_LED(LED_1);
			GPIO_LED(LED_2);
		}
	}
}