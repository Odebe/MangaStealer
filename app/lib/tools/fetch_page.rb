module Tools
  class FetchPage
    include Dry::Monads[:result]
    include ::Import['faraday']

    def call(link)
      page = faraday.get(link)
      Success(page.body)
    rescue => e
      Failure(e.message)
    end
  end
end
