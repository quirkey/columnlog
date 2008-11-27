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
      
    end
    
    def settings
      @settings ||= SuperHash.new(@attributes[:settings])
    end
    
    def app
      @app ||= Object.const_get("Columnlog::Apps::#{app_type}").new(settings)
    end
  end
end