# Docker

The provided Dockerfiles and docker-compose allow you to bring up a dockerized application stack for development / testing.

## Pre-requisites

Install docker and docker-compose (see https://docs.docker.com/compose/install/)

## Build the images:

```
> bundle install # ensure all gems are in place and the Gemfile is up to date
> docker-compose build
```

## Bring up the services:

```
> docker-compose up web
```

Or (in background)
```
> docker-compose up -d web
```

## Setup

```
> docker-compose exec web db:create db:migrate db:seed
```

Note: db:seed setups up the admin sets and collection types and creates an admin user admin@example.com / testing123

## with VIRTUAL_HOST

To use a VIRTUAL_HOST (eg. trinity.docker), install dory:

```
> gem install dory
> dory up
```
