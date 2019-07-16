TOOLBOX
##########

A docker image containing all the tools you could possibly ever need.

Included:

#. tfenv
#. terraform
#. pkenv
#. pyenv
#. python
#. ruby
#. chruby

Execute as: ::

    docker run -it \
       -v $HOME/.ssh:/home/user/.ssh \
       -v $HOME/.aws:/home/user/.aws \
       -v $PWD:/workdir \
       -e UID=`id -u` \
       -e GID=`id -g` \
       registry.gitlab.com/thecornershop/toolbox \
       AWS_PROFILE=my-aws-profile aws-profile terraform plan

Or define it as a bash function: ::

      function toolbox() {
          docker run -it \
             -v $HOME/.ssh:/home/user/.ssh \
             -v $HOME/.aws:/home/user/.aws \
             -v $PWD:/workdir \
             -e UID=`id -u` \
             -e GID=`id -g` \
             registry.gitlab.com/thecornershop/toolbox \
             $*
      }
