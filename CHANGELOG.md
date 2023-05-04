# Changelog
## v3-oacs-5-10 - 2023-05-04

### Added
- `hook/build.sh` image tag `latest` for docker image

### Changed
- used new base docker image [oupfiz5/naviserver-s6:4.99.24](https://hub.docker.com/layers/oupfiz5/naviserver-s6/4.99.24/images/sha256-d7ccbe80d2b582d55c8b73f607cd3281672b0213d8689a86953c57b0cd83f7b5?context=repo)
- `hook/push.sh` push docker image with tag `latest`
- github pipeline will use ``runs-on: ubuntu-22.04`
- writing a new openacs service script (`run, finish, type`)
- writing `oneshot wait-postgres-onetime` service script - start openacs service after db is ready
- updated docker compose dependecies for postgres (`condition: service_healthy`)
