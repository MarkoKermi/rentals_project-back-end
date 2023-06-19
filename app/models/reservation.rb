# Creates the aplication reservation
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :vespa

  validates :city, presence: true
  validates :pick_up_date, presence: true
  validates :return_date, presence: true
  validates_comparison_of :return_date, greater_than: :pick_up_date, other_than: Date.today
end
