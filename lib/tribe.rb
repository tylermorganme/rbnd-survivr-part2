class Tribe
  attr_reader :name, :members
  def initialize(options={})
    @name = options[:name]
    @members = options[:members]
    puts "Tribe #{@name} has been created"
  end
  def name
    @name
  end
  def members
    @members
  end
  def to_s
    @name
  end
  def tribal_council(options)
    immune = options[:immune]
    voted_off = @members.sample
    while voted_off == immune do
      voted_off = @members.sample
    end
    voted_off
  end
end
