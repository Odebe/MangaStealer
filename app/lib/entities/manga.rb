module Entities
  class Manga
    attr_reader :info, :chapters
    
    def initialize(info:, chapters:)
      @info = info
      @chapters = chapters
    end
  end
end
