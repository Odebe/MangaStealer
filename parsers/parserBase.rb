class ParserBase
	attr_reader :manga

	def initialize(link)
		puts "I'am #{self.class}, hur-dur"
		@link = link
    @host = link.host
    @tittlePage = getTittlePage(link)
    @manga = Manga.new(@host)
    @chapters_links = Array.new
	end

	def getTittlePage(link)
		Nokogiri::HTML(open(link) { |io| io.read })
	end

	def getMangaName
		@manga.info[:name] = yield(@tittlePage).tr(" ","_")
	end

	def getChaptersLinkList
		res = (yield @tittlePage)
		if res.kind_of? String
			@chapters_links << res
			checkForBlock(res)
		else
			@chapters_links = res.map{|c| c[:href]}
		end 
	end

	def setChaptersList
		@chapters_links.each do |link|
			chap = Chapter.new
			yield(link, chap.info)
			chap.info[:link] = URI(link).path
			@manga.info[:chapters] << chap
			puts link
		end
	end

	def getPages
		@manga.info[:chapters].each do |chapter|
			new_link = URI::HTTP.build(:host => @host, :path => chapter.info[:link])
    	page = Nokogiri::HTML(open(new_link) { |io| io.read })
			chapter.info[:pages] = yield(page)
			puts chapter.info[:link]
		end
	end
	def checkForBlock(path)
		new_link = URI::HTTP.build(host: @host, path: path)
		page = Nokogiri::HTML(open(new_link) { |io| io.read})
		if page.text.include? "Доступ ограничен"
			raise "Не на этот раз приятель!"
		end	
	end
end