require 'dry/system/container'

module MangaStealer
  class Application < Dry::System::Container
    configure do |config|
      config.root = Pathname('./app')
      config.auto_register = 'lib'
    end

    load_paths! 'lib'
  end
end
