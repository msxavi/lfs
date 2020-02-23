declare -a arr=("zlib-1.2.11.tar.xz" "bzip2-1.0.8.tar.gz" "xz-5.2.4.tar.xz" "file-5.38.tar.gz" "readline-8.0.tar.gz" "m4-1.4.18.tar.xz" "bc-2.5.3.tar.gz"
  "binutils-2.34.tar.xz" "gmp-6.2.0.tar.xz" "mpfr-4.0.2.tar.xz" "mpc-1.1.0.tar.gz" "attr-2.4.48.tar.gz" "acl-2.2.53.tar.gz"
  "shadow-4.8.1.tar.xz" "gcc-9.2.0.tar.xz" "pkg-config-0.29.2.tar.gz" "ncurses-6.1.tar.gz" "libcap-2.31.tar.xz" "sed-4.8.tar.xz" "psmisc-23.2.tar.xz"
  "iana-etc-2.30.tar.bz2" "bison-3.5.1.tar.xz" "flex-2.6.4.tar.gz" "grep-3.4.tar.xz" "bash-5.0.tar.gz" "libtool-2.4.6.tar.xz" "gdbm-1.18.1.tar.gz" "gperf-3.1.tar.gz"
  "expat-2.2.9.tar.xz" "inetutils-1.9.4.tar.xz" "perl-5.30.1.tar.xz" "XML-Parser-2.46.tar.gz" "intltool-0.51.0.tar.gz" "autoconf-2.69.tar.xz" "automake-1.16.1.tar.xz"
  "kmod-26.tar.xz" "gettext-0.20.1.tar.xz" "elfutils-0.178.tar.bz2" "libffi-3.3.tar.gz" "openssl-1.1.1d.tar.gz" "Python-3.8.1.tar.xz" "ninja-1.10.0.tar.gz" "meson-0.53.1.tar.gz"
  "coreutils-8.31.tar.xz" "check-0.14.0.tar.gz" "diffutils-3.7.tar.xz" "gawk-5.0.1.tar.xz" "findutils-4.7.0.tar.xz" "groff-1.22.4.tar.gz" "grub-2.04.tar.xz" "less-551.tar.gz"
  "gzip-1.10.tar.xz" "zstd-1.4.4.tar.gz" "iproute2-5.5.0.tar.xz" "kbd-2.2.0.tar.xz" "libpipeline-1.5.2.tar.gz" "make-4.3.tar.gz" "patch-2.7.6.tar.xz" "man-db-2.9.0.tar.xz"
  "tar-1.32.tar.xz" "texinfo-6.7.tar.xz" "nano-4.8.tar.xz" "procps-ng-3.3.15.tar.xz" "util-linux-2.35.1.tar.xz" "e2fsprogs-1.45.5.tar.gz" "sysklogd-1.5.1.tar.gz"
  "sysvinit-2.96.tar.xz" "eudev-3.2.9.tar.gz")

touch compile2.log
for tarFile in "${arr[@]}"
do
  tarDir=$(echo "${tarFile%.*.*}")
  echo "Extracting $tarFile ..."
  sleep 3
  mkdir -v $tarDir && tar -xf $tarFile -C $tarDir --strip-components 1
  cd $tarDir
  bash $SCRIPT_DIR/compile/scripts/${tarDir}/run2.sh
  cd ..
  rm -rf $tarDir
  echo "$tarFile Succeeded!" >> compile2.log
done

rm -rf /tmp/*

echo "Done. Logout, renter chroot (6.81) and execute chroot/01.sh"

#chroot "$LFS" /usr/bin/env -i          \
#    HOME=/root TERM="$TERM"            \
#    PS1='(lfs chroot) \u:\w\$ '        \
#    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
#    /bin/bash --login
