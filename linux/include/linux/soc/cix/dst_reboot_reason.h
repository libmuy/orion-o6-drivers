// SPDX-License-Identifier: GPL-2.0
/* Copyright 2024 Cix Technology Group Co., Ltd.*/
/**
 * SoC: CIX SKY1 platform
 */

#ifndef __DST_REBOOT_REASON_H__
#define __DST_REBOOT_REASON_H__

#include <linux/types.h>

void set_reboot_reason(unsigned int reboot_reason);
void set_subtype_exception(unsigned int subtype, bool save_value);
unsigned int get_reboot_reason(bool is_last);
unsigned int get_sub_reboot_reason(bool is_last);
void plat_pm_system_reset_comm(const char *cmd);

#endif
