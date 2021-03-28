# * From
FROM oupfiz5/naviserver-s6:latest

# * Arguments
ARG OACS_VERSION=5.9.1

# * Environment
ENV oacs_version=${OACS_VERSION} \
    NS_CONF="/usr/local/ns/conf/openacs-config.tcl"

# * Labels
LABEL \
    maintainer="Oupfiz V <oupfiz5@yandex.ru>" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.authors="Oupfiz V (Five)" \
    org.opencontainers.image.url="https://chiselapp.com/user/oupfiz5/repository/openacs-s6/home" \
    org.opencontainers.image.documentation="https://chiselapp.com/user/oupfiz5/repository/openacs-s6/wiki" \
    org.opencontainers.image.source="https://chiselapp.com/user/oupfiz5/repository/openacs-s6/brlist" \
    org.opencontainers.image.version="0.0.1d" \
    org.opencontainers.image.revision="" \
    org.opencontainers.image.vendor="" \
    org.opencontainers.image.licenses="" \
    org.opencontainers.image.ref.name="" \
    org.opencontainers.image.title="OpenACS on naviserver docker image using s6-overlay" \
    org.opencontainers.image.description="OpenACS on naviserver  docker image using s6-overlay" \
    custom.package.version.openacs=${OACS_VERSION}

# * Copy S6 configuration files
COPY rootfs/etc /etc/

# * Install OpenACS
RUN mkdir -p /var/www

ADD https://openacs.org/projects/openacs/download/download/openacs-${oacs_version}-core.tar.gz /tmp/openacs-${oacs_version}-core.tar.gz

RUN tar xzf /tmp/openacs-${oacs_version}-core.tar.gz -C /var/www; \
    mv /var/www/openacs-${oacs_version} /var/www/openacs; \
    chown -R nsadmin:nsadmin /var/www/openacs; \
    rm /tmp/openacs-${oacs_version}-core.tar.gz

# ** Copy openacs configuration files
COPY rootfs/usr/local/ns/conf/openacs-config.tcl /usr/local/ns/conf/openacs-config.tcl
COPY rootfs/usr/local/ns/conf/config_vars.tcl /usr/local/ns/conf/config_vars.tcl
COPY rootfs/var/www/openacs/www/SYSTEM/openacs-test.tcl /var/www/openacs/www/SYSTEM/openacs-test.tcl

# * Change directory
WORKDIR /var/www/openacs

# * Expose
EXPOSE 8000

# * Environment

# * Entrypoint
ENTRYPOINT ["/init"]

# * Command
CMD []
