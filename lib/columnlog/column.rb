module Columnlog
  class Column < StaticModel::Base
   
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
    
  end
end