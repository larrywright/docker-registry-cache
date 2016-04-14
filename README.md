## Docker Registry Cache

When doing development with Docker, if you're using a lot of containers, you can end up downloading the same containers over and over again. This can be problematic if you're on a metered or slow internet connection, but it also slows down development waiting for your containers to be downloaded. The solution is to use a local registry that caches content from your upstream registry and stores it on your local machine. In my experience with projects that use lots of containers, this can cut setup time in 1/2.

This is a simple Docker compose file + config file that sets up a local caching proxy for the Docker registry. Run this and then let your local Docker Machines use it as the registry. Once the Docker containers are stored in the cache, they will be served up locally, unless the upstream has changed.

## Use

There's a simple shell script here called 'run.sh' which will create a Docker Machine called 'local-registry' if it doesn't already exist, and then run `docker-compose up`. You are free to just call that command directly if you wish to use a pre-existing Docker machine. Once the registry is up and running, you need to create your Docker Machines with a few extra parameters: `--engine-registry-mirror` and `--engine-insecure-registry`, both set to the full url of the local registry. You can do this automatically:

```
docker-machine create --driver virtualbox --engine-registry-mirror http://$( docker-machine ip local-registry):5000 --engine-insecure-registry http://$( docker-machine ip local-registry):5000 my-docker-machine

```

## Prerequisites

- Docker Toolbox

## Caveats

- This only works with the official Docker registry, and doesn't yet support other registries (including private ones). 

## License

This is licensed under the Apache license
