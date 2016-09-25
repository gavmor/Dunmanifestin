require_relative '../lib/dunmanifestin/list_loader'
require 'tmpdir'

describe ListLoader do
  let(:palette_doc) do
<<-TXT
|root
cat
frog
chicken
TXT
  end
  
  let(:palette_dir) do
    Dir.mktmpdir do |dir|
      open(File.join(dir, 'root.dun'), 'w') { |f| f.puts palette_doc }
    end
  end

  describe '.load' do
    it 'loads phrases from the given genre' do
      ListLoader.load 'sexy-horror'
    end
  end
end