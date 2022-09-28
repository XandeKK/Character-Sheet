class CreatePathfinderNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_notes do |t|
      t.string :name
      t.text :note
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
