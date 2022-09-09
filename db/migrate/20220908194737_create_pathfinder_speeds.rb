class CreatePathfinderSpeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_speeds do |t|
      t.integer :feet
      t.string :movement_types
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
