module Columnlog
  module Apps
    class Tumblr < Base

      def post(content)
        content = content.is_a?(Post) ? content.body : content
        app.post(content)
      end

      def get(howmany = 10)
        out = []
        doc = Nokogiri::HTML.parse(open("http://#{settings["username"]}.tumblr.com/api/read")).xpath('//post').collect{|x| out << to_post(x)}
        out
      end

      def app
        settings
      end
      
      protected
      def to_post(tumble, other = {})
        Post.new({:body => tumble["link-url"], 
                  :time => tumble["created_at"],
                  :url => tumble["url"]})
      end

    end
  end
end

