#! /bin/bash

wget http://fast.dpdk.org/rel/dpdk-18.11.tar.xz
tar -xvf dpdk-18.11.tar.xz
cd dpdk-18.11
make config T=x86_64-native-linuxapp-gcc
sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config
make
mkdir -p /mnt/huge
mount -t hugetlbfs nodev /mnt/huge
echo 64 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
make -C examples RTE_SDK=$(pwd) RTE_TARGET=build O=$(pwd)/build/examples
