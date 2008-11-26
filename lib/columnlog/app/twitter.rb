module Columnlog
  module App
    class Twitters
      
      require 'net/http'
      require 'uri'
      require 'twitter'
      
      def post(contents)
        if self.authorized?
          @twit.post(contents)
        end
      end
      
      def get(howmany = 10)
        out = []
        if self.authorized?
          Twitter::Search.new.from(@user).each_with_index do |tweet, index|
            if index < howmany
              out << tweet
            end
          end
        else
          out << "Authorization Failed"
        end
        out
      end
      
      def authorized?
        user = Columnlog::Credentials.get(:twitter).username
        pass = Columnlog::Credentials.get(:twitter).password
        if user && pass
          if Twitter::Base.new(user,pass).verify_credentials.to_html == "Authorized"
            auth ||= true
            self.credential_load(user,pass)
          else
            auth ||= false
          end
        else
          auth ||= false
        end
        auth
      end
      
      def credential_load(user,pass)
        @twit ||= Twitter::Base.new(user,pass)
        @user ||= user
      end
      
    end
  end
end


