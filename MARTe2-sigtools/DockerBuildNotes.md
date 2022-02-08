# Dockerfiles for MARTe2-sigtools

To create docker images from the files in this repository there is a docker file per supported
linux distribution (base images) and a builder.sh script which can drive the four phases of 
the multistage builds. 

At present, the builder.sh script must be manually edited to select the next build action.  This
will be updated with proper argument and option processing at a later date.


