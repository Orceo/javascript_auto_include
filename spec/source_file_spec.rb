require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'yaml'

describe SourceFile do
  
  before(:all) do
    @conf = "#{::Rails.root}#{File::SEPARATOR}config#{File::SEPARATOR}dependencies"
    if Dir.exists?(@conf)
      Dir.entries(@conf).collect { |file| File.delete("#{@conf}#{File::SEPARATOR}#{file}") unless ['.'].include?(file) }
      Dir.rmdir(@conf)
    end
    @test_array = ['jquery','rails','fake_controller','application']
    @source = SourceFile.new(@test_array)
    @dependencies = @source.dependencies
  end
  
  it "reads dependencies from javascript file" do
    @dependencies.should eq(["jquery", "rails", "jquery.ui.core.js", "jquery.ui.mouse.js", "jquery.ui.widget.js", "fake_controller", "application"])
  end

  it "caches discoveries in config file" do
    File.exists?("#{@conf}#{File::SEPARATOR}fake_controller.yml").should be_true
  end
  
  it "reads dependencies from config file" do
    @source = SourceFile.new(@test_array)
    @source.dependencies.should eq(["jquery", "rails", "jquery.ui.core.js", "jquery.ui.mouse.js", "jquery.ui.widget.js", "fake_controller", "application"])
  end
  
  it "does not re-check for dependencies unless forced to" do
    @source = SourceFile.new(@test_array)
    @source.dependencies(true).should eq(["jquery", "rails", "jquery.ui.core.js", "jquery.ui.mouse.js", "jquery.ui.widget.js", "fake_controller", "application"])
  end
  
  it "silently handles non-existant JS source files" do
    @source = SourceFile.new(@test_array << 'hello')
    @source.dependencies.should eq(["jquery", "rails", "jquery.ui.core.js", "jquery.ui.mouse.js", "jquery.ui.widget.js", "fake_controller", "application"])
  end
  
  it "can store multiple dependencies in one directory" do
    SourceFile.new(['jquery','rails','another_fake_controller','application']).dependencies
    File.exists?("#{@conf}#{File::SEPARATOR}fake_controller.yml").should be_true
    File.exists?("#{@conf}#{File::SEPARATOR}another_fake_controller.yml").should be_true
  end
  
  it "uses minimized instead of regular versions in production environments" do
    ENV["RAILS_ENV"] = 'production'
    @source = SourceFile.new(@test_array)
    @source.dependencies.should eq(["jquery", "rails", "jquery.ui.core.min.js", "jquery.ui.mouse.min.js", "jquery.ui.widget.min.js", "fake_controller", "application"])
  end
  
end
