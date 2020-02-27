mkdir -p $LIVE_DIR/{testing,image/live}

mksquashfs \
    $LIVE_DIR/chroot \
    $LIVE_DIR/image/live/filesystem.squashfs \
    -e boot

cp $LIVE_DIR/chroot/boot/vmlinuz-* \
    $LIVE_DIR/image/vmlinuz
cp $LIVE_DIR/chroot/boot/initrd.img-* \
    $LIVE_DIR/image/initrd

cat <<EOF >$LIVE_DIR/testing/grub.cfg
search --set=root --file /XAVIOS

insmod all_video

set default="0"
set timeout=5

menuentry "XaviOS Linux Live" {
    linux /vmlinuz boot=live quiet nomodeset
    initrd /initrd
}
EOF

touch $LIVE_DIR/image/XAVIOS

ls -lh $LIVE_DIR
ls -lRh $LIVE_DIR/testing
ls -lRh $LIVE_DIR/image

grub-mkstandalone \
    --format=x86_64-efi \
    --output=$LIVE_DIR/testing/bootx64.efi \
    --locales="" \
    --fonts="" \
    "boot/grub/grub.cfg=$LIVE_DIR/testing/grub.cfg"

(cd $LIVE_DIR/testing && \
    dd if=/dev/zero of=efiboot.img bs=1M count=10 && \
    mkfs.vfat efiboot.img && \
    mmd -i efiboot.img efi efi/boot && \
    mcopy -i efiboot.img ./bootx64.efi ::efi/boot/
)

grub-mkstandalone \
    --format=i386-pc \
    --output=$LIVE_DIR/testing/core.img \
    --install-modules="linux normal iso9660 biosdisk memdisk search tar ls" \
    --modules="linux normal iso9660 biosdisk search" \
    --locales="" \
    --fonts="" \
    "boot/grub/grub.cfg=$LIVE_DIR/testing/grub.cfg"

cat \
    /usr/lib/grub/i386-pc/cdboot.img \
    $LIVE_DIR/testing/core.img \
> $LIVE_DIR/testing/bios.img

xorriso \
    -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -volid "XAVIOS" \
    -eltorito-boot \
        boot/grub/bios.img \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        --eltorito-catalog boot/grub/boot.cat \
    --grub2-boot-info \
    --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img \
    -eltorito-alt-boot \
        -e EFI/efiboot.img \
        -no-emul-boot \
    -append_partition 2 0xef $LIVE_DIR/testing/efiboot.img \
    -output "$LIVE_DIR/xavios-2020.iso" \
    -graft-points \
        "$LIVE_DIR/image" \
        /boot/grub/bios.img=$LIVE_DIR/testing/bios.img \
        /EFI/efiboot.img=$LIVE_DIR/testing/efiboot.img

ls -lh $LIVE_DIR/*.iso

