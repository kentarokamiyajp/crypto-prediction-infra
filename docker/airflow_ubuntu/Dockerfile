FROM apache/airflow:2.5.2
USER root

RUN apt-get update
RUN apt-get -y install locales-all
RUN apt-get update
RUN apt-get install -y --no-install-recommends locales vim less sudo default-jdk wget git build-essential libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev libgdbm-dev libbz2-dev liblzma-dev zlib1g-dev  nano uuid-dev libffi-dev libdb-dev scala apt-utils curl libgomp1

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
WORKDIR /home/airflow
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

# install virtualenv for other python versions
# install pyenv
RUN git clone https://github.com/pyenv/pyenv.git /opt/airflow/.pyenv
ENV PYENV_ROOT="/opt/airflow/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN echo "PYENV_ROOT=/opt/airflow/.pyenv" >> ~/.bashrc
RUN echo "PATH=/opt/airflow/.pyenv/bin:$PATH" >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN eval "$(pyenv init -)"
RUN pyenv install 3.10.13

# install pyenv-virtualenv
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
RUN eval "$(pyenv virtualenv-init -)"
ENV PATH="$PYENV_ROOT/plugins/pyenv-virtualenv/bin:$PATH"

# create a virtual env for dbt
RUN pyenv virtualenv 3.10.13 dbtenv
COPY ./dbt_config/requirements.txt /opt/airflow/
RUN /opt/airflow/.pyenv/shims/python -m pip install -r requirements.txt --no-user

# set pools
COPY airflow_pools.json .

USER $USERNAME
WORKDIR /home/$USERNAME
RUN mkdir /home/$USERNAME/.ssh
COPY authorized_keys /home/$USERNAME/.ssh/
RUN sudo chmod 700 /home/$USERNAME/.ssh
RUN sudo chmod 644 /home/$USERNAME/.ssh/authorized_keys

WORKDIR /opt/airflow/

EXPOSE 22
CMD ["sudo", "/usr/sbin/sshd", "-D"]