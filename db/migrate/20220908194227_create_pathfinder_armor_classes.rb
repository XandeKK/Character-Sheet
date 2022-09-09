class CreatePathfinderArmorClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_armor_classes do |t|
      t.integer :capable
      t.integer :proficiency
      t.integer :unarmored
      t.integer :light
      t.integer :medium
      t.integer :heavy
      t.integer :shield
      t.integer :hardness
      t.integer :maxHp
      t.integer :broken_threshold
      t.integer :current_hp
      t.integer :item
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
