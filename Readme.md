# Table of Contents

-   [About](#orgd9522a0)
-   [Quickstart](#orgd0bd276)
    -   [Manage OpenACS using docker-compose.yaml](#orgecce5d7)
        -   [Prerequisite](#orgdfca233)
        -   [Start/stop interactive](#org7220c79)
        -   [Start/stop/remove as daemon](#orgb91f5fb)
        -   [View logs](#org09fd99b)
        -   [View list containers](#orgb7add66)
        -   [Prune all](#orgac70790)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org0138f01)
        -   [Prerequisite](#org422377d)
        -   [Start/stop interactive](#org10ad621)
        -   [Start/stop/remove as daemon](#orgd172168)
        -   [View logs](#org2c47563)
        -   [View list containers](#org27dce33)
        -   [Prune all](#orgfc22acc)
-   [Configuration options](#orgb38d744)
    -   [General options](#orgf88e009)
    -   [Timezone](#org17a2aa6)
    -   [OpenACS listen port](#orgb97fba3)
    -   [NaviServer configuration file](#org1969e90)
    -   [NaviServer variable file](#org47ce901)
    -   [Database hostname](#orgb8ad5d5)
    -   [Database username](#orgf2dffd0)
    -   [Database password](#org798ebdb)
    -   [Postgres official tag](#org2510baf)
    -   [Postgres datacore tag](#orge3a3a4c)
-   [CI/CD](#org1ce8b26)
-   [Build docker image](#orgb91acab)
    -   [Build from chiselapp (fossil)](#org07c0317)
    -   [Build from GitHub](#orgc7c14a1)
    -   [Contfiguration](#orgd1b11dd)
        -   [Build arguments](#org4e55480)
        -   [Example of build](#org698399d)
-   [Download from DockerHub](#orgb663d11)
-   [Maintenance](#org812f17a)
    -   [Shell access](#orgc88cd6c)



<a id="orgd9522a0"></a>

# About

This is [OpenACS](https://openacs.org/) on [Ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  To install OpenACS I used  code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/openacs-s6](https://hub.docker.com/r/oupfiz5/openacs-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using GitHub CI/CD  (GitHub Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="orgd0bd276"></a>

# Quickstart

The quickstart contains two variants:


<a id="orgecce5d7"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="orgdfca233"></a>

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


<a id="org7220c79"></a>

### Start/stop interactive

start:

    docker-compose up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orgb91f5fb"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="org09fd99b"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="orgb7add66"></a>

### View list containers

    docker-compose ps


<a id="orgac70790"></a>

### Prune all

    docker system prune --volumes --force


<a id="org0138f01"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="org422377d"></a>

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


<a id="org10ad621"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orgd172168"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="org2c47563"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org27dce33"></a>

### View list containers

    docker-compose ps


<a id="orgfc22acc"></a>

### Prune all

    docker system prune --volumes --force


<a id="orgb38d744"></a>

# Configuration options


<a id="orgf88e009"></a>

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
<td class="org-left"><a href="#org17a2aa6">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgb97fba3">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org1969e90">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org47ce901">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgb8ad5d5">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgf2dffd0">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org798ebdb">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org2510baf">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orge3a3a4c">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="org17a2aa6"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="orgb97fba3"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="org1969e90"></a>

## NaviServer configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="org47ce901"></a>

## NaviServer variable file

`NS_VARS` - - configuration file. This configuration file contains several parameters which are frequently changed (e.g. for debug or other configurations). The provided NaviServer configuation file reads the variable file and uses its values.  Default value is `/usr/local/ns/conf/config_vars.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="orgb8ad5d5"></a>

## Database hostname

`DB_HOST` set the database hostname for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="orgf2dffd0"></a>

## Database username

`DB_USER` set the database username for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org798ebdb"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org2510baf"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="orge3a3a4c"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="org1ce8b26"></a>

# CI/CD

For  build and push docker images we use  [GitHub Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="orgb91acab"></a>

# Build docker image


<a id="org07c0317"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open ../openacs-s6.fossil
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="orgc7c14a1"></a>

## Build from GitHub

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="orgd1b11dd"></a>

## Contfiguration


<a id="org4e55480"></a>

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


<a id="org698399d"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_TAG="oacs-5-10" \
        -t oupfiz5/openacs-s6:oacs-5-10 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="orgb663d11"></a>

# Download from DockerHub

You can download docker images from dockerhub:

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:oacs-5-10


<a id="org812f17a"></a>

# Maintenance


<a id="orgc88cd6c"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
