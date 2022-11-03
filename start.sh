#!/bin/sh

# 开启postfix日志记录
sed -i '/imklog/s/^/#/' /etc/rsyslog.conf
sed -i 's/\/var\/log\/mail/\/var\/log\/postfix\/mail/' /etc/rsyslog.d/50-default.conf
/usr/sbin/rsyslogd

# 配置/etc/postfix/main.cf文件
sed -i 's/^myhostname.*/myhostname = sctei.com.cn/' /etc/postfix/main.cf
sed -i 's/^#myorigin.*/myorigin = $myhostname/' /etc/postfix/main.cf
sed -i 's/^mydestination.*/mydestination = localhost/' /etc/postfix/main.cf
# 删除配置
sed -i 's/^message_size_limit.*//' /etc/postfix/main.cf
sed -i 's/^default_process_limit.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_tls_cert_file.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_tls_key_file.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_use_tls.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_tls_auth_only.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_sasl_type.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_sasl_path.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_sasl_auth_enable.*//' /etc/postfix/main.cf
sed -i 's/^smtpd_recipient_restrictions.*//' /etc/postfix/main.cf
sed -i 's/^virtual_transport.*//' /etc/postfix/main.cf
sed -i 's/^virtual_mailbox_domains.*//' /etc/postfix/main.cf
sed -i 's/^virtual_mailbox_maps.*//' /etc/postfix/main.cf
sed -i 's/^virtual_alias_maps.*//' /etc/postfix/main.cf
sed -i ':t;N;s/\n\n\n/\n\n/;b t' /etc/postfix/main.cf
# 重写配置
echo "Cm1lc3NhZ2Vfc2l6ZV9saW1pdCA9IDUxMjAwMDAwMApkZWZhdWx0X3Byb2Nlc3NfbGltaXQgPSA1MDAwCgpzbXRwZF90bHNfY2VydF9maWxlPS9hcHAvZnVsbGNoYWluLnBlbQpzbXRwZF90bHNfa2V5X2ZpbGU9L2FwcC9wcml2a2V5LnBlbQpzbXRwZF91c2VfdGxzPXllcwpzbXRwZF90bHNfYXV0aF9vbmx5ID0geWVzCgpzbXRwZF9zYXNsX3R5cGUgPSBkb3ZlY290CnNtdHBkX3Nhc2xfcGF0aCA9IHByaXZhdGUvYXV0aApzbXRwZF9zYXNsX2F1dGhfZW5hYmxlID0geWVzCnNtdHBkX3JlY2lwaWVudF9yZXN0cmljdGlvbnMgPSBwZXJtaXRfc2FzbF9hdXRoZW50aWNhdGVkLHBlcm1pdF9teW5ldHdvcmtzLHJlamVjdF91bmF1dGhfZGVzdGluYXRpb24KCnZpcnR1YWxfdHJhbnNwb3J0ID0gbG10cDp1bml4OnByaXZhdGUvZG92ZWNvdC1sbXRwCgp2aXJ0dWFsX21haWxib3hfZG9tYWlucyA9IG15c3FsOi9ldGMvcG9zdGZpeC9teXNxbC12aXJ0dWFsLW1haWxib3gtZG9tYWlucy5jZgp2aXJ0dWFsX21haWxib3hfbWFwcyA9IG15c3FsOi9ldGMvcG9zdGZpeC9teXNxbC12aXJ0dWFsLW1haWxib3gtbWFwcy5jZgp2aXJ0dWFsX2FsaWFzX21hcHMgPSBteXNxbDovZXRjL3Bvc3RmaXgvbXlzcWwtdmlydHVhbC1hbGlhcy1tYXBzLmNmCg==" |base64 -d >> /etc/postfix/main.cf
sed -i 's/smtpd_tls_cert_file=\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/#smtpd_tls_cert_file=\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/' /etc/postfix/main.cf
sed -i 's/smtpd_tls_key_file=\/etc\/ssl\/private\/ssl-cert-snakeoil.key/#smtpd_tls_key_file=\/etc\/ssl\/private\/ssl-cert-snakeoil.key/' /etc/postfix/main.cf
sed -i 's/smtpd_tls_security_level=may/#smtpd_tls_security_level=may/' /etc/postfix/main.cf
sed -i 's/smtp_tls_CApath=\/etc\/ssl\/certs/#smtp_tls_CApath=\/etc\/ssl\/certs/' /etc/postfix/main.cf
sed -i 's/smtp_tls_security_level=may/#smtp_tls_security_level=may/' /etc/postfix/main.cf
sed -i 's/smtp_tls_session_cache_database = btree:${data_directory}\/smtp_scache/#smtp_tls_session_cache_database = btree:${data_directory}\/smtp_scache/' /etc/postfix/main.cf
sed -i ':t;N;s/\n\n\n/\n\n/;b t' /etc/postfix/main.cf

# 配置数据库连接
u="user = root"
p="password = Asd123456Asd"
h="hosts = mysql"
d="dbname = mailserver"

