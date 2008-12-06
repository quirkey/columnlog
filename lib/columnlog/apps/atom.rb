module Columnlog
  module Apps
    class Atom < Base

      # def post(content)
      #   content = content.is_a?(Post) ? content.body : content
      #   app.post(content)
      # end

      def get(how_many = nil)
        super
        out = []
        doc = app.xpath('/feed/entry').collect {|i| out << to_post(i) }
        out.first(how_many)
      end

      def app
        @app ||= Nokogiri::XML.parse(open(settings.url))
      end
      
      protected
      def to_post(item, other = {})
        Post.new({:title => get_inner_element(item, 'title'),
                  :body => get_inner_element(item, 'content'), 
                  :author => get_inner_element(item, 'author/name'),
                  :posted_at => get_inner_element(item, 'published'),
                  :url => get_inner_element(item, 'link')['href']
                  })
      end
      
      def get_inner_element(item, element)
        inner = item.at(element)
        inner ? inner.inner_text : nil
      end

    end
  end
end

