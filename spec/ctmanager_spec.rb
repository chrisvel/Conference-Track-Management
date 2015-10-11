require 'rspec'
require_relative '../lib/CTValidator.rb'
require_relative '../lib/CTParser.rb'
require_relative '../lib/CTManager.rb'

describe CTManager do

  before :all do
    @ctmfile = CTParser.new('./data/talks.txt')
    @talks = CTValidator.new(@ctmfile.talks).talks
    @ctm = CTManager.new(@talks)
  end

  it { expect(@ctm).to respond_to(:talks) }
  it { expect(@ctm).to respond_to(:tracks) }
  it { expect(@ctm).to respond_to(:get_max_length) }
  it { expect(@ctm).to respond_to(:transform_to_decreasing) }
  it { expect(@ctm).to respond_to(:pack_talks) }

  it "should not raise an error when trying to set @talks" do
    expect{@ctm.talks = @talks}.not_to raise_error
  end
  it "should raise an error when trying to set @tracks from outside" do
    expect{@ctm.tracks = [1,2]}.to raise_error(NoMethodError)
  end
  it "should set @data with the right elements" do
    expect(@ctm.talks = @talks).to eq(@talks)
  end
  it "should initialize @tracks as an Array" do
    expect(@ctm.tracks).to be_an_instance_of(Array)
  end
  it "calls transform_to_decreasing when created" do
    expect_any_instance_of(CTManager).to receive(:transform_to_decreasing)
    CTManager.new(@talks)
  end
  it "calls pack_talks when created" do
    expect_any_instance_of(CTManager).to receive(:pack_talks)
    CTManager.new(@talks)
  end

  context "#transform_to_decreasing" do
    it "should return an Array" do
      expect(@ctm.transform_to_decreasing).to be_an_instance_of(Array)
    end
    it "should not raise an error" do
      expect{ @ctm.transform_to_decreasing }.not_to raise_error
    end
    it "should return the right amount of elements" do
      count = 0
      @ctm.talks.each { |k| count += 1 }
      expect(@ctm.transform_to_decreasing.length).to eq(count)
    end
  end

  context "#get_max_length" do
    it "should return an Integer" do
      expect(@ctm.get_max_length(0)).to be_a Integer
    end
    it "should not raise an error" do
      expect{ @ctm.get_max_length(0) }.not_to raise_error
    end
    it "should return 180 if input number is even" do
      even = (0..20).step(2).to_a
      odd = (1..20).step(2).to_a
      even.each {|no| expect(@ctm.get_max_length(no)).to eq(180) }
    end
    it "should return 240 if input number is odd" do
      odd = (1..20).step(2).to_a
      odd.each {|no| expect(@ctm.get_max_length(no)).to eq(240) }
    end
  end

  context "#pack_talks" do
    it "should return an Array of Tracks" do
      expect(@ctm.pack_talks).to be_a Array
    end
    it "should not raise an error" do
      expect{ @ctm.pack_talks }.not_to raise_error
    end
    it "should have the right amount of talks" do
      count_imported = 0
      @talks.each { |k| count_imported += 1 }
      count_packed = 0
      @ctm.pack_talks.each {|k| count_packed += 1 }
      expect(count_packed).to eq(count_imported)
    end
  end

end
