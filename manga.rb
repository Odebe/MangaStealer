
class Manga
  attr_accessor :info
  def initialize(link)
    @info = {
      :chapters => [],
      :link => link
    }
  end
end