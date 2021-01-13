# Chevereto

## This image using chevereto installer to download and extracting the data.

## Compose
```
version: '3.5'
services:
  db:
    image: mariadb
    volumes:
      - ./mysql:/var/lib/mysql:rw
    restart: always
    #networks:
    #  - chevereto
    environment:
      MYSQL_ROOT_PASSWORD: chevereto_root
      MYSQL_DATABASE: chevereto
      MYSQL_USER: chevereto
      MYSQL_PASSWORD: chevereto
  web:
    depends_on:
      - db
    image: martadinata666/chevereto
    restart: always
    container_name: chevereto
    #networks:
    #  - chevereto
    environment:
      CHEVERETO_DB_HOST: db
      CHEVERETO_DB_USERNAME: chevereto
      CHEVERETO_DB_PASSWORD: chevereto
      CHEVERETO_DB_NAME: chevereto
      CHEVERETO_DB_PREFIX: chv_
    volumes:
      - htdocs:/var/www/localhost/htdocs:rw
      - /media/WD/Pictures:/var/www/localhost/htdocs/importing:rw
      - /media/WD/ch-pic:/var/www/localhost/htdocs/images:rw
    ports:
      - 2000:80
#networks:
#  chevereto:
#    name: chevereto
#    driver: bridge
#    ipam:
#      config:
#        - subnet: 172.66.10.0/24
volumes:
  htdocs:
```
### You can change port or network as needed. In sample using port 2000

## Usage
```
http://ip-address:2000/installer.php
```
Follow installer instruction, input database connection, user admin, user email, etc. Then the install will download and extract the chevereto. You will see that the installer show your inpr data input before after it success on install.
After installation success. You can access:
```
http://ip-address:2000
```
### Using **http://ip-address:2000** before installation will lead to 403 (this is expected).