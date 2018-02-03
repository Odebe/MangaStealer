class MangachanMe  < ParserBase

	def initialize(link)
		super 

    getMangaName do |page|
    	page.css('a.title_top_a').text
    end

    getChaptersLinkList do |page|  
    	links = page.css('table.table_cha a')
    	if links.count == 0
				"/online/#{@link.path.split('/').last}"
    	else
    		links.reverse
    	end
    end

    setChaptersList do |link, chapter|
    	if /._v._ch./.match link
    		link_parts = link[/_v(.*?).html/].gsub('.html', '').split("_") 
        chapter[:num] = link_parts[2]
        chapter[:vol] = link_parts[1]
      else
      	chapter[:num] = ""
      	chapter[:vol] =""
      end
    end

    getPages do |chapter|
    	chapter.text.split('"fullimg":[')[1].split("]")[0].split(',').map! {|x| x.tr('"','')}
    end
	end

end