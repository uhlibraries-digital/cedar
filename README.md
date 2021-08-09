# Cedar

[![Code Climate](https://codeclimate.com/github/uhlibraries-digital/cedar/badges/gpa.svg)](https://codeclimate.com/github/uhlibraries-digital/cedar)
[![Build Status](https://travis-ci.org/uhlibraries-digital/cedar.svg?branch=master)](https://travis-ci.org/uhlibraries-digital/cedar)

University of Houston Libraries vocabulary manager built from [iQvoc](https://github.com/innoq/iqvoc).

## Manual Installation

Install gems and build the app

Cedar requires [NodeJS](https://nodejs.org/en/) installed to run.

Setup the appropriate `database.yml` file for your setup.

Setup the `config/secrets.yml` file by running `rake secret` and follow the instructions in the `secrets.yml` file.

```bash
bundle install
rake db:migrate
rake db:seed
```

Once setup you can continue to run the rails server according to your system environment.

## Docker

Inital setup for docker run these commands

```
docker-compose run --rm app rake db:migrate
docker-compose run --rm app rake db:seed 
```

Run Cedar stack
```
docker-compose up
```

Stop Cedar stack
```
docker-compose stop
```

## Usage
Log in with admin rights to get started. Go to Administration section to change account information.

```
Email: admin@iqvoc
Password: admin
```

### Background Jobs

Note that some features like "Import" and "Export" exposed in the Web UI store
their workload as jobs. You can either issue a job worker that runs continuously
and watches for new jobs via

```
$ rake jobs:work
```

or process jobs in a one-off way (in development or via cron):

```
$ rake jobs:workoff
```

### Dependences

Cedar needs [Greens](https://github.com/uhlibraries-digital/greens) installed to mint ARK identifiers

## Custumizing

You will need to follow the iQvoc [Asset pipeline](https://github.com/innoq/iqvoc/wiki/iQvoc-as-a-Rails-Engine#asset-pipeline) when modifying assets like CSS and JavaScript files.