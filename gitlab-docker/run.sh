#!/bin/bash

mkdir gitlab
export GITLAB_HOME=$(pwd)/gitlab
docker-compose up -d
