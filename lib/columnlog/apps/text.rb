module Columnlog
  class SimpleText < StaticModel::Base
  end
  
  module Apps
    class Text < Base

      # def post(content)
      #   content = content.is_a?(Post) ? content.body : content
      #   app.post(content)
      # end

      def get(how_many = nil)
        super
        out = app.collect {|i| to_post(i) }
        out.first(how_many)
      end

      def app
        data_root = File.join(Columnlog.root, 'data/')
        Columnlog::SimpleText.set_data_file data_root+settings.data_file
        Columnlog::SimpleText.all
      end
      
      protected
      def to_post(item, other = {})
        Post.new({:title =>item.title,
                  :body => item.body,
                  :posted_at => item.posted_at})
      end

    end
  end
end

