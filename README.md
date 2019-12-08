# HVWorkout

## Tech Stack
* [Rails](https://rubyonrails.org) API only backend using [PostgreSQL](https://www.postgresql.org) database
* ~~[Angular](https://angular.io) frontend with [PrimeNG](https://www.primefaces.org/primeng/#/) component~~
* [Bootstrap](https://getbootstrap.com) theme
* [Phusion Passenger](https://github.com/HVboom/HowTo-DigitalOcean/wiki/Phusion-Passenger) application server running with [Apache](https://github.com/HVboom/HowTo-DigitalOcean/wiki/Apache) and [Let´s encrypt](https://letsencrypt.org/getting-started/) certificates

## Background
### Books / Tutorials
* [Evil Front](https://evilmartians.com/chronicles/evil-front-part-1)
* ~~Rails, Angular, Postgres, and Bootstrap, 2nd Edition~~
* ~~Angular UI Development with PrimeNG~~
* ~~Reactive Programming with RxJS 5~~

### Websites
* [Git Branching Model](https://nvie.com/posts/a-successful-git-branching-model/)
* [Typescript](http://www.typescriptlang.org/docs/home.html)
* [Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox)
* [BEM](https://en.bem.info/methodology/quick-start/)

## Setup
### Create new app
* see [New Rails Application](https://github.com/HVboom/HowTo-DigitalOcean/wiki/New-Rails-Application)

  ```bash
  create_rails_project HVWorkout
  
  # which runs in a newly created directory
  # bundle exec rails new . --webpack --force --skip-puma --skip-spring --skip-sprockets --skip-test --database=postgresql
  ```
	
* whitelist the host in file `config/application.rb`:

  ```yaml
  ...
  
  # Allow all subdomains (indicated by the first dot) of my virtual host
  config.hosts << '.hvboom.org'
  
  ...
  ```
	
* create a new [GitLab](https://github.com/HVboom/HowTo-DigitalOcean/wiki/New-Rails-Application#git-repository) repository as described

* create the Apache configuration `/usr/local/etc/apache24/Includes/120_vhost_443_hvworkout_demo.conf`

  ```ApacheConf
  <VirtualHost *:443>
    # Serve rails applications in production mode
  
    UseCanonicalName Off
  
    ServerName HVWorkout.Demo.HVboom.org
    VirtualDocumentRoot "/home/mario/RubyOnRails/HVWorkout/public"
  
    PassengerAppEnv "development"
    RailsBaseURI "/"
    <Directory "/home/mario/RubyOnRails/HVWorkout/public">
      Require all granted
      Options -MultiViews 
    </Directory>
  
    SSLEngine on
    SSLCertificateFile      /usr/local/etc/letsencrypt/live/hvboom.org/fullchain.pem
    SSLCertificateKeyFile   /usr/local/etc/letsencrypt/live/hvboom.org/privkey.pem
  
    <IfModule headers_module>
      Header always edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure
      Header always set Strict-Transport-Security "max-age=15768000; includeSubDomains"
    </IfModule>
  </VirtualHost>
  ```

### PostgreSQL
* edit `config/database.yml` to have following default content, but don´t forget to remove the *database* key for the *development*, *test*, and *production* sections

  ```yaml
  ...
  
  default: &default
    adapter: postgresql
    encoding: unicode
    # For details on connection pooling, see Rails configuration guide
    # http://guides.rubyonrails.org/configuring.html#database-pooling
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    database: <%= Rails.application.credentials[Rails.env.to_sym][:db_name] %>
    username: <%= Rails.application.credentials[Rails.env.to_sym][:db_username] %>
    password: <%= Rails.application.credentials[Rails.env.to_sym][:db_password] %>
    
  ...
  ```

* edit `config/credentials.yml.enc` to store the encrypted DB access keys (`EDITOR=vim rails credentials:edit`) - see some [Credential Tricks](https://blog.eq8.eu/til/rails-52-credentials-tricks.html)

  ```yaml
  ...
  
  db_connection: &db_connection
    db_username: workout
    db_password: <secret database password>
  
  development:
    db_name: workout_dev
    <<: *db_connection
  
  test:
    db_name: workout_test
    <<: *db_connection
  
  production:
    db_name: workout_prod
    <<: *db_connection
  
  ...
  ```
	
* create database

  ```bash
	# login with a database superuser and create a db user for the application
	psql -d template1 -U postgres -c "CREATE USER workout CREATEDB PASSWORD '<secret database password>';"
	
	# login as the normal development user and create the database
	rails db:create
	rails db:migrate
	```