module Columnlog
  module Apps
    class Tumblr < Base

      def post(params)
      end

      def get(howmany = 10)
        out = []
        # url = "http://mrb.tumblr.com/api/read"
        # parser = XML::Parser.new
        # parser.file = url
        # parsed = parser.parse
        # parsed.find('posts').collect{|x| x.find('post').collect{|x| out << x}}
        out
      end

      def app
        settings
      end

    end
  end
end