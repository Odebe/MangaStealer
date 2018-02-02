class MangakakalotCom < ParserBase

	def initialize(link)
		super 
		#@link = link
    #@host = @link.host
    #page = getTitlePage(link)

    getMangaName do |page|
    	page.css('ul.manga-info-text li')[0].css('h1').text
    end

		puts "getChaptersList"
    getChaptersList do |page| 
    	page.css('div.chapter-list a')
    end

    puts "setChaptersList "
    setChaptersList do |link, chapter|
    	link_parts = link.split("/")
      chapter[:num] = link_parts.last.split('_').last
      chapter[:vol] = "vol"
      chapter[:link] = URI(link).path
      puts link
    end

		puts "get pages"
    getPages do |chapter|
    	chapter.css('div#vungdoc img').map{|p| p[:src]}
    end
    puts "done"

    return_manga
	end

		def self.getManga
		@manga
	end
end