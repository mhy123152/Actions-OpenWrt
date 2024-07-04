#!/bin/bash

TAG=latest
TMPDIR=openwrt_rootfs
OUTDIR=/root/dockerx86/
IMG_NAME=mhy123152/openwrt-rootfs

[ -d "$TMPDIR" ] && rm -rf "$TMPDIR"
sudo apt-get install pigz
mkdir -p "$TMPDIR"  && \
gzip -dc openwrt-x86-64-default-rootfs.tar.gz | ( cd "$TMPDIR" && tar xf - ) && \
rm -f "$TMPDIR/etc/bench.log" && \
sss=$(date +%s) && \
ddd=$((sss/86400)) && \
sed -e "s/:0:0:99999:7:::/:${ddd}:0:99999:7:::/" -i "${TMPDIR}/etc/shadow" && \
rm -rf "$TMPDIR/lib/firmware/*" "$TMPDIR/lib/modules/*" && \
(cd "$TMPDIR" && tar cf ../openwrt-x86-64-default-rootfs-patched.tar .) && \
rm -f DockerImg-OpenwrtArm64-${TAG}.gz && \
docker build -t ${IMG_NAME}:${TAG} . && \
rm -f  openwrt-x86-64-default-rootfs-patched.tar && \
rm -rf "$TMPDIR" && \
docker save ${IMG_NAME}:${TAG} | pigz -9 > docker-img-openwrt-x86-${TAG}.gz
