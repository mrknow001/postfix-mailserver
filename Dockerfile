FROM ubuntu:latest

WORKDIR /app

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
&& sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
&& apt clean \
&& apt-get update -y \
&& apt install rsyslog -y \
&& apt install postfix postfix-mysql dovecot-core dovecot-pop3d dovecot-imapd dovecot-lmtpd dovecot-mysql mysql-client -y \
&& apt install tzdata -y

COPY start.sh /app
COPY fullchain.pem /app
COPY privkey.pem /app

CMD /bin/sh /app/start.sh

