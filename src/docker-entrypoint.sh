#!/bin/sh

addgroup \
	-g $GID \
	-S \
	$FTP_USER

adduser \
	-D \
	-G $FTP_USER \
	-h /home/$FTP_USER \
	-s /bin/false \
	-u $UID \
	$FTP_USER

mkdir -p /home/$FTP_USER
chown root:root /home/$FTP_USER/$MAIN_DIR
chmod 755 /home/$FTP_USER/$MAIN_DIR
echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log | tee /dev/stdout &
touch /var/log/xferlog
tail -f /var/log/xferlog | tee /dev/stdout &

/usr/sbin/vsftpd
