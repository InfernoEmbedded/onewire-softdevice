/*
 * trace.h
 *
 *  Created on: 8Dec.,2016
 *      Author: Alastair
 */

#ifndef TRACE_H_
#define TRACE_H_

#ifndef WANT_TRACE
#define WANT_TRACE 0
#endif

#if WANT_TRACE
#define TRACE(__dbg_format, __dbg_args...) \
do {\
	printf("%s:%d\t%s():\t\t",__FILE__, __LINE__, __func__); \
	printf(__dbg_format, ## __dbg_args); \
	printf("\r\n"); \
} while (0)
#else
#define TRACE(__dbg_format, __dbg_args...)
#endif

#define DUMPREG(reg) \
	do { \
		TRACE("%s = %ld  %x %c%c%c%c%c%c%c%c %c%c%c%c%c%c%c%c", #reg, reg, reg, \
			(reg & (1 << 15)) ? '1' : '0', (reg & (1 << 14)) ? '1' : '0', (reg & (1 << 13)) ? '1' : '0', \
			(reg & (1 << 12)) ? '1' : '0', (reg & (1 << 11)) ? '1' : '0', (reg & (1 << 10)) ? '1' : '0', \
			(reg & (1 << 9)) ? '1' : '0', (reg & (1 << 8)) ? '1' : '0', (reg & (1 << 7)) ? '1' : '0', \
			(reg & (1 << 6)) ? '1' : '0', (reg & (1 << 5)) ? '1' : '0', (reg & (1 << 4)) ? '1' : '0', \
			(reg & (1 << 3)) ? '1' : '0', (reg & (1 << 2)) ? '1' : '0', (reg & (1 << 1)) ? '1' : '0', \
			(reg & (1 << 0)) ? '1' : '0'); \
	} while (0)


#endif /* TRACE_H_ */
