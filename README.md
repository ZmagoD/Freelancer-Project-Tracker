# Freelancer Project Tracker

 is a open source simple project management tool to track cost and progress of your projects.

To run this project locally you need to install:

* Ruby 2.4.0

* Postgres (PostgreSQL) 9.6.2

Run `bundle install`, create the database with `bin/rake db:create`
run the migrations `bin/rake db:create` and start the server `bin/rails server`

Open http://localhost:3000/ in your browser and there you have the app running.

### Environmental Variables:

| Name              | Required      | Description                           |
| ----------------- |:-------------:| -------------------------------------:|
| MAIL_SERVER_URL   | Yes           | url for `default_url_options`         |
| SENDGRID_USERNAME | Yes           | sendgrid username to setup the mailer |
| SENDGRID_PASSWORD | Yes           | sendgrid password to setup the mailer |
| HOST_NAME         | Yes           | domain name for smtp setup            |
| MAIL_SENDER       | Yes           | devise `mailer_sender` config env     |

### LICENCE
It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.