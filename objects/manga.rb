class Manga
  attr_accessor :info
  def initialize(host)
    @info = {
      :eng_name => "",
      :name => "",
      :anoth_names => "",
      :chapters => [],
      :link => "",
      :host => host
    }
  end
  def to_s
    print "name=#{@info[:name]} host=#{@info[:host]}, pages=#{@info[:chapters].count}\n"
    print "#{info[:chapters].map {|chap| chap.info[:link]}}"
  end
end