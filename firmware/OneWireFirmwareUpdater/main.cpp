#define NDEBUG
#include "mbed.h"

#include <FirmwareUpdater.h>
#define WANT_TRACE 0
#include "trace.h"
#include <stdint.h>

#include "stm32f0xx_hal_rcc.h"

using namespace infernoembedded;

#if WANT_TRACE
#define BOOTLOADER_SIZE  	(32 * 1024)
#else
#define BOOTLOADER_SIZE  	(16 * 1024)
#endif
#define APP_START			(FLASH_BASE + BOOTLOADER_SIZE)
#define APP_END				(FLASH_BANK1_END)
#define APP_PAGES			((APP_END - APP_START) / FLASH_PAGE_SIZE)

#if WANT_TRACE
Serial trace(USBTX, USBRX, "trace", 921600);
#endif

DigitalOut led(LED1);
DigitalIn swClk(PA_14);

class FirmwareUpdateListener : public FirmwareListener {
public:
	uint32_t bootloaderSize() {
		return BOOTLOADER_SIZE;
	}

	bool eraseApplication() {
		FLASH_EraseInitTypeDef eraseInit;
		uint32_t faultedPage;

		if (HAL_FLASH_Unlock() != HAL_OK) {
			return 1;
		}

		eraseInit.PageAddress = APP_START;
		eraseInit.TypeErase = FLASH_TYPEERASE_PAGES;
		eraseInit.NbPages = APP_PAGES;
		if (HAL_FLASHEx_Erase(&eraseInit, &faultedPage) != HAL_OK) {
			TRACE("Failed to erase page 0x%08lx", faultedPage);
			return 1;
		}

		(void)HAL_FLASH_Lock();

		return 0;
	}

	bool write(uint32_t address, uint32_t data) {
		if (address < APP_START || address >= APP_END) {
			return 1;
		}

		if (HAL_FLASH_Unlock() != HAL_OK) {
			return 1;
		}

		if (HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, address, data)  != HAL_OK) {
			(void)HAL_FLASH_Lock();
			return 1;
		}

		(void)HAL_FLASH_Lock();

