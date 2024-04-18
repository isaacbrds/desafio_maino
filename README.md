# Blog

# About this project

This is a project to build a simple blog, allowing the users to control your posts and see another user's posts. This project is deployed at http://desafio-maino-isaac.herokuapp.com/



![usando-blog](https://user-images.githubusercontent.com/6543465/143882689-2c4d01d5-aa57-4cc8-8074-c914db4bd992.gif)



# Used Technologies

## Backend
- Ruby 
- Rails 
- Postgresql 


## Frontend

- Html 
- Css 
- Bootsrap 

# Requirements
- Ruby 3.3.0
- Ruby on Rails 7.1.3

## Backend

### dependencies
-  devise
-  rspec
-  factory_bot_rails
-  faker
-  shoulda-matchers 
-  kaminari
-  sidekiq
-  cocoon

## Frontend

### dependencies

- Bootstrap 
- Popperjs
- Redis-Server


# How to execute this project


```bash
# clone repository
git clone https://github.com/isaacbrds/desafio_maino.git 

# access the folder
cd desafio_maino

# Install gems

bundle install

# Create a database
rails db:prepare db:migrate 


```

# How to test this project

```bash 

# Run rspec 

rspec
