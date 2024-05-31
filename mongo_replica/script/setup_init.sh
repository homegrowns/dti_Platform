#!/bin/sh

mongodb_1="211.115.206.18:27017"
mongodb_2="211.115.206.18:27018"
mongodb_3="211.115.206.18:27019"

echo "Waiting for MongoDB startup.."
until [ "$(mongosh --host $mongodb_1 -u ctilab -p ctilab@!09 --eval "printjson(db.serverStatus())" | grep uptime | head -1)" ]; do
    printf '.'
    sleep 1
done

echo $(mongosh --host $mongodb_1 -u ctilab -p ctilab@!09 --eval "printjson(db.serverStatus())" | grep uptime | head -1)
echo "MongoDB Started.."

echo SETUP.sh time now: $(date +"%T")
mongosh --host $mongodb_1 <<EOF
   var rootUser = 'ctilab';
   var rootPassword = 'ctilab@!09';
   var admin = db.getSiblingDB('admin');
   admin.auth(rootUser, rootPassword);

   var cfg = {
        "_id": "MongoReplicaSet",
        "members": [
            {
                "_id": 0,
                "host": "$mongodb_1",
            },
            {
                "_id": 1,
                "host": "$mongodb_2",
            },
            {
                "_id": 2,
                "host": "$mongodb_3",
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.status();
EOF
