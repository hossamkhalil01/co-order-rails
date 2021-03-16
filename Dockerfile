FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /co-order-rails
WORKDIR /co-order-rails

ADD Gemfile /co-order-rails/Gemfile
ADD Gemfile.lock /co-order-rails/Gemfile.lock 


RUN yes | apt install npm
RUN npm install --global yarn
RUN yarn add bootstrap@next 
RUN yarn add popper.js
RUN yarn add @popperjs/core

RUN bundle install

ADD . /co-order-rails
