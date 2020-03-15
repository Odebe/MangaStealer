module Parsers
  class Manager
    extend Dry::Configurable

    setting :list, %w[readmanga mangachan mangakakalot mangahasu]

    setting :readmanga do
      setting :sites, %w[readmanga.me mintmanga.com selfmanga.ru]
      setting :endpoint, 'parsers.readmanga.endpoint'
    end

    setting :mangachan do
      setting :sites, %w[mangachan.me hentai-chan.me yaoichan.me]
      setting :endpoint, 'parsers.mangachan.endpoint'
    end

    setting :mangakakalot do
      setting :sites, %w[mangakakalot.com]
      setting :endpoint, 'parsers.mangakakalot.endpoint'
    end

    setting :mangahasu do
      setting :sites, %w[mangahasu.se]
      setting :endpoint, 'parsers.mangahasu.endpoint'
    end
  end
end
