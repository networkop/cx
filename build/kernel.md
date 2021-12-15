# How to build a kernel image

```
qemu-img convert -f qcow2 -O raw cumulus-linux-5.0.0-vx-amd64-qemu.qcow2 cumulus.raw
```

```
fdisk -l cumulus.raw                                                                                                                            
Disk cumulus.raw: 6 GiB, 6442450944 bytes, 12582912 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A320440B-68C2-47CB-A3FE-50C873D30338

Device        Start      End  Sectors  Size Type
cumulus.raw1   2048     6143     4096    2M BIOS boot
cumulus.raw2   6144   268287   262144  128M ONIE boot
cumulus.raw3 268288   530431   262144  128M Linux filesystem
cumulus.raw4 530432 12582878 12052447  5.8G Linux filesystem
```

```
sudo losetup -f -P cumulus.raw

ls -1 /dev/loop0*                                                                                                                               
/dev/loop0
/dev/loop0p1
/dev/loop0p2
/dev/loop0p3
/dev/loop0p4

sudo mount /dev/loop0p4 /mnt/cx
```

```
cd build/
cp /mnt/cx/
cp /mnt/cx/boot/vmlinuz-* .
mkdir lib
cp -au /mnt/cx/lib/modules lib
```


```
./extract-vmlinuz.sh vmlinuz-4.19.0-cl-1-amd64 > vmlinux
```

```
docker build -t networkop/cl-kernel:5.0.0 .
```