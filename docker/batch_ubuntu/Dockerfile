FROM openjdk:11
COPY --from=python:3.11.9-slim-bullseye / /


RUN apt-get update
RUN apt-get -y install locales-all && apt-get -y install locales nano vim less sudo git librdkafka-dev build-essential

RUN pip install --upgrade pip && pip install --upgrade setuptools

# Add user
ARG USERNAME=batch
ARG GROUPNAME=batch
ARG PASSWORD=batch
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

RUN mkdir /home/$USERNAME/src
COPY init.sh /home/$USERNAME/
COPY init_bashrc /home/$USERNAME/
COPY requirements.txt /home/$USERNAME/src/

RUN echo "sh ~/init.sh" >> /home/$USERNAME/.profile

# install kafka client
RUN wget https://downloads.apache.org/kafka/3.7.0/kafka_2.13-3.7.0.tgz
RUN tar xvf kafka_2.13-3.7.0.tgz
RUN sudo mv kafka_2.13-3.7.0 /usr/local/kafka

# install hadoop client
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
RUN tar zxfv hadoop-3.3.6.tar.gz
RUN echo "export HADOOP_HOME=/home/$USERNAME/hadoop-3.3.6" >> ~/.bashrc
RUN echo "alias hdfs=/home/$USERNAME/hadoop-3.3.6/bin/hdfs" >> ~/.bashrc
COPY hadoop_conf/core-site.xml /home/$USERNAME/hadoop-3.3.6/etc/hadoop/core-site.xml

EXPOSE 22
CMD ["sudo", "/usr/sbin/sshd", "-D"]