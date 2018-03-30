class MangagoMe  < BaseParser
  def initialize(link)
    super 
    get_manga_name do |page|
      page.css('div.w-title h1').text.strip
    end
    get_chapters_link_list do |page|  
      page.css('table#chapter_table a').reverse
    end
    set_chapters_list do |link, chapter|
      if /._v._ch./.match link
        link_parts = link[/_v(.*?).html/].gsub('.html', '').split("_") 
        chapter[:num] = link_parts[2]
        chapter[:vol] = link_parts[1]
      else
        chapter[:num] = ""
        chapter[:vol] = ""
      end
    end
    get_pages do |chapter|
      chapter.text.split('"fullimg":[')[1].split("]")[0].split(',').map! {|x| x.tr('"','')}
    end
  end
end