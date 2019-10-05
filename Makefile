.DEFAULT_GOAL := build

CI_REGISTRY := registry.gitlab.com/thecornershop
CI_IMAGE := toolbox


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
	docker build -f Dockerfile.latest -t $(CI_REGISTRY)/$(CI_IMAGE):latest .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):latest

build: toolbox-base toolbox-gcc6 toolbox-tools toolbox-latest
