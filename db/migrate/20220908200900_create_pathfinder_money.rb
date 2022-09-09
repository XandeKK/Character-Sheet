class CreatePathfinderMoney < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_money do |t|
      t.integer :pp
      t.integer :gp
      t.integer :sp
      t.integer :cp
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
