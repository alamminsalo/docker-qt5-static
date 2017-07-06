FROM        ubuntu:16.04
MAINTAINER  Antti Lamminsalo <antti.lamminsalo@gmail.com>

RUN apt-key update && apt-get update
RUN apt-get install -y build-essential perl python git wget
RUN apt-get install -y '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev
RUN apt-get install -y libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev libxfixes-dev libxcb1-dev libxcb-glx0-dev

# openssl
RUN cd && wget https://www.openssl.org/source/openssl-1.0.2l.tar.gz
RUN cd && tar -xvf openssl-1.0.2l.tar.gz \ 
	&& rm -f openssl-1.0.2l.tar.gz \
	&& cd openssl-1.0.2l && ./Configure linux-x86_64 -O3 && make && make install
ENV OPENSSL_LIBS '-L/usr/local/ssl/lib -lssl -lcrypto'

# qt 5.9.0
RUN cd ~ && wget http://download.qt.io/official_releases/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz -O qt-5.9.tar.xz

RUN cd ~ && tar -xvf qt-5.9.tar.xz && rm -f qt-5.9.tar.xz

RUN cd ~/qt-everywhere-opensource-src-5.9.0 && \
	./configure -confirm-license -opensource -release \
	-prefix /opt/Qt -skip qtconnectivity -static \
	-openssl-linked -skip multimedia -skip winextras \
	-skip activeqt -skip location -skip webchannel \
	-skip webkit -skip androidextras -skip macextras \
	-skip serialport -skip webengine \
	-nomake tools -nomake demos -nomake examples -I/usr/local/ssl/include -qt-xcb
RUN cd ~/qt-everywhere-opensource-src-5.9.0 && make
RUN cd ~/qt-everywhere-opensource-src-5.9.0 && make install
ENV PATH $PATH:/opt/Qt/bin

# cleanup
RUN rm -rf ~/openssl-1.0.2l
RUN rm -rf ~/qt-everywhere-opensource-src-5.9.0



