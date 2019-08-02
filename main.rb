# require 'dotenv/load'

# require './system/application.rb'
require_relative './system/boot.rb'

# require 'nokogiri'

MangaStealer::Application.finalize!


MangaStealer::Application['logger'].info(123123)

puts ENV['LOAD_PATH']

Import = MangaStealer::Application.injector

puts Parsers::Config.config.list.inspect 
# MangaStealer::Application['manga_stealer.parser_manager']
#MangaStealer::ParserManager
# MangaStealer::Application['logger'].info(parsers_settings.list)

# include Import["logger"]
