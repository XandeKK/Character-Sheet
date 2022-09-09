class CreatePathfinderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_details do |t|
      t.string :name, null: false
      t.string :class_name
      t.string :ancestry
      t.string :heritage
      t.string :alignment
      t.string :background
      t.string :traits
      t.integer :level
      t.integer :hero_points
      t.integer :size
      t.integer :experience_points
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
