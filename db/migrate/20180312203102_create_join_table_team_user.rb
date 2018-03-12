class CreateJoinTableTeamUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :team_id
    create_join_table :teams, :users do |t|
      t.index [:team_id, :user_id]
    end
  end
end