touch /etc/postfix/mysql-virtual-mailbox-domains.cf
touch /etc/postfix/mysql-virtual-mailbox-maps.cf
touch /etc/postfix/mysql-virtual-alias-maps.cf
# 先删后增，防止反复追加
sed -i 's\^user.*\\' /etc/postfix/mysql-virtual-mailbox-domains.cf
sed -i 's\^password.*\\' /etc/postfix/mysql-virtual-mailbox-domains.cf
sed -i 's\^hosts.*\\' /etc/postfix/mysql-virtual-mailbox-domains.cf
sed -i 's\^dbname.*\\' /etc/postfix/mysql-virtual-mailbox-domains.cf
sed -i 's\^query.*\\' /etc/postfix/mysql-virtual-mailbox-domains.cf
echo $u >> /etc/postfix/mysql-virtual-mailbox-domains.cf
echo $p >> /etc/postfix/mysql-virtual-mailbox-domains.cf
echo $h >> /etc/postfix/mysql-virtual-mailbox-domains.cf
echo $d >> /etc/postfix/mysql-virtual-mailbox-domains.cf
echo "query = SELECT 1 FROM virtual_domains WHERE name='%s'" >> /etc/postfix/mysql-virtual-mailbox-domains.cf


sed -i 's\^user.*\\' /etc/postfix/mysql-virtual-mailbox-maps.cf
sed -i 's\^password.*\\' /etc/postfix/mysql-virtual-mailbox-maps.cf
sed -i 's\^hosts.*\\' /etc/postfix/mysql-virtual-mailbox-maps.cf
sed -i 's\^dbname.*\\' /etc/postfix/mysql-virtual-mailbox-maps.cf
sed -i 's\^query.*\\' /etc/postfix/mysql-virtual-mailbox-maps.cf
echo $u >> /etc/postfix/mysql-virtual-mailbox-maps.cf
echo $p >> /etc/postfix/mysql-virtual-mailbox-maps.cf
echo $h >> /etc/postfix/mysql-virtual-mailbox-maps.cf
echo $d >> /etc/postfix/mysql-virtual-mailbox-maps.cf
echo "query = SELECT 1 FROM virtual_users WHERE email='%s'" >> /etc/postfix/mysql-virtual-mailbox-maps.cf


sed -i 's\^user.*\\' /etc/postfix/mysql-virtual-alias-maps.cf
sed -i 's\^hosts.*\\' /etc/postfix/mysql-virtual-alias-maps.cf
sed -i 's\^password.*\\' /etc/postfix/mysql-virtual-alias-maps.cf
sed -i 's\^dbname.*\\' /etc/postfix/mysql-virtual-alias-maps.cf
sed -i 's\^query.*\\' /etc/postfix/mysql-virtual-alias-maps.cf
echo $u >> /etc/postfix/mysql-virtual-alias-maps.cf
echo $p >> /etc/postfix/mysql-virtual-alias-maps.cf
echo $h >> /etc/postfix/mysql-virtual-alias-maps.cf
echo $d >> /etc/postfix/mysql-virtual-alias-maps.cf
echo "query = SELECT destination FROM virtual_aliases WHERE source='%s'" >> /etc/postfix/mysql-virtual-alias-maps.cf
# 清除换行
sed -i ':t;N;s/\n\n\n/\n\n/;b t' /etc/postfix/mysql-virtual-mailbox-domains.cf
sed -i ':t;N;s/\n\n\n/\n\n/;b t' /etc/postfix/mysql-virtual-mailbox-maps.cf
sed -i ':t;N;s/\n\n\n/\n\n/;b t' /etc/postfix/mysql-virtual-alias-maps.cf
# 配置dovecot日志
sed -i 's/#log_path = syslog/log_path = \/var\/log\/dovecot\/dovecot.log/' /etc/dovecot/conf.d/10-logging.conf
sed -i 's/#info_log_path = /info_log_path = \/var\/log\/dovecot\/dovecot_info.log/' /etc/dovecot/conf.d/10-logging.conf
sed -i 's/#debug_log_path = /debug_log_path = \/var\/log\/dovecot\/dovecot_debug.log/' /etc/dovecot/conf.d/10-logging.conf
echo "L3Zhci9sb2cvZG92ZWNvdCoubG9nIHsKd2Vla2x5CnJvdGF0ZSA0Cm1pc3Npbmdvawpub3RpZmVtcHR5CmNvbXByZXNzCmVsYXljb21wcmVzcwpzaGFyZWRzY3JpcHRzCnBvc3Ryb3RhdGUKZG92ZWFkbSBsb2cgcmVvcGVuCmVuZHNjcmlwdH0K" > /etc/rsyslog.d/dovecot
cp /etc/rsyslog.d/dovecot /etc/logrotate.d/dovecot
mkdir /var/log/dovecot


# 修改/etc/dovecot/dovecot.conf文件
sed -i 's/#!include conf.d\/\*\.conf/!include conf.d\/\*\.conf/' /etc/dovecot/dovecot.conf
# 移除原来配置后追加
sed -i 's/protocols = imap lmtp pop3//' /etc/dovecot/dovecot.conf
echo "protocols = imap lmtp pop3" >> /etc/dovecot/dovecot.conf
sed -i ':t;N;s/\n\n\n/\n\n/;b t' /etc/dovecot/dovecot.conf

# 修改/etc/dovecot/conf.d/10-mail.conf文件
sed -i 's/mail_location = mbox\:\~\/mail\:INBOX=\/var\/mail\/\%u/mail_location = maildir\:\/var\/mail\/vhosts\/\%d\/\%n/' /etc/dovecot/conf.d/10-mail.conf
sed -i 's/#mail_privileged_group\s=\smail/mail_privileged_group = mail/' /etc/dovecot/conf.d/10-mail.conf

