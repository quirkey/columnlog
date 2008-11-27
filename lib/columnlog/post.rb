module Columnlog
  class Post
    attr_accessor :title, :body, :url, :author, :posted_at
    
    def initialize(params = {})
      @app   = params[:app]
      @title = params[:title]
      @body  = params[:body]
      @url   = params[:url]
      @author = params[:author]
      @posted_at = params[:posted_at] ? Chronic.parse(params[:posted_at]) : Time.now
    end
    
    
    def save
      app.post(self)
    end
    
    def app
      @app || raise("No app specified for post: #{self}")
    end
    
  end
end