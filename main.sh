docker image remove primary-db
docker image remove secondary-db


docker rm -f primary-db
docker rm -f secondary-db
docker build -t primary-db ./primary
docker build -t secondary-db ./secondary
docker run -d --name primary-db --network postgres -p 5001:5432 -v ${PWD}/primary/pgdata:/data -v ${PWD}/primary/config:/config -v ${PWD}/primary/archive:/mnt/server/archive primary-db

docker run -d --name secondary-db --network postgres -p 5002:5432 -v ${PWD}/secondary/pgdata:/data -v ${PWD}/secondary/config:/config -v ${PWD}/secondary/archive:/mnt/server/archive secondary-db

docker network create postgres

docker exec -it primary-db bash
createuser -U admin -P -c 5 --replication replicationUser
psql --username=admin primarydb



docker run -it --rm --net postgres -v ${PWD}/secondary/pgdata:/data --entrypoint /bin/bash postgres:13

pg_basebackup -h primary-db -p 5432 -U replicationUser -D /data/ -Fp -Xs -R


docker exec -it primary-db psql -U admin -d postgresdb

docker exec -it secondary-db psql -U admin -d postgresdb
