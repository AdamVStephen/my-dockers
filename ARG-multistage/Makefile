cache :
	docker build -t avstephen/arg -f Dockerfile .

MYCACHE:=$(shell date +%s)

nocache :
	docker build -t avstephen/arg --build-arg CACHE_DATE=$(MYCACHE) -f Dockerfile .

