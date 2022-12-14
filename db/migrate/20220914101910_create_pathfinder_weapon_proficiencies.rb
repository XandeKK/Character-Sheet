class CreatePathfinderWeaponProficiencies < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_weapon_proficiencies do |t|
      t.string :name
      t.integer :proficiency
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
