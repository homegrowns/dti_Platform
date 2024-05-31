#!/bin/sh

DATE=$(date "+%Y%m%d" -d '1 day ago')

mkdir -p /data/mongo_dump/$DATE
/usr/bin/mongodump -u ctilab -p 'ctilab@!09' -o /data/mongo_dump/$DATE/
