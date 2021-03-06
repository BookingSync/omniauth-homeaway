[![CI Build
Status](https://secure.travis-ci.org/BookingSync/omniauth-homeaway.png)](http://travis-ci.org/BookingSync/omniauth-homeaway)

# OmniAuth HomeAway

This is an OmniAuth strategy for authenticating to HomeAway. To
use it, you'll need to sign up for an OAuth2 Application ID and Secret
on the [HomeAway Application's Registration Page](https://www.homeaway.com/platform/).

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-homeaway'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::HomeAway` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :homeaway, ENV['HOMEAWAY_APPLICATION_ID'], ENV['HOMEAWAY_SECRET']
end
```

## Supported Rubies

OmniAuth BookingSync is tested under 2.2, 2.3, 2.4, Ruby-head, JRuby.

[![CI Build
Status](https://secure.travis-ci.org/BookingSync/omniauth-homeaway.png)](http://travis-ci.org/BookingSync/omniauth-homeaway)

## Other Ruby libraries to connect to HomeAway API

* [homeaway-api](https://github.com/homeaway/homeaway_api_ruby) - By HomeAway

## License

Copyright (c) 2016-2017 [BookingSync.com](https://www.bookingsync.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
