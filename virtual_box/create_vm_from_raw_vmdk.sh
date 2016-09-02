#!/usr/bin/env bash
# Created by paincompiler on 2016/08/31
# © 2016 PAINCOMPILER All RIGHTS RESERVED.

##########settings##########
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o xtrace
##########settings##########

echo -n "Choose the source raw disk"
if command -v diskutil >/dev/null 2>&1; then
    diskutil list
else
    fdisk -l
fi
read -e RAWDISK
echo -n "Umounting target disk"
if command -v diskutil >/dev/null 2>&1; then
    diskutil umountDisk $RAWDISK
else
    umount $RAWDISK
fi
echo -n "Input the full file path of the vmdk file:"
read -e FILENAME 
if [ ! -f $FILENAME ]; then
    echo -n  "Creating new raw vmdk..."
else
    echo -n "Overwritting raw vmdk..."
    rm $FILENAME
fi
VBoxManage internalcommands createrawvmdk -filename $FILENAME -rawdisk $RAWDISK
if command -v diskutil >/dev/null 2>&1; then
    diskutil umountDisk $RAWDISK
else
    umount $RAWDISK
fi
echo -n "Name your VM"
read -e VMNAME
echo -n "Choose the OS types:"
VBoxManage list ostypes
read -e OSTYPE
VBoxManage createvm --name $VMNAME --ostype $OSTYPE --register
VBoxManage storagectl $VMNAME --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach $VMNAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $FILENAME
echo -n "Input the memory size, for example 1024"
read -e MEMSIZE
echo -n "Input the vram size, for example 128"
read -e VRAMSIZE
VBoxManage modifyvm $VMNAME --memory $MEMSIZE --vram $VRAMSIZE
VBoxManage modifyvm $VMNAME --boot1 disk --boot2 none --boot3 none --boot4 none
echo -n "Attach the network adapter to:"
echo -n "nat bridged internal host-only"
read -e ADAPTER
VBoxManage modifyvm $VMNAME --nic1 $ADAPTER 
read -p "Start the VM?Y/N " -n 1 -r
echo    
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
read -p "Start the VM headless?Y/N " -n 1 -r
echo    
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    VBoxManage startvm $VMNAME
fi
VBoxHeadless -s $VMNAME
