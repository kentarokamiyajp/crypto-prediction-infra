#!/bin/bash

. ./container_common.sh

sudo docker run -u $(id -u):$(id -g) -v ${GIT_HOME}:/tf/git -v ${DATASET_HOME}:/tf/dataset -p 8888:8888 --network=host -d --name crypto_base --gpus all -it crypto_base:latest /bin/bash
