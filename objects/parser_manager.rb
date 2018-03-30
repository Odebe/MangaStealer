class ParserManager
  @@managers_count = 0
  @@parsers_list = {}
  @@synonyms_list = {}

  def self.config(&block)
    self.instance_eval(&block)
  end
  def self.set_parser(*arg)
    #file: :readmanga, for_sites: ["readmanga.me", "mintmanga.com", "selfmanga.ru"]
    filename = "#{arg.first[:file]}.rb" 
    arg.first[:for_sites].each do |sitename|
      self.add_to_parser_list(filename, sitename)
      self.add_to_synnonyms_list(filename, sitename)
    end
  end
  def self.add_to_parser_list(filename, sitename)
    @@parsers_list[sitename] = filename
  end
  def self.add_to_synnonyms_list(filename, sitename)
    parser_class_name = get_parser_class_name(sitename)
    parser_class_syn = filename.split(".").first.capitalize
    return nil if parser_class_name == parser_class_syn
    @@synonyms_list[parser_class_name] = parser_class_syn
  end
  def self.get_parser_class_name(sitename)
    sitename.tr('-','').split(".").first.capitalize #.join
  end
  def initialize(uri, range)
    raise "no more managers" if @@managers_count != 0
    @@managers_count += 1

    require_parser(uri.host)
    parser_name = ParserManager.get_parser_class_name(uri.host)
    parser_name = @@synonyms_list[parser_name] if @@synonyms_list.has_key? parser_name
    @parser = Object.const_get(parser_name).new(uri, range)
  end
  def manga
    @parser.manga
  end
  def require_parser(hostname)
    if @@parsers_list.has_key? hostname
      require_relative "../parsers/#{@@parsers_list[hostname]}"
    else
      raise "#{hostname}! No such parser!"
    end
  end
end
