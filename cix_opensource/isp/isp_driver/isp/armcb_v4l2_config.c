// SPDX-License-Identifier: GPL-2.0
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
#include "armcb_camera_io_drv.h"
#include "armcb_isp.h"
#include "armcb_isp_driver.h"
#include "armcb_isp_hw_reg.h"
#include "armcb_platform.h"
#include "armcb_register.h"
#include "armcb_v4l2_core.h"
#include "armcb_v4l_sd.h"
#include "armcb_vb2.h"
#include "isp_hw_ops.h"
#include "linux/list.h"
#include "linux/spinlock.h"
#include "system_dma.h"
#include <linux/errno.h>
#include <linux/font.h>
#include <linux/ftrace.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/platform_device.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/v4l2-dv-timings.h>
#include <linux/videodev2.h>
#include <linux/vmalloc.h>
#include <media/v4l2-dv-timings.h>
#include <media/v4l2-event.h>
#include <media/v4l2-fh.h>
#include <media/v4l2-ioctl.h>
#include <media/videobuf2-dma-contig.h>
#include <media/videobuf2-vmalloc.h>

#include "armcb_v4l2_config.h"
#include "system_logger.h"

#if 0
#ifdef CONFIG_PLAT_BBOX
#include <linux/soc/cix/rdr_pub.h>
#include <mntn_public_interface.h>
#endif
#endif

#define ARMCB_MODULE_NAME "armcb_v4l2_config"

static armcb_v4l2_stream_t *g_t_pstream;

typedef void (*put_frame_func_t)(uint32_t ctx_id, int stream_id,
				 isp_output_port_t port);
#ifndef CIX_V4L2_ADAPTER
put_frame_func_t PUT_FRAME = armcb_isp_put_frame;
#else
put_frame_func_t PUT_FRAME = armcb_isp_put_frame_vb2;
#endif

#if 0
#ifdef CONFIG_PLAT_BBOX
u64 g_isp_addr;

enum RDR_ISP_MODID {
	RDR_ISP_MODID_START = PLAT_BB_MOD_ISP_START,
	RDR_ISP_SOC_ISR_ERR_MODID,
	RDR_ISP_MODID_END = PLAT_BB_MOD_ISP_END,
};

static struct rdr_register_module_result g_current_info;

static struct rdr_exception_info_s g_isp_einfo[] = {
	{ { 0, 0 },
	  RDR_ISP_SOC_ISR_ERR_MODID,
	  RDR_ISP_SOC_ISR_ERR_MODID,
	  RDR_ERR,
	  RDR_REBOOT_NO,
	  RDR_ISP,
	  RDR_ISP,
	  RDR_ISP,
	  (u32)RDR_REENTRANT_DISALLOW,
	  ISP_S_EXCEPTION,
	  0,
	  (u32)RDR_UPLOAD_YES,
	  "isp",
	  "isp isr proc",
	  0,
	  0,
	  0 },
};

static struct completion g_rdr_dump_comp;

static int rdr_writen_num;

/*
 * Description : Dump function of the AP when an exception occurs
 */
static void cix_isp_rproc_rdr_dump(u32 modid, u32 etype, u64 coreid,
				   char *log_path)
{
}

/*
 * Description : register exception with the rdr
 */
static void cix_isp_rproc_rdr_register_exception(void)
{
	unsigned int i;
	int ret;

	for (i = 0;
		 i < sizeof(g_isp_einfo) / sizeof(struct rdr_exception_info_s);
		 i++) {
		LOG(LOG_DEBUG, "register exception:%u",
			g_isp_einfo[i].e_exce_type);
		ret = rdr_register_exception(&g_isp_einfo[i]);
		if (ret == 0) {
			LOG(LOG_ERR,
				"rdr_register_exception fail, ret = [%d]\n", ret);
			return;
		}
	}
}

static void cix_isp_rproc_rdr_unregister_exception(void)
{
	unsigned int i;

	for (i = 0;
		 i < sizeof(g_isp_einfo) / sizeof(struct rdr_exception_info_s);
		 i++) {
		LOG(LOG_DEBUG, "unregister exception:%u",
			g_isp_einfo[i].e_exce_type);
		rdr_unregister_exception(g_isp_einfo[i].e_modid);
	}
}

/*
 * Description : Register the dump and reset functions to the rdr
 */
static int cix_isp_rproc_rdr_register_core(void)
{
	struct rdr_module_ops_pub s_isp_ops;
	struct rdr_register_module_result retinfo;
	u64 coreid = RDR_ISP;
	int ret;

	s_isp_ops.ops_dump = cix_isp_rproc_rdr_dump;
	s_isp_ops.ops_reset = NULL;

	ret = rdr_register_module_ops(coreid, &s_isp_ops, &retinfo);
	if (ret < 0) {
		LOG(LOG_ERR, "rdr_register_module_ops fail, ret = [%d]\n", ret);
		return ret;
	}

	g_current_info.log_addr = retinfo.log_addr;
	g_current_info.log_len = retinfo.log_len;
	g_current_info.nve = retinfo.nve;

	g_isp_addr = (uintptr_t)rdr_bbox_map(g_current_info.log_addr,
						 g_current_info.log_len);
	if (!g_isp_addr) {
		LOG(LOG_ERR, "hisi_bbox_map g_hisiap_addr fail\n");
		return -1;
	}

	LOG(LOG_DEBUG, "%d: addr=0x%llx   [0x%llx], len=0x%x",
		__LINE__, g_current_info.log_addr, g_isp_addr,
		g_current_info.log_len);

	return ret;
}

static void cix_isp_rproc_rdr_unregister_core(void)
{
	u64 coreid = RDR_ISP;

	rdr_unregister_module_ops(coreid);
}
#endif
#endif

static int streamOnFlag;
struct isp_config_fmt isp_config_src_formats[] = {
	{
		.name = "NV12M",
		.fourcc = V4L2_PIX_FMT_NV12M,
		.depth = { 8, 8 },
		.memplanes = 2,
		.mbus_code = MEDIA_BUS_FMT_YUYV8_1_5X8,
	},
	{
		.name = "RGB888",
		.fourcc = V4L2_PIX_FMT_RGB24,
		.depth = { 24 },
		.memplanes = 1,
		.mbus_code = MEDIA_BUS_FMT_RGB888_1X24,
	}
};

struct isp_config_fmt *isp_config_get_format(unsigned int index)
{
	return &isp_config_src_formats[index];
}

/*
 * lookup color format by fourcc or media bus format
 */
struct isp_config_fmt *isp_config_find_format(const u32 *pixelformat,
						  const u32 *mbus_code, int index)
{
	struct isp_config_fmt *fmt, *def_fmt = NULL;
	int i;

	if (index >= ARRAY_SIZE(isp_config_src_formats))
		return NULL;

	for (i = 0; i < ARRAY_SIZE(isp_config_src_formats); i++) {
		fmt = &isp_config_src_formats[i];

		if ((pixelformat && (fmt->fourcc == *pixelformat)) ||
			(mbus_code && (fmt->mbus_code == *mbus_code))) {
			return fmt;
		}

		if (index == i)
			def_fmt = fmt;
	}
	return def_fmt;
}

void armcb_isp_put_frame_vb2(uint32_t ctx_id, int stream_id,
				 isp_output_port_t port)
{
	armcb_v4l2_stream_t *pstream = NULL;
	armcb_v4l2_buffer_t *pbuf = NULL;
	struct vb2_buffer *vb = NULL;

	static armcb_v4l2_buffer_t *splastbuf;
	armcb_v4l2_buffer_t *plastbuf = NULL;

	pstream = g_t_pstream;

	/* check if stream is on */
	if (!pstream || !pstream->stream_started) {
		LOG(LOG_DEBUG, "[Stream#%d] is not started yet on ctx %d",
			stream_id, ctx_id);
		return;
	}

	plastbuf = list_last_entry(&(pstream->stream_buffer_list_busy),
				   armcb_v4l2_buffer_t, list);

	/* try to get an active buffer from vb2 queue  */
	if (!list_empty(&pstream->stream_buffer_list_busy)) {
		if (!list_is_singular(&pstream->stream_buffer_list_busy) ||
			(plastbuf == splastbuf)) {
			pbuf = list_entry(pstream->stream_buffer_list_busy.next,
					  armcb_v4l2_buffer_t, list);
			list_del(&pbuf->list);
		}
	}
	splastbuf = list_last_entry(&(pstream->stream_buffer_list_busy),
					armcb_v4l2_buffer_t, list);

	if (!pbuf) {
		/// @TODO: need to use reserved buffer to hw output.
		LOG(LOG_DEBUG, "[Stream#%d] type: %d no empty buffers",
			pstream->stream_id, V4L2_STREAM_TYPE_VIDEO);
		return;
	}
	vb = &pbuf->vvb.vb2_buf;
	vb->planes[0].bytesused = vb->planes[0].length;
	vb->planes[1].bytesused = vb->planes[1].length;
	vb->timestamp = ktime_get_ns();

	vb2_buffer_done(vb, VB2_BUF_STATE_DONE);
	LOG(LOG_DEBUG, "set buf %p to done :%d", vb, vb->planes[0].bytesused);
}

typedef enum { ISP_TYPE_I5, ISP_TYPE_I5_CUS0, ISP_TYPE_I7 } armcb_isp_type_t;

typedef i7_top_top_reg_44_t i7_frm_cnt_ctrl_t;
typedef i7_top_top_reg_4c_t i7_vin_in_sof_channel_t;
typedef i7_top_top_reg_50_t i7_sof_type_ctrl_t;
typedef i7_top_top_reg_c0_t i7_index_type_t;
typedef i5_top_top_reg_68_t i5_index_t;

struct armcb_isp_info {
	armcb_isp_type_t type;
	irqreturn_t (*isp_isr)(s32 irq, void *subdev);
	irqreturn_t (*isp_err_isr)(s32 irq, void *subdev);
};

#ifndef CIX_V4L2_ADAPTER
static armcb_v4l2_config_dev_t *p_v4l_config_dev;
#endif

static irqreturn_t armcb_I5_isp_isr(s32 irq, void *pdev);
static irqreturn_t armcb_I7_isp_isr(s32 irq, void *pdev);
static irqreturn_t armcb_I7_isp_err_isr(s32 irq, void *pdev);

static int armcb_get_vout_addr_by_outport_i5(uint32_t outport,
						 uint32_t *p_vout_reg1,
						 uint32_t *p_vout_reg2)
{
	int rc = 0;
	uint32_t vout_reg1 = 0;
	uint32_t vout_reg2 = 0;

	if (outport & (1 << ISP_OUTPUT_PORT_3A)) {
		vout_reg1 = I5_3A_START_ADDR;
		vout_reg2 = 0;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT0)) {
		vout_reg1 = I5_VOUT0_START_ADDR;
		vout_reg2 = 0;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT1)) {
		vout_reg1 = I5_VOUT1_START_ADDR;
		vout_reg2 = 0;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT2)) {
		vout_reg1 = I5_VOUT2_START_ADDR;
		vout_reg2 = 0;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT3)) {
		vout_reg1 = I5_VOUT3_START_ADDR;
		vout_reg2 = 0;
	} else {
		LOG(LOG_ERR, "invalid outport used, outport:%d", outport);
		rc = -EINVAL;
	}
	*p_vout_reg1 = vout_reg1;
	*p_vout_reg2 = vout_reg2;
	return rc;
}

static int armcb_get_vin_addr_by_outport_i7(uint32_t outport,
						uint32_t *p_vin_daw_reg,
						uint32_t *p_vin_dar_reg)
{
	int rc = 0;
	uint32_t vin_daw_reg = 0;
	uint32_t vin_dar_reg = 0;

	if (outport & (1 << ISP_OUTPUT_PORT_VIN)) {
		vin_daw_reg = I7_VIN_LONG_START_ADDR_DAW0 + 0x10;
		vin_dar_reg = I7_VIN_LONG_START_ADDR_DAR0 + 0x10;
	} else {
		rc = -EINVAL;
	}
	*p_vin_daw_reg = vin_daw_reg;
	*p_vin_dar_reg = vin_dar_reg;

	return rc;
}

static int armcb_get_output_addr_by_outport_i7(uint32_t outport,
						   uint32_t *p_vout_reg1,
						   uint32_t *p_vout_reg2)
{
	int rc = 0;
	uint32_t vout_reg1 = 0;
	uint32_t vout_reg2 = 0;

#ifdef ENABLE_RUNTIME_UPDATE_STATS_ADDR
	if (outport & (1 << ISP_OUTPUT_PORT_3A)) {
		vout_reg1 = I7_3A_START_ADDR;
		vout_reg2 = 0;
	}
#endif
	if (outport & 1 << ISP_OUTPUT_PORT_VOUT0) {
		vout_reg1 = I7_VOUT0_START_ADDR;
		vout_reg2 = 0;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT1)) {
		vout_reg1 = I7_VOUT1_START_ADDR;
		vout_reg2 = I7_VOUT2_START_ADDR;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT3)) {
		vout_reg1 = I7_VOUT3_START_ADDR;
		vout_reg2 = I7_VOUT4_START_ADDR;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT5)) {
		vout_reg1 = I7_VOUT5_START_ADDR;
		vout_reg2 = I7_VOUT6_START_ADDR;
	} else if (outport & (1 << ISP_OUTPUT_PORT_VOUT7)) {
		vout_reg1 = I7_VOUT7_START_ADDR;
		vout_reg2 = I7_VOUT8_START_ADDR;
	} else {
		rc = -EINVAL;
	}
	*p_vout_reg1 = vout_reg1;
	*p_vout_reg2 = vout_reg2;

	return rc;
}

