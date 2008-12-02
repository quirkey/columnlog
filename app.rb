require File.join(File.dirname(__FILE__), 'lib', 'columnlog.rb')
require File.join(File.dirname(__FILE__), 'vendor', 'sinatra', 'lib', 'sinatra.rb')
require File.join(File.dirname(__FILE__), 'vendor', 'sinatra_helpers', 'authorization.rb')


set :public, 'public'
set :views, "views"
set :realm, 'Columnlog'

helpers do
  include Sinatra::Authorization
  
  def authorize(username, password)
    username == Columnlog::Column.class_attributes[:username] && 
    password == Columnlog::Column.class_attributes[:password]
  end
  
  def truncate_words(text, length = 30, truncate_string = "..." )
    return '' if text.nil?
    words = text.split
    words.length > length ? words[0...length].join(" ") + truncate_string : text
  end
  
  def truncate(text, length = 30, truncate_string = '...')
    return '' if text.blank?
    text.length > length ? text[0..length] + truncate_string : text
  end
  
  def link_to(text, link = nil)
    link ||= text
    "<a href=\"#{link}\">#{text}</a>"
  end
  
  def theme
    Columnlog::Column.theme
  end
  
  def default_theme
    Columnlog::Column.default_theme
  end
  
  def default_view_path
    Sinatra.application.options.views
  end
  
  def erb_with_theme(filename, options = {})
    erb(filename, {:views_directory => view_directory_for_filename_in_theme(filename)}.merge(options))
  end
  
  def view_directory_for_filename_in_theme(filename)
    theme_specific = File.join(default_view_path, theme, "#{filename}.erb")
    File.readable?(theme_specific) ? File.join(default_view_path, theme) : File.join(default_view_path, default_theme)
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