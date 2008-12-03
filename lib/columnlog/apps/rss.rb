module Columnlog
  module Apps
    class Rss < Base

      # def post(content)
      #   content = content.is_a?(Post) ? content.body : content
      #   app.post(content)
      # end

      def get(howmany = 10)
        out = []
        doc = app.xpath('/rss/channel/item').collect {|i| out << to_post(i) }
        out.first(howmany)
      end

      def app
        Nokogiri::XML.parse(open(settings.url))
      end
      
      protected
      def to_post(item, other = {})
        Post.new({:title => get_inner_element(item, 'title'),
                  :body => get_inner_element(item, 'description'), 
                  :author => get_inner_element(item, 'author') || get_inner_element(item, 'dc:creator'),
                  :posted_at => get_inner_element(item, 'pubDate'),
                  :url => get_inner_element(item, 'link')
                  })
      end
      
      def get_inner_element(item, element)
        inner = item.at(element)
        inner ? inner.inner_text : nil
      end

    end
  end
end

