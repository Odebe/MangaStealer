module Parsers
  module  Mangakakalot
    class FetchManga
      def initialize(link, params)
        @link = link
        @params = params
      end

      def call
        result = Parsers::Mangakakalot::FetchGeneralInfo.new(@link).call
        if result.success?
          # TODO
        else
          # TODO: return Failure
          return Failure()
        end

        result = Parsers::Mangakakalot::FetchChaptersList.new(@link, filter: chapters_filter)
        if result.success?
          chapters_links = result.value!
        else
          # TODO: return Failure
          return Failure()
        end

        full_chapters = chapters_links.each_with_object([]) do |c, acc|
          result = Parsers::Mangakakalot::FetchChapterPagesList.new(c[:link])).call
          acc << { chapter: c, pages: result.value! } if result.success?
        end

        Success(full_chapters)
      end

      def chapters_filter
        # TODO
      end

    end
  end
end