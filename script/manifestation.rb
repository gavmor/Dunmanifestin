class Manifestation
  attr_accessor :opts

  def initialize opts
    genre = opts[:genre]
    
    root_list = "#{genre}.list"

    concatenate_lists_in(genre, root_list)

    avatar = manifestation of: opts[:phrase], from: root_list
    puts avatar
  end

  private

  def concatenate_lists_in genre, destination_file
    path = "./lists/#{genre}"

    unless system("find #{path}/* -exec cat {} > #{destination_file} + 2>&1")
       puts "There is no lists/#{genre} directory in which to find lists."
    end
  end

  def manifestation zrm
    gen = Generator.from_file zrm[:from]

    text = gen.manifest zrm[:of]
    while text.length > 500
      text = gen.manifest zrm[:of]
    end

    text
  end
end

