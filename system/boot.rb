
require_relative './application/container.rb'
require_relative './boot/logger.rb'
require_relative './boot/faraday.rb'

Application::Container.start(:logger)
Application::Container.start(:faraday)

Application::Container.finalize!
