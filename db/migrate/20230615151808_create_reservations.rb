# frozen_string_literal: true

# Creates the reservations table
class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :city
      t.date :pick_up_date
      t.date :return_date
      t.references :user, null: false, foreign_key: true
      t.references :vespa, null: false, foreign_key: true

      t.timestamps
    end
  end
end
