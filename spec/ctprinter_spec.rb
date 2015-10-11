require 'rspec'
require_relative '../lib/CTValidator.rb'
require_relative '../lib/CTParser.rb'
require_relative '../lib/CTManager.rb'
require_relative '../lib/CTPrinter.rb'

describe CTPrinter do

  before :all do
    @ctmfile = CTParser.new('./data/talks.txt')
    @talks = CTValidator.new(@ctmfile.talks).talks
    @ctm = CTManager.new(@talks)
    @ctp = CTPrinter.new(@ctm.talks, @ctm.tracks)
  end

  it { expect(@ctp).to respond_to(:talks) }
  it { expect(@ctp).to respond_to(:tracks) }
  it { expect(@ctp).to respond_to(:calc_total_length) }
  it { expect(@ctp).to respond_to(:puts_talks) }
  it { expect(@ctp).to respond_to(:format_time) }
  it { expect(@ctp).to respond_to(:print_schedule) }

  it "should not raise an error when trying to set @talks from outside" do
    expect{@ctp.talks = @talks}.not_to raise_error
  end
  it "should not raise an error when trying to set @tracks from outside" do
    expect{@ctp.tracks = [1,2]}.not_to raise_error
  end
  it "should set @data with the right elements" do
    expect(@ctp.talks = @talks).to eq(@talks)
  end
  it "should initialize @tracks as an Array" do
    expect(@ctp.tracks).to be_an_instance_of(Array)
  end

  context "#calc_total_length" do
    it "should output to stdout" do
      expect { @ctp.calc_total_length }.to output.to_stdout
    end
    it "includes \"Total length:\" in output to stdout" do
      expect { @ctp.calc_total_length }.to output(/Total length:/).to_stdout
    end
    it "should not raise an error" do
      expect { @ctp.calc_total_length }.not_to raise_error
    end
  end

  context "#format_time" do
    it "should return a String" do
      expect (@ctp.format_time(100)).to be_an_instance_of(String)
    end
    it "should not raise an error" do
      expect { @ctp.format_time(100) }.not_to raise_error
    end
  end

end
