# Build with Docker

```
time docker build -t avstephen/m2padova-alma8:kranj -f Dockerfile . 2>&1 | tee docker.build.1
```

# Build with Podman

# TBA

# Special Notes

The build for open62541 has some complications.  If migrating the build
to a later version, check the README file in the OPCUA Datasource directory.
