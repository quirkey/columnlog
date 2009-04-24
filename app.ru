require File.join(File.dirname(__FILE__), 'app.rb')

disable :run
set :environment, :production
run Sinatra::Application