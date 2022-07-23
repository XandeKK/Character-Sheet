class AddCharacterCategoryRefToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_reference :characters, :character_category, null: false, foreign_key: true
  end
end
