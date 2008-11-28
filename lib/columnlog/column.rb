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
        shortcuts.each do |shortcut, id|
          return Column[id] if text_block.strip =~ /^#{Regexp.escape(shortcut)}/
        end; nil
      end
      
    end
    
    def settings
      @settings ||= SuperHash.new(@attributes[:settings])
    end
    
    def app
      @app ||= "Columnlog::Apps::#{app_type}".constantize.new(settings)
    end
  end
end