module Parsers
  module Mangakakalot
    module Entities
      class Chapter < ::Entities::Chapter
        attr_reader :pages, :link

        def initialize(link:, pages:)
          @link = link
          @pages = pages
        end

        def number
          @_number ||= @link.scan(/Chapter (.+)/).flatten.first.to_i
        end
      end
    end
  end
end
