module Parsers
  module Mangakakalot
    module Entities
      class ChapterLink
        def initialize(link)
          @link = link 
        end

        def link
          @link[:href]
        end


        def number
          @_number ||= @link.text.scan(/Chapter (.+)/).flatten.first.to_i
        end
      end
    end
  end
end
