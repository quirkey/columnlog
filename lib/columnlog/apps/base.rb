module Columnlog
  module Apps
    class Base
      attr_reader :settings
      
      def initialize(settings = SuperHash.new)
        @settings = SuperHash.new(settings)
        app
      end
      
      def post(params); end
      def get(how_many = nil)
        how_many ||= settings.how_many
      end
      
      def to_post(element, other = {})
        Post.new(other)
      end
      
      protected
      def app; end
      
      def unauthorized!
        raise(Columnlog::Errors::UnauthorizedApp, "Could not log you in for #{self.class} with username: #{settings.username}")
      end
    end
  end
end