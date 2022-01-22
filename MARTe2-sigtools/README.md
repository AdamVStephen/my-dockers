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


# Shell Script Installer

Typical usage is three stage.

1. As root : install.sh 2>&1 | tee /root/install.log
2. As user : install.sh 2>&1 | tee $HOME/install.log
3. As user : manually work through the compilation, unless this is on a clone machine and the compilation is known good.
