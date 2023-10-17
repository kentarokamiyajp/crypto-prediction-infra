FROM jupyter/pyspark-notebook:spark-3.1.1

USER root

RUN apt-get update
RUN apt-get -y install locales-all && apt-get -y install locales nano vim less sudo \
      zlib1g-dev libncurses5 libncurses5-dev libncursesw5 libffi-dev libreadline-dev \
      libssl-dev libsqlite3-dev lzma liblzma-dev libbz2-dev
RUN apt-get update

# Install SSH server
RUN apt-get update
RUN apt-get install -y --no-install-recommends openssh-server
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN ssh-keygen -A
RUN service ssh start

WORKDIR $HOME
RUN mkdir $HOME/.ssh
COPY authorized_keys $HOME/.ssh/
RUN sudo chmod 700 $HOME/.ssh
RUN sudo chmod 644 $HOME/.ssh/authorized_keys

RUN mkdir $HOME/src
COPY init.sh $HOME/
COPY init_bashrc $HOME/
COPY requirements.txt $HOME/src/

RUN echo "sh ~/init.sh" >> $HOME/.bashrc
