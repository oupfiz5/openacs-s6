# Table of Contents

-   [About](#orgfc95820)
-   [Installation](#org0eeece4)
    -   [Download from dockerhub](#orgcbf073f)
    -   [Build from chiselapp (fossil)](#orgdd03115)
    -   [Build from github](#org0ead688)
    -   [Contfiguration](#org6e575f8)
        -   [Build arguments](#org178fc9f)
        -   [Example of build](#org5abd118)
-   [Configuration options](#orgcfced3f)
    -   [General options](#orgcb53efa)
    -   [Timezone](#org9a6cf4d)
    -   [OpenACS listen port](#orgfd445c3)
    -   [Naviserver configuration file](#org6cd50fc)
    -   [Naviserver variable file](#orge5743b9)
    -   [Database host](#org72f1e12)
    -   [Database user](#org17da473)
    -   [Database password](#org3f3d990)
    -   [Postgres official tag](#org3c3c476)
    -   [Postgres datacore tag](#org25d1820)
-   [Quickstart](#org44348ce)
    -   [Manage OpenACS using docker-compose.yaml](#orge4ed323)
        -   [Start/stop interactive](#orgd1e0dae)
        -   [Start/stop/remove as daemon](#org4d23a42)
        -   [View logs](#orge88e60b)
        -   [View list containers](#org2e20014)
        -   [Prune all](#org8afc3af)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org9621082)
        -   [Start/stop interactive](#org535d5b1)
        -   [Start/stop/remove as daemon](#org52a8bc3)
        -   [View logs](#orgc53ff2c)
        -   [View list containers](#orgbab7545)
        -   [Prune all](#orgde8c3f8)
-   [CI/CD](#org003d318)
-   [Maintenance](#org494ca56)
    -   [Shell access](#org3c8104d)



<a id="orgfc95820"></a>

# About

This is [OpenACS](https://openacs.org/) on [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  For install the OpenACS was used some code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/naviserver-s6](https://hub.docker.com/r/oupfiz5/naviserver-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="org0eeece4"></a>

# Installation


<a id="orgcbf073f"></a>

## Download from dockerhub

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:5.10


<a id="orgdd03115"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open openacs-s6/openacs-s6.fossil

Build image using one step:

    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org0ead688"></a>

## Build from github

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org6e575f8"></a>

## Contfiguration


<a id="org178fc9f"></a>

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


<a id="org5abd118"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_VERSION="5.9.1" \
        -t oupfiz5/openacs-s6:5.9.1 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="orgcfced3f"></a>

# Configuration options


<a id="orgcb53efa"></a>

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
<td class="org-left"><a href="#org9a6cf4d">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgfd445c3">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org6cd50fc">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orge5743b9">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org72f1e12">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org17da473">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org3f3d990">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org3c3c476">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org25d1820">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="org9a6cf4d"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="orgfd445c3"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="org6cd50fc"></a>

## Naviserver configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="orge5743b9"></a>

## Naviserver variable file

`NS_VARS` - configuration file. Default value is `/usr/local/ns/conf/config_vars.tcl` Using for debug, configure etc.

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="org72f1e12"></a>

## Database host

`DB_HOST` set the database host name for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="org17da473"></a>

## Database user

`DB_USER` set the database user name for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org3f3d990"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org3c3c476"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="org25d1820"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="org44348ce"></a>

# Quickstart


<a id="orge4ed323"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="orgd1e0dae"></a>

### Start/stop interactive

start:

    docker-compose up

stop:

    <Ctrl>+C


<a id="org4d23a42"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="orge88e60b"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org2e20014"></a>

### View list containers

    docker-compose ps


<a id="org8afc3af"></a>

### Prune all

    docker system prune --volumes --force


<a id="org9621082"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="org535d5b1"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

stop:

    <Ctrl>+C


<a id="org52a8bc3"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="orgc53ff2c"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="orgbab7545"></a>

### View list containers

    docker-compose ps


<a id="orgde8c3f8"></a>

### Prune all

    docker system prune --volumes --force


<a id="org003d318"></a>

# CI/CD

For  build and push docker images we use  [Github Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="org494ca56"></a>

# Maintenance


<a id="org3c8104d"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
