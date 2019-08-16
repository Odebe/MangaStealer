module Tools
  class ParsePage
    include Dry::Monads[:result]
    # include ::Import['faraday']

    def call(page)
      page = Nokogiri::HTML.parse(page)
      Success(page)
    rescue => e
      Failure(e.message)
    end
  end
end
