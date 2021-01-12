# Specify the version of PHP we use for our Chevereto
FROM alpine:latest
ARG CHEVERETO_VERSION=1.3.0
WORKDIR /var/www/localhost/htdocs/
COPY installer.php /var/www/localhost/htdocs/

# Copy modified settings
COPY ./php.ini /etc/php7/php.ini
COPY ./httpd.conf /etc/apache2/httpd.conf
COPY ./default.conf /etc/apache2/conf.d/default.conf
# Install apache and php
# curl hash json mbstring pdo pdo-mysql zip session
RUN apk add --no-cache nano \
					   apache2 unzip \
					   php7-apache2 php7-json php7-dom php7-curl php7-iconv php7-openssl \
					   php7-pdo_mysql php7-session php7-ctype php7-gd php7-mbstring php7-zip

# Add #1000 user
RUN adduser --disabled-password --uid 1000 chev
RUN chown -R chev:chev /var/www/localhost/htdocs/
# Expose port
RUN rm /var/www/localhost/htdocs/index.html
EXPOSE 80

# CMD
CMD /usr/sbin/httpd -DFOREGROUND -f /etc/apache2/httpd.conf
#CMD /bin/sh
# DB connection environment variables
ENV CHEVERETO_DB_HOST=db CHEVERETO_DB_USERNAME=chevereto CHEVERETO_DB_PASSWORD=chevereto CHEVERETO_DB_NAME=chevereto CHEVERETO_DB_PREFIX=chv_ CHEVERETO_DB_PORT=3306
ARG BUILD_DATE
ARG CHEVERETO_VERSION=1.3.0

# Set all required labels, we set it here to make sure the file is as reusable as possible
LABEL org.label-schema.url="https://github.com/tanmng/docker-chevereto" \
      org.label-schema.name="Chevereto Free" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version="${CHEVERETO_VERSION}" \
      build_signature="Chevereto free version ${CHEVERETO_VERSION}; built on ${BUILD_DATE}; Using PHP version ${PHP_VERSION}"