module Downloader
  class Endpoint
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include ::Import[
      'downloader.tools.download_chapter',
      'downloader.tools.make_folder'
    ]

    def call(config, manga)
      session = yield create_session(config, manga.info[:name])
      _page_path = yield make_folder.call(session.root)

      manga.chapters.each do |chapter|
        download_chapter.call(session, chapter)
      end

      Success(session)
    end

    private

    def create_session(config, manga_name)
      session = Downloader::Entities::Session.new(config, manga_name)
      Success(session)
    end
  end
end
