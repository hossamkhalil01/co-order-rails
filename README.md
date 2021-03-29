# **Co-Order**

Co-Order is a web application that helps you coordinate and place orders with your friends.
The project is developed using Ruby on Rails framework and MySQL database.

## Table of Contents

---

<!-- TOC -->

- [Features](#features)
- [Getting Started](#getting-started)
  - [Setup Your Environment](#setup-your-environment)
  - [Using Docker](#using-docker)
- [Configurations](#configurations)
- [Dependencies](#dependencies)
- [Limitations](#limitations)
- [Possible Improvements](#possible-improvements)
- [About Us](#about-us)
<!-- /TOC -->

## Features

---

- Sign in with your Google / Facebook accounts
- Add friends by their emails.
- The ability to invite your friends to your order, so they can participate and include their items.
- Notifications that tells you whenever a relevant event occurs.
- Create group of your favorite friends, so that it's easier for you to invite them by using the group's name.

## Getting Started

---

To use and run this project you need to:

Before executing the following commands, please setup the [dependencies](#dependencies)

#### Setup Your Environment

---

1. Run the following command to install all the required gems.

```bash
bundle install
```

2. Setup the database (mysql in this case).

```bash
rails db:create db:migrate
```

```bash
rails s
```

##### Note:

Make sure that your database is up and configured properly for the application to work.

#### Using Docker

---

You can also use the docker image provided to setup a running environment
for the application to avoid any environment conflicts.

Change your working directory to the projects folder and execute the following commands (only one time)

```bash
docker-compose build
```

to build the image and then

```bash
docker-compose run app rails db:create db:migrate
```

to setup the database.

Whenever you want to run the server through the container run the following
in the project's directory.

```bash
docker-compose up
```

## Configurations

---

You can configure the application to connect to your database in the [database.yml](https://github.com/hossamkhalil01/TicTacToe-Java-Project/co-order-rails/blob/main/config/database.yml) file.

As for the Facebook and Google API's configurations you will need to:

- Delete [credentials.yml](https://github.com/hossamkhalil01/TicTacToe-Java-Project/co-order-rails/blob/main/config/credentials.yml.enc)

- Run EDITOR="code --wait" rails credentials:edit

- write the Google and Facebook APIs' keys
  - google_api_public:
  - google_api_secret:
  - facebook_api_public:
  - facebook_api_secret:
- Save then close the file

## Dependencies

---

- [Ruby 3.0.0](https://www.ruby-lang.org/en/)

## Limitations

---

- A potential shortcoming could be the fact the application doesn't have a live feed in the landing page.

## Possible Improvements

---

- Integrate with restaurants to provide advantages such as in app orders.

---

## About Us

We are a team of software engineering students at ITI intake 41, Smart Village branch, Open-source application track.
