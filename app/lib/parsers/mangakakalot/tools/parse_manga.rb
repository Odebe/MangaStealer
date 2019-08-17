module Parsers
  module  Mangakakalot
    module Tools
      class ParseManga
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        include ::Import[
                        'tools.fetch_page',
                        'tools.parse_page',
                        'parsers.mangakakalot.tools.fetch_general_info',
                        'parsers.mangakakalot.tools.fetch_chapters',
                        'parsers.mangakakalot.tools.compose_manga_entity',
                        ]

        def call(config)
          page = yield fetch_page.call(config.link)
          nokogiri_page = yield parse_page.call(page)
          info = yield fetch_general_info.call(nokogiri_page)
          chapters = yield fetch_chapters.call(nokogiri_page, config: config)
          manga = yield compose_manga_entity.call(info: info, chapters: chapters)
          
          Success(manga)
        end
      end
    end
  end
end
