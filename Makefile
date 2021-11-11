container_name := docker-python
docker_registry_url := index.docker.io/behance

GIT_BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
GIT_SHA     = $(shell git rev-parse HEAD)
BUILD_DATE  = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
VERSION     ?= 3.9


TAG ?= $(VERSION)
ifeq ($(TAG),@branch)
	override TAG = $(shell git symbolic-ref --short HEAD)
	@echo $(value TAG)
endif

build:
	docker build --tag $(docker_registry_url)/$(container_name):$(GIT_SHA) -f Dockerfile-$(TAG) .; \
	docker tag $(docker_registry_url)/$(container_name):$(GIT_SHA) $(docker_registry_url)/$(container_name):$(TAG)

build-force:
	docker build --rm --force-rm --pull --no-cache -t $(docker_registry_url)/$(container_name):$(GIT_SHA) -f Dockerfile-$(TAG) . ; \
	docker tag $(docker_registry_url)/$(container_name):$(GIT_SHA) $(docker_registry_url)/$(container_name):$(TAG)

tag:
	docker tag $(docker_registry_url)/$(container_name):$(GIT_SHA) $(docker_registry_url)/$(container_name):$(TAG)

build-push: build tag
	docker push $(docker_registry_url)/$(container_name):$(GIT_SHA)
	docker push $(docker_registry_url)/$(container_name):$(TAG)

push:
	docker push $(docker_registry_url)/$(container_name):$(GIT_SHA)
	docker push $(docker_registry_url)/$(container_name):$(TAG)

push-force: build-force push

release: push
	git tag $(VERSION)
	git push upstream --tags

bash:
	docker run --rm -i -t --entrypoint "bash" $(docker_registry_url)/$(container_name):$(TAG) -l
