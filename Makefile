DOCKER_IMAGE?=kid/k8s-podinfo
DOCKER_TAG?=$(shell git symbolic-ref --short HEAD)
GIT_REPOSITORY?=kid/k8s-podinfo
GIT_SHA:=$(shell git describe --dirty --always)

.PHONY: all
all: test build

.PHONY: test
test:
	go test ./...

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) \
     --build-arg REPOSITORY=${GIT_REPOSITORY} \
     --build-arg SHA=${GIT_SHA} -f Dockerfile.gh .
