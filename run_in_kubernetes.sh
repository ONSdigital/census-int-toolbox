#!/usr/bin/env bash

if [ -z "$IMAGE" ]; then
   IMAGE=eu.gcr.io/census-rh-ci/census-rh-toolbox:latest
fi

echo "Image $IMAGE"

kubectl run toolbox -it --rm \
   --generator=run-pod/v1 \
   --image $IMAGE\
   --env=RABBITMQ_USER=$(kubectl get secret rabbit-identity -o=jsonpath="{.data.username}" | base64 --decode) \
   --env=RABBITMQ_PASSWORD=$(kubectl get secret rabbit-identity -o=jsonpath="{.data.password}" | base64 --decode) \
   --env=RABBITMQ_SERVICE_HOST=rabbitmq \
   --env=RABBITMQ_SERVICE_PORT=5672 \
   --env=RABBITMQ_HTTP_PORT=15672 \
   --env=RABBITMQ_VHOST='/' \
   -- /bin/bash
