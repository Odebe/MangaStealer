class Mangakakalot < BaseParser
  def initialize(link, range)
    super 
    get_manga_name  do |page|
      page.css('ul.manga-info-text li')[0].css('h1').text
    end
    get_chapters_link_list do |page| 
      page.css('div.chapter-list a').reverse
    end
    set_chapters_list do |link, chapter|
      chapter[:num] = link.split("/").last.split('_').last
      chapter[:vol] = ""
    end
    get_pages do |chapter|
      chapter.css('div#vungdoc img').map{|p| p[:src]}
    end
  end
    def self.getManga
    @manga
  end
end