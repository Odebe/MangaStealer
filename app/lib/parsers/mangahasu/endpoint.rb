module Parsers
  module Mangahasu
    class Endpoint
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include ::Import['parsers.mangahasu.tools.parse_manga']

      def call(config)
        manga = yield parse_manga.call(config)

        return Failure('can_not_fetch_manga') if manga.nil?

        Success(manga)
      end
    end
  end
end
