module Parsers
  module  Mangakakalot
    module Tools
      class FilterChaptersLinksList
        include Dry::Monads[:result]

        def call(chapters_links_list, config:)
          filtered_list = chapters_links_list.select { |c| c.number >= config.from.to_i && c.number <= config.til.to_i }
          Success(filtered_list)
        end
      end
    end
  end
end
