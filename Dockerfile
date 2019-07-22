FROM archlinux/base

USER root

# Set correct locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8
ENV LC_CTYPE 'en_US.UTF-8'

# Base installation
RUN pacman -Syyu --noconfirm --noprogressbar && \
    pacman -S --noconfirm --needed --noprogressbar \
    base-devel \
    ttf-roboto \
    pyalpm \
    git \
    unzip \
    ctags \
    ack \
    the_silver_searcher \
    gconf \
    sharutils \
    openssl-1.0 \
    python-pip \
    python-virtualenv \
    readline \
    keybase \
    aws-cli \
    openssh \
    docker \
    vim \
    cmake \
    mono \
    go \
    nodejs \
    jdk8-openjdk \
    tmuxp \
    tmux \
    npm \
    wget &&  \
    pacman -Scc --noconfirm

# Install yay - https://github.com/Jguer/yay
ENV yay_version=9.2.0
ENV yay_folder=yay_${yay_version}_x86_64
RUN cd /tmp && \
    curl -L https://github.com/Jguer/yay/releases/download/v${yay_version}/${yay_folder}.tar.gz | tar zx && \
    install -Dm755 ${yay_folder}/yay /usr/bin/yay && \
    install -Dm644 ${yay_folder}/yay.8 /usr/share/man/man8/yay.8

# Add user, group sudo
RUN /usr/sbin/groupadd --system sudo && \
    /usr/sbin/useradd -m --groups sudo user && \
    /usr/sbin/sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers && \
    /usr/sbin/echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN git clone https://github.com/iamhsa/pkenv.git /home/user/.pkenv && cd /home/user/.pkenv && git checkout 9f0567b331d361c008f41865eecc9ee01927ee62
RUN git clone https://github.com/tfutils/tfenv.git /home/user/.tfenv && cd /home/user/.tfenv && git checkout 4475b714e0291d20727a3e2946f3b3e2136df059
RUN ln -s /home/user/.pkenv/bin/* /usr/local/bin
RUN ln -s /home/user/.tfenv/bin/* /usr/local/bin

USER user
RUN echo 1 | yay -Y --removemake -nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu --noconfirm  pod2man
RUN echo 1 | yay -Y --removemake -nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu --noconfirm  pacget
ENV EDITOR vim
RUN pacget --noconfirm --noedit suexec
RUN pacget --noconfirm --noedit chruby
RUN pacget --noconfirm --noedit ruby-build
RUN pacget --noconfirm --noedit pyenv
RUN pacget --noconfirm --noedit gcc6
USER root

RUN echo 'source /usr/share/chruby/chruby.sh' > /etc/profile.d/chruby.sh
RUN echo 'source /usr/share/chruby/auto.sh' >> /etc/profile.d/chruby.sh
RUN echo 'export PATH=/home/user/.pkenv/bin:$PATH' > /etc/profile.d/pkenv.sh
RUN echo 'export PYENV_ROOT="/home/user/.pyenv"' >> /etc/profile.d/pyenv.sh && \
    echo 'eval "$(pyenv init -)"' >> /etc/profile.d/pyenv.sh

RUN  virtualenv /opt/aws-profile && \
	/opt/aws-profile/bin/pip3 install aws-profile && \
	ln -s /opt/aws-profile/bin/aws-profile /usr/bin

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /workdir
