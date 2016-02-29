class Game
  attr_reader :tribes
  def initialize(tribe1, tribe2)
    @tribes = [tribe1, tribe2]
  end
  def tribes
    @tribes
  end
  def add_tribe(tribe)
    @tribes << tribe
  end
  def immunity_challenge
    @tribes.sample
  end
  def clear_tribes
    @tribes.clear
  end
  def merge(tribe_name)
    merged_tribes = @tribes.inject([]) do |unified_tribe, individual_tribe|
      unified_tribe + individual_tribe.members
    end
    Tribe.new({name: tribe_name, members: merged_tribes})
  end
  def individual_immunity_challenge
    @tribes.sample.members.sample
  end
end
