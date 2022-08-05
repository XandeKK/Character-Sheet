class CreateAdventureParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :adventure_participations do |t|
      t.references :adventure, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
