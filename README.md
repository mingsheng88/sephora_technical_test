# Backend

Sephora backend rails project

## Stack

1. Rails 5.1.3
2. Ruby 2.4
3. Vue.js frontend ([Link to frontend project](https://github.com/mingsheng88/sephora_front_end))

## General Comments

Most of the technologies / gems chosen were largely for learning purposes. The main components are:

1. `jsonapi-resources`: chosen over `jsonapi-rb` due to maturity
1. `ancestry`: tree-structure supports more versatility. might be overengineering, but since there are no technical decision discussions, decided to implement it regardless
1. `money-rails`: to support operations for money
1. `globalize`: should be using globalize if internationalisation is a concern, but to KISS, did not implement
1. `vue.js`: originally used rails/webpacker but extracted it into separate project for simplicity

With complete understanding that:

1. [Thoughtbot Testing Style - Preference for explicit over implicit](https://robots.thoughtbot.com/how-we-test-rails-applications)
1. Skipped controller tests because they are minimal when using `jsonapi-resources`, therefore, `controller specs = request specs`

## Build Setup

``` bash
gem install bundler
bundle install
rake db:create db:migrate db:seed
```
