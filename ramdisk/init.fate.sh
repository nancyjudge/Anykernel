#!/system/bin/sh

sysctl -e -w kernel.random.read_wakeup_threshold=64 2>/dev/null
sysctl -e -w kernel.random.write_wakeup_threshold=128 2>/dev/null

echo "0" > /dev/stune/foreground/schedtune.boost
echo "10" > /dev/stune/top-app/schedtune.boost
echo "0" > /dev/stune/background/schedtune.boost

echo "0" > /dev/stune/foreground/schedtune.sched_boost
echo "10" > /dev/stune/top-app/schedtune.sched_boost
echo "0" > /dev/stune/background/schedtune.sched_boost

setprop dalvik.vm.heapminfree 2m

echo "wlan_pno_wl;wlan_ipa;wcnss_filter_lock;[timerfd];hal_bluetooth_lock;IPA_WS;sensor_ind;wlan;netmgr_wl;qcom_rx_wakelock;wlan_wow_wl;wlan_extscan_wl;" > /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker

for i in $(ls /sys/class/scsi_disk/); do
 echo "temporary none" > /sys/class/scsi_disk/"$i"/cache_type;
done
