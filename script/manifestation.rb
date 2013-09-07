class Manifestation
  attr_accessor :text

  def initialize desired
    @text = manifestation of: desired[:phrase], from: desired[:genre]
  end

  private

  def concatenate_lists_in genre
    unless system("find ./lists/#{genre}/* -exec cat {} > #{genre}.list + 2>&1")
       puts "There is no lists/#{genre} directory in which to find lists."
       raise StandardError
    end
  end

  def manifestation desire
    concatenate_lists_in(desire[:from])

    world = Generator.from_file "#{desire[:from]}.list"

    text = world.manifest desire[:of]
    while text.length > 500
      text = world.manifest desire[:of]
    end

    text
  end
end

