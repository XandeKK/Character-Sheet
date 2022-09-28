class CreatePathfinderDefenses < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_defenses do |t|
      t.integer :max_hp
      t.integer :current_hp
      t.integer :ancestry_hp
      t.integer :class_hp
      t.integer :temp_hp
      t.string :resistances_and_immunities
      t.string :conditions
      t.integer :dying
      t.integer :wounded
      t.integer :armor_class_item
      t.integer :armor_class_proficiency
      t.integer :max_dex
      t.integer :heavy_proficiency
      t.integer :medium_proficiency
      t.integer :light_proficiency
      t.integer :unarmored_proficiency
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
