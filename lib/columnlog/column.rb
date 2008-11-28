module Columnlog
  class Column < StaticModel::Base
   set_data_file File.join(Columnlog.root, 'config', 'columns.yml')
   
    class << self
      
      def [](name_or_id)
        case name_or_id
        when String
          self.find_by_name(name_or_id)
        else
          self.find(name_or_id.to_i)
        end
      end
      
      def shortcuts
        map = {}
        Column.all.each do |column|
          map[column.shortcut] = column.id
        end
        map
      end
      
      def shortcut_scan(text_block)
        return if text_block.nil?
        text_block = text_block.strip
        shortcuts.each do |shortcut, id|
          exp = /^#{Regexp.escape(shortcut)}\ /
          return [Column[id], text_block.gsub(exp, '')] if text_block =~ exp
        end; nil
      end
      
    end
    
    delegate :post, :get, :to => :app
    
    def settings
      @settings ||= SuperHash.new(@attributes[:settings])
    end
    
    def app
      @app ||= "Columnlog::Apps::#{app_type}".constantize.new(settings)
    end
  end
end