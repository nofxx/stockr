require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Stockr" do

  def run(x)
    Stockr.work(x)
  end

  it "should add parts" do
    run("2 LM358").should eql("Done. 2x LM358")
    run("LM358").should eql("2x LM358")
  end

  it "should add parts" do
    run("100 1K").should eql("Done. 100x 1K")
    run("1K").should eql("100x 1K")
  end

  it "should increment existing parts" do
    run("2 ATMEGA32").should eql("Done. 2x ATMEGA32")
    run("2 ATMEGA32").should eql("Done. 4x ATMEGA32")
    run("ATMEGA32").should eql("4x ATMEGA32")
  end

  it "should decrement existing parts" do
    run("4 LM447").should eql("Done. 4x LM447")
    run("-2 LM447").should eql("Done. 2x LM447")
  end

  it "should add missing parts" do
    run("-2 LM447").should eql("Done. -2x LM447")
    run("2 LM447").should eql("Done. 0x LM447")

  end

  it "should upcase the part name" do
    run("8 enc28j60").should eql("Done. 8x ENC28J60")
  end

  it "should be case insensitive" do
    run("2 LM447").should eql("Done. 2x LM447")
    run("lm447").should eql("2x LM447")
  end

  it "should search pattern" do
    run("4 LM447").should eql("Done. 4x LM447")
    run("4 LM448").should eql("Done. 4x LM448")

    run("LM4").should eql("4x LM447\n4x LM448")
  end

  it "should not fault when not found" do
    run("DUNNO").should eql("Not found... go shop!")
  end

  it "should export txt file" do
    run("txt").should eql("File saved! stockr-")
  end

  it "should export to html file" do
  end

end
