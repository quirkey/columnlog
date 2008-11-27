require File.join(File.dirname(__FILE__), '../columnlog.rb')
require File.join(File.dirname(__FILE__), '../../sinatra/lib/sinatra.rb')

get '/' do
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  Columnlog::App::Twitters.new.post(params[:tweet])
  redirect '/'
end