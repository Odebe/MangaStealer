
require 'dry/monads'
require 'dry/monads/do'
require 'dry/monads/list'

require 'uri'
require 'nokogiri'

require_relative './system/boot.rb'
require_relative './config.rb'


result = Endpoint.new.call(Config)
if result.success?
  Application::Container['logger'].info(result.value!.info)
else
  Application::Container['logger'].error(result.failure)
  Application::Container['logger'].error(result.trace)
end
