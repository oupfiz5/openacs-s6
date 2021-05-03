# Table of Contents

-   [About](#org6df6555)
-   [Quickstart](#org5871638)
    -   [Manage OpenACS using docker-compose.yaml](#orgf36631f)
        -   [Prerequisite](#org4e1400e)
        -   [Start/stop interactive](#orgd2489e1)
        -   [Start/stop/remove as daemon](#org38318c4)
        -   [View logs](#org895c120)
        -   [View list containers](#org5912c08)
        -   [Prune all](#orgfb03aae)
    -   [Manage OpenACS using docker-compose-official-db.yaml](#org22b034c)
        -   [Prerequisite](#orgc6fe0ff)
        -   [Start/stop interactive](#org79b769f)
        -   [Start/stop/remove as daemon](#orgcaf850e)
        -   [View logs](#org1856d66)
        -   [View list containers](#org8e1e946)
        -   [Prune all](#orgd6595c6)
-   [Configuration options](#org45c206c)
    -   [General options](#org3ab9e5f)
    -   [Timezone](#orge7fa197)
    -   [OpenACS listen port](#org7a34622)
    -   [NaviServer configuration file](#orgb0eee27)
    -   [NaviServer variable file](#orgd49b9b2)
    -   [Database hostname](#orga9abb65)
    -   [Database username](#orgc563150)
    -   [Database password](#org94585bb)
    -   [Postgres official tag](#org684e997)
    -   [Postgres datacore tag](#org6d63afe)
-   [CI/CD](#org4ea1d1c)
-   [Build docker image](#org0880267)
    -   [Build from chiselapp (fossil)](#orgfd11405)
    -   [Build from GitHub](#org51ce663)
    -   [Contfiguration](#org1c00034)
        -   [Build arguments](#orgbf0246e)
        -   [Example of build](#org7c7d82b)
-   [Download from DockerHub](#org7fa3ea9)
-   [Maintenance](#org7c071ac)
    -   [Shell access](#orgb8723fe)



<a id="org6df6555"></a>

# About

This is [OpenACS](https://openacs.org/) on [Ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay).  To install OpenACS I used  code from  [Gustaf Neumann](https://github.com/gustafn/install-ns) script [install-oacs.sh](https://github.com/gustafn/install-ns/blob/master/install-oacs.sh). The base image is [oupfiz5/openacs-s6](https://hub.docker.com/r/oupfiz5/openacs-s6).

OpenACS-S6 is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/openacs-s6>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting OpenACS-S6 repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using GitHub CI/CD  (GitHub Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about OpenACS-S6, visit the official self-hosting site linked above.


<a id="org5871638"></a>

# Quickstart

The quickstart contains two variants:


<a id="orgf36631f"></a>

## Manage OpenACS using docker-compose.yaml

We use postgres image from [datacore/postgresql](https://hub.docker.com/r/datacore/postgresql) in docker-compose.yaml file.


<a id="org4e1400e"></a>

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


<a id="orgd2489e1"></a>

### Start/stop interactive

start:

    docker-compose up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="org38318c4"></a>

### Start/stop/remove as daemon

start :

    docker-compose up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose down

remove:

    docker-compose rm


<a id="org895c120"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org5912c08"></a>

### View list containers

    docker-compose ps


<a id="orgfb03aae"></a>

### Prune all

    docker system prune --volumes --force


<a id="org22b034c"></a>

## Manage OpenACS using docker-compose-official-db.yaml

We use [official posgres](https://hub.docker.com/_/postgres) image in docker-compose-official-db.yaml file.


<a id="orgc6fe0ff"></a>

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


<a id="org79b769f"></a>

### Start/stop interactive

start:

    docker-compose -f docker-compose-official-db.yaml up

The site will be accessible by url  <http://localhost:8080>.

stop:

    <Ctrl>+C


<a id="orgcaf850e"></a>

### Start/stop/remove as daemon

start :

    docker-compose -f docker-compose-official-db.yaml up -d

The site will be accessible by url  <http://localhost:8080>.

stop:

    docker-compose -f docker-compose-official-db.yaml down

remove:

    docker-compose -f docker-compose-official-db.yaml rm


<a id="org1856d66"></a>

### View logs

Logs follow:

    docker-compose logs -f

Logs tail:

    docker-compose logs --tail=10


<a id="org8e1e946"></a>

### View list containers

    docker-compose ps


<a id="orgd6595c6"></a>

### Prune all

    docker system prune --volumes --force


<a id="org45c206c"></a>

# Configuration options


<a id="org3ab9e5f"></a>

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
<td class="org-left"><a href="#orge7fa197">TZ</a></td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org7a34622">OACS_LISTEN_PORT</a></td>
<td class="org-left">8080</td>
<td class="org-left">Set http listen port, example 8080</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgb0eee27">NS_CONF</a></td>
<td class="org-left">openacs_config.tcl</td>
<td class="org-left">Configuration file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgd49b9b2">NS_VARS</a></td>
<td class="org-left">config_vars.tcl</td>
<td class="org-left">Variable file for NaviServer</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orga9abb65">DB_HOST</a></td>
<td class="org-left">postgres</td>
<td class="org-left">Database host name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#orgc563150">DB_USER</a></td>
<td class="org-left">openacs</td>
<td class="org-left">Database user name</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org94585bb">DB_PASS</a></td>
<td class="org-left">testing</td>
<td class="org-left">Database user password</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org684e997">POSTGRES_OFFICIAL_TAG</a></td>
<td class="org-left">10-alpine</td>
<td class="org-left">Docker tag from official postgres.</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left"><a href="#org6d63afe">POSTGRES_DATACORE_TAG</a></td>
<td class="org-left">10.12</td>
<td class="org-left">Docker tag from datacore/postgresql</td>
</tr>
</tbody>
</table>

All options have predifined values and store in file `.env` .


<a id="orge7fa197"></a>

## Timezone

Set the timezone for the containers, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    TZ="Europe/Moscow" docker-compose up


<a id="org7a34622"></a>

## OpenACS listen port

`OACS_LISTEN_PORT` set the http listen port for the openacs.  In this case the OpenACS is accessible by URL [http://localhost:8070](http://localhost:8070).

    OACS_LISTEN_PORT=8070 docker-compose up


<a id="orgb0eee27"></a>

## NaviServer configuration file

`NS_CONF` - configuration file. Default value is `/usr/local/ns/conf/openacs-config.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_CONF="/usr/local/ns/conf/my-config.tcl" docker-compose up


<a id="orgd49b9b2"></a>

## NaviServer variable file

`NS_VARS` - - configuration file. This configuration file contains several parameters which are frequently changed (e.g. for debug or other configurations). The provided NaviServer configuation file reads the variable file and uses its values.  Default value is `/usr/local/ns/conf/config_vars.tcl`

1.  Put the configuration file to `rootfs/usr/local/ns/conf`
2.  Run docker compose

    NS_VARS="/usr/local/ns/conf/my_vars.tcl" docker-compose up


<a id="orga9abb65"></a>

## Database hostname

`DB_HOST` set the database hostname for the openacs. By default it has name of docker-compose database  service - postgres.

    DB_HOST=foo docker-compose up


<a id="orgc563150"></a>

## Database username

`DB_USER` set the database username for the openacs and postgres.

    DB_USER=foouser docker-compose up


<a id="org94585bb"></a>

## Database password

`DB_PASS` set the database user password for the openacs and postgres.

    DB_PASS=foopass docker-compose up


<a id="org684e997"></a>

## Postgres official tag

`POSTGRES_OFFICIAL_TAG` set the docker image tag for [official postgres](https://hub.docker.com/_/postgres). Using only for `docker-compose-official-db.yaml`  Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.16-alpine" docker-compose up


<a id="org6d63afe"></a>

## Postgres datacore tag

`POSTGRES_DATACORE_TAG` set the docker image tag for [datacore postgres](https://hub.docker.com/r/datacore/postgresql). Using only for `docker-compose.yaml`. Pay attention - some openacs version can use only correspond version of postgres.

    POSTGRES_OFFICIAL_TAG="10.12" docker-compose up


<a id="org4ea1d1c"></a>

# CI/CD

For  build and push docker images we use  [GitHub Actions workflow](https://github.com/oupfiz5/openacs-s6/blob/master/.github/workflows/on-push.yaml).


<a id="org0880267"></a>

# Build docker image


<a id="orgfd11405"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/openacs-s6 openacs-s6.fossil
    mkdir openacs-s6
    cd openacs-s6
    fossil open ../openacs-s6.fossil
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org51ce663"></a>

## Build from GitHub

    git clone https://github.com/oupfiz5/openacs-s6.git
    cd openacs-s6
    docker build -t oupfiz5/openacs-s6 -f ./Dockerfile .


<a id="org1c00034"></a>

## Contfiguration


<a id="orgbf0246e"></a>

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


<a id="org7c7d82b"></a>

### Example of build

    docker build --no-cache \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg OACS_TAG="oacs-5-10" \
        -t oupfiz5/openacs-s6:oacs-5-10 \
        -t oupfiz5/openacs-s6:latest \
        -f ../Dockerfile \
        ../.


<a id="org7fa3ea9"></a>

# Download from DockerHub

You can download docker images from dockerhub:

    docker pull oupfiz5/openacs-s6:latest
    docker pull oupfiz5/openacs-s6:oacs-5-10


<a id="org7c071ac"></a>

# Maintenance


<a id="orgb8723fe"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it openacs-s6_openacs_1 /bin/bash

    docker exec -it openacs-s6_postgres_1 /bin/bash
