FROM python:3.10.12

RUN apt update && apt install -y cron && apt install -y vim && apt install dumb-init && apt clean
RUN mkdir -p /home/ctilab

COPY healthchecker.py /home/ctilab
COPY gpu_util_custom.py /home/ctilab
COPY requirements.txt .
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
RUN pip install -r requirements.txt

WORKDIR /home/ctilab
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]





