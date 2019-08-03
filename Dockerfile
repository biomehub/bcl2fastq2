FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER BiomeHub

LABEL version="2.20.0"
LABEL software.version="2.20.0"
LABEL software="bcl2fastq2"

RUN apt-get -y update; \
  apt-get -y upgrade; \
  apt-get -y install build-essential zlibc libc6 gcc g++ libboost1.54-all-dev cmake; \
  apt-get -y install wget; \
  apt-get -y install unzip; \
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

