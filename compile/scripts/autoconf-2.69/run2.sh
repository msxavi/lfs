sed '361 s/{/\\{/' -i bin/autoscan.in
./configure --prefix=/usr
make
make install
