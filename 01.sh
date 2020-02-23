mkfs -v -t ext4 $PART

mkdir -pv $LFS
mount -v -t ext4 $PART $LFS

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
cp -v $SCRIPT_DIR/sources/* $LFS/sources
cp -v $LFS/sources/gcc-9.2.0.tar.xz $LFS/sources/gcc-9.2.0-2.tar.xz
cp -v $LFS/sources/gcc-9.2.0.tar.xz $LFS/sources/gcc-9.2.0-3.tar.xz
cp -v $LFS/sources/binutils-2.34.tar.xz $LFS/sources/binutils-2.34-2.tar.xz

rm -rf $LFS/tools
mkdir -v $LFS/tools
ln -sv $LFS/tools /

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources

echo "Now execute: 'su - lfs' and proceed to script 02.sh"
