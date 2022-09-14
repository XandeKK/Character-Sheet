class CreatePathfinderInnateSpells < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_innate_spells do |t|
      t.string :name
      t.text :notes
      t.integer :frequency
      t.string :spell_component
      t.string :action
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
