#ifndef _GPIO_H
#define _GPIO_H
#include "stm8s.h"
#include "spi.h"

#define LED_0 GPIO_PIN_4
#define LED_1 GPIO_PIN_5
#define LED_2 GPIO_PIN_6
#define LED_PORT GPIOB

#define KEY_0 GPIO_PIN_0
#define KEY_1 GPIO_PIN_1
#define KEY_2 GPIO_PIN_2
#define KEY_3 GPIO_PIN_3
#define KEY_PORT GPIOB

void GPIO_H_Init(void);
void GPIO_CS0(void);
void GPIO_CS1(void);
void GPIO_LED(GPIO_Pin_TypeDef);
BitStatus GPIO_KEY(GPIO_Pin_TypeDef);

#endif
