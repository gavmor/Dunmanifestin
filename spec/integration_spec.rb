require 'rspec'

describe 'generate' do
  it 'produces a string of text' do
    text = `./generate.sh`
    text.should_not be_empty
  end

  describe 'loading a genre' do
    let(:scifi) {  }

    around do |example|
      `mkdir ./lists/scifi`
      `echo "|root\nraygun" > ./lists/scifi/root.list`
      example.run
      `rm -r ./lists/scifi`
    end

    it 'overwrites default lists' do
      text = `./generate.sh -g scifi`.chomp
      text.should == 'raygun'
    end
  end
end