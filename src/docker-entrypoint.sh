#!/bin/sh
# Add the passive ports configuration dynamically
echo "pasv_max_port=${PASV_MAX_PORT}" >> /etc/vsftpd.conf
echo "pasv_min_port=${PASV_MIN_PORT}" >> /etc/vsftpd.conf

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
mkdir -p /home/$FTP_USER/$MAIN_DIR
chown -R $FTP_USER:$FTP_USER /home/$FTP_USER/$MAIN_DIR
chown root:root /home/$FTP_USER
chmod 755 /home/$FTP_USER

echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log | tee /dev/stdout &
touch /var/log/xferlog
tail -f /var/log/xferlog | tee /dev/stdout &

/usr/sbin/vsftpd
