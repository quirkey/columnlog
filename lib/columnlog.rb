$:.unshift File.dirname(__FILE__)

require 'gems'

module Columnlog
  
  def self.root
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
end

%w{
  super_hash 
  text_helper
  themes
  post
  column
  apps/base
  apps/twitter 
  apps/tumblr
  apps/gist
  apps/rss
  apps/last_fm
  apps/flickr
  apps/text
}.each do |file|
    require File.join('columnlog', file)
  end
  
