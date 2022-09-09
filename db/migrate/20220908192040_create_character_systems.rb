class CreateCharacterSystems < ActiveRecord::Migration[7.0]
  def change
    create_table :character_systems do |t|
      t.string :name

      t.timestamps
    end
  end
end