int armcb_v4l2_config_update_stream_vin_addr(armcb_v4l2_stream_t *pstream)
{
	armcb_v4l2_buffer_t *pbuf = NULL;
	struct v4l2_format *v4l2_fmt = NULL;
	unsigned int vin_daw_reg = 0;
	unsigned int vin_dar_reg = 0;
	unsigned int startaddr = 0;

	if (armcb_get_vin_addr_by_outport_i7(pstream->outport, &vin_daw_reg,
						 &vin_dar_reg) < 0) {
		LOG(LOG_DEBUG,
			"ctx_id:%d stream_id:%d failed to get reg for outport:%d",
			pstream->ctx_id, pstream->stream_id, pstream->outport);
		return -EINVAL;
	}

	v4l2_fmt = &pstream->cur_v4l2_fmt;
	/* try to get an active buffer from vb2 queue  */
	if (!list_empty(&pstream->stream_buffer_list)) {
		pbuf = list_entry(pstream->stream_buffer_list.next,
				  armcb_v4l2_buffer_t, list);
		list_del(&pbuf->list);
		list_add_tail(&pbuf->list, &pstream->stream_buffer_list_busy);
	}

	if (!pbuf) {
		LOG(LOG_DEBUG, "[Stream#%d] no empty buffers",
			pstream->stream_id);
		startaddr = pstream->reserved_buf_addr;
	} else {
		startaddr = (unsigned int)(uintptr_t)vb2_plane_vaddr(
			&pbuf->vvb.vb2_buf, 0);
	}

	if (vin_dar_reg && vin_daw_reg && startaddr) {
		LOG(LOG_DEBUG,
			"[Stream#%d] set daw0(0x%x) & dar0(0x%x) startaddr(0x%x) "
			"reserved_buf_addr(0x%x) VIN_BUFFER_LONG_ADDR(0x%x)",
			pstream->stream_id, vin_daw_reg, vin_dar_reg, startaddr,
			pstream->reserved_buf_addr, VIN_BUFFER_LONG_ADDR);
		armcb_isp_write_reg(vin_daw_reg, startaddr);
		armcb_isp_write_reg(vin_dar_reg, startaddr);
	}

	return 0;
}

int armcb_v4l2_config_update_stream_hw_addr(armcb_v4l2_stream_t *pstream)
{
	armcb_v4l2_buffer_t *pbuf = NULL;
	struct v4l2_format *v4l2_fmt = NULL;
	unsigned int vout_reg1 = 0;
	unsigned int vout_reg2 = 0;
	unsigned int startaddr = 0;

	if (armcb_get_output_addr_by_outport_i7(pstream->outport, &vout_reg1,
						&vout_reg2) < 0) {
		LOG(LOG_DEBUG,
			"ctx_id:%d stream_id:%d failed to get reg for outport:%d",
			pstream->ctx_id, pstream->stream_id, pstream->outport);
		return -EINVAL;
	}

	v4l2_fmt = &pstream->cur_v4l2_fmt;
	/* try to get an active buffer from vb2 queue  */
	if (!list_empty(&pstream->stream_buffer_list)) {
		pbuf = list_entry(pstream->stream_buffer_list.next,
				  armcb_v4l2_buffer_t, list);
		list_del(&pbuf->list);
		list_add_tail(&pbuf->list, &pstream->stream_buffer_list_busy);
	}

	if (!pbuf) {
		LOG(LOG_DEBUG, "[Stream#%d] no empty buffers",
			pstream->stream_id);
		startaddr = pstream->reserved_buf_addr;
	} else {
		startaddr = (unsigned int)(uintptr_t)vb2_plane_vaddr(
			&pbuf->vvb.vb2_buf, 0);
	}

	if (vout_reg1 && startaddr) {
		LOG(LOG_DEBUG, "[Stream#%d] set addr: 0x%x = 0x%x",
			pstream->stream_id, vout_reg1, startaddr);
		armcb_isp_write_reg(vout_reg1, startaddr);
	}

	if (vout_reg2 && startaddr) {
		startaddr += v4l2_fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
		LOG(LOG_DEBUG, "[Stream#%d] set addr: 0x%x = 0x%x",
			pstream->stream_id, vout_reg2, startaddr);
		armcb_isp_write_reg(vout_reg2, startaddr);
	}

	return 0;
}

int armcb_v4l2_config_update_stream_hw_addr_vb2(armcb_v4l2_stream_t *pstream)
{
	int rc = 0;
	unsigned int vout_reg1 = 0;
	unsigned int vout_reg2 = 0;
	unsigned int startaddr = 0;
	armcb_v4l2_buffer_t *pbuf = NULL;
	struct v4l2_format *v4l2_fmt = NULL;
	armcb_v4l2_stream_t *pstreamReserved = NULL;
	struct isp_config_fmt *fmt =
		&isp_config_src_formats[g_t_pstream->isp_fmt_index];

	rc = armcb_v4l2_find_stream(&pstreamReserved, 0, 0);
	if (rc) {
		LOG(LOG_INFO, "armcb_v4l2_find_stream failed, rc=%d", rc);
		return rc;
	}
	pstream->reserved_buf_addr = pstreamReserved->reserved_buf_addr;
	switch (fmt->fourcc) {
	case V4L2_PIX_FMT_NV12M:
	case V4L2_PIX_FMT_NV12:
	case V4L2_PIX_FMT_NV21M:
	case V4L2_PIX_FMT_NV21:
		pstream->outport = 1 << ISP_OUTPUT_PORT_VOUT1;
		break;
	case V4L2_PIX_FMT_RGB24:
	case V4L2_PIX_FMT_BGR24:
	case V4L2_PIX_FMT_BGR32:
	case V4L2_PIX_FMT_RGB32:
		pstream->outport = 1 << ISP_OUTPUT_PORT_VOUT0;
		break;
	default:
		pstream->outport = 1 << ISP_OUTPUT_PORT_VOUT1;
		LOG(LOG_INFO, "not support fourcc:%d", fmt->fourcc);
	}

	if (armcb_get_output_addr_by_outport_i7(pstream->outport, &vout_reg1,
						&vout_reg2) < 0) {
		LOG(LOG_INFO,
			"ctx_id:%d stream_id:%d failed to get reg for outport:%d",
			pstream->ctx_id, pstream->stream_id, pstream->outport);
		return -EINVAL;
	}

	v4l2_fmt = &pstream->cur_v4l2_fmt;
	/* try to get an active buffer from vb2 queue */
	if (!list_empty(&pstream->stream_buffer_list)) {
		pbuf = list_entry(pstream->stream_buffer_list.next,
				  armcb_v4l2_buffer_t, list);
		list_del(&pbuf->list);
		list_add_tail(&pbuf->list, &pstream->stream_buffer_list_busy);
	}
	if (!pbuf) {
		LOG(LOG_DEBUG, "[Stream#%d] no empty buffers",
			pstream->stream_id);
		startaddr = pstream->reserved_buf_addr;
		if (vout_reg1 && startaddr) {
			LOG(LOG_DEBUG, "[Stream#%d] set addr: 0x%x = 0x%x",
				pstream->stream_id, vout_reg1, startaddr);
			armcb_isp_write_reg(vout_reg1, startaddr);
		}

		if (vout_reg2 && startaddr) {
			startaddr +=
				v4l2_fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
			LOG(LOG_DEBUG, "[Stream#%d] set addr: 0x%x = 0x%x",
				pstream->stream_id, vout_reg2, startaddr);
			armcb_isp_write_reg(vout_reg2, startaddr);
		}
	} else {
		startaddr =
			vb2_dma_contig_plane_dma_addr(&pbuf->vvb.vb2_buf, 0);
		armcb_isp_write_reg(vout_reg1, startaddr);

		if (vout_reg2 && startaddr) {
			if (pbuf->vvb.vb2_buf.num_planes > 1) {
				startaddr = vb2_dma_contig_plane_dma_addr(
					&pbuf->vvb.vb2_buf, 1);
			}
			armcb_isp_write_reg(vout_reg2, startaddr);
			LOG(LOG_DEBUG, "start_addr_1 = 0x%x\n", startaddr);
		}
	}
	return rc;
}

static void armcb_isp_irq_sol_i5(unsigned int ctx_id)
{
	int rc = 0;
	int i = 0;
	armcb_v4l2_stream_t *pstream = NULL;
	armcb_v4l2_buffer_t *pbuf = NULL;
	struct v4l2_format *v4l2_fmt = NULL;
	unsigned int vout_reg1 = 0;
	unsigned int vout_reg2 = 0;
	unsigned int startaddr = 0;

	LOG(LOG_DEBUG, "sof ctx_id=%u", ctx_id);
	for (i = 0; i < V4L2_STREAM_TYPE_MAX; i++) {
		/* find stream pointer */
		rc = armcb_v4l2_find_stream(&pstream, ctx_id, i);
		if (rc < 0) {
			LOG(LOG_INFO,
				"can't find stream on ctx %d (errno = %d)", ctx_id,
				rc);
			return;
		}

		/* check if stream is on */
		if (!pstream->stream_started) {
			LOG(LOG_INFO,
				"[Stream#%d] stream META is not started yet on ctx %d",
				pstream->stream_id, ctx_id);
			return;
		}

		if (armcb_get_vout_addr_by_outport_i5(
				pstream->outport, &vout_reg1, &vout_reg2) < 0) {
			LOG(LOG_ERR,
				"ctx_id:%d stream_id:%d failed to get vout reg for outport:%d",
				ctx_id, pstream->stream_id, pstream->outport);
			continue;
		}
		v4l2_fmt = &pstream->cur_v4l2_fmt;
		/* try to get an active buffer from vb2 queue  */
		if (!list_empty(&pstream->stream_buffer_list)) {
			pbuf = list_entry(pstream->stream_buffer_list.next,
					  armcb_v4l2_buffer_t, list);
			list_del(&pbuf->list);
			list_add_tail(&pbuf->list,
					  &pstream->stream_buffer_list_busy);
		}

		if (!pbuf) {
			LOG(LOG_DEBUG, "[Stream#%d] no empty buffers",
				pstream->stream_id);
			startaddr = pstream->reserved_buf_addr;
		} else {
			startaddr = (unsigned int)(uintptr_t)vb2_plane_vaddr(
				&pbuf->vvb.vb2_buf, 0);
		}

		if ((v4l2_fmt->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_NV21 ||
			 v4l2_fmt->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_NV12) &&
			startaddr) {
			armcb_isp_write_reg(vout_reg1, startaddr);
		}
	}
}

static void armcb_isp_irq_sol_i7(unsigned int ctx_id)
{
	armcb_v4l2_stream_t *pstream = NULL;
#ifndef CIX_V4L2_ADAPTER
	int i = 0;
	int rc = 0;
	armcb_v4l2_dev_t *pdev = NULL;

	pdev = armcb_v4l2_core_get_dev(ctx_id);
	if (pdev && atomic_read(&pdev->opened) == 0)
		ctx_id = armcb_v4l2_core_find_1st_opened_dev();
	LOG(LOG_DEBUG, "sof ctx_id=%u", ctx_id);

	for (i = 0; i < V4L2_STREAM_TYPE_MAX; i++) {
		/* find stream pointer */
		rc = armcb_v4l2_find_stream(&pstream, ctx_id, i);
		if (rc < 0) {
			LOG(LOG_DEBUG,
				"can't find stream on ctx %d (errno = %d)", ctx_id,
				rc);
			continue;
		}

		LOG(LOG_DEBUG, "sol cxt_id:%d, stream_id:%d", pstream->ctx_id,
			pstream->stream_id);
		/* check if stream is on */
		if (!pstream->stream_started) {
			LOG(LOG_DEBUG,
				"[Stream#%d] stream video is not started yet on ctx %d",
				pstream->stream_id, ctx_id);
			continue;
		}

		if (armcb_v4l2_config_update_stream_hw_addr(pstream)) {
			LOG(LOG_DEBUG,
				"[Stream#%d] failed to update stream hw addr for cxt_id:%d",
				pstream->stream_id, ctx_id);
		}
	}
#else
	pstream = g_t_pstream;
	if (armcb_v4l2_config_update_stream_hw_addr_vb2(pstream)) {
		LOG(LOG_INFO, "[Stream#%d] failed to update stream hw addr",
			pstream->stream_id);
		if (!pstream->stream_started) {
			LOG(LOG_DEBUG,
				"[Stream#%d] : %p,  stream video is not started yet",
				pstream->stream_id, pstream);
		}
	}
#endif
}

static void armcb_isp_irq_sof_i7(unsigned int ctx_id)
{
	int rc = 0;
	int i = 0;
	armcb_v4l2_stream_t *pstream = NULL;
	armcb_v4l2_dev_t *pdev = NULL;

	pdev = armcb_v4l2_core_get_dev(ctx_id);
	if (pdev && atomic_read(&pdev->opened) == 0)
		ctx_id = armcb_v4l2_core_find_1st_opened_dev();

	LOG(LOG_DEBUG, "sof ctx_id=%u", ctx_id);
	for (i = 0; i < V4L2_STREAM_TYPE_MAX; i++) {
		/* find stream pointer */
		rc = armcb_v4l2_find_stream(&pstream, ctx_id, i);
		if (rc < 0) {
			LOG(LOG_DEBUG,
				"can't find stream on ctx %d (errno = %d)", ctx_id,
				rc);
			continue;
		}

		LOG(LOG_DEBUG, "sol cxt_id:%d, stream_id:%d", pstream->ctx_id,
			pstream->stream_id);
		/* check if stream is on */
		if (!pstream->stream_started) {
			LOG(LOG_DEBUG,
				"[Stream#%d] stream video is not started yet on ctx %d",
				pstream->stream_id, ctx_id);
			continue;
		}

		if (armcb_v4l2_config_update_stream_vin_addr(pstream)) {
			LOG(LOG_DEBUG,
				"[Stream#%d] failed to update stream vin addr for cxt_id:%d",
				pstream->stream_id, ctx_id);
		}
	}
}

