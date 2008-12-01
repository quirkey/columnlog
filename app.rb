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
  puts params
  erb :index
end

get '/new' do
  require_administrative_privileges
  erb :new
end

post '/new' do
  require_administrative_privileges
  @post = Columnlog::Post.new(:body => params['post_body'])
  
  if @post.save == true
    params[:flash] = "<script type='text/javascript'>$(function() { jQuery.flash.success('You clicked a link and it worked!')});</script>"
    erb :index
  else
    params[:flash] = "<script type='text/javascript'>$(function() { jQuery.flash.failure('Your post failed.')});</script>"
    erb :new
  end
  
end