# Creates the user model
class User < ApplicationRecord
  has_many :vespas
  has_many :reservations

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, lenght: { minimum: 6 }
end
