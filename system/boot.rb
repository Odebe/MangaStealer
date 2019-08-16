
require_relative './application/container.rb'
require_relative './boot/logger.rb'

Application::Container.start(:logger)

Application::Container.finalize!
