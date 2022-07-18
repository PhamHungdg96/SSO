# SSO
- Create docker image "keycloak":

$ cd keycloak

$ wget https://github.com/keycloak/keycloak/releases/download/18.0.2/keycloak-18.0.2.tar.gz

$ docker built -t pam/keycloak .

- Create docker image "keycloak-haproxy":

$ cd haproxy

$ docker built -t pam/haproxy .

$ cd ../
- Run docker loadbalance:

$ docker-compose up

├── SSO

│   ├── data: cert, keystore for keycloak, haproxy

│   ├── database: the folder mount to /var/lib/postgresql/data in postgres container (root permission)

│   ├── haproxy: to build docker image

│   ├── keycloak: to build docker image

│   └── log: the folder mount to /var/log/keycloak/* in keycloak's containers. Ex: keycloak-server.log for main server, keycloak-server-1.log for load balancing server


- keytool generate: 

$ keytool -genkeypair -alias keycloak.com -keyalg RSA -keysize 2048 -validity 3650 -keystore server.keystore -dname "cn=KeyCloak,o=Org,c=AU" -storetype PKCS12 -storepass KEYSTOREPASSWORD

- openssl for certificate:

$ openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem

- certificate for haproxy

$ cat cert.pem key.pem > haproxy.pem