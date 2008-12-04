module Columnlog
  module Apps
    class Tumblr < Base

      def post(content)
        content = content.is_a?(Post) ? content.body : content
        app.post(content)
      end

      def get(how_many = nil)
        super
        out = []
        doc = Nokogiri::XML.parse(open("http://#{settings["username"]}.tumblr.com/api/read")).xpath('//post').collect{|x| out << to_post(x)}
        out.first(how_many)
      end

      def app
        settings
      end
      
      protected
      def to_post(tumble, other = {})
        case tumble["type"]
        when "link"
          Post.new({:body => "<a href='#{tumble.children[1].content}'>#{tumble.children[0].content}</a>", 
                    :posted_at => tumble["date-gmt"].to_time.strftime("%m/%d/%Y at %I:%M%p"),
                    :url => tumble["url"]})
        end
      end

    end
  end
end

