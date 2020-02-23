mkdir -pv $LFS/{dev,proc,sys,run,scripts}

mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

mount -v --bind /dev $LFS/dev
mount -v --bind $SCRIPT_DIR $LFS/scripts

mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

echo "Done. Exec chroot now (6.4) and go to compile/03.sh"

#chroot "$LFS" /tools/bin/env -i \
#    HOME=/root                  \
#    TERM="$TERM"                \
#    PS1='(lfs chroot) \u:\w\$ ' \
#    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
#    /tools/bin/bash --login +h
