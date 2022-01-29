# Table of Contents

-   [About](#about)
-   [Quickstart](#quickstart)
    -   [Manage OpenACS using docker-compose.yaml](#manage-openacs-using-docker-compose-yaml)
        -   [Prerequisite](#prerequisite)
        -   [Start/stop interactive](#start-stop-interactive)
        -   [Start/stop/remove as daemon](#start-stop-remove-as-daemon)
        -   [View logs](#view-logs)
        -   [View list containers](#view-list-containers)
        -   [Prune all](#prune-all)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#manage-openacs-using-docker-compose-official-db-yaml)
        -   [Prerequisite](#prerequisite)
        -   [Start/stop interactive](#start-stop-interactive)
        -   [Start/stop/remove as daemon](#start-stop-remove-as-daemon)
        -   [View logs](#view-logs)
        -   [View list containers](#view-list-containers)
        -   [Prune all](#prune-all)
-   [Configuration options](#configuration-options)
    -   [General options](#general-options)
    -   [Timezone](#timezone)
    -   [OpenACS listen port](#openacs-listen-port)
    -   [NaviServer configuration file](#naviserver-configuration-file)
    -   [NaviServer variable file](#naviserver-variable-file)
    -   [Database hostname](#database-hostname)
    -   [Database username](#database-username)
    -   [Database password](#database-password)
    -   [Postgres official tag](#postgres-official-tag)
    -   [Postgres datacore tag](#postgres-datacore-tag)
-   [CI/CD](#ci-cd)
-   [Build docker image](#build-docker-image)
    -   [Build from chiselapp (fossil)](#build-from-chiselapp--fossil-)
    -   [Build from GitHub](#build-from-github)
    -   [Contfiguration](#contfiguration)
        -   [Build arguments](#build-arguments)
        -   [Example of build](#example-of-build)
-   [Download from DockerHub](#download-from-dockerhub)
-   [Maintenance](#maintenance)
    -   [Shell access](#shell-access)
-   [Code](#code):code:
    -   [VERSION](#version):code:
    -   [../.fossil-settings/crlf-glob](#----fossil-settings-crlf-glob):code:
    -   [../.fossil-settings/crlf-glob.no-warn](#----fossil-settings-crlf-glob-no-warn):code:
    -   [../.fossil-settings/ignore-glob](#----fossil-settings-ignore-glob):code:
    -   [../.fossil-settings/crlf-glob](#----fossil-settings-crlf-glob):code:
    -   [../.github/workflows/on-push.yaml](#----github-workflows-on-push-yaml):code:
    -   [../.github/.trigger\_on\_push](#----github--trigger-on-push):code:
    -   [../.gitignore](#----gitignore):code:
    -   [Dockerfile](#dockerfile):code:
    -   [rootfs/etc/cont-init.d/01-wait-postgres-onetime](#rootfs-etc-cont-init-d-01-wait-postgres-onetime):code:
    -   [rootfs/etc/services.d/naviserver/run](#rootfs-etc-services-d-naviserver-run):code:
    -   [rootfs/usr/local/ns/conf/openacs\_config.tcl](#rootfs-usr-local-ns-conf-openacs-config-tcl):code:
    -   [rootfs/usr/local/ns/conf/config\_vars.tcl](#rootfs-usr-local-ns-conf-config-vars-tcl):code:
    -   [rootfs/var/www/openacs/www/SYSTEM/openacs-test.tcl](#rootfs-var-www-openacs-www-system-openacs-test-tcl):code:
    -   [rootfs/usr/local/ns/conf/install-oacs-core-config.xml](#rootfs-usr-local-ns-conf-install-oacs-core-config-xml):code:
    -   [hook/build.sh](#hook-build-sh):code:
    -   [hook/push.sh](#hook-push-sh):code:
    -   [docker-compose.yaml](#docker-compose-yaml):code:
    -   [docker-compose-official-db.yaml](#docker-compose-official-db-yaml):code:
    -   [.env](#-env):code:



<a id="about"></a>

# About

This is [OpenACS](https://openacs.org/) on [Ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  To install OpenACS I used  code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/openacs-s6](https://hub.docker.com/r/oupfiz5/openacs-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using GitHub CI/CD  (GitHub Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="quickstart"></a>

# Quickstart

The quickstart contains two variants:


<a id="manage-openacs-using-docker-compose-yaml"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="prerequisite"></a>

### Prerequisite

Clone repository from:

-   fossil:

        fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
        mkdir openacs-s6
        cd openacs-s6
        fossil open ../openacs-s6.fossil
-   GitHub:

        git clone https://github.com/oupfiz5/openacs-s6.git
        cd openacs-s6


<a id="start-stop-interactive"></a>

### Start/stop interactive

start:

    docker-compose up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="start-stop-remove-as-daemon"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="view-logs"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="view-list-containers"></a>

### View list containers

    docker-compose ps


<a id="prune-all"></a>

### Prune all

    docker system prune --volumes --force


<a id="manage-openacs-using-docker-compose-official-db-yaml"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="prerequisite"></a>

### Prerequisite

Clone repository from:

-   fossil:

        fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
        mkdir openacs-s6
        cd openacs-s6
        fossil open ../openacs-s6.fossil

-   GitHub:

        git clone https://github.com/oupfiz5/openacs-s6.git
        cd openacs-s6


<a id="start-stop-interactive"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="start-stop-remove-as-daemon"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="view-logs"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="view-list-containers"></a>

### View list containers

    docker-compose ps


<a id="prune-all"></a>

### Prune all

    docker system prune --volumes --force


<a id="configuration-options"></a>

# Configuration options


<a id="general-options"></a>

## General options

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Option</th>
<th scope="col" class="org-left">Default</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left"><a href="#timezone">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#openacs-listen-port">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#naviserver-configuration-file">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#naviserver-variable-file">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#database-hostname">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#database-username">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#database-password">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#postgres-official-tag">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#postgres-datacore-tag">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="timezone"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="openacs-listen-port"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="naviserver-configuration-file"></a>

## NaviServer configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="naviserver-variable-file"></a>

## NaviServer variable file

`NS_VARS` - - configuration file. This configuration file contains several parameters which are frequently changed (e.g. for debug or other configurations). The provided NaviServer configuation file reads the variable file and uses its values.  Default value is `/usr/local/ns/conf/config_vars.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="database-hostname"></a>

## Database hostname

`DB_HOST` set the database hostname for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="database-username"></a>

## Database username

`DB_USER` set the database username for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="database-password"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="postgres-official-tag"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="14.1-alpine" docker-compose up


<a id="postgres-datacore-tag"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="ci-cd"></a>

# CI/CD

For  build and push docker images we use  [GitHub Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="build-docker-image"></a>

# Build docker image


<a id="build-from-chiselapp--fossil-"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open ../openacs-s6.fossil
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="build-from-github"></a>

## Build from GitHub

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="contfiguration"></a>

## Contfiguration


<a id="build-arguments"></a>

### Build arguments

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Arguments</th>
<th scope="col" class="org-left">Default</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">BUILD_DATE</td>
<td class="org-left">none</td>
<td class="org-left">Set build date for label</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">OACS_TAG</td>
<td class="org-left">oacs-5-10</td>
<td class="org-left">Set default OpenACS version</td>
</tr>
</tbody>
</table>


<a id="example-of-build"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_TAG="oacs-5-10" \
        -t oupfiz5/openacs-s6:oacs-5-10 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="download-from-dockerhub"></a>

# Download from DockerHub

You can download docker images from dockerhub:

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:oacs-5-10


<a id="maintenance"></a>

# Maintenance


<a id="shell-access"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash


<a id="code"></a>

# Code     :code:


<a id="version"></a>

## VERSION     :code:

    VERSION='oacs-5-10'


<a id="----fossil-settings-crlf-glob"></a>

## ../.fossil-settings/crlf-glob     :code:

    *


<a id="----fossil-settings-crlf-glob-no-warn"></a>

## ../.fossil-settings/crlf-glob.no-warn     :code:

    *


<a id="----fossil-settings-ignore-glob"></a>

## ../.fossil-settings/ignore-glob     :code:

    .git/
    .github-mirroring/*
    docs/
    org/.configuration/*
    tests/.bats-battery/*/.git
    tests/.bats-battery/*/.github


<a id="----fossil-settings-crlf-glob"></a>

## ../.fossil-settings/crlf-glob     :code:

    *


<a id="----github-workflows-on-push-yaml"></a>

## ../.github/workflows/on-push.yaml     :code:

    name: Build and push docker images

    on:
      push:
        paths:
          - .github/workflows/on-push.yaml
          - .github/.trigger_on_push
          - Dockerfile*
          - builds/*
          - .env
          - rootfs/*
          - hook/*
          - VERSION
        branches:
          - master
          - dev

    jobs:
      build:
        name: Build and push images to DockerHub
        runs-on: ubuntu-latest
        steps:
          - name: Checkout repository oupfiz5/openacs-s6
            uses: actions/checkout@v2

          - name: Login to DockerHub Registry
            run: |
              echo  ${{ secrets.DOCKERHUB_TOKEN }} | docker login --username ${{ secrets.DOCKERHUB_USERNAME }} --password-stdin

          - name: Build images
            run: |
              cd ${GITHUB_WORKSPACE}/hook
              ./build.sh

          - name: Push images
            run: |
              cd ${GITHUB_WORKSPACE}/hook
              ./push.sh


<a id="----github--trigger-on-push"></a>

## ../.github/.trigger\_on\_push     :code:

    Trigger: 9


<a id="----gitignore"></a>

## ../.gitignore     :code:

    .fslckout
    .projectile
    .fossil-settings/*


<a id="dockerfile"></a>

## Dockerfile     :code:

    # * From
    FROM oupfiz5/naviserver-s6:4.99.23

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
        org.opencontainers.image.version="0.0.3d" \
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


<a id="rootfs-etc-cont-init-d-01-wait-postgres-onetime"></a>

## rootfs/etc/cont-init.d/01-wait-postgres-onetime     :code:

    #!/usr/bin/with-contenv bash

    until PGPASSWORD=${DB_PASS} pg_isready -h ${DB_HOST} -U ${DB_USER}; do
        sleep 1
    done


<a id="rootfs-etc-services-d-naviserver-run"></a>

## rootfs/etc/services.d/naviserver/run     :code:

    #!/usr/bin/with-contenv bash

    # Load functions
    source /etc/naviserver/functions

    exec s6-applyuidgid -u $(get_usermap_uid) -g $(get_usermap_gid) /usr/local/ns/bin/nsd -f -t ${NS_CONF}


<a id="rootfs-usr-local-ns-conf-openacs-config-tcl"></a>

## rootfs/usr/local/ns/conf/openacs\_config.tcl     :code:

    ######################################################################
    #
    # Config parameter for an OpenACS site using NaviServer.
    #
    # These default settings will only work in limited circumstances.
    # Two servers with default settings cannot run on the same host
    #
    ######################################################################
    ns_log notice "nsd.tcl: starting to read config file..."

    #---------------------------------------------------------------------
    # Change the HTTP and HTTPS port to e.g. 80 and 443 for production use.

    # source /usr/local/ns/conf/config_vars.tcl
    source $::env(NS_VARS)

    switch $httpport {
            443 - 8443 {
            set httpsport $httpport
            }
    }

    #
    # Setting the HTTPS port to 0 means to active the https driver for
    # ns_http, but do not listen on this port.
    #
    #set httpsport		0
    #set httpsport		8443

    # The hostname and address should be set to actual values.
    # setting the address to 0.0.0.0 means AOLserver listens on all interfaces

    #set address_v4		127.0.0.1  ;# listen on loopback via IPv4
    set address_v4		0.0.0.0    ;# listen on all IPv4 addresses
    #set address_v6		::1        ;# listen on loopback via IPv6
    #set address_v6		::0        ;# listen on all IPv6 addresses

    # Note: If port is privileged (usually < 1024), OpenACS must be
    # started by root, and the run script must contain the flag
    # '-b address:port' which matches the address and port
    # as specified above.

    set server "openacs"

    set servername		"New OpenACS Installation - Development"

    set logroot		$serverroot/log

    set homedir		/usr/local/ns

    set bindir		$homedir/bin

    # Are we running behind a proxy?
    set proxy_mode		$proxy_mode

    #---------------------------------------------------------------------
    # Which database do you want? PostgreSQL or Oracle?
    set database              postgres

    # set db_name openacs
    set db_name $::env(DB_NAME)

    if { $database eq "oracle" } {
        set db_password           "mysitepassword"
    } else {
        # set db_host               postgres
        set db_host               $::env(DB_HOST)
        set db_port               "5432"

        # set db_user               [exec cat /run/secrets/psql_user]
        # set db_user               openacs
        set db_user               $::env(DB_USER)
        if {$db_user eq ""} {
            set db_user $server
        }

        # set db_password           [exec cat /run/secrets/psql_password]
        # set db_password           testing
        set db_password           $::env(DB_PASS)
        if {$db_password eq ""} {
            set db_password           testing
        }
    }

    #---------------------------------------------------------------------
    # If debug is false, all debugging will be turned off.
    if {$develop_p} {
        set debug true
        set dev true
        set verboseSQL true
    } else {
        set debug false
        set dev false
        set verboseSQL false
    }

    if {$staging_p} {
        set debug true
    }

    set max_file_upload_mb        20
    set max_file_upload_min        5

    #---------------------------------------------------------------------
    # Set environment variables HOME and LANG. HOME is needed since
    # otherwise some programs called via exec might try to write into the
    # root home directory.
    #
    set env(HOME) $homedir
    set env(LANG) en_US.UTF-8

    #---------------------------------------------------------------------
    # Set headers that should be included in every reply from the server
    #
    set nssock_extraheaders {
        X-Frame-Options            "SAMEORIGIN"
        X-Content-Type-Options     "nosniff"
        X-XSS-Protection           "1; mode=block"
        Referrer-Policy            "strict-origin"
    }

    set nsssl_extraheaders {
        Strict-Transport-Security "max-age=31536000; includeSubDomains"
    }
    append nsssl_extraheaders $nssock_extraheaders

    ######################################################################
    #
    # End of instance-specific settings
    #
    # Nothing below this point need be changed in a default install.
    #
    ######################################################################


    ns_logctl severity "Debug(ns:driver)" $debug

    set addresses {}
    set suffixes {}
    if {[info exists address_v4]} {lappend addresses $address_v4; lappend suffixes v4}
    if {[info exists address_v6]} {lappend addresses $address_v6; lappend suffixes v6}

    #---------------------------------------------------------------------
    #
    # NaviServer's directories. Auto-configurable.
    #
    #---------------------------------------------------------------------
    # Where are your pages going to live ?
    set pageroot                  ${serverroot}/www
    set directoryfile             "index.tcl index.adp index.html index.htm"

    #---------------------------------------------------------------------
    # Global server parameters
    #---------------------------------------------------------------------
    ns_section ns/parameters {
        ns_param	serverlog	${logroot}/error.log
        ns_param	pidfile		${logroot}/nsd.pid
        ns_param	home		$homedir
        ns_param	debug		$debug

        # Define optionally the tmpdir. If not specified, the
        # environment variable TMPDIR is used. If that is not
        # specified either, a system specific constant us used
        # (compile time macro P_tmpdir)
        #
        # ns_param        tmpdir          c:/tmp

        #
        # Configuration of error.log
        #
        # Rolling of logfile:
        ns_param	logroll		on
        ns_param	logmaxbackup	100      ;# 10 is default
        ns_param	logrollfmt	%Y-%m-%d ;# format appended to serverlog file name when rolled
        #
        # Format of log entries:
        # ns_param  logusec         true     ;# add timestamps in microsecond (usec) resolution (default: false)
        # ns_param  logusecdiff     true     ;# add timestamp diffs since in microsecond (usec) resolution (default: false)
        ns_param	logcolorize	true     ;# colorize log file with ANSI colors (default: false)
        ns_param	logprefixcolor	green    ;# black, red, green, yellow, blue, magenta, cyan, gray, default
        # ns_param  logprefixintensity normal;# bright or normal
        #
        # Severities to be logged (can be controlled at runtime via ns_logctl)
        ns_param	logdebug	$debug    ;# debug messages
        ns_param	logdev		$dev      ;# development message
        ns_param    lognotice       true      ;# informational messages

        # ns_param	mailhost	localhost
        # ns_param	jobsperthread	0
        # ns_param	jobtimeout	300
        # ns_param	schedsperthread	0

        # Write asynchronously to log files (access log and error log)
        # ns_param	asynclogwriter	true		;# false

        #ns_param       mutexlocktrace       true   ;# default false; print durations of long mutex calls to stderr

        # Reject output operations on already closed connections (e.g. subsequent ns_return statements)
        #ns_param       rejectalreadyclosedconn false ;# default: true

        # Allow concurrent create operations of Tcl interpreters.
        # Versions up to at least Tcl 8.5 are known that these might
        # crash in case two threads create interpreters at the same
        # time. These crashes were hard to reproduce, but serializing
        # interpreter creation helped. Probably it is possible to
        # allow concurrent interpreter create operations in Tcl 8.6.
        #ns_param        concurrentinterpcreate true   ;# default: false

        # Enforce sequential thread initialization. This is not really
        # desirably in general, but might be useful for hunting strange
        # crashes or for debugging with valgrind.
        # ns_param	tclinitlock	true	       ;# default: false

        #
        # Encoding settings (see http://dqd.com/~mayoff/encoding-doc.html)
        #
        # ns_param	HackContentType	1

        # NaviServer's defaults charsets are all utf-8.  Although the
        # default charset is utf-8, set the parameter "OutputCharset"
        # here, since otherwise OpenACS uses in the meta-tags the charset
        # from [ad_conn charset], which is taken from the db and
        # per-default ISO-8859-1.
        ns_param	OutputCharset	utf-8
        # ns_param	URLCharset	utf-8

        #
        # DNS configuration parameters
        #
        ns_param dnscache true          ;# default: true
        ns_param dnswaittimeout 5       ;# time for waiting for a DNS reply in seconds; default: 5
        ns_param keepwaittimeout 60     ;# time to keep entries in cache in minutes; default: 60
        ns_param dnscachemaxsize 500kB  ;# max size of DNS cache in memory units; default: 500kB

        # Running behind proxy? Used by OpenACS...
        ns_param	ReverseProxyMode	$proxy_mode
    }

    #---------------------------------------------------------------------
    # Thread library (nsthread) parameters
    #---------------------------------------------------------------------
    ns_section ns/threads {
        ns_param	stacksize	[expr {2*1024*1024}]
    }
    #---------------------------------------------------------------------
    # Extra mime types
    #---------------------------------------------------------------------
    ns_section ns/mimetypes {
        #  Note: NaviServer already has an exhaustive list of MIME types:
        #  see: /usr/local/src/naviserver/nsd/mimetypes.c
        #  but in case something is missing you can add it here.

        #ns_param	Default		*/*
        #ns_param	NoExtension	*/*
        #ns_param	.pcd		image/x-photo-cd
        #ns_param	.prc		application/x-pilot
    }

    #---------------------------------------------------------------------
    # Global fastpath parameters
    #---------------------------------------------------------------------
    ns_section      "ns/fastpath" {
        #ns_param        cache               true       ;# default: false
        #ns_param        cachemaxsize        10MB       ;# default: 10MB
        #ns_param        cachemaxentry       100kB      ;# default: 8kB
        #ns_param        mmap                true       ;# default: false
        #ns_param        gzip_static         true       ;# check for static gzip; default: false
        #ns_param        gzip_refresh        true       ;# refresh stale .gz files on the fly using ::ns_gzipfile
        #ns_param        gzip_cmd            "/usr/bin/gzip -9"  ;# use for re-compressing
        #ns_param        minify_css_cmd      "/usr/bin/yui-compressor --type css"
        #ns_param        minify_js_cmd       "/usr/bin/yui-compressor --type js"
        #ns_param        brotli_static       true       ;# check for static brotli files; default: false
        #ns_param        brotli_refresh      true       ;# refresh stale .br files on the fly using ::ns_brotlifile
        #ns_param        brotli_cmd          "/usr/bin/brotli -f -Z"  ;# use for re-compressing
    }

    #---------------------------------------------------------------------
    #
    # Server-level configuration
    #
    #  There is only one server in NaviServer, but this is helpful when multiple
    #  servers share the same configuration file.  This file assumes that only
    #  one server is in use so it is set at the top in the "server" Tcl variable
    #  Other host-specific values are set up above as Tcl variables, too.
    #
    #---------------------------------------------------------------------
    ns_section ns/servers {
        ns_param $server		$servername
    }

    #
    # Server parameters
    #
    ns_section ns/server/${server} {
        #
        # Scaling and Tuning Options
        #
        # ns_param	maxconnections	100	;# 100; number of allocated connection structures
        # ns_param	maxthreads	10	;# 10; maximal number of connection threads
        ns_param	minthreads	2	;# 1; minimal number of connection threads

        ns_param	connsperthread	1000	;# 10000; number of connections (requests) handled per thread
        ;# Setting connsperthread to > 0 will cause the thread to
        ;# graciously exit, after processing that many
        ;# requests, thus initiating kind-of Tcl-level
        ;# garbage collection.

        # ns_param	threadtimeout	120	;# 120; timeout for idle threads.
        ;# In case, minthreads < maxthreads, threads
        ;# are shutdown after this idle time until
        ;# minthreads are reached.

        # ns_param	lowwatermark	10      ;# 10; create additional threads above this queue-full percentage
        ns_param	highwatermark	100     ;# 80; allow concurrent creates above this queue-is percentage
        ;# 100 means to disable concurrent creates

        # Compress response character data: ns_return, ADP etc.
        #
        ns_param	compressenable	on	;# false, use "ns_conn compress" to override
        # ns_param	compresslevel	4	;# 4, 1-9 where 9 is high compression, high overhead
        # ns_param	compressminsize	512	;# Compress responses larger than this
        # ns_param	compresspreinit true	;# false, if true then initialize and allocate buffers at startup

        #
        # Configuration of replies
        #
        # ns_param	realm		yourrealm	;# Default realm for Basic authentication
        # ns_param	noticedetail	false	;# true, return detail information in server reply
        # ns_param	errorminsize	0	;# 514, fill-up reply to at least specified bytes (for ?early? MSIE)
        # ns_param	headercase	preserve;# preserve, might be "tolower" or "toupper"
        # ns_param	checkmodifiedsince	false	;# true, check modified-since before returning files from cache. Disable for speedup
    }

    #---------------------------------------------------------------------
    # Special HTTP pages
    #---------------------------------------------------------------------
    ns_section ns/server/${server}/redirects {
        ns_param   404 /shared/404
        ns_param   403 /shared/403
        ns_param   503 /shared/503
        ns_param   500 /shared/500
    }

    #---------------------------------------------------------------------
    # ADP (AOLserver Dynamic Page) configuration
    #---------------------------------------------------------------------
    ns_section ns/server/${server}/adp {
        ns_param	enabledebug	$debug
        ns_param	map		/*.adp		;# Extensions to parse as ADP's
        # ns_param	map		"/*.html"	;# Any extension can be mapped
        #
        # ns_param	cache		true		;# false, enable ADP caching
        # ns_param	cachesize	10MB		;# 5MB, size of ADP cache
        # ns_param	bufsize		5MB		;# 1MB, size of ADP buffer
        #
        # ns_param	trace		true		;# false, trace execution of adp scripts
        # ns_param	tracesize	100		;# 40, max number of entries in trace
        #
        # ns_param	stream		true		;# false, enable ADP streaming
        # ns_param	enableexpire	true		;# false, set "Expires: now" on all ADP's
        # ns_param	safeeval	true		;# false, disable inline scripts
        # ns_param	singlescript	true		;# false, collapse Tcl blocks to a single Tcl script
        # ns_param	detailerror	false		;# true,  include connection info in error backtrace
        # ns_param	stricterror	true		;# false, interrupt execution on any error
        # ns_param	displayerror	true		;# false, include error message in output
        # ns_param	trimspace	true		;# false, trim whitespace from output buffer
        # ns_param	autoabort	false		;# true,  failure to flush a buffer (e.g. closed HTTP connection) generates an ADP exception
        #
        # ns_param	errorpage	/.../errorpage.adp	;# page for returning errors
        # ns_param	startpage	/.../startpage.adp	;# file to be run for every adp request; should include "ns_adp_include [ns_adp_argv 0]"
        # ns_param	debuginit	some-proc		;# ns_adp_debuginit, proc to be executed on debug init
        #
    }

    ns_section ns/server/${server}/adp/parsers {
        ns_param	fancy		".adp"
    }

    #
    # Tcl Configuration
    #
    ns_section ns/server/${server}/tcl {
        ns_param	library		${serverroot}/tcl
        ns_param	autoclose	on
        ns_param	debug		$debug
        # ns_param	nsvbuckets	16       ;# default: 8
    }

    ns_section "ns/server/${server}/fastpath" {
        ns_param	serverdir	${homedir}
        ns_param	pagedir		${pageroot}
        #
        # Directory listing options
        #
        # ns_param	directoryfile		"index.adp index.tcl index.html index.htm"
        # ns_param	directoryadp		$pageroot/dirlist.adp ;# Choose one or the other
        # ns_param	directoryproc		_ns_dirlist           ;#  ...but not both!
        # ns_param	directorylisting	fancy                 ;# Can be simple or fancy
        #
    }
    #---------------------------------------------------------------------
    # OpenACS specific settings (per server)
    #---------------------------------------------------------------------
    #
    # Define/override kernel parameters in section /acs
    #
    ns_section ns/server/${server}/acs {
        ns_param NsShutdownWithNonZeroExitCode 1
        # ns_param WithDeprecatedCode 0
        # ns_param LogIncludeUserId 1
        #
    }

    # Define/override OpenACS package parameters in section
    # ending with /acs/PACKAGENAME
    #
    # Provide tailored sizes for the site node cache in acs-tcl:
    #
    ns_section ns/server/${server}/acs/acs-tcl {
        # ns_param SiteNodesCacheSize        2000000
        # ns_param SiteNodesIdCacheSize       100000
        # ns_param SiteNodesChildenCacheSize  100000
        # ns_param SiteNodesPrefetch  {/file /changelogs /munin}
        # ns_param UserInfoCacheSize          2000000
    }

    #
    # Set for all package instances of acs-mail-lite the
    # EmailDeliveryMode. Setting this to "log" is useful for developer
    # instances.
    #
    ns_section ns/server/${server}/acs/acs-mail-lite {
        # ns_param EmailDeliveryMode log
    }

    #
    # API browser configuration: setting IncludeCallingInfo to "true" is
    # useful mostly for developer instances.
    #
    ns_section ns/server/${server}/acs/acs-api-browser {
        # ns_param IncludeCallingInfo true
    }

    #---------------------------------------------------------------------
    # WebDAV Support (optional, requires oacs-dav package to be installed
    #---------------------------------------------------------------------
    ns_section ns/server/${server}/tdav {
        ns_param	propdir		   ${serverroot}/data/dav/properties
        ns_param	lockdir		   ${serverroot}/data/dav/locks
        ns_param	defaultlocktimeout 300
    }

    ns_section ns/server/${server}/tdav/shares {
        ns_param	share1		"OpenACS"
        # ns_param	share2		"Share 2 description"
    }

    ns_section ns/server/${server}/tdav/share/share1 {
        ns_param	uri		"/dav/*"
        # all WebDAV options
        ns_param	options		"OPTIONS COPY GET PUT MOVE DELETE HEAD MKCOL POST PROPFIND PROPPATCH LOCK UNLOCK"
    }

    #ns_section ns/server/${server}/tdav/share/share2 {
    # ns_param	uri "/share2/path/*"
    # read-only WebDAV options
    # ns_param options "OPTIONS COPY GET HEAD MKCOL POST PROPFIND PROPPATCH"
    #}

    #---------------------------------------------------------------------
    # Socket driver module (HTTP)  -- nssock
    #---------------------------------------------------------------------
    foreach address $addresses suffix $suffixes {
        ns_section ns/server/${server}/module/nssock_$suffix
        ns_param	address		$address
        ns_param	hostname	$hostname
        ns_param	port		$httpport	;# 80 or 443
        ns_param	maxinput	"$max_file_upload_mb MB";   # 1MB, maximum size for inputs (uploads)
        ns_param	recvwait	[expr {$max_file_upload_min * 60}] ;# 30, timeout for receive operations
        # ns_param	maxline		8192	;# 8192, max size of a header line
        # ns_param	maxheaders	128	;# 128, max number of header lines
        # ns_param	uploadpath	/tmp	;# directory for uploads
        # ns_param	backlog		256	;# 256, backlog for listen operations
        # ns_param	maxqueuesize	256	;# 1024, maximum size of the queue
        # ns_param	acceptsize	10	;# Maximum number of requests accepted at once.
        # ns_param	deferaccept     true    ;# false, Performance optimization, may cause recvwait to be ignored
        # ns_param	bufsize		16kB	;# 16kB, buffersize
        # ns_param	readahead	16kB	;# value of bufsize, size of readahead for requests
        # ns_param	sendwait	30	;# 30, timeout in seconds for send operations
        # ns_param	closewait	2	;# 2, timeout in seconds for close on socket
        # ns_param	keepwait	2	;# 5, timeout in seconds for keep-alive
        # ns_param  nodelay         false   ;# true; deactivate TCP_NODELAY if Nagle algorithm is wanted
        # ns_param	keepalivemaxuploadsize	  500kB  ;# 0, don't allow keep-alive for upload content larger than this
        # ns_param	keepalivemaxdownloadsize  1MB    ;# 0, don't allow keep-alive for download content larger than this
        # ns_param	spoolerthreads	1	;# 0, number of upload spooler threads
        ns_param	maxupload	100kB	;# 0, when specified, spool uploads larger than this value to a temp file
        ns_param	writerthreads	2	;# 0, number of writer threads
        ns_param	writersize	1kB	;# 1MB, use writer threads for files larger than this value
        # ns_param	writerbufsize	8kB	;# 8kB, buffer size for writer threads
        # ns_param	writerstreaming	true	;# false;  activate writer for streaming HTML output (when using ns_write)

        #
        # Options for port reuse (see https://lwn.net/Articles/542629/)
        # These options require proper OS support.
        #
        # ns_param  reuseport       true    ;# false;  normally not needed to be set, set by driverthreads when necessary
        # ns_param	driverthreads	2	;# 1; use multiple driver threads; activates "reuseport"

        #
        # Extra request headers fields to be added for every request.
        #
        ns_param    extraheaders    $nssock_extraheaders
    }


    #---------------------------------------------------------------------
    # Access log -- nslog
    #---------------------------------------------------------------------
    ns_section ns/server/${server}/module/nslog {
        #
        # General parameters for access.log
        #
        ns_param	file			${logroot}/access.log
        # ns_param	maxbuffer		100	;# 0, number of logfile entries to keep in memory before flushing to disk
        #
        # Control what to log
        #
        # ns_param	suppressquery	true	;# false, suppress query portion in log entry
        # ns_param	logreqtime	true	;# false, include time to service the request
        ns_param	logpartialtimes	true	;# false, include high-res start time and partial request durations (accept, queue, filter, run)
        ns_param    logthreadname   true    ;# default: false; include thread name for linking with error.log
        # ns_param	formattedtime	true	;# true, timestamps formatted or in secs (unix time)
        # ns_param	logcombined	true	;# true, Log in NSCA Combined Log Format (referer, user-agent)
        ns_param	checkforproxy	$proxy_mode ;# false, check for proxy header (X-Forwarded-For)
        ns_param	masklogaddr     true    ;# false, mask IP address in log file for GDPR (like anonip IP anonymizer)
        ns_param	maskipv4        255.255.255.0  ;# mask for IPv4 addresses
        ns_param	maskipv6        ff:ff:ff:ff::  ;# mask for IPv6 addresses

        #
        # Add extra entries to the access log via specifying a comma delimited
        # list of request header fields in "extendedheaders"
        #
        if {[ns_config "ns/server/${server}/acs" LogIncludeUserId 0]} {
            ns_param   extendedheaders    "X-User-Id"
        }

        #
        #
        # Control log file rolling
        #
        # ns_param	maxbackup	100	;# 10, max number of backup log files
        # ns_param	rolllog		true	;# true, should server log files automatically
        # ns_param	rollhour	0	;# 0, specify at which hour to roll
        # ns_param	rollonsignal	true	;# false, perform roll on a sighup
        ns_param	rollfmt		%Y-%m-%d ;# format appended to log file name
    }

    #---------------------------------------------------------------------
    #
    # CGI interface -- nscgi, if you have legacy stuff. Tcl or ADP files inside
    # NaviServer are vastly superior to CGIs. I haven't tested these params but they
    # should be right.
    #
    #---------------------------------------------------------------------
    #ns_section "ns/server/${server}/module/nscgi"
    #       ns_param	map	"GET  /cgi-bin ${serverroot}/cgi-bin"
    #       ns_param	map	"POST /cgi-bin ${serverroot}/cgi-bin"
    #       ns_param	Interps CGIinterps
    #       ns_param        allowstaticresources true    ;# default: false

    #ns_section "ns/interps/CGIinterps"
    #       ns_param .pl "/usr/bin/perl"


    #---------------------------------------------------------------------
    #
    # PAM authentication
    #
    #---------------------------------------------------------------------
    ns_section ns/server/${server}/module/nspam {
        ns_param	PamDomain          "pam_domain"
    }

    if {[info exists httpsport]} {
        #---------------------------------------------------------------------
        # SSL/TLS
        #---------------------------------------------------------------------
        foreach address $addresses suffix $suffixes {
            ns_section    "ns/server/${server}/module/nsssl_$suffix" {
                ns_param		address		$address
                ns_param		port		$httpsport
                ns_param		hostname	$hostname
                ns_param		ciphers		"ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!RC4"
                ns_param		protocols	"!SSLv2:!SSLv3"
                ns_param		certificate	$serverroot/etc/certfile.pem
                ns_param		verify		0
                ns_param		writerthreads	2
                ns_param		writersize	1kB
                ns_param		writerbufsize	16kB	;# 8kB, buffer size for writer threads
                #ns_param   nodelay         false   ;# true; deactivate TCP_NODELAY if Nagle algorithm is wanted
                #ns_param	writerstreaming	true	;# false
                #ns_param	deferaccept	true    ;# false, Performance optimization
                ns_param		maxinput	"$max_file_upload_mb MB" ;# Maximum file size for uploads in bytes
                ns_param         extraheaders    $nsssl_extraheaders
            }
        }
    }

    #---------------------------------------------------------------------
    #
    # Database drivers
    # The database driver is specified here.
    # Make sure you have the driver compiled and put it in {aolserverdir}/bin
    #
    #---------------------------------------------------------------------
    ns_section "ns/db/drivers" {

        if { $database eq "oracle" } {
            ns_param	ora8           ${bindir}/ora8
        } else {
            ns_param	postgres       ${bindir}/nsdbpg
            #
            ns_logctl severity "Debug(sql)" -color blue $verboseSQL
        }

        if { $database eq "oracle" } {
            ns_section "ns/db/driver/ora8"
            ns_param	maxStringLogLength -1
            ns_param	LobBufferSize      32768
        } else {
            ns_section "ns/db/driver/postgres"
            # Set this parameter, when "psql" is not on your path (OpenACS specific)
            # ns_param	pgbin	"/usr/local/pg960/bin/"
        }
    }

    # Database Pools: This is how NaviServer "talks" to the RDBMS. You
    # need three for OpenACS, named here pool1, pool2 and pool3. Most
    # queries use to first pool, nested queries (i.e. in a db_foreach,
    # which is actually not recommended) use pool2 and so on. Make sure to
    # set the "db_*" the variables with actual values on top of this file.
    #
    # NaviServer can have different pools connecting to different databases
    # and even different database servers.  See
    #
    #     http://openacs.org/doc/tutorial-second-database
    #
    ns_section ns/server/${server}/db {
        ns_param	pools              pool1,pool2,pool3
        ns_param	defaultpool        pool1
    }
    ns_section ns/db/pools {
        ns_param	pool1              "Pool 1"
        ns_param	pool2              "Pool 2"
        ns_param	pool3              "Pool 3"
    }

    ns_section ns/db/pool/pool1 {
        # ns_param	maxidle            0
        # ns_param	maxopen            0
        ns_param	connections        15
        ns_param    LogMinDuration     0.01   ;# when SQL logging is on, log only statements above this duration
        ns_param	logsqlerrors       $debug
        if { $database eq "oracle" } {
            ns_param	driver             ora8
            ns_param	datasource         {}
            ns_param	user               $db_name
            ns_param	password           $db_password
        } else {
            ns_param	driver             postgres
            ns_param	datasource         ${db_host}:${db_port}:dbname=${db_name}
            ns_param	user               $db_user
            ns_param	password           $db_password
        }
    }
    #
    # In case, you want to activate (more intense) SQL logging at runtime,
    # consider the two commands (e.g. entered over ds/shell)
    #
    #    ns_logctl severity "Debug(sql)" on
    #    ns_db logminduration pool1  0.01
    #

    ns_section ns/db/pool/pool2 {
        # ns_param	maxidle            0
        # ns_param	maxopen            0
        ns_param	connections        5
        ns_param    LogMinDuration     0.01   ;# when SQL logging is on, log only statements above this duration
        ns_param	logsqlerrors       $debug
        if { $database eq "oracle" } {
            ns_param	driver             ora8
            ns_param	datasource         {}
            ns_param	user               $db_name
            ns_param	password           $db_password
        } else {
            ns_param	driver             postgres
            ns_param	datasource         ${db_host}:${db_port}:dbname=${db_name}
            ns_param	user               $db_user
            ns_param	password           $db_password
        }
    }

    ns_section ns/db/pool/pool3 {
        # ns_param	maxidle            0
        # ns_param	maxopen            0
        ns_param	connections        5
        # ns_param  LogMinDuration     0.00   ;# when SQL logging is on, log only statements above this duration
        ns_param	logsqlerrors       $debug
        if { $database eq "oracle" } {
            ns_param	driver             ora8
            ns_param	datasource         {}
            ns_param	user               $db_name
            ns_param	password           $db_password
        } else {
            ns_param	driver             postgres
            ns_param	datasource         ${db_host}:${db_port}:dbname=${db_name}
            ns_param	user               $db_user
            ns_param	password           $db_password
        }
    }



    #---------------------------------------------------------------------
    # Which modules should be loaded?  Missing modules break the server, so
    # don't uncomment modules unless they have been installed.

    ns_section ns/server/${server}/modules {
        ns_param	nslog		${bindir}/nslog
        ns_param	nsdb		${bindir}/nsdb
        ns_param	nsproxy		${bindir}/nsproxy.so

        #
        # Load networking modules depending on existence of Tcl variables
        # address_v* and httpsport
        #
        if {[info exists address_v4]} { ns_param nssock_v4 ${bindir}/nssock }
        if {[info exists address_v6]} { ns_param nssock_v6 ${bindir}/nssock }
        if {[info exists address_v4] && [info exists httpsport]} { ns_param nsssl_v4 ${bindir}/nsssl }
        if {[info exists address_v6] && [info exists httpsport]} { ns_param nsssl_v6 ${bindir}/nsssl }

        #
        # Determine, if libthread is installed
        #
        set libthread [lindex [lsort [glob -nocomplain $homedir/lib/thread*/libthread*[info sharedlibextension]]] end]
        if {$libthread eq ""} {
            ns_log notice "No Tcl thread library installed in $homedir/lib/"
        } else {
            ns_param	libthread $libthread
            ns_log notice "Use Tcl thread library $libthread"
        }

        # authorize-gateway package requires dqd_utils
        # ns_param	dqd_utils dqd_utils[expr {int($tcl_version)}]

        # PAM authentication
        # ns_param	nspam              ${bindir}/nspam

        # LDAP authentication
        # ns_param	nsldap             ${bindir}/nsldap

        # These modules aren't used in standard OpenACS installs
        # ns_param	nsperm             ${bindir}/nsperm
        # ns_param	nscgi              ${bindir}/nscgi
    }



    #
    # nsproxy configuration
    #
    ns_section ns/server/${server}/module/nsproxy {
        # ns_param	maxslaves          8
        # ns_param	sendtimeout        5000
        # ns_param	recvtimeout        5000
        # ns_param	waittimeout        100
        # ns_param	idletimeout        3000000
    }

    #
    # nsstats configuration (global module)
    #
    # When installed under acs-subsite/www/admin/nsstats.tcl it is due to
    # its /admin/ location save from public access.
    #
    ns_section "ns/module/nsstats" {
        ns_param enabled  1
        ns_param user     ""
        ns_param password ""
        ns_param bglocks  {oacs:sched_procs}
    }

    #
    # If you want to activate core dumps, one can use the following command
    #
    #ns_log notice "nsd.tcl: ns_rlimit coresize [ns_rlimit coresize unlimited]"

    ns_log notice "nsd.tcl: using threadsafe tcl: [info exists tcl_platform(threaded)]"
    ns_log notice "nsd.tcl: finished reading config file."


<a id="rootfs-usr-local-ns-conf-config-vars-tcl"></a>

## rootfs/usr/local/ns/conf/config\_vars.tcl     :code:

    set hostname "localhost"
    set httpport "8000"
    set system_owner oupfiz5@yandex.ru
    set serverroot /var/www/openacs
    set develop_p 0
    set staging_p 0
    set proxy_mode "false"


<a id="rootfs-var-www-openacs-www-system-openacs-test-tcl"></a>

## rootfs/var/www/openacs/www/SYSTEM/openacs-test.tcl     :code:

    ad_page_contract {

        This is called by server monitoring scripts, such as
        keepalive (see http://arsdigita.com/free-tools/keepalive.html)
        if it doesn't return "success" then they are supposed
        to kill the AOLserver.

        You can also use this with our Uptime monitoring system,
        described in Chapter 15 of http://photo.net/wtr/thebook/

        This tests total db connectivity of all 3 database pools.

        @cvs-id $Id: dbtest.tcl,v 1.2 2009/11/17 22:26:13 ryang Exp $
    } { }


    try {
        if {![ad_verify_install]} {
            ns_log notice "Installation is not complete"
        } else {
            db_foreach check_pool1 "select 1 from acs_objects limit 1" {
                db_foreach check_pool2 "select 1 from acs_objects limit 1" {
                    db_1row check_pool3 "select 1 from acs_objects limit 1"
                }
            }
        }
    } on error {errorMsg} {
        ns_log warning "monitoring: openacs-test runs into an error: $errorMsg"
        ns_return 500 text/plain "1"
    } on ok {result} {
        ns_return 200 text/plain "0"
    }


<a id="rootfs-usr-local-ns-conf-install-oacs-core-config-xml"></a>

## rootfs/usr/local/ns/conf/install-oacs-core-config.xml     :code:

    <?xml version="1.0"?>

    <!-- This must be moved to the OpenACS page root when making a release tarball -->

    <application name="openacs" pretty-name="OpenACS" home="http://openacs.org/">

      <actions>
        <install package="openacs-bootstrap3-theme"/>

        <set-parameter package-key="acs-subsite" name="DefaultMaster" value="tabbed-master"/>
        <set-parameter package-key="acs-subsite" name="StreamingHead" value="tabbed-streaming-head"/>
        <set-parameter package-key="acs-subsite" name="ThemeKey" value="openacs_bootstrap3"/>

        <set-parameter package-key="acs-subsite" name="ResourceDir" value="/packages/openacs-bootstrap3-theme/resources"/>

        <set-parameter package-key="acs-subsite" name="ThemeCSS" value="{-href /resources/acs-subsite/site-master.css -media all -order 0}
                    {-href urn:ad:css:bootstrap3 -media all -order 1}
                    {-href /resources/openacs-bootstrap3-theme/css/main.css -media all -order 2}
                    {-href /resources/openacs-bootstrap3-theme/css/color/grey.css -media all -order 3}
                    {-href /resources/acs-templating/forms.css -media all -order 4}
                    {-href /resources/acs-templating/lists.css -media all -order 5}"/>

        <set-parameter package-key="acs-subsite" name="ThemeJS" value="{-src urn:ad:js:jquery -order 1}
                    {-src urn:ad:js:bootstrap3 -order 2}" />

    <!-- We could mount automaticall additional packages; some packages need to be mounted, before configuration option can be added
        <mount package="..." mount-point="..." instance-name="..."/>
    -->

        <!-- <set-parameter package-key="acs-templating" name="RichTextEditor" value="ckeditor4"/> -->

        <set-parameter package-key="acs-bootstrap-installer" name="post_installation_message" value="When the server restarts click <a href='/acs-admin'>here</a> to configure OpenACS"/>
      </actions>

    </application>


<a id="hook-build-sh"></a>

## hook/build.sh     :code:

    set -a; source ../VERSION ; set +a;

    if [[ ${BRANCH} == 'dev' ]]; then
        TAG_PREFIX='dev-'
    else
        TAG_PREFIX=""
    fi

    docker build --no-cache \
           --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
           --build-arg OACS_TAG="${VERSION}"\
           -t oupfiz5/openacs-s6:"${TAG_PREFIX}${VERSION:-undefine}" \
           -t oupfiz5/openacs-s6:"${TAG_PREFIX}latest" \
           -f ../Dockerfile \
            ../.


<a id="hook-push-sh"></a>

## hook/push.sh     :code:

    set -a; source ../VERSION ; set +a;

    if [[ ${BRANCH} == 'dev' ]]; then
        TAG_PREFIX='dev-'
    else
        TAG_PREFIX=''
    fi

    docker push oupfiz5/openacs-s6:"${TAG_PREFIX}${VERSION:-undefine}"
    docker push oupfiz5/openacs-s6:"${TAG_PREFIX}latest"


<a id="docker-compose-yaml"></a>

## docker-compose.yaml     :code:

    version: '3.9'

    services:
      openacs:
        image: oupfiz5/openacs-s6:latest
        env_file:
          - .env
        volumes:
          - content:/var/www/openacs/content-repository-content-files
          - ./rootfs/usr/local/ns/conf/:/usr/local/ns/conf/
        depends_on:
          - postgres
        ports:
          - ${OA_LISTEN_PORT}:8000
        healthcheck:
          test: ["CMD-SHELL", "wget -qO - http://localhost:8000/SYSTEM/openacs-test || exit 1"]
          interval: 10s
          timeout: 5s
          retries: 2

      postgres:
        image: datacore/postgresql:${POSTGRES_DATACORE_TAG}
        env_file:
          - .env
        ports:
          - "5432"
        healthcheck:
          test: ["CMD-SHELL", "pg_isready -U ${DB_USER}"]
          interval: 10s
          timeout: 5s
          retries: 5

    volumes:
      content:


<a id="docker-compose-official-db-yaml"></a>

## docker-compose-official-db.yaml     :code:

    version: '3.9'

    services:
      openacs:
        image: oupfiz5/openacs-s6:latest
        env_file:
          - .env
        volumes:
          - content:/var/www/openacs/content-repository-content-files
          - ./rootfs/usr/local/ns/conf/:/usr/local/ns/conf/
        depends_on:
          - postgres
        ports:
          - ${OA_LISTEN_PORT}:8000
        healthcheck:
          test: ["CMD-SHELL", "wget -qO - http://localhost:8000/SYSTEM/openacs-test || exit 1"]
          interval: 10s
          timeout: 5s
          retries: 2

      postgres:
        image: postgres:${POSTGRES_OFFICIAL_TAG}
        environment:
          POSTGRES_DB: ${DB_NAME}
          POSTGRES_PASSWORD: ${DB_NAME}
          POSTGRES_USER: ${DB_USER}
        ports:
          - "5432"
        volumes:
          - db_data:/var/lib/postgresql/data
        healthcheck:
          test: ["CMD-SHELL", "pg_isready -U ${DB_USER}"]
          interval: 10s
          timeout: 5s
          retries: 5

    volumes:
      db_data:
      content:


<a id="-env"></a>

## .env     :code:

    # * Common
    TZ="${TZ:-UTC}"

    # * OpenACS
    NS_CONF="${NS_CONF:-/usr/local/ns/conf/openacs_config.tcl}"
    NS_VARS="${NS_VARS:-/usr/local/ns/conf/config_vars.tcl}"
    OA_LISTEN_PORT="${OA_LISTEN_PORT:-8080}"

    # * Postgres
    DB_HOST="${DB_HOST:-postgres}"
    DB_NAME="${DB_NAME:-openacs}"
    DB_PASS="${DB_PASS:-testing}"
    DB_USER="${DB_USER:-openacs}"
    POSTGRES_OFFICIAL_TAG="10-alpine"
    POSTGRES_DATACORE_TAG="10.12"