# 将该文件夹的所属人改为 vmail/vmail
groupadd -g 5000 vmail
useradd -g vmail -u 5000 vmail -d /var/mail
chown -R vmail:vmail /var/mail

# 修改/etc/dovecot/conf.d/10-auth.conf文件
sed -i 's/#disable_plaintext_auth = yes/disable_plaintext_auth = yes/' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/auth_mechanisms = plain$/auth_mechanisms = plain login/' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/!include auth-system.conf.ext/#!include auth-system.conf.ext/' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/#!include auth-sql.conf.ext/!include auth-sql.conf.ext/' /etc/dovecot/conf.d/10-auth.conf

# 修改/etc/dovecot/conf.d/auth-sql.conf.ext文件
echo "IyBBdXRoZW50aWNhdGlvbiBmb3IgU1FMIHVzZXJzLiBJbmNsdWRlZCBmcm9tIDEwLWF1dGguY29uZi4KIwojIDxkb2Mvd2lraS9BdXRoRGF0YWJhc2UuU1FMLnR4dD4KCnBhc3NkYiB7CiAgZHJpdmVyID0gc3FsCgogICMgUGF0aCBmb3IgU1FMIGNvbmZpZ3VyYXRpb24gZmlsZSwgc2VlIGV4YW1wbGUtY29uZmlnL2RvdmVjb3Qtc3FsLmNvbmYuZXh0CiAgYXJncyA9IC9ldGMvZG92ZWNvdC9kb3ZlY290LXNxbC5jb25mLmV4dAp9CgojICJwcmVmZXRjaCIgdXNlciBkYXRhYmFzZSBtZWFucyB0aGF0IHRoZSBwYXNzZGIgYWxyZWFkeSBwcm92aWRlZCB0aGUKIyBuZWVkZWQgaW5mb3JtYXRpb24gYW5kIHRoZXJlJ3Mgbm8gbmVlZCB0byBkbyBhIHNlcGFyYXRlIHVzZXJkYiBsb29rdXAuCiMgPGRvYy93aWtpL1VzZXJEYXRhYmFzZS5QcmVmZXRjaC50eHQ+CiN1c2VyZGIgewojICBkcml2ZXIgPSBwcmVmZXRjaAojfQoKdXNlcmRiIHsKICBkcml2ZXIgPSBzdGF0aWMKICBhcmdzID0gdWlkPXZtYWlsIGdpZD12bWFpbCBob21lPS92YXIvbWFpbC92aG9zdHMvJWQvJW4KfQoKIyBJZiB5b3UgZG9uJ3QgaGF2ZSBhbnkgdXNlci1zcGVjaWZpYyBzZXR0aW5ncywgeW91IGNhbiBhdm9pZCB0aGUgdXNlcl9xdWVyeQojIGJ5IHVzaW5nIHVzZXJkYiBzdGF0aWMgaW5zdGVhZCBvZiB1c2VyZGIgc3FsLCBmb3IgZXhhbXBsZToKIyA8ZG9jL3dpa2kvVXNlckRhdGFiYXNlLlN0YXRpYy50eHQ+CiN1c2VyZGIgewogICNkcml2ZXIgPSBzdGF0aWMKICAjYXJncyA9IHVpZD12bWFpbCBnaWQ9dm1haWwgaG9tZT0vdmFyL3ZtYWlsLyV1CiN9Cg==" |base64 -d > /etc/dovecot/conf.d/auth-sql.conf.ext

# 修改/etc/dovecot/dovecot-sql.conf.ext文件
sed -i 's/#driver = /driver = mysql/' /etc/dovecot/dovecot-sql.conf.ext
sed -i 's/#   connect = host=sql.example.com dbname=virtual user=virtual password=blarg/   connect = host=mysql port=3306 dbname=mailserver user=root password=Asd123456Asd/' /etc/dovecot/dovecot-sql.conf.ext
sed -i 's/#default_pass_scheme = MD5/default_pass_scheme = MD5/' /etc/dovecot/dovecot-sql.conf.ext
# 移除后追加
sed -i "s/password_query = SELECT email as user, password FROM virtual_users WHERE email='%u';//" /etc/dovecot/dovecot-sql.conf.ext
echo "password_query = SELECT email as user, password FROM virtual_users WHERE email='%u';" >> /etc/dovecot/dovecot-sql.conf.ext
sed -i ':t;N;s/\n\n\n/\n\n/;b t' /etc/dovecot/dovecot-sql.conf.ext

# 将`/etc/dovecot`的拥有者改为 vmail:dovecot
chown -R vmail:dovecot /etc/dovecot
chmod -R o-rwx /etc/dovecot

