class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :description, presence: true
  validates :video_source_id, presence: true
  validates :name, presence: true
  validates :name, length: { minimum: 3 }

  belongs_to :project

end
