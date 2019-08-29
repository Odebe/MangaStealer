module Downloader
  module Tools
    class DownloadPage
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include ::Import['tools.fetch_page', 'logger']
  
      def call(session, page)
        logger.info("downloading page: #{page.link}")
        image = yield fetch_page.call(page.link)

        Success(image)
      end
    end
  end
end
