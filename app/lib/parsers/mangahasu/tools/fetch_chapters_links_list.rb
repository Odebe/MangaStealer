module Parsers
  module Mangahasu
    module Tools
      class FetchChaptersLinksList
        include Dry::Monads[:result]

        def call(nokogiri_page)
          list = nokogiri_page.xpath('//div[@class="list-chapter"]//td[@class="name"]/a').reverse
          link_entitites = list.map do |link|
            Parsers::Mangahasu::Entities::ChapterLink.new(link.text, link[:href])
          end
          Success(link_entitites)
        rescue => e
          Failure(e.message)
        end
      end
    end
  end
end
