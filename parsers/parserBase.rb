class ParserBase
	attr_reader :manga

	def self.getManga
		@manga
	end

	def initialize(link)
		puts "I'am #{self.class}, hur-dur"
		@link = link
    @host = link.host
    @tittlePage = getTittlePage(link)
    #@name = getMangaNameFrom()
    @manga = Manga.new(@host)
	end

	def getTittlePage(link)
		Nokogiri::HTML(open(link) { |io| io.read })
	end

	def getMangaName
		@manga.info[:name] = yield(@tittlePage)
	end

	def getChaptersList
		@chapters_links = (yield @tittlePage).map{|c| c[:href]}
	end

	def setChaptersList
		@chapters_links.each do |link|
			chap = Chapter.new
			yield(link, chap.info)
			@manga.info[:chapters] << chap
		end
	end

	def getPages
		@manga.info[:chapters].each do |chapter|

			new_link = URI::HTTP.build(:host => @host, :path => chapter.info[:link])
    	page = Nokogiri::HTML(open(new_link) { |io| io.read })
			chapter.info[:pages] = yield(page)
			puts chapter.info[:link]
			#puts chapter.info[:pages]
		end

		def return_manga
			@manga
		end
	end

end