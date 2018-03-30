class BaseParser
  attr_reader :manga

  def initialize(link, range)
    puts "I'am #{self.class}, hur-dur"
    @range = range
    @link = link
    @host = link.host
    @tittlePage = get_tittle_page(link)
    @manga = Manga.new(@host)
    @chapters_links = Array.new
  end
  def get_tittle_page(link)
    Nokogiri::HTML(open(link) { |io| io.read })
  end
  def get_manga_name
    @manga.info[:name] = yield(@tittlePage).tr(" ","_")
  end
  def get_chapters_link_list
    res = (yield @tittlePage)
    if res.kind_of? String
      @chapters_links << res
      check_for_block(res)
    else
      @chapters_links = res.map{|c| c[:href]}
    end 
  end
  def set_chapters_list
    @chapters_links.each do |link|
      chap = Chapter.new
      yield(link, chap.info)
      chap.info[:link] = URI(link).path
      @manga.info[:chapters] << chap
      puts link
    end
  end
  def get_pages
    @manga.info[:chapters].each do |chapter|
      num = chapter.info[:num].to_i
      next if num < @range["from"].to_i || num > @range["to"].to_i
      new_link = URI::HTTP.build(:host => @host, :path => chapter.info[:link])
      page = Nokogiri::HTML(open(new_link) { |io| io.read })
      chapter.info[:pages] = yield(page)
      puts chapter.info[:link]
    end
  end
  def check_for_block(path)
    new_link = URI::HTTP.build(host: @host, path: path)
    page = Nokogiri::HTML(open(new_link) { |io| io.read})
    if page.text.include? "Доступ ограничен"
      raise "Не на этот раз приятель!"
    end 
  end
  private def is_chapter_in_range
    
  end
end