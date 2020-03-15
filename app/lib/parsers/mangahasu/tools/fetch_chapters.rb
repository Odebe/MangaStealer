module Parsers
  module Mangahasu
    module Tools
      class FetchChapters
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        include ::Import[
                          'parsers.mangahasu.tools.fetch_chapters_links_list',
                          'parsers.mangahasu.tools.filter_chapters_links_list',
                          'parsers.mangahasu.tools.fetch_chapter'
                        ]

        def call(nokogiri_page, config:)
          chapters_links_list = yield fetch_chapters_links_list.call(nokogiri_page)
          filtered_links_list = yield filter_chapters_links_list.call(chapters_links_list, config: config)

          chapters = filtered_links_list.each_with_object([]) do |chapter_link, acc|
            result = fetch_chapter.call(chapter_link)
            acc << result.value! if result.success?
          end

          Success(chapters)
        end
      end
    end
  end
end
