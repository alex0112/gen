class Item
  attr_accessor :weight
  attr_accessor :data
  
  def initialize(weight: 1, size: nil, data: nil)
    @weight = weight
    @data   = data
  end

end
