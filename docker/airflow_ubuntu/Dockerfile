FROM apache/airflow:2.5.2
USER root

RUN apt-get update
RUN apt-get -y install locales-all && apt-get -y install locales nano vim less sudo default-jdk wget scala apt-utils curl libgomp1

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
    echo "airflow   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    usermod -a -G root $USERNAME && \
    usermod -a -G air $USERNAME

# install spark
RUN wget https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
RUN tar -xvzf spark-3.1.1-bin-hadoop3.2.tgz
RUN mv spark-3.1.1-bin-hadoop3.2 /mnt/spark

# install .NET 6.0
RUN wget https://download.visualstudio.microsoft.com/download/pr/62181759-93ce-4512-8de1-92de74a6ba3f/f83ea41c3161f301d3584598f9c31801/dotnet-sdk-6.0.412-linux-x64.tar.gz
RUN mkdir -p /home/airflow/dotnet && tar zxf dotnet-sdk-6.0.412-linux-x64.tar.gz -C /home/airflow/dotnet

# Update PATH for root user
ENV SPARK_HOME /mnt/spark
ENV DOTNET_ROOT=/home/airflow/dotnet
ENV PATH=$PATH:/home/airflow/dotnet:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Install SSH server
RUN apt-get update
RUN apt-get install -y --no-install-recommends openssh-server
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN ssh-keygen -A
RUN service ssh start

COPY .ssh /home/airflow/.ssh

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