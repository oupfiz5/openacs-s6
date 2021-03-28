# Table of Contents

-   [About](#orga1e3c31)
-   [Quickstart](#org7095ec2)
    -   [Manage OpenACS using docker-compose.yaml](#orgede178b)
        -   [Start/stop interactive](#org99b9e12)
        -   [Start/stop/remove as daemon](#orga4e5f94)
        -   [View logs](#org5a190de)
        -   [View list containers](#org3a492bc)
        -   [Prune all](#org3411117)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org4dc4c08)
        -   [Start/stop interactive](#org17374dc)
        -   [Start/stop/remove as daemon](#org64e827c)
        -   [View logs](#orgcc77a16)
        -   [View list containers](#orge4e03f8)
        -   [Prune all](#org568207e)
-   [Configuration options](#org00311a6)
    -   [General options](#orge459490)
    -   [Timezone](#org9e62297)
    -   [OpenACS listen port](#orge256b76)
    -   [Naviserver configuration file](#orgaec49d2)
    -   [Naviserver variable file](#org30317d6)
    -   [Database host](#org03dfa97)
    -   [Database user](#orge7edc64)
    -   [Database password](#org016f9ab)
    -   [Postgres official tag](#org2ef93b0)
    -   [Postgres datacore tag](#orgc9d3fb8)
-   [CI/CD](#org7d7d65d)
-   [Build docker image](#org10d17b9)
    -   [Download from dockerhub](#orgd67ebf2)
    -   [Build from chiselapp (fossil)](#org268e14f)
    -   [Build from github](#orga8381c4)
    -   [Contfiguration](#org2f872c9)
        -   [Build arguments](#org4d35f20)
        -   [Example of build](#org8407d7f)
-   [Maintenance](#org6a32402)
    -   [Shell access](#org2d3c642)



<a id="orga1e3c31"></a>

# About

This is [OpenACS](https://openacs.org/) on [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  For install the OpenACS was used some code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/naviserver-s6](https://hub.docker.com/r/oupfiz5/naviserver-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="org7095ec2"></a>

# Quickstart


<a id="orgede178b"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="org99b9e12"></a>

### Start/stop interactive

start:

    docker-compose up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orga4e5f94"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="org5a190de"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org3a492bc"></a>

### View list containers

    docker-compose ps


<a id="org3411117"></a>

### Prune all

    docker system prune --volumes --force


<a id="org4dc4c08"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="org17374dc"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="org64e827c"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="orgcc77a16"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="orge4e03f8"></a>

### View list containers

    docker-compose ps


<a id="org568207e"></a>

### Prune all

    docker system prune --volumes --force


<a id="org00311a6"></a>

# Configuration options


<a id="orge459490"></a>

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
<td class="org-left"><a href="#org9e62297">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orge256b76">OA_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgaec49d2">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org30317d6">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for Naviserver</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org03dfa97">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orge7edc64">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org016f9ab">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org2ef93b0">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgc9d3fb8">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="org9e62297"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="orge256b76"></a>

## OpenACS listen port

`OA_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OA_LISTEN_PORT=8070 docker-compose up


<a id="orgaec49d2"></a>

## Naviserver configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="org30317d6"></a>

## Naviserver variable file

`NS_VARS` - configuration file. Default value is `/usr/local/ns/conf/config_vars.tcl` Using for debug, configure etc.

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="org03dfa97"></a>

## Database host

`DB_HOST` set the database host name for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="orge7edc64"></a>

## Database user

`DB_USER` set the database user name for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org016f9ab"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org2ef93b0"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="orgc9d3fb8"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="org7d7d65d"></a>

# CI/CD

For  build and push docker images we use  [Github Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="org10d17b9"></a>

# Build docker image


<a id="orgd67ebf2"></a>

## Download from dockerhub

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:5.10


<a id="org268e14f"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open openacs-s6/openacs-s6.fossil

Build image using one step:

    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="orga8381c4"></a>

## Build from github

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org2f872c9"></a>

## Contfiguration


<a id="org4d35f20"></a>

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


<a id="org8407d7f"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_VERSION="5.9.1" \
        -t oupfiz5/openacs-s6:5.9.1 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="org6a32402"></a>

# Maintenance


<a id="org2d3c642"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
