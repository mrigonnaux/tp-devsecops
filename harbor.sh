#! /bin/sh



# Création dossier contenant les certificats #

mkdir -p /root/cert



# Génération certificat dans /root/cert #

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=FR/ST=PACA/L=AIX/O=ynov/CN=*.devsecops.com" -keyout /root/cert/devsecops.key  -out /root/cert/devsecops.crt



cd /root



wget https://storage.googleapis.com/harbor-releases/release-1.7.0/harbor-online-installer-v1.7.0.tgz



tar xvf harbor-online-installer-v1.7.0.tgz



cd harbor/



# Modification du hostname #

sed -i 's/hostname = reg.mydomain.com/hostname = harbor.devsecops.com/g' harbor.cfg



# Modification https #

sed -i 's/ui_url_protocol = http/ui_url_protocol = https/g' harbor.cfg



# Modification du chemin du SSL #

sed -i 's@ssl_cert = /data/cert/server.crt@ssl_cert = /root/cert/devsecops.crt@g' harbor.cfg

sed -i 's@ssl_cert_key = /data/cert/server.key@ssl_cert_key = /root/cert/devsecops.key@g' harbor.cfg



# Modification du password administrateur #

sed -i 's/harbor_admin_password = Harbor12345/harbor_admin_password = 23ufe7D4k3vIa72hDw145Avw/g' harbor.cfg



# Modification password de la base de donéne Harbor #

sed -i 's/db_password = root123/db_password = p2sz5FakefrDn6cM3#3Vz/g' harbor.cfg



# Modification password server redis (non utilisé) #

sed -i 's/redis_password =/redis_password = 2YSsRSTaat&eD#2M9F#yB/g' harbor.cfg



# Modification password clair DB #

sed -i 's/clair_db_password = root123/clair_db_password = p2sz5FakefrDn6cM3#3Vz/g' harbor.cfg



# Lance l'installation d'Harbor #

./install.sh --with-clair --with-notary



# Suppression du fichier compressé #

rm -rf harbor-online-installer-v1.7.0.tgz
