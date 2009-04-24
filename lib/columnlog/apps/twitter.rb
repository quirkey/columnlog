module Columnlog
  module Apps
    class Twitter < Base
      
      def post(content)
        content = content.is_a?(Post) ? content.body : content
        app.post(content, :source => 'columnlog')
      end

      def get(how_many = nil)
        super
        posts = []
        ::Twitter::Search.new.from(settings.username).each do |post|
          posts << to_post(post)
        end
        posts.first(how_many)
      end

      def app
        @app ||= ::Twitter::Base.new(::Twitter::HTTPAuth.new(settings.username,settings.password))
      end

      protected
      def to_post(tweet, other = {})
        Post.new({:body => make_at_linked(tweet.text), 
                  :author => tweet.from_user, 
                  :posted_at => tweet.created_at, 
                  :url => "http://twitter.com/#{tweet.from_user}/status/#{tweet.id}"}.merge(other))
      end
      
      def make_at_linked(text)
        text.gsub(/\@(\w+)/, '<a href="http://twitter.com/\1">@\1</a>')
      end
    end
  end
end


