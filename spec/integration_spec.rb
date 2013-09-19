require 'rspec'

describe 'generate' do
  it 'produces a string of text' do
    text = `./generate.sh`
    text.should_not be_empty
  end

  describe 'loading a genre' do
    let(:scifi) { 'scifi_but_lets_be_sure_not_to_overwrite_any_user_data' }
    let(:generated_text) { `./generate.sh -g #{scifi}`.chomp }

    around do |example|
      `mkdir ./lists/#{scifi}`
      `echo "|root\nraygun" > ./lists/#{scifi}/root`
      example.run
      `rm -r ./lists/#{scifi}`
    end

    it 'overrides default lists' do
      generated_text.should == 'raygun'
    end
    
    context "using a list that's not defined in the genre" do
      let(:character_name) { 'name_but_lets_be_sure_not_to_overwrite_any_user_data' }
      
      around do |example|
        `echo "|name\nZiggy" > ./lists/default/#{character_name}`
        `echo "|root\n[name]'s raygun" > ./lists/#{scifi}/root`
        example.run
        `rm ./lists/default/#{character_name}`
      end
      
      it "uses the default list" do
        generated_text.should == "Ziggy's raygun"
      end
    end
  end
end