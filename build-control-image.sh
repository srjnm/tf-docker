#!/bin/bash

cd docker-files
docker build -t srjnm/control-ubuntu:v1 -f control-node.Dockerfile .
docker push srjnm/control-ubuntu:v1
cd ..