static void
armcb_v4l2_config_queue_event_with_status(struct video_device *pvdev,
					  struct isp_irq_info *pirq_info,
					  unsigned int status)
{
	unsigned int *pData = NULL;
	struct v4l2_event ev = {
		.id = pirq_info->int_type,
		.type = V4L2_EVENT_CTRL,
	};

	if (!pvdev || !pirq_info) {
		LOG(LOG_ERR, "invalid dev is null or pisp_ir is null!");
		return;
	}

	pData = (unsigned int *)&ev.u;
	if (pirq_info->int_type == ISP_NORMAL_INT) {
		pData[0] = pirq_info->changed;
		pData[1] = status;
		pData[2] = pirq_info->id;
		pData[3] = pirq_info->sen_id;
		pData[4] = pirq_info->frm_cnt_sof;
		pData[5] = pirq_info->frm_cnt_sol;
		pData[6] = pirq_info->frm_cnt_3a;
		pData[7] = pirq_info->frm_cnt_nxt_sol;
		pData[8] = 0;
		pData[9] = 0;
		pData[10] = 0;
		pData[11] = 0;
		pData[12] = 0;
	} else if (pirq_info->int_type == ISP_MIXTURE_INT) {
		pData[0] = pirq_info->changed;
		pData[1] = status;
		pData[2] = pirq_info->id;
		pData[3] = pirq_info->sen_id;
		pData[4] = pirq_info->frm_cnt_sof;
		pData[5] = pirq_info->frm_cnt_sol;
		pData[6] = pirq_info->frm_cnt_3a;
		pData[7] = pirq_info->frm_cnt_nxt_sol;
		pData[8] = pirq_info->err_detail_status[0];
		pData[9] = 0;
		pData[10] = 0;
		pData[11] = 0;
		pData[12] = 0;
	} else if (pirq_info->int_type == ISP_ERROR_INT) {
		pData[0] = pirq_info->changed;
		pData[1] = status;
		pData[2] = pirq_info->id;
		pData[3] = pirq_info->sen_id;
		pData[4] = pirq_info->frm_cnt_sof;
		pData[5] = pirq_info->frm_cnt_sol;
		pData[6] = pirq_info->frm_cnt_3a;
		pData[7] = pirq_info->frm_cnt_nxt_sol;
		pData[8] = pirq_info->err_detail_status[0];
		pData[9] = pirq_info->err_detail_status[1];
		pData[10] = pirq_info->err_detail_status[2];
		pData[11] = pirq_info->err_detail_status[3];
		pData[12] = pirq_info->err_detail_status[4];
	} else {
		pData[0] = 0;
		pData[1] = 0;
		pData[2] = 0;
		pData[3] = 0;
		pData[4] = 0;
		pData[5] = 0;
		pData[6] = 0;
		pData[7] = 0;
		pData[8] = 0;
		pData[9] = 0;
		pData[10] = 0;
		pData[11] = 0;
		pData[12] = 0;
	}

	if (pData[5] % 30 == 0) {
		LOG(LOG_DEBUG,
			"isp_queue event id(%d) type(%d) mask=0x%x, "
			"status=0x%x, id = 0x%x, sen_id = 0x%x, frm_cnt_sof = %u, frm_cnt_sol " \
			"= %u",
			ev.id, ev.type, pData[0], pData[1], pData[2], pData[3],
			pData[4], pData[5]);
	}

	v4l2_event_queue(pvdev, &ev);
}

static void armcb_v4l2_config_queue_event(struct video_device *pvdev,
					  struct isp_irq_info *pirq_info)
{
	unsigned int *pData = NULL;
	struct v4l2_event ev = {
		.id = pirq_info->int_type,
		.type = V4L2_EVENT_CTRL,
	};

	if (!pvdev || !pirq_info) {
		LOG(LOG_ERR, "invalid dev is null or pisp_ir is null!");
		return;
	}

	pData = (unsigned int *)&ev.u;
	if (pirq_info->int_type == ISP_NORMAL_INT) {
		pData[0] = pirq_info->changed;
		pData[1] = pirq_info->status;
		pData[2] = pirq_info->id;
		pData[3] = pirq_info->sen_id;
		pData[4] = pirq_info->frm_cnt_sof;
		pData[5] = pirq_info->frm_cnt_sol;
		pData[6] = pirq_info->frm_cnt_3a;
		pData[7] = pirq_info->frm_cnt_nxt_sol;
		pData[8] = 0;
		pData[9] = 0;
		pData[10] = 0;
		pData[11] = 0;
		pData[12] = 0;
	} else if (pirq_info->int_type == ISP_MIXTURE_INT) {
		pData[0] = pirq_info->changed;
		pData[1] = pirq_info->status;
		pData[2] = pirq_info->id;
		pData[3] = pirq_info->sen_id;
		pData[4] = pirq_info->frm_cnt_sof;
		pData[5] = pirq_info->frm_cnt_sol;
		pData[6] = pirq_info->frm_cnt_3a;
		pData[7] = pirq_info->frm_cnt_nxt_sol;
		pData[8] = pirq_info->err_detail_status[0];
		pData[9] = 0;
		pData[10] = 0;
		pData[11] = 0;
		pData[12] = 0;
	} else if (pirq_info->int_type == ISP_ERROR_INT) {
		pData[0] = pirq_info->changed;
		pData[1] = pirq_info->status;
		pData[2] = pirq_info->id;
		pData[3] = pirq_info->sen_id;
		pData[4] = pirq_info->frm_cnt_sof;
		pData[5] = pirq_info->frm_cnt_sol;
		pData[6] = pirq_info->frm_cnt_3a;
		pData[7] = pirq_info->frm_cnt_nxt_sol;
		pData[8] = pirq_info->err_detail_status[0];
		pData[9] = pirq_info->err_detail_status[1];
		pData[10] = pirq_info->err_detail_status[2];
		pData[11] = pirq_info->err_detail_status[3];
		pData[12] = pirq_info->err_detail_status[4];
	} else {
		pData[0] = 0;
		pData[1] = 0;
		pData[2] = 0;
		pData[3] = 0;
		pData[4] = 0;
		pData[5] = 0;
		pData[6] = 0;
		pData[7] = 0;
		pData[8] = 0;
		pData[9] = 0;
		pData[10] = 0;
		pData[11] = 0;
		pData[12] = 0;
	}

	if (pData[5] % 30 == 0) {
		LOG(LOG_DEBUG,
			"isp_queue event id(%d) type(%d) mask=0x%x, "
			"status=0x%x, id = 0x%x, sen_id = 0x%x, frm_cnt_sof = %u, frm_cnt_sol " \
			"= %u",
			ev.id, ev.type, pData[0], pData[1], pData[2], pData[3],
			pData[4], pData[5]);
	}

	v4l2_event_queue(pvdev, &ev);
}

/**
 * @description: record interrupt mask and mask interrupt
 * @param {u32} *mask: pointer to interrupt mask
 * @return {*}
 */
static inline void armcb_i5_mask_int(u32 *mask)
{
	*mask = armcb_isp_read_reg(I5_INT_MASK_ADDR);
	armcb_isp_write_reg(I5_INT_MASK_ADDR, 0xFFFFFFFF);
}

/**
 * @description: set register mask register to original value
 * @param {u32} mask: original interrupt mask
 * @return {*}
 */
static inline void armcb_i5_unmask_int(u32 mask)
{
	armcb_isp_write_reg(I5_INT_MASK_ADDR, mask);
}

/**
 * @description: i5 clear interupt
 * @param {u32} status: current interrupt status
 * @return {*}
 */
static inline void armcb_i5_clear_int(u32 status)
{
	/* i5 read clear*/
	armcb_isp_write_reg(I5_INT_CLEAR_ADDR, status | I5_INT_VOUTX_INT_MASK);
	armcb_isp_read_reg(I5_INT_STATUS_ADDR);
	armcb_isp_write_reg(I5_INT_CLEAR_ADDR, 0x0);
}

/**
 * @description: process afbc error interrupt
 * @param {isp_irq_info} *pirq_info: pointer to irq information
 * @return {*}
 */
static inline void armcb_i5_afbc_err_process(struct isp_irq_info *pirq_info)
{
	unsigned int afbc_clean = 0;

	if (pirq_info->status & I5_INT_AFBC_MASK) {
		pirq_info->err_detail_status[0] =
			armcb_isp_read_reg(I5_INT_AFBC_STATUS_ADDR);
		if (pirq_info->err_detail_status[0] &
			I5_INT_AFBC_DETAIL_ERR_MASK) {
			afbc_clean = armcb_isp_read_reg(I5_INT_AFBC_CLEAR_ADDR);
			armcb_isp_write_reg(
				I5_INT_AFBC_CLEAR_ADDR,
				afbc_clean | (I5_INT_AFBC_MASK &
						  pirq_info->err_detail_status[0]));
		}
	}
}

static irqreturn_t armcb_I5_isp_isr(s32 irq, void *pdev)
{
	irqreturn_t ret = IRQ_NONE;
	uint32_t outport = 0;
	uint32_t ctx_id = 0;
	uint32_t stream_id = 0;
	struct video_device *pvdev = NULL;
	armcb_v4l2_config_dev_t *p_config_dev = (armcb_v4l2_config_dev_t *)pdev;
	struct isp_irq_info irq_info = { 0 };
	struct isp_irq_info irq_info_vout = { 0 };
	unsigned long flags;
	i5_index_t int_id = { 0 };

	pvdev = &p_config_dev->vid_cap_dev;
	irq_info.status = armcb_isp_read_reg(I5_INT_STATUS_ADDR);
	if (irq_info.status) {
		spin_lock_irqsave(&p_config_dev->slock, flags);

		/*1. record interrupt mask and mask interrupt*/
		armcb_i5_mask_int(&irq_info.mask);
		irq_info.changed = 1;
		irq_info.int_type = ISP_MIXTURE_INT;
		irq_info.frm_cnt_sol = armcb_isp_read_reg(I5_INT_FRMCNT_ADDR);

		/*2. Read irq status*/
		irq_info.id = armcb_isp_read_reg(I5_INT_ID_ADDR);
		int_id.val = irq_info.id;

		LOG(LOG_DEBUG, "irq: frm_cnt=%u,  status=0x%x",
			irq_info.frm_cnt_sol, irq_info.status);

		if (irq_info.status & I5_INT_VSYNC_INT_MASK) {
			irq_info.status |= I5_INT_SW_SOL_MASK;
			armcb_isp_irq_sol_i5(int_id.frame_index);
		}

		/* Check AFBC error interrupt */
		armcb_i5_afbc_err_process(&irq_info);

		if (irq_info.status & I5_INT_VOUTX_INT_MASK) {
			LOG(LOG_DEBUG,
				"irq status=0x%x sensor id:%d frm_cnt:%d",
				irq_info.status, int_id.sensor_id,
				irq_info.frm_cnt_sof);
			if (irq_info.status & I5_INT_VOUT0_DONE) {
				outport = (1 << ISP_OUTPUT_PORT_VOUT0);
				if (!armcb_v4l2_find_ctx_stream_by_outport(
						outport, &ctx_id, &stream_id)) {
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT0);
				}
				irq_info_vout = irq_info;
				irq_info_vout.status = I5_INT_VOUT0_DONE;
				armcb_v4l2_config_queue_event(pvdev,
								  &irq_info_vout);

				irq_info.status &= ~I5_INT_VOUT0_DONE;
			}
			if (irq_info.status & I5_INT_VOUT1_DONE) {
				outport = (1 << ISP_OUTPUT_PORT_VOUT1);
				if (!armcb_v4l2_find_ctx_stream_by_outport(
						outport, &ctx_id, &stream_id)) {
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT1);
				}
				irq_info_vout = irq_info;
				irq_info_vout.status = I5_INT_VOUT1_DONE;
				armcb_v4l2_config_queue_event(pvdev,
								  &irq_info_vout);

				irq_info.status &= ~I5_INT_VOUT1_DONE;
			}
			if (irq_info.status & I5_INT_VOUT2_DONE) {
				outport = (1 << ISP_OUTPUT_PORT_VOUT2);
				if (!armcb_v4l2_find_ctx_stream_by_outport(
						outport, &ctx_id, &stream_id)) {
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT2);
				}
				irq_info_vout = irq_info;
				irq_info_vout.status = I5_INT_VOUT2_DONE;
				armcb_v4l2_config_queue_event(pvdev,
								  &irq_info_vout);

				irq_info.status &= ~I5_INT_VOUT2_DONE;
			}
			if (irq_info.status & I5_INT_VOUT3_DONE) {
				outport = (1 << ISP_OUTPUT_PORT_VOUT3);
				if (!armcb_v4l2_find_ctx_stream_by_outport(
						outport, &ctx_id, &stream_id)) {
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT3);
				}
				irq_info_vout = irq_info;
				irq_info_vout.status = I5_INT_VOUT3_DONE;
				armcb_v4l2_config_queue_event(pvdev,
								  &irq_info_vout);

				irq_info.status &= ~I5_INT_VOUT3_DONE;
			}
		}

		/*3. post irq event to userspace */
		if (irq_info.status & I5_IRQ_EVENT_POST_MASK)
			armcb_v4l2_config_queue_event(pvdev, &irq_info);

		/*4. read clear*/
		armcb_i5_clear_int(irq_info.status);

		/*5. Restore interrupt mask bit*/
		armcb_i5_unmask_int(irq_info.mask);
		spin_unlock_irqrestore(&p_config_dev->slock, flags);
		ret = IRQ_HANDLED;
	}

	return ret;
}

static struct isp_irq_info *armcb_irq_msg_ev_alloc(struct armcb_irq_msg_fh *fh)
{
	struct isp_irq_info *info = NULL;
	struct armcb_irq_event *ev = NULL;
	unsigned long flags;

	spin_lock_irqsave(&fh->fh_lock, flags);
	if (fh->in_use == fh->elems) {
		fh->in_use--;
		fh->first = irqev_pos(fh, 1);
	} else {
		ev = fh->ev_array + fh->in_use;
		info = &ev->info;
		fh->in_use++;
		memset(info, 0, sizeof(struct isp_irq_info));
		list_add_tail(&ev->fh_node, &fh->avaliable);
	}
	spin_unlock_irqrestore(&fh->fh_lock, flags);
	return info;
}

/**
 * @description: record interrupt mask and mask interrupt
 * @param {u32} *pnormal_mask: pointer to normal mask
 * @param {u32} *perror_mask: pointer to error mask
 * @return {*}
 */
