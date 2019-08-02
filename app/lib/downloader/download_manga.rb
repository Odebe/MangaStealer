module Downloader
  class LoadManga
    def initialize(manga)
      @manga = manga
    end

    def call
      @manga.chapters.each do |chapter|
        result = Downloader::CreateChapterDirectory.new(chapter).call
        next unless result.success?

        directory = result.value!

        result = Downloader::LoadChapter.new(chapter).call
        next unless result.success?

        chapter = result.value!

        chapter.pages.each do |page|
          result = Downloader::LoadPage.new(page).call
          next unless result.success?

          page_file = result.value!
          result = Downloader::SavePageFile.new(page_file, directory).call
          if result.failure?
            # TODO
          end
        end
      end
    end
  end
end

