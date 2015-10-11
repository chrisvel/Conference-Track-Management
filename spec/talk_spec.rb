require 'rspec'
require_relative '../lib/Talk.rb'

describe Talk do

  before :all do
    @data = ["Writing Fast Tests Against Enterprise Rails", 60]
    @talk = Talk.new(@data)
  end

  it { expect(@talk).to respond_to(:description) }
  it { expect(@talk).to respond_to(:length) }

  it "should not raise an error when trying to set @description" do
    expect{@talk.description = @data[0]}.not_to raise_error(NoMethodError)
  end
  it "should not raise an error when trying to set @length" do
    expect{@talk.length = @data[1]}.not_to raise_error(NoMethodError)
  end
  it "should set @description with the right elements" do
    expect(@talk.description = @data[0]).to eq(@data[0])
  end
  it "should set @length with the right elements" do
    expect(@talk.length = @data[1]).to eq(@data[1])
  end

end
