module Parsers
  class Manager
    extend Dry::Configurable

    setting :list, %w[readmanga mangachan mangakakalot]

    setting :readmanga do
      setting :sites, %w[readmanga.me mintmanga.com selfmanga.ru]
      setting :endpoint, ->{ Parsers::ReadManga }
    end

    setting :mangachan do
      setting :sites, %w[mangachan.me hentai-chan.me yaoichan.me]
      setting :endpoint, ->{ Parsers::MangaChan }
    end

    setting :mangakakalot do
      setting :sites, %w[mangakakalot.com]
      setting :endpoint, ->{ Parsers::Mangakakalot }
    end
  end
end