static inline void armcb_i7_mask_int(u32 *pnormal_mask, u32 *perror_mask)
{
	*pnormal_mask = armcb_isp_read_reg(I7_INT_MASK_ADDR);
	*perror_mask = armcb_isp_read_reg(I7_INT_ERR_MASK_ADDR);
	armcb_isp_write_reg(I7_INT_MASK_ADDR, 0xFFFFFFFF);
	armcb_isp_write_reg(I7_INT_ERR_MASK_ADDR, 0xFFFFFFFF);
}

/**
 * @description: set register mask register to original value
 * @param {u32} normal_mask: original normal mask
 * @param {u32} error_mask: original error mask
 * @return {*}
 */
static inline void armcb_i7_unmask_int(u32 normal_mask, u32 error_mask)
{
	armcb_isp_write_reg(I7_INT_MASK_ADDR, normal_mask);
	armcb_isp_write_reg(I7_INT_ERR_MASK_ADDR, error_mask);
}

/**
 * @description: clear normal interrupt
 * @param {u32} status: current normal interrupt status
 * @return {*}
 */
static inline void armcb_i7_clear_normal_int(u32 status)
{
	/*i7 write clear*/
	armcb_isp_write_reg(I7_INT_CLEAR_ADDR,
				status | I7_INT_VIN_EXPX_INT_MASK);
}

/**
 * @description: clear error interrupt
 * @param {u32} status: current error interrupt status
 * @return {*}
 */
static inline void armcb_i7_clear_error_int(u32 status)
{
	/*i7 write clear*/
	armcb_isp_write_reg(I7_INT_ERR_CLEAR_ADDR, status);
}

/**
 * @description: get sof frame count and update id and frame_cnt_sel
 * @param {isp_irq_info} *pirq_info: pointer to irq information
 * @param {i7_index_type_t} *pint_id: pointer to id of interrupt
 * @param {i7_frm_cnt_ctrl_t} *pframe_cnt_sel: pointer to frame count controller
 * @return {*}
 */
static inline void armcb_i7_get_sof_frm_cnt(struct isp_irq_info *pirq_info,
						i7_index_type_t *pint_id,
						i7_frm_cnt_ctrl_t *pframe_cnt_sel)
{
	i7_sof_type_ctrl_t sensor_sel = { 0 };
	i7_vin_in_sof_channel_t sen_id_sof = { 0 };
	i7_vin_vin_reg_c8_t sof_frame_cnt_sel = { 0 };
	/*context index occupies 2 bits*/
	uint32_t cxt_offset = 2;

	/*I7_INT_SENSOR_SEL_ADDR control which type sof could be used*/
	sensor_sel.val = armcb_isp_read_reg(I7_INT_SENSOR_SEL_ADDR);

	/* VIN_IN_SOF: SOF is generated by vin input end, sensor output, isp
	 * cannot control
	 */
	if (sensor_sel.r_vin_sof_sel == 0) {
		/*I7_INT_SOF_ID_ADDR contains vin input channel index*/
		pirq_info->sen_id = armcb_isp_read_reg(I7_INT_SOF_ID_ADDR);
		sen_id_sof.val = pirq_info->sen_id;
		/*I7_INT_SOF_FRMCNT_SEL_ADDR, namely vin_c8, control which
		 * channel of frame count could be accessed
		 */
		sof_frame_cnt_sel.val =
			armcb_isp_read_reg(I7_INT_SOF_FRMCNT_SEL_ADDR);
		/*only change channel index control part of frame_cnt_sel*/
		sof_frame_cnt_sel.r_vin_daw_frm_cnt_chm_sel =
			sen_id_sof.r_vin_in_ch_idx;

		/* after set frame_cnt_sel to select index, can get frame count
		 * of selected channel, as frame counter register only one
		 */
		armcb_isp_write_reg(I7_INT_SOF_FRMCNT_SEL_ADDR,
					sof_frame_cnt_sel.val);
		/* read vin_e4 frame counter from 4 channels in DAW, only use in
		 * VIN_IN SOF
		 */
		pirq_info->frm_cnt_sof =
			armcb_isp_read_reg(I7_INT_SOF_FRMCNT_ADDR);
	}
	/*VIN_OUT_SOF: SOF is generated by vin output end, isp can control*/
	else {
		/*read frame count index register*/
		pirq_info->id = armcb_isp_read_reg(I7_INT_ID_ADDR);
		pint_id->val = pirq_info->id;
		/*generate sen_id, bits[3:2]:vin_context_index,
		 * bits[1:0]:vin_frame_index
		 */
		pirq_info->sen_id = (pint_id->cxt_idx << cxt_offset) |
					(pint_id->frm_idx);

		/*I7_INT_FRMCNT_SEL_ADDR control which context index of ISP
		 * frame count could be accessed
		 */
		pframe_cnt_sel->val =
			armcb_isp_read_reg(I7_INT_FRMCNT_SEL_ADDR);
		/* generate new frame counter configuration, only change index
		 * control part of frame_cnt_sel
		 */
		pframe_cnt_sel->r_3a_cnt_sel_frm_idx = pint_id->aaa_frm_idx;
		pframe_cnt_sel->r_3a_cnt_sel_cxt_idx = pint_id->aaa_cxt_idx;
		pframe_cnt_sel->r_isp_cnt_sel_frm_idx = pint_id->frm_idx;
		pframe_cnt_sel->r_isp_cnt_sel_cxt_idx = pint_id->cxt_idx;

		/* after set frame_cnt_sel to select index, can get frame count
		 * of selected channel, as frame counter register only one
		 */
		armcb_isp_write_reg(I7_INT_FRMCNT_SEL_ADDR,
					pframe_cnt_sel->val);
		/* get sol framecount, sof and sol framecount is same in
		 * VIN_OUT_SOF case
		 */
		pirq_info->frm_cnt_sof =
			armcb_isp_read_reg(I7_INT_SOL_FRMCNT_ADDR);
	}
}

/**
 * @description: get sol and 3a frame count
 * @param {isp_irq_info} *pirq_info: pointer to irq information
 * @param {i7_index_type_t} *pint_id: pointer to id of interrupt
 * @param {i7_frm_cnt_ctrl_t} *pframe_cnt_sel: pointer to frame count controller
 * @return {*}
 */
static inline void
armcb_i7_get_sol_3a_frm_cnt(struct isp_irq_info *pirq_info,
				i7_index_type_t *pint_id,
				i7_frm_cnt_ctrl_t *pframe_cnt_sel)
{
	pirq_info->id = armcb_isp_read_reg(I7_INT_ID_ADDR);
	pint_id->val = pirq_info->id;
	pframe_cnt_sel->val = armcb_isp_read_reg(I7_INT_FRMCNT_SEL_ADDR);
	pframe_cnt_sel->r_3a_cnt_sel_frm_idx = pint_id->aaa_frm_idx;
	pframe_cnt_sel->r_3a_cnt_sel_cxt_idx = pint_id->aaa_cxt_idx;
	pframe_cnt_sel->r_isp_cnt_sel_frm_idx = pint_id->frm_idx;
	pframe_cnt_sel->r_isp_cnt_sel_cxt_idx = pint_id->cxt_idx;

	/* after set frame_cnt_sel to select index, can get frame count of
	 * selected channel, as frame counter register only one
	 */
	armcb_isp_write_reg(I7_INT_FRMCNT_SEL_ADDR, pframe_cnt_sel->val);

	/* read sol and 3a frame count, in vin_out_sof case, frame count of sof
	 * and sol is same ,so they use same frame count register
	 */
	pirq_info->frm_cnt_sol = armcb_isp_read_reg(I7_INT_SOL_FRMCNT_ADDR);
	pirq_info->frm_cnt_3a = armcb_isp_read_reg(I7_INT_3A_FRMCNT_ADDR);
}

/**
 * @description: get next sol frame count in multi-cam cases
 * @param {isp_irq_info} *pirq_info: pointer to irq information
 * @param {i7_index_type_t} *pint_id: pointer to id of interrupt
 * @param {i7_frm_cnt_ctrl_t} *pframe_cnt_sel: pointer to frame count controller
 * @return {*}
 */
static inline void
armcb_i7_get_nxt_sol_frm_cnt(struct isp_irq_info *pirq_info,
				 i7_index_type_t *pint_id,
				 i7_frm_cnt_ctrl_t *pframe_cnt_sel)
{
	pframe_cnt_sel->r_isp_cnt_sel_cxt_idx = pint_id->cxt_nxt_idx;
	pframe_cnt_sel->r_isp_cnt_sel_frm_idx = pint_id->frm_nxt_idx;
	/*after set frame_cnt_sel to select index, can get frame count of
	 * selected channel, as frame counter register only one
	 */
	armcb_isp_write_reg(I7_INT_FRMCNT_SEL_ADDR, pframe_cnt_sel->val);

	pirq_info->frm_cnt_nxt_sol = armcb_isp_read_reg(I7_INT_SOL_FRMCNT_ADDR);
}

/**
 * @description: process afbc error interrupt
 * @param {isp_irq_info} *pirq_info: pointer to irq information
 * @return {*}
 */
static inline void armcb_i7_afbc_err_process(struct isp_irq_info *pirq_info)
{
	unsigned int afbc_status = 0;
	unsigned int afbc_clr = 0;

	if (pirq_info->status & I7_INT_AFBC_ERR_MASK) {
		afbc_status = armcb_isp_read_reg(I7_INT_AFBC_STATUS_ADDR);
		pirq_info->err_detail_status[4] = afbc_status;
		if (afbc_status & I7_INT_AFBC_DETAIL_ERR_MASK) {
			afbc_clr = armcb_isp_read_reg(I7_INT_AFBC_CLEAR_ADDR);
			armcb_isp_write_reg(
				I7_INT_AFBC_CLEAR_ADDR,
				afbc_clr | (I7_INT_AFBC_DETAIL_ERR_MASK &
						afbc_status));
		}
	}
}

static irqreturn_t armcb_I7_isp_isr(s32 irq, void *pdev)
{
	irqreturn_t ret = IRQ_NONE;
	uint32_t next_ctx_id = 0;
#ifdef ENABLE_RUNTIME_UPDATE_STATS_ADDR
	uint32_t outport = 0;
	uint32_t ctx_id = 0;
	uint32_t stream_id = 0;
	uint32_t ctx_count = 0;
	struct isp_irq_info irq_info_vout = { 0 };
#endif
	struct video_device *pvdev = NULL;
	armcb_v4l2_config_dev_t *p_config_dev = (armcb_v4l2_config_dev_t *)pdev;
	struct isp_irq_info irq_info = { 0 };
	i7_frm_cnt_ctrl_t frame_cnt_sel = { 0 };
	unsigned long flags = 0;
	unsigned int irq_clear = 0;
	struct isp_irq_info *bh_info = NULL;
	i7_index_type_t int_id = { 0 };
	/*context index occupies 2 bits*/
	uint32_t cxt_offset = 2;
	/*frame count index occupies 2 bits*/
	uint32_t frm_cnt_idx_mask = 0x3;
	unsigned int reg_val = 0;
	streamOnFlag = 1;

	pvdev = &p_config_dev->vid_cap_dev;
	irq_info.status = armcb_isp_read_reg(I7_INT_STATUS_ADDR);

	if (irq_info.status) {
		spin_lock_irqsave(&p_config_dev->slock, flags);
		/*1. record interrupt mask and mask interrupt*/
		armcb_i7_mask_int(&irq_info.mask, &irq_info.err_mask);
		irq_info.changed = 1;
		irq_info.int_type = ISP_NORMAL_INT;

		/*2. Read irq status*/
		irq_clear = irq_info.status;

		/*2.1 get sof frame count, sof: vin output first valid data*/
		if (irq_info.status & I7_INT_SOF_INT_MASK) {
			armcb_i7_get_sof_frm_cnt(&irq_info, &int_id,
						 &frame_cnt_sel);
		}

		/*2.2 get sol and 3a frame count, sol: last pipe output VSYNC rising
		 * pulse.
		 */
		if (irq_info.status & (~I7_INT_SOF_INT_MASK)) {
			armcb_i7_get_sol_3a_frm_cnt(&irq_info, &int_id,
							&frame_cnt_sel);
		}

		/*2.3 get next sol frame count for prepare next register
		 * configuration, only in multiple cameras cases, multi-cam
		 * index changes alternately
		 */
		if ((irq_info.status & I7_INT_SOL_MASK ||
			 irq_info.status & I7_INT_MCFB_LOAD_DONE ||
			 irq_info.status & I7_INT_LINE_TRIG_MASK) &&
			((int_id.frm_idx != int_id.frm_nxt_idx) ||
			 (int_id.cxt_idx != int_id.cxt_nxt_idx))) {
			armcb_i7_get_nxt_sol_frm_cnt(&irq_info, &int_id,
							 &frame_cnt_sel);
		}

		/*handle afbc error interrupt*/
		armcb_i7_afbc_err_process(&irq_info);

		LOG(LOG_DEBUG,
			"status=0x%x, id=0x%x, sel=0x%x, sof=%d, sol=%d-%d, 3a=%d",
			irq_info.status, irq_info.id, frame_cnt_sel.val,
			irq_info.frm_cnt_sof, irq_info.frm_cnt_sol,
			irq_info.frm_cnt_nxt_sol, irq_info.frm_cnt_3a);

		/*2.4 set vout buffer address*/
		if (irq_info.status & I7_INT_SOL_MASK) {
			next_ctx_id = ((int_id.cxt_nxt_idx << cxt_offset) |
					   (int_id.frm_nxt_idx & frm_cnt_idx_mask));
			armcb_isp_irq_sol_i7(next_ctx_id);
		}

		/*2.5 set vin buffer address*/
		if (irq_info.status & I7_INT_SOF_INT_MASK) {
			next_ctx_id = ((int_id.cxt_nxt_idx << cxt_offset) |
					   (int_id.frm_nxt_idx & frm_cnt_idx_mask));
			armcb_isp_irq_sof_i7(next_ctx_id);
		}

		if (irq_info.status & I7_INT_VIN_EXPX_INT_MASK) {
			LOG(LOG_DEBUG,
				"status=0x%x, id=0x%x, sel=0x%x, sof=%d," \
				"sol=%d-%d, 3a=%d I7_INT_VIN_EXPX_INT_MASK(0x%x)",
				irq_info.status, irq_info.id, frame_cnt_sel.val,
				irq_info.frm_cnt_sof, irq_info.frm_cnt_sol,
				irq_info.frm_cnt_nxt_sol, irq_info.frm_cnt_3a,
				I7_INT_VIN_EXPX_INT_MASK);
		}

		/*3. clear the interrupt bits*/
		if (irq_info.status & I7_INT_VIN_CHNL_L_BUF_DONE) {
			reg_val = armcb_isp_read_reg(DAW0_IFBC_IDMA_REG_1C);
			reg_val &=
				0xfffeffff; /*r_dump_en = 0 disable daw0 write*/
			armcb_isp_write_reg(DAW0_IFBC_IDMA_REG_1C, reg_val);
		}
		armcb_i7_clear_normal_int(irq_clear);

		/*4. post irq event to userspace */
		if (irq_info.status & I7_IRQ_EVENT_POST_MASK) {
#ifndef CIX_V4L2_ADAPTER
			bh_info = armcb_irq_msg_ev_alloc(
				&p_v4l_config_dev->isr_fh);
			memcpy(bh_info, &irq_info, sizeof(struct isp_irq_info));
			tasklet_schedule(&p_v4l_config_dev->buffer_done_task);
#else
			bh_info = armcb_irq_msg_ev_alloc(&p_config_dev->isr_fh);
			memcpy(bh_info, &irq_info, sizeof(struct isp_irq_info));
			tasklet_schedule(&p_config_dev->buffer_done_task);
#endif
		}

		/*5. restore interrupt mask bit */
		armcb_i7_unmask_int(irq_info.mask, irq_info.err_mask);
		spin_unlock_irqrestore(&p_config_dev->slock, flags);
		ret = IRQ_HANDLED;
	}

	return ret;
}

