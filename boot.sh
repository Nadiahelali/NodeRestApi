#!/bin/bash
set -e

printf "creating network --->\n"
docker network create restless-api;
printf "network created --->\n"

printf "\n"

printf "starting mongo container --->\n"
docker container run \
    --detach \
    --name=mongo \
    --network=restless-api \
    mongo;
printf "mongo container started --->\n"

printf "\n"

cd mongo-express;
printf "starting mongo-express container --->\n"
docker container run \
    --detach \
    --name=mongo-express \
    --network=restless-api \
    --publish=8081:8081
    mongo-express;
printf "mongo-express container started --->\n"

cd ..
printf "\n"

cd app;
printf "creating api image --->\n"
docker image build . --tag node-api;
printf "api image created --->\n"
printf "starting api container --->\n"
docker container run \
    --detach \
    --name=app \
    --env DB_CONNECT=mongodb://mongo:27017/posts\
    --network=restless-api \
    --depends_on=mongo
    node-api;
printf "api container started --->\n"


cd ..
printf "\n"

printf "all containers are up and running"