#!/bin/bash -e

export MACHINE_NAME="local-registry"
if $(docker-machine env $MACHINE_NAME > /dev/null 2>&1) ; then
    echo "Docker machine '$MACHINE_NAME' already exists"
else
    # Creates a local docker registry to use as a proxy
    docker-machine create --driver virtualbox $MACHINE_NAME
fi

eval $( docker-machine env $MACHINE_NAME)

docker-compose up -d 
