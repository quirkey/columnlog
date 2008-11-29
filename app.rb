require File.join(File.dirname(__FILE__), 'lib', 'columnlog.rb')
require File.join(File.dirname(__FILE__), 'vendor', 'sinatra', 'lib', 'sinatra.rb')

set :public, 'public'
set :views, 'views' 

get '/' do
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @post = Columnlog::Post.new(:body => params['post_body'])
  @post.save
  redirect '/'
end