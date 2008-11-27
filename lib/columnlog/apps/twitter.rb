module Columnlog
  module Apps
    class Twitter
      
      def post(contents)
        if self.authorized?
          @twit.post(contents)
        end
      end
      
      def get(howmany = 10)
        out = []
        if self.authorized?
          ::Twitter::Search.new.from(@user).each_with_index do |tweet, index|
            if index < howmany
              tmp = Columnlog::App::Twitters.date_format(tweet["created_at"])
              tweet["created_at"] = tmp
              out << tweet
            end
          end
        else
          out << "Authorization Failed"
        end
        out
      end
            
      def app
        @app ||= ::Twitter::Base.new(settings.username,settings.password)
        unless @app.verify_credentials.to_html == "Authorized"
          raise(Errors::UnauthorizedApp, "Could not log you in for twitter with username: #{settings.username}")
        end
        @app
      end
      
      def self.date_format(date_u)
        date = date_u.to_datetime
        "#{date.month}/#{date.day}/#{date.year} - #{date.hour}:#{date.min}:#{date.sec}"
      end
      
    end
  end
end


