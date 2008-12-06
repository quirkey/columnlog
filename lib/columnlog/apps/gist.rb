module Columnlog
  module Apps
    class Gist < Base
      include Columnlog::TextHelper
      @@gist_url = 'http://gist.github.com/%s.txt'
      
      def post(content)
      end

      def get(how_many = nil)
        super
        out = []
        doc = Nokogiri::HTML(open("http://gist.github.com/#{settings.username}"))
        doc.css('div.file').collect{|x|
          gist = x.css('div.info').css('a').inner_text.split(" ")[1]
          out << to_post(open(@@gist_url % gist).read)
        }
        out.first(how_many)
      end

      def app
        settings
      end
      
      protected
      def to_post(gist, other = {})
        Post.new({:body => textilize(escape(gist))}.merge(other))
      end
      
    end
  end
end
    