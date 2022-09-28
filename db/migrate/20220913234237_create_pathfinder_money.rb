class CreatePathfinderMoney < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_money do |t|
      t.integer :platinum
      t.integer :gold
      t.integer :silver
      t.integer :copper
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
