require File.join(File.dirname(__FILE__), 'app.rb')

disable :run

set :port, 9000
set :env, :production
set :public, 'public'
set :views, 'views' 

run Sinatra.application