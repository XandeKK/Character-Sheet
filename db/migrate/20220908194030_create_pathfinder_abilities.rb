class CreatePathfinderAbilities < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_abilities do |t|
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
