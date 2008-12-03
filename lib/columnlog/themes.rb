module Columnlog
  module Themes

    def theme
      Columnlog::Column.theme
    end

    def default_theme
      Columnlog::Column.default_theme
    end

    def default_view_path
      Sinatra.application.options.views
    end

    def erb_with_theme(filename, options = {})
      erb(filename, {:views_directory => view_directory_for_filename_in_theme(filename)}.merge(options))
    end

    def view_directory_for_filename_in_theme(filename)
      theme_specific = File.join(default_view_path, theme, "#{filename}.erb")
      File.readable?(theme_specific) ? File.join(default_view_path, theme) : File.join(default_view_path, default_theme)
    end
    
  end
end