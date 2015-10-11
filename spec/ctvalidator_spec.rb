require 'rspec'
require_relative '../lib/CTValidator.rb'
require_relative '../lib/CTParser.rb'

describe CTValidator do

  before :all do
    @file_name = 'data/talks_2.txt'
    @talks = CTParser.new(@file_name).talks
    @ctmval = CTValidator.new(@talks)
  end

  it { expect(@ctmval).to respond_to(:talks) }
  it { expect(@ctmval).to respond_to(:select_valid) }
  it { expect(@ctmval).to respond_to(:select_unique) }

  it "should not raise an error when trying to set @talks" do
    expect{@ctmval.talks = @talks}.not_to raise_error(NoMethodError)
  end
  it "should set @data with the right elements" do
    expect(@ctmval.talks = @talks).to eq(@talks)
  end
  it "should initialize @talks as an Array" do
    expect(@ctmval.talks).to be_an_instance_of(Array)
  end
  it "calls select_valid when created" do
    expect_any_instance_of(CTValidator).to receive(:select_valid)
    CTValidator.new(@talks)
  end
  it "calls select_unique when created" do
    expect_any_instance_of(CTValidator).to receive(:select_unique)
    CTValidator.new(@talks)
  end

  context "#select_valid" do
    it "should return an Array" do
      expect(@ctmval.select_valid).to be_an_instance_of(Array)
    end
    it "should not raise an error" do
      expect{ @ctmval.select_valid }.not_to raise_error
    end
    it "should not include invalid elements (>240min)" do
      count = 0
      @ctmval.talks.each { |talk| count += 1 if talk.length > 240 }
      expect(count).to eq(0)
    end
  end

  context "#select_unique" do
    it "should return an Array" do
      expect(@ctmval.select_unique).to be_an_instance_of(Array)
    end
    it "should not raise an error" do
      expect{ @ctmval.select_unique }.not_to raise_error
    end
    it "should not include duplicate elements" do
      talk_counts = Hash.new 0

      @talks.each { |talk| talk_counts[talk.description] += 1 }

      talk_counts.each do |talk, occurencies|
        expect(occurencies).to eq(1)
      end

    end
  end

end
