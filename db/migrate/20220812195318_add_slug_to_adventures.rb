class AddSlugToAdventures < ActiveRecord::Migration[7.0]
  def change
    add_column :adventures, :slug, :string
    add_index :adventures, :slug, unique: true
  end
end
