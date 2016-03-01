class Jury
  attr_accessor :members
  def initialize
    @members = []
  end
  def add_member(member)
    @members << member
  end
  def members
    @members
  end
  def cast_votes(finalists)
    final_votes = {}
    finalists.each {|finalist| final_votes[finalist] = 0}
    @members.each do |member|
      vote_for = finalists.sample
      final_votes[vote_for] +=1
      puts "#{member.to_s.capitalize} votes for #{vote_for.name.capitalize}"
    end
    final_votes
  end
  def report_votes(final_votes)
    final_votes.each {|finalist, votes| puts "#{finalist.name.capitalize} received #{votes} votes"}
  end
  def announce_winner(final_votes)
    final_votes.each do |finalist, votes|
      if votes >= 4 then
        puts "#{finalist.name.capitalize} won!"
        return finalist
      end
    end
  end
end
