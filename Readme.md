# Table of Contents

-   [About](#org583713e)
-   [Quickstart](#orgb6054e2)
    -   [Manage OpenACS using docker-compose.yaml](#org222e95c)
        -   [Prerequisite](#org74f97db)
        -   [Start/stop interactive](#orgfd33291)
        -   [Start/stop/remove as daemon](#org5270d1a)
        -   [View logs](#orga810d72)
        -   [View list containers](#orgb247e2c)
        -   [Prune all](#orgcaab04b)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org74221d6)
        -   [Prerequisite](#org5489114)
        -   [Start/stop interactive](#org4e86cb1)
        -   [Start/stop/remove as daemon](#orgf9fd682)
        -   [View logs](#orge754a1b)
        -   [View list containers](#orgf1e0bc7)
        -   [Prune all](#orgca81166)
-   [Configuration options](#org4e99fd6)
    -   [General options](#org47b0b63)
    -   [Timezone](#org54a35ed)
    -   [OpenACS listen port](#orgeb4c71b)
    -   [NaviServer configuration file](#org2a2c455)
    -   [NaviServer variable file](#org37e6926)
    -   [Database hostname](#org29c9540)
    -   [Database username](#org572f01a)
    -   [Database password](#org947d07f)
    -   [Postgres official tag](#org405079c)
    -   [Postgres datacore tag](#org6d252ac)
-   [CI/CD](#org922b1ed)
-   [Build docker image](#org8e040f1)
    -   [Build from chiselapp (fossil)](#org4490be2)
    -   [Build from GitHub](#orga553fb5)
    -   [Contfiguration](#orga3b551d)
        -   [Build arguments](#org7c55934)
        -   [Example of build](#orgafde94c)
-   [Download from DockerHub](#orgc8c7279)
-   [Maintenance](#orgff839d0)
    -   [Shell access](#orgc9fc171)



<a id="org583713e"></a>

# About

This is [OpenACS](https://openacs.org/) on [Ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  To install OpenACS I used  code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/openacs-s6](https://hub.docker.com/r/oupfiz5/openacs-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using GitHub CI/CD  (GitHub Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="orgb6054e2"></a>

# Quickstart

The quickstart contains two variants:


<a id="org222e95c"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="org74f97db"></a>

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


<a id="orgfd33291"></a>

### Start/stop interactive

start:

    docker-compose up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="org5270d1a"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="orga810d72"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="orgb247e2c"></a>

### View list containers

    docker-compose ps


<a id="orgcaab04b"></a>

### Prune all

    docker system prune --volumes --force


<a id="org74221d6"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="org5489114"></a>

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


<a id="org4e86cb1"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orgf9fd682"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="orge754a1b"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="orgf1e0bc7"></a>

### View list containers

    docker-compose ps


<a id="orgca81166"></a>

### Prune all

    docker system prune --volumes --force


<a id="org4e99fd6"></a>

# Configuration options


<a id="org47b0b63"></a>

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
<td class="org-left"><a href="#org54a35ed">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgeb4c71b">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org2a2c455">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org37e6926">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org29c9540">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org572f01a">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org947d07f">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org405079c">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org6d252ac">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="org54a35ed"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="orgeb4c71b"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="org2a2c455"></a>

## NaviServer configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="org37e6926"></a>

## NaviServer variable file

`NS_VARS` - - configuration file. This configuration file contains several parameters which are frequently changed (e.g. for debug or other configurations). The provided NaviServer configuation file reads the variable file and uses its values.  Default value is `/usr/local/ns/conf/config_vars.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="org29c9540"></a>

## Database hostname

`DB_HOST` set the database hostname for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="org572f01a"></a>

## Database username

`DB_USER` set the database username for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org947d07f"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org405079c"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="org6d252ac"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="org922b1ed"></a>

# CI/CD

For  build and push docker images we use  [GitHub Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="org8e040f1"></a>

# Build docker image


<a id="org4490be2"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open ../openacs-s6.fossil
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="orga553fb5"></a>

## Build from GitHub

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="orga3b551d"></a>

## Contfiguration


<a id="org7c55934"></a>

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


<a id="orgafde94c"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_TAG="oacs-5-10" \
        -t oupfiz5/openacs-s6:oacs-5-10 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="orgc8c7279"></a>

# Download from DockerHub

You can download docker images from dockerhub:

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:oacs-5-10


<a id="orgff839d0"></a>

# Maintenance


<a id="orgc9fc171"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
