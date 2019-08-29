module Parsers
  module  Mangakakalot
    module Tools
      class ComposeMangaEntity
        include Dry::Monads[:result]

        def call(info_hash)
          manga_entity = ::Entities::Manga.new(info: info_hash[:info], chapters: info_hash[:chapters])
          Success(manga_entity)
        end
      end
    end
  end
end
