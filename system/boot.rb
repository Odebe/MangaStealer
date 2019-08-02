
require_relative './application/container.rb'
require_relative './boot/logger.rb'

MangaStealer::Application.start(:logger)

MangaStealer::Application.finalize!

