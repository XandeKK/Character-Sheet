class AddSlugToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :slug, :string
    add_index :characters, :slug, unique: true
  end
end
