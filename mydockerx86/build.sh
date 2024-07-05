#!/bin/bash

DOCKER_USER=$1
DOCKER_REPO=$2
TAG=latest
if [ ! -z "$3" ];then
	TAG=$3
fi
TMPDIR=openwrt_rootfs
OUTDIR=/root/mydockerx86/
IMG_NAME=${DOCKER_USER}/${DOCKER_REPO}

[ -d "$TMPDIR" ] && rm -rf "$TMPDIR"
sudo apt-get install pigz
mkdir -p "$TMPDIR"  && \
gzip -dc rootfs.tar.gz | ( cd "$TMPDIR" && tar xf - ) && \
rm -f "$TMPDIR/etc/bench.log" && \
sss=$(date +%s) && \
ddd=$((sss/86400)) && \
sed -e "s/:0:0:99999:7:::/:${ddd}:0:99999:7:::/" -i "${TMPDIR}/etc/shadow" && \
rm -rf "$TMPDIR/lib/firmware/*" "$TMPDIR/lib/modules/*" "$TMPDIR/dev/*" && \
(cd "$TMPDIR" && tar cf ../openwrt-x86-64-default-rootfs-patched.tar .) && \
rm -f DockerImg-OpenwrtArm64-${TAG}.gz && \
docker build -t ${IMG_NAME}:${TAG} . && \
rm -f  openwrt-x86-64-default-rootfs-patched.tar && \
rm -rf "$TMPDIR" && \
docker save ${IMG_NAME}:${TAG} | pigz -9 > docker-img-openwrt.gz
