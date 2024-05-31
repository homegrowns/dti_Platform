FROM clickhouse/clickhouse-server:23.4.2.11
USER root
RUN apt update && apt install -y vim && apt install -y procps && apt -y install curl && apt install net-tools && apt install dumb-init && apt clean


USER clickhouse
CMD ["/usr/bin/clickhouse-server", "--config-file=/etc/clickhouse-server/config.xml"]
