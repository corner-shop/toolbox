all: base python ruby latest

base:
	docker pull registry.gitlab.com/thecornershop/toolbox:base
	docker build -f Dockerfile.base -t registry.gitlab.com/thecornershop/toolbox:base
	docker build -f Dockerfile.base -t registry.gitlab.com/thecornershop/toolbox:cache.base
	docker push registry.gitlab.com/thecornershop/toolbox:base
	docker push registry.gitlab.com/thecornershop/toolbox:cache.base

python:
	docker pull registry.gitlab.com/thecornershop/toolbox:python
	docker build -f Dockerfile.python -t registry.gitlab.com/thecornershop/toolbox:python
	docker build -f Dockerfile.python -t registry.gitlab.com/thecornershop/toolbox:cache.python
	docker push registry.gitlab.com/thecornershop/toolbox:python
	docker push registry.gitlab.com/thecornershop/toolbox:cache.python

ruby:
	docker pull registry.gitlab.com/thecornershop/toolbox:ruby
	docker build -f Dockerfile.ruby -t registry.gitlab.com/thecornershop/toolbox:ruby
	docker build -f Dockerfile.ruby -t registry.gitlab.com/thecornershop/toolbox:cache.ruby
	docker push registry.gitlab.com/thecornershop/toolbox:ruby
	docker push registry.gitlab.com/thecornershop/toolbox:cache.ruby

latest:
	docker pull registry.gitlab.com/thecornershop/toolbox:latest
	docker build -f Dockerfile.latest -t registry.gitlab.com/thecornershop/toolbox:latest
	docker build -f Dockerfile.latest -t registry.gitlab.com/thecornershop/toolbox:cache.latest
	docker push registry.gitlab.com/thecornershop/toolbox:latest
	docker push registry.gitlab.com/thecornershop/toolbox:cache.latest
