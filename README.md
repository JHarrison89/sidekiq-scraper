# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Installing Rspec
Rspec will automaticly create a factories directory when a new model is created e.g scaffold so don't create it manually.
I used [this guide](https://dev.to/adrianvalenz/setup-rspec-on-a-fresh-rails-7-project-5gp) but placed `config.include FactoryBot::Syntax::Methods` in the rails_helper.rb file.
