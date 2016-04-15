# Cedar

University of Houston Libraries vocabulary manager built from [iQvoc](https://github.com/innoq/iqvoc).

## Installation

Install gems and build the app

Copy the appropriate `database.yml` file for your setup. For SQLite3, `cp config/database.yml.sqlite3 config/database.yml`. For MySQL, `cp config/database.yml.mysql config/database.yml`. Update the file to match your configuation.

```bash
bundle install
rake db:create
rake db:migrate
rake db:seed
```

Setup the `config/secrets.yml` file by running `rake secret` and follow the instructions in the `secrets.yml` file.

Once setup you can continue to run the rails server according to your system environment.

## Custumizing

You will need to follow the iQvoc [Asset pipeline](https://github.com/innoq/iqvoc/wiki/iQvoc-as-a-Rails-Engine#asset-pipeline) when modifying assets like CSS and JavaScript files.