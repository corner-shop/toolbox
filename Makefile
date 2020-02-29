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

test-base:
	docker run -it --rm $(CI_REGISTRY)/$(CI_IMAGE):base bash -c '\
		set -e ;\
		for pkg in \
		  git unzip ctags ag openssl pip2 virtualenv2 pip3 \
		  virtualenv3 keybase aws postgres ssh mysql docker vim cmake \
		  mono go node java tmuxp tmux fzf npm ldapsearch wget groovy yay;\
	       do which $${pkg} ; done'

toolbox-gcc6:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):gcc6 || true
	docker build -f Dockerfile.gcc6 -t $(CI_REGISTRY)/$(CI_IMAGE):gcc6 .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):gcc6

test-gcc6:
	docker run -it --rm $(CI_REGISTRY)/$(CI_IMAGE):gcc6 which gcc-6


toolbox-tools:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):tools || true
	docker build -f Dockerfile.tools -t $(CI_REGISTRY)/$(CI_IMAGE):tools .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):tools

test-tools:
	docker run -it --rm $(CI_REGISTRY)/$(CI_IMAGE):tools su - user -c '\
		set -e ;\
		for pkg in \
		  pkenv tfenv su-exec chruby-exec ruby-build pyenv ruby-install poetry \
		  poetry pipenv tmate direnv global kubectl gawk helmsman helm; \
	       do which $${pkg} ; done'
	docker run -it --rm $(CI_REGISTRY)/$(CI_IMAGE):tools su - user -c '\
		set -e ;\
		PATH=/opt/virtualenv2/bin:$$PATH ;\
		for pymodule in \
		  aws-profile pylint flake8 yapf autoflake isort coverage \
		  bandit therapist ;\
	       do which $${pymodule} ; done'
	docker run -it --rm $(CI_REGISTRY)/$(CI_IMAGE):tools su - user -c '\
		set -e ;\
		PATH=/opt/virtualenv3/bin:$$PATH ;\
		for pymodule in \
		  aws-profile black pylint flake8 yapf autoflake isort coverage \
		  bandit therapist ;\
	       do which $${pymodule} ; done'


toolbox-latest:
	docker pull $(CI_REGISTRY)/$(CI_IMAGE):latest || true
	docker build \
		--build-arg DOCKER_USER_ID=`id -u` \
		--build-arg DOCKER_GROUP_ID=`id -g` \
		-f Dockerfile.latest -t $(CI_REGISTRY)/$(CI_IMAGE):latest .
	docker push $(CI_REGISTRY)/$(CI_IMAGE):latest

test:
	docker run --rm -i -v $$PWD/.hadolint.base.yaml:/root/.config/hadolint.yaml  hadolint/hadolint   < Dockerfile.base
	docker run --rm -i -v $$PWD/.hadolint.gcc6.yaml:/root/.config/hadolint.yaml  hadolint/hadolint   < Dockerfile.gcc6
	docker run --rm -i -v $$PWD/.hadolint.tools.yaml:/root/.config/hadolint.yaml  hadolint/hadolint   < Dockerfile.tools
	docker run --rm -i hadolint/hadolint < Dockerfile.latest

build: test toolbox-base test-base toolbox-gcc6 test-gcc6 toolbox-tools test-tools toolbox-latest
