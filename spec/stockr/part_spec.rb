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

  it "should list all parts" do
    run("-2 LM447")
    run("2 LM448")
    Part.all.should have(2).parts
  end

  it "should list missing parts" do
    run("-2 LM447")
    run("2 LM448")
    Part.missing.should have(1).part
    Part.missing[0].name.should eql("LM447")
   # run("shop").should eql("-2x LM447  $ 0.000 ($ -0.000)")
  end

end
