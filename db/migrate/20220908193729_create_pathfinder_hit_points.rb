class CreatePathfinderHitPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :pathfinder_hit_points do |t|
      t.integer :max_hp
      t.integer :current_hp
      t.integer :temporary_hp
      t.string :resistances_and_immunities
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
