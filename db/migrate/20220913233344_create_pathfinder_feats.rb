class CreatePathfinderFeats < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_feats do |t|
      t.string :name
      t.string :types
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
