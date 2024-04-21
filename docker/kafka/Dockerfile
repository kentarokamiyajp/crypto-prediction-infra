FROM confluentinc/cp-kafka:latest

USER root

# Add user
ARG USERNAME=kafka
ARG GROUPNAME=kafka
ARG UID=1001
ARG GID=1001
RUN useradd $USERNAME &&\
    echo $USERNAME:$USERNAME | chpasswd &&\
    echo '$USERNAME ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers &&\
    echo 'root ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers &&\
    mkdir /home/$USERNAME/.ssh

COPY authorized_keys /home/$USERNAME/.ssh/
RUN chmod 700 /home/$USERNAME/.ssh
RUN chmod 644 /home/$USERNAME/.ssh/authorized_keys

RUN yum update -y && yum -y install openssh openssh-server openssh-clients sudo initscripts nano

# Generate keys
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "/usr/sbin/sshd" >> /root/.bash_profile
RUN source /root/.bash_profile
EXPOSE 22

WORKDIR /home/$USERNAME/
RUN wget https://dlcdn.apache.org/kafka/3.7.0/kafka_2.13-3.7.0.tgz
RUN tar xzf kafka_2.13-3.7.0.tgz
ENV PATH=$PATH:/home/$USERNAME/kafka_2.13-3.7.0/bin
