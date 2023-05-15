#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

git clone https://github.com/torvalds/linux.git
cp general_config $SCRIPT_DIR/linux/.config

cd $SCRIPT_DIR/linux
git checkout v5.10
make -j $(nproc) bzImage

cd $SCRIPT_DIR

if [[ -d "$SCRIPT_DIR/basic_initramfs" ]];
then
	echo "already exists"
else
	git clone https://github.com/ntegan/basic_initramfs.git
	sed -i '64i echo "Hello World"' $SCRIPT_DIR/basic_initramfs/misc/init_template
fi
cd $SCRIPT_DIR/basic_initramfs
sudo chmod u+x $SCRIPT_DIR/basic_initramfs/0_build_initramfs.sh
$SCRIPT_DIR/basic_initramfs/0_build_initramfs.sh

qemu-system-x86_64 -kernel $SCRIPT_DIR/linux/arch/x86_64/boot/bzImage -initrd $SCRIPT_DIR/basic_initramfs/output/initramfs.cpio
