#require 'uri'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'uri'

class MangaStealer
  def initialize
    load_objects_files
    load_config_files

    link = @config["manga"]
    uri = URI(link)
    pm = ParserManager.new(uri, @config["range"])
    Downloader.new(pm.manga)
  end
  def load_config_files
    config_path = File.dirname(__FILE__) + "/config/config.yml"
    if File.exists? config_path
      @config = YAML.load_file(config_path)
    else
      raise "Can't find config file!"
    end
    Dir[__dir__+"/config/*.rb"].each{ |file| require file }
  end
  def load_objects_files
    Dir[__dir__+"/objects/*.rb"].each{ |file| require file }
  end
end

MangaStealer.new