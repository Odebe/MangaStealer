module Parsers
  module Mangahasu
    module Entities
      class ImageTag < ::Entities::Page
        attr_reader :link

        def initialize(link)
          @link = link
        end
      end
    end
  end
end
