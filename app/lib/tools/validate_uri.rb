
module Tools
  class ValidateUri
    include Dry::Monads[:result]

    def call(link)
      link =~ URI::DEFAULT_PARSER.regexp[:ABS_URI] ? Success(true) : Failure('invalid_link')
    end
  end
end
