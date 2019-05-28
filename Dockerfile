FROM archlinux/base

USER root

# Base installation
RUN pacman -Syyu --noconfirm --noprogressbar && \
    pacman -S --noconfirm --needed --noprogressbar \
    base-devel \
    ttf-roboto \
    pyalpm \
    git

RUN pacman -S --noconfirm openssl-1.0



# Install yay - https://github.com/Jguer/yay
ENV yay_version=9.2.0
ENV yay_folder=yay_${yay_version}_x86_64
RUN cd /tmp && \
    curl -L https://github.com/Jguer/yay/releases/download/v${yay_version}/${yay_folder}.tar.gz | tar zx && \
    install -Dm755 ${yay_folder}/yay /usr/bin/yay && \
    install -Dm644 ${yay_folder}/yay.8 /usr/share/man/man8/yay.8

# Set correct locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8
ENV LC_CTYPE 'en_US.UTF-8'

# Add user, group sudo
RUN /usr/sbin/groupadd --system sudo && \
    /usr/sbin/useradd -m --groups sudo user && \
    /usr/sbin/sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers && \
    /usr/sbin/echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user

RUN yay -S --noconfirm tfenv
#RUN yay -S --noconfirm python-build
RUN yay -S --noconfirm pyenv
RUN yay -S --noconfirm chruby
RUN yay -S --noconfirm ruby-install

USER root
RUN chmod 755 /usr/sbin/ruby-install
USER user

RUN pyenv install 2.7.16
RUN pyenv install 3.6.0
RUN pyenv install 3.6.1
RUN pyenv install 3.6.2
RUN pyenv install 3.6.3
RUN pyenv install 3.6.4
RUN pyenv install 3.6.5
RUN pyenv install 3.6.6
RUN pyenv install 3.6.7
RUN pyenv install 3.6.8

WORKDIR /tmp

RUN yes | PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig ruby-install ruby 2.1.8
RUN yes | PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig ruby-install ruby 2.3.3
RUN yes | ruby-install ruby 2.4.1
RUN yes | ruby-install ruby 2.4.4

# don't install any editors, only tools to update state on AWS
# example: tfenv, terraform, packer, pyenv,  pythons, ruby, chruby, etcs, gcc6
# then run as:
# docker run -it -v $HOME/.ssh:/home/user/.ssh -v $HOME:/.aws:/home/user -v $PWD:/workdir toolbox terraform plan