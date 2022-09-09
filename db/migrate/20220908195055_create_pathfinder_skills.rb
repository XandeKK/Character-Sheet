class CreatePathfinderSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_skills do |t|
      t.string :name
      t.string :ability
      t.integer :proficiency
      t.integer :item
      t.integer :armor
      t.string :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
