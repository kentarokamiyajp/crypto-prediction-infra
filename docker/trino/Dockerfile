FROM trinodb/trino:latest

# Add user
USER root
ARG USERNAME=kamiken
ARG GROUPNAME=kamiken
ARG UID=5986
ARG GID=5986
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
# maybe you need to run the command below in the container directly by root user.
RUN service ssh start
EXPOSE 22


WORKDIR /home/$USERNAME/

RUN mkdir /home/kamiken/.ssh/
COPY id_rsa.pub /home/kamiken/.ssh/
RUN chmod 755 /home/kamiken/.ssh
RUN cat /home/kamiken/.ssh/id_rsa.pub >> /home/kamiken/.ssh/authorized_keys
RUN chmod 755 /home/kamiken/.ssh/authorized_keys
