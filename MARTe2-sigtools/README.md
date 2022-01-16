# Dockerfile for MARTe2-signal-tools

It can be useful to derive environment scripts from the Dockerfile.

To do this, the following script fragment can be useful :

sed -e 's/ENV/export/g' Dockerfile > env-setup
