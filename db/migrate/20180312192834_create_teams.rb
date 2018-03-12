class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :key
      t.boolean :active
      t.string :school
      t.string :name
      t.integer :ap_rank
      t.string :team_logo_url

      t.timestamps
    end
    add_reference :users, :team, index: false
    add_index :teams, [:school]
  end
end
