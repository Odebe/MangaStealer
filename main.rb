
require 'dry/monads'
require 'dry/monads/do'
require 'dry/monads/list'

require "dry/inflector"

require 'uri'
require 'nokogiri'
require 'fileutils'

require_relative './system/boot.rb'
require_relative './config.rb'


result = Endpoint.new.call(Config)
if result.success?
  Application::Container['logger'].info(result.value!.inspect)
else
  Application::Container['logger'].error(result.failure)
  Application::Container['logger'].error(result.trace)
end
