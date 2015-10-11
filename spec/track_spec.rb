require 'rspec'
require_relative '../lib/CTValidator.rb'
require_relative '../lib/CTParser.rb'
require_relative '../lib/Track.rb'

describe Track do

  before :all do
    ctparser = CTParser.new('./data/talks.txt')
    @data = CTValidator.new(ctparser.talks)
    @track = Track.new(@data)
  end

  it { expect(@track).to respond_to(:talks) }
  it { expect(@track).to respond_to(:total_length) }

  it "should not raise an error when trying to set @talks" do
    expect{@track.talks = @data}.not_to raise_error(NoMethodError)
  end
  it "should not raise an error when trying to set @length" do
    expect{@track.total_length = 120}.not_to raise_error(NoMethodError)
  end
  it "should set @description with the right elements" do
    expect(@track.talks = @data).to eq(@data)
  end
  it "should initialize @length as 0" do
    @track = Track.new(@data)
    expect(@track.total_length).to eq(0)
  end

end
