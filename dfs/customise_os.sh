apt install -y network-manager wget \
  net-tools wireless-tools ssh gcc bc \
  make flex libssl-dev libelf-dev bison \
  dosfstools nano xz-utils

apt-get clean

echo > /etc/motd
echo > /etc/motd.d

echo "xavios" > /etc/hostname
echo "XaviOS Linux 2020" > /etc/issue.net

cat > /etc/issue << "EOF"
XaviOS \s-\r_\m \l

EOF

cat > /etc/profile << "EOF"
export LANG=en_AU.UTF-8

if [[ $EUID == 0 ]] ; then
    PS1="\[\e[1;31m\]\u\[\e[0m\]@\h \W# "
else
    PS1="\[\e[1;32m\]\u\[\e[0m\]@\h \W\$ "
fi
EOF

cat > /etc/update-motd.d/10-uname << "EOF"
#!/bin/bash
cat /etc/issue.net
EOF

cat > /usr/lib/os-release << "EOF"
PRETTY_NAME="XaviOS Linux 2020"
NAME="XaviOS"
VERSION_ID="2020"
VERSION=""
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
EOF

passwd root

wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.7.tar.xz
tar -xf linux-5.5.7.tar.xz
cd linux-5.5.7
make mrproper
make defconfig

echo "cp -v arch/x86/boot/bzImage /boot/vmlinuz-xavios-5.5.7"
echo "cp -v System.map /boot/System.map-5.5.7"
echo "cp -v .config /boot/config-5.5.7"

echo "Done. Customise kernel or go and execute customise_02.sh"

