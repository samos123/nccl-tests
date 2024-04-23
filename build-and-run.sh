#!/usr/bin/env bash

set -xe

export JOB_NAME=${JOB_NAME:-"stoelinga-nccl-test"}
export PROJECT_ID=$(gcloud config get project)
export IMAGE=gcr.io/${PROJECT_ID}/nccl-tests:$JOB_NAME
export BUCKET_NAME=supercomputer-testing-stoelinga

docker build -t $IMAGE -f Dockerfile.ubuntu22 .
docker push $IMAGE

envsubst < a3-mpijob.yaml | kubectl apply -f -
