
class MangachanMe 
  def initialize(link)
    puts "I'am MangachanMe, hur-dur"
    @link = link
    @host = @link.host
    page = getTitlePage(link)
    @manga = Manga.new(@host)
    @manga.info[:link] = link.path
    puts @manga.info[:name] = page.css('a.title_top_a').text.tr(' ', '').tr('\'', '')
    @chapters = getChaptersList(page)
    @chapters.reverse.each do |cl|
      puts cl
      sleep 0.3
      chap = Chapter.new
      if /._v._ch./.match cl
        clParsed = cl[/_v(.*?).html/].tr('.html', '').split("_")
        chap.info[:link] = "/#{@manga.info[:name]}/#{clParsed[1]}/#{clParsed[2]}"
      else
        clParsed = cl.split('/').last.tr('.html', '')
        chap.info[:link] = "/#{@manga.info[:name]}"
      end
      chap.info[:pages] = getPages(cl)
      @manga.info[:chapters] << chap
    end   
    @manga
  end
  def getTitlePage(link)
    Nokogiri::HTML(open(link) { |io| io.read })
  end
  def getChaptersList(page)
    chapters = page.css('div.manga')
    puts "Chapters: #{chapters.count}"
    if chapters.count.equal? 0
      chapters = Array.new
      chapters << "/online/#{@link.path.split('/').last}"
    else
      chapters.css('a').map {|x| x["href"]}
    end
  end
  def getManga
    @manga
  end
  def getPages(chapterPath)
    new_link = URI::HTTP.build(:host => @host, :path => chapterPath)
    body = Nokogiri::HTML(open(new_link) { |io| io.read })
    if body.text.include? "Доступ ограничен. Только зарегистрированные пользователи подтвердившие, что им 18 лет."
      raise "Доступ ограничен. Не на этот раз, Приятель."
    else
    pages =  body.text.split('"fullimg":[')[1].split("]")[0].split(',').map! {|x| x.tr('"','')}
    end
  end
end

