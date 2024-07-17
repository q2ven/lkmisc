QEMU_CMDLINE="nokaslr rw audit=0 raid=noautodetect"
ROOTFS="BASEDIR/rootfs.ext4"
ROOTFS_MOUNT="BASEDIR/rootfs"

if [ "$(uname -m)" = "x86_64" ]; then
    QEMU=qemu-system-x86_64
    QEMU_OPTION=""
    QEMU_CMDLINE="$QEMU_CMDLINE root=/dev/sda console=ttyS0,115200"
    BZIMAGE="./arch/x86/boot/bzImage"
else
    QEMU=qemu-system-aarch64
    QEMU_OPTION="-machine virt"
    QEMU_CMDLINE="$QEMU_CMDLINE root=/dev/vda console=ttyAMA0"
    BZIMAGE="./arch/arm64/boot/Image.gz"
fi

function qk() {
    $QEMU -boot c -m 4G -enable-kvm -cpu host -smp 4 \
	  -kernel $BZIMAGE -hda $ROOTFS -append "$QEMU_CMDLINE" \
	  -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp:127.0.0.1:10022-:22 \
	  -serial stdio -display none \
	  $QEMU_OPTION $@
    #      -cpu Skylake-Server-v4"
}

alias qs="ssh -oStrictHostKeyChecking=no root@localhost -p 10022"

alias qm="sudo mount -o loop ${ROOTFS} ${ROOTFS_MOUNT}"
alias qu="sudo umount ${ROOTFS_MOUNT}"

qcp() {
    scp -oStrictHostKeyChecking=no -P10022 $1 root@localhost:~/
}

qksig() {
    stty -isig
    qk $@
    stty isig
}
