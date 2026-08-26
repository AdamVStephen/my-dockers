# Build with Docker

```
time docker build -t avstephen/m2padova-alma8:kranj -f Dockerfile . 2>&1 | tee docker.build.1
```

# Multiplatform builds


docker buildx build --platform linux/amd64,linux/arm64 .
However, the packages for MDSplus are not available, so this needs a rethink.

# Push to Docker Hub

docker login
docker push avstephen/m2padova-alma8:kranj

# Push to Codeberg

# TODO: Push to gitlab.ukaea.uk

# Build with Podman

# TBA


# Special Notes

## MARTe2 and MARTe2-components matching releases

Latest convention appears to be matching tags in both repositories.

As of 2026-08-22 the latest tags are v1.10.4	


## Maintenance Time

1. 10 minutes on pace-srv-1 to build with the exception of the MARTe2 layer.
2. minutes on pace-srv-1 to build the MARTe2 core and components layers.



## OPCUA

The build for open62541 has some complications.  If migrating the build
to a later version, check the README file in the OPCUA Datasource directory.
