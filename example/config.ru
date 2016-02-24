require 'rubygems'
require 'bundler'
Bundler.setup

require './homeaway_oauth_helper'

run Sinatra::Application