static irqreturn_t armcb_I7_isp_err_isr(s32 irq, void *pdev)
{
	irqreturn_t ret = IRQ_NONE;
	armcb_v4l2_config_dev_t *p_config_dev = (armcb_v4l2_config_dev_t *)pdev;
	struct video_device *pvdev = NULL;
	struct isp_irq_info irq_info = { 0 };
	i7_frm_cnt_ctrl_t frame_cnt_sel = { 0 };
	i7_index_type_t int_id = { 0 };
	unsigned long flags = 0;
	unsigned int irq_clear = 0;
#if 0
#ifdef CONFIG_PLAT_BBOX
	static const char start_flag_str[] = "ispDumpStart";
	int start_flag_len = sizeof(start_flag_str) - 1;
	int start_flag_num = (start_flag_len % 4 ? 1 : 0) + start_flag_len / 4;
	int total_reg_num = ERR_DETAIL_NUM + ISP_TOP_NUM + ISP_VIN_NUM +
				ISP_IFBC_NUM * 2 + ISP_PSC_NUM + ISP_SCA_NUM +
				start_flag_num;
	u64 err_save_base_addr[ISP_SAVE_MAX] = {
		I7_TOP_BASE_ADDR,  I7_VIN_BASE_ADDR, I7_IFBC_BASE_ADDR,
		I7_IFBD_BASE_ADDR, I7_PSC_BASE_ADDR, I7_SCA_BASE_ADDR
	};
	u64 write_shift = g_isp_addr + rdr_writen_num * 4;
	err_save_module err_save_len[ISP_SAVE_MAX] = {
		ISP_TOP_NUM,  ISP_VIN_NUM, ISP_IFBC_NUM,
		ISP_IFBC_NUM, ISP_PSC_NUM, ISP_SCA_NUM
	};
	u32 val;
	int i, j;
#endif
#endif

	pvdev = &p_config_dev->vid_cap_dev;

	irq_info.status = armcb_isp_read_reg(I7_INT_ERR_STATUS_ADDR);

	if (irq_info.status) {
		spin_lock_irqsave(&p_config_dev->slock, flags);
		/*1. record interrupt mask and mask interrupt*/
		armcb_i7_mask_int(&irq_info.mask, &irq_info.err_mask);
		irq_info.changed = 1;
		irq_info.int_type = ISP_ERROR_INT;

		/*2. Read irq status*/
		irq_clear = irq_info.status;

		/*read detail error interrupt registers*/
		irq_info.err_detail_status[0] =
			armcb_isp_read_reg(I7_INT_DETAIL_ERR_ADDR1);
		irq_info.err_detail_status[1] =
			armcb_isp_read_reg(I7_INT_DETAIL_ERR_ADDR2);
		irq_info.err_detail_status[2] =
			armcb_isp_read_reg(I7_INT_DETAIL_ERR_ADDR3);
		irq_info.err_detail_status[3] =
			armcb_isp_read_reg(I7_INT_DETAIL_ERR_ADDR4);
		LOG(LOG_ERR, "status=0x%x, dtail= {0x%x, 0x%x, 0x%x, 0x%x}",
			irq_info.status, irq_info.err_detail_status[0],
			irq_info.err_detail_status[1],
			irq_info.err_detail_status[2],
			irq_info.err_detail_status[3]);
		/*read camId and frmCnt*/
		if (irq_info.status & I7_INT_SOF_INT_MASK) {
			armcb_i7_get_sof_frm_cnt(&irq_info, &int_id,
						 &frame_cnt_sel);
		}

		/*handle afbc error interrupt*/
		armcb_i7_afbc_err_process(&irq_info);

		/*3. clear the interrupt bits*/
		armcb_i7_clear_error_int(irq_clear);

		/*4. post irq event to userspace */
		if (irq_info.status) {
			armcb_v4l2_config_queue_event(pvdev, &irq_info);

#if 0
#ifdef CONFIG_PLAT_BBOX
		/* asynchronous API */
		/* error information
		 * ERR/TOP/VIN/IFBC/IFBD/PSC/SCA status
		 * Length measured in words (32bit)
		 */
			if ((rdr_writen_num + total_reg_num) * 4 <
				g_current_info.log_len) {
				memcpy((void *)write_shift, start_flag_str,
					   start_flag_len);
				write_shift += start_flag_num * 4;
				rdr_writen_num += start_flag_num;

				writel(irq_info.status,
					   (void __iomem *)write_shift);
				writel(irq_info.err_detail_status[0],
					   (void __iomem *)(write_shift +
								 0x4));
				writel(irq_info.err_detail_status[1],
					   (void __iomem *)(write_shift +
								 0x8));
				writel(irq_info.err_detail_status[2],
					   (void __iomem *)(write_shift +
								 0xc));
				writel(irq_info.err_detail_status[3],
					   (void __iomem *)(write_shift +
								 0x10));
				write_shift += ERR_DETAIL_NUM * 4;

				for (i = 0; i < ISP_SAVE_MAX; i++) {
					for (j = 0; j < err_save_len[i]; j++) {
						val = armcb_isp_read_reg(
							err_save_base_addr[i] +
							4 * j);
						writel(val,
							   (void __iomem
								*)(write_shift +
								   4 * j));
					}
					write_shift += err_save_len[i] * 4;
				}
				rdr_writen_num += total_reg_num;
			}
			rdr_system_error(RDR_ISP_SOC_ISR_ERR_MODID, 0, 0);
#endif
#endif
		}
		/*5. restore interrupt mask bit */
		armcb_i7_unmask_int(irq_info.mask, irq_info.err_mask);
		spin_unlock_irqrestore(&p_config_dev->slock, flags);
		ret = IRQ_HANDLED;
	}

	return ret;
}

struct armcb_isp_info i5_isp_hw_info = {
	.type = ISP_TYPE_I5,
	.isp_isr = armcb_I5_isp_isr,
	.isp_err_isr = NULL,
};

struct armcb_isp_info i5_cus0_isp_hw_info = {
	.type = ISP_TYPE_I5_CUS0,
	.isp_isr = armcb_I5_isp_isr,
	.isp_err_isr = NULL,
};

struct armcb_isp_info i7_isp_hw_info = {
	.type = ISP_TYPE_I7,
	.isp_isr = armcb_I7_isp_isr,
	.isp_err_isr = armcb_I7_isp_err_isr,
};

#ifdef QEMU_ON_VEXPRESS
static int armcb_isp_interrupt_task(void *data)
{
	int res = 0;
	uint32_t outport = 0;
	uint32_t ctx_id = 0;
	uint32_t stream_id = 0;
	armcb_v4l2_config_dev_t *p_config_dev = (armcb_v4l2_config_dev_t *)data;
	struct video_device *pvdev = NULL;
	struct isp_irq_info irq_info = { 0 };
	struct isp_irq_info irq_info_vout = { 0 };

	static int sof_count;
	static int sol_count;
	static int stats_count;

	while (1) {
#ifndef CIX_V4L2_ADAPTER
		if (atomic_read(&p_v4l_config_dev->opened)) {
#else
		if (atomic_read(&p_config_dev->opened)) {
#endif
			irq_info.status = 0x83001000; // only preview
			// irq_info.status = 0x83005000; //+vout
			// irq_info.status = 0x83015000; //+vout+vout1
		} else {
			irq_info.status = 0x0;
		}

		ctx_id = 0;

		if (irq_info.status) {
			pvdev = &p_config_dev->vid_cap_dev;
			/*1. record interrupt mask*/
			irq_info.changed = 1;
			irq_info.int_type = ISP_NORMAL_INT;

			if (irq_info.status & I7_INT_SOF_INT_MASK)
				irq_info.frm_cnt_sof = sof_count++;

			if (irq_info.status & (~I7_INT_SOF_INT_MASK)) {
				irq_info.frm_cnt_sol = sol_count++;
				irq_info.frm_cnt_3a = stats_count++;
			}

			if (irq_info.status & I7_INT_SOL_MASK)
				irq_info.frm_cnt_nxt_sol = sol_count;

			LOG(LOG_DEBUG,
				"status=0x%x, id=0x%x, sof=%d, sol=%d-%d, 3a=%d",
				irq_info.status, irq_info.id, irq_info.frm_cnt_sof,
				irq_info.frm_cnt_sol, irq_info.frm_cnt_nxt_sol,
				irq_info.frm_cnt_3a);

			if (irq_info.status & I7_INT_SOL_MASK) {
				// ctx_id = ((irq_info.id & 0x3) << 2) | ((irq_info.id >> 2) & 03);
				armcb_isp_irq_sol_i7(ctx_id);
			}

			if (irq_info.status & I7_INT_SOF_INT_MASK)
				armcb_isp_irq_sof_i7(ctx_id);

			if (irq_info.status & I7_INT_VOUTX_INT_MASK) {
				if (irq_info.status & I7_INT_VOUT1_BUF_DONE) {
					outport = (1 << ISP_OUTPUT_PORT_VOUT1);
					if (armcb_v4l2_find_ctx_stream_by_outport(
							outport, &ctx_id,
							&stream_id) < 0) {
						LOG(LOG_ERR,
							"failed to find a valid ctx_id and stream_id for port %d",
							outport);
						goto loop;
					}
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT1);
					irq_info_vout = irq_info;
					irq_info_vout.status =
						I7_INT_VOUT1_BUF_DONE;
					armcb_v4l2_config_queue_event(
						pvdev, &irq_info_vout);

					irq_info.status &=
						~I7_INT_VOUT1_BUF_DONE;
				}
				if (irq_info.status & I7_INT_VOUT3_BUF_DONE) {
					outport = (1 << ISP_OUTPUT_PORT_VOUT3);
					if (armcb_v4l2_find_ctx_stream_by_outport(
							outport, &ctx_id,
							&stream_id) < 0) {
						LOG(LOG_ERR,
							"failed to find a valid ctx_id and stream_id for port %d",
							outport);
						goto loop;
					}
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT3);
					irq_info_vout = irq_info;
					irq_info_vout.status =
						I7_INT_VOUT3_BUF_DONE;
					armcb_v4l2_config_queue_event(
						pvdev, &irq_info_vout);

					irq_info.status &=
						~I7_INT_VOUT3_BUF_DONE;
				}
				if (irq_info.status & I7_INT_VOUT5_BUF_DONE) {
					outport = (1 << ISP_OUTPUT_PORT_VOUT5);
					if (armcb_v4l2_find_ctx_stream_by_outport(
							outport, &ctx_id,
							&stream_id) < 0) {
						LOG(LOG_ERR,
							"failed to find a valid ctx_id and stream_id for port %d",
							outport);
						goto loop;
					}
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT5);
					irq_info_vout = irq_info;
					irq_info_vout.status =
						I7_INT_VOUT5_BUF_DONE;
					armcb_v4l2_config_queue_event(
						pvdev, &irq_info_vout);

					irq_info.status &=
						~I7_INT_VOUT5_BUF_DONE;
				}
				if (irq_info.status & I7_INT_VOUT7_BUF_DONE) {
					outport = (1 << ISP_OUTPUT_PORT_VOUT7);
					if (armcb_v4l2_find_ctx_stream_by_outport(
							outport, &ctx_id,
							&stream_id) < 0) {
						LOG(LOG_ERR,
							"failed to find a valid ctx_id and stream_id for port %d",
							outport);
						goto loop;
					}
					armcb_isp_put_frame(
						ctx_id, stream_id,
						ISP_OUTPUT_PORT_VOUT7);
					irq_info_vout = irq_info;
					irq_info_vout.status =
						I7_INT_VOUT7_BUF_DONE;
					armcb_v4l2_config_queue_event(
						pvdev, &irq_info_vout);

					irq_info.status &=
						~I7_INT_VOUT7_BUF_DONE;
				}
			}

			/*5. post irq event to userspace */
			if (irq_info.status & I7_IRQ_EVENT_POST_MASK)
				armcb_v4l2_config_queue_event(pvdev, &irq_info);
		}
loop:
		msleep(33);
	}

	return res;
}
#endif

static void armcb_irq_msg_fh_init(struct armcb_irq_msg_fh *fh)
{
	int idx = 0;

	fh->elems = 32;
	fh->first = 0;
	fh->in_use = 0;
	spin_lock_init(&fh->fh_lock);
	INIT_LIST_HEAD(&fh->avaliable);
	for (; idx < fh->elems; idx++)
		INIT_LIST_HEAD(&fh->ev_array[idx].fh_node);
}

