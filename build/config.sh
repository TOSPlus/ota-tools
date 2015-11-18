#!/bin/bash 
echo "config.sh"
#set build config, export env

export PORT_ROOT=${PWD}
export FURNACE_OUT_DIR=${PORT_ROOT}/out

export BUILD_DIR=${PORT_ROOT}/build
export TOOLS_DIR=${PORT_ROOT}/build/tools

if [[ -n "${DEFAULT_SYSTEM_DEV_CERTIFICATE}"  ]];then
    export KEY_DIR=$(dirname ${DEFAULT_SYSTEM_DEV_CERTIFICATE})
else
    export KEY_DIR=${PORT_ROOT}/build/security
    export DEFAULT_SYSTEM_DEV_CERTIFICATE=${KEY_DIR}/testkey
fi

export APKTOOL_JAR=${TOOLS_DIR}/apktool-2.0.0rc2.jar
export SMALI_JAR=${TOOLS_DIR}/smali-2.0.3.jar
export BAKSMALI_JAR=${TOOLS_DIR}/baksmali-2.0.3.jar
export SIGNAPK_JAR=${TOOLS_DIR}/signapk.jar

export ZIPALIGN=${TOOLS_DIR}/zipalign
export MKBOOTIMG=${TOOLS_DIR}/mkbootimg
export FIX_PLURAL=${TOOLS_DIR}/fix_plurals.sh
export RM_LINE=${TOOLS_DIR}/rmline.sh
export SIGN_APK=${TOOLS_DIR}/sign_apk.sh
export OTA_FROM_TARGET_FILES=${TOOLS_DIR}/releasetools/ota_from_target_files
export SIGN_TARGET_FILES_APKS=${TOOLS_DIR}/releasetools/sign_target_files_apks

export DEVICE_OUT_DIR=${FURNACE_OUT_DIR}/${DEVICE}
export STOCK_ROM_ZIP=stock_rom.zip
export STOCK_ROM_DIR=${DEVICE_OUT_DIR}/stock

export PATCH_DIR=${DEVICE_OUT_DIR}/patch
export RELEASE_DIR=${DEVICE_OUT_DIR}/release

export TARGET_FILES_TEMPLATE_DIR=${TOOLS_DIR}/target_files_template
export DEVICE_META_DATA_DIR=${DEVICE_DIR}/target_files/META
export DEVICE_DIR_TEMPLATE=${TOOLS_DIR}/device_dir_template

export REMOVED_FILE_LIST=${DEVICE_DIR}/removed_file_list
export INC_OTA_TARGET_DIR=${DEVICE_DIR}/ota_target_files

export DEVICE_RES_TAG=${DEVICE}

HAS_CONFLICTS="false"
OVERRIDE_DEVICE="--override_device auto"

if [[ -f ${TOOLS_DIR}/function.sh ]];then
    . ${TOOLS_DIR}/function.sh
fi

if [[ -f ${DEVICE_DIR}/config.sh ]];then
    . ${DEVICE_DIR}/config.sh
fi

. ${BUILD_DIR}/setup_jdk.sh

if [[ ${PATH} != *${TOOLS_DIR}* ]];then
    export PATH=${PATH}:${TOOLS_DIR}:${TOOLS_DIR}/releasetools
fi

if [[ ${APKTOOL_JAR} == *-2.* ]]; then
    DEVICE_RES_TAG_ARG="-t ${DEVICE_RES_TAG}"
else
    DEVICE_RES_TAG_ARG=${DEVICE_RES_TAG}
fi

if [[ -f ${DEVICE_DIR}/releasetools.py ]];then
    export QROM_DEVICE_RELEASETOOLS="-s ${DEVICE_OUT_DIR}/releasetools.py"
else
    export QROM_DEVICE_RELEASETOOLS=
fi

