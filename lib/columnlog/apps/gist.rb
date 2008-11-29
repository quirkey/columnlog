module Columnlog
  module Apps
    class Gist < Base
      
      @@gist_url = 'http://gist.github.com/%s.txt'
      
      def post(content)
        content = content.is_a?(Post) ? content.body : content
        app.post(content)
      end

      def get(gist_id)
        unless gist_id.nil?
          #open(@@gist_url % gist_id).read
        end
      end

      def app
        settings
      end
      
      protected
      def to_post(tumble, other = {})
        #Post.new({:body => tumble["text"], 
        #          :author => tumble["from_user"], 
        #          :time => tweet["created_at"], 
        #          :url => "http://twitter.com/#{tweet['from_user']}/status/#{tweet['id']}"}.merge(other))
      end
      
    end
  end
end
    