FROM trinodb/trino:431
USER root

RUN apt-get update
RUN apt-get install -y locales-all && apt-get install -y locales nano vim less sudo

RUN echo 'JAVA_HOME=/opt/java/openjdk; export JAVA_HOME' >> /root/.bashrc
RUN echo 'PATH=$JAVA_HOME/bin:$PATH; export PATH' >> /root/.bashrc

EXPOSE 22
