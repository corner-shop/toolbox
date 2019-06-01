FROM archlinux/base

USER root

# Base installation
RUN pacman -Syyu --noconfirm --noprogressbar && \
    pacman -S --noconfirm --needed --noprogressbar \
    base-devel \
    ttf-roboto \
    pyalpm \
    git \
    unzip \
    sharutils \
    openssl-1.0 \
    keybase &&  \
    pacman -Scc

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

RUN yay -S --noconfirm pyenv
RUN yay -S --noconfirm chruby
RUN yay -S --noconfirm ruby-install

USER root
RUN chmod 755 /usr/sbin/ruby-install
USER user

RUN pyenv install 2.7.16
RUN pyenv install 3.6.8
RUN pyenv install 3.7.2

WORKDIR /tmp

# install ruby
RUN yes | ( PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig ruby-install --jobs=4 ruby 2.1.10 && rm -rf /home/user/src )
RUN yes | ( PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig ruby-install --jobs=4 ruby 2.2.10 && rm -rf /home/user/src )
RUN yes | ( PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig ruby-install --jobs=4 ruby 2.3.8 && rm -rf /home/user/src )
RUN yes | ( ruby-install --jobs=4 ruby 2.4.6 && rm -rf /home/user/src )
RUN yes | ( ruby-install --jobs=4 ruby 2.5.5 && rm -rf /home/user/src )
RUN yes | ( ruby-install --jobs=4 ruby 2.6.3 && rm -rf /home/user/src )

RUN git clone https://github.com/iamhsa/pkenv.git /home/user/.pkenv && cd /home/user/.pkenv && git checkout 9f0567b331d361c008f41865eecc9ee01927ee62
RUN git clone https://github.com/tfutils/tfenv.git /home/user/.tfenv && cd /home/user/.tfenv && git checkout 4475b714e0291d20727a3e2946f3b3e2136df059
USER root
RUN ln -s /home/user/.pkenv/bin/* /usr/local/bin
RUN ln -s /home/user/.tfenv/bin/* /usr/local/bin
USER user

# instal pkenv
RUN pkenv install 1.4.1
RUN pkenv install 1.3.5

# install tfenv
RUN tfenv install 0.11.14
RUN tfenv install 0.12.0


# don't install any editors, only tools to update state on AWS
# example: tfenv, terraform, packer, pyenv,  pythons, ruby, chruby, etcs, gcc6
# then run as:
# docker run -it -v $HOME/.ssh:/home/user/.ssh -v $HOME:/.aws:/home/user -v $PWD:/workdir toolbox terraform plan
