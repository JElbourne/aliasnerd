class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  validates :name, presence: true
  validates :name, uniqueness: true
end
