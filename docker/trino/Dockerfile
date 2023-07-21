FROM trinodb/trino:latest
USER root

RUN apt-get update
RUN apt-get install -y locales-all && apt-get install -y locales nano vim less sudo

# Add user
ARG USERNAME=triner
ARG GROUPNAME=triner
ARG PASSWORD=triner
ARG UID=1001
ARG GID=1001
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    usermod -a -G root $USERNAME

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

RUN echo 'JAVA_HOME=/opt/java/openjdk; export JAVA_HOME' >> /home/$USERNAME/.bashrc
RUN echo 'PATH=$JAVA_HOME/bin:$PATH; export PATH' >> /home/$USERNAME/.bashrc

# set JAVA_HOME
USER root
RUN echo 'JAVA_HOME=/opt/java/openjdk; export JAVA_HOME' >> /root/.bashrc
RUN echo 'PATH=$JAVA_HOME/bin:$PATH; export PATH' >> /root/.bashrc
RUN echo 'service ssh start' >> /root/.bashrc

EXPOSE 22
