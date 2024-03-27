# FTP Server with main directory

A simple FTP server, using
[`vsftpd`](https://security.appspot.com/vsftpd.html).

## Fork's difference
**I (https://github.com/liamtoaldo)** forked the original repository to automatically create a main directory inside the ftp volume and to prevent the ftp user to delete any directory inside the main directory, while still being able to delete all its subdirs and files.
For security purposes.

The main directory can be specified inside the environment with
`MAIN_DIR`. See the examples below.

## How to use this image

### start a FTP Server instance

To start a container, with data stored in `/data` on the host, use the
following:

```sh
docker run \
	--detach \
	--env FTP_PASS=123 \
	--env FTP_USER=user \
  --env MAIN_DIR=files \
	--name my-ftp-server \
	--publish 20-21:20-21/tcp \
	--publish 40000-40009:40000-40009/tcp \
	--volume /data:/home/user \ # could also be --volume /data:/home/user/files
	garethflowers/ftp-server
```

### ... via `docker compose`

```yml
services:
  ftp-server:
    container_name: my-ftp-server
    environment:
      - FTP_PASS=123
      - FTP_USER=user
      - MAIN_DIR=files
    image: garethflowers/ftp-server
    ports:
      - '20-21:20-21/tcp'
      - '40000-40009:40000-40009/tcp'
    volumes:
      - '/data:/home/user/files'
```

## License

-   This image is released under the
    [MIT License](https://raw.githubusercontent.com/garethflowers/docker-ftp-server/master/LICENSE).
