FROM ubuntu:18.04
FROM adoptopenjdk:11-jre-hotspot
# FROM hseeberger/scala-sbt:8u222_1.3.5_2.13.1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y git autoconf automake make \
                       gcc g++ mcpp \
                       python python3 openjdk-8-jdk \
                       flex bison \
                       sqlite libsqlite-dev sqlite3 libsqlite3-dev \
                       zlib1g zlib1g-dev \
                       doxygen libncurses5-dev libtool libffi-dev wget python3-matplotlib graphviz gnupg2 \
                       task-spooler procps passwd openssh-server vim curl


RUN git clone https://github.com/aalok-thakkar/egs-artifact.git

# Prepare scala/sbt for egs
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt-get update
RUN apt-get install -y sbt
RUN apt-get install -y scala

# libffi6, souffle for prosynth
RUN wget http://mirrors.kernel.org/ubuntu/pool/main/libf/libffi/libffi6_3.2.1-8_amd64.deb
RUN apt install ./libffi6_3.2.1-8_amd64.deb

RUN echo "deb https://dl.bintray.com/souffle-lang/deb-unstable bionic main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
# RUN apt-get update
# RUN apt-get install -y souffle
# For setting up prosynth
RUN cd egs-artifact/prosynth && tar -xzvf benchmarks.tar.gz

# RUN cd ./egs-artifact/EGS && \
 #   sbt assembly

CMD /bin/bash

########################################################################################################################

# sudo docker build -t IMAGE_NAME .
# sudo docker images
# sudo docker run -it IMAGE_NAME /bin/bash

########################################################################################################################
