class CreateDices < ActiveRecord::Migration[7.0]
  def change
    create_table :dices do |t|
      t.string :name
      t.string :notation
      t.text :notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
