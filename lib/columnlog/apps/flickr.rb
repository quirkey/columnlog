module Columnlog
  module Apps
    class Flickr < Base
      
      # def post(content)
      #   content = content.is_a?(Post) ? content.body : content
      #   app.post(content, :source => 'columnlog')
      # end

      def get(how_many = nil)
        super
        posts = app.photos('per_page' => how_many, 'extras' => 'date_taken').collect {|p| to_post(p) }
        posts.first(how_many)
      end

      def app
        @app ||= ::Flickr.new(settings.api_key).users(settings.username)
      end

      protected
      def to_post(photo, other = {})
        Post.new({:body => "<a href=\"#{photo.url}\"><img src=\"#{photo.source(settings[:size] || 'Small')}\" alt=\"#{photo.title}\" /></a>", 
                  :posted_at => photo['datetaken'], 
                  :url => "#{photo.url}"}.merge(other))
      end
    end
  end
end


