class DropUsersTeamIdJoinTable < ActiveRecord::Migration[5.1]
  def change
    drop_join_table :teams, :users
  end
end
