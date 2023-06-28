FROM confluentinc/cp-kafka:latest

USER root

# Add user
ARG USERNAME=kamiken
ARG GROUPNAME=kamiken
ARG UID=5986
ARG GID=5986
RUN useradd $USERNAME &&\
    echo $USERNAME:$USERNAME | chpasswd &&\
    echo '$USERNAME ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers &&\
    mkdir /home/$USERNAME/.ssh

COPY id_rsa.pub /home/$USERNAME/.ssh/
RUN chmod 755 /home/$USERNAME/.ssh
RUN cat /home/$USERNAME/.ssh/id_rsa.pub >> /home/$USERNAME/.ssh/authorized_keys
RUN chmod 755 /home/$USERNAME/.ssh/authorized_keys

RUN yum update -y && yum -y install openssh openssh-server openssh-clients sudo initscripts

# Generate keys
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "/usr/sbin/sshd" >> /root/.bash_profile
# Maybe you need to run the command below in the container directly
# if you got the following error "kex_exchange_identification: Connection closed by remote host"
RUN source /root/.bash_profile
EXPOSE 22

WORKDIR /home/$USERNAME/
