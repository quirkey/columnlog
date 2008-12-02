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
          map[column.shortcut] = column.id if column.shortcut
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

      def theme
        self.class_attributes['theme'] || default_theme
      end

      def default_theme
        'default'
      end

    end

    delegate :post, :get, :to => :app

    def cache_key(with = "")
      cache_for = self.cache_for.blank? ? 5.minutes : self.cache_for
      "#{name}_#{with}/#{Time.now.to_i / cache_for.to_i}"
    end
    
    def get(howmany = 10)
      cache.fetch(cache_key(howmany)) do
        app.get(howmany)
      end
    end
    
    def updated_at
      get && get.first ? get.first.posted_at : nil
    end

    def cache
      @cache ||= ActiveSupport::Cache::MemoryStore.new#('tmp/columnlog')
    end

    def settings
      @settings ||= SuperHash.new(@attributes[:settings])
    end

    def app
      @app ||= "Columnlog::Apps::#{app_type}".constantize.new(settings)
    end
  end
end