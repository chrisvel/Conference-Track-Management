require './lib/Talk.rb'

# Parses talk data from file and processes them to be in a manageable format
class CTParser

  attr_accessor :data
  attr_reader :talks

  def initialize(file_name)
    @file_name = file_name
    @talks = [] #includes all the Talk objects parsed from file
    read_file_data
  end

  # Reads data from file, line by line and creates a new Talk object for each
  # of them, then appends them all to an array @talks
  def read_file_data
    File.open(@file_name, 'r').each_line do |line|
      @talks << Talk.new(process_line(line))
    end
    @talks
  end

  # Uses regEx to slice each line to two parts, substitutes "lightning" with
  # the time length of 5 minutes, then returns an array with the talk
  # description and its length.
  def process_line(line)
    talk = line.match(/(\w+.*?)(\d+|lightning$)/)
    data = []
    if talk[2] == "lightning"
      data = [talk[1].strip, 5]
    else
      data = [talk[1].strip, talk[2].to_i]
    end

    return data
  end

end
