cp -iv arch/x86/boot/bzImage /boot/vmlinuz-5.5.4-xavios
cp -iv System.map /boot/System.map-5.5.4
cp -iv .config /boot/config-5.5.4

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

grub-install /dev/sda

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,3)

menuentry "XaviOS GNU/Linux 5.5.4" {
        linux   /boot/vmlinuz-5.5.4-xavios root=/dev/sda3 ro
}
EOF

cat > /etc/lsb-release << "EOF"
DISTRIB_ID="XaviOS"
DISTRIB_RELEASE="2020"
DISTRIB_CODENAME="2020"
DISTRIB_DESCRIPTION="XaviOS"
EOF

cat > /etc/os-release << "EOF"
NAME="XaviOS"
VERSION="2020"
ID=xavios
PRETTY_NAME="XaviOS 2020"
VERSION_CODENAME="2020"
EOF
