module Columnlog
  module Apps
    class Gist < Base
      
      @@gist_url = 'http://gist.github.com/%s.txt'
      
      def post(content)
      end

      def get(how_many = nil)
        super
        doc = Nokogiri::HTML(open("http://gist.github.com/mrb"))
        doc.css('div.file').collect{|x| to_post(x.to_html) }
      end

      def app
        settings
      end
      
      protected
      def to_post(gist, other = {})
        Post.new({:body => gist}.merge(other))
      end
      
    end
  end
end
    