require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Export" do
  include Stockr

  it "should export txt file" do
    Time.should_receive(:now).exactly(2).times.and_return(Time.at(1291879432))
    run("4 LM448")
    run("txt").should eql("File saved! my_stockr_10-12-09-05-23-52.txt")
  end

  it "should export to html file" do

  end


  it "should import txt bkp" do
    run("load ./spec/data/export.txt").should eql("Loaded")
    Part.find("LM7805").qty.should eql(50)
    Part.find("LM758").qty.should eql(25)
  end

  it "should import all values" do
    run("load ./spec/data/export.txt").should eql("Loaded")
    Part.all.size.should eql(3)
  end


end

