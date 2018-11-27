class Environment
  def intialize(chromosomes:, itterations: 100, knapsack:)
    @chromosomes = Array.new(chromosomes) { Chromosome.new(length: knapsack.capacity) }
  end

  def run
    @itterations.times do |i|
        
    end
  end
  
end
