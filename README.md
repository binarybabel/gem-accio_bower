# Bower Sprockets for Ruby on Rails

[![Join the chat at https://gitter.im/binarybabel/Latestver](https://badges.gitter.im/binarybabel/gem-accio_bower.svg)](https://gitter.im/binarybabel/gem-accio_bower?utm_source=badge&utm_medium=badge&utm_content=badge) [![Gem Version](https://badge.fury.io/rb/accio_bower.svg)](https://badge.fury.io/rb/accio_bower)

**Bower** asset processor for **Rails 4/5** Sprockets, featuring:

  + ***CSS/JS URL Rewriting*** for images, fonts, etc.
  + Support for production ***Hashes/Digests***

A rewrite/evolution of the Gem [Bowerify](https://rubygems.org/gems/bowerify), with new capabilities.

## Installation

Add this line to your application's **`Gemfile`**:

```ruby
gem 'accio_bower'
```

And this line to a new/existing **`.bowerrc`** file:

```json
{"directory": "vendor/assets/bower_components"}
```

If you **DO NOT** yet have a **`bower.json`** file:

    $ bundle install
    $ bower init    # follow instructions
    $ bower install --save SOME-BOWER-DEPDENDENCY
    
If you **ALREADY** have a **`bower.json`** file:

    $ rm -rf bower_components
    $ bundle install
    $ bower install

### To include CSS/JS files in your application

Use the name of the file under the `vendor/assets/bower_components` path.

For example, to include `font-awesome` in **`application.css`**:

```
 *= require 'font-awesome/css/font-awesome.min'
```

### You'll still need `$ bower install`

This gem does not execute or modify your Bower configuration or components.

* Run `$ bower install` whenever you modify **`bower.json`**
* If you're building in a sandbox, CI, Docker, Heroku, etc.
  * Include `$ bower install; bower prune` in your build-script.
  * Consider saving/restoring `vendor/assets/bower_components` as a build cache.

## Configuration

### Ruby Initializer

**`app/config/initializers/bower.rb`**

```
Rails.application.config.accio_bower.components = [
  Rails.root.join('vendor', 'assets', 'bower_components')
]
Rails.application.config.accio_bower.extensions = %w[
  png gif jpg jpeg ttf svg eot woff woff2
]
```

### Environment Variables
* __BOWER\_PREFIX__
  * default: none - Path prefix for Bower asset URL substitutions, handy for unique CDN setups.
  * `config.action_controller.asset_host` applies as normal.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

