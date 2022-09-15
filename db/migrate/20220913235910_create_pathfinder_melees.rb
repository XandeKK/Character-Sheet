class CreatePathfinderMelees < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_melees do |t|
      t.string :name
      t.integer :qty
      t.string :types
      t.integer :proficiency
      t.string :traits
      t.integer :weapon_specialization
      t.string :die
      t.integer :item
      t.string :other
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
