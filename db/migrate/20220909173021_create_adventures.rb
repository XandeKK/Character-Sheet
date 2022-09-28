class CreateAdventures < ActiveRecord::Migration[7.0]
  def change
    create_table :adventures do |t|
      t.string :name
      t.string :server_name
      t.string :password_digest
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
