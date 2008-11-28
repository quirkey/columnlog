require 'rubygems'
require 'activesupport'
require 'yaml'
require 'chronic'
require 'static_model'
require 'net/http'
require 'uri'
require 'twitter'
require 'xml'

module Columnlog
  
  def self.root
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
end

%w{
  super_hash 
  post
  column
  apps/base
  apps/twitter 
  apps/tumblr
}.each do |file|
    require File.join(File.dirname(__FILE__), 'columnlog', file)
  end
  
