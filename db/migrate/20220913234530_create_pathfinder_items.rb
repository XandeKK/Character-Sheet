class CreatePathfinderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_items do |t|
      t.string :name
      t.integer :quatity
      t.integer :volume
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
