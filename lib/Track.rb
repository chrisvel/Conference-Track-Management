class Track

  attr_accessor :talks, :total_length

  def initialize(talks = [])
    @talks = talks
    @total_length = 0
  end

end
