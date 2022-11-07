# postfix-mailserver
一键部署邮件服务器(postfix+dovecot)

1、修改域名

start.sh文件192行修改title(可不改)，193修改域名


2、生成证书

通过cert.sh生成证书(脚本自动复制到当前目录，不要移动)


3、修改端口

编辑docker-compose.yml，目前是使用的[22465(smtp+ssl)、22587(smtp+tsl)](默认ssl)、22993(imap)、22995(pop3)、33333(mysql)


4、启动docker

`docker-compose up -d`

需要注意的是，根据客户端不同，需要改下配置使用TSL还是SSL


5、连接mysql创建用户
```
# 创建域名
insert into virtual_domains values(1,'域名');
# 创建用户
insert into virtual_users values(1,1,md5('密码'),'账号');
```
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


生成文件说明：
```
./mail/logs/postfix/mail.log
# postfix日志
./mail/logs/postfix/syslog
# docker系统日志
./mail/logs/dovecot/dovecot.log
# dovecot日志
./mail/data/*
# postfix队列文件
./mysql/conf/*
# mysql配置
./mysql/data/*
# mysql数据
```
![image](https://github.com/mrknow001/postfix-mailserver/blob/main/images/current-dir.png)
![image](https://github.com/mrknow001/postfix-mailserver/blob/main/images/logs-dir.png)
