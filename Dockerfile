FROM ubuntu:17.10

WORKDIR /

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y wget git make && \
	apt-get install -y bzip2 gcc zlib1g-dev libbz2-dev liblzma-dev && \
	apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev

RUN mkdir /software
RUN mkdir /software/tclap-1.2.2

RUN mkdir /software/htslib && \
	wget https://github.com/samtools/htslib/releases/download/1.7/htslib-1.7.tar.bz2 && \
	tar -vxjf /htslib-1.7.tar.bz2 && \
	rm /htslib-1.7.tar.bz2 && \
	cd /htslib-1.7 && \
	./configure --prefix=/software/htslib && \
	make && \
	make install
ENV PATH="/software/htslib/bin:${PATH}"

RUN mkdir /software/tclap && \
	wget https://sourceforge.net/projects/tclap/files/tclap-1.2.2.tar.gz && \
	tar -xzf /tclap-1.2.2.tar.gz && \
	rm /tclap-1.2.2.tar.gz && \
	cd /tclap-1.2.2 && \
	./configure --prefix=/software/tclap && \
	make && \
	make install
ENV PATH="/software/htslib/bin:${PATH}"

RUN cd /software && \
	git clone https://github.com/atks/Rmath.git && \
	cd /software/Rmath && \
	make

RUN mkdir /software/pcre && \
	wget https://sourceforge.net/projects/pcre/files/pcre2/10.31/pcre2-10.31.tar.gz && \
	tar -xzf /pcre2-10.31.tar.gz && \
	rm /pcre2-10.31.tar.gz && \
	cd /pcre2-10.31 && \
	./configure && \
	make && \
	make install
# ENV PATH="/software/pcre/bin:${PATH}"

RUN cd /software/ && \
	git clone https://github.com/cjlin1/libsvm.git && \
	cd /software/libsvm/ && \
	make 

RUN cd /software/ && \
	git clone https://github.com/atks/vt.git && \
	cd /software/vt/ && \
	make
