#!/usr/bin/env bash

#  Copyright 2024 Cix Technology Group Co., Ltd.
#  All Rights Reserved.
#
#  The following programs are the sole property of Cix Technology Group Co., Ltd.,
#  and contain its proprietary and confidential information.
#

do_build() {
    #dpu-ddk
    pkg_Name="cix-dpu-ddk"

    if [[ "${EX_CUSTOMER:-default}" == "default" ]]; then
        rm -rf ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
        cp -r ${PATH_OUT_PRIVATE_DEB_PACKAGES}/${pkg_Name} ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
        create_cix_deb "$pkg_Name"
    fi

    if [[ "${DOCKER_MODE}" != "docker" ]]; then
        #npu-umd
        pkg_Name="cix-npu-umd"
        if [[ "${EX_CUSTOMER:-default}" == "default" ]]; then
            rm -rf ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
            cp -r ${PATH_OUT_PRIVATE_DEB_PACKAGES}/${pkg_Name} ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
            create_cix_deb "$pkg_Name"
        fi

        #npu-noe-umd
        pkg_Name="cix-noe-umd"
        rm -rf ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
        cp -r ${PATH_OUT_PRIVATE_DEB_PACKAGES}/${pkg_Name} ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
        create_cix_deb "$pkg_Name"

        #isp-umd
        pkg_Name="cix-isp-umd"
        rm -rf ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
        cp -r ${PATH_OUT_PRIVATE_DEB_PACKAGES}/${pkg_Name} ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
        create_cix_deb "$pkg_Name"
    fi

    #gpu
    pkg_Name="cix-gpu-umd"
    rm -rf ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
    cp -r ${PATH_OUT_PRIVATE_DEB_PACKAGES}/${pkg_Name} ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
    if [[ -e "${PATH_ROOT}/debian12/script/99-cma-device.rules" ]]; then
        mkdir -p ${PATH_OUT_DEB_PACKAGES}/$pkg_Name/lib/udev/rules.d
        cp -fp "${PATH_ROOT}/debian12/script/99-cma-device.rules" ${PATH_OUT_DEB_PACKAGES}/$pkg_Name/lib/udev/rules.d
    fi
    build_deb_dir=${PATH_OUT_DEB_PACKAGES}/$pkg_Name
    if [ ! -e $build_deb_dir/etc/systemd/system ]; then
        mkdir -p $build_deb_dir/etc/systemd/system
    fi
    cat > $build_deb_dir/etc/systemd/system/load-modules.service <<- EOF
[Unit]
Description=Load custom kernel modules

[Service]
Type=oneshot
ExecStart=/usr/bin/load-modules.sh
RemainAfterExit=yes

[Install]
WantedBy=sysinit.target
EOF
    if [[ "$BOARD" == "evb" ]]; then
        if [ ! -e $build_deb_dir/usr/bin ]; then
            mkdir -p $build_deb_dir/usr/bin
        fi
        cat > $build_deb_dir/usr/bin/load-modules.sh <<- EOF
#!/bin/bash
insmod /lib/modules/$linux_version/kernel/net/wireless/cfg80211.ko
insmod /lib/modules/$linux_version/extra/protected_memory_allocator.ko
insmod /lib/modules/$linux_version/extra/memory_group_manager.ko
insmod /lib/modules/$linux_version/extra/mali_kbase.ko
insmod /lib/modules/$linux_version/extra/rtl_btusb.ko
insmod /lib/modules/$linux_version/extra/rtl_wlan.ko
insmod /lib/modules/$linux_version/extra/aipu.ko
insmod /lib/modules/$linux_version/extra/amvx.ko
insmod /lib/modules/$linux_version/kernel/drivers/hid/uhid.ko

insmod /lib/modules/$linux_version/kernel/net/netfilter/x_tables.ko
insmod /lib/modules/$linux_version/kernel/net/ipv4/netfilter/ip_tables.ko
insmod /lib/modules/$linux_version/kernel/net/ipv4/netfilter/iptable_nat.ko
insmod /lib/modules/$linux_version/kernel/net/ipv4/netfilter/nf_defrag_ipv4.ko
insmod /lib/modules/$linux_version/kernel/net/ipv6/netfilter/nf_defrag_ipv6.ko
insmod /lib/modules/$linux_version/kernel/lib/libcrc32c.ko
insmod /lib/modules/$linux_version/kernel/net/netfilter/nf_conntrack.ko
insmod /lib/modules/$linux_version/kernel/net/netfilter/nf_nat.ko
insmod /lib/modules/$linux_version/kernel/net/netfilter/xt_MASQUERADE.ko

ln -s /dev/dma_heap/reserved /dev/dma_heap/linux,cma

if [[ ! -s  /etc/machine-id ]]; then
dbus-uuidgen > /var/lib/dbus/machine-id
ln -sf /var/lib/dbus/machine-id /etc/machine-id
fi



EOF
        cat >> $build_deb_dir/usr/bin/load-modules.sh <<- 'EOF'
video_devices=($(ls /dev/video* 2>/dev/null | sort -V))

if [ ${#video_devices[@]} -eq 1 ]; then
ln -s "${video_devices[0]}" /dev/video-cixdec0
elif [ ${#video_devices[@]} -eq 0 ]; then
echo "Not found /dev/video*"
else
max_device="${video_devices[-2]}"
ln -s "$max_device" /dev/video-cixdec0
fi
EOF

    else
        cat > $build_deb_dir/usr/bin/load-modules.sh <<- EOF
#!/bin/bash

insmod /lib/modules/$linux_version/extra/protected_memory_allocator.ko
insmod /lib/modules/$linux_version/extra/memory_group_manager.ko
insmod /lib/modules/$linux_version/extra/mali_kbase.ko
EOF
    fi
    chmod a+x $build_deb_dir/usr/bin/load-modules.sh
    if [[ ! -e $build_deb_dir/DEBIAN ]]; then
        mkdir -p $build_deb_dir/DEBIAN
    fi
    cat > $build_deb_dir/DEBIAN/postinst <<- EOF
#!/bin/sh
set -e

# Enable the service to start on boot
systemctl enable load-modules.service || true

exit 0
EOF
    cat > $build_deb_dir/DEBIAN/triggers <<- EOF
activate-noawait ldconfig
EOF
    cat > $build_deb_dir/DEBIAN/shlibs <<- EOF
libgbm 1 cix-gpu-umd (>= 1.0.0-1)
EOF
    chmod a+x $build_deb_dir/DEBIAN/postinst
    if [[ "${EX_CUSTOMER:-default}" == "default" ]]; then
        if [[ -e $PATH_OUT_DEB_PACKAGES/cix-gpu-test ]]; then
            rm -rf $PATH_OUT_DEB_PACKAGES/cix-gpu-test
        fi
        mkdir -p $PATH_OUT_DEB_PACKAGES/cix-gpu-test/usr/share
        if [[ -e $build_deb_dir/usr/share/cix ]]; then
            mv $build_deb_dir/usr/share/cix $PATH_OUT_DEB_PACKAGES/cix-gpu-test/usr/share
        fi
        create_cix_deb "cix-gpu-test"
    fi
    create_cix_deb "$pkg_Name"

    #dsp
    pkg_Name="cix-audio-dsp"
    rm -rf ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
    cp -r ${PATH_OUT_PRIVATE_DEB_PACKAGES}/${pkg_Name} ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
    create_cix_deb "$pkg_Name"

    if [[ "${DOCKER_MODE}" != "docker" ]]; then
        #hdcp
        pkg_Name="cix-hdcp2"
        if [[ "${EX_CUSTOMER:-default}" == "default" ]]; then
            rm -rf ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
            cp -r ${PATH_OUT_PRIVATE_DEB_PACKAGES}/${pkg_Name} ${PATH_OUT_DEB_PACKAGES}/$pkg_Name
            create_cix_deb "$pkg_Name"
        fi
    fi
}
do_clean() {
  rm -rf ${PATH_DEB}/cix-hdcp2*.deb
  rm -rf ${PATH_DEB}/cix-audio*.deb
  rm -rf ${PATH_DEB}/cix-gpu-umd*.deb
  rm -rf ${PATH_DEB}/cix-isp-umd*.deb
  rm -rf ${PATH_DEB}/cix-npu-umd*.deb
  rm -rf ${PATH_DEB}/cix-noe-umd*.deb
  rm -rf ${PATH_DEB}/cix-dpu-ddk*.deb
}
source "$(dirname ${BASH_SOURCE[0]})/framework.sh"
