module Parsers
  module Mangahasu
    module Tools
      class FetchGeneralInfo
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        def call(nokogiri_page)
          manga_name = yield get_manga_name(nokogiri_page)

          Success(name: manga_name)
        end

        private

        def get_manga_name(page)
          name = page.xpath('//div[@class="info-title"]/h1/text()').text
          Success(name)
        rescue => e
          Failure(e.message)
        end
      end
    end
  end
end
