require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'mocha'

require File.dirname(__FILE__) + '/../lib/columnlog'


class Test::Unit::TestCase
  
  include Columnlog
end