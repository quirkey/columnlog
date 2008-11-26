require 'rubygems'
require '../sinatra/lib/sinatra.rb'

get '/about' do
  "I'm running on Version " + Sinatra::VERSION
end
