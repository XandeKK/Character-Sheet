class CreatePathfinderFeats < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_feats do |t|
      t.string :level
      t.string :name
      t.text :notes
      t.references :character, null: false, foreign_key: true
      t.references :pathfinder_feat_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
