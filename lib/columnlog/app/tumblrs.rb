module Columnlog
  module App
    class Tumblrs
      
      require 'xml'
      
      def post(params)
      end
      
      def get(howmany = 10)
        out = []
        if self.authorized?
          url = "http://mrb.tumblr.com/api/read"
          parser = XML::Parser.new
          parser.file = url
          parsed = parser.parse
          parsed.find('posts').collect{|x| x.find('post').collect{|x| out << x}}
        end
        out
      end
      
      def authorized?
        user = Columnlog::Credentials.get(:tumblr).username
        pass = Columnlog::Credentials.get(:tumblr).password
        
        if !user.nil? && !pass.nil?
          self.credential_load(user,pass)
        end
      end
      
      def credential_load(user,pass)
        @user ||= user
      end
      
    end
  end
end