module Columnlog
  module Apps
    class Twitter < Base

      def post(content)
        content = content.is_a?(Post) ? content.body : content
        app.post(content)
      end

      def get(howmany = 10)
        posts = []
        ::Twitter::Search.new.from(settings.username).each do |post|
          posts << to_post(post)
        end
        posts
      end

      def app
        @app ||= ::Twitter::Base.new(settings.username,settings.password)
        unathorized! unless @app.verify_credentials.to_html == "Authorized"
        @app
      rescue Twitter::CantConnect
        unathorized!
      end

      protected
      def to_post(tweet)
        Post.new(:body => tweet.text, :author => tweet.user.screen_name, :time => tweet.created_at, :url => '')
      end
    end
  end
end


