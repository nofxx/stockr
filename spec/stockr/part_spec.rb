require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Part" do
  include Stockr

  it "should have name" do
    Part.new("IRF640").name.should eql("IRF640")
  end

  it "should have qty" do
    Part.new("IRF640", 10).qty.should eql(10)
  end

  it "should have price" do
    Part.new("IRF640", 10, "0,30").price.should be_within(0.1).of(0.3)
  end

  
end
