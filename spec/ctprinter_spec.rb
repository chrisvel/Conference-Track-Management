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
      expect(@ctp.format_time(100)).to be_a_kind_of(String)
    end
    it "should return 100 as 01:00" do
      expect(@ctp.format_time(100)).to eq("01:00")
    end
    it "should return 900 as 09:00" do
      expect(@ctp.format_time(900)).to eq("09:00")
    end
    it "should return 960 as 10:00" do
      expect(@ctp.format_time(960)).to eq("10:00")
    end
    it "should return 1150 as 11:50" do
      expect(@ctp.format_time(1150)).to eq("11:50")
    end
    it "should return 1260 as 13:00" do
      expect(@ctp.format_time(860)).to eq("09:00")
    end
    it "should return 189 as 02:29" do
      expect(@ctp.format_time(189)).to eq("02:29")
    end
    it "should return 1099 as 11:39" do
      expect(@ctp.format_time(1099)).to eq("11:39")
    end
    it "should not raise an error" do
      expect { @ctp.format_time(100) }.not_to raise_error
    end
  end

  context "#print_schedule" do
    before :each do
      @ctp = CTPrinter.new(@ctm.talks, @ctm.tracks)
    end

    it "should output to stdout" do
      expect { @ctp.print_schedule }.to output.to_stdout
    end
    it "includes \"Track\" in output to stdout" do
      expect { @ctp.print_schedule }.to output(/Track/).to_stdout
    end
    it "includes \"12:00PM Lunch\" in output to stdout" do
      expect { @ctp.print_schedule }.to output(/12:00PM Lunch/).to_stdout
    end
    it "includes \"05:00PM Networking Event\" in output to stdout" do
      expect { @ctp.print_schedule }.to output(/05:00PM Networking Event/).to_stdout
    end
    it "includes talks from original file in output to stdout" do
      expect { @ctp.print_schedule }.to output(/#{@ctp.talks[0].description}/).to_stdout
      expect { @ctp.print_schedule }.to output(/#{@ctp.talks[2].description}/).to_stdout
    end
    it "should not raise an error" do
      expect { @ctp.print_schedule }.not_to raise_error
    end
  end

end
