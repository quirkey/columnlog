module Columnlog
  module Apps
    class Twitter < Base
      
      def post(content)
        content = content.is_a?(Post) ? content.body : content
        app.post(content, :source => 'columnlog')
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
        unauthorized! unless @app.verify_credentials.to_html == "Authorized"
        @app
      rescue Twitter::CantConnect
        unauthorized!
      end

      protected
      def to_post(tweet, other = {})
        Post.new({:body => tweet["text"], 
                  :author => tweet["from_user"], 
                  :posted_at => tweet["created_at"].to_time.strftime("%m/%d/%Y at %I:%M%p"), 
                  :url => "http://twitter.com/#{tweet['from_user']}/status/#{tweet['id']}"}.merge(other))
      end
    end
  end
end


