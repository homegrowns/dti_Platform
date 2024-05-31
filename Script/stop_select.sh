#!/bin/sh
# file-name: start_select.sh

DTIAI_CLICKHOUSE="/data/PDTIAI_platform/DTIAI_CLICKHOUSE"
DTIAI_AIRFLOW="/data/PDTIAI_platform/DTIAI_AIRFLOW"
DTIAI_UTIL="/data/PDTIAI_platform/DTIAI_UTIL"
DTIAI_WEB="/data/PDTIAI_platform/DTIAI_WEB"
DTIAI_WEBDB="/data/PDTIAI_platform/mongo_replica"

echo '------------------------------------------------------'
echo '                 1. DTIAI_CLICKHOUSE                  '
echo '                 2. DTIAI_AIRFLOW                     '
echo '                 3. DTIAI_UTIL                        '
echo '                 4. DTIAI_WEB                        '
echo '                 5. DTIAI_WEBDB                        '
echo '                 6. ALL                               '
echo '------------------------------------------------------'

while true; do

        read -p " Enter the stop package number: " number

        if [ $number -eq 1 ]; then

                echo 'Start delete...'
                /usr/bin/docker stack rm data
                echo 'Delete completed...'
                break

        elif [ $number -eq 2 ]; then

                echo 'Start delete...'
                /usr/bin/docker-compose -f $DTIAI_AIRFLOW/docker-compose.yaml down
                echo 'Delete completed...'
                break
        elif [ $number -eq 3 ]; then

                echo 'Start delete...'
                /usr/bin/docker stack rm util
                echo 'Delete completed...'
        elif [ $number -eq 4 ]; then

                echo 'Start delete...'
                /usr/bin/docker stack rm web
                echo 'Delete completed...'
        elif [ $number -eq 5 ]; then

                echo 'Start delete...'
                /usr/bin/docker compose -f $DTIAI_WEBDB/mongo_replica.yml down
                echo 'Delete completed...'
                break
        elif [ $number -eq 6 ]; then

                echo 'Start delete...'
                /usr/bin/docker stack rm data
                /usr/bin/docker-compose -f $DTIAI_AIRFLOW/docker-compose.yaml down
                /usr/bin/docker stack rm web
                /usr/bin/docker stack rm util
                /usr/bin/docker compose -f $DTIAI_WEBDB/mongo_replica.yml down
                echo 'Delete completed...'
                break
        else
                echo ' Invalid input. Please enter a Package number. '

        fi
done
