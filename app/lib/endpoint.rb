class Endpoint
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  include ::Import['tools.find_parser_endpoint']

  def call(config_class)
    endpoint = yield find_parser_endpoint.call(config_class.config.link)
    
    Success(endpoint)
  end
end
