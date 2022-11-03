# postfix-mailserver
一键部署邮件服务器(postfix+dovecot)


启动
·docker-compose up -d·
第二次使用，·docker ps -a·查看对应docker，使用docker start [CONTAINER ID]启动，如果在使用docker-compose up -d会报错，因为做了目录映射的

需要注意的是，根据客户端不同，需要改下配置使用TSL还是SSL
### 打开加密端口(smtp +SSL:465)

```
 $ vim /etc/postfix/master.cf
 加入如下几行：
 smtps     inet  n       -       n       -       -       smtpd
 -o syslog_name=postfix/smtps
 -o smtpd_tls_wrappermode=yes
 -o smtpd_sasl_auth_enable=yes
 -o smtpd_reject_unlisted_recipient=no
```

### 打开加密端口（smtp +TLS:587）

```
 $ vim /etc/postfix/master.cf
 加入如下几行：
 submission inet n       -       n       -       -       smtpd
```

如果开启TLS gophish可发邮件，foxmail无法发送
如果开启SSL foxmail可发邮件，gophish无法使用

配置完后重启postfix

sudo service postfix restart
