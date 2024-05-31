#/bin/bash
# root 권한으로 실행

OS_CHECK="$(cat /proc/version)"
GPU_CHECK="$(lspci | grep NVIDIA | wc -l)"

if [[ "$OS_CHECK" =~ "ubuntu" ]] || [[ "$OS_CHECK" =~ "Ubuntu" ]]; then
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    sudo service docker restart
    echo "Docker for Ubuntu download complete!"

elif [[ "$OS_CHECK" =~ "centos" ]] || [[ "$OS_CHECK" =~ "rocky" ]]; then
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo usermod -aG docker $USER
    sudo service docker restart
    echo "Docker for CentOS download complete!"
else
    echo "Check OS version is ubuntu or centos"
fi

if [ "$GPU_CHECK" -eq 0 ]; then

    sudo cat <<EOF >/etc/docker/daemon.json
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
EOF

    sudo systemctl restart docker
    echo "Docker daemon setting complete!!"

elif [ "$GPU_CHECK" -ne 0 ]; then

    distribution=$(
        . /etc/os-release
        echo $ID$VERSION_ID
    )
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt update && apt install -y nvidia-container-toolkit
    sudo systemctl restart docker

    sudo cat <<EOF >/etc/docker/daemon.json
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
EOF

    sudo systemctl restart docker
    echo "Docker daemon setting complete!!"
else
    echo "Check whether Docker is installed"
fi
