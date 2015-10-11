require './lib/Track'

class CTManager

  attr_accessor :talks
  attr_reader :tracks

  def initialize(talks)
    @talks = talks
    @tracks = []
    transform_to_decreasing
    pack_talks
  end

  # reverse sorts @talks list in order to use FF decreasing algorithm
  def transform_to_decreasing
    @talks.sort_by!{ |x| x.length.to_i }.reverse!
  end

  # returns max length depending on track placement
  def get_max_length(x)
    x % 2 == 0 ? y = 180 : y = 240
  end


  def pack_talks

    @tracks << Track.new() # create first [0] Track object
    x = 0 # first object @tracks[0]

    @talks.each do |talk|

      # if it's morning session, set limit to 180min, otherwise to 240min
      len = get_max_length(x)

      # if the sum of Track's total length + current talk's length is less
      # than y minutes
      if @tracks[x].total_length + talk.length.to_i <= len

        # append talk to current Track
        @tracks[x].talks << talk

        # add current talk's length to Track's total length
        @tracks[x].total_length += talk.length.to_i

      else
        available_tracks = @tracks.dup.reject{|k| k == x}
        available_tracks.each_with_index do |track, index|

          # if it's morning session, set limit to 180min, otherwise to 240min
          len = get_max_length(index)

          if track.total_length + talk.length.to_i <= len

            # append talk to current Track
            track.talks << talk

            # add current talk's length to Track's total length
            track.total_length += talk.length.to_i
            break
          else
            # append a new Track to the conference
            @tracks << Track.new()

            # set the last element of the array as the current one
            x = @tracks.size - 1

            # append talk to current track
            @tracks[x].talks << talk

            # add current talk's length to Track's total length
            @tracks[x].total_length += talk.length.to_i
            break
          end

        end

      end # @talks.each

    end
    @tracks
  end
end
