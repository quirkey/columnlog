require 'rubygems'

def gem_dependency(gem_name)
  $missing_gems ||= []
  begin
    require gem_name
  rescue MissingSourceFile => e
    $missing_gems << gem_name
  end
end

def missing_gems?
  if $missing_gems && !$missing_gems.empty?
    puts "Sorry, your missing some gems to run columnlog:"
    $missing_gems.each do |gem_name|
      puts gem_name
    end
    puts "--- run ---"
    puts "sudo gem install #{$missing_gems.join(' ')}"
    exit
  end
end

gem_dependency 'activesupport'
gem_dependency 'yaml'
gem_dependency 'chronic'
gem_dependency 'static_model'
gem_dependency 'net/http'
gem_dependency 'open-uri'
gem_dependency 'twitter'
gem_dependency 'nokogiri'
gem_dependency 'xml'

missing_gems?