class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :web_link, presence: true
  validates :github_link, presence: true
end
