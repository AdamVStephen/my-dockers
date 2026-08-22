# Build with Docker

```
time docker build -t avstephen/m2padova-alma8:kranj -f Dockerfile . 2>&1 | tee docker.build.1
```

# Build with Podman

# TBA


# Special Notes

## MARTe2 and MARTe2-components matching releases

Latest convention appears to be matching tags in both repositories.

As of 2026-08-22 the latest tags are v1.10.4	


## Maintenance Time

10 minutes on pace-srv-1 to build with the exception of the MARTe2 layer.

## OPCUA

The build for open62541 has some complications.  If migrating the build
to a later version, check the README file in the OPCUA Datasource directory.
