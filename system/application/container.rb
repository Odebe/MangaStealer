require 'dry/system/container'

module Application
  class Container < Dry::System::Container
    configure do |config|
      config.root = Pathname('./app')
      config.auto_register = 'lib'
    end

    load_paths! 'lib'
  end
end


Import = Application::Container.injector

