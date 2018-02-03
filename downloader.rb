class Downloader
  def initialize(manga)
    puts "I've got manga! #{manga.info[:name]}\n\n"
    manga.info[:chapters].each do|chapter|
      puts chapter.info[:link]
      if chapter.info[:archiveLink].nil?
        path = "./downloads/#{manga.info[:name]}/#{chapter.info[:vol]}/#{chapter.info[:num]}"
        FileUtils.mkdir_p(path) 
        chapter.info[:pages].each do |page|
          sleep 0.1
          base = File.basename(page)
          file_path = "#{path}/#{base}"
          puts file_path
          File.write(file_path, open(page).read, {mode: 'wb'})
        end
      else
        createDir(manga.info[:name])
        puts chapter.info[:link]
        puts chapter.info[:archiveLink]
      end
    end
  end
  def createDir(path)
    FileUtils::mkdir_p(".#{path}") unless Dir.exists? ".#{path}"
  end

  def download_page(page, path)
      File.write(".#{link}/#{base}", open(page).read, {mode: 'wb'})
  end
end