#ifndef CIX_V4L2_ADAPTER
static void buffer_done_i7_handle(struct isp_irq_info *info)
{
	struct video_device *pvdev = &p_v4l_config_dev->vid_cap_dev;
#else
static void buffer_done_i7_handle(struct isp_irq_info *info,
				  struct video_device *pvdev)
{
#endif
	uint32_t ctx_id = ((info->id & 0x3) << 2) | ((info->id >> 2) & 03);
	armcb_v4l2_dev_t *pdev = NULL;

	pdev = armcb_v4l2_core_get_dev(ctx_id);
	if (pdev && atomic_read(&pdev->opened) == 0)
		ctx_id = armcb_v4l2_core_find_1st_opened_dev();

#ifdef ENABLE_RUNTIME_UPDATE_STATS_ADDR
	if (info->status & I7_INT_3A_INT_MASK) {
		uint32_t outport = 0;
		uint32_t stream_id = 0;

		outport = (1 << ISP_OUTPUT_PORT_3A);
		if (!armcb_v4l2_find_stream_by_outport_ctx(outport, ctx_id,
							   &stream_id)) {
			armcb_isp_put_frame(ctx_id, stream_id,
						ISP_OUTPUT_PORT_3A);
		}

		armcb_v4l2_config_queue_event_with_status(pvdev, info,
							  I7_INT_3A_INT_MASK);

		info->status &= ~I7_INT_3A_INT_MASK;
	}
#endif

	if (info->status & I7_INT_VOUTX_INT_MASK) {
		if (info->status & I7_INT_VOUT0_BUF_DONE) {
			PUT_FRAME(ctx_id, -1, ISP_OUTPUT_PORT_VOUT0);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VOUT0_BUF_DONE);

			info->status &= ~I7_INT_VOUT0_BUF_DONE;
		}
		if (info->status & I7_INT_VOUT1_BUF_DONE) {
			PUT_FRAME(ctx_id, -1, ISP_OUTPUT_PORT_VOUT1);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VOUT1_BUF_DONE);

			info->status &= ~I7_INT_VOUT1_BUF_DONE;
		}
		if (info->status & I7_INT_VOUT3_BUF_DONE) {
			PUT_FRAME(ctx_id, -1, ISP_OUTPUT_PORT_VOUT3);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VOUT3_BUF_DONE);

			info->status &= ~I7_INT_VOUT3_BUF_DONE;
		}
		if (info->status & I7_INT_VOUT5_BUF_DONE) {
			PUT_FRAME(ctx_id, -1, ISP_OUTPUT_PORT_VOUT5);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VOUT5_BUF_DONE);

			info->status &= ~I7_INT_VOUT5_BUF_DONE;
		}
		if (info->status & I7_INT_VOUT7_BUF_DONE) {
			PUT_FRAME(ctx_id, -1, ISP_OUTPUT_PORT_VOUT7);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VOUT7_BUF_DONE);

			info->status &= ~I7_INT_VOUT7_BUF_DONE;
		}
	}

	if (info->status & I7_INT_VIN_EXPX_INT_MASK) {
		if (info->status & I7_INT_VIN_CHNL_L_BUF_DONE) { // Channel Long
			armcb_isp_put_frame(ctx_id, -1, ISP_OUTPUT_PORT_VIN);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VIN_CHNL_L_BUF_DONE);

			info->status &= ~I7_INT_VIN_CHNL_L_BUF_DONE;
		}
		if (info->status &
			I7_INT_VIN_CHNL_M_BUF_DONE) { // Channel Middle
			armcb_isp_put_frame(ctx_id, -1, ISP_OUTPUT_PORT_VIN);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VIN_CHNL_M_BUF_DONE);

			info->status &= ~I7_INT_VIN_CHNL_M_BUF_DONE;
		}
		if (info->status &
			I7_INT_VIN_CHNL_S_BUF_DONE) { // Channel Short
			armcb_isp_put_frame(ctx_id, -1, ISP_OUTPUT_PORT_VIN);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VIN_CHNL_S_BUF_DONE);

			info->status &= ~I7_INT_VIN_CHNL_S_BUF_DONE;
		}
		if (info->status &
			I7_INT_VIN_CHNL_VS_BUF_DONE) { // Channel v short
			armcb_isp_put_frame(ctx_id, -1, ISP_OUTPUT_PORT_VIN);
			armcb_v4l2_config_queue_event_with_status(
				pvdev, info, I7_INT_VIN_CHNL_VS_BUF_DONE);

			info->status &= ~I7_INT_VIN_CHNL_VS_BUF_DONE;
		}
	}

	if (info->status & I7_IRQ_EVENT_POST_MASK)
		armcb_v4l2_config_queue_event(pvdev, info);
}

#ifndef CIX_V4L2_ADAPTER
static void buffer_done_handler(unsigned long data)
{
	struct armcb_irq_msg_fh *fh = &p_v4l_config_dev->isr_fh;
	struct isp_irq_info *info = NULL;
	struct armcb_irq_event *ev = NULL;
	struct armcb_irq_event *ev_next = NULL;
	unsigned long flags;
	(void)data;

	spin_lock_irqsave(&fh->fh_lock, flags);
	list_for_each_entry_safe(ev, ev_next, &fh->avaliable, fh_node) {
		info = &ev->info;

		/* enqueue the buffer to done queue*/
		buffer_done_i7_handle(info);

		list_del(&ev->fh_node);
		fh->in_use--;
		fh->first = irqev_pos(fh, 1);
	}
	spin_unlock_irqrestore(&fh->fh_lock, flags);
}
#else
static void buffer_done_handler(unsigned long data)
{
	armcb_v4l2_config_dev_t *p_cfg_dev = (armcb_v4l2_config_dev_t *)data;
	struct armcb_irq_msg_fh *fh = &p_cfg_dev->isr_fh;
	struct isp_irq_info *info = NULL;
	struct armcb_irq_event *ev = NULL;
	struct armcb_irq_event *ev_next = NULL;
	unsigned long flags;

	spin_lock_irqsave(&fh->fh_lock, flags);
	list_for_each_entry_safe(ev, ev_next, &fh->avaliable, fh_node) {
		info = &ev->info;

		/* enqueue the buffer to done queue*/
		buffer_done_i7_handle(info, &p_cfg_dev->vid_cap_dev);

		list_del(&ev->fh_node);
		fh->in_use--;
		fh->first = irqev_pos(fh, 1);
	}
	spin_unlock_irqrestore(&fh->fh_lock, flags);
}
#endif

/**********************************************************/
/*						V4L2 APIs					   */

static int armcb_v4l2_querycap(struct file *file, void *priv,
				   struct v4l2_capability *cap)
{
	armcb_v4l2_config_dev_t *dev = video_drvdata(file);

	strcpy(cap->driver, "arm-china-isp");
	strcpy(cap->card, "linlon isp");
	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
		 dev->v4l2_dev.name);

	return 0;
}

static int
armcb_v4l2_config_subscribe_event(struct v4l2_fh *fh,
				  const struct v4l2_event_subscription *sub)
{
	int ret = -1;

	LOG(LOG_DEBUG, "type:%d id:%d", sub->type, sub->id);
	ret = v4l2_event_subscribe(fh, sub, CORE_NEVENTS, NULL);
	if (ret < 0)
		LOG(LOG_ERR, "armcb_v4l2_subscribe_event failed ret(%d)", ret);
	return ret;
}

static int
armcb_v4l2_config_unsubscribe_event(struct v4l2_fh *fh,
					const struct v4l2_event_subscription *sub)
{
	struct v4l2_event ev;

	LOG(LOG_INFO, "+");
	memset(&ev, 0, sizeof(struct v4l2_event));
#ifndef CIX_V4L2_ADAPTER
	ev.id = 3;
#else
	ev.id = ISP_MIXTURE_INT;
#endif
	ev.type = V4L2_EVENT_CTRL;
	/// Queue a empty event to notify userspace
	v4l2_event_queue(fh->vdev, &ev);

	LOG(LOG_INFO, "type:%d id:%d", sub->type, sub->id);
	v4l2_event_unsubscribe(fh, sub);
	streamOnFlag = 0;

	LOG(LOG_INFO, "-");
	return 0;
}

static ssize_t armcb_v4l2_config_fop_write(struct file *filep,
					   const char __user *buf, size_t count,
					   loff_t *ppos)
{
	return 0;
}

static ssize_t armcb_v4l2_config_fop_read(struct file *filep, char __user *buf,
					  size_t count, loff_t *ppos)
{
	return 0;
}

#ifndef CIX_V4L2_ADAPTER
static const struct v4l2_ioctl_ops armcb_v4l2_config_ioctl_ops = {
	.vidioc_querycap = armcb_v4l2_querycap,

	.vidioc_g_fmt_vid_cap_mplane = NULL,
	.vidioc_s_fmt_vid_cap_mplane = NULL,
	.vidioc_try_fmt_vid_cap_mplane = NULL,

	.vidioc_reqbufs = NULL,
	.vidioc_expbuf = NULL,
	.vidioc_querybuf = NULL,

	.vidioc_qbuf = NULL,
	.vidioc_dqbuf = NULL,

	.vidioc_streamon = NULL,
	.vidioc_streamoff = NULL,

	.vidioc_subscribe_event = armcb_v4l2_config_subscribe_event,
	.vidioc_unsubscribe_event = armcb_v4l2_config_unsubscribe_event,
};

/**************************************************************************/
/*				file APIs: v4l2_file_operations						 */
static int armcb_v4l2_config_fop_release(struct file *file)
{
	armcb_v4l2_config_dev_t *dev = video_drvdata(file);
	struct video_device *vdev = video_devdata(file);
	struct v4l2_fh *fh = NULL;
	struct v4l2_event_subscription sub;
	int ret = 0;

	LOG(LOG_INFO, "+");
	if (vdev->queue)
		return vb2_fop_release(file);

	atomic_sub_return(1, &dev->opened);

	fh = file->private_data;
	/* unsubscribe event when close file */
	if (fh) {
		memset(&sub, 0, sizeof(sub));
		sub.type = V4L2_EVENT_ALL;
		ret = v4l2_event_unsubscribe(fh, &sub);
		LOG(LOG_DEBUG,
			"armcb_fop_release v4l2_event_unsubscribe, ret = %d", ret);

		v4l2_fh_del(fh);
		v4l2_fh_exit(fh);
	}
	LOG(LOG_INFO, "-");

	return ret;
}

static int armcb_v4l2_config_fop_open(struct file *file)
{
	armcb_v4l2_config_dev_t *dev = video_drvdata(file);
	struct video_device *vdev = video_devdata(file);
	struct v4l2_fh *fh = kzalloc(sizeof(*fh), GFP_KERNEL);

	file->private_data = fh;
	if (fh == NULL)
		return -ENOMEM;

	v4l2_fh_init(fh, vdev);
	v4l2_fh_add(fh);

	atomic_add(1, &dev->opened);
	return 0;
}

static unsigned int armcb_v4l2_config_fop_poll(struct file *filep,
						   struct poll_table_struct *wait)
{
	return 0;
}

static int armcb_v4l2_config_fop_mmap(struct file *file,
					  struct vm_area_struct *vma)
{
	return 0;
}

static const struct v4l2_file_operations armcb_v4l2_config_fops = {
	.owner = THIS_MODULE,
	.open = armcb_v4l2_config_fop_open,
	.release = armcb_v4l2_config_fop_release,
	.read = armcb_v4l2_config_fop_read,
	.write = armcb_v4l2_config_fop_write,
	.poll = armcb_v4l2_config_fop_poll,
	.unlocked_ioctl = video_ioctl2,
	.mmap = armcb_v4l2_config_fop_mmap,
};
#else
/**************************************************************************/
/*				file APIs: v4l2_file_operations						 */

static int armcb_v4l2_config_fop_release(struct file *file)
{
	armcb_v4l2_config_dev_t *dev = video_drvdata(file);
	struct video_device *vdev = video_devdata(file);
	struct v4l2_fh *fh = NULL;
	struct v4l2_event_subscription sub;
	int ret = 0;

	LOG(LOG_INFO, "+");
	if (vdev->queue)
		return vb2_fop_release(file);

	atomic_sub_return(1, &dev->opened);

	fh = file->private_data;
	/* unsubscribe event when close file */
	if (fh) {
		memset(&sub, 0, sizeof(sub));
		sub.type = V4L2_EVENT_ALL;
		ret = v4l2_event_unsubscribe(fh, &sub);
		LOG(LOG_DEBUG,
			"armcb_fop_release v4l2_event_unsubscribe, ret = %d", ret);

		v4l2_fh_del(fh);
		v4l2_fh_exit(fh);
	}
	mutex_lock(&dev->lock);
	ret = _vb2_fop_release(file, NULL);
	mutex_unlock(&dev->lock);

	LOG(LOG_INFO, "-");

	return ret;
}

static int armcb_v4l2_config_fop_open(struct file *file)
{
	armcb_v4l2_config_dev_t *dev = video_drvdata(file);
	struct video_device *vdev = video_devdata(file);
	struct v4l2_fh *fh = kzalloc(sizeof(*fh), GFP_KERNEL);

	file->private_data = fh;

	if (fh == NULL)
		return -ENOMEM;
	v4l2_fh_open(file);
	v4l2_fh_init(fh, vdev);
	v4l2_fh_add(fh);
	/* init stream */
	if (dev->stream_init_done == 0) {
		armcb_v4l2_stream_init(&dev->pstream, 0, 0);
		LOG(LOG_INFO,
			"stream init: file:%p, config_dev: %p, dev->pstream: %p",
			file, dev, dev->pstream);
		dev->stream_init_done = 1;
	} else {
		LOG(LOG_INFO,
			"stream inited: file:%p, config_dev: %p, dev->pstream: %p",
			file, dev, dev->pstream);
	}
	g_t_pstream = dev->pstream;

	atomic_add(1, &dev->opened);
	return 0;
}

