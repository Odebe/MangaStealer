require 'uri'

module Tools
  class FindParserEndpoint
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include ::Import['parsers.manager']

    def call(link)
      hostname = yield get_hostname(link)
      parser_name = yield find_parser_name(hostname)
      parser_endpoint_proc = yield find_endpoint_proc(parser_name)
      parser_endpoint_class = yield find_endpoint_class(parser_endpoint_proc)

      return Failure('can_not_find_endpoint') if parser_endpoint_class.nil?

      Success(parser_endpoint_class)
    end

    private

    def get_hostname(link)
      uri = URI.parse(link)
      hostname = uri.host
      Failure('can_not_get_hostname') if hostname.nil?

      Success(hostname)
    end

    def find_endpoint_class(endpoint_proc)
      endpoint_class = endpoint_proc.call
      Failure('endpoint_class_not_defined') if endpoint_class.nil?

      Success(endpoint_class)
    end

    def find_endpoint_proc(parser_name)
      return Failure('endpoint_proc_not_defined') unless config_class.respond_to?(parser_name)

      Success(config_class.send(parser_name).endpoint)
    end

    def find_parser_name(hostname)
      parser_name = config_class.list.find do |parser|
        next unless config_class.respond_to?(parser)

        config_class.send(parser).sites.include?(hostname)
      end
      return Failure('parser_not_defined') if parser_name.nil?

      Success(parser_name)
    end

    def config_class
      @_config_class ||= manager.class.config
    end
  end
end
