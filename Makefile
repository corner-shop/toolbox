
CI_REGISTRY := registry.gitlab.com/thecornershop
CI_IMAGE := toolbox

all: base python ruby latest

base:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):base || true
	docker build -f Dockerfile.base --cache-from $(CI_REGISTRY)/$(CI_IMAGE):base  -t $(CI_REGISTRY)/$(CI_IMAGE):base .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):base

python: python.2.7.16 python.3.4.1 python.3.5.5 python.3.6.3 python.3.6.8 python.3.7.4

python.2.7.16:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):python.2.7.16 || true
	docker build -f Dockerfile.python.2.7.16 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):python.2.7.16  -t $(CI_REGISTRY)/$(CI_IMAGE):python.2.7.16 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):python.2.7.16

python.3.4.1:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):python.3.4.1 || true
	docker build -f Dockerfile.python.3.4.1 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):python.3.4.1  -t $(CI_REGISTRY)/$(CI_IMAGE):python.3.4.1 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):python.3.4.1

python.3.5.5:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):python.3.5.5 || true
	docker build -f Dockerfile.python.3.5.5 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):python.3.5.5  -t $(CI_REGISTRY)/$(CI_IMAGE):python.3.5.5 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):python.3.5.5

python.3.6.3:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.3 || true
	docker build -f Dockerfile.python.3.6.3 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.3  -t $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.3 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.3

python.3.6.8:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.8 || true
	docker build -f Dockerfile.python.3.6.8 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.8  -t $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.8 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):python.3.6.8

python.3.7.4:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):python.3.7.4 || true
	docker build -f Dockerfile.python.3.7.4 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):python.3.7.4  -t $(CI_REGISTRY)/$(CI_IMAGE):python.3.7.4 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):python.3.7.4


ruby: ruby-2.3.3 ruby-2.4.3 ruby-2.5.1 ruby-2.6.3

ruby.2.3.3:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.3.3 || true
	docker build -f Dockerfile.ruby.2.3.3 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.3.3  -t $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.3.3 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.3.3

ruby.2.4.3:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.4.3 || true
	docker build -f Dockerfile.ruby.2.4.3 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.4.3  -t $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.4.3 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.4.3

ruby.2.5.1:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.5.1 || true
	docker build -f Dockerfile.ruby.2.5.1 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.5.1  -t $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.5.1 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.5.1

ruby.2.6.3:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.6.3 || true
	docker build -f Dockerfile.ruby.2.6.3 --cache-from $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.6.3  -t $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.6.3 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):ruby.2.6.3


latest:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):latest || true
	docker build -f Dockerfile.latest --cache-from $(CI_REGISTRY)/$(CI_IMAGE):latest  -t $(CI_REGISTRY)/$(CI_IMAGE):latest .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):latest