# 修改/etc/dovecot/conf.d/10-master.conf文件,修改起来太复杂了，直接编写好echo进去
#echo "I2RlZmF1bHRfcHJvY2Vzc19saW1pdCA9IDEwMAojZGVmYXVsdF9jbGllbnRfbGltaXQgPSAxMDAwCgojIERlZmF1bHQgVlNaICh2aXJ0dWFsIG1lbW9yeSBzaXplKSBsaW1pdCBmb3Igc2VydmljZSBwcm9jZXNzZXMuIFRoaXMgaXMgbWFpbmx5CiMgaW50ZW5kZWQgdG8gY2F0Y2ggYW5kIGtpbGwgcHJvY2Vzc2VzIHRoYXQgbGVhayBtZW1vcnkgYmVmb3JlIHRoZXkgZWF0IHVwCiMgZXZlcnl0aGluZy4KI2RlZmF1bHRfdnN6X2xpbWl0ID0gMjU2TQoKIyBMb2dpbiB1c2VyIGlzIGludGVybmFsbHkgdXNlZCBieSBsb2dpbiBwcm9jZXNzZXMuIFRoaXMgaXMgdGhlIG1vc3QgdW50cnVzdGVkCiMgdXNlciBpbiBEb3ZlY290IHN5c3RlbS4gSXQgc2hvdWxkbid0IGhhdmUgYWNjZXNzIHRvIGFueXRoaW5nIGF0IGFsbC4KI2RlZmF1bHRfbG9naW5fdXNlciA9IGRvdmVudWxsCgojIEludGVybmFsIHVzZXIgaXMgdXNlZCBieSB1bnByaXZpbGVnZWQgcHJvY2Vzc2VzLiBJdCBzaG91bGQgYmUgc2VwYXJhdGUgZnJvbQojIGxvZ2luIHVzZXIsIHNvIHRoYXQgbG9naW4gcHJvY2Vzc2VzIGNhbid0IGRpc3R1cmIgb3RoZXIgcHJvY2Vzc2VzLgojZGVmYXVsdF9pbnRlcm5hbF91c2VyID0gZG92ZWNvdAoKc2VydmljZSBpbWFwLWxvZ2luIHsKICBpbmV0X2xpc3RlbmVyIGltYXAgewogICAgcG9ydCA9IDAKICB9CiAgaW5ldF9saXN0ZW5lciBpbWFwcyB7CiAgICAjcG9ydCA9IDk5MwogICAgI3NzbCA9IHllcwogIH0KCiAgIyBOdW1iZXIgb2YgY29ubmVjdGlvbnMgdG8gaGFuZGxlIGJlZm9yZSBzdGFydGluZyBhIG5ldyBwcm9jZXNzLiBUeXBpY2FsbHkKICAjIHRoZSBvbmx5IHVzZWZ1bCB2YWx1ZXMgYXJlIDAgKHVubGltaXRlZCkgb3IgMS4gMSBpcyBtb3JlIHNlY3VyZSwgYnV0IDAKICAjIGlzIGZhc3Rlci4gPGRvYy93aWtpL0xvZ2luUHJvY2Vzcy50eHQ+CiAgI3NlcnZpY2VfY291bnQgPSAxCgogICMgTnVtYmVyIG9mIHByb2Nlc3NlcyB0byBhbHdheXMga2VlcCB3YWl0aW5nIGZvciBtb3JlIGNvbm5lY3Rpb25zLgogICNwcm9jZXNzX21pbl9hdmFpbCA9IDAKCiAgIyBJZiB5b3Ugc2V0IHNlcnZpY2VfY291bnQ9MCwgeW91IHByb2JhYmx5IG5lZWQgdG8gZ3JvdyB0aGlzLgogICN2c3pfbGltaXQgPSAkZGVmYXVsdF92c3pfbGltaXQKfQoKc2VydmljZSBwb3AzLWxvZ2luIHsKICBpbmV0X2xpc3RlbmVyIHBvcDMgewogICAgcG9ydCA9IDAKICB9CiAgaW5ldF9saXN0ZW5lciBwb3AzcyB7CiAgICAjcG9ydCA9IDk5NQogICAgI3NzbCA9IHllcwogIH0KfQoKc2VydmljZSBsbXRwIHsKICB1bml4X2xpc3RlbmVyIC92YXIvc3Bvb2wvcG9zdGZpeC9wcml2YXRlL2RvdmVjb3QtbG10cCB7CiAgICBtb2RlID0gMDYwMAogICAgdXNlciA9IHBvc3RmaXgKICAgIGdyb3VwID0gcG9zdGZpeAogIH0KCiAgIyBDcmVhdGUgaW5ldCBsaXN0ZW5lciBvbmx5IGlmIHlvdSBjYW4ndCB1c2UgdGhlIGFib3ZlIFVOSVggc29ja2V0CiAgI2luZXRfbGlzdGVuZXIgbG10cCB7CiAgICAjIEF2b2lkIG1ha2luZyBMTVRQIHZpc2libGUgZm9yIHRoZSBlbnRpcmUgaW50ZXJuZXQKICAgICNhZGRyZXNzID0KICAgICNwb3J0ID0gCiAgI30KfQoKc2VydmljZSBpbWFwIHsKICAjIE1vc3Qgb2YgdGhlIG1lbW9yeSBnb2VzIHRvIG1tYXAoKWluZyBmaWxlcy4gWW91IG1heSBuZWVkIHRvIGluY3JlYXNlIHRoaXMKICAjIGxpbWl0IGlmIHlvdSBoYXZlIGh1Z2UgbWFpbGJveGVzLgogICN2c3pfbGltaXQgPSAkZGVmYXVsdF92c3pfbGltaXQKCiAgIyBNYXguIG51bWJlciBvZiBJTUFQIHByb2Nlc3NlcyAoY29ubmVjdGlvbnMpCiAgI3Byb2Nlc3NfbGltaXQgPSAxMDI0Cn0KCnNlcnZpY2UgcG9wMyB7CiAgIyBNYXguIG51bWJlciBvZiBQT1AzIHByb2Nlc3NlcyAoY29ubmVjdGlvbnMpCiAgI3Byb2Nlc3NfbGltaXQgPSAxMDI0Cn0KCnNlcnZpY2UgYXV0aCB7CiAgIyBhdXRoX3NvY2tldF9wYXRoIHBvaW50cyB0byB0aGlzIHVzZXJkYiBzb2NrZXQgYnkgZGVmYXVsdC4gSXQncyB0eXBpY2FsbHkKICAjIHVzZWQgYnkgZG92ZWNvdC1sZGEsIGRvdmVhZG0sIHBvc3NpYmx5IGltYXAgcHJvY2VzcywgZXRjLiBVc2VycyB0aGF0IGhhdmUKICAjIGZ1bGwgcGVybWlzc2lvbnMgdG8gdGhpcyBzb2NrZXQgYXJlIGFibGUgdG8gZ2V0IGEgbGlzdCBvZiBhbGwgdXNlcm5hbWVzIGFuZAogICMgZ2V0IHRoZSByZXN1bHRzIG9mIGV2ZXJ5b25lJ3MgdXNlcmRiIGxvb2t1cHMuCiAgIwogICMgVGhlIGRlZmF1bHQgMDY2NiBtb2RlIGFsbG93cyBhbnlvbmUgdG8gY29ubmVjdCB0byB0aGUgc29ja2V0LCBidXQgdGhlCiAgIyB1c2VyZGIgbG9va3VwcyB3aWxsIHN1Y2NlZWQgb25seSBpZiB0aGUgdXNlcmRiIHJldHVybnMgYW4gInVpZCIgZmllbGQgdGhhdAogICMgbWF0Y2hlcyB0aGUgY2FsbGVyIHByb2Nlc3MncyBVSUQuIEFsc28gaWYgY2FsbGVyJ3MgdWlkIG9yIGdpZCBtYXRjaGVzIHRoZQogICMgc29ja2V0J3MgdWlkIG9yIGdpZCB0aGUgbG9va3VwIHN1Y2NlZWRzLiBBbnl0aGluZyBlbHNlIGNhdXNlcyBhIGZhaWx1cmUuCiAgIwogICMgVG8gZ2l2ZSB0aGUgY2FsbGVyIGZ1bGwgcGVybWlzc2lvbnMgdG8gbG9va3VwIGFsbCB1c2Vycywgc2V0IHRoZSBtb2RlIHRvCiAgIyBzb21ldGhpbmcgZWxzZSB0aGFuIDA2NjYgYW5kIERvdmVjb3QgbGV0cyB0aGUga2VybmVsIGVuZm9yY2UgdGhlCiAgIyBwZXJtaXNzaW9ucyAoZS5nLiAwNzc3IGFsbG93cyBldmVyeW9uZSBmdWxsIHBlcm1pc3Npb25zKS4KICB1bml4X2xpc3RlbmVyIC92YXIvc3Bvb2wvcG9zdGZpeC9wcml2YXRlL2F1dGggewogICAgbW9kZSA9IDA2NjYKICAgIHVzZXIgPSBwb3N0Zml4CiAgICBncm91cCA9IHBvc3RmaXgKICB9CgogICMgUG9zdGZpeCBzbXRwLWF1dGgKICAjdW5peF9saXN0ZW5lciAvdmFyL3Nwb29sL3Bvc3RmaXgvcHJpdmF0ZS9hdXRoIHsKICAjICBtb2RlID0gMDY2NgogICN9CgogICMgQXV0aCBwcm9jZXNzIGlzIHJ1biBhcyB0aGlzIHVzZXIuCiAgI3VzZXIgPSAkZGVmYXVsdF9pbnRlcm5hbF91c2VyCn0KCnNlcnZpY2UgYXV0aC13b3JrZXIgewogICMgQXV0aCB3b3JrZXIgcHJvY2VzcyBpcyBydW4gYXMgcm9vdCBieSBkZWZhdWx0LCBzbyB0aGF0IGl0IGNhbiBhY2Nlc3MKICAjIC9ldGMvc2hhZG93LiBJZiB0aGlzIGlzbid0IG5lY2Vzc2FyeSwgdGhlIHVzZXIgc2hvdWxkIGJlIGNoYW5nZWQgdG8KICAjICRkZWZhdWx0X2ludGVybmFsX3VzZXIuCiAgdXNlciA9IHZtYWlsCn0KCnNlcnZpY2UgZGljdCB7CiAgIyBJZiBkaWN0IHByb3h5IGlzIHVzZWQsIG1haWwgcHJvY2Vzc2VzIHNob3VsZCBoYXZlIGFjY2VzcyB0byBpdHMgc29ja2V0LgogICMgRm9yIGV4YW1wbGU6IG1vZGU9MDY2MCwgZ3JvdXA9dm1haWwgYW5kIGdsb2JhbCBtYWlsX2FjY2Vzc19ncm91cHM9dm1haWwKICB1bml4X2xpc3RlbmVyIGRpY3QgewogICAgI21vZGUgPSAwNjAwCiAgICAjdXNlciA9IAogICAgI2dyb3VwID0gCiAgfQp9Cg==" |base64 -d > /etc/dovecot/conf.d/10-master.conf
echo "I2RlZmF1bHRfcHJvY2Vzc19saW1pdCA9IDEwMAojZGVmYXVsdF9jbGllbnRfbGltaXQgPSAxMDAwCgojIERlZmF1bHQgVlNaICh2aXJ0dWFsIG1lbW9yeSBzaXplKSBsaW1pdCBmb3Igc2VydmljZSBwcm9jZXNzZXMuIFRoaXMgaXMgbWFpbmx5CiMgaW50ZW5kZWQgdG8gY2F0Y2ggYW5kIGtpbGwgcHJvY2Vzc2VzIHRoYXQgbGVhayBtZW1vcnkgYmVmb3JlIHRoZXkgZWF0IHVwCiMgZXZlcnl0aGluZy4KI2RlZmF1bHRfdnN6X2xpbWl0ID0gMjU2TQoKIyBMb2dpbiB1c2VyIGlzIGludGVybmFsbHkgdXNlZCBieSBsb2dpbiBwcm9jZXNzZXMuIFRoaXMgaXMgdGhlIG1vc3QgdW50cnVzdGVkCiMgdXNlciBpbiBEb3ZlY290IHN5c3RlbS4gSXQgc2hvdWxkbid0IGhhdmUgYWNjZXNzIHRvIGFueXRoaW5nIGF0IGFsbC4KI2RlZmF1bHRfbG9naW5fdXNlciA9IGRvdmVudWxsCgojIEludGVybmFsIHVzZXIgaXMgdXNlZCBieSB1bnByaXZpbGVnZWQgcHJvY2Vzc2VzLiBJdCBzaG91bGQgYmUgc2VwYXJhdGUgZnJvbQojIGxvZ2luIHVzZXIsIHNvIHRoYXQgbG9naW4gcHJvY2Vzc2VzIGNhbid0IGRpc3R1cmIgb3RoZXIgcHJvY2Vzc2VzLgojZGVmYXVsdF9pbnRlcm5hbF91c2VyID0gZG92ZWNvdAoKc2VydmljZSBpbWFwLWxvZ2luIHsKICBpbmV0X2xpc3RlbmVyIGltYXAgewogICAgcG9ydCA9IDAKICB9CiAgaW5ldF9saXN0ZW5lciBpbWFwcyB7CiAgICAjcG9ydCA9IDk5MwogICAgI3NzbCA9IHllcwogIH0KCiAgIyBOdW1iZXIgb2YgY29ubmVjdGlvbnMgdG8gaGFuZGxlIGJlZm9yZSBzdGFydGluZyBhIG5ldyBwcm9jZXNzLiBUeXBpY2FsbHkKICAjIHRoZSBvbmx5IHVzZWZ1bCB2YWx1ZXMgYXJlIDAgKHVubGltaXRlZCkgb3IgMS4gMSBpcyBtb3JlIHNlY3VyZSwgYnV0IDAKICAjIGlzIGZhc3Rlci4gPGRvYy93aWtpL0xvZ2luUHJvY2Vzcy50eHQ+CiAgI3NlcnZpY2VfY291bnQgPSAxCgogICMgTnVtYmVyIG9mIHByb2Nlc3NlcyB0byBhbHdheXMga2VlcCB3YWl0aW5nIGZvciBtb3JlIGNvbm5lY3Rpb25zLgogICNwcm9jZXNzX21pbl9hdmFpbCA9IDAKCiAgIyBJZiB5b3Ugc2V0IHNlcnZpY2VfY291bnQ9MCwgeW91IHByb2JhYmx5IG5lZWQgdG8gZ3JvdyB0aGlzLgogICN2c3pfbGltaXQgPSAkZGVmYXVsdF92c3pfbGltaXQKfQoKc2VydmljZSBwb3AzLWxvZ2luIHsKICBpbmV0X2xpc3RlbmVyIHBvcDMgewogICAgcG9ydCA9IDAKICB9CiAgaW5ldF9saXN0ZW5lciBwb3AzcyB7CiAgICAjcG9ydCA9IDk5NQogICAgI3NzbCA9IHllcwogIH0KfQoKc2VydmljZSBsbXRwIHsKICB1bml4X2xpc3RlbmVyIC92YXIvc3Bvb2wvcG9zdGZpeC9wcml2YXRlL2RvdmVjb3QtbG10cCB7CiAgICBtb2RlID0gMDYwMAogICAgdXNlciA9IHBvc3RmaXgKICAgIGdyb3VwID0gcG9zdGZpeAogIH0KCiAgIyBDcmVhdGUgaW5ldCBsaXN0ZW5lciBvbmx5IGlmIHlvdSBjYW4ndCB1c2UgdGhlIGFib3ZlIFVOSVggc29ja2V0CiAgI2luZXRfbGlzdGVuZXIgbG10cCB7CiAgICAjIEF2b2lkIG1ha2luZyBMTVRQIHZpc2libGUgZm9yIHRoZSBlbnRpcmUgaW50ZXJuZXQKICAgICNhZGRyZXNzID0KICAgICNwb3J0ID0gCiAgI30KfQoKc2VydmljZSBpbWFwIHsKICAjIE1vc3Qgb2YgdGhlIG1lbW9yeSBnb2VzIHRvIG1tYXAoKWluZyBmaWxlcy4gWW91IG1heSBuZWVkIHRvIGluY3JlYXNlIHRoaXMKICAjIGxpbWl0IGlmIHlvdSBoYXZlIGh1Z2UgbWFpbGJveGVzLgogICN2c3pfbGltaXQgPSAkZGVmYXVsdF92c3pfbGltaXQKCiAgIyBNYXguIG51bWJlciBvZiBJTUFQIHByb2Nlc3NlcyAoY29ubmVjdGlvbnMpCiAgI3Byb2Nlc3NfbGltaXQgPSAxMDI0Cn0KCnNlcnZpY2UgcG9wMyB7CiAgIyBNYXguIG51bWJlciBvZiBQT1AzIHByb2Nlc3NlcyAoY29ubmVjdGlvbnMpCiAgI3Byb2Nlc3NfbGltaXQgPSAxMDI0Cn0KCnNlcnZpY2UgYXV0aCB7CiAgIyBhdXRoX3NvY2tldF9wYXRoIHBvaW50cyB0byB0aGlzIHVzZXJkYiBzb2NrZXQgYnkgZGVmYXVsdC4gSXQncyB0eXBpY2FsbHkKICAjIHVzZWQgYnkgZG92ZWNvdC1sZGEsIGRvdmVhZG0sIHBvc3NpYmx5IGltYXAgcHJvY2VzcywgZXRjLiBVc2VycyB0aGF0IGhhdmUKICAjIGZ1bGwgcGVybWlzc2lvbnMgdG8gdGhpcyBzb2NrZXQgYXJlIGFibGUgdG8gZ2V0IGEgbGlzdCBvZiBhbGwgdXNlcm5hbWVzIGFuZAogICMgZ2V0IHRoZSByZXN1bHRzIG9mIGV2ZXJ5b25lJ3MgdXNlcmRiIGxvb2t1cHMuCiAgIwogICMgVGhlIGRlZmF1bHQgMDY2NiBtb2RlIGFsbG93cyBhbnlvbmUgdG8gY29ubmVjdCB0byB0aGUgc29ja2V0LCBidXQgdGhlCiAgIyB1c2VyZGIgbG9va3VwcyB3aWxsIHN1Y2NlZWQgb25seSBpZiB0aGUgdXNlcmRiIHJldHVybnMgYW4gInVpZCIgZmllbGQgdGhhdAogICMgbWF0Y2hlcyB0aGUgY2FsbGVyIHByb2Nlc3MncyBVSUQuIEFsc28gaWYgY2FsbGVyJ3MgdWlkIG9yIGdpZCBtYXRjaGVzIHRoZQogICMgc29ja2V0J3MgdWlkIG9yIGdpZCB0aGUgbG9va3VwIHN1Y2NlZWRzLiBBbnl0aGluZyBlbHNlIGNhdXNlcyBhIGZhaWx1cmUuCiAgIwogICMgVG8gZ2l2ZSB0aGUgY2FsbGVyIGZ1bGwgcGVybWlzc2lvbnMgdG8gbG9va3VwIGFsbCB1c2Vycywgc2V0IHRoZSBtb2RlIHRvCiAgIyBzb21ldGhpbmcgZWxzZSB0aGFuIDA2NjYgYW5kIERvdmVjb3QgbGV0cyB0aGUga2VybmVsIGVuZm9yY2UgdGhlCiAgIyBwZXJtaXNzaW9ucyAoZS5nLiAwNzc3IGFsbG93cyBldmVyeW9uZSBmdWxsIHBlcm1pc3Npb25zKS4KICB1bml4X2xpc3RlbmVyIC92YXIvc3Bvb2wvcG9zdGZpeC9wcml2YXRlL2F1dGggewogICAgbW9kZSA9IDA2NjYKICAgIHVzZXIgPSBwb3N0Zml4CiAgICBncm91cCA9IHBvc3RmaXgKICB9CgogIHVuaXhfbGlzdGVuZXIgYXV0aC11c2VyZGIgewogICAgbW9kZSA9IDA2MDAKICAgIHVzZXIgPSB2bWFpbAogICAgI2dyb3VwID0gCiAgfQoKICB1c2VyID0gZG92ZWNvdAogICMgUG9zdGZpeCBzbXRwLWF1dGgKICAjdW5peF9saXN0ZW5lciAvdmFyL3Nwb29sL3Bvc3RmaXgvcHJpdmF0ZS9hdXRoIHsKICAjICBtb2RlID0gMDY2NgogICN9CgogICMgQXV0aCBwcm9jZXNzIGlzIHJ1biBhcyB0aGlzIHVzZXIuCiAgI3VzZXIgPSAkZGVmYXVsdF9pbnRlcm5hbF91c2VyCn0KCnNlcnZpY2UgYXV0aC13b3JrZXIgewogICMgQXV0aCB3b3JrZXIgcHJvY2VzcyBpcyBydW4gYXMgcm9vdCBieSBkZWZhdWx0LCBzbyB0aGF0IGl0IGNhbiBhY2Nlc3MKICAjIC9ldGMvc2hhZG93LiBJZiB0aGlzIGlzbid0IG5lY2Vzc2FyeSwgdGhlIHVzZXIgc2hvdWxkIGJlIGNoYW5nZWQgdG8KICAjICRkZWZhdWx0X2ludGVybmFsX3VzZXIuCiAgdXNlciA9IHZtYWlsCn0KCnNlcnZpY2UgZGljdCB7CiAgIyBJZiBkaWN0IHByb3h5IGlzIHVzZWQsIG1haWwgcHJvY2Vzc2VzIHNob3VsZCBoYXZlIGFjY2VzcyB0byBpdHMgc29ja2V0LgogICMgRm9yIGV4YW1wbGU6IG1vZGU9MDY2MCwgZ3JvdXA9dm1haWwgYW5kIGdsb2JhbCBtYWlsX2FjY2Vzc19ncm91cHM9dm1haWwKICB1bml4X2xpc3RlbmVyIGRpY3QgewogICAgI21vZGUgPSAwNjAwCiAgICAjdXNlciA9IAogICAgI2dyb3VwID0gCiAgfQp9Cg==" |base64 -d > /etc/dovecot/conf.d/10-master.conf
# 第二个增加了auth-userdb，第一个是源邮服配置

