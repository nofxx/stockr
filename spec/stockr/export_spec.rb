require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Export" do
  include Stockr

  it "should export txt file" do
    Time.should_receive(:now).and_return(Time.at(1291879432))
    run("4 LM448").should eql("Done. 4x LM448")
    run("txt").should eql("File saved! my_stockr_10-12-09-05-23-52.txt")
  end

  it "should export to html file" do

  end


  it "should import txt bkp" do
    run("load ./spec/data/export.txt").should eql("Loaded")
    Part.find("LM7805").qty.should eql(25)
  end


end

