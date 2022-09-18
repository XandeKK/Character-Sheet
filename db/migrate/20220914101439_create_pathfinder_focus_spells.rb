class CreatePathfinderFocusSpells < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_focus_spells do |t|
      t.string :name
      t.text :notes
      t.string :spell_component
      t.string :duration
      t.integer :action
      t.integer :range
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
