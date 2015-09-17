FROM ubuntu:wily
MAINTAINER Jintleen <jintleen777@gmaill>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update

RUN apt-get -y install \
    git \
    curl \
    php5 \
    php5-gd \
    php5-mysqlnd \
    php5-mcrypt \
    php5-json \
    php5-curl \
    apache2

RUN apt-get clean

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
RUN sed -i "s#/var/www/html#/var/www/html/public#g" /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite
RUN php5enmod mcrypt

RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

ADD run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 80
WORKDIR /app

CMD ["/run.sh"]
