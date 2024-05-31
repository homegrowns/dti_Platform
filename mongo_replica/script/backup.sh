#!/bin/bash
# mongo_backup join cron

touch /etc/cron.d/mongo_backup
echo '0 3 * * * /script/mongodump.sh >> /data/mongo_dump/mongodump.sh.log 2>&1' >>/etc/cron.d/mongo_backup
/usr/bin/chmod 644 /etc/cron.d/
/usr/bin/crontab /etc/cron.d/mongo_backup
/usr/sbin/cron -f
