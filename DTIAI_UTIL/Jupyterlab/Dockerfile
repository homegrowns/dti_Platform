FROM tensorflow/tensorflow:2.16.1-gpu-jupyter

USER root
RUN apt update && apt install -y vim && apt install dumb-init && apt clean

RUN mkdir /workspace

COPY requirements.txt .
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
RUN pip3 install --upgrade pip && pip3 install --ignore-installed -r requirements.txt && rm requirements.txt
RUN /usr/local/bin/jupyter lab --generate-config
RUN echo c.NotebookApp.password = \'argon2:\$argon2id\$v=19\$m=10240,t=10,p=8\$VOdc1zwzn4iqNesG8m9gWA\$QepY3dLjNmiMfhev12e98rAuJxSK7H7j92GA2eO6JqY\' >>/root/.jupyter/jupyter_lab_config.py


WORKDIR /workspace
#ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

