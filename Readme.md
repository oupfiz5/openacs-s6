# Table of Contents

-   [About](#org2965fdf)
-   [Quickstart](#orga942c43)
    -   [Manage OpenACS using docker-compose.yaml](#org16c89cb)
        -   [Prerequisite](#org36d55ff)
        -   [Start/stop interactive](#org0cb5745)
        -   [Start/stop/remove as daemon](#org5c38dee)
        -   [View logs](#org5729d67)
        -   [View list containers](#org9dfae95)
        -   [Prune all](#orgc658e31)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org24e85af)
        -   [Prerequisite](#org7f628c1)
        -   [Start/stop interactive](#orgff4989c)
        -   [Start/stop/remove as daemon](#orgae0b3c3)
        -   [View logs](#org6c1e9e8)
        -   [View list containers](#org8a6ab8e)
        -   [Prune all](#orgee9cd16)
-   [Configuration options](#org0380de5)
    -   [General options](#orgcb58f9c)
    -   [Timezone](#orgd9115cc)
    -   [OpenACS listen port](#orgb741127)
    -   [NaviServer configuration file](#org731f5dc)
    -   [NaviServer variable file](#orge62bd23)
    -   [Database hostname](#org56b49f6)
    -   [Database username](#org031f4d4)
    -   [Database password](#org851ebb2)
    -   [Postgres official tag](#org0bd0fff)
    -   [Postgres datacore tag](#org8ebc2fc)
-   [CI/CD](#orga2891ab)
-   [Build docker image](#org41485f6)
    -   [Build from chiselapp (fossil)](#org064f7c9)
    -   [Build from GitHub](#org1b5eb2e)
    -   [Contfiguration](#org2c3ba36)
        -   [Build arguments](#orgafc4867)
        -   [Example of build](#org26fa34d)
-   [Download from DockerHub](#org5410ce9)
-   [Maintenance](#orge335728)
    -   [Shell access](#org3f0fbf6)



<a id="org2965fdf"></a>

# About

This is [OpenACS](https://openacs.org/) on [Ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  To install OpenACS I used  code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/openacs-s6](https://hub.docker.com/r/oupfiz5/openacs-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using GitHub CI/CD  (GitHub Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="orga942c43"></a>

# Quickstart

The quickstart contains two variants:


<a id="org16c89cb"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="org36d55ff"></a>

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


<a id="org0cb5745"></a>

### Start/stop interactive

start:

    docker-compose up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="org5c38dee"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="org5729d67"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org9dfae95"></a>

### View list containers

    docker-compose ps


<a id="orgc658e31"></a>

### Prune all

    docker system prune --volumes --force


<a id="org24e85af"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="org7f628c1"></a>

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


<a id="orgff4989c"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orgae0b3c3"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="org6c1e9e8"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org8a6ab8e"></a>

### View list containers

    docker-compose ps


<a id="orgee9cd16"></a>

### Prune all

    docker system prune --volumes --force


<a id="org0380de5"></a>

# Configuration options


<a id="orgcb58f9c"></a>

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
<td class="org-left"><a href="#orgd9115cc">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgb741127">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org731f5dc">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orge62bd23">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org56b49f6">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org031f4d4">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org851ebb2">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org0bd0fff">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org8ebc2fc">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="orgd9115cc"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="orgb741127"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="org731f5dc"></a>

## NaviServer configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="orge62bd23"></a>

## NaviServer variable file

`NS_VARS` - - configuration file. This configuration file contains several parameters which are frequently changed (e.g. for debug or other configurations). The provided NaviServer configuation file reads the variable file and uses its values.  Default value is `/usr/local/ns/conf/config_vars.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="org56b49f6"></a>

## Database hostname

`DB_HOST` set the database hostname for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="org031f4d4"></a>

## Database username

`DB_USER` set the database username for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org851ebb2"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org0bd0fff"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="org8ebc2fc"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="orga2891ab"></a>

# CI/CD

For  build and push docker images we use  [GitHub Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="org41485f6"></a>

# Build docker image


<a id="org064f7c9"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open ../openacs-s6.fossil
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org1b5eb2e"></a>

## Build from GitHub

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org2c3ba36"></a>

## Contfiguration


<a id="orgafc4867"></a>

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


<a id="org26fa34d"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_TAG="oacs-5-10" \
        -t oupfiz5/openacs-s6:oacs-5-10 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="org5410ce9"></a>

# Download from DockerHub

You can download docker images from dockerhub:

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:oacs-5-10


<a id="orge335728"></a>

# Maintenance


<a id="org3f0fbf6"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
