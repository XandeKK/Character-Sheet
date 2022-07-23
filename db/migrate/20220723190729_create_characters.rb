class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.json :statistic, null: false, default: {}
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
