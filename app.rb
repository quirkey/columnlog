require File.join(File.dirname(__FILE__), 'lib', 'columnlog.rb')
require File.join(File.dirname(__FILE__), 'vendor', 'sinatra', 'lib', 'sinatra.rb')
require File.join(File.dirname(__FILE__), 'vendor', 'sinatra_helpers', 'authorization.rb')

set :public, Columnlog::Themes.public_path
set :realm, 'Columnlog'

helpers do
  include Sinatra::Authorization
  include Columnlog::TextHelper
  include Columnlog::Themes
  
  def authorize(username, password)
    username == Columnlog::Column.class_attributes[:username] && 
    password == Columnlog::Column.class_attributes[:password]
  end
end

get '/' do
  erb_with_theme :index
end

get '/new' do
  require_administrative_privileges
  erb_with_theme :new
end

post '/new' do
  require_administrative_privileges
  @post = Columnlog::Post.new(:body => params['post_body'])
  
  if @post.save == true
    params[:flash] = "<script type='text/javascript'>$(function() { jQuery.flash.success('You clicked a link and it worked!')});</script>"
    erb_with_theme :index
  else
    params[:flash] = "<script type='text/javascript'>$(function() { jQuery.flash.failure('Your post failed.')});</script>"
    erb_with_theme :new
  end
  
end