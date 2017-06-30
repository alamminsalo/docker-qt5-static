FROM        ubuntu
MAINTAINER  Antti Lamminsalo <antti.lamminsalo@gmail.com>

RUN apt-key update && apt-get update
RUN apt-get install -y build-essential perl python git wget libgl1-mesa-dev

# openssl
RUN cd && wget https://www.openssl.org/source/openssl-1.0.2l.tar.gz
RUN cd && tar -xvf openssl-1.0.2l.tar.gz \ 
	&& rm -f openssl-1.0.2l.tar.gz \
	&& cd openssl-1.0.2l && ./Configure linux-x86_64 && make && make install
ENV OPENSSL_LIBS '-L/usr/local/ssl/lib -lssl -lcrypto'

# qt 5.9.0
RUN cd ~ && wget http://download.qt.io/official_releases/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz -O qt-5.9.tar.xz

RUN cd ~ && tar -xvf qt-5.9.tar.xz && rm -f qt-5.9.tar.xz

RUN cd ~/qt-everywhere-opensource-src-5.9.0 && \
	./configure -confirm-license -opensource -nomake examples \
	-nomake tests -no-compile-examples -no-xcb \
	-prefix /opt/Qt -skip qtconnectivity -static \
	-openssl-linked -skip multimedia -skip winextras \
	-skip activeqt -skip location -skip webchannel \
	-skip webkit -skip androidextras -skip macextras \
	-skip quick1 -skip wayland -skip serialport \
	-skip enginio -skip webengine -nomake tools -I/usr/local/ssl/include
RUN cd ~/qt-everywhere-opensource-src-5.9.0 && make -j4
RUN cd ~/qt-everywhere-opensource-src-5.9.0 && make install

# cleanup
RUN rm -rf ~/openssl-1.0.2l
RUN rm -rf ~/qt-everywhere-opensource-src-5.9.0



