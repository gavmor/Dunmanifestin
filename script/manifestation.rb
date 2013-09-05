class Manifestation
  attr_accessor :text

  def initialize opts
    
    genre = opts[:genre]
    root_list = "#{genre}.list"
    concatenate_lists_in(genre, root_list)
    @text = manifestation of: opts[:phrase], from: root_list
  end

  private

  def concatenate_lists_in genre, destination_file
    path = "./lists/#{genre}"

    unless system("find #{path}/* -exec cat {} > #{destination_file} + 2>&1")
       puts "There is no lists/#{genre} directory in which to find lists."
    end
  end

  def manifestation zrm
    world = Generator.from_file zrm[:from]

    text = world.manifest zrm[:of]
    while text.length > 500
      text = world.manifest zrm[:of]
    end

    text
  end
end

