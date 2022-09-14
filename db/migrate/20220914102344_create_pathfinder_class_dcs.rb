class CreatePathfinderClassDcs < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_class_dcs do |t|
      t.integer :item
      t.integer :proficiency
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
