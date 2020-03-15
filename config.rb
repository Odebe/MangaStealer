class Config
  extend Dry::Configurable

  setting :download_to, Pathname('./downloaded')
  setting :link, 'http://mangahasu.se/bokura-no-kiseki-v10-p1845.html'
  setting :from, '30'
  setting :til, '30'
  setting :exclude, ''
end
