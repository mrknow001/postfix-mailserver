sudo apt install certbot -y
echo "*******tips*******"
echo "1.请按提示添加域名的txt记录 "
echo "2.申请成功后会生成fullchain.pem和privkey.pem文件 "
certbot certonly --manual --preferred-challenges=dns --email test@web.de --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d \*.$1 -d $1
cp /etc/letsencrypt/archive/$1/fullchain1.pem ./fullchain.pem
cp /etc/letsencrypt/archive/$1/privkey1.pem ./privkey.pem

sed -i "s/test.com/$1/g" start.sh
