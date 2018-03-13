#require 'uri'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'uri'

require_relative "parser_manager.rb"

class MangaStealer
  def initialize
    load_objects_files
    get_config
    link = @config["manga"]
    uri = URI(link)
    pm = ParserManager.new(uri)
    Downloader.new(pm.getManga)
  end
  def get_config
    config_path = File.dirname(__FILE__) + "/config.yml"
    if File.exists? config_path
      @config = YAML.load_file(config_path)
    else
      raise "Can't find config file!"
    end
  end
  def load_objects_files
    Dir[__dir__+"/objects/*.rb"].each{ |file| require file }
  end
end

MangaStealer.new