		return 0;
	}

	bool write(uint32_t address, uint32_t length, uint32_t *data) {
		if (address < APP_START || address >= APP_END) {
			TRACE("Address 0x%08lx out of bounds, must be between 0x%08lx & 0x%08lx", address, APP_START, APP_END);
			return 1;
		}

		if (HAL_FLASH_Unlock() != HAL_OK) {
			TRACE("Flash unlock failed");
			return 1;
		}

		for (uint32_t offset = 0; offset < length; offset++) {
			HAL_StatusTypeDef rc;
			while ((rc = HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, address + offset * 4, data[offset])) == HAL_BUSY) {}
			if (rc != HAL_OK) {
				TRACE("Flash program failed, rc=%d", rc);
				TRACE("HAL Error is %lu", HAL_FLASH_GetError());
				(void)HAL_FLASH_Lock();
				return 1;
			}
		}

		(void)HAL_FLASH_Lock();

		return 0;
	}


	bool read(uint32_t address, uint32_t *data) {
		if (address < APP_START || address >= APP_END) {
			return 1;
		}

		uint32_t *val = (uint32_t *)address;

		*data = *val;

		return 0;
	}

	void bootApplication() {
		TRACE("Booting application, Application vector table starts at 0x%08lx, Application starts at 0x%08lx, Stack pointer start at 0x%08lx",
						APP_START, *(__IO uint32_t*)(APP_START + 4), *(__IO uint32_t*) APP_START);

	    // disable global interrupt
	    __disable_irq();

	    // Disable all peripheral interrupts
	    NVIC_DisableIRQ(SysTick_IRQn);
	    NVIC_DisableIRQ(USART2_IRQn);

	    NVIC_DisableIRQ(WWDG_IRQn);
	    NVIC_DisableIRQ(RTC_IRQn);
	    NVIC_DisableIRQ(FLASH_IRQn);
	    NVIC_DisableIRQ(RCC_IRQn);
	    NVIC_DisableIRQ(EXTI0_1_IRQn);
	    NVIC_DisableIRQ(EXTI2_3_IRQn);
	    NVIC_DisableIRQ(EXTI4_15_IRQn);
	    NVIC_DisableIRQ(DMA1_Channel1_IRQn);
	    NVIC_DisableIRQ(DMA1_Channel2_3_IRQn);
	    NVIC_DisableIRQ(DMA1_Channel4_5_IRQn);
	    NVIC_DisableIRQ(ADC1_IRQn);
	    NVIC_DisableIRQ(TIM1_BRK_UP_TRG_COM_IRQn);
	    NVIC_DisableIRQ(TIM1_CC_IRQn);
	    NVIC_DisableIRQ(TIM3_IRQn);
	    NVIC_DisableIRQ(TIM6_IRQn);
	    NVIC_DisableIRQ(TIM14_IRQn);
	    NVIC_DisableIRQ(TIM15_IRQn);
	    NVIC_DisableIRQ(TIM16_IRQn);
	    NVIC_DisableIRQ(TIM17_IRQn);
	    NVIC_DisableIRQ(I2C1_IRQn);
	    NVIC_DisableIRQ(I2C2_IRQn);
	    NVIC_DisableIRQ(SPI1_IRQn);
	    NVIC_DisableIRQ(SPI2_IRQn);
	    NVIC_DisableIRQ(USART1_IRQn);
	    NVIC_DisableIRQ(USART2_IRQn);

	    // Copy interrupt vector table to the RAM.
	    volatile uint32_t *vectorTable = (volatile uint32_t *)0x20000000;

	    for(uint32_t vectorIndex = 0; vectorIndex < 48; vectorIndex++) {
	        vectorTable[vectorIndex] = *(__IO uint32_t*)((uint32_t)APP_START + (vectorIndex << 2));
	    }

	    __HAL_RCC_AHB_FORCE_RESET();

	    //  Enable SYSCFG peripheral clock
	    __HAL_RCC_SYSCFG_CLK_ENABLE();

	    __HAL_RCC_AHB_RELEASE_RESET();

	    // Remap RAM into 0x0000 0000 to use the application's vector table
	    __HAL_SYSCFG_REMAPMEMORY_SRAM();

	    // Reenable the global interrupt
	    __enable_irq();

	    // Boot the application
		uint32_t appAddress = *(__IO uint32_t*)(APP_START + 4);
		void (*app)(void) = (void (*)(void))appAddress;
		__set_MSP(*(__IO uint32_t*) APP_START);
		app();
	}

	void applicationRange (uint32_t *start, uint32_t *end) {
		*start = APP_START;
		*end = APP_END;
	}

	/**
	 * Calculate the CRC for a range of memory
	 * @param address the address of the range
	 * @param size the size of range
	 * @return the 16 bit CRC
	 */
	uint16_t crc(uint32_t address, uint32_t size) {
		uint16_t crc = OneWireSlave::crc16((uint8_t *)address, size, 0);

		TRACE("CRC for 0x%08lx, size %ld is %d", address, size, crc);

		return crc;
	}
};

FirmwareUpdateListener listener;

OneWireAddress address;
#ifdef RGBW_CONTROLLER_PROTOTYPE
FirmwareUpdater dev(PB_2, address, listener);
#else
FirmwareUpdater dev(PB_0, address, listener);
#endif

/**
 * Determine if the application has requested the bootloader
 * @return true if we should remain in the bootloader
 */
static bool wantBootloader() {
	bool ret = __HAL_RCC_GET_FLAG(RCC_FLAG_SFTRST) != 0;

	TRACE("wantBootloader = %s", ret ? "true" : "false");

	__HAL_RCC_CLEAR_RESET_FLAGS();

	return ret;
}

/**
 * Determine if the application has been programmed
 * @return true if the application is programmed
 */
static bool hasApplication() {
	bool ret = ((*(__IO uint32_t*)APP_START) & 0x2FFE0000) == 0x20000000;

	TRACE("hasApplication = %s", ret ? "true" : "false");

	return ret;
}

/**
 * Are we forced into the bootloader (by placing a jumper between SWCLK & Gnd)
 * @return true if the bootloader is forced
 */
static bool isForced() {
	bool ret = swClk.read() == 0;

	TRACE("forced = %s", ret ? "true" : "false");

	return ret;
}

int main() {
	TRACE("Firmware Updater online xxx");

	// Allow a jumper between SWCLK & Gnd to force entry to the bootloader
	swClk.mode(PullUp);

	if (hasApplication() && !wantBootloader() && !isForced()) {
		listener.bootApplication();
	}

    while (1) {
    	dev.poll();
    }
}
