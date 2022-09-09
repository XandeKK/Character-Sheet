class CreatePathfinderInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_inventories do |t|
      t.string :name
      t.integer :amount
      t.integer :bulk
      t.string :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
