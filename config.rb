class Config
  extend Dry::Configurable

  setting :link, 'https://mangakakalot.com/manga/volcanic_age'
  setting :chapters, '1..2'
  setting :exclude, ''
end
