class Chapter
  attr_accessor :info
  def initialize
    @info = {
      :pages => [],
      :link => "",
      :num => "",
      :vol => "",
      :archiveLink => nil
    }
  end
end