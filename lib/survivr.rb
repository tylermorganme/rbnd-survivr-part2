require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"
require 'colorizr'

#After your tests pass, uncomment this code below
#=========================================================
# Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!
# Create two new tribes with names
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))

# Create a new game of Survivor
@borneo = Game.new(@coyopa, @hunapu)

#=========================================================


#This is where you will write your code for the three phases
def phase_one
  @iterations = 8
  puts "Starting Survivr".light_blue
  puts "Phase 1".yellow
  puts ""
  @borneo.tribes.each do |tribe|
    puts "Tribe: #{tribe.name}"
    tribe.members.each do |member|
      puts member
    end
    puts ""
  end
  @iterations.times do
    team = @borneo.immunity_challenge
    individual = team.tribal_council
    puts "#{individual.to_s.blue}" + " voted off of ".red + "#{team.to_s.pink}"
  end
  puts ""
  @iterations
end

def phase_two
  puts "Phase 2".yellow
  @iterations = 3
  @iterations.times do
    immune = @borneo.individual_immunity_challenge
    puts "#{immune.name.blue} " + "gained immunity".green
    voted_off = @borneo.tribes[0].tribal_council({immune: immune})
    puts "#{voted_off.to_s.blue}" + " was voted off".red
  end
  puts ""
  @iterations
end

def phase_three
  puts "Phase 3".yellow
  @iterations = 7
  @iterations.times do
    immune = @borneo.individual_immunity_challenge
    puts "#{immune.name.blue}" + " gained immunity".green
    voted_off = @borneo.tribes[0].tribal_council({immune: immune})
    @jury.add_member(voted_off)
    puts "#{voted_off.to_s.blue}" + " was voted off".red
  end
  puts ""
  puts "Jury Phase".yellow
  @iterations
end


# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
@jury = Jury.new
phase_three #7 elminiations become jury members
finalists = @merge_tribe.members #set finalists
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
@jury.announce_winner(vote_results) #Jury announces final winner
