#!/usr/bin/env bash

POSTGRES_SEC_ID=$1
PHASE_API_KEY=$2
AWS_ACCOUNT_ID=$3
AWS_REGION=$4
VERSION=$5

pkl eval -f yaml app/config/pkl/main.pkl > app/config/pkl/prod.yml

docker build \
    --build-arg stage=prod \
    --build-arg port=5001 \
    --build-arg phaseApiKey="$PHASE_API_KEY" \
    --build-arg postgresSecretName="$POSTGRES_SEC_ID" \
    -t lt-docker-cs app
  
docker tag lt-docker-cs:latest "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/lt-docker-cs:latest"
docker tag lt-docker-cs:latest "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/lt-docker-cs:$VERSION"

docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/lt-docker-cs:latest"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/lt-docker-cs:$VERSION"