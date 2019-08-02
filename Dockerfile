FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER LFelipedeOliveira <felipe@neoprospecta.com>

RUN apt-get -y update; \
  apt-get -y upgrade; \
  apt-get -y install python3 build-essential zlibc libc6 gcc g++ libboost1.54-all-dev cmake python3-pip; \
  apt-get -y install wget; \
  apt-get -y install software-properties-common python-software-properties unzip; \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections; \
  add-apt-repository -y ppa:webupd8team/java; \
  apt-get update; \
  apt-get install -y oracle-java8-installer; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/cache/oracle-jdk8-installer; \
  apt-get clean

RUN wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-tar.zip; \
    unzip bcl2fastq2-v2-20-0-tar.zip; \
	tar -zxf bcl2fastq2-v2.20.0.422-Source.tar.gz; \
    mkdir /tmp/bcl2fastq2-v2-20-0-build

WORKDIR /tmp/bcl2fastq2-v2-20-0-build

RUN /bcl2fastq/src/configure --prefix=/usr/local; \
    make && make install; \
    rm /bcl2fastq2-v2-20-0-tar.zip; \
	rm /bcl2fastq2-v2.20.0.422-Source.tar.gz; \
    rm -r /bcl2fastq; \
    rm -r /tmp/bcl2fastq2-v2-20-0-build

WORKDIR /

