class ConfigNerd < ActiveRecord::Base
  acts_as_votable

  def get_liked_count
    self.votes_for.size
  end
end
