#!/bin/bash

# colorize and add text parameters
grn=$(tput setaf 2)             # green
yellow=$(tput setaf 3)          # yellow
bldgrn=${txtbld}$(tput setaf 2) # bold green
red=$(tput setaf 1)             # red
txtbld=$(tput bold)             # bold
bldblu=${txtbld}$(tput setaf 4) # bold blue
blu=$(tput setaf 4)             # blue
txtrst=$(tput sgr0)             # reset
blink=$(tput blink)             # blink

KERNEL_NAME="~Radioactive"
INCREMENTAL_VERSION="V1.0.7"
export LOCALVERSION="${KERNEL_NAME}-${INCREMENTAL_VERSION}"
export KBUILD_BUILD_USER=acuicultor
export KBUILD_BUILD_HOST=NuclearPowerPlant
export PATH=$PATH:/home/acuicultor/Android/toolchains/aarch64-linux-gnu-linaro7.3.1/bin
export CROSS_COMPILE=aarch64-linux-gnu-

# Functions
function clean_all {
		       make ARCH=arm64 distclean
               rm -rf out/
               mkdir out
}

function make_kernel {
		      echo
		      make ARCH=arm64 O=out radioactive_defconfig 
              make ARCH=arm64 O=out -j5
}

DATE_START=$(date +"%s")

echo -e "${bldgrn}"
echo "                                                    ";
echo "  Vamos a compilar Radioactive Kernel...        ";
echo "                                                    ";
echo -e "${txtrst}"

echo

while read -p "Quieres hacer compilacion limpia? (s/n)? " cchoice
do
case "$cchoice" in
	s|S )
		clean_all
		echo
		echo "Todo limpio!!."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Que te has fumado? prueba otra vez!"
		echo
		;;
esac
done

echo

while read -p "Quieres compilar?" dchoice
do
case "$dchoice" in
	s|S )
		make_kernel
        break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Que te has fumado? prueba otra vez!"
		echo
		;;
esac
done


echo -e "${bldgrn}"
echo "-------------------"
echo "Build Completado en:"
echo "-------------------"
echo -e "${txtrst}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minuto(s) and $(($DIFF % 60)) segundos."
echo
