class Downloader
  def initialize(manga)
    puts "I've got manga! #{manga}\n\n"
    #createDir("." + manga.info[:name])
    manga.info[:chapters].each do|chapter|
      #puts chapter.info[:link]
      if chapter.info[:archiveLink].nil?
        createDir(chapter.info[:link])
        chapter.info[:pages].each do |page|
          #puts File.basename(page)
          link = chapter.info[:link]
          base = File.basename(page)
          puts "#{link}/#{base}"
          File.write(".#{link}/#{base}", open(page).read, {mode: 'wb'})
        end
      else
        createDir(manga.info[:name])
        puts chapter.info[:link]
        puts chapter.info[:archiveLink]
        #open(chapter.info[:archiveLink]).read
        File.write(".#{manga.info[:name]}/#{chapter.info[:link]}", Net::HTTP.get_response(chapter.info[:archiveLink]).body , {mode: 'wb'})
      end
    end
  end
  def createDir(path)
    FileUtils::mkdir_p(".#{path}") unless Dir.exists? ".#{path}"
  end
end