# 修改/etc/dovecot/conf.d/10-ssl.conf文件
sed -i 's/ssl = yes/ssl = required/' /etc/dovecot/conf.d/10-ssl.conf
sed -i 's/ssl_cert = <\/etc\/dovecot\/private\/dovecot.pem/ssl_cert = <\/app\/fullchain.pem/' /etc/dovecot/conf.d/10-ssl.conf
sed -i 's/ssl_key = <\/etc\/dovecot\/private\/dovecot.key/ssl_key = <\/app\/privkey.pem/' /etc/dovecot/conf.d/10-ssl.conf

# 修改/etc/postfix/main.cf文件
#echo "smtpd_tls_loglevel = 2" >> /etc/postfix/main.cf
# 以上内容可不配置

# 修改/etc/postfix/master.cf文件
sed -i 's/smtp      inet  n       -       y       -       -       smtpd/#smtp      inet  n       -       y       -       -       smtpd/' /etc/postfix/master.cf
sed -i 's/#smtps     inet  n       -       y       -       -       smtpd/smtps     inet  n       -       n       -       -       smtpd/' /etc/postfix/master.cf
sed -i 's/#  -o smtpd_tls_wrappermode=yes/  -o smtpd_tls_wrappermode=yes/' /etc/postfix/master.cf
#sed -i 's/#submission inet n       -       y       -       -       smtpd/submission inet n       -       y       -       -       smtpd/' /etc/postfix/master.cf
sed -i 's/#  -o syslog_name=postfix\/smtps/  -o syslog_name=postfix\/smtps/' /etc/postfix/master.cf
sed -z -i 's/#  -o smtpd_sasl_auth_enable=yes/  -o smtpd_sasl_auth_enable=yes/2' /etc/postfix/master.cf
sed -z -i 's/#  -o smtpd_reject_unlisted_recipient=no/  -o smtpd_reject_unlisted_recipient=no/2' /etc/postfix/master.cf

