FROM python:3
USER root

RUN apt-get update
RUN apt-get -y install locales-all && apt-get -y install locales && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get install -y vim less \
  && pip install --upgrade pip \
  && pip install --upgrade setuptools

RUN git clone https://github.com/edenhill/librdkafka.git
WORKDIR librdkafka
RUN ./configure --prefix /usr --install-deps
RUN make
RUN make install

# install openjdk
RUN apt-get install -y openjdk-11-jdk

# Add user
USER root
ARG USERNAME=kamiken
ARG GROUPNAME=kamiken
ARG UID=1000
ARG GID=1000
ARG PASSWORD=kamiken
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install SSH server
RUN apt-get update
RUN apt-get install -y --no-install-recommends openssh-server
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config

RUN mkdir /home/kamiken/.ssh
COPY id_rsa.pub /home/kamiken/.ssh/
RUN chmod 755 /home/kamiken/.ssh
RUN cat /home/kamiken/.ssh/id_rsa.pub >> /home/kamiken/.ssh/authorized_keys
RUN chmod 755 /home/kamiken/.ssh/authorized_keys

RUN mkdir /home/kamiken/src
COPY init.sh /home/kamiken/
COPY init_bashrc /home/kamiken/
COPY requirements.txt /home/kamiken/src/

RUN echo 'source "/home/kamiken/init.sh"' >> /home/kamiken/.profile

EXPOSE 22
CMD service ssh start && /bin/bash
