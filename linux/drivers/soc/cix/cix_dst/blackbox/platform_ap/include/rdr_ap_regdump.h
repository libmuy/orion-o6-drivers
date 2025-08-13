/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef __RDR_AP_REGDUMP_H__
#define __RDR_AP_REGDUMP_H__

#include <linux/platform_device.h>

#define REGS_INFO_NAME_LEN 12
#define REG_NAME_LEN 12
#define REGS_DUMP_MAX_NUM 10

struct regs_info {
	char name[REGS_INFO_NAME_LEN];
	u32 size;
	u64 paddr;
	void __iomem *map_addr;
	unsigned char *dump_addr;
};

struct regs_dump {
	u32 num;
	struct regs_info info[REGS_DUMP_MAX_NUM];
};

void regsdump_debug_info(struct regs_dump *dump);
unsigned int get_total_regdump_size(struct regs_dump *dump);
void regs_dump(struct regs_dump *dump);
int regsdump_init(struct platform_device *pdev, struct regs_dump *dump,
		  void *addr);

#endif
