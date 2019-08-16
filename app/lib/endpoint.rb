class Endpoint
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  include ::Import['tools.find_parser_endpoint']

  def call(config_class)
    parser_endpoint_class = yield find_parser_endpoint.call(config_class.config.link)

    Success(parser_endpoint_class)
  end
end
