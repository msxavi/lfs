echo "--- Installing dependencies..."
echo ""
apt update && apt install -y debootstrap \
  squashfs-tools \
  xorriso \
  grub-pc-bin \
  grub-efi-amd64-bin \
  mtools \
  dosfstools

echo "--- Initiating debootstrap..."
echo ""
debootstrap \
--arch=amd64 \
--variant=minbase \
--include=systemd-sysv,live-boot \
bullseye \
$LIVE_DIR/chroot \
http://ftp.au.debian.org/debian

#cp -v customise_os.sh $LIVE_DIR/chroot

#echo "--- Entering chroot..."
#chroot $LIVE_DIR/chroot
