class Endpoint
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  include ::Import['tools.find_parser_endpoint', 'downloader.endpoint']

  def call(config_class)
    parser_endpoint = yield find_parser_endpoint.call(config_class.config.link)
    manga = yield parser_endpoint.call(config_class.config)
    _path = yield endpoint.call(config_class.config, manga)
    
    Success(manga)
  end
end
