#! /bin/bash

wget http://fast.dpdk.org/rel/dpdk-18.11.tar.xz
tar -xvf dpdk-18.11.tar.xz
cd dpdk-18.11
make config T=x86_64-native-linuxapp-gcc
sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config
make
make -C examples RTE_SDK=$(pwd) RTE_TARGET=build O=$(pwd)/build/examples
