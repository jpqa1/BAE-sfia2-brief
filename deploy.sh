#!/bin/bash

# create network
docker network create dummy-proj-network

# build images
docker build -t proj-db database # database = Dockerfile loc dir
docker build -t proj-fe frontend
docker build -t proj-be backend

# run database container
docker run -d \
    --network dummy-proj-network \
    --name mysql proj-db

# run backend app
docker run -d \
    --network dummy-proj-network \
    --name backend proj-be

# run frontend app
docker run -d \
    --network dummy-proj-network \
    --name frontend proj-fe

# run nginx container
docker run -d \
    --network dummy-proj-network \
    --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf \
    --p 80:80 \
    --name nginx \
    nginx:alpine


docker ps -a