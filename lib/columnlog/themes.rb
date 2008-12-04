module Columnlog
  module Themes

    class << self

      def themes_dir
        File.join('themes')
      end

      def theme_dir(theme_name = nil)
        theme_name ||= self.theme
        File.join(themes_dir, theme_name)
      end

      def theme
        Columnlog::Column.theme
      end

      def default_theme
        Columnlog::Column.default_theme
      end

      def default_view_path
        File.join(theme_dir('default'), 'views')
      end
      
      def view_path(theme_name = nil)
        File.join(theme_dir(theme_name), 'views')
      end

      def public_path
        File.join(theme_dir, 'public')
      end

    end

    def theme
      Columnlog::Themes.theme
    end
    
    def default_view_path
      Columnlog::Themes.default_view_path
    end
    
    def default_theme
      Columnlog::Themes.default_theme
    end

    def erb_with_theme(filename, options = {})
      erb(filename, {:views_directory => view_directory_for_filename_in_theme(filename)}.merge(options))
    end

    def view_directory_for_filename_in_theme(filename)
      theme_specific = File.join(Columnlog::Themes.view_path, "#{filename}.erb")
      File.readable?(theme_specific) ? Columnlog::Themes.view_path : Columnlog::Themes.default_view_path
    end

  end
end