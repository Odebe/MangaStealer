class Downloader
  def initialize(manga)
    puts "I've got manga! #{manga}"
    manga.info[:chapters].each do|chapter|
      createDir(chapter.info[:link])
      puts chapter.info[:link]
      chapter.info[:pages].each do |page|
        #puts File.basename(page)
        File.write(".#{chapter.info[:link]}/#{File.basename(page)}", open(page).read, {mode: 'wb'})
      end
    end
  end
  def createDir(path)
    FileUtils::mkdir_p(".#{path}") unless Dir.exists? ".#{path}"
  end
end