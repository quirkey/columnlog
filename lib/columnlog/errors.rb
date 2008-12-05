module Columnlog
  module Errors
    
    class Error < Exception; end
    class UnauthorizedApp < Error; end
  end
end