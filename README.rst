TOOLBOX
##########

The main repository for this project can be found at:
https://gitlab.com/theCornerShop/toolbox


A docker image containing all the tools you could possibly ever need.

Included:

#. tfenv
#. terraform
#. pkenv
#. pyenv
#. python
#. ruby
#. chruby

To install:

1. git clone this repostory

2. Run ::

      make toolbox-latest

Then define it as a bash function: ::

      function toolbox() {
        docker run -it \
          -v $HOME/.ssh:/home/user/.ssh \
          -v $HOME/.gitconfig:/home/user/.gitconfig \
          -v $HOME/.gitignore:/home/user/.gitignore \
          -v $HOME/.gnupg:/home/user/.gnupg \
          -v $HOME/.aws:/home/user/.aws \
          -v $HOME/.vimrc:/home/user/.vimrc \
          -v $HOME/.tmux:/home/user/.tmux \
          -v $HOME/.tmux.conf:/home/user/.tmux.conf \
          -v $HOME/.toolbox/vim:/home/user/.vim \
          -v $HOME/.toolbox/gems:/home/user/.gem \
          -v $HOME/.toolbox/SpaceVim:/home/user/.SpaceVim \
          -v $HOME/.toolbox/SpaceVim.d:/home/user/.SpaceVim.d \
          -v $HOME/.toolbox/.cache/vimfiles:/home/user/.cache/vimfiles \
          -v $HOME/.ctags.d:/home/user/.ctags.d \
          -v $HOME/.toolbox/pyenv:/home/user/.pyenv/versions \
          -v $HOME/.toolbox/rubies:/home/user/.rubies \
          -v $HOME/.toolbox/tfenv:/home/user/.tfenv/versions \
          -v $HOME/.toolbox/pkenv:/home/user/.pkenv/versions \
          -v $PWD:/workdir \
          -e UID=`id -u` \
          -e GID=`id -g` \
        registry.gitlab.com/thecornershop/toolbox $*
              }

Then execute as: ::

      toolboox

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
