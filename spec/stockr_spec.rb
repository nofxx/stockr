require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Stockr" do

  def find(t)
    Stockr::Part.find(t)
  end

  it "should add parts" do
    run("2 LM358").should be_a Stockr::Part
    run("LM358").should have(1).part
  end

  it "should add part names" do
    run("100 1K").name.should eql("1K")
  end

  it "should add part qty" do
    run("100 1K").qty.should eql(100)
  end

  it "should increment existing parts" do
    run("2 ATMEGA32").name.should eql("ATMEGA32")
    run("2 ATMEGA32").qty.should eql(4)
    Stockr::Part.all.size.should eql(1)
    find("ATMEGA32").qty.should eql(4)
  end

  it "should decrement existing parts" do
    run("4 LM447")
    run("-2 LM447")
    Stockr::Part.all.size.should eql(1)
    find("LM447").qty.should eql(2)
  end

  it "should parse nicely missing parts" do
    run("-2 4N35").qty.should eql(-2)
  end

  it "should add missing parts" do
    run("-2 LM447")
    find("LM447").qty.should eql(-2)
    run("2 LM447")
    find("LM447").qty.should be_zero
  end

  it "should list missing parts" do
    run("-2 LM447")
    run("2 LM448")
    run("shop").should eql("-2x LM447  $ 0.000 ($ -0.000)")
  end


  it "should add prices to parts" do
    run("1 LM447 1.50").price.should be_within(0.1).of(1.5)
  end

  it "should add prices to multiple parts (sum)" do
    run("2 LM447 0.50").price.should be_within(0.1).of(0.5)
  end

  it "should upcase the part name" do
    run("8 enc28j60").name.should eql("ENC28J60")
  end

  it "should be case insensitive" do
    run("2 LM447")
    run("lm447")[0].name.should eql(find("LM447").name)
  end

  it "should search pattern" do
    run("4 LM447")
    run("4 LM448")

    run("LM4").should have(2).parts
  end

  it "should not fault when not found" do
    run("DUNNO").should be_nil
  end


end
