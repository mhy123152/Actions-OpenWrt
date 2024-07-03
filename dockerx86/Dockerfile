FROM scratch

ARG ROOTFS_FILE="openwrt-x86-64-default-rootfs-patched.tar"

ADD $ROOTFS_FILE /
EXPOSE 22 80
# using exec format so that /sbin/init is proc 1 (see procd docs)
ENTRYPOINT ["/sbin/init"]
