# postfix-mailserver
一键部署邮件服务器(postfix+dovecot)


启动
·docker-compose up -d·
第二次使用，·docker ps -a·查看对应docker，使用docker start [CONTAINER ID]启动，如果在使用docker-compose up -d会报错，因为做了目录映射的

需要注意的是，根据客户端不同，需要改下配置
