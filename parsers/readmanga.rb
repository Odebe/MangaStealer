
class ReadmangaMe 
  def initialize(link)
    puts "I'am ReadmangaMe, hur-dur"
    @link = link
    @host = @link.host
    page = getTitlePage(link)

    @manga = Manga.new(@host)
    @manga.info[:link] = link.path.split('/')[1]
    @manga.info[:name] = page.css('span.name').text
    @manga.info[:eng_name] = page.css('span.eng_name').text
    @manga.info[:anoth_names] = page.css('div.another-names').text

    getChaptersLIst(page).reverse.each do |cl|
      chap = Chapter.new
      cl_s = cl.split("/")
      chap.info[:num] = cl_s[2]
      chap.info[:vol] = cl_s[1].split('vol')
      chap.info[:link] = cl
      chap.info[:pages] = getPages(cl)
      @manga.info[:chapters] << chap
    end
    
    @manga
=begin
    #@manga.info[:chapters]
    chaptersLinks.reverse.each do |chapterPath|
      dir_path = "."+chapterPath
      #createDir(dir_path)
      FileUtils::mkdir_p(dir_path)
      puts chapterPath
      regex = /rm_h.init\( (.*), 0, false\);/
      puts new_link = URI::HTTP.build(:host => @host, :path => chapterPath, :query => "mtr=1")
      body = Faraday.get(new_link).body.tr("'", '"')
      match = regex.match body
      #puts match
      json_res = JSON.parse(match[1]).map {|item| item[1].to_s + item[0].to_s + item[2].to_s}
      #puts res = 
      json_res.each do |mPage|
        File.open('image.png', 'wb') { |fp| fp.write(response.body) }
      end
     end
=end
  end
  def getTitlePage(link)
    Nokogiri::HTML(open(link) { |io| io.read })
  end
  def getChaptersLIst(page)
    page.css('div.chapters-link').css('a').map {|x| x = x["href"]}
  end
  def getManga
    @manga
  end
  def getPages(chapterPath)
    regex = /rm_h.init\( (.*), 0, false\);/
    new_link = URI::HTTP.build(:host => @host, :path => chapterPath, :query => "mtr=1")
    #body = Faraday.get(new_link).body.tr("'", '"')
    body = open(new_link) { |io| io.read }.tr("'", '"')
    match = regex.match body
    json_res = JSON.parse(match[1]).map {|item| item[1].to_s + item[0].to_s + item[2].to_s}
  end
  def createDir(path)
    FileUtils::mkdir_p("."+path)
  end
end

