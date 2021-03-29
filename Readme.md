# Table of Contents

-   [About](#orga748197)
-   [Quickstart](#org3c18cb5)
    -   [Manage OpenACS using docker-compose.yaml](#org16a339e)
        -   [Prerequisite](#org9b7a8a8)
        -   [Start/stop interactive](#org069787d)
        -   [Start/stop/remove as daemon](#orga54775a)
        -   [View logs](#org870150a)
        -   [View list containers](#org9c5c184)
        -   [Prune all](#orgf88480f)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org4f35b41)
        -   [Prerequisite](#orgdf0e9ec)
        -   [Start/stop interactive](#org15b7e6e)
        -   [Start/stop/remove as daemon](#orgae089f0)
        -   [View logs](#org6db4306)
        -   [View list containers](#orga5edf79)
        -   [Prune all](#org113a5b6)
-   [Configuration options](#org5b00eab)
    -   [General options](#org9412d10)
    -   [Timezone](#org50f7e31)
    -   [OpenACS listen port](#org20defec)
    -   [Naviserver configuration file](#org8074fe2)
    -   [Naviserver variable file](#org13df4c3)
    -   [Database host](#org60a0248)
    -   [Database user](#org648bcf2)
    -   [Database password](#org90a2ce0)
    -   [Postgres official tag](#org638b428)
    -   [Postgres datacore tag](#org8633176)
-   [CI/CD](#org455e490)
-   [Build docker image](#orgd60ed92)
    -   [Build from chiselapp (fossil)](#org3d74233)
    -   [Build from github](#org4a60f67)
    -   [Contfiguration](#org4a2aefa)
        -   [Build arguments](#org273a7e8)
        -   [Example of build](#org876749c)
-   [Download from DockerHub](#orgc3d2f6d)
-   [Maintenance](#org7aff886)
    -   [Shell access](#org4d66844)



<a id="orga748197"></a>

# About

This is [OpenACS](https://openacs.org/) on [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  For install the OpenACS was used some code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/naviserver-s6](https://hub.docker.com/r/oupfiz5/naviserver-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="org3c18cb5"></a>

# Quickstart

The quickstart contains two variants:


<a id="org16a339e"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="org9b7a8a8"></a>

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


<a id="org069787d"></a>

### Start/stop interactive

start:

    docker-compose up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orga54775a"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="org870150a"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org9c5c184"></a>

### View list containers

    docker-compose ps


<a id="orgf88480f"></a>

### Prune all

    docker system prune --volumes --force


<a id="org4f35b41"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="orgdf0e9ec"></a>

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


<a id="org15b7e6e"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orgae089f0"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="org6db4306"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="orga5edf79"></a>

### View list containers

    docker-compose ps


<a id="org113a5b6"></a>

### Prune all

    docker system prune --volumes --force


<a id="org5b00eab"></a>

# Configuration options


<a id="org9412d10"></a>

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
<td class="org-left"><a href="#org50f7e31">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org20defec">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org8074fe2">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org13df4c3">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org60a0248">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org648bcf2">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org90a2ce0">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org638b428">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org8633176">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="org50f7e31"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="org20defec"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="org8074fe2"></a>

## Naviserver configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="org13df4c3"></a>

## Naviserver variable file

`NS_VARS` - configuration file. Default value is `/usr/local/ns/conf/config_vars.tcl` Using for debug, configure etc.

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="org60a0248"></a>

## Database host

`DB_HOST` set the database host name for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="org648bcf2"></a>

## Database user

`DB_USER` set the database user name for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org90a2ce0"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org638b428"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="org8633176"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="org455e490"></a>

# CI/CD

For  build and push docker images we use  [Github Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="orgd60ed92"></a>

# Build docker image


<a id="org3d74233"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open ../openacs-s6.fossil
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org4a60f67"></a>

## Build from github

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org4a2aefa"></a>

## Contfiguration


<a id="org273a7e8"></a>

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
<td class="org-left">OACS_VERSION</td>
<td class="org-left">5.9.1</td>
<td class="org-left">Set deafaul OpenACS version</td>
</tr>
</tbody>
</table>


<a id="org876749c"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_VERSION="5.9.1" \
        -t oupfiz5/openacs-s6:5.9.1 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="orgc3d2f6d"></a>

# Download from DockerHub

You can download docker images from dockerhub:

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:5.10


<a id="org7aff886"></a>

# Maintenance


<a id="org4d66844"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
