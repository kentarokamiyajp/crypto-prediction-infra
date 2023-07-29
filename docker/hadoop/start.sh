#!/bin/bash

DOCKER_COMPOSE_FILE=docker-compose.yml

SCRIPT_PATH=$(
    cd $(dirname $0)
    pwd
)
docker-compose -f ${SCRIPT_PATH}/${DOCKER_COMPOSE_FILE} down
docker-compose -f ${SCRIPT_PATH}/${DOCKER_COMPOSE_FILE} pull
sleep 5

docker-compose -f ${SCRIPT_PATH}/${DOCKER_COMPOSE_FILE} up -d --build namenode datanode resourcemanager nodemanager historyserver
sleep 5
docker-compose -f ${SCRIPT_PATH}/${DOCKER_COMPOSE_FILE} up -d hive-server hive-metastore hive-metastore-postgresql
sleep 5
docker-compose -f ${SCRIPT_PATH}/${DOCKER_COMPOSE_FILE} up -d spark-master spark-worker
sleep 15

docker exec -it namenode bash -c 'hdfs dfsadmin -safemode leave && hdfs dfs -mkdir -p /user/spark/applicationHistory'
docker-compose -f ${SCRIPT_PATH}/${DOCKER_COMPOSE_FILE} up -d spark-history-server
