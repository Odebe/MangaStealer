module Downloader
  module Tools
    class MakeFolder
      include Dry::Monads[:result]
  
      def call(path)
        result = FileUtils.mkdir_p(path)
        # TODO: read docs and fix
        result ? Success(result) : Failure(result)
      end
    end
  end
end
