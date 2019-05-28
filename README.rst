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

Execute as:

.. code-block:: bash
   docker run -it \
      -v $HOME/.ssh:/home/user/.ssh \
      -v $HOME:/.aws:/home/user \
      -v $PWD:/workdir \
      toolbox terraform plan
