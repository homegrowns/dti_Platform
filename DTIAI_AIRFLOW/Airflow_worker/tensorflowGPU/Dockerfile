FROM tensorflow/tensorflow:2.13.0-gpu

USER root
RUN apt update && apt install -y vim && apt install -y cron && apt install -y procps && apt clean
COPY requirements.txt .

RUN pip3 install --upgrade pip && pip3 install -r requirements.txt && rm requirements.txt