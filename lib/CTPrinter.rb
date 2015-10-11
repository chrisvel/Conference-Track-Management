require './lib/CTParser'
require './lib/CTManager'

# This class prints output data to terminal
class CTPrinter

  attr_accessor :talks, :tracks

  def initialize(talks, tracks)
    @talks = talks
    @tracks = tracks
  end

  # Prints the total length of all the talks in minutes
  def calc_total_length
    sum = 0
    @talks.each { |talk| sum += talk.length.to_i }
    puts "-- Total length: #{sum} min"
  end

  # Prints all the talk descriptions and lengths
  def puts_talks
    @talks.each { |talk| puts "* #{talk.length} :: #{talk.description}" }
  end

  # Takes time as an integer e.g. 1230 and returns it in the appropriate
  # format: "12:30"
  def format_time(ttime)

    # slice integer into an array of characters
    ttime = ttime.to_s.chars

    minutes = ttime[-1].to_i
    tminutes = ttime[-2].to_i
    hrs = ttime[-3].to_i

    # add "0" in case time is less than 10:00 so they all have the same length
    ttime[-4].nil? ? thrs = 0 : thrs = ttime[-4].to_i

    # convert 60 minutes to 1 hour
    if tminutes >=6
      tminutes -= 6
      if hrs == 9
         hrs = 0
         thrs += 1
      else
         hrs += 1
      end
    end

    # return the formatted time
    ttime = "#{thrs}#{hrs}:#{tminutes}#{minutes}"
  end

  # Prints the final schedule
  def print_schedule
    @tracks.each_with_index do |track, index|
      puts
      puts "Track #{index + 1} :: #{track.total_length}min"

      # if it's a morning session, the starting time is 09:00 (AM) and
      # if it's an afternoon one, it's 01:00 (PM)
      index % 2 == 0 ? ttime = 900 : ttime = 100

      track.talks.each do |talk|
        # get formatted time in "xx:xx" format
        time_formatted = format_time(ttime)
        # add AM/PM suffix
        index % 2 == 0 ? ampm = "AM" : ampm = "PM"

        puts "#{time_formatted}#{ampm} #{talk.description} #{talk.length == 5 ? 'lightning' : talk.length.to_s + 'min'}"
        # split new time
        new_time = time_formatted.chars
        # delete ":" from array's elements
        new_time.delete(":")
        # join elements, convert to integer and add current talk's length
        # converted to integer
        ttime = new_time.join.to_i + talk.length.to_i
      end

      # add lunch break and networking event
      if index % 2 == 0
        puts "12:00PM Lunch"
      else
        puts "05:00PM Networking Event"
      end
    end
  end

end
