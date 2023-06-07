#!/bin/bash

echo "开始同步Anyernel3，请确保你的网络是否可靠。"

if [ -d KernelSU ]; then
    echo "找到了同步过的KernelSU，请问是否同步为最新版？"
    read -p "如果同步请输入Y，不同步则输入N: " input

    if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
        rm -rf driver/kernelsu
        curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
    elif [ "$input" = "N" ] || [ "$input" = "n" ]; then
        echo "脚本已终止"
    else
        echo "无效的输入"
    fi

else
    echo "未发现KernelSU，将同步。"
    curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
fi
