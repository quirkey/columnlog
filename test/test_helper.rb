require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'mocha'

require File.dirname(__FILE__) + '/../lib/columnlog'

module Columnlog
  class Column < StaticModel::Base
    set_data_file File.join(File.dirname(__FILE__), 'data', 'columns.yml')
  end
end

class Test::Unit::TestCase
  
  include Columnlog
end