class CreatePathfinderMeleeStrikes < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_melee_strikes do |t|
      t.string :weapon
      t.string :weapon_strength
      t.integer :proficiency
      t.integer :item
      t.integer :dice
      t.string :types
      t.string :damage_strength
      t.string :weapon_specialization
      t.string :traits
      t.string :other
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
