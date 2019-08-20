module Parsers
  module Mangakakalot
    module Entities
      class ImageTag
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
