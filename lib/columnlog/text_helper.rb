module Columnlog
  module TextHelper

    IMG_EXT_REGEX = /\.(jpg|gif|png)/

    LINK_REGEX = %r{
      (                          # leading text
      <\w+.*?>|                # leading HTML tag, or
      [^=!:'"/]|               # leading punctuation, or
      ^                        # beginning of line
      )
      (
      (?:https?://)|           # protocol spec, or
      (?:www\.)                # www.*
      )
      (
      [-\w]+                   # subdomain or domain
      (?:\.[-\w]+)*            # remaining subdomains or domain
      (?::\d+)?                # port
      (?:/(?:(?:[~\w\+@%=\(\)-]|(?:[,.;:][^\s$]))+)?)* # path
      (?:\?[\w\+@%&=.;-]+)?     # query string
      (?:\#[\w\-]*)?           # trailing anchor
      )
      ([[:punct:]]|<|$|)       # trailing text
      }x

    class << self
      def link_urls_in(body)
        return nil unless body
        body.gsub(LINK_REGEX) do
          all, leading, protocol, uri, trailing = $&, $1, $2, $3, $4
          if leading =~ /<a\s/i # don't replace URL's that are already linked
            all
          else
            if uri =~ IMG_EXT_REGEX
              image_tag(protocol + uri)
            else
              link(protocol + uri)
            end
          end
        end
      end
      
      def image_tag(img_url)
        %{ <a href="#{img_url}" target="_blank"><img src="#{img_url}" alt="User Posted Image" width="480" /></a>}
      end
      
      def link(url)
        %{ <a href="#{url}" target="_blank">#{url}</a>}
      end
      
    end
    
    def truncate_words(text, length = 30, truncate_string = "..." )
      return '' if text.nil?
      words = text.split
      words.length > length ? words[0...length].join(" ") + truncate_string : text
    end

    def truncate(text, length = 30, truncate_string = '...')
      return '' if text.blank?
      text.length > length ? text[0..length] + truncate_string : text
    end

    def link_to(text, link = nil)
      link ||= text
      "<a href=\"#{link}\">#{text}</a>"
    end
  end
end