class Config
  extend Dry::Configurable

  setting :link, 'https://mangakakalot.com/manga/manga_name'
  setting :chapters, '1..2'
  setting :exclude, ''
end
