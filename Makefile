
CI_REGISTRY := registry.gitlab.com/thecornershop
CI_IMAGE := toolbox

all: base python ruby latest

base:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):base
	docker build -f Dockerfile.base --cache-from $(CI_REGISTRY)/$(CI_IMAGE):base  -t $(CI_REGISTRY)/$(CI_IMAGE):base .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):base

python:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):python
	docker build -f Dockerfile.python --cache-from $(CI_REGISTRY)/$(CI_IMAGE):python  -t $(CI_REGISTRY)/$(CI_IMAGE):python .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):python

ruby:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):ruby
	docker build -f Dockerfile.ruby --cache-from $(CI_REGISTRY)/$(CI_IMAGE):ruby  -t $(CI_REGISTRY)/$(CI_IMAGE):ruby .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):ruby

latest:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):latest
	docker build -f Dockerfile.latest --cache-from $(CI_REGISTRY)/$(CI_IMAGE):latest  -t $(CI_REGISTRY)/$(CI_IMAGE):latest .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):latest
