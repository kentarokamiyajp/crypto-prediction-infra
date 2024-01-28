FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends wget build-essential libreadline-dev libkrb5-dev \
libncursesw5-dev libssl-dev libsqlite3-dev libgdbm-dev libbz2-dev liblzma-dev zlib1g-dev uuid-dev libffi-dev libdb-dev nano git less sudo

RUN wget --no-check-certificate https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz \
&& tar -xf Python-3.9.5.tgz \
&& cd Python-3.9.5 \
&& ./configure --enable-optimizations\
&& make \
&& make install

RUN apt-get autoremove -y

# Add user
ARG USERNAME=dbtuser
ARG GROUPNAME=dbtuser
ARG PASSWORD=dbtuser
ARG UID=1001
ARG GID=1001
RUN groupadd -g $GID $GROUPNAME && \
  useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
  echo $USERNAME:$PASSWORD | chpasswd && \
  echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# Install SSH server
RUN apt-get update
RUN apt-get install -y --no-install-recommends openssh-server
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN ssh-keygen -A
RUN service ssh start

USER $USERNAME
WORKDIR /home/$USERNAME
RUN mkdir /home/$USERNAME/.ssh
COPY authorized_keys /home/$USERNAME/.ssh/
RUN sudo chmod 700 /home/$USERNAME/.ssh
RUN sudo chmod 644 /home/$USERNAME/.ssh/authorized_keys

COPY requirements.txt .
COPY init.sh .

EXPOSE 22
CMD ["sudo", "/usr/sbin/sshd", "-D"]