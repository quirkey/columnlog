module Columnlog
  module Apps
    class LastFM < Rss
      
      protected
      def to_post(item, other = {})
        Post.new({:title => get_inner_element(item, 'title'),
                  :author => get_inner_element(item, 'author') || get_inner_element(item, 'dc:creator'),
                  :posted_at => get_inner_element(item, 'pubDate'),
                  :url => get_inner_element(item, 'link')
                  })
      end
      
    end
  end
end

