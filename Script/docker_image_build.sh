#!/bin/bash

Airflow_image_build() {
    docker build -t ctilab/tensorflow_gpu:latest /data/PDTIAI_platform/DTIAI_AIRFLOW/Airflow_worker/tensorflowGPU/
    docker build -t ctilab/tensorflow_cpu:latest /data/PDTIAI_platform/DTIAI_AIRFLOW/Airflow_worker/tensorflowNonGpu/
    docker build -t ctilab/torch:latest /data/PDTIAI_platform/DTIAI_AIRFLOW/Airflow_worker/torch/
    docker build -t ctilab/airflow:2.8.0 /data/PDTIAI_platform/DTIAI_AIRFLOW/
}

Clickhouse_image_build() {
    docker build -t ctilab/clickhouse-server:23.4.2.11 /data/PDTIAI_platform/DTIAI_CLICKHOUSE/clickhouse/
    docker build -t ctilab/tabix:latest /data/PDTIAI_platform/DTIAI_CLICKHOUSE/tabix/
}

Util_image_build() {
    docker pull portainer/portainer:latest
    docker build -t ctilab/jupyterlab:latest /data/PDTIAI_platform/DTIAI_UTIL/Jupyterlab/
    docker build -t ctilab/health_check:latest /data/PDTIAI_platform/DTIAI_UTIL/Health_Check/
    docker build -t ctilab/health_check_alert:latest /data/PDTIAI_platform/DTIAI_UTIL/Health_Check_Alert/
}

Webdb_image_build() {
    docker build -t ctilab/mongo:6.0 /data/PDTIAI_platform/mongo_replica/
}

Webserver_image_build() {
    docker build -t ctilab/nginx:latest /data/PDTIAI_platform/DTIAI_WEB/
}

echo '------------------------------------------------------'
echo '                 1. Airflow image build               '
echo '                 2. Clickhouse image build            '
echo '                 3. UTIL image build                  '
echo '                 4. Webdb image build                 '
echo '                 5. Webserver image build             '
echo '                 6. ALL                               '
echo '------------------------------------------------------'

while true; do

    read -p " Enter the start image number: " number

    if [ $number -eq 1 ]; then

        echo 'start build...'
        Airflow_image_build
        echo 'build complete...'
        break

    elif [ $number -eq 2 ]; then

        echo 'start build...'
        Clickhouse_image_build
        echo 'build complete...'
        break

    elif [ $number -eq 3 ]; then

        echo 'start build...'
        Util_image_build
        echo 'build complete...'
        break

    elif [ $number -eq 4 ]; then

        echo 'start build...'
        Webdb_image_build
        echo 'build complete...'
        break

    elif [ $number -eq 5 ]; then

        echo 'start build...'
        Webserver_image_build
        echo 'build complete...'
        break

    elif [ $number -eq 6 ]; then

        echo 'start build...'
        Airflow_image_build
        Clickhouse_image_build
        Util_image_build
        Webdb_image_build
        Webserver_image_build
        echo 'build complete...'
        break

    else
        echo ' Invalid input. Please enter a image number. '

    fi
done
