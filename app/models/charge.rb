class Charge < ActiveRecord::Base
  #evt_18ELJD2f1XdroZv4TXVqWhP2
  belongs_to :user

  validates :user_id, presence: true
  validates :stripe_charge_id, presence: true
  validates :amount_in_cents, presence: true
  validates :card_last4, presence: true
  validates :card_exp_month, presence: true
  validates :card_exp_year, presence: true
  validates :card_type, presence: true
end
