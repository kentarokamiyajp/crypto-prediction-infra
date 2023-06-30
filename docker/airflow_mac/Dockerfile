FROM apache/airflow:2.5.2
USER root

RUN apt-get update
RUN apt-get -y install locales-all && apt-get -y install locales

# install openjdk
RUN apt-get install -y default-jdk

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
RUN apt-get install -y --no-install-recommends build-essential libopenmpi-dev libsasl2-dev openssh-server vim
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
# maybe you need to run the command below in the container directly.
RUN service ssh start
EXPOSE 22


WORKDIR /home/$USERNAME/

RUN mkdir /home/kamiken/.ssh/
COPY authorized_keys /home/kamiken/.ssh/
RUN chmod 755 /home/kamiken/.ssh
RUN chmod 755 /home/kamiken/.ssh/authorized_keys

USER airflow
RUN pip install lxml
RUN pip install apache-airflow-providers-docker
RUN pip install apache-airflow-providers-apache-cassandra
RUN pip install apache-airflow-providers-apache-spark
RUN pip install apache-airflow-providers-apache-hive
RUN pip install apache-airflow-providers-mysql
RUN pip install apache-airflow-providers-trino
RUN pip install apache-airflow-providers-mongo
RUN pip install airflow-provider-kafka