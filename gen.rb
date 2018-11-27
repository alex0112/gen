require_relative('./knapsack.rb')

class Chromosome

  attr_reader :data
  
  def initialize(length: 10, data: nil)
    @data    = data || Array.new(length) { Item.new() }
    @fitness = nil
    @weight  = 
  end

  def weight
    @weight = @data.map { |item| item.weight }.reduce(:+)
  end
  
  def fitness(knapsack:, perfect: false)
    @fitness ||= @weight
    knapsack.fits? @data ? @fitness : 0
  end
  
end

## Why the heck am I even caching all of this?  I can't remember... I think it was because I defined two methods that needed to operate on the same data and I didn't want to make the same (potentially large) computation twice.  All of this could be solved with an ||= ...
  ## No.  The reason I'm caching it is that if I pass in a knapsack like I'm doing here, I want the fitness and the knapsack it was computed from to be coupled together, and if I ask for the fitness on the same Chromosome/Knapsack pair, why run through the computation twice?  This is where a cache comes in handy.

c = Chromosome.new(length: 10, data: Array.new(10) { Item.new(weight: 10) })
k = Knapsack.new(weight: 100, capacity: 10)

p c.fitness(knapsack: k)
