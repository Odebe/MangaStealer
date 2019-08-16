Application::Container.boot(:faraday) do
  init do
    require 'faraday'
  end

  start do
    register(:faraday, Faraday.new)
  end
end
