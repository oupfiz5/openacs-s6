# Table of Contents

-   [About](#org2e8b673)
-   [Installation](#org83f172a)
    -   [Download from dockerhub](#org972dc40)
    -   [Build from chiselapp (fossil)](#org59d9d1b)
    -   [Build from github](#orge48ccb8)
    -   [Contfiguration](#orgb599cd9)
        -   [Build arguments](#org202fa6a)
        -   [Example of build](#org13c8b92)
-   [Configuration options](#org44bee6d)
    -   [General options](#org2111b07)
    -   [Timezone](#org6274d79)
    -   [OpenACS listen port](#orgb5095af)
    -   [Naviserver configuration file](#org1473978)
    -   [Naviserver variable file](#org2d98b44)
    -   [Database host](#orgcfa7adb)
    -   [Database user](#org30d74a6)
    -   [Database password](#org24edac7)
    -   [Postgres official tag](#org4de8cc0)
    -   [Postgres datacore tag](#orge5d85b2)
-   [Quickstart](#org095396c)
    -   [Manage OpenACS using docker-compose.yaml](#org7cb2f21)
        -   [Start/stop interactive](#org951bbdb)
        -   [Start/stop/remove as daemon](#org7942f15)
        -   [View logs](#org4fd46e9)
        -   [View list containers](#org960543a)
        -   [Prune all](#org0f30cc3)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#orge69a018)
        -   [Start/stop interactive](#org0f99677)
        -   [Start/stop/remove as daemon](#orgd808490)
        -   [View logs](#orgfe8e623)
        -   [View list containers](#orgef1541c)
        -   [Prune all](#org039d074)
-   [CI/CD](#orge05141e)
-   [Maintenance](#orgeda366a)
    -   [Shell access](#org8f7eecd)



<a id="org2e8b673"></a>

# About

This is [OpenACS](https://openacs.org/) on [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  For install the OpenACS was used some code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/naviserver-s6](https://hub.docker.com/r/oupfiz5/naviserver-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="org83f172a"></a>

# Installation


<a id="org972dc40"></a>

## Download from dockerhub

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:5.10


<a id="org59d9d1b"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open openacs-s6/openacs-s6.fossil

Build image using one step:

    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="orge48ccb8"></a>

## Build from github

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="orgb599cd9"></a>

## Contfiguration


<a id="org202fa6a"></a>

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


<a id="org13c8b92"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_VERSION="5.9.1" \
        -t oupfiz5/openacs-s6:5.9.1 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="org44bee6d"></a>

# Configuration options


<a id="org2111b07"></a>

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
<td class="org-left"><a href="#org6274d79">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgb5095af">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org1473978">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org2d98b44">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgcfa7adb">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org30d74a6">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org24edac7">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org4de8cc0">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orge5d85b2">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="org6274d79"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="orgb5095af"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="org1473978"></a>

## Naviserver configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="org2d98b44"></a>

## Naviserver variable file

`NS_VARS` - configuration file. Default value is `/usr/local/ns/conf/config_vars.tcl` Using for debug, configure etc.

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="orgcfa7adb"></a>

## Database host

`DB_HOST` set the database host name for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="org30d74a6"></a>

## Database user

`DB_USER` set the database user name for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org24edac7"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org4de8cc0"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="orge5d85b2"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="org095396c"></a>

# Quickstart


<a id="org7cb2f21"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="org951bbdb"></a>

### Start/stop interactive

start:

    docker-compose up

stop:

    <Ctrl>+C


<a id="org7942f15"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="org4fd46e9"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org960543a"></a>

### View list containers

    docker-compose ps


<a id="org0f30cc3"></a>

### Prune all

    docker system prune --volumes --force


<a id="orge69a018"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="org0f99677"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

stop:

    <Ctrl>+C


<a id="orgd808490"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="orgfe8e623"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="orgef1541c"></a>

### View list containers

    docker-compose ps


<a id="org039d074"></a>

### Prune all

    docker system prune --volumes --force


<a id="orge05141e"></a>

# CI/CD

For  build and push docker images we use  [Github Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="orgeda366a"></a>

# Maintenance


<a id="org8f7eecd"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
