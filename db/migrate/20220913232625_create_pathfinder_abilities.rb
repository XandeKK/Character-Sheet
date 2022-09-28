class CreatePathfinderAbilities < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_abilities do |t|
      t.integer :str_total
      t.integer :str_free
      t.integer :str_class
      t.integer :str_ascentry
      t.integer :str_background
      t.integer :dex_total
      t.integer :dex_free
      t.integer :dex_class
      t.integer :dex_ascentry
      t.integer :dex_background
      t.integer :con_total
      t.integer :con_free
      t.integer :con_class
      t.integer :con_ascentry
      t.integer :con_background
      t.integer :int_total
      t.integer :int_free
      t.integer :int_class
      t.integer :int_ascentry
      t.integer :int_background
      t.integer :wis_total
      t.integer :wis_free
      t.integer :wis_class
      t.integer :wis_ascentry
      t.integer :wis_background
      t.integer :cha_total
      t.integer :cha_free
      t.integer :cha_class
      t.integer :cha_ascentry
      t.integer :cha_background
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
