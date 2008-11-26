require '../columnlog.rb'
require File.join(File.dirname(__FILE__), '../sinatra/lib/sinatra.rb')

get '/about' do
  "I'm running on Version " + Sinatra::VERSION
end
