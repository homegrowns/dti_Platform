FROM ubuntu/nginx:1.18-20.04_beta
USER root

RUN apt update && apt install -y vim && apt install -y net-tools && apt install -y procps && apt install -y ntp && apt install -y curl && apt install dumb-init && apt clean
RUN apt clean

#KST 설정
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/timezone && echo 'Asia/Seoul' > /etc/timezone

#nvm 설치 및 환경변수 설정
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" \
    && nvm install 20.9.0 \
    && nvm alias default 20.9.0 \
    && npm install -g pm2 \
    && npm install -g yarn


COPY ecosystem.config.js /data/ecosystem.config.js
COPY start.sh /start.sh
RUN chmod +x /start.sh