require 'rubygems'
require 'activesupport'
require 'yaml'

%w{app credentials}.each do |file|
  require File.join(File.dirname(__FILE__), 'columnlog', file)
end