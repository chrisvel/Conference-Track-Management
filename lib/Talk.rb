class Talk

  attr_accessor :description, :length

  def initialize(data)
    @description = data[0]
    @length = data[1]
  end

end
