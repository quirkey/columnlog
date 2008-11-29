require File.join(File.dirname(__FILE__), 'lib', 'columnlog.rb')
require File.join(File.dirname(__FILE__), 'vendor', 'sinatra', 'lib', 'sinatra.rb')
require File.join(File.dirname(__FILE__), 'vendor', 'sinatra_helpers', 'authorization.rb')

set :public, 'public'
set :views, 'views' 
set :realm, 'Columnlog'

helpers do
  include Sinatra::Authorization
  
  def authorize(username, password)
    username == Columnlog::Column.class_attributes[:username] && 
    password == Columnlog::Column.class_attributes[:password]
  end
end

get '/' do
  erb :index
end

get '/new' do
  require_administrative_privileges
  erb :new
end

post '/new' do
  require_administrative_privileges
  @post = Columnlog::Post.new(:body => params['post_body'])
  @post.save
  redirect '/'
end