module Columnlog
  module Apps
    class Base
      attr_reader :settings
      
      def initialize(settings = SuperHash.new)
        @settings = settings
      end
      
      def post(params); end
      def get(howmany = 10); end
      
      def to_post(element); end
      
      protected
      def app; end
    
    end
  end
end