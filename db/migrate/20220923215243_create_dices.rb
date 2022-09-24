class CreateDices < ActiveRecord::Migration[7.0]
  def change
    create_table :dices do |t|
      t.string :notation
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
