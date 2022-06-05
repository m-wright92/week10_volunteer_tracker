# Volunteer Tracker

#### Set up projects and assign volunteers

#### By Mike Wright

## Technologies Used

* Ruby
* Sinatra
* Regex
* rspec
* capybara
* pry
* Postgres
* psql

## This site is a simple way to setup and organize projects and add volunteers to each project

## Setup/Installation Requirements

* Clone this repo
* Run `createdb volunteer_tracker`
* Run `psql volunteer_tracker < database_backup.sql`
* Run `createdb -T volunteer_tracker` volunteer_tracker_test
* Run `bundle` in your terminal from within the root directory of this project
* To check all passing test specs, run `rspec` in the terminal, this will test all files in the 'spec' directory.
* Run `ruby app.rb` in the terminal from the root directory
* Open your browser and navigate to http://localhost:4567/
* You can now navigate the site

## Known Bugs

* No known bugs at this time

## License 

MIT

## Copyright (c) 05-06-2022 Mike Wright