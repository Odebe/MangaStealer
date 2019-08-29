module Parsers
  module Mangakakalot
    module Entities
      class ImageTag < ::Entities::Page
        def initialize(nokogiri_obj)
          @nokogiri_obj = nokogiri_obj 
        end

        def link
          @nokogiri_obj[:src]
        end
      end
    end
  end
end
