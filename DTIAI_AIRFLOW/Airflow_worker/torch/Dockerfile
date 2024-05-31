FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

RUN apt update && apt install -y vim && apt install -y cron && apt install -y procps && apt clean
COPY requirements.txt .

RUN pip3 install --upgrade pip && pip3 install -r requirements.txt && rm requirements.txt