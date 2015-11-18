#!/bin/bash
#此脚本使用在Android 各项处理上
#制作者：振云
if [[ ! $1 ]]; then
	echo -e "usage\n\t ./make_ota.sh origin_zip new_zip"
	exit
fi
. build/config.sh
./build/tools/releasetools/ota_from_target_files -i $1 -n -k ./build/security/testkey --override_device auto $2 output_ota.zip
