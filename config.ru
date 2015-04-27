require 'rubygems'
require 'bundler'
Bundler.require(:default)
$LOAD_PATH.unshift('./lib') unless $LOAD_PATH.include?('./lib')
require 'time_api'

run TimeApi
