.DEFAULT_GOAL := build
CI_REGISTRY := registry.gitlab.com/thecornershop
CI_IMAGE := toolbox

registry-login:
	docker info
	docker login -u $$CI_REGISTRY_USER -p $$CI_REGISTRY_PASSWORD $$CI_REGISTRY

toolbox-base:
	docker pull archlinux/base:latest || true
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):base || true
	docker build -f Dockerfile.base -t $(CI_REGISTRY)/$(CI_IMAGE):base .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):base

toolbox-gcc6:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):gcc6 || true
	docker build -f Dockerfile.gcc6 -t $(CI_REGISTRY)/$(CI_IMAGE):gcc6 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):gcc6

toolbox-tools:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):tools || true
	docker build -f Dockerfile.tools -t $(CI_REGISTRY)/$(CI_IMAGE):tools .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):tools

toolbox-latest:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):latest || true
	docker build \
		--build-arg DOCKER_USER_ID=`id -u` \
		--build-arg DOCKER_GROUP_ID=`id -g` \
		-f Dockerfile.latest -t $(CI_REGISTRY)/$(CI_IMAGE):latest .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):latest

build: toolbox-base toolbox-gcc6 toolbox-tools toolbox-latest
