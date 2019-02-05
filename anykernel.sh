# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string= FateKernel by @botnancy
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=vince
device.name2=Redmi Note 5
device.name3=Redmi note 5 plus
device.name4=
device.name5=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.rc
insert_line init.rc 'fate' before 'on early-init' 'import /init.fate.rc';

# zram
insert_line fstab.qcom "/dev/block/zram0" after "/dev/block/bootdevice/by-name/config		/frp			emmc	defaults							defaults" "/dev/block/zram0                                        none                swap    defaults                    zramsize=536870912,max_comp_streams=2"

# end ramdisk changes

write_boot;

## end install

