# Table of Contents

-   [About](#orgf0f1560)
-   [Installation](#orgb6a5e3a)
    -   [Download from dockerhub](#org42cb676)
    -   [Build from chiselapp (fossil)](#orgb6b113f)
    -   [Build from github](#org153f700)
    -   [Contfiguration](#org0590a4f)
        -   [Build arguments](#orgbb946eb)
        -   [Example of build](#org672677a)
-   [Configuration options](#orgc45db32)
    -   [General options](#org1827709)
    -   [Timezone](#org2b20cc2)
    -   [OpenACS listen port](#orge0ca608)
    -   [Naviserver configuration file](#org7b84e12)
    -   [Naviserver variable file](#org5f2ec77)
    -   [Database host](#org47da35c)
    -   [Database user](#orgf2b7bb5)
    -   [Database password](#org92b41f5)
    -   [Postgres official tag](#org3bd9cea)
    -   [Postgres datacore tag](#org475a6d7)
-   [Quickstart](#orgd63f701)
    -   [Manage OpenACS using docker-compose.yaml](#org3372374)
        -   [Start/stop interactive](#org8e32235)
        -   [Start/stop/remove as daemon](#org80957ec)
        -   [View logs](#orga6f9f7a)
        -   [View list containers](#org011974f)
        -   [Prune all](#org4987e0e)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org83c9de2)
        -   [Start/stop interactive](#org3936fb8)
        -   [Start/stop/remove as daemon](#orgf5fde3b)
        -   [View logs](#orgd7f0e92)
        -   [View list containers](#org209a05e)
        -   [Prune all](#org4a800a9)
-   [CI/CD](#org7fa86c8)
-   [Maintenance](#org12ecc32)
    -   [Shell access](#org9166979)



<a id="orgf0f1560"></a>

# About

This is [OpenACS](https://openacs.org/) on [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  For install the OpenACS was used some code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/naviserver-s6](https://hub.docker.com/r/oupfiz5/naviserver-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="orgb6a5e3a"></a>

# Installation


<a id="org42cb676"></a>

## Download from dockerhub

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:5.10


<a id="orgb6b113f"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open openacs-s6/openacs-s6.fossil

Build image using one step:

    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org153f700"></a>

## Build from github

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org0590a4f"></a>

## Contfiguration


<a id="orgbb946eb"></a>

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


<a id="org672677a"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_VERSION="5.9.1" \
        -t oupfiz5/openacs-s6:5.9.1 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="orgc45db32"></a>

# Configuration options


<a id="org1827709"></a>

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
<td class="org-left"><a href="#org2b20cc2">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orge0ca608">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org7b84e12">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org5f2ec77">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org47da35c">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgf2b7bb5">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org92b41f5">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org3bd9cea">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org475a6d7">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="org2b20cc2"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="orge0ca608"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="org7b84e12"></a>

## Naviserver configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="org5f2ec77"></a>

## Naviserver variable file

`NS_VARS` - configuration file. Default value is `/usr/local/ns/conf/config_vars.tcl` Using for debug, configure etc.

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="org47da35c"></a>

## Database host

`DB_HOST` set the database host name for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="orgf2b7bb5"></a>

## Database user

`DB_USER` set the database user name for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org92b41f5"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org3bd9cea"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="org475a6d7"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="orgd63f701"></a>

# Quickstart


<a id="org3372374"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="org8e32235"></a>

### Start/stop interactive

start:

    docker-compose up

stop:

    <Ctrl>+C


<a id="org80957ec"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="orga6f9f7a"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org011974f"></a>

### View list containers

    docker-compose ps


<a id="org4987e0e"></a>

### Prune all

    docker system prune --volumes --force


<a id="org83c9de2"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="org3936fb8"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

stop:

    <Ctrl>+C


<a id="orgf5fde3b"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="orgd7f0e92"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org209a05e"></a>

### View list containers

    docker-compose ps


<a id="org4a800a9"></a>

### Prune all

    docker system prune --volumes --force


<a id="org7fa86c8"></a>

# CI/CD

For  build and push docker images we use  [Github Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="org12ecc32"></a>

# Maintenance


<a id="org9166979"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
