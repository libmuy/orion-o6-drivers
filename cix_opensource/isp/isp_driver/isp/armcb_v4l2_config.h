/* SPDX-License-Identifier: GPL-2.0 */
/*
 * Copyright (c) 2021-2021, The Linux Foundation. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 and
 * only version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */
#ifndef __ARMCB_V4L2_CONFIG_H__
#define __ARMCB_V4L2_CONFIG_H__

#include "armcb_isp_driver.h"
#include <linux/interrupt.h>
#include <media/v4l2-device.h>

typedef enum {
	ISP_DAEMON_EVENT_START = 100,
	ISP_DAEMON_EVENT_SET_CAM_ID, // 101
	ISP_DAEMON_EVENT_SET_STREAM_ID, // 102
	ISP_DAEMON_EVENT_SET_FMT, // 103
	ISP_DAEMON_EVENT_PUT_FRAME, // 104
	ISP_DAEMON_EVENT_GET_FRAME, // 105
	ISP_DAEMON_EVENT_STREAM_ON, // 106
	ISP_DAEMON_EVENT_STREAM_OFF, // 107
	ISP_DAEMON_EVENT_SET_IMG_SIZE, // 108
	ISP_DAEMON_EVENT_MAX
} isp_daemon_event;

struct armcb_irq_event {
	struct isp_irq_info info;
	struct list_head fh_node;
};

struct armcb_irq_msg_fh {
	struct armcb_irq_event ev_array[32];
	int in_use;
	int first;
	int elems;
	spinlock_t fh_lock;
	struct list_head avaliable;
};

typedef struct armcb_v4l2_config_dev {
	struct platform_device *pvdev;

	/* device */
	struct v4l2_device v4l2_dev;
	struct video_device vid_cap_dev;

	struct device *mem_device;

	spinlock_t slock;
	struct mutex mutex;
	spinlock_t v4l2_event_slock;
	struct mutex v4l2_event_mutex;
	/* capabilities */
	u32 vid_cap_caps;

	/* open counter for stream id */
	atomic_t opened;
	unsigned int stream_mask;

	/* Error injection (not used now)*/
	bool queue_setup_error;
	bool buf_prepare_error;
	bool start_streaming_error;
	bool dqbuf_error;
	bool seq_wrap;
	bool has_vid_cap;
	/* video capture */
	struct v4l2_async_notifier notifier;
	struct media_entity_enum crashed;
	struct media_device media_dev;

	/* buffer_done_work */
	struct tasklet_struct buffer_done_task;
	struct armcb_irq_msg_fh isr_fh;

	struct vb2_queue vb2_q;
	struct v4l2_pix_format_mplane pix;
	struct mutex lock;

	/* for v4l2 adapte */
	armcb_v4l2_stream_t *pstream;
	int32_t stream_id_index;
	atomic_t stream_on_cnt;
	uint32_t ctx_id;
	int stream_init_done;

} armcb_v4l2_config_dev_t;

/* Support Maxmum 2 planes color format */
#define MAX_PLANES 2

struct isp_config_fmt {
	char *name;
	u32 mbus_code;
	u32 fourcc;
	u32 color;
	u16 memplanes;
	u16 colplanes;
	u8 colorspace;
	u8 depth[MAX_PLANES];
	u16 mdataplanes;
	u16 flags;
};

struct frame_addr {
	u64 y;
	u64 cb;
};

struct arm_cfg_buffer {
	struct vb2_v4l2_buffer v4l2_buf;
	struct list_head list;
	struct frame_addr paddr;
	bool discard;
};

static inline unsigned int irqev_pos(const struct armcb_irq_msg_fh *fh,
				 unsigned int idx)
{
	idx += fh->first;
	return idx >= fh->elems ? idx - fh->elems : idx;
}

int armcb_v4l2_config_update_stream_vin_addr(armcb_v4l2_stream_t *pstream);
int armcb_v4l2_config_update_stream_hw_addr(armcb_v4l2_stream_t *pstream);
int armcb_v4l2_config_update_stream_hw_addr_vb2(armcb_v4l2_stream_t *pstream);
void armcb_isp_put_frame_vb2(uint32_t ctx_id, int stream_id,
			     isp_output_port_t port);

#ifdef ARMCB_CAM_KO
void *armcb_get_v4l2_cfg_driver_instance(void);
void armcb_v4l2_cfg_driver_destroy(void);
#endif

#endif
