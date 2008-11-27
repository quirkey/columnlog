module Columnlog
  module Apps
    class Tumblrs
      
      require 'net/http'
      require 'uri'
      require 'tumblr'
      
      def post(params)
      end
      
      def get(howmany = 10)
        out = []
        Tumblr::API.read("#{@user}.tumblr.com") do |pager|
          data = pager.page(0)
          p data.tumblelog
          data.posts.each do |post|
            out << post
          end
        end
        out
      end
      
      def authorized?
        user = Columnlog::Credentials.get(:tumblr).username
        pass = Columnlog::Credentials.get(:tumblr).password
        
        if user && pass
          Tumblrs.credential_load(user,pass)
        end
      end
      
      def self.credential_load(user,pass)
        @user ||= user
      end
      
    end
  end
end