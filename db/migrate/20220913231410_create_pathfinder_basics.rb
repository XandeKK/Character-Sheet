class CreatePathfinderBasics < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_basics do |t|
      t.string :name
      t.string :class_name
      t.string :ancestry
      t.string :heritage
      t.text :heritage_note
      t.string :background
      t.string :alignment
      t.string :deity
      t.string :key_ability
      t.integer :age
      t.integer :level
      t.integer :hero_points
      t.string :size
      t.string :speed
      t.text :speed_note
      t.text :description
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
