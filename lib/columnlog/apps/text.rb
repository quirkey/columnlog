module Columnlog
  module Apps
    class Text < Base

      # def post(content)
      #   content = content.is_a?(Post) ? content.body : content
      #   app.post(content)
      # end

      def get(how_many = 10)
        super
        out = []
        app.collect{|i| out << to_post(i)}
        out.first(how_many)
      end

      def app
        file = eval(settings.data_file)
        YAML.load_file(file).values
      end
      
      protected
      def to_post(item, other = {})
        Post.new({:title =>item["title"],
                  :body => item["body"]})
      end

    end
  end
end