static const struct v4l2_file_operations armcb_v4l2_config_fops = {
	.owner = THIS_MODULE,
	.open = armcb_v4l2_config_fop_open,
	.release = armcb_v4l2_config_fop_release,
	.read = armcb_v4l2_config_fop_read,
	.write = armcb_v4l2_config_fop_write,
	.poll = vb2_fop_poll,
	.unlocked_ioctl = video_ioctl2,
	.mmap = vb2_fop_mmap,
};

/**********************************************************/
/*						vb2_ops						 */

static int cap_vb2_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
				   unsigned int *num_planes, unsigned int sizes[],
				   struct device *alloc_devs[])
{
	int i = 0;
	armcb_v4l2_config_dev_t *dev = vb2_get_drv_priv(q);
	struct isp_config_fmt *fmt =
		&isp_config_src_formats[g_t_pstream->isp_fmt_index];
	struct v4l2_format *vfmt = &g_t_pstream->cur_v4l2_fmt;

	LOG(LOG_DEBUG, "queue setup: num_planes:%d, size[0]:%d", *num_buffers,
		sizes[0]);
	*num_planes = fmt->memplanes;

	for (i = 0; i < *num_planes; ++i) {
		sizes[i] = vfmt->fmt.pix_mp.plane_fmt[i].sizeimage;
		LOG(LOG_INFO, "size:%d", sizes[i]);
		alloc_devs[i] = dev->mem_device;
	}

	LOG(LOG_DEBUG,
		"num_buffers=%d, num_planes=%d, sizes=%d / %d, alloc_devs[0]=0x%x",
		*num_buffers, *num_planes, sizes[0], sizes[1], alloc_devs[0]);
	return 0;
}

static int cap_vb2_buffer_prepare(struct vb2_buffer *vb2)
{
	return 0;
}

static void cap_vb2_buffer_queue(struct vb2_buffer *vb2)
{
	armcb_v4l2_config_dev_t *dev = vb2_get_drv_priv(vb2->vb2_queue);
	armcb_v4l2_stream_t *pstream = dev->pstream;
	struct vb2_v4l2_buffer *vvb = to_vb2_v4l2_buffer(vb2);
	armcb_v4l2_buffer_t *buf = container_of(vvb, armcb_v4l2_buffer_t, vvb);

	spin_lock(&pstream->slock);
	list_add_tail(&buf->list, &pstream->stream_buffer_list);
	LOG(LOG_DEBUG, "buf%p, num_planes=%d", buf,
		buf->vvb.vb2_buf.num_planes);
	spin_unlock(&pstream->slock);
}

static int cap_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
{
	LOG(LOG_DEBUG, "function enter");
	LOG(LOG_DEBUG, "function exit");
	return 0;
}

static void destroy_buf_queue(struct vb2_queue *q, enum vb2_buffer_state state)
{
	armcb_v4l2_config_dev_t *dev = vb2_get_drv_priv(q);
	armcb_v4l2_stream_t *pstream = dev->pstream;
	armcb_v4l2_buffer_t *pbuf = NULL;
	u32 i;

	spin_lock(&pstream->slock);
	while (!list_empty(&pstream->stream_buffer_list)) {
		pbuf = list_entry(pstream->stream_buffer_list.next,
				  armcb_v4l2_buffer_t, list);
		list_del(&pbuf->list);
		vb2_buffer_done(&pbuf->vvb.vb2_buf, state);
	}
	while (!list_empty(&pstream->stream_buffer_list_busy)) {
		pbuf = list_entry(pstream->stream_buffer_list_busy.next,
				  armcb_v4l2_buffer_t, list);
		list_del(&pbuf->list);
		vb2_buffer_done(&pbuf->vvb.vb2_buf, state);
	}
	spin_unlock(&pstream->slock);

	for (i = 0; i < q->num_buffers; ++i) {
		if (q->bufs[i]->state == VB2_BUF_STATE_ACTIVE)
			vb2_buffer_done(q->bufs[i], VB2_BUF_STATE_ERROR);
	}
}

static void cap_vb2_stop_streaming(struct vb2_queue *q)
{
	armcb_v4l2_config_dev_t *config_dev = vb2_get_drv_priv(q);
	armcb_v4l2_stream_t *pstream = config_dev->pstream;
	unsigned int *pData = NULL;
	struct v4l2_event ev;

	LOG(LOG_INFO, "function enter");
	if (!pstream->stream_started)
		return;

	if (streamOnFlag)
	{
		memset(&ev, 0, sizeof(struct v4l2_event));
		ev.id = ISP_DAEMON_EVENT_STREAM_OFF;
		ev.type = V4L2_EVENT_CTRL;

		/// Queue a empty event to notify userspace
		pData = (unsigned int *)ev.u.data;
		pData[0] = 0xff;
		v4l2_event_queue(&config_dev->vid_cap_dev, &ev);
		streamOnFlag = 0;
		LOG(LOG_INFO, "upload event");
	}

	if (1) {
		pstream->stream_started = 0;
		destroy_buf_queue(q, VB2_BUF_STATE_ERROR);
		LOG(LOG_INFO, "	 exit");
		return;
	}

	LOG(LOG_INFO, "function exit");
}

static const struct vb2_ops sky1_cap_vb2_qops = {
	.queue_setup = cap_vb2_queue_setup,
	.buf_prepare = cap_vb2_buffer_prepare,
	.buf_queue = cap_vb2_buffer_queue,
	.wait_prepare = vb2_ops_wait_prepare,
	.wait_finish = vb2_ops_wait_finish,
	.start_streaming = cap_vb2_start_streaming,
	.stop_streaming = cap_vb2_stop_streaming,
};

static int armcb_v4l2_cfg_streamon(struct file *file, void *priv,
				   enum v4l2_buf_type buf_type)
{
	int rc = -1;
	unsigned int *pData = NULL;
	struct v4l2_event ev;
	armcb_v4l2_stream_t *pstream = NULL;
	armcb_v4l2_config_dev_t *dev = video_drvdata(file);
	struct video_device *vdev = video_devdata(file);

	memset(&ev, 0, sizeof(struct v4l2_event));
	ev.id = ISP_DAEMON_EVENT_STREAM_ON;
	ev.type = V4L2_EVENT_CTRL;

	/// Queue a empty event to notify userspace
	pData = (unsigned int *)ev.u.data;
	pData[0] = 0xff;
	v4l2_event_queue(&dev->vid_cap_dev, &ev);
	LOG(LOG_INFO, "streaming: %d, queued_count:%d, min_buffers_needed:%d",
		vdev->queue->streaming, vdev->queue->queued_count,
		vdev->queue->min_buffers_needed);

	if (list_empty(&vdev->queue->queued_list))
		LOG(LOG_ERR, "queued_list list is empty. (rc=%d)", rc);
	else
		rc = vb2_streamon(vdev->queue, buf_type);

	if (rc != 0) {
		LOG(LOG_ERR, "fail to vb2_streamon. (rc=%d)", rc);
		return rc;
	} else {
		pstream = dev->pstream;
		pstream->stream_started = 1;
		LOG(LOG_DEBUG,
			"success to pstream->stream_started: %p, streaming:%d",
			pstream, vdev->queue->streaming);
	}

	return 0;
}

static int armcb_v4l2_cfg_streamoff(struct file *file, void *priv,
					enum v4l2_buf_type buf_type)
{
	int ret = 0;

	LOG(LOG_INFO, "enter streamoff");
	return ret;
}

static int find_fmt(struct v4l2_pix_format_mplane *pix, BOOL try)
{
	int ret = 0;
	int index = 0;
	struct isp_config_fmt *fmt;

	for (index = 0; index < ARRAY_SIZE(isp_config_src_formats); index++) {
		fmt = &isp_config_src_formats[index];
		if (fmt->fourcc == pix->pixelformat) {
			LOG(LOG_INFO, "format: %s", fmt->name);
			break;
		}
	}

	if (index >= ARRAY_SIZE(isp_config_src_formats)) {
		LOG(LOG_INFO, "format(%.4s) is not support!\n",
			(char *)&pix->pixelformat);
		return -EINVAL;
	}

	/* Handle actual format setting */
	if (!try)
	{
		g_t_pstream->isp_fmt_index = index;
		pix->num_planes = fmt->memplanes;

		for (int i = 0; i < pix->num_planes; i++) {
			pix->plane_fmt[i].bytesperline = pix->width * fmt->depth[i] >> 3;

			pix->plane_fmt[i].sizeimage =
						pix->plane_fmt[i].bytesperline *
						pix->height;
		}
	}
	return ret;
}

static int armcb_cfg_try_fmt_vid_cap_mplane(struct file *file, void *fh,
						struct v4l2_format *f)
{
	return find_fmt(&f->fmt.pix_mp, TRUE);
}

int armcb_cfg_s_fmt_vid_cap_mplane(struct file *file, void *priv,
				   struct v4l2_format *f)
{
	int ret = 0;
	struct v4l2_event ev;
	unsigned int *pData = NULL;
	armcb_v4l2_config_dev_t *dev = video_drvdata(file);
	struct vb2_queue *q = &dev->vb2_q;

	ret = find_fmt(&f->fmt.pix_mp, FALSE);
	if (ret < 0)
		return -EINVAL;
	g_t_pstream->cur_v4l2_fmt.fmt.pix_mp = f->fmt.pix_mp;

	memset(q, 0, sizeof(*q));
	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
	q->io_modes = VB2_MMAP | VB2_USERPTR;
	q->drv_priv = dev;
	q->ops = &sky1_cap_vb2_qops;
	q->mem_ops = &vb2_dma_contig_memops;
	q->memory = V4L2_MEMORY_MMAP;
	q->buf_struct_size = sizeof(struct arm_cfg_buffer);
	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
	q->lock = &dev->lock;

	ret = vb2_queue_init(q);
	if (ret) {
		LOG(LOG_ERR, "create vb2 queue failed");
		return ret;
	}

	memset(&ev, 0, sizeof(struct v4l2_event));
	ev.id = ISP_DAEMON_EVENT_SET_IMG_SIZE;
	ev.type = V4L2_EVENT_CTRL;

	pData = (unsigned int *)ev.u.data;
	pData[0] = 0;
	pData[1] = f->fmt.pix_mp.width;
	pData[2] = f->fmt.pix_mp.height;
	pData[3] = f->fmt.pix_mp.pixelformat;
	pData[4] = 30;
	v4l2_event_queue(&dev->vid_cap_dev, &ev);
	LOG(LOG_INFO, "SET FMT: width = %d, height = %d, pixelformat = %d",
		f->fmt.pix_mp.width, f->fmt.pix_mp.height,
		f->fmt.pix_mp.pixelformat);
	return ret;
}

int armcb_cfg_g_fmt_vid_cap_mplane(struct file *file, void *priv,
				   struct v4l2_format *f)
{
	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;

	LOG(LOG_INFO, "function enter");
	f->fmt.pix_mp = g_t_pstream->cur_v4l2_fmt.fmt.pix_mp;

	LOG(LOG_DEBUG,
		"GET FMT: width = %d, height = %d, colorspace = %d, pixel_format = %d, " \
		"sizeimage0 = %d, sizeimage1 = %d, bytesperline0 = %d, bytesperline1 = %d",
		pix->width, pix->height, pix->colorspace, pix->pixelformat,
		pix->plane_fmt[0].sizeimage, pix->plane_fmt[1].sizeimage,
		pix->plane_fmt[0].bytesperline, pix->plane_fmt[1].bytesperline);

	return 0;
}

int armcb_cfg_enum_fmt_vid_cap(struct file *file, void *priv,
				   struct v4l2_fmtdesc *f)
{
	struct isp_config_fmt *fmt;

	LOG(LOG_DEBUG, "function enter");
	if (f->index >= (int)ARRAY_SIZE(isp_config_src_formats))
		return -EINVAL;

	fmt = &isp_config_src_formats[f->index];
	strncpy(f->description, fmt->name, sizeof(f->description) - 1);

	f->pixelformat = fmt->fourcc;
	f->mbus_code = fmt->mbus_code;

	LOG(LOG_INFO, "function exit : %d", f->pixelformat);
	return 0;
}

static int armcb_cfg_enum_framesizes(struct file *file, void *priv,
					 struct v4l2_frmsizeenum *fsize)
{
	static const struct v4l2_frmsize_discrete frame_sizes[] = {
		{ .width = 1920, .height = 1080 }, // 1080p
		{ .width = 1280, .height = 720 },  // 720p
		{ .width = 640, .height = 480 }    // 480p
	};
	LOG(LOG_DEBUG, "function enter");

	if (fsize->index >= ARRAY_SIZE(frame_sizes))
		return -EINVAL;

	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
	fsize->discrete = frame_sizes[fsize->index];

	return 0;
}

static int armcb_cfg_g_selection(struct file *file, void *fh,
				 struct v4l2_selection *s)
{
	LOG(LOG_DEBUG, "enter: target = %d, type = %d",
		s->target, s->type);

	/* need fix: hard code for NV12M 1080p fmt */
	switch (s->target) {
	case V4L2_SEL_TGT_CROP_DEFAULT:
	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
		s->r.left = 0;
		s->r.top = 0;
		s->r.width = 1920;
		s->r.height = 1080;
		LOG(LOG_DEBUG, "function exit");
		return 0;
	}

	return -EINVAL;
}

static int armcb_cfg_s_selection(struct file *file, void *fh,
				 struct v4l2_selection *s)
{
	LOG(LOG_DEBUG, "function enter");
	return 0;
}

static int armcb_cfg_enum_frameintervals(struct file *file, void *fh,
					 struct v4l2_frmivalenum *interval)
{
	if (interval->pixel_format ==
		isp_config_src_formats[interval->index].fourcc) {
		interval->type = V4L2_FRMIVAL_TYPE_DISCRETE;
		interval->discrete.numerator = 30;
		interval->discrete.denominator = 1000;

		LOG(LOG_DEBUG,
			"index: %d, width: %d, height: %d, pixel_format: 0x%08x",
			interval->index, interval->width, interval->height,
			interval->pixel_format);
		return 0;
	}

	return -EINVAL;
}

