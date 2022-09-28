class CreatePathfinderSavingThrows < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_saving_throws do |t|
      t.integer :fortitude_total
      t.integer :reflex_total
      t.integer :will_total
      t.integer :fortitude_proficiency
      t.integer :reflex_proficiency
      t.integer :will_proficiency
      t.integer :fortitude_item
      t.integer :reflex_item
      t.integer :will_item
      t.integer :fortitude_misc
      t.integer :reflex_misc
      t.integer :will_misc
      t.integer :fortitude_penalty
      t.integer :reflex_penalty
      t.integer :will_penalty
      t.text :saving_throw_notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
