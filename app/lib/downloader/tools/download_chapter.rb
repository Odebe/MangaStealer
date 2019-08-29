module Downloader
  module Tools
    class DownloadChapter
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include ::Import[
        'downloader.tools.make_folder',
        'tools.fetch_page',
        'downloader.tools.download_page',
        'downloader.tools.save_file',
        'logger',
      ]
  
      def call(session, chapter)
        chapter_path = File.join(session.root, chapter.number.to_s)

        path = yield make_folder.call(chapter_path)
        
        chapter.pages.each do |page|
          result = download_page.call(session, page)

          logger.error(result.failure) unless result.success?
          next unless result.success?

          image = result.value!
          result = save_file.call(chapter_path, page, image)
          logger.error(result.failure) unless result.success?
        end

        Success(path)
      end

    end
  end
end
