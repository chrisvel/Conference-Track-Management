class CTValidator

  attr_accessor :talks

  # maximum length in minutes that a talk could be
  MAX_LENGTH = 240

  def initialize(talks)
    @talks = talks
    select_valid
    select_unique
  end

  # Check If there's any talk with length more than the limits
  def select_valid
    @talks.select! { |talk| talk.length.to_i <= MAX_LENGTH }
    @talks
  end

  # Saves only unique values considering description
  # if there are two entries with same description, we save the first one
  def select_unique
    @talks.uniq! { |talk| talk.description }
    @talks
  end

end
