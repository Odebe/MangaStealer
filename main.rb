#require 'uri'
require 'nokogiri'
#require 'faraday'
require 'open-uri'
require 'json'
#require 'fileutils'
require './parserManager.rb'
require './manga.rb'
require './chapter.rb'
require './downloader.rb'

class MangaStealer
  def initialize
    link = "http://selfmanga.ru/videira"
    uri = URI(link)
    pm = ParserManager.new uri
    Downloader.new pm.getManga
    #puts pm.getManga.info[:chapters].map {|x| x.info[:link]}
  end
end
MangaStealer.new