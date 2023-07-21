FROM apache/airflow:2.5.2
USER root

RUN apt-get update
RUN apt-get -y install locales-all && apt-get -y install locales nano vim less sudo default-jdk

# Add user
ARG USERNAME=air
ARG GROUPNAME=air
ARG PASSWORD=air
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


USER airflow
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

USER $USERNAME
WORKDIR /home/$USERNAME
RUN mkdir /home/$USERNAME/.ssh
COPY authorized_keys /home/$USERNAME/.ssh/
RUN sudo chmod 700 /home/$USERNAME/.ssh
RUN sudo chmod 644 /home/$USERNAME/.ssh/authorized_keys

WORKDIR /opt/airflow/

EXPOSE 22
CMD ["sudo", "/usr/sbin/sshd", "-D"]