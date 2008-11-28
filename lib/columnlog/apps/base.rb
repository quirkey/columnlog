module Columnlog
  module Apps
    class Base
      attr_reader :settings
      
      def initialize(settings = SuperHash.new)
        @settings = settings
        app
      end
      
      def post(params); end
      def get(howmany = 10); end
      
      def to_post(element, other = {})
        Post.new(other)
      end
      
      protected
      def app; end
      
      def unauthorized!
        raise(Errors::UnauthorizedApp, "Could not log you in for #{self.class} with username: #{settings.username}")
      end
    end
  end
end