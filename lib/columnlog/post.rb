module Columnlog
  class Post
    attr_accessor :title, :body, :url, :author, :posted_at
    
    def initialize(params = {})
      @title = params[:title]
      @body  = params[:body]
      @url   = params[:url]
      @author = params[:author]
      @posted_at = params[:posted_at] ? Chronic.parse(params[:posted_at]) : Time.now
    end
    
    
  end
end