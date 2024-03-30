FROM alpine:3.19.1
ENV FTP_USER=foo \
	FTP_PASS=bar \
	GID=1000 \
	UID=1000 \
	PASV_MIN_PORT=40000 \
    PASV_MAX_PORT=40009


RUN apk add --no-cache --update \
	vsftpd==3.0.5-r2

COPY [ "/src/vsftpd.conf", "/etc" ]
COPY [ "/src/docker-entrypoint.sh", "/" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]
# Passive ports are dynamically configured via PASV_MIN_PORT and PASV_MAX_PORT environment variables
EXPOSE 20/tcp 21/tcp
HEALTHCHECK CMD netstat -lnt | grep :21 || exit 1
