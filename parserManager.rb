
class ParserManager
  def initialize(uri)
    @parsersList = {
      "readmanga.me" => "readmanga.rb",
      "mintmanga.com" => "readmanga.rb",
      "selfmanga.ru" => "readmanga.rb"
    }
    synonyms = {
      "MintmangaCom" => "ReadmangaMe",
      "SelfmangaRu" => "ReadmangaMe",
    }
    addParser(uri.host)
    parserName = uri.host.split(".").map{|word| word.capitalize!}.join
    parserName = synonyms[parserName] if synonyms.has_key? parserName
    @parser = Object.const_get(parserName).new uri
  end
  def getManga
    @parser.getManga
  end
  def addParser(parser)
    if @parsersList.has_key? parser
      require "./parsers/#{@parsersList[parser]}"
    else
      raise "No such parser!"
    end
  end
  def setStandartParameters
  end
end