class CreatePathfinderLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_languages do |t|
      t.string :name
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
