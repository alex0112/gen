class KnapsackCapacityExceededError < StandardError; end
class KnapsackWeightExceededError < StandardError; end
class KnapsackContentError < StandardError; end

require_relative('./item')

class Knapsack
  attr_reader :capacity
  attr_reader :weight
  attr_reader :contents
  
  def initialize(capacity:, weight:)
    @capacity = capacity
    @weight   = weight
    @contents = Array.new(@capacity)
  end

  def contents=(new_contents)
    raise KnapsackCapacityExceededError if exceeds_capacity? new_contents
    raise KnapsackWeightExceededError   if exceeds_weight? new_contents
    raise KnapsackContentError          if new_contents.any? { |e| !e.is_a? Item }

    @contents = new_contents
  end

  def fit?(contents)
    fits_weight?(contents) && fits_capacity?(contents)

  end
  alias_method :fits?, :fit?  

  def fits_weight?(contents)
    new_weight = contents.map { |item| item.weight }.sum
    new_weight <= @weight
  end

  def exceeds_weight?(contents)
    !fits_weight? contents
  end

  def fits_capacity?(contents)
    contents.length <= @capacity
  end

  def exceeds_capacity?(contents)
    !fits_capacity? contents
  end

end

## Future unit tests
k = Knapsack.new(capacity: 10, weight: 50)
a = Array.new(10) { Item.new(weight: 5) }

p "does it fit capacity?"
p k.fits_capacity?(a)
p "is it within weight?"
p k.fits_weight?(a)
p "does it fit altogether?"
p k.fits?(a)
