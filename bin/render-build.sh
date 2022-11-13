#!/usr/bin/env bash

set -o errexit
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
bundle exec rails runner "User.destroy_all; CharacterCategory.destroy_all; CharacterSystem.destroy_all;"
bundle exec rake db:seed
