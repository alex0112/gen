require_relative('./item.rb')

class Knapsack
    attr_reader :capacity
    attr_reader :weight
    attr_reader :contents
  
    def initialize(capacity: nil, weight:, contents: nil)
      @capacity = capacity
      @weight   = weight
      self.contents = contents if contents ## Use the setter to enforce weight/capacity restrictions
    end
    
    def contents=(new_contents)
      raise KnapsackCapacityExceededError if exceeds_capacity? new_contents
      raise KnapsackWeightExceededError   if exceeds_weight? new_contents
      raise KnapsackContentError          if has_non_items? new_contents
      
      @contents = new_contents
    end

    def has_non_items?(contents)
      contents.any? { |e| !e.is_a? Item }
    end

    def push(item)
      (item.is_a? Item && @contents.push(item).length <= @capacity) || raise(KnapsackContentError)
      @contents
    end

    def pop
      @contents.pop
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



# p "does it fit capacity?"
# p k.fits_capacity?(a)
# p "is it within weight?"
# p k.fits_weight?(a)
# p "does it fit altogether?"
# p k.fits?(a)

# kinf = Knapsack.new(capacity: Float::INFINITY, weight: 4)
# p "kinf fits capacity"
# p kinf.fits_capacity? Array.new(10000000)
