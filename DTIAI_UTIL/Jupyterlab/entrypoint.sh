#!/bin/sh
#password = ctilab@!09

echo c.NotebookApp.password = \'argon2:\$argon2id\$v=19\$m=10240,t=10,p=8\$VOdc1zwzn4iqNesG8m9gWA\$QepY3dLjNmiMfhev12e98rAuJxSK7H7j92GA2eO6JqY\' >>/root/.jupyter/jupyter_lab_config.py

jupyter lab --ip 0.0.0.0 --port 8780 --notebook-dir=/workspace --allow-root &
