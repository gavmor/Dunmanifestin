require 'treetop'
require_relative '../lib/dunmanifestin/dunmanifestin_grammar'

RSpec::Matchers.define(:parse) do |text|
  match do |parser|
    parser.parse(text)
  end
  
  failure_message_for_should do |parser|
    "#{parser.failure_reason}"
  end
  
  failure_message_for_should_not do
    "Expected parse to fail, but it succeeded."
  end
end

describe ListSetParser do
  let(:parsed) do
    described_class.new.should parse(shove(@input || input))
  end
  
  def shove(string)
    prefix_space_length = string.match(/^ */).to_s.length
    string.gsub(%r<(^|\n) {#{prefix_space_length}}>, '\1')
  end
  
  describe 'a valid input' do
    after { parsed.should_not be_nil }
    
    it "may contain many lists" do
      @input = <<-__
      |list1
      item 1
      item 2
      
      |list2
      item 3
      item 4
      __
    end
    
    it "may contain a single list" do
      @input = <<-__
      |someName
      foo
      bar
      __
    end
    
    it "may be empty" do
      @input = ''
    end
    
    it "may consist of newlines" do
      @input = "\n\n"
    end
    
    it "may consist of whitespace" do
      @input = "  \n\t  \n"
    end
    
    it "may end with trailing spaces" do
      @input = "\n "
    end
    
    specify "lists may be preceded and followed by blank lines" do
      @input = <<-__
      
      
      |someName
      foo
      bar
      
      
      __
      parsed.should have(1).lists
      parsed.lists.first.should have(2).items
    end
    
    specify "lists need not be separated by blank lines" do
      @input = <<-__
      |someName
      foo
      |otherName
      bar
      __
    end
  end
    
  describe "a list" do
    it "begins with a name preceded by a pipe" do
      @input = <<-__
      |city
      Palo Alto
      San Francisco
      Seattle
      __
      
      parsed.lists[0].name.should eq 'city'
    end
    
    specify "items may be separated by blank lines" do
      @input = <<-__
      |city
      Palo Alto
      San Francisco
      
      Seattle
      __
      
      parsed.lists[0].should have(3).items
      parsed.lists[0].items.map(&:raw_content).should eq ['Palo Alto', 'San Francisco', 'Seattle']
    end
    
    it "may be divided into sections headed by a condition" do
      @input = <<-__
      |city
      $state = California
        Palo Alto
        San Francisco
      $state = Washington
        Seattle
      __
      
      parsed.lists[0].should have(3).items
      parsed.lists[0].should have(2).sections
      parsed.lists[0].sections.map { |s| s.condition.to_s }.should eq ['$state = California', '$state = Washington']
    end
    
    it "may be empty" do
      @input = <<-__
      |city
      
      |state
      |country
      __
      
      parsed.should have(3).lists
      parsed.lists.each { |l| l.items.should be_empty }
    end
  end
      
  describe "a list item" do
    it "may be indented" do
      @input = <<-__
      |city
        Palo Alto
        San Francisco
      __
      
      parsed.lists[0].items.map(&:raw_content).should eq ['Palo Alto', 'San Francisco']
    end
    
    it "may have a numeric multiplier that increases its probability of being chosen" do
      @input = <<-__
      |city
      Palo Alto
      3@San Francisco
      __
      
      parsed.lists[0].items.map(&:multiplier).should eq [1, 3]
    end
    
    it "may have interpolated free variables" do
      @input = <<-__
      |city
      [personName]ton
      __
      
      parsed.lists[0].items.first.raw_content.should eq '[personName]ton'
      parsed.lists[0].items.first.text_segments.should eq ['', 'ton']
      parsed.lists[0].items.first.variables.map(&:to_s).should eq ['personName']
    end
    
    it "may have interpolated bound variables" do
      @input = <<-__
      |city
      [$state]ton, the glorious capital of [$state]
      __
      
      parsed.lists[0].items.first.raw_content.should eq '[$state]ton, the glorious capital of [$state]'
      parsed.lists[0].items.first.text_segments.should eq ['', 'ton, the glorious capital of ']
      parsed.lists[0].items.first.variables.map(&:to_s).should eq ['$state', '$state']
    end
    
    it "may end with an interpolated variable" do
      @input = <<-__
      |city
        San [saintName]
      __
      
      parsed.lists[0].items.first.text_segments.should eq ['San ']
      parsed.lists[0].items.first.variables.map(&:to_s).should eq ['saintName']
    end
    
    describe "a text interpolation" do
      it "may have directives" do
        @input = <<-__
        |city
        San [saintName.capitalize]
        __
        
        parsed.lists[0].items[0].variables[0].directives.should eq ['.capitalize']
      end
      
      it "may delegate directives" do
        @input = <<-__
        |city
        San [saintName#pluralize] de [spanishWord]
        __
      end
    end
  end
      
  describe "a list section" do
    it 'has items' do
      @input = <<-__
      |city
      $state = California
        Palo Alto
        San Francisco
      __
      
      parsed.lists[0].sections[0].should have(2).items
    end
    
    it "may have no items" do
      @input = <<-__
      |city
      $state = Utopia
      __
      
      parsed.lists[0].sections[0].should have(0).items
    end
    
    it "has a condition" do
      @input = <<-__
      |city
      $state = California
        Palo Alto
      __
      
      parsed.lists[0].sections[0].condition.to_s.should eq '$state = California'
    end
    
    it "may have no condition, if it is the first section in a list" do
      @input = <<-__
      |city
        Minas Tirith
      $state = California
        Palo Alto
        San Francisco
      __
      
      parsed.lists[0].should have(2).sections
      parsed.lists[0].sections[0].condition.to_s.should eq ''
    end
  end
end
