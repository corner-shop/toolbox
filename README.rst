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


Define it as a bash function: ::

      function toolbox() {
          docker run -it \
             -v $HOME/.ssh:/home/user/.ssh \
             -v $HOME/.aws:/home/user/.aws \
             -v $HOME/.vimrc:/home/user/.vimrc \
             -v $HOME/.toolboox/vim:/home/user/.vim \
             -v $HOME/.ctags.d:/home/user/.ctags.d \
             -v $HOME/.toolboox/pyenv:/home/user/.pyenv/versions \
             -v $HOME/.toolboox/rubies:/home/user/.rubies \
             -v $HOME/.toolboox/tfenv:/home/user/.tfenv/versions \
             -v $HOME/.toolboox/pkenv:/home/user/.pkenv/versions \
             -v $PWD:/workdir \
             -e UID=`id -u` \
             -e GID=`id -g` \
             cornershop/toolbox \
             $*
      }

Then execute as: ::

      tooboox

To install additional software:

for python, using `pyenv` ::

   python-build 2.7.16 ~/.pyenv/versions/2.7.16
   LDFLAGS="-L/usr/lib/openssl-1.0" CFLAGS="-I/usr/include/openssl-1.0" python-build 3.4.1 ~/.pyenv/versions/3.4.1
   python-build 3.6.5 ~/.pyenv/versions/3.6.5

for ruby, using `ruby-install` ::

   PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig CC=/usr/bin/gcc-6 ruby-build 2.3.3 ~/.rubies/ruby-2.3.3
   ~/.rubies/ruby-2.3.3/bin/gem install bundler
   ruby-build 2.6.3 ~/.rubies/ruby-2.6.3
   ~/.rubies/ruby-2.6.3/bin/gem install bundler

for packer, using `pkenv` ::

   pkenv install 1.2.5

for terraform, using `tfenv` ::

   tfenv install 0.11.14


To quickly bootstrap all your required packages you can run an operation like:

   toolbox
   curl https://raw.githubusercontent.com/corner-shop/toolbox/master/bootstrap.sh | bash
