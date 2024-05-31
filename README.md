# PDTIAI_platform

## GPU server Docker settings

    Docker 설치 후 daemon.json 세팅

    {
    "data-root": "/var/lib/docker",
    "storage-driver": "overlay2",
    "group": "docker",
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m",
        "max-file": "30"
    }

    }

## Not GPU server Docker settings

    Docker 설치 후 daemon.json 세팅

    {
    "data-root": "/var/lib/docker",
    "storage-driver": "overlay2",
    "group": "docker",
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m",
        "max-file": "30"
    }

    }

## ubuntu server static ip setting(ubuntu 20.04)

    sudo vim /etc/netplan/~~.yml

    # This is the network config written by 'subiquity'
    network:
    ethernets:
        enp2s0:
        addresses:
        - 192.168.0.3/24 #IP 및 서브넷 설정
        nameservers:
            addresses:
            - 8.8.8.8
            - 8.8.4.4
            search: []
        routes:
        - to: default
            via: 192.168.0.1 #GATEWAY 설정
    version: 2

## disable ufw

    sudo systemctl disable ufw
    sudo systemctl stop ufw

## Network Interface RX, TX setting(rc.d setting)

    sudo apt update && apt install ethtool
    sudo ethtool -g $NIC_NAME #각 인터페이스 rx ,tx 최대 설정 확인
    sudo ethtool -G $NIC_NAME rx 4096(확인한 최댓값) tx 4096(확인한 최댓값)

    설정은 재부팅시 초기화되기 때문에 부팅 후 자동실행을 위하여 /etc/init.d or /etc/rc.local 에 등록 필요
    sudo vim /etc/rc.local #스크립트 내용 작성
    sudo chmod +x /etc/rc.local

    sudo vim /lib/systemd/system/rc-local.service
    ###
    [Install]
    WantedBy=multi-user.target
    ###
    위의 내용 추가

    sudo systemctl enable rc-local.service
    sudo systemctl start rc-local.service

## GPU driver dependency and cuda export environment variables

    @그래픽카드 확인
    sudo update-pciids
    lspci | grep VGA  || ls pci | grep NVIDIA

    sudo apt install -y gcc make

    vim ~/.bashrc

    CUDA 설치 후 밑의 내용 페이지 하단 복사, 붙여넣기
    export PATH
    export PATH=/usr/local/cuda/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/lib64:$LD_LIBRARY_PATH

    @cudnn 설치 후 세팅(cuda 버전은 세팅한 버전에 맞게 변경)
    tar xvzf cudnn-11.4-linux-x64-v8.2.2.26.tgz
    sudo cp cuda-11.4/include/cudnn* /usr/local/cuda/include
    sudo cp cuda-11.4/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda-11.4/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

    @cudnn 버전에 맞춰 라이브러리 버전 선택
    sudo ln -sf /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_adv_train.so.8.2.2 /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_adv_train.so.8
    sudo ln -sf /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8.2.2  /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8
    sudo ln -sf /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8.2.2  /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8
    sudo ln -sf /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8.2.2  /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8
    sudo ln -sf /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_ops_train.so.8.2.2  /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_ops_train.so.8
    sudo ln -sf /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.8.2.2 /usr/local/cuda-11.4/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.

    sudo ln -sf libcudnn.so.8.2.2 libcudnn.so.8
    sudo ln -sf libcudnn.so.8 libcudnn.so

    @cudnn 버전확인
    cat /usr/local/cuda-11.4/include/cudnn_version.h | grep CUDNN_MAJOR -A 2

## Clickhouse 및 MongDB 덤프 및 복원

    Clickhouse는 9번 서버의 /var/lib/docker/volumes/51af4fae691e88380f16414679e532c3d2725a1bb3ee819a2535c3a8a839c139/_data 디렉토리 압축 및 포팅 서버 /data/PDTIAI_PLATFORM/DTIAI_CLICKHOUSE/click_data 로 복원
    MongoDB는 9번서버의 덤프데이터로 복원 (Mongorestore)
    mongo_replica/mongo_key/mongo.key 파일에 chmod 400 mongo.key && sudo chown 999.999 mongo.key

## nvm 설치

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" \
    && nvm install 20.9.0 \
    && nvm alias default 20.9.0 \
    && npm install -g pm2 \
    && npm install -g yarn
# dti_Platform
