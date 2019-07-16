FROM registry.gitlab.com/thecornershop/toolbox:base

RUN RUBY_MAKE_OPTS='-j 5' ruby-build 2.6.3 /opt/rubies/ruby-2.6.3
RUN PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig CC=/usr/bin/gcc-6 RUBY_MAKE_OPTS='-j 5' ruby-build 2.3.3 /opt/rubies/ruby-2.3.3

RUN /opt/rubies/ruby-2.6.3/bin/gem install bundler
RUN /opt/rubies/ruby-2.3.3/bin/gem install bundler

