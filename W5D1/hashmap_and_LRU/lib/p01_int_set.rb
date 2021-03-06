require "byebug"

class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max)
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if num > @max || num < 0
    store[num] = true
  end

  def remove(num)
    store[num] = nil
  end

  def include?(num)
    store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    store[num % num_buckets] = true
  end

  def remove(num)
    store[num % num_buckets] = []
  end

  def include?(num)
    return false if store[num % num_buckets] == []
    true
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if count == num_buckets
      resize!
    end

    if @store[num % num_buckets] == []
      @store[num % num_buckets] = num
      @count += 1
    end

  end

  def remove(num)
    unless @store[num % num_buckets] == []
      @store[num % num_buckets] = []
      @count -= 1
    end
  end

  def include?(num)
    return false if @store[num % num_buckets] == []
    true
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    values = @store.dup
  
    @num_buckets *= 2
    unless @store.any?{|element| element == []}
      @store = Array.new(@num_buckets){Array.new}

      values.each do |el|
        @store[el % @num_buckets] = el
      end
    end
  end
  
end
