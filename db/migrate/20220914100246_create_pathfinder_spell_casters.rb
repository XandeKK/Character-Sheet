class CreatePathfinderSpellCasters < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_spell_casters do |t|
      t.string :magic_tradition
      t.string :spellcasting_type
      t.integer :attack_proficiency
      t.integer :attack_bonus
      t.integer :attack_penalty
      t.integer :cd_proficiency
      t.integer :cd_bonus
      t.integer :cd_penalty
      t.integer :max_focus_points
      t.integer :current_focus_points
      t.integer :level_0
      t.integer :level_1
      t.integer :level_2
      t.integer :level_3
      t.integer :level_4
      t.integer :level_5
      t.integer :level_6
      t.integer :level_7
      t.integer :level_8
      t.integer :level_9
      t.integer :level_10
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
