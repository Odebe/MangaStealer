module Downloader
  module Tools
    class SaveFile
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include ::Import['logger']
  
      def call(chapter_path, page, image_file)
        filename = yield find_file_name(page.link)

        result = yield save_file(File.join(chapter_path, filename), image_file)

        Success(result)
      end

      private

      def save_file(path, image_file)
        logger.info("saving file: #{path}")
        File.open(path, 'w') { |f| f.write(image_file)  }
        Success(true)
      rescue => e
        Failure(e)
      end

      def find_file_name(page_link)
        uri = URI.parse(page_link)
        name = File.basename(uri.path)
        Success(name)
      rescue => e
        Failure(e)
      end
    end
  end
end
