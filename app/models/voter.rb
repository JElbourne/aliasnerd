class Voter < ActiveRecord::Base
  acts_as_voter

  def self.has_voted?(model, voting_id)
    voter = find_by(voting_id: voting_id)
    voter.voted_for? model if voter
  end

end

