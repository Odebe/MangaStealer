require 'uri'
require 'nokogiri'
require 'faraday'
require 'json'
#require 'fileutils'
require './parserManager.rb'
require './manga.rb'
require './chapter.rb'
require './downloader.rb'

class MangaStealer
  def initialize
    link = "http://readmanga.me/sherdoodles"
    uri = URI(link)
    #pm =
    Downloader.new (ParserManager.new uri).getManga
    #puts pm.getManga.info[:chapters].map {|x| x.info[:link]}

  end
end
MangaStealer.new