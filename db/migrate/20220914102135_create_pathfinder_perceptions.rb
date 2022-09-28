class CreatePathfinderPerceptions < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_perceptions do |t|
      t.integer :item
      t.integer :proficiency
      t.string :senses
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
