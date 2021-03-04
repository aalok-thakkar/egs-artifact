FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

########################################################################################################################
# 0. Dependencies

RUN apt-get update; \
    apt-get install -y git autoconf automake make \
                       gcc g++ mcpp \
                       python python3 openjdk-8-jdk \
                       flex bison \
                       sqlite libsqlite-dev sqlite3 libsqlite3-dev \
                       zlib1g zlib1g-dev \
                       doxygen libncurses5-dev libtool libffi-dev wget python3-matplotlib graphviz gnupg2 \
                       task-spooler procps passwd openssh-server vim curl unzip zip bc

########################################################################################################################
# 1. EGS

RUN git clone https://github.com/aalok-thakkar/egs-artifact.git; \
    bash egs-artifact/scripts/setup-sbt.sh
RUN cd egs-artifact/egs/ && sbt assemble
########################################################################################################################
# 2. Prosynth

RUN cd /root; \
    wget -c https://github.com/Z3Prover/z3/archive/z3-4.8.6.tar.gz; \
    tar -xf z3-4.8.6.tar.gz; \
    cd z3-z3-4.8.6; \
      mkdir -p /usr/local/lib/python3.6/dist-packages; \
      python scripts/mk_make.py --python --pypkgdir=/usr/local/lib/python3.6/dist-packages; \
      cd build; \
        make -j 8; \
        make install; \
    cd /; egs-artifact/scripts/build-souffle.sh; \
    cd /egs-artifact/prosynth; tar -xzvf benchmarks.tar.gz

########################################################################################################################
# 3. ILASP

########################################################################################################################
# 4. Scythe

########################################################################################################################
# 5. Conclusion

CMD /bin/bash
WORKDIR egs-artifact
