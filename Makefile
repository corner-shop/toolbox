
CI_REGISTRY := registry.gitlab.com/thecornershop
CI_IMAGE := toolbox

build:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):latest || true
	docker build -t $(CI_REGISTRY)/$(CI_IMAGE):latest .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):latest
