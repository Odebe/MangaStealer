module Downloader
  module Entities
    class Session
      def initialize(config, manga_name)
        @config = config
        @manga_name = manga_name
      end

      def root
        @_root ||= File.join(@config.download_to.realpath, Dry::Inflector.new.underscore(@manga_name))
      end
    end
  end
end
