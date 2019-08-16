module Parsers
  module  Mangakakalot
    class ParseManga
      include Dry::Monads::Do.for(:call)

      def initialize(link, params)
        @link = link
        @params = params
      end

      # TODO
      def call
        general_info = yield Parsers::Mangakakalot::FetchGeneralInfo.new(@link).call
        chapters_links = yield Parsers::Mangakakalot::FetchChaptersList.new(@link).call
        chapters = yield Parsers::Mangakakalot::FetchChapters.new(chapters_links).call
        manga = yield Parsers::Mangakakalot::ComposeManga.new(general_info, chapters).call
      end
    end
  end
end

