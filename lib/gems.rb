require 'rubygems'

def gem_dependency(gem_name, lib_name = nil)
  $missing_gems ||= []
  lib_name ||= gem_name
  begin
    require lib_name
  rescue MissingSourceFile => e
    $missing_gems << gem_name
  end
end

def missing_gems?
  if $missing_gems && !$missing_gems.empty?
    $missing_gems.uniq!
    puts "Sorry, you're missing some gems to run columnlog:"
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
# gem_dependency 'atom-tools', 'atom/entry'
# gem_dependency 'atom-tools', 'atom/collection'
# gem_dependency 'atom-tools', 'atom/feed'
gem_dependency 'flickr', 'vendor/flickr/lib/flickr'

missing_gems?

