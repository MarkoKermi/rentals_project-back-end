class CreateVaspas < ActiveRecord::Migration[7.0]
  def change
    create_table :vaspas do |t|

      t.timestamps
    end
  end
end
