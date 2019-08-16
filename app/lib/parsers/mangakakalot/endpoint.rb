module Parsers
  module  Mangakakalot
    class Endpoint
      include Dry::Monads[:result]

      def call
        Success('I am ENDPOINT!!!')
      end
    end
  end
end
