FROM buildpack-deps:18.04-curl 
MAINTAINER Swire Chen <idoop@msn.cn>

ENV ZENTAO_VER=12.4.1

ARG ZENTAO_URL=http://dl.cnezsoft.com/zentao/${ZENTAO_VER}/ZenTaoPMS.${ZENTAO_VER}.zbox_64.tar.gz
ADD https://raw.githubusercontent.com/easysoft/zentaopms/master/www/upgrade.php.tmp /tmp/upgrade.php

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN curl -s ${ZENTAO_URL} -o zbox.tar.gz && mv zbox.tar.gz /tmp \
    && chmod +x           /usr/local/bin/docker-entrypoint

RUN apt-get update && \
apt-get -y install apt-transport-https \
    ca-certificates \
    git

EXPOSE 80 3306

ENTRYPOINT ["docker-entrypoint"]
