class CreatePathfinderRangeds < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_rangeds do |t|
      t.string :name
      t.integer :qty
      t.string :types
      t.string :range
      t.integer :proficiency
      t.string :other
      t.string :traits
      t.integer :weapon_specialization
      t.integer :special
      t.string :die
      t.integer :item
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