#service postfix restart
#service dovecot restart

mysql_h="mysql"
mysql_u="root"
mysql_p="Asd123456Asd"
save_f="mysql.log"
save_p="/app/"

mysql_sq1="create database mailserver character set utf8;"
mysql_sq2="CREATE TABLE \`virtual_domains\` (\`id\`  INT NOT NULL AUTO_INCREMENT,\`name\` VARCHAR(50) NOT NULL,PRIMARY KEY (\`id\`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
mysql_sq3="CREATE TABLE \`virtual_users\` (\`id\` INT NOT NULL AUTO_INCREMENT,\`domain_id\` INT NOT NULL,\`password\` VARCHAR(106) NOT NULL,\`email\` VARCHAR(120) NOT NULL,PRIMARY KEY (\`id\`),UNIQUE KEY \`email\` (\`email\`),FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
mysql_sq4="CREATE TABLE \`virtual_aliases\` (\`id\` int(11) NOT NULL auto_increment,\`domain_id\` int(11) NOT NULL,\`source\` varchar(100) NOT NULL,\`destination\` varchar(100) NOT NULL,PRIMARY KEY (\`id\`),FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE)ENGINE=InnoDB DEFAULT CHARSET=utf8;"

export MYSQL_PWD=${mysql_p}
echo "start connect database..."
result=`mysql -h$mysql_h -u$mysql_u -p$mysql_p << EOF
$mysql_sq1;
use mailserver;
$mysql_sq2;
$mysql_sq3;
$mysql_sq4;
show tables;
quit
EOF`
if [ $? = 0 ]
then
 echo "connect successful..."
else
 echo "connect failure..."
fi
echo "write result..."
echo "$result" > $save_p$save_f
echo "write done..."

sed -i 's/^smtpd_banner = .*/smtpd_banner = Welcome to mail system!(mail.test.com.cn)/' /etc/postfix/main.cf
postconf -e "myhostname = sctei.com.cn"

service postfix restart
service dovecot restart

#/usr/sbin/postfix start-fg
#/usr/sbin/dovecot -F

# 死循环，保持前台运行
i=1
while :
do
sleep 86400
echo "已运行$i天"
i=$((i += 1))
done
