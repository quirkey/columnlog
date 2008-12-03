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
      @posted_at = params[:posted_at] ? (Chronic.parse(params[:posted_at]) || Time.parse(params[:posted_at]) || params[:posted_at]) : nil
      @column    = params[:column].blank? ? nil : Column[params[:column]]
      @body      = Columnlog::TextHelper.link_urls_in(@body)
      scan_for_shortcut
    end
    
    def save
      unless column.nil?
        column.post(self)
      else
        false
      end
    end
    
    def column
      @column #|| raise("No column/app specified for post: #{self}")
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