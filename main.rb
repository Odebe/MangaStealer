#require 'uri'
require 'nokogiri'
require 'faraday'
require 'open-uri'
require 'json'
require 'yaml'
#require 'fileutils'
require './parserManager.rb'
require './manga.rb'
require './chapter.rb'
require './downloader.rb'

class MangaStealer
  def initialize
    getConfig
    link = @config["manga"]
    uri = URI(link)
    pm = ParserManager.new uri
    Downloader.new pm.getManga
    #puts pm.getManga.info[:chapters].map {|x| x.info[:link]}
  end
  def getConfig
    if File.exists? "config.yml"
      @config = YAML.load_file("config.yml")
    else
      raise "Can't find config file!"
    end
  end
end
MangaStealer.new