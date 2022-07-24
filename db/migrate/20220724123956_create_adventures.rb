class CreateAdventures < ActiveRecord::Migration[7.0]
  def change
    create_table :adventures do |t|
      t.string :name, null: false
      t.string :password
      t.string :unique_name, unique: true, null: false
      t.boolean :online, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
