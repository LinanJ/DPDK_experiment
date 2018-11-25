#!/bin/sh
cd /usr/src/
wget http://fast.dpdk.org/rel/dpdk-17.11.4.tar.xz
tar xf dpdk-17.11.4.tar.xz
export DPDK_DIR=/usr/src/dpdk-stable-17.11.4
cd $DPDK_DIR
sed -i "s/CONFIG_RTE_BUILD_SHARED_LIB=n/CONFIG_RTE_BUILD_SHARED_LIB=y/g" config/common_base
sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config
export DPDK_TARGET=x86_64-native-linuxapp-gcc
export DPDK_BUILD=$DPDK_DIR/$DPDK_TARGET
export EXTRA_CFLAGS="-O0 -g"
sed -i "s/CONFIG_RTE_LIBRTE_PMD_AF_PACKET=n/CONFIG_RTE_LIBRTE_PMD_AF_PACKET=y/g" config/common_linuxapp
make install T=$DPDK_TARGET DESTDIR=install
