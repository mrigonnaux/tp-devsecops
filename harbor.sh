#! /bin/sh

cd /root/

wget https://storage.googleapis.com/harbor-releases/release-1.7.0/harbor-online-installer-v1.7.0.tgz

tar xvf harbor-online-installer-v1.7.0.tgz

cd harbor/

# Modification du hostname #
sed -i 's/hostname = reg.mydomain.com/hostname = harbor.devsecops.com/g' harbor.cfg

# Modification https #
sed -i 's/ui_url_protocol = http/ui_url_protocol = https/g' harbor.cfg

# Désactivation de la création du CRT automatique #
sed -i 's/customize_crt = on/customize_crt = off/g' harbor.cfg

# Modification du chemin du SSL #
sed -i 's@ssl_cert = /data/cert/server.crt@ssl_cert = /root/cert/devsecops.crt@g' harbor.cfg
sed -i 's@ssl_cert_key = /data/cert/server.key@ssl_cert_key = /root/cert/devsecops.key@g' harbor.cfg

# Modification du password administrateur #
sed -i 's/harbor_admin_password = Harbor12345/harbor_admin_password = @%23u7D43vIa72&hDwA%vw/g' harbor.cfg

# Modification password de la base de donéne Harbor #
sed -i 's/db_password = root123/db_password = p2s%z5FakefrDn6cM3#3Vz/g' harbor.cfg

# Modification password server redis (non utilisé) #
sed -i 's/redis_password =/redis_password = 2YSsRS%Taat&eD#2M9F#yB/g' harbor.cfg

# Modification password clair DB #
sed -i 's/clair_db_password = root123/clair_db_password = p2s%z5FakefrDn6cM3#3Vz/g' harbor.cfg

# Activation du frewall pour l'ajout des règles IPTABLEs du scipt d'install d'habor #
service firewalld start

# Lance l'installation d'Harbor #
./install.sh

# Désactivation du frewall #
service firewalld stop
