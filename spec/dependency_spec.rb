require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Dependency do
  
  before(:each) do
    @dependency = Dependency.new
  end
  
  it "stores existing files" do
    @dependency << 'jquery.js'
    @dependency.to_a.should eq(['jquery.js'])
  end
  
  it "rejects non-existing files" do
    @dependency << 'prototype.js'
    @dependency.to_a.should eq([])
  end
  
end
