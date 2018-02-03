class MangakakalotCom < ParserBase

	def initialize(link)
		super 

    getMangaName do |page|
    	page.css('ul.manga-info-text li')[0].css('h1').text
    end

    getChaptersLinkList do |page| 
    	page.css('div.chapter-list a').reverse
    end

    setChaptersList do |link, chapter|
      chapter[:num] = link.split("/").last.split('_').last
      chapter[:vol] = "vol"
      puts link
    end

    getPages do |chapter|
    	chapter.css('div#vungdoc img').map{|p| p[:src]}
    end
	end

		def self.getManga
		@manga
	end
end