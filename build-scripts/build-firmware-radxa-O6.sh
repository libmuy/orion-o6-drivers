#!/usr/bin/env bash

export  BOLD="\e[1m"
export  NORMAL="\e[0m"
export	RED="\e[31m"
export	GREEN="\e[32m"
export	YELLOW="\e[33m"
export  BLUE="\e[94m"
export  CYAN="\e[36m"

readonly DO_DESC_build="build uefi"
do_build() {
    set +u
    local path_uefi="${PATH_ROOT}/bsp/uefi_release"
    local open_firmwre_build_script="${path_uefi}/edk2-non-osi/Platform/CIX/Sky1/PackageTool/build_and_package.sh"

    cd "${path_uefi}"

    if [[ ! -e "${open_firmwre_build_script}" ]]; then
        echo -e "${RED}There is no ${open_firmwre_build_script}!${NORMAL}"
        exit 1
    fi

    ${open_firmwre_build_script} O6

    if [[ ! -e "${path_uefi}/output/cix_flash_all.bin" ]]; then
        echo -e "${RED}Generate ${path_uefi}/output/cix_flash_all.bin failed!${NORMAL}"
    fi

    if [[ ! -e "${path_uefi}/output/cix_flash_ota.bin" ]]; then
        echo -e "${RED}Generate ${path_uefi}/output/cix_flash_ota.bin failed!${NORMAL}"
    fi

    cp "${path_uefi}/output/cix_flash_all.bin" "${PATH_OUT}/images/cix_flash_all_O6.bin"
    cp "${path_uefi}/output/cix_flash_ota.bin" "${PATH_OUT}/images/cix_flash_ota_O6.bin"

    echo -e "${GREEN}Generate ${PATH_OUT}/images/cix_flash_all.bin successful!${NORMAL}"

    cd -
}

readonly DO_DESC_clean="clean uefi"
do_clean() {
    echo "clean uefi"

    local path_uefi="${PATH_ROOT}/bsp/uefi_release"

    if [ -e "${path_uefi}/edk2/BaseTools/Source/C/bin" ]; then
        make -C "${path_uefi}/edk2/BaseTools" clean
    fi

    rm -f "${PATH_OUT}/SKY1_BL33_UEFI.fd"
    rm -rf "${path_uefi}/Build"
}

source "$(dirname ${BASH_SOURCE[0]})/framework.sh"
