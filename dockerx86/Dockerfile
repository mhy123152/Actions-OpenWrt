FROM scratch

ARG ROOTFS_FILE="openwrt-x86-64-default-rootfs-patched.tar"

ADD $ROOTFS_FILE /
EXPOSE 22 80
# using exec format so that /sbin/init is proc 1 (see procd docs)
ENTRYPOINT ["/sbin/init"]

# FROM scratch

# ARG ROOTFS_FILE="openwrt-x86-64-default-rootfs-patched.tar"
# ARG USER=root
# ARG CMD="/bin/bash"

# USER $USER
# WORKDIR /

# ADD $ROOTFS_FILE /

# EXPOSE 22 80 443

# ENTRYPOINT ["/sbin/init"]

# # required to have CMD as ENV to be executed
# ENV CMD_ENV=${CMD}
# CMD ${CMD_ENV}