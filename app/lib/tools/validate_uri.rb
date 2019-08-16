
module Tools
  class ValidateUri
    include Dry::Monads[:result]
    include ::Import['faraday']

    def call(link)
      page = faraday.get(link)
      Success(page)
    rescue => e
      Failure(e.message)
    end
  end
end
