module Parsers
  module Mangahasu
    module Entities
      class Chapter < ::Entities::Chapter
        attr_reader :pages, :link

        def initialize(link:, pages:)
          @link = link
          @pages = pages
        end

        def number
          # scan(/Chapter (.+)/).flatten.first.to_i
          @_number ||= @link.number
        end
      end
    end
  end
end
