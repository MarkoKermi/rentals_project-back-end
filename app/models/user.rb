# Creates the user model
class User < ApplicationRecord
  has_many :vespas, dependent :destroy
  has_many :reservations, dependent :destroy

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, lenght: { minimum: 6 }  
end
