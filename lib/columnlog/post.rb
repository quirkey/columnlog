module Columnlog
  class Post
    attr_accessor :title, :body, :url, :author, :posted_at
    
    def initialize(params = {})
      @column = params[:column]
      @title = params[:title]
      @body  = params[:body]
      @url   = params[:url]
      @author = params[:author]
      @posted_at = params[:posted_at] ? Chronic.parse(params[:posted_at]) : Time.now
    end
    
    def save
      column.post(self)
    end
    
    def column
      @column || raise("No column/app specified for post: #{self}")
    end
    
  end
end