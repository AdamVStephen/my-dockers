# Dockerfile for MARTe2-signal-tools

It can be useful to derive environment scripts from the Dockerfile.

To do this, the following script fragment can be useful :

sed -e 's/ENV/export/g' Dockerfile > env-setup

## python dateutils
Note that installing the python dateutils package requires interactive input
as it configures itself to select the appropriate timezone.  This needs
particular attention for batch mode docker image creation.

It will install without input but with warnings *in the absence of readline*.
To get the equivalent if readline is installed, use this environment setting.

DEBIAN_FRONTEND=noninteractive

