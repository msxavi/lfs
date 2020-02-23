strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*

rm -rf /tools/{,share}/{info,man,doc}

find /tools/{lib,libexec} -name \*.la -delete

cp -vR $LFS/tools $LFS/tools_bkp
chown -R root:root $LFS/tools

echo "Done. Now proceed to compile/02.sh"
