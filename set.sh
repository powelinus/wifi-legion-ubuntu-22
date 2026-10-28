ls -lah /lib/firmware/rtw89/rtw8922a_fw*
dpkg -l firmware-realtek linux-firmware

#============================
sudo mkdir -p /lib/firmware/rtw89

cd /tmp

for fw in \
    rtw8922a_fw.bin \
    rtw8922a_fw-1.bin \
    rtw8922a_fw-2.bin \
    rtw8922a_fw-3.bin \
    rtw8922a_fw-4.bin
do
    sudo curl -fL \
      "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/rtw89/$fw" \
      -o "/lib/firmware/rtw89/$fw" || break
done

#================================
ls -lh /lib/firmware/rtw89/rtw8922a_fw*
sudo modprobe -r rtw89_8922ae_git
sudo modprobe rtw89_8922ae_git
sudo systemctl restart NetworkManager
nmcli device status
sudo journalctl -k -b --no-pager | grep -iE 'rtw89|firmware' | tail -40
nmcli device wifi list
