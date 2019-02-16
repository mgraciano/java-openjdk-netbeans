FROM adoptopenjdk/openjdk11:x86_64-ubuntu-jdk-11.0.2.9

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libxrender1 \
        libxtst6 \
        libxi6 \
        libfontconfig1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV HOME /home/netbeans

RUN adduser --disabled-password --gecos '' netbeans && \
    mkdir -m 700 /data && \
    mkdir -m 700 $HOME/.netbeans && \
    mkdir -m 700 $HOME/NetBeansProjects && \
    chown -R netbeans:netbeans /data $HOME/.netbeans $HOME/NetBeansProjects

VOLUME ~/.netbeans
VOLUME ~/.cache
VOLUME ~/.m2
VOLUME ~/NetBeansProjects

USER netbeans

ADD incubating-netbeans-10.0-bin.tar.xz /home/netbeans

COPY netbeans.conf /home/netbeans/netbeans/etc

CMD ~/netbeans/bin/netbeans