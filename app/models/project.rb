class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :description, presence: true
  validates :web_link, presence: true
  validates :github_link, presence: true
  validates :name, presence: true
  validates :name, length: { minimum: 3 }
  
  has_many :videos
end
