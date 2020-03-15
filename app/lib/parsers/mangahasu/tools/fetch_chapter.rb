module Parsers
  module Mangahasu
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
          chapter = yield compose_chapter(chapter_link, pages)

          Success(chapter)
        end

        private

        def compose_chapter(link, pages)
          chapter_entitry = Parsers::Mangahasu::Entities::Chapter.new(link: link, pages: pages)
          Success(chapter_entitry)
        end

        def fetch_pages(nokogiri_page)
          images = nokogiri_page.xpath('//div[@class="img-chapter"]//img[starts-with(@class, "page")]/@src')
          Success(images.map { |img| Parsers::Mangahasu::Entities::ImageTag.new(img.value) })
        rescue => e
          Failure(e.message)
        end
      end
    end
  end
end