static const struct v4l2_ioctl_ops armcb_v4l2_config_ioctl_ops = {
	.vidioc_querycap = armcb_v4l2_querycap,

	.vidioc_g_fmt_vid_cap_mplane = armcb_cfg_g_fmt_vid_cap_mplane,
	.vidioc_s_fmt_vid_cap_mplane = armcb_cfg_s_fmt_vid_cap_mplane,
	.vidioc_try_fmt_vid_cap_mplane = armcb_cfg_try_fmt_vid_cap_mplane,

	.vidioc_enum_fmt_vid_cap = armcb_cfg_enum_fmt_vid_cap,
	.vidioc_enum_framesizes = armcb_cfg_enum_framesizes,

	.vidioc_reqbufs = vb2_ioctl_reqbufs,
	.vidioc_querybuf = vb2_ioctl_querybuf,
	.vidioc_qbuf = vb2_ioctl_qbuf,
	.vidioc_dqbuf = vb2_ioctl_dqbuf,
	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
	.vidioc_create_bufs = vb2_ioctl_create_bufs,
	//.vidioc_expbuf				  = vb2_ioctl_expbuf, // gstreamer check
	.vidioc_expbuf = NULL,

	.vidioc_streamon = armcb_v4l2_cfg_streamon,
	.vidioc_streamoff = armcb_v4l2_cfg_streamoff,

	.vidioc_subscribe_event = armcb_v4l2_config_subscribe_event,
	.vidioc_unsubscribe_event = armcb_v4l2_config_unsubscribe_event,

	.vidioc_g_selection = armcb_cfg_g_selection,
	.vidioc_s_selection = armcb_cfg_s_selection,
	.vidioc_enum_frameintervals = armcb_cfg_enum_frameintervals,
};
#endif

extern struct device *mem_dev;
static int armcb_v4l2_config_probe(struct platform_device *pdev)
{
#ifndef CIX_V4L2_ADAPTER
	int ret = 0;
	int isp_irqno = 0;
	struct armcb_isp_info *hw_info = NULL;
	struct video_device *vfd = NULL;
#ifdef QEMU_ON_VEXPRESS
	struct task_struct *interrupt_task = NULL;
#endif
	p_v4l_config_dev = devm_kzalloc(
		&pdev->dev, sizeof(armcb_v4l2_config_dev_t), GFP_KERNEL);
	if (p_v4l_config_dev == NULL) {
		LOG(LOG_ERR, "failed to alloc memory for v4l config dev.");
		goto exit_ret;
	}

	/* initialize v4l2 config dev */
	p_v4l_config_dev->pvdev = pdev;

	/* register v4l2_device */
	snprintf(p_v4l_config_dev->v4l2_dev.name,
		 V4L2_DEVICE_NAME_SIZE * sizeof(char), "%s", ARMCB_MODULE_NAME);
	LOG(LOG_INFO, "armcb config dev name:%s",
		p_v4l_config_dev->v4l2_dev.name);
	ret = v4l2_device_register(&pdev->dev, &p_v4l_config_dev->v4l2_dev);
	if (ret) {
		LOG(LOG_ERR, "failed to register v4l2 device %s",
			p_v4l_config_dev->v4l2_dev.name);
		goto exit_ret;
	}

	// p_v4l_config_dev->v4l2_dev.release = armcb_v4l2_dev_release;
	// p_v4l_config_dev->v4l2_dev.notify = armcb_v4l2_subdev_notify;

	/* set up the capabilities of the video capture device */
	p_v4l_config_dev->vid_cap_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
					 V4L2_CAP_STREAMING |
					 V4L2_CAP_READWRITE;
	spin_lock_init(&p_v4l_config_dev->slock);
	mutex_init(&p_v4l_config_dev->mutex);

	/* initialize open counter */
	atomic_set(&p_v4l_config_dev->opened, 0);

	vfd = &p_v4l_config_dev->vid_cap_dev;
	snprintf(vfd->name, sizeof(vfd->name), "armcb-config");
	vfd->fops = &armcb_v4l2_config_fops;
	vfd->ioctl_ops = &armcb_v4l2_config_ioctl_ops;
	vfd->device_caps = p_v4l_config_dev->vid_cap_caps;
	vfd->release = video_device_release_empty;
	vfd->v4l2_dev = &p_v4l_config_dev->v4l2_dev;
	vfd->queue = NULL;
	vfd->tvnorms = 0;

#else
	int ret = 0;
	int isp_irqno = 0;
	struct armcb_isp_info *hw_info = NULL;
	struct video_device *vfd = NULL;
	struct vb2_queue *q = NULL;
	armcb_v4l2_config_dev_t *p_v4l_config_dev = NULL;

	p_v4l_config_dev = devm_kzalloc(
		&pdev->dev, sizeof(armcb_v4l2_config_dev_t), GFP_KERNEL);
	q = &p_v4l_config_dev->vb2_q;
	if (p_v4l_config_dev == NULL) {
		LOG(LOG_ERR, "failed to alloc memory for v4l config dev.");
		goto exit_ret;
	}

	/* initialize v4l2 config dev */
	p_v4l_config_dev->pvdev = pdev;

	/* register v4l2_device */
	p_v4l_config_dev->mem_device = mem_dev;

	snprintf(p_v4l_config_dev->v4l2_dev.name,
		 V4L2_DEVICE_NAME_SIZE * sizeof(char), "%s", ARMCB_MODULE_NAME);
	ret = v4l2_device_register(mem_dev, &p_v4l_config_dev->v4l2_dev);
	if (ret) {
		LOG(LOG_ERR, "failed to register v4l2 device %s",
			p_v4l_config_dev->v4l2_dev.name);
		goto exit_ret;
	}

	/* set up the capabilities of the video capture device */
	p_v4l_config_dev->vid_cap_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
					 V4L2_CAP_STREAMING |
					 V4L2_CAP_READWRITE;
	spin_lock_init(&p_v4l_config_dev->slock);
	mutex_init(&p_v4l_config_dev->mutex);

	/* initialize open counter */
	atomic_set(&p_v4l_config_dev->opened, 0);

	vfd = &p_v4l_config_dev->vid_cap_dev;

	vfd->fops = &armcb_v4l2_config_fops;
	vfd->ioctl_ops = &armcb_v4l2_config_ioctl_ops;
	vfd->device_caps = p_v4l_config_dev->vid_cap_caps;
	vfd->release = video_device_release_empty;
	vfd->v4l2_dev = &p_v4l_config_dev->v4l2_dev;
	vfd->queue = q;
	vfd->tvnorms = 0;
	snprintf(vfd->name, sizeof(vfd->name), "armcb-config");
#endif

	/*
	 * Provide a mutex to v4l2 core. It will be used to protect
	 * all fops and v4l2 ioctls.
	 */
	vfd->lock = &p_v4l_config_dev->mutex;
	video_set_drvdata(vfd, p_v4l_config_dev);
#if (KERNEL_VERSION(5, 10, 0) <= LINUX_VERSION_CODE)
	ret = video_register_device(vfd, VFL_TYPE_VIDEO, -1);
#else
	ret = video_register_device(vfd, VFL_TYPE_GRABBER, -1);
#endif
	if (ret < 0)
		goto unreg_dev;
	LOG(LOG_INFO,
		"V4L2 capture device registered as %s, vfd->name:%s v4l2_dev.name:%s",
		video_device_node_name(vfd), vfd->name,
		p_v4l_config_dev->v4l2_dev.name);

	/* register isr function*/
	if (has_acpi_companion(&pdev->dev)) {
		hw_info = (struct armcb_isp_info *)acpi_device_get_match_data(
			&pdev->dev);
	} else {
		hw_info = (struct armcb_isp_info *)of_device_get_match_data(
			&pdev->dev);
	}

	if (!hw_info) {
		LOG(LOG_ERR, "failed to get isp hw info.");
		goto exit_ret;
	}

#ifdef QEMU_ON_VEXPRESS
	interrupt_task = kthread_run(armcb_isp_interrupt_task,
					 (void *)p_v4l_config_dev,
					 "interrupt_thread");
	if (interrupt_task == NULL) {
		LOG(LOG_ERR, "failed to create interrupt thread!!!");
		ret = -ENXIO;
		goto unreg_dev;
	}
#else
	isp_irqno = platform_get_irq(pdev, 0);

	if (isp_irqno <= 0) {
		ret = -ENXIO;
		LOG(LOG_ERR, "platform_get_irq failed irq(%d) ret(%d)",
			isp_irqno, ret);
		goto unreg_dev;
	}

#ifdef CONFIG_ARENA_FPGA_PLATFORM
	ret = devm_request_irq(&pdev->dev, isp_irqno, hw_info->isp_isr,
				   IRQF_SHARED, pdev->name,
				   (void *)p_v4l_config_dev);
#else
	ret = devm_request_irq(&pdev->dev, isp_irqno, hw_info->isp_isr,
				   IRQF_ONESHOT | IRQF_SHARED, pdev->name,
				   (void *)p_v4l_config_dev);
#endif
	if (ret != 0) {
		ret = -ENXIO;
		LOG(LOG_ERR, "devm_request_irq failed ret(%d)", ret);
		goto unreg_dev;
	}
#endif

	/*register i7 error isr*/
	if (hw_info->type == ISP_TYPE_I7) {
		isp_irqno = platform_get_irq(pdev, 1);

		if (isp_irqno <= 0) {
			ret = -ENXIO;
			LOG(LOG_ERR, "platform_get_irq failed irq(%d) ret(%d)",
				isp_irqno, ret);
			goto unreg_dev;
		}

		ret = devm_request_irq(&pdev->dev, isp_irqno,
					   hw_info->isp_err_isr, IRQF_SHARED,
					   pdev->name, (void *)p_v4l_config_dev);

		if (ret != 0) {
			ret = -ENXIO;
			LOG(LOG_ERR, "devm_request_irq failed ret(%d)", ret);
			goto unreg_dev;
		}
	}

	armcb_irq_msg_fh_init(&p_v4l_config_dev->isr_fh);
#ifndef CIX_V4L2_ADAPTER
	tasklet_init(&p_v4l_config_dev->buffer_done_task, buffer_done_handler,
			 0UL);
#else
	tasklet_init(&p_v4l_config_dev->buffer_done_task, buffer_done_handler,
			 (unsigned long)p_v4l_config_dev);
	platform_set_drvdata(pdev, p_v4l_config_dev);
#endif

#if 0
#ifdef CONFIG_PLAT_BBOX
	init_completion(&g_rdr_dump_comp);

	cix_isp_rproc_rdr_register_exception();

	ret = cix_isp_rproc_rdr_register_core();
	if (ret) {
		LOG(LOG_ERR,
			"cix_isp_rproc_rdr_register_core fail, ret = [%d]\n", ret);
		goto err_rproc_add;
	}
#endif
#endif

	return ret;
#if 0
#ifdef CONFIG_PLAT_BBOX
err_rproc_add:
#endif
#endif
unreg_dev:
	video_unregister_device(&p_v4l_config_dev->vid_cap_dev);
	v4l2_device_put(&p_v4l_config_dev->v4l2_dev);
exit_ret:
	devm_kfree(&pdev->dev, p_v4l_config_dev);
	return ret;
}

static int armcb_v4l2_config_remove(struct platform_device *pdev)
{
	int ret = 0;
#ifdef CIX_V4L2_ADAPTER
	armcb_v4l2_config_dev_t *p_v4l_config_dev = platform_get_drvdata(pdev);
#endif

#if 0
#ifdef CONFIG_PLAT_BBOX
	cix_isp_rproc_rdr_unregister_core();
	cix_isp_rproc_rdr_unregister_exception();
#endif
#endif

	if (p_v4l_config_dev) {
		video_unregister_device(&p_v4l_config_dev->vid_cap_dev);
		v4l2_device_put(&p_v4l_config_dev->v4l2_dev);
		devm_kfree(&pdev->dev, p_v4l_config_dev);
	}
	p_v4l_config_dev = NULL;

	return ret;
}

static const struct of_device_id armcb_v4l2_config_dt_match[] = {
	{ .compatible = "armcb,config-i5", .data = &i5_isp_hw_info },
	{ .compatible = "armcb,config-i5-cus0", .data = &i5_cus0_isp_hw_info },
#ifndef ARMCB_CAM_DEBUG
	{ .compatible = "armcb,sky1-config-i7", .data = &i7_isp_hw_info },
#else
	{ .compatible = "armcb,config-i7", .data = &i7_isp_hw_info },
#endif
	{}
};
MODULE_DEVICE_TABLE(of, armcb_v4l2_config_dt_match);

static const struct acpi_device_id armcb_v4l2_config_acpi_match[] = {
	{ .id = "CIXH3020", .driver_data = (kernel_ulong_t)&i7_isp_hw_info },
	{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(acpi, armcb_v4l2_config_acpi_match);

static struct platform_driver armcb_v4l2_config_pdrv = {
	.probe = armcb_v4l2_config_probe,
	.remove = armcb_v4l2_config_remove,
	.driver = {
		.name = "armcb,config",
		.owner = THIS_MODULE,
		.of_match_table = armcb_v4l2_config_dt_match,
		.acpi_match_table = ACPI_PTR(armcb_v4l2_config_acpi_match),
	},
};

#ifndef ARMCB_CAM_KO
static int __init armcb_v4l2_config_init(void)
{
	return platform_driver_register(&armcb_v4l2_config_pdrv);
}

static void __exit armcb_v4l2_config_exit(void)
{
	platform_driver_unregister(&armcb_v4l2_config_pdrv);
}

module_init(armcb_v4l2_config_init);
module_exit(armcb_v4l2_config_exit);

MODULE_AUTHOR("Armchina Inc.");
MODULE_DESCRIPTION("Armcb isp video driver");
MODULE_LICENSE("GPL v2");
#else
static void *g_instance;

void *armcb_get_v4l2_cfg_driver_instance(void)
{
	if (platform_driver_register(&armcb_v4l2_config_pdrv) < 0) {
		LOG(LOG_ERR, "register v4l2 cfg driver failed.\n");
		return NULL;
	}
	g_instance = (void *)&armcb_v4l2_config_pdrv;
	return g_instance;
}

void armcb_v4l2_cfg_driver_destroy(void)
{
	if (g_instance)
		platform_driver_unregister(
			(struct platform_driver *)g_instance);
}
#endif
