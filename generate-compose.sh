#!/bin/bash

ACCOUNTS=(
examp_account
)

OUTPUT="docker-compose.yml"

# base compose
cat docker-compose-template > ${OUTPUT}

TEMPLATE='
  ${ACCOUNT}:
    <<: *defaults
    container_name: ${ACCOUNT}
    image: ${ACCOUNT}:latest
    volumes:
      - *vol1
      - *vol2
      - ./sessions/${ACCOUNT}@hotmail.com:/app/sessions/${ACCOUNT}@hotmail.com
      - type: bind
        source: ./config_${ACCOUNT}.yaml
        target: /app/config.yaml
        bind:
          create_host_path: false
    build:
      args:
        SLEEP: ${SLEEP}'

i=0
for ACCOUNT in ${ACCOUNTS[@]} ; do
  export ACCOUNT SLEEP=$i
  echo "$TEMPLATE" | envsubst >> ${OUTPUT}
  i=$((i+1))
done
