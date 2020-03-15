module Parsers
  module Mangahasu
    module Entities
      class ChapterLink
        attr_reader :link, :name

        def initialize(name, link)
          @link = link
          @name = name
        end

        def number
          @_number ||= name.scan(/Chapter (\d+\W*\d*):*/).flatten.first.to_f
        end
      end
    end
  end
end
