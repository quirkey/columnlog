module Columnlog
  module Apps
    class Gist < Base
      
      @@gist_url = 'http://gist.github.com/%s.txt'
      
      def post(content)
        content = content.is_a?(Post) ? content.body : content
        app.post(content)
      end

      def get(howmany=10)
        doc = Nokogiri::HTML.parse(open("http://gist.github.com/mrb"))
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
    