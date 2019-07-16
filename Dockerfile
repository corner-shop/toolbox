FROM registry.gitlab.com/thecornershop/toolbox:base

# time consuming tasks
COPY --from=registry.gitlab.com/thecornershop/toolbox:python /opt/pyenv /opt/pyenv
COPY --from=registry.gitlab.com/thecornershop/toolbox:ruby /opt/rubies /opt/rubies


RUN tfenv install 0.11.13

RUN PATH=/opt/pkenv/bin:$PATH pkenv install 1.2.5

RUN echo 'source /usr/share/chruby/chruby.sh' > /etc/profile.d/chruby.sh
RUN echo 'export PATH=/opt/pkenv/bin:$PATH' > /etc/profile.d/pkenv.sh
RUN echo 'export PYENV_ROOT="/opt/pyenv"' >> /etc/profile.d/pyenv.sh && \
    echo 'eval "$(pyenv init -)"' >> /etc/profile.d/pyenv.sh

RUN  pip3 install aws-profile

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


WORKDIR /workdir

# don't install any editors, only tools to update state on AWS
# example: tfenv, terraform, packer, pyenv,  pythons, ruby, chruby, etcs, gcc6
# then run as:
# docker run -it -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/.ssh:/home/user/.ssh -v $HOME:/.aws:/home/user -v $PWD:/workdir toolbox terraform plan
