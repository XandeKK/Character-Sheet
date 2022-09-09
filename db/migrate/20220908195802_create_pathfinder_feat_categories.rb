class CreatePathfinderFeatCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_feat_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
