# Accio Bower

**Bower** asset processor for **Rails 4/5**, supporting ***CSS/JS URL Rewriting*** (images, fonts, etc.), and production ***Hashes/Digests***.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'accio_bower'
```

And this line to a new/existing `.bowerrc` file:

```json
{"directory": "vendor/assets/bower_components"}
```

If you **DO NOT** yet have a `bower.json` file:

    $ bundle install
    $ bower init    # follow instructions
    $ bower install --save A-BOWER-PKG-YOU-WANT
    
If you **ALREADY** have a `bower.json` file:

    $ rm -rf bower_components
    $ bundle install
    $ bower install

### To include CSS/JS files in your application

Require the name of the file under the `vendor/assets/bower_components` path.

For example, to include `font-awesome` in `application.css`

```
 *= require 'font-awesome/css/font-awesome.min'
```

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

