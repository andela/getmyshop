#GetMyShop
[![Circle CI](https://circleci.com/gh/andela/getmyshop.svg?style=svg)](https://circleci.com/gh/andela/getmyshop)
[![Code Climate](https://codeclimate.com/github/andela/getmyshop/badges/gpa.svg)](https://codeclimate.com/github/andela/getmyshop)
[![Coverage Status](https://coveralls.io/repos/github/andela/getmyshop/badge.svg?branch=master)](https://coveralls.io/github/andela/getmyshop?branch=master)

GetMyShop is an awesome online shop rental app. It models a physical shopping complex where traders can rent a pre-designed shopping space and place their goods for sale. Users rent a space from our virtual shopping complex where their customers can shop from. Customers will also be able to invite their friends to shop together online. It saves users the stress and financial burden of having to hire a web developer to build an online store from scratch.

Visit GetMyShop on http://getmyshop-staging.herokuapp.com


##Features
* Users can try the app for a period before subscribing for a paid account.

* Users can edit their virtual space to their preference or use the default design available.

* Free subdomain name with getmyshop with the added option of purchasing a unique name and linking it to the subdomain.

* Social networking platform embedded within the app where customers can talk about products and shop together.

* Various online payment methods supported including bank transfers.


## Getting Started
Clone or fork our repository on [GitHub](https://github.com/andela/getmyshop.git) or download the entire project as a zip package and run locally.

## External Dependencies
Web application is written with Ruby using the Ruby on Rails framework.

To install Ruby visit [Ruby Lang](https://www.ruby-lang.org). [v2.1.6]

To install Rails visit [Ruby on Rails](http://rubyonrails.org/). [v4.2.4]

Install [RubyGems](https://rubygems.org/) and [Bundler](http://bundler.io/) to help you manage dependencies in your [Gemfile](Gemfile).


## Running the App

* Once you have Ruby and Rails installed, clone the repo by running

  ```$ git clone https://github.com/andela/getmyshop.git```

* Then run the following command to install gem dependencies:

  ```$ bundle install```

* Then run the following command to set up the database:

  ```$ bundle exec rake db:migrate```

* Once the command runs successfully, start the Rails server by running:

  ```$ rails server```

* To access the app, visit http://localhost:3000 in a web browser


## Testing

* To test the web application, run the following command to carry out all tests:

  ```$ bundle exec rake spec```

* To view test descriptors, run the following command:

  ```$ bundle exec rake spec -fd```


## Limitations

* GetMyShop is still in development


## Contributing

* Fork it by visiting - https://github.com/andela/getmyshop.git

* Create your feature branch

  ```$ git checkout -b new_feature```

* Contribute to code

* Commit changes made

  ```$ git commit -a -m 'descriptive_message_about_change'```

* Push to branch created

  ```$ git push origin new_feature```

* Then, create a new Pull Request and wait
