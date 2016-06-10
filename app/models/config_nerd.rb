class ConfigNerd < ActiveRecord::Base
  acts_as_votable

  validates :video_ad_id, presence: true

  def get_liked_count
    self.votes_for.size
  end
end
