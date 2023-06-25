# Creates the user model
class User < ApplicationRecord
  has_many :vespas, dependent: :destroy
  has_many :reservations, dependent: :destroy

  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
