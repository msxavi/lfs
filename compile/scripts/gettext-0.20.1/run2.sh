./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.20.1

make
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so
