class CreatePathfinderSpells < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_spells do |t|
      t.integer :level
      t.string :name
      t.string :spell_component
      t.string :duration
      t.integer :prepared
      t.integer :action
      t.integer :range
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
