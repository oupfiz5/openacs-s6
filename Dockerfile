# * From
FROM oupfiz5/naviserver-s6:latest

# * Arguments
ARG OACS_TAG
# ARG OACS_TAG=oacs-5-10

# * Environment
ENV oacs_tag=${OACS_TAG} \
    NS_CONF="/usr/local/ns/conf/openacs_config.tcl"

# * Labels
LABEL \
    maintainer="Oupfiz V <oupfiz5@yandex.ru>" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.authors="Oupfiz V (Five)" \
    org.opencontainers.image.url="https://chiselapp.com/user/oupfiz5/repository/openacs-s6/home" \
    org.opencontainers.image.documentation="https://chiselapp.com/user/oupfiz5/repository/openacs-s6/wiki" \
    org.opencontainers.image.source="https://chiselapp.com/user/oupfiz5/repository/openacs-s6/brlist" \
    org.opencontainers.image.version="0.0.2d" \
    org.opencontainers.image.revision="" \
    org.opencontainers.image.vendor="" \
    org.opencontainers.image.licenses="" \
    org.opencontainers.image.ref.name="" \
    org.opencontainers.image.title="OpenACS on NaviServer docker image using s6-overlay" \
    org.opencontainers.image.description="OpenACS on NaviServer docker image using s6-overlay" \
    custom.package.version.openacs="${OACS_TAG}"

# * Copy S6 configuration files
COPY rootfs/etc /etc/

# * Install OpenACS
RUN mkdir -p /var/www

ADD https://github.com/openacs/openacs-core/archive/${OACS_TAG}.tar.gz /tmp/${OACS_TAG}.tar.gz

RUN tar xzf /tmp/${OACS_TAG}.tar.gz -C /var/www; \
    mv /var/www/openacs-core-${OACS_TAG} /var/www/openacs; \
    mkdir /var/www/openacs/log/; \
    chown -R nsadmin:nsadmin /var/www/openacs; \
    rm /tmp/${OACS_TAG}.tar.gz

# ** Install openacs-bootstrap3-theme
ADD https://github.com/openacs/openacs-bootstrap3-theme/archive/${OACS_TAG}.tar.gz /tmp/openacs-bootstrap3-theme-${OACS_TAG}.tar.gz

RUN tar xzf /tmp/openacs-bootstrap3-theme-${OACS_TAG}.tar.gz -C /var/www/openacs/packages; \
    mv /var/www/openacs/packages/openacs-bootstrap3-theme-${OACS_TAG} /var/www/openacs/packages/openacs-bootstrap3-theme; \
    rm /tmp/openacs-bootstrap3-theme-${OACS_TAG}.tar.gz

# ** Copy openacs configuration files
COPY rootfs/usr/local/ns/conf/openacs_config.tcl /usr/local/ns/conf/openacs_config.tcl
COPY rootfs/usr/local/ns/conf/config_vars.tcl /usr/local/ns/conf/config_vars.tcl
COPY rootfs/var/www/openacs/www/SYSTEM/openacs-test.tcl /var/www/openacs/www/SYSTEM/openacs-test.tcl

# ** Install and configure extra OpenACS packages
COPY rootfs/usr/local/ns/conf/install-oacs-core-config.xml /var/www/openacs/install.xml

# * Change directory
WORKDIR /var/www/openacs

# * Expose
EXPOSE 8000

# * Environment

# * Entrypoint
ENTRYPOINT ["/init"]

# * Command
CMD []
