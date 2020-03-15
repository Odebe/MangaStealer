
require 'dry/monads'
require 'dry/monads/do'
require 'dry/monads/list'
require 'dry-configurable'
require "dry/inflector"

require 'uri'
require 'nokogiri'
require 'fileutils'
require 'faraday'
require 'json'

require_relative './system/boot.rb'
require_relative './config.rb'

begin
  result = Endpoint.new.call(Config)
  if result.success?
    Application::Container['logger'].info(result.value!.inspect)
  else
    Application::Container['logger'].error(result.failure)
    Application::Container['logger'].error(result.trace)
  end
rescue => e
  file_name = "./logs/error_#{Time.now.strftime('%Y-%jT%RZ')}.log"
  puts "О нет, кажись случилась ошибка, отправляйте логи из #{file_name} автору"

  FileUtils.mkdir('./logs/') unless Dir.exist?('./logs/')
  File.open(file_name, 'w') do |f|
    message = {
      message: e.message,
      backtrace: e.backtrace.join("\n"),
      config:  Config.config.to_h,
    }

    f.write(message.to_json)
  end
end
