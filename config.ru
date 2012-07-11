require 'sinatra'
require './app'

enable :sessions

run Sinatra::Application
