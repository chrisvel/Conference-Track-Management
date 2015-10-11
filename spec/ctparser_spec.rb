require 'rspec'
require_relative '../lib/CTParser.rb'

describe CTParser do

  before :all do
    @file_name = 'data/talks.txt'
    @ctmfile = CTParser.new(@file_name)
  end

  it { expect(@ctmfile).to respond_to(:data) }
  it { expect(@ctmfile).to respond_to(:talks) }
  it { expect(@ctmfile).to respond_to(:read_file_data) }
  it { expect(@ctmfile).to respond_to(:process_line) }

  it "should raise an error when trying to set @talks from outside" do
    expect{@ctmfile.talks = [1,2]}.to raise_error(NoMethodError)
  end
  it "should not raise an error when trying to set @data" do
    expect{@ctmfile.data = [1,2]}.not_to raise_error(NoMethodError)
  end
  it "should set @data with the right elements" do
    expect(@ctmfile.data = [1,2]).to eq([1,2])
  end
  it "should validate talk file's existance" do
    expect(File).to exist(@file_name)
  end
  it "should initialize @talks as an Array" do
    expect(@ctmfile.talks).to be_an_instance_of(Array)
  end
  it "should be initialized with a filename" do
    expect(@ctmfile.instance_variable_get(:@file_name)).not_to be_empty
  end
  it "calls read_file_data when created" do
    expect_any_instance_of(CTParser).to receive(:read_file_data)
    CTParser.new('data/talks.txt')
  end

  context "#read_file_data" do
    it "should return an Array" do
      expect(@ctmfile.read_file_data).to be_an_instance_of(Array)
    end
    it "should not raise an error" do
      expect{ @ctmfile.read_file_data }.not_to raise_error
    end
    it "should parse the right amount of elements" do
      count = 0
      @ctmfile.talks.each { |k| count += 1 }
      expect(@ctmfile.talks.length).to eq(count)
    end
  end

  context "#process_line" do
    it "should return an Array" do
      line = "Ruby Errors from Mismatched Gem Versions 45min"
      expect(@ctmfile.process_line(line)).to be_an_instance_of(Array)
    end
    it "should return an Array with correct elements" do
      line = "Ruby Errors from Mismatched Gem Versions 45min"
      description = "Ruby Errors from Mismatched Gem Versions"
      length = 45
      expect(@ctmfile.process_line(line)).to eq([description, length])
    end
    it "should not return an Array with wrong elements (misplaced numbers)" do
      line = "Ruby Errors from 23ismatched23em V23sions 45min"
      description = "Ruby Errors from Mismatched Gem Versions"
      length = 45
      expect(@ctmfile.process_line(line)).not_to eq([description, length])
    end
    it "should return an Array with lightning talk length as 5min" do
      line = "Rails for Python Developers lightning"
      description = "Rails for Python Developers"
      length = 5
      expect(@ctmfile.process_line(line)).to eq([description, length])
    end
  end

end
