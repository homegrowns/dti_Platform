#!/bin/sh
# file-name: unas_cron.sh
# NIC 명은 장비 인터페이스 설정에 따라 변경

DATE=$(date -d now)
PROC_XDOS=$(ps -ef | grep xdo[s] | wc -l)
PROC_XSMTP=$(ps -ef | grep xsmt[p] | wc -l)
XSMTP_PID=$(ps -ef | grep xsmt[p] | awk '{print $2}')
NIC1= ens2f0
NIC2= ens2f1
NIC3= ens5f0

if [ $PROC_XDOS -eq 0 ]; then

    /unas/xdos -reboot
    echo "$DATE UNAS XDOS rebooted"

else
    echo "$DATE UNAS XDOS IS HEALTHY!!"

fi

if [ $PROC_XSMTP -ne 3 ]; then

    kill -9 $XSMTP_PID
    /unas/xsmtp -Ci $NIC1 file &
    /unas/xsmtp -Ci $NIC2 file &
    /unas/xsmtp -Ci $NIC3 file &
    echo "$DATE UNAS XSMTP rebooted"

else

    echo "$DATE UNAS XSMTP IS HEALTHY!!"

fi
