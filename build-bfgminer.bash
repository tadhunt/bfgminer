#!/bin/bash -x

set -o nounset
set -o errexit

function getdeps {
	sudo apt-get install \
		build-essential \
		autoconf \
		automake \
		libtool \
		pkg-config \
		libcurl4-gnutls-dev \
		libjansson-dev \
		uthash-dev \
		libncursesw5-dev \
		libudev-dev \
		libusb-1.0-0-dev \
		libevent-dev \
		libmicrohttpd-dev \
		libhidapi-dev \
		yasm
}

function autogen {
	./autogen.sh
}

function config {
	export LDFLAGS="-Wl,-rpath -Wl,/Bitcoin/lib"
	./configure \
		--prefix=/Bitcoin \
		--disable-silent-rules \
		--enable-dependency-tracking \
		--disable-maintainer-mode \
		\
		--enable-other-drivers \
		--enable-broad-udevrules \
		--enable-keccak \
		--enable-sha256d \
		--enable-scrypt \
		--enable-cpumining \
		--enable-opencl \
		--enable-adl \
		\
		--disable-alchemist \
		--disable-bitforce \
		--disable-bitmain \
		--disable-icarus \
		--disable-dualminer \
		--disable-zeusminer \
		--disable-gridseed \
		--disable-avalon \
		--disable-avalonmm \
		--disable-knc \
		--disable-kncasic \
		--disable-modminer \
		--disable-cointerra \
		--disable-klondike \
		--disable-titan \
		--disable-x6500 \
		--disable-ztex \
		--disable-bifury \
		--disable-bitfury \
		--disable-bfsb \
		--disable-bigpic \
		--disable-bfx \
		--disable-drillbit \
		--disable-twinfury \
		--disable-littlefury \
		--disable-nanofury \
		--disable-hashbuster \
		--disable-hashbusterusb \
		--disable-hashfast \
		--disable-jingtian \
		--disable-metabank \
		--disable-minergate \
		--disable-minion \
		--disable-rockminer

	unset LDFLAGS
}

getdeps
autogen
config
make
make install
