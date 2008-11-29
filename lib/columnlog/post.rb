module Columnlog
  class Post
    attr_accessor :column, :title, :body, :url, :author, :posted_at
    
    def initialize(params = {})
      return unless params
      params     = params.superize
      @title     = nil_if_blank? params[:title]
      @body      = nil_if_blank? params[:body]
      @url       = nil_if_blank? params[:url]
      @author    = nil_if_blank? params[:author]
      @posted_at = params[:posted_at] ? Chronic.parse(params[:posted_at]) : Time.now.strftime("Printed on %m/%d/%Y at %I:%M%p")
      @column    = params[:column].blank? ? nil : Column[params[:column]]
      scan_for_shortcut
    end
    
    def save
      column.post(self)
    end
    
    def column
      @column || raise("No column/app specified for post: #{self}")
    end
    
    protected
    def nil_if_blank?(test)
      test.blank? ? nil : test
    end
    
    def scan_for_shortcut
      return if @column || !@body
      if result = Column.shortcut_scan(body)
        @column, @body = result
      end
    end
  end
end