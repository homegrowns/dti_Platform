FROM apache/airflow:2.8.0
USER root
RUN apt update && apt -y install vim && apt install -y net-tools && apt -y install procps && apt install -y curl && apt install dumb-init && apt clean 

USER "${AIRFLOW_UID:-50000}:0"
COPY requirements.txt /opt/airflow/requirements.txt

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN pip3 install --upgrade pip && pip3 install -r /opt/airflow/requirements.txt && rm /opt/airflow/requirements.txt