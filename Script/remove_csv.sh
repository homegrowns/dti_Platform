#/bin/bash
# mtime 옵션에 기간 설정

find /xdb/csvfile -name "*" -mtime +6 -exec rm -f {} \;
