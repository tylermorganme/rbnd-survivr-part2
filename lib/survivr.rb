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
def print_voted_off(name, team, color)
  puts "#{name.blue} voted off of team" + " #{team.send(color)}"
end

def print_immunity_challenge(iterations)
  @iterations.times do
    immune = @borneo.individual_immunity_challenge
    puts "#{immune.name.capitalize.blue} " + "gained immunity".green
    voted_off = @borneo.tribes[0].tribal_council({immune: immune})
    puts print_voted_off(voted_off.name.capitalize, @borneo.tribes[0].name, "yellow")
  end
end

#This is where you will write your code for the three phases
def phase_one
  @iterations = 8
  puts "Phase 1"
  puts ""

  color1 = true
  @iterations.times do
    team = @borneo.immunity_challenge
    individual = team.tribal_council
    puts print_voted_off(individual.to_s.capitalize, team.name, color1 ? "pink" : "light_blue")
    color1 = !color1
  end

  puts ""
  @iterations
end

def phase_two
  puts "Phase 2"
  @iterations = 3
  print_immunity_challenge(@iterations)
  @iterations
end

def phase_three
  puts "Phase 3"
  @iterations = 7
  print_immunity_challenge(@iterations)
  puts "Jury Phase"
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
