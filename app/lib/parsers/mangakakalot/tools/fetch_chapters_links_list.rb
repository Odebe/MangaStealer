module Parsers
  module  Mangakakalot
    module Tools
      class FetchChaptersLinksList
        include Dry::Monads[:result]

        def call(nokogiri_page)
          list = nokogiri_page.css('div.chapter-list a').reverse
          link_entitites = list.map { |link| Parsers::Mangakakalot::Entities::ChapterLink.new(link) } 
          Success(link_entitites)
        rescue => e
          Failure(e.message)
        end
      end
    end
  end
end
