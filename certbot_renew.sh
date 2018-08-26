export PATH=/usr/local/anaconda3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
/usr/bin/certbot renew --post-hook "systemctl reload nginx" &> /root/.certbotrenew.log
