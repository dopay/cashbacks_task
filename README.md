# README

### Welcome to pair programming test task!



Your task is to add the ability to create cashback for payments. Every time a payment is made, you should transfer 5 percent to the account of the client named "Cashback." If the client does not have such an account yet, it should be created automatically.

### Stack:

* Ruby 3.2.2

* Rails 7.0.8

* PostgreSQL 9.3 and later


### How to start:

````
git clone git@github.com:pavlodopay/cashbacks_task.git

cd cashbacks_task

cp config/database.yml.example config/database.yml

bundle install

rails db:create db:migrate db:seed

rails s
````
