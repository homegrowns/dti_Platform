FROM ghcr.io/mlflow/mlflow

RUN apt update && apt install -y procps && apt install -y net-tools && apt install -y cron && apt install -y vim

WORKDIR /data/mlflow

COPY wait_for_it.sh /data/mlflow/
RUN chmod +x /data/mlfow/wait_for_it.sh