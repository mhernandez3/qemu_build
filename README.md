# QEMU BUILD

## DEPENDENCIES
* docker
* qemu-system-x86_64
* build essentials for linux kernel

### DOCKER 
Docker is used to build the initramfs

### LINUX
we build version 5.10 of linux kernel for example

## BUILD_QEMU.sh
Assuming that dependencies are there the script should build and run an entire 
linux kernel with OS sayinig hello world when booted.
