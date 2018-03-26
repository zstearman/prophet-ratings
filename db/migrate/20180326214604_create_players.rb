class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|

      t.timestamps
      t.integer :global_player_id, index: true
      t.string :first_name
      t.string :last_name
      t.references :team, foreign_key: true
      t.integer :jersey
      t.string :position
      t.string :year
      t.integer :height
      t.integer :weight
      t.string :birth_city
      t.string :birth_state
      t.string :high_school
    end
  end
end
