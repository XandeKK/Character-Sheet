class CreatePathfinderSavingThrows < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_saving_throws do |t|
      t.integer :fortitude
      t.integer :fortitude_item
      t.integer :will
      t.integer :will_item
      t.integer :reflex
      t.integer :reflex_item
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
