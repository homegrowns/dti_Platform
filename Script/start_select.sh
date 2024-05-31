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
echo '                 4. DTIAI_WEB                         '
echo '                 5. DTIAI_WEBDB                       '
echo '                 6. ALL                               '
echo '------------------------------------------------------'

while true; do

  read -p " Enter the start package number: " number

  if [ "$number" -eq 1 ]; then

    cd $DTIAI_CLICKHOUSE
    echo 'start deploying...'
    /usr/bin/docker stack deploy --compose-file clickhouse_server.yml data
    echo 'deploying done...'
    break

  elif [ "$number" -eq 2 ]; then

    cd $DTIAI_AIRFLOW
    echo 'start deploying...'
    /usr/bin/docker compose up -d
    echo 'deploying done...'
    break

  elif [ "$number" -eq 3 ]; then

    cd $DTIAI_UTIL
    echo 'start deploying...'
    /usr/bin/docker stack deploy --compose-file utils.yml util
    echo 'deploying done...'
    break

  elif [ "$number" -eq 4 ]; then

    echo 'start deploying...'
    /usr/bin/docker stack deploy --compose-file $DTIAI_WEB/DTIAI_WEB.yml web
    echo 'deploying done...'
    break

  elif [ "$number" -eq 5 ]; then

    echo 'start deploying...'
    chmod -R 777 $DTIAI_WEBDB/script
    /usr/bin/docker compose -f $DTIAI_WEBDB/mongo_replica.yml up -d
    echo 'deploying done...'
    break

  elif [ "$number" -eq 6 ]; then

    echo 'start deploying...'
    /usr/bin/docker stack deploy --compose-file $DTIAI_CLICKHOUSE/clickhouse_server.yml data
    /usr/bin/docker stack deploy --compose-file $DTIAI_AIRFLOW/docker-compose.yml airflow
    /usr/bin/docker stack deploy --compose-file $DTIAI_UTIL/utils.yml web
    chmod -R 777 $DTIAI_WEBDB/script && /usr/bin/docker stack deploy --compose-file $DTIAI_WEB/DTIAI_WEB.yml util
    /usr/bin/docker compose -f $DTIAI_WEBDB/mongo_replica.yml up -d
    echo 'deploying done...'
    break

  else
    echo ' Invalid input. Please enter a Package number. '

  fi
done
