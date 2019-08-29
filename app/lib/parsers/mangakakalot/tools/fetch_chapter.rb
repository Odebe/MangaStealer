module Parsers
  module  Mangakakalot
    module Tools
      class FetchChapter
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        include ::Import[
                          'tools.fetch_page',
                          'tools.parse_page',
                        ]

        def call(chapter_link)
          chapter_page = yield fetch_page.call(chapter_link.link)
          nokogiri_page = yield parse_page.call(chapter_page)
          pages = yield fetch_pages(nokogiri_page)
          chapter = yield compose_chapter(chapter_link.link, pages)

          Success(chapter)
        end

        private

        def compose_chapter(link, pages)
          chapter_entitry = Parsers::Mangakakalot::Entities::Chapter.new(link: link, pages: pages)
          Success(chapter_entitry)
        end

        def fetch_pages(nokogiri_page)
          images = nokogiri_page.css('div#vungdoc img')
          Success(images.map { |i| Parsers::Mangakakalot::Entities::ImageTag.new(i) })
        rescue => e
          Failure(e.message)
        end
      end
    end
  end
end
