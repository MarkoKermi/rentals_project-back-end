# frozen_string_literal: true

# Creates the vespa model
class Vespa < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :model, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :photo, presence: true
end
