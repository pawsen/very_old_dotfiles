#!/bin/bash
sshfs -o IdentityFile=~/.ssh/dtumnt s082705@hald.gbar.dtu.dk: ~/dtumnt
# fusermount -u ~/dtumnt # to unmount
# hvis connection ikke lykkes,eg. error: fuse: bad mount point /mnt/foo: Transport endpoint is not connected
# se http://www.nicolaskuttler.com/post/sshfs-transport-endpoint-not-connecte/
