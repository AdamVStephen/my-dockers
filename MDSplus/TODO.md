Copy the latest caching technique from the better version of my scripts
which perfroms the docker pull/push trick

OR
Don't use the multistage build script calling sequentially over the early
stages


i.e. CALL final only, but note that this does NOT cache the intermediate